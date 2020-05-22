import boto3
from terraform_external_data import terraform_external_data

client = boto3.client('logs')


def create_new_response(next_token):
    response = client.describe_log_groups(
        logGroupNamePrefix='/aws/lambda',
        nextToken=next_token,
        limit=50
    )
    return response


@terraform_external_data
def get_log_group_names(query):
    response = client.describe_log_groups(
        logGroupNamePrefix='/aws/lambda',
        limit=50
    )
    rules = [
        # Add here the prefix of the lambdas you want to filter
    ]
    filter_flag = False

    flag = True
    log_group_names_map = ""

    while flag == True:
        log_group_list = response.get('logGroups')
        cont = 0
        for group in log_group_list:
            log_group_name = group.get('logGroupName')
            first_split = log_group_name.split('-')
            second_split = first_split[0].split('/aws/lambda/')
            
            # Only filter when the filter_flag is True, and will consume de rules
            if filter_flag and second_split[1] in rules:
                group_name = group.get('logGroupName')
                log_group_names_map += f"{group_name}"
                if cont < len(log_group_list):
                    log_group_names_map += ","
                    cont += 1
            else:
                group_name = group.get('logGroupName')
                log_group_names_map += f"{group_name}"
                if cont < len(log_group_list):
                    log_group_names_map += ","
                    cont += 1

        nextToken = response.get('nextToken')

        if nextToken is None:
            flag = False
            response = client.describe_log_groups(
                logGroupNamePrefix='/aws/lambda',
                limit=50
            )
            comma = log_group_names_map[:-1]
            log_group_names_map = comma

        else:
            response = create_new_response(nextToken)

    return {query['group_names_list']: log_group_names_map}


if __name__ == "__main__":
    get_log_group_names()

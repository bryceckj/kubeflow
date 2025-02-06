# Example with KIAM

- KIAM needs two extra roles which are created outside of EKS_HELM modules.
- These Roles can not be included inside the helm moudle because of the circular dependency
- These roles are creaetd as part of the main terraform using the `kiam_iam_role.tf` file
- For KIAM server to work, the node where KIAM server runs need to have some special IAM policy attached to its instance profile role.
- This is done using the `iam_role_id = local.kiam_server_node_role_id` for the management workder node group in the `local.tf` file
- THe server pod need to have tolleartions to tollerate the Mangement Node's taint. This make sure the KIAM sever only runs on the management node
- The KIAM agents pods are would run in all the worker nodes but the management worker node.

### Happly KIAMing!!

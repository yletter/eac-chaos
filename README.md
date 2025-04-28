
### Remove a Node from Cluster and ASG. Keep it in isolated state.
```
kubectl cordon ip-10-1-4-196.ec2.internal
kubectl drain ip-10-1-4-196.ec2.internal --ignore-daemonsets
kubectl drain ip-10-1-4-196.ec2.internal --ignore-daemonsets --delete-emptydir-data
aws autoscaling detach-instances \
  --instance-ids i-0ca0f1808d72cbbca \
  --auto-scaling-group-name eks-amc-cluster-wg-20250428021024210500000014-06cb3d14-75d1-825d-2928-f5ef2a1473b2 \
  --should-decrement-desired-capacity
kubectl delete node ip-10-1-4-196.ec2.internal
```

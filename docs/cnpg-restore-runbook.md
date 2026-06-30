# Restoring Backups with the CNPG Operator

This runbook describes the recovery flow for restoring a CNPG PostgreSQL cluster from backups using the Barman Cloud plugin.

## Recovery Process

1. Modify `database.yaml` and `scheduled-backup.yaml`.
   - Remove the `initdb` bootstrap and replace it with `recovery`.
   - Add `externalClusters` for the source of the recovery.
   - Change the database name, for example by adding `v1`.
   - Rename the scheduled backup similarly.

2. Reconcile the GitOps source.
   - The Barman recovery job will run.

3. CNPG starts a new cluster.
   - This creates a new folder with the new server name.

4. Update the application ConfigMap to point at the new database name.

5. Restart the application deployment.

```bash
kubectl rollout restart deployment <deployment-name>
```

## Notes

- The restore creates a recovered cluster rather than modifying the failed cluster in place.
- The application must be pointed at the recovered database cluster before it can use the restored data.
- The scheduled backup name should follow the restored cluster name so future backups target the active database.

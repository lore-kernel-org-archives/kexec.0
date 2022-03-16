From: Hari Bathini <hbathini@linux.ibm.com>
Date: Wed, 16 Mar 2022 16:03:05 +0530
Subject: [PATCH] kexec-tools: print error if kexec_file_load fails
Message-ID: <20220316103305.174842-1-hbathini@linux.ibm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Commit 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error
handling") introduced EFALLBACK for scenarios where fallbacking back
to kexec_load syscall is likely to work and dropped printing error
message for these scenarios. But printing error message for other
failure scenarios was inadvertently dropped. Restore printing error
message for such cases.

Fixes: 4f77da634035 ("kexec-tools: Fix kexec_file_load(2) error handling")
Cc: Petr Tesarik <ptesarik@suse.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 kexec/kexec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 7e4787b..865de61 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1339,6 +1339,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 		case EMSGSIZE:
 			/* Reject by default. */
 		default:
+			fprintf(stderr, "kexec_file_load failed: %s\n", strerror(errno));
 			ret = EFAILED;
 			break;
 
-- 
2.35.1



From: Ross Philipson <ross.philipson@oracle.com>
Date: Wed, 16 Feb 2022 22:54:45 -0500
Subject: [PATCH v5 12/12] tpm: Allow locality 2 to be set when initializing
 the TPM for Secure Launch
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Message-ID: <1645070085-14255-13-git-send-email-ross.philipson@oracle.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

The Secure Launch MLE environment uses PCRs that are only accessible from
the DRTM locality 2. By default the TPM drivers always initialize the
locality to 0. When a Secure Launch is in progress, initialize the
locality to 2.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 drivers/char/tpm/tpm-chip.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index b009e74..7b8d4bb 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -23,6 +23,7 @@
 #include <linux/major.h>
 #include <linux/tpm_eventlog.h>
 #include <linux/hw_random.h>
+#include <linux/slaunch.h>
 #include "tpm.h"
 
 DEFINE_IDR(dev_nums_idr);
@@ -34,12 +35,18 @@
 
 static int tpm_request_locality(struct tpm_chip *chip)
 {
+	int locality;
 	int rc;
 
 	if (!chip->ops->request_locality)
 		return 0;
 
-	rc = chip->ops->request_locality(chip, 0);
+	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
+		locality = 2;
+	else
+		locality = 0;
+
+	rc = chip->ops->request_locality(chip, locality);
 	if (rc < 0)
 		return rc;
 
-- 
1.8.3.1



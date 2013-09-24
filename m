Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [14.96.33.174] (helo=oc4412665023.ibm.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOhDg-0003di-Gk
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 05:01:01 +0000
From: Athira Rajeev <atrajeev@in.ibm.com>
Subject: [PATCH] kexec/ppc: Add nodes for initrd in dtb
Date: Tue, 24 Sep 2013 10:52:54 +0530
Message-ID: <20130924052240.4517.85639.stgit@localhost.localdomain>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: suzuki@in.ibm.com, kexec@lists.infradead.org

From: Suzuki K. Poulose <suzuki@in.ibm.com>

If the primary kernel doesn't use an initrd,
we may not have linux,initrd-* entries in the
device-tree, and hence the initial flat tree
may not contain them.

Make sure we add the entries in the dtb if the
second kernel needs an initrd.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
Signed-off-by: Athira Rajeev<atrajeev@in.ibm.com>
---

 kexec/arch/ppc/fs2dt.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
index a49f85e..4121c7d 100644
--- a/kexec/arch/ppc/fs2dt.c
+++ b/kexec/arch/ppc/fs2dt.c
@@ -342,8 +342,17 @@ static void putnode(void)
 
 	putprops(dn, namelist, numlist);
 
-	/* Add initrd entries to the second kernel */
-	if (initrd_base && !strcmp(basename, "chosen/")) {
+	/* 
+	 * Add initrd entries to the second kernel
+	 * if
+	 * 	a) a ramdisk is specified in cmdline
+	 * 	 OR
+	 * 	b) reuseinitrd is specified and a initrd is
+	 * 	   used by the kernel.
+	 *
+	 */
+	if ((ramdisk || (initrd_base && reuse_initrd))
+		&& !strcmp(basename, "chosen/")) {
 		int len = 8;
 		unsigned long long initrd_end;
 		*dt++ = 3;
@@ -362,8 +371,9 @@ static void putnode(void)
 
 		memcpy(dt, &initrd_end, len);
 		dt += (len + 3)/4;
-
-		reserve(initrd_base, initrd_size);
+		/* reserve the existing initrd image in case of reuse_initrd */
+		if (initrd_base && initrd_size && reuse_initrd)
+			reserve(initrd_base, initrd_size);
 	}
 
 	for (i = 0; i < numlist; i++) {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

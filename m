Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp08.in.ibm.com ([59.145.155.8])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LUkQV-0001mn-CX
	for kexec@lists.infradead.org; Wed, 04 Feb 2009 16:16:38 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp08.in.ibm.com (8.13.1/8.13.1) with ESMTP id n14Fucvt005131
	for <kexec@lists.infradead.org>; Wed, 4 Feb 2009 21:26:38 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n14GGZQR2838696
	for <kexec@lists.infradead.org>; Wed, 4 Feb 2009 21:46:35 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id n14GGUQJ012276
	for <kexec@lists.infradead.org>; Wed, 4 Feb 2009 21:46:30 +0530
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH] powerpc: initialize drconf variables
Date: Wed, 4 Feb 2009 21:46:28 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200902042146.28854.chandru@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au

The initialization of lmb_size and num_of_lmbs got removed as part of the
'kexec memory ranges dynamic allocation' patch to kexec-tools (which added
realloc_memory_ranges() code to kexec-tools). These variables are pertinent
to ppc64 systems with ibm,dynamic-reconfiguration-memory node in device-tree,
i.e systems with /proc/device-tree/ibm,dynamic-reconfiguration-memory. The
following patch adds code to initialize the variables back again in kexec-tools.
Without this patch kexec-tools will think that it needs to save only the memory
represented in memory@ nodes of device-tree and will skip the memory represented
in  /proc/device-tree/ibm,dynamic-reconfiguration-memory node of device-tree.


Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
---

 kexec/arch/ppc64/kexec-ppc64.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- kexec-tools/kexec/arch/ppc64/kexec-ppc64.c.orig	2009-02-04 05:38:44.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2009-02-04 05:36:36.000000000 -0500
@@ -150,6 +150,23 @@ static int get_dyn_reconf_base_ranges(vo
 	FILE *file;
 	int i, n;
 
+	strcpy(fname, "/proc/device-tree/");
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+	if (fread(buf, 1, 8, file) < 0) {
+		perror(fname);
+		fclose(file);
+		return -1;
+	}
+	/*
+	 * lmb_size, num_of_lmbs(global variables) are
+	 * initialized once here.
+	 */
+	lmb_size = ((uint64_t *)buf)[0];
+	fclose(file);
 
 	strcpy(fname, "/proc/device-tree/");
 	strcat(fname,
@@ -158,8 +175,14 @@ static int get_dyn_reconf_base_ranges(vo
 		perror(fname);
 		return -1;
 	}
+	/* first 4 bytes tell the number of lmbs */
+	if (fread(buf, 1, 4, file) < 0) {
+		perror(fname);
+		fclose(file);
+		return -1;
+	}
+	num_of_lmbs = ((unsigned int *)buf)[0];
 
-	fseek(file, 4, SEEK_SET);
 	for (i = 0; i < num_of_lmbs; i++) {
 		if ((n = fread(buf, 1, 24, file)) < 0) {
 			perror(fname);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

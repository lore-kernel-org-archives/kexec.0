Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1LVKL4-0002XB-Vr
	for kexec@lists.infradead.org; Fri, 06 Feb 2009 06:37:23 +0000
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp07.au.ibm.com (8.13.1/8.13.1) with ESMTP id n166bJua008336
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:37:19 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n166bb2t352734
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:37:37 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n166bJBx024853
	for <kexec@lists.infradead.org>; Fri, 6 Feb 2009 17:37:19 +1100
From: Chandru <chandru@in.ibm.com>
Subject: Re: [PATCH] powerpc: initialize drconf variables
Date: Fri, 6 Feb 2009 12:07:17 +0530
References: <200902042146.28854.chandru@in.ibm.com>
	<200902041748.56793.bwalle@suse.de>
In-Reply-To: <200902041748.56793.bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200902061207.17451.chandru@in.ibm.com>
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
To: horms@verge.net.au
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

The initialization of lmb_size and num_of_lmbs got removed as part of the
'kexec memory ranges dynamic allocation' patch to kexec-tools (which added
realloc_memory_ranges() code to kexec-tools). These variables are pertinent
to ppc64 systems with ibm,dynamic-reconfiguration-memory node in device-tree,
i.e systems with /proc/device-tree/ibm,dynamic-reconfiguration-memory. The
following patch adds code to initialize the variables back again in kexec-tools.
Without this patch kexec-tools will think that it needs to save only the memory
represented in memory@ nodes and will skip the memory in
/proc/device-tree/ibm,dynamic-reconfiguration-memory node of the device-tree.


Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
Reviewed-by: Bernhard Walle <bwalle@suse.de>
---

 kexec/arch/ppc64/kexec-ppc64.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- kexec-tools/kexec/arch/ppc64/kexec-ppc64.c.orig	2009-02-04 05:38:44.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/kexec-ppc64.c	2009-02-04 20:16:30.000000000 -0500
@@ -150,6 +150,23 @@ static int get_dyn_reconf_base_ranges(vo
 	FILE *file;
 	int i, n;
 
+	strcpy(fname, "/proc/device-tree/");
+	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,lmb-size");
+	if ((file = fopen(fname, "r")) == NULL) {
+		perror(fname);
+		return -1;
+	}
+	if (fread(buf, 1, 8, file) != 8) {
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
+	if (fread(buf, 1, 4, file) != 4) {
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

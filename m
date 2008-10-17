Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([59.145.155.6] helo=e28esmtp06.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KqtYJ-0003qa-G0
	for kexec@lists.infradead.org; Fri, 17 Oct 2008 17:55:56 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m9HHtpOW007760
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 23:25:51 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9HHtp4f1052814
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 23:25:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.13.1/8.13.3) with ESMTP id m9HHtpTZ002610
	for <kexec@lists.infradead.org>; Fri, 17 Oct 2008 23:25:51 +0530
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH] kdump : check flags field from drconf memory
Date: Fri, 17 Oct 2008 23:25:54 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200810172325.54932.chandru@in.ibm.com>
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

On a powerpc machine when memory is dynamically removed/added from an lpar, the 
corresponding flags field in the drconf memory reflects the same with the bits 
unset/set accordingly. The kernel does a check on these flags while booting. 
Following are the similar changes brought in to kexec-tools.  This makes 
kexec-tools to skip those memory regions that do not belong or are not 
assigned to the current partition ( but are available to dynamically add them 
back ). Without this patch (and with memory remove operation) copying vmcore 
fails with error as

Copying data                       : [ 84 %] readmem: Can't read the dump 
memory(/proc/vmcore). Bad address
read_pfn: Can't get the page data.


Signed-off-by : Chandru S <chandru@in.ibm.com>
---

diff -Naurp kexec-tools-orig//kexec/arch/ppc64/crashdump-ppc64.c 
kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c
--- kexec-tools-orig//kexec/arch/ppc64/crashdump-ppc64.c	2008-10-14 
01:36:05.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.c	2008-10-17 
12:17:53.000000000 -0500
@@ -127,6 +127,7 @@ static int get_dyn_reconf_crash_memory_r
 	char fname[128], buf[32];
 	FILE *file;
 	int i, n;
+	uint32_t flags;
 
 	strcpy(fname, "/proc/device-tree/");
 	strcat(fname, "ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory");
@@ -150,10 +151,17 @@ static int get_dyn_reconf_crash_memory_r
 			return -1;
 		}
 
-		start = ((uint64_t *)buf)[0];
+		start = ((uint64_t *)buf)[DRCONF_ADDR];
 		end = start + lmb_size;
 		if (start == 0 && end >= (BACKUP_SRC_END + 1))
 			start = BACKUP_SRC_END + 1;
+
+		flags = (*((uint32_t *)&buf[DRCONF_FLAGS]));
+		/* skip this block if the reserved bit is set in flags (0x80)
+		   or if the block is not assigned to this partition (0x8) */
+		if ((flags & 0x80) || !(flags & 0x8))
+			continue;	
+
 		exclude_crash_region(start, end);
 	}
 	fclose(file);
diff -Naurp kexec-tools-orig//kexec/arch/ppc64/crashdump-ppc64.h 
kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h
--- kexec-tools-orig//kexec/arch/ppc64/crashdump-ppc64.h	2008-10-14 
01:36:05.000000000 -0500
+++ kexec-tools/kexec/arch/ppc64/crashdump-ppc64.h	2008-10-17 
12:18:02.000000000 -0500
@@ -31,4 +31,7 @@ extern unsigned int rtas_size;
 uint64_t lmb_size;
 unsigned int num_of_lmbs;
 
+#define DRCONF_ADDR	0
+#define DRCONF_FLAGS	20
+
 #endif /* CRASHDUMP_PPC64_H */



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

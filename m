Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WSTzy-0000ug-J6
 for kexec@lists.infradead.org; Tue, 25 Mar 2014 16:14:47 +0000
Received: from /spool/local
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 25 Mar 2014 16:14:24 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E38B17D8059
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:15:08 +0000 (GMT)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2PGEAvc60096722
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 16:14:10 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2PGELRp029779
 for <kexec@lists.infradead.org>; Tue, 25 Mar 2014 10:14:22 -0600
Date: Tue, 25 Mar 2014 17:14:20 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [PATCH 2/2] makedumpfile: Use max_pfn from mem_map array
Message-ID: <20140325171420.6b558576@holzheu>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

There are dump mechansims like s390 stand-alond dump or KVM virsh dump
that write the physical memory of a machine and are not aware of the
dumped operating system. For those dump mechanisms it can happen
that for the Linux kernel of the dumped system the "mem=" kernel
parameter has been specified. In this case max_mapnr that makedumpfile
gets from the ELF header can be bigger than the maximum page frame number
used by the dumped Linux kernel.

With this patch makedumpfile gets the maximum page frame number from
the mem_map array and adjusts info->max_mapnr if this value is smaller
than the value calculated from the ELF header.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2829,7 +2829,8 @@ get_mem_map_without_mm(void)
 int
 get_mem_map(void)
 {
-	int ret;
+	unsigned long max_pfn = 0;
+	int ret, i;
 
 	switch (get_mem_type()) {
 	case SPARSEMEM:
@@ -2861,6 +2862,17 @@ get_mem_map(void)
 		ret = FALSE;
 		break;
 	}
+	/*
+	 * Adjust "max_mapnr" for the case that Linux uses less memory
+	 * than is dumped. For example when "mem=" has been used for the
+	 * dumped system.
+	 */
+	for (i = 0; i < info->num_mem_map; i++) {
+		if (info->mem_map_data[i].mem_map == NOT_MEMMAP_ADDR)
+			continue;
+		max_pfn = MAX(max_pfn, info->mem_map_data[i].pfn_end);
+	}
+	info->max_mapnr = MIN(info->max_mapnr, max_pfn);
 	return ret;
 }
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

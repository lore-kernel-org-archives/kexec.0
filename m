Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XAh6Y-0007CU-V8
 for kexec@lists.infradead.org; Fri, 25 Jul 2014 15:08:21 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 25 Jul 2014 16:07:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 999E617D8059
 for <kexec@lists.infradead.org>; Fri, 25 Jul 2014 16:09:31 +0100 (BST)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6PF7oYV16908296
 for <kexec@lists.infradead.org>; Fri, 25 Jul 2014 15:07:50 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6PF7oEl012610
 for <kexec@lists.infradead.org>; Fri, 25 Jul 2014 09:07:50 -0600
Subject: [PATCH] ppc64/kdump: Fix ELF header endianess
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 25 Jul 2014 17:07:49 +0200
Message-ID: <20140725150749.17944.26746.stgit@nimbus>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

The ELF header created among the loading of the kdump kernel should be
flagged using the current endianess and not always as big endian.

Without this patch the data exposed in /proc/vmcore are not readable when
running in LE mode.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 00a0e632f48e..6214b831fdf2 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -38,7 +38,11 @@
 static struct crash_elf_info elf_info64 =
 {
 	class: ELFCLASS64,
+#if BYTE_ORDER == LITTLE_ENDIAN
+	data: ELFDATA2LSB,
+#else
 	data: ELFDATA2MSB,
+#endif
 	machine: EM_PPC64,
 	page_offset: PAGE_OFFSET,
 	lowmem_limit: MAXMEM,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

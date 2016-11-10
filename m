Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c4nzq-0002UP-7S
 for kexec@lists.infradead.org; Thu, 10 Nov 2016 11:58:23 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAABsF3q090569
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2016 06:58:03 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26mpc0h6wr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2016 06:58:03 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 10 Nov 2016 17:27:59 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4E9B5E0045
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2016 17:28:03 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAABvvDi24772772
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2016 17:27:57 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAABvstg019737
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2016 17:27:56 +0530
Subject: [PATCH 2/3] powerpc/fadump: reuse crashkernel parameter for fadump
 memory reservation
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 10 Nov 2016 17:27:50 +0530
In-Reply-To: <147877899077.31483.3740501843050856595.stgit@hbathini.in.ibm.com>
References: <147877899077.31483.3740501843050856595.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Message-Id: <147877906392.31483.217986075920494267.stgit@hbathini.in.ibm.com>
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
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, Michael Ellerman <mpe@ellerman.id.au>, dyoung@redhat.com, vgoyal@redhat.com

fadump supports specifying memory to reserve for fadump's crash kernel
with fadump_reserve_mem kernel parameter. This parameter currently
supports passing a fixed memory size, like fadump_reserve_mem=<size>
only. This patch aims to add support for other syntaxes like range-based
memory size <range1>:<size1>[,<range2>:<size2>,<range3>:<size3>,...]
which allows using the same parameter to boot the kernel with different
system RAM sizes.

As crashkernel parameter already supports the above mentioned syntaxes,
this patch removes fadump_reserve_mem parameter and reuses crashkernel
parameter instead, to specify memory for fadump's crash kernel memory
reservation as well. If any offset is provided in crashkernel parameter,
it will be ignored in case of fadump, as fadump reserves memory at end
of RAM.

Advantages using crashkernel parameter instead of fadump_reserve_mem
parameter are one less kernel parameter overall, code reuse and support
for multiple syntaxes to specify memory.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index db0b339..de7d39a 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -210,14 +210,20 @@ static unsigned long init_fadump_mem_struct(struct fadump_mem_struct *fdm,
  */
 static inline unsigned long fadump_calculate_reserve_size(void)
 {
-	unsigned long size;
+	int ret;
+	unsigned long long base, size;
 
 	/*
-	 * Check if the size is specified through fadump_reserve_mem= cmdline
-	 * option. If yes, then use that.
+	 * Check if the size is specified through crashkernel= cmdline
+	 * option. If yes, then use that but ignore base as fadump
+	 * reserves memory at end of RAM.
 	 */
-	if (fw_dump.reserve_bootvar)
+	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
+				&size, &base);
+	if (ret == 0 && size > 0) {
+		fw_dump.reserve_bootvar = (unsigned long)size;
 		return fw_dump.reserve_bootvar;
+	}
 
 	/* divide by 20 to get 5% of value */
 	size = memblock_end_of_DRAM() / 20;
@@ -353,15 +359,6 @@ static int __init early_fadump_param(char *p)
 }
 early_param("fadump", early_fadump_param);
 
-/* Look for fadump_reserve_mem= cmdline option */
-static int __init early_fadump_reserve_mem(char *p)
-{
-	if (p)
-		fw_dump.reserve_bootvar = memparse(p, &p);
-	return 0;
-}
-early_param("fadump_reserve_mem", early_fadump_reserve_mem);
-
 static void register_fw_dump(struct fadump_mem_struct *fdm)
 {
 	int rc;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

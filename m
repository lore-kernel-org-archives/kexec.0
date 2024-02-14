Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB2BFC48BC3
	for <kexec@archiver.kernel.org>; Wed, 14 Feb 2024 22:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WBbgFy/ntFn9FiwJW3l23LHUJbBaWKbGH/vkWxxHiQI=; b=BVO3Hc7Wrvsmus
	7UlnBERFKUrqZnv04YvB1JQUFqyGTlefklF4MaASRUkqq3wiXz+q6IqwNh4fpdyRxaA2+QB+lH7K0
	e0fhEbmyjF5bgMbPdpreGJ/pjWdTkCe9kq5yc5AtrUyLMR9KAMc704AIBLENvG5lquSQ8h0guzAZH
	dLrTtqrpkl8eRT0SRTbnTo1ZqQqgERiyvnI/zPPUYL3VQHUVV3ipdue2ItmUwOzzXrF47tsm5UcVD
	tJFAjNkfJlHkmxmPHwYsHJVVrS1E12FGfSXZE/lRw9uhQn03zqQQiKCJw2iQ7FDDKjX7op41176C6
	CK77p3uw9lTReIgE3cCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNrj-0000000ERjg-2Maa;
	Wed, 14 Feb 2024 22:36:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNri-0000000ERjB-1A4Z
	for kexec@bombadil.infradead.org;
	Wed, 14 Feb 2024 22:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=V4prafnbK9N6Yd37++Nhfulk+Ru0PJbtWvEZwMJYEyk=; b=Cxo2plUX+5VwvLjAJa6tCdVTmZ
	JngfIzrCQLKvKySZqmVJ21AtNQgdGKqaey/Z3rMJS96E5dG/FqQCgHr5mNXblCfj7o3MEqQxJQlPe
	z73A5T1aroMEqW1p8raQDrgaRzSXhPJVWePGpKT+iZICB3A7Mizpt2UrmifTczyfgi2GCDQy0k6VK
	fgQB4WUgPB09u08dk5bJygXeEgu8O7+qAuQRqli68vtgP+/VXPKz6kC8TyzskZ+zPJUQkvPQlkzjg
	HiUsFdYPf613L94Rii1OJzvxy07/k2366tpna3TsNTuuzuDZR8lF0BGojldNm+gO3xHjIaB+CUSle
	Yej8FNTw==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNrd-00000000BNn-0kIk
	for kexec@lists.infradead.org;
	Wed, 14 Feb 2024 22:36:29 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41ELibbR015442;
	Wed, 14 Feb 2024 22:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=V4prafnbK9N6Yd37++Nhfulk+Ru0PJbtWvEZwMJYEyk=;
 b=LlLPnGrF1/raVowv1XHaaT/uzo9/VBQi9laPjx2TwJTHW43fxv1EigPLLX0haj9mw8yY
 o2nFenThXWGE/G7/PVSFvMk0us1puVWz3PfV4SMCc47j5VSNbf+vysD4uajMjl9eidE2
 bIRGmVIyfjnmplz+tOtSbUdysWo8sT3JZu5opN5vNVR+h6hy9rzQmKkIPIteZrnf40AR
 sxHk+xyyvJAfrapIfLjplOcZzVDgY+ejKQgf40LPRtrGYnt6hvUZRk88MDcUw3xsoAQP
 k9wD/GzVEE2V8cPnNqLG/7flxBqM/CtsX+tqyGgWdJQ3BCt2hm1UG66Cb2Vhvg9qHW1S XA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s70gv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 22:31:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMAG4f000681;
	Wed, 14 Feb 2024 22:31:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n7b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EMVTVC004281;
	Wed, 14 Feb 2024 22:31:39 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk9n72r-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 14 Feb 2024 22:31:39 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v8 09/15] x86: Secure Launch SMP bringup support
Date: Wed, 14 Feb 2024 14:18:41 -0800
Message-Id: <20240214221847.2066632-10-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240214221847.2066632-1-ross.philipson@oracle.com>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_14,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140170
X-Proofpoint-GUID: jiuIEDJncH4Vf-BfrUmzdgYrt3-A0iUB
X-Proofpoint-ORIG-GUID: jiuIEDJncH4Vf-BfrUmzdgYrt3-A0iUB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_223626_938859_03E97167 
X-CRM114-Status: GOOD (  31.02  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Intel, the APs are left in a well documented state after TXT performs
the late launch. Specifically they cannot have #INIT asserted on them so
a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
early SL stub code uses MONITOR and MWAIT to park the APs. The realmode/init.c
code updates the jump address for the waiting APs with the location of the
Secure Launch entry point in the RM piggy after it is loaded and fixed up.
As the APs are woken up by writing the monitor, the APs jump to the Secure
Launch entry point in the RM piggy which mimics what the real mode code would
do then jumps to the standard RM piggy protected mode entry point.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/include/asm/realmode.h      |  3 ++
 arch/x86/kernel/smpboot.c            | 58 +++++++++++++++++++++++++++-
 arch/x86/realmode/init.c             |  3 ++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++
 5 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 87e5482acd0d..339b48e2543d 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -38,6 +38,9 @@ struct real_mode_header {
 #ifdef CONFIG_X86_64
 	u32	machine_real_restart_seg;
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	u32	sl_trampoline_start32;
+#endif
 };
 
 /* This must match data at realmode/rm/trampoline_{32,64}.S */
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce68a3f1..74511be5b779 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -60,6 +60,7 @@
 #include <linux/stackprotector.h>
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -987,6 +988,56 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
+
+static bool slaunch_is_txt_launch(void)
+{
+	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
+	    (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
+		return true;
+
+	return false;
+}
+
+/*
+ * TXT AP startup is quite different than normal. The APs cannot have #INIT
+ * asserted on them or receive SIPIs. The early Secure Launch code has parked
+ * the APs using monitor/mwait. This will wake the APs by writing the monitor
+ * and have them jump to the protected mode code in the rmpiggy where the rest
+ * of the SMP boot of the AP will proceed normally.
+ */
+static void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+	struct sl_ap_wake_info *ap_wake_info;
+	struct sl_ap_stack_and_monitor *stack_monitor = NULL;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
+							       ap_wake_info->ap_stacks_offset);
+
+	for (unsigned int i = TXT_MAX_CPUS - 1; i >= 0; i--) {
+		if (stack_monitor[i].apicid == apicid) {
+			/* Write the monitor */
+			stack_monitor[i].monitor = 1;
+			break;
+		}
+	}
+}
+
+#else
+
+static inline bool slaunch_is_txt_launch(void)
+{
+	return false;
+}
+
+static inline void slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
+{
+}
+
+#endif  /* !CONFIG_SECURE_LAUNCH */
+
 /*
  * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
  * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
@@ -996,7 +1047,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
-	int ret;
+	int ret = 0;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -1041,12 +1092,15 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 
 	/*
 	 * Wake up a CPU in difference cases:
+	 * - Intel TXT DRTM launch uses its own method to wake the APs
 	 * - Use a method from the APIC driver if one defined, with wakeup
 	 *   straight to 64-bit mode preferred over wakeup to RM.
 	 * Otherwise,
 	 * - Use an INIT boot APIC message
 	 */
-	if (apic->wakeup_secondary_cpu_64)
+	if (slaunch_is_txt_launch())
+		slaunch_wakeup_cpu_from_txt(cpu, apicid);
+	else if (apic->wakeup_secondary_cpu_64)
 		ret = apic->wakeup_secondary_cpu_64(apicid, start_ip);
 	else if (apic->wakeup_secondary_cpu)
 		ret = apic->wakeup_secondary_cpu(apicid, start_ip);
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index f9bc444a3064..d95776cb30d3 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -4,6 +4,7 @@
 #include <linux/memblock.h>
 #include <linux/cc_platform.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 
 #include <asm/set_memory.h>
 #include <asm/realmode.h>
@@ -210,6 +211,8 @@ void __init init_real_mode(void)
 
 	setup_real_mode();
 	set_real_mode_permissions();
+
+	slaunch_fixup_jump_vector();
 }
 
 static int __init do_init_real_mode(void)
diff --git a/arch/x86/realmode/rm/header.S b/arch/x86/realmode/rm/header.S
index 2eb62be6d256..3b5cbcbbfc90 100644
--- a/arch/x86/realmode/rm/header.S
+++ b/arch/x86/realmode/rm/header.S
@@ -37,6 +37,9 @@ SYM_DATA_START(real_mode_header)
 #ifdef CONFIG_X86_64
 	.long	__KERNEL32_CS
 #endif
+#ifdef CONFIG_SECURE_LAUNCH
+	.long	pa_sl_trampoline_start32
+#endif
 SYM_DATA_END(real_mode_header)
 
 	/* End signature, used to verify integrity */
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index c9f76fae902e..526d449d5383 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -120,6 +120,38 @@ SYM_CODE_END(sev_es_trampoline_start)
 
 	.section ".text32","ax"
 	.code32
+#ifdef CONFIG_SECURE_LAUNCH
+	.balign 4
+SYM_CODE_START(sl_trampoline_start32)
+	/*
+	 * The early secure launch stub AP wakeup code has taken care of all
+	 * the vagaries of launching out of TXT. This bit just mimics what the
+	 * 16b entry code does and jumps off to the real startup_32.
+	 */
+	cli
+	wbinvd
+
+	/*
+	 * The %ebx provided is not terribly useful since it is the physical
+	 * address of tb_trampoline_start and not the base of the image.
+	 * Use pa_real_mode_base, which is fixed up, to get a run time
+	 * base register to use for offsets to location that do not have
+	 * pa_ symbols.
+	 */
+	movl    $pa_real_mode_base, %ebx
+
+	LOCK_AND_LOAD_REALMODE_ESP lock_pa=1
+
+	lgdt    tr_gdt(%ebx)
+	lidt    tr_idt(%ebx)
+
+	movw	$__KERNEL_DS, %dx	# Data segment descriptor
+
+	/* Jump to where the 16b code would have jumped */
+	ljmpl	$__KERNEL32_CS, $pa_startup_32
+SYM_CODE_END(sl_trampoline_start32)
+#endif
+
 	.balign 4
 SYM_CODE_START(startup_32)
 	movl	%edx, %ss
-- 
2.39.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

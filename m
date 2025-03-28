Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00BFC28B20
	for <kexec@archiver.kernel.org>; Fri, 28 Mar 2025 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b1JD/nRwgiwHQ352tFdoR/jXCyZ0VHh2LXCjUdgtN2Q=; b=H2AFdUCH7r8l2jZCDXkxdlQEyj
	mZpah5FuPrNnKfEA9ktnOfNYXApJCW7Chv8b9OTMeL1j01M7O1/Ei7qQSHFlCgXlP1cpTYjVJNjUf
	pbw2udCapEA16EkaG1b5biOCtUVUq3+xQpyrRUT8vsVIkxv9QXrsVCMtMkk0bpC89RagMwflcDLgx
	xO/8YoHQ/7qERUxvtkmMqohzY/TE0NPJ96hc5YKieid6kicObL6u3arnbNV9FES44cwHgPJH7WN59
	rdlKpW15gjh0Fl/MBpXsIvD+anaVpnsgWR75IpitEH/ZD3FXtfe8it4lWpcXoHOkayHRHScrEwRbB
	rJ0bg/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyItK-0000000ESo2-3hIk;
	Fri, 28 Mar 2025 23:13:34 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyItI-0000000ESl7-0dc1
	for kexec@lists.infradead.org;
	Fri, 28 Mar 2025 23:13:33 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52SKWB58006347;
	Fri, 28 Mar 2025 23:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=b1JD/
	nRwgiwHQ352tFdoR/jXCyZ0VHh2LXCjUdgtN2Q=; b=TzmIjgxblmSAGLywCFg3t
	Trr4p++hMA94ifYfDdjRdww+It/QaLGZ6wxvo/fqQ43/Zs6mOmduXZGcF6Qcq92R
	QJUvp3/6yPJrxXMV8bW1OGV76RSIAXJAkTYonUkvYD8q57hB9Zgpn3uChwosDxMq
	oxcas9m1ycOh//AcX+tJgpkTW311KkLBr3rYHQiIdIBa9rEuXBqZbywTOWJv7Lp7
	W3zmWrk1yv4rQErrSXuwmwXFNghQJR/rCxOIGDN0S/6HPDJQ068FzdmWNf6lpugh
	VfzjfsoNnMdJZDQFlsxp1KMQ9wzJYVozaL+Iy/5Nk8KxoLeFE4IPIZmLXD/dVNbZ
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnd6fntf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Mar 2025 23:13:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52SLFO2o023171;
	Fri, 28 Mar 2025 23:13:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcjnnh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:12 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52SNDBKB005068;
	Fri, 28 Mar 2025 23:13:11 GMT
Received: from bur-virt-x6-2-100.us.oracle.com (bur-virt-x6-2-100.us.oracle.com [10.153.92.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jjcjnng7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 28 Mar 2025 23:13:11 +0000
From: Ross Philipson <ross.philipson@oracle.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux.dev
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v13 11/19] x86: Secure Launch SMP bringup support
Date: Fri, 28 Mar 2025 16:08:06 -0700
Message-Id: <20250328230814.2210230-12-ross.philipson@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250328230814.2210230-1-ross.philipson@oracle.com>
References: <20250328230814.2210230-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-28_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503280156
X-Proofpoint-ORIG-GUID: gYfOFW3OM1Aeuc9ps0csoPWnnyTCakLN
X-Proofpoint-GUID: gYfOFW3OM1Aeuc9ps0csoPWnnyTCakLN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_161332_348341_92B077DC 
X-CRM114-Status: GOOD (  25.99  )
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
 arch/x86/kernel/smpboot.c            | 43 ++++++++++++++++++++++++++--
 arch/x86/realmode/init.c             |  3 ++
 arch/x86/realmode/rm/header.S        |  3 ++
 arch/x86/realmode/rm/trampoline_64.S | 32 +++++++++++++++++++++
 5 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index f607081a022a..84367bcec1a8 100644
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
index d6cf1e23c2a3..219523884fdc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -61,6 +61,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/mc146818rtc.h>
 #include <linux/acpi.h>
+#include <linux/slaunch.h>
 
 #include <asm/acpi.h>
 #include <asm/cacheinfo.h>
@@ -836,6 +837,41 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 	return 0;
 }
 
+#ifdef CONFIG_SECURE_LAUNCH
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
+	struct sl_ap_stack_and_monitor *stack_monitor;
+	struct sl_ap_wake_info *ap_wake_info;
+
+	ap_wake_info = slaunch_get_ap_wake_info();
+
+	stack_monitor = (struct sl_ap_stack_and_monitor *)__va(ap_wake_info->ap_wake_block +
+							       ap_wake_info->ap_stacks_offset);
+
+	for (unsigned int i = TXT_MAX_CPUS - 1; i >= 0; i--) {
+		if (stack_monitor[i].apicid == apicid) {
+			stack_monitor[i].monitor = 1;
+			break;
+		}
+	}
+}
+
+#else
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
@@ -845,7 +881,7 @@ int common_cpu_up(unsigned int cpu, struct task_struct *idle)
 static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 {
 	unsigned long start_ip = real_mode_header->trampoline_start;
-	int ret;
+	int ret = 0;
 
 #ifdef CONFIG_X86_64
 	/* If 64-bit wakeup method exists, use the 64-bit mode trampoline IP */
@@ -890,12 +926,15 @@ static int do_boot_cpu(u32 apicid, int cpu, struct task_struct *idle)
 
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
index 14d9c7daf90f..b0ce6205d7ea 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -122,6 +122,38 @@ SYM_CODE_END(sev_es_trampoline_start)
 
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



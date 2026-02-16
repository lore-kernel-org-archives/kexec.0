Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B6EE63F15
	for <kexec@archiver.kernel.org>; Mon, 16 Feb 2026 17:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DlfQBWh/1ejwW858oNbtS1e0RO+K3ejkv0QSbNUrw9w=; b=gYbtLGc4XlkC6MoFMsPNy8EqF0
	3HrxStTwqyVG4BE1UW7gSLlMJeyYTZXsexR34533oa6dOpfz+8VCVWdmZlioU+IikUAo5ks5SC7wF
	5sLmQb1yEXHhJhYAj+FZww55CdCxMu0DK+c4r2IqOTmUZSGSZcir8kZCWF9iiorGrA2FzWF8jopUF
	dTBcgzYXdG0UFzXpIfMeSgZgbVJLFLNy7oiaLjOtbjsRqaaf/+asGZ6fkZOYlwKXFW5n5eCE6Oeq8
	8ptFE5yIcrw86iCnHVfbsgguB42mZLO7DRd5zaAKT7J3Eecfy3/0dvfBnPIRoyZk20Mdbb7FPH66d
	U7yyR69w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs2G0-000000075RG-32PO;
	Mon, 16 Feb 2026 17:19:36 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vs2Fw-000000075QL-0Taw
	for kexec@lists.infradead.org;
	Mon, 16 Feb 2026 17:19:33 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G9bcCD2549181;
	Mon, 16 Feb 2026 17:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DlfQBWh/1ejwW858oNbtS1e0RO+K3ejkv0QSbNUrw
	9w=; b=rYRiFaSy5WobzD9BZF/g43fnh5iBrOrUJPV3qdgAucJ3ilR2n9DzNptQW
	6lzmDmsiPjLAKX/S43ptirBArALrLJN9bNzM2CFkfb5Cxy/0Waax64tqRYwTBQuD
	kt9wYPM4FyE6kK+LP6zCWIYTQRgbA9Vfr5lUKyGWYIBrsxm3OAm5mcT16OXX+HOy
	2MIV0elxRAHi3VsuNrSdOkLS5/Yb+8wyM3mg1d3eJdoGGRAg6H4Fmcu9KZT7PUC4
	PsomsJy7yMGXgGWsanGkmh9b0fgEQgQtq2BmUN/+9oNBKoTblbeUVy2ALLzMf6wZ
	7aZ4XfE19l66pc94PnE5R5Mi51N8Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cajcj84e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 17:19:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61GDiV4q029073;
	Mon, 16 Feb 2026 17:19:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb6315y14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 17:19:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GHJ0o352429218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 17:19:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE0BA20043;
	Mon, 16 Feb 2026 17:19:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9383A20040;
	Mon, 16 Feb 2026 17:18:51 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.25.185])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 17:18:51 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: maddy@linux.ibm.com, sourabhjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Cc: mpe@ellerman.id.au, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, akpm@linux-foundation.org,
        bhe@redhat.com, mahesh@linux.ibm.com, ritesh.list@gmail.com,
        vishalc@linux.ibm.com, thuth@redhat.com, hbathini@linux.ibm.com,
        eajames@linux.ibm.com, dwmw@amazon.co.uk, kai.huang@intel.com,
        pbonzini@redhat.com, ubizjak@gmail.com, coxu@redhat.com,
        fuqiang.wang@easystack.cn, brgerst@gmail.com, liaoyuanhong@vivo.com,
        jbohac@suse.cz
Subject: [RFC PATCH v1] kexec: optimize crash hotplug by filtering redundant FDT updates
Date: Mon, 16 Feb 2026 22:44:57 +0530
Message-ID: <20260216171456.527608-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: nCI5gqZepZ3KLvK25N5CfSurnFU4yjHE
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=6993518a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Q1TS8951KDF7Hiku8JMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDE0NyBTYWx0ZWRfX6Rg7r6oBnCeZ
 Yhuz0zIh4QajyIwnpEk/Dw7aiouITOnmhtHtqgVe1bt1eFkj7UznntfwwPfwHFgJjjobZaDWZlZ
 fNUhINMAMKVxnhppXwANur3mCQ8LblLVNT4w4K4H3lQ56zxNdb/LBg01JwRfp/ujgKL8pAROAuU
 kD69SH1BrGHrvZDZSx3D1s8tlsnMBJdmH+Asio7YqMn6vE20ynZcs4wgdgxkynMWTMnRvHETfYF
 2hpnFhgBHZS2kPtRPkhROw0USndL7dMnHg0+cprouXi8M9oYzmxQzYBJ6kN3QvblKCg/YHTF88r
 IoGg9JekEROzYF1fqcF/U7lu2psgCXjkwGbwcECia64/BDutp2zhCKGcnYI+y6oAILLM3aTVVom
 w25wdMTlxH3BlLNZCgG0Ln/LZmkWdxDlz6Y3f2Un+o4WF8hJ5IjIFMefTjZgeZXzNaZSDmsnHqA
 i/FFS5qPkjr8iftQaUw==
X-Proofpoint-GUID: PrsvvTrYUNbwbokUKjJ5M4S3gZk1CWkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_05,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260216_091932_279426_C39C6A05 
X-CRM114-Status: GOOD (  19.36  )
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

The arch_crash_handle_hotplug_event() interface currently lacks the CPU
index associated with hotplug events. This forces architecture handlers,
specifically on PowerPC, to unconditionally update the crash Flattened
Device Tree (FDT) for every CPU online event which should only be done
in case of DLPAR operations which add/remove new device tree node under the
/cpus. On large systems with crash kernel loaded, this behavior causes a
significant performance bottleneck. For example, during SMT switch
operations involving 1400 CPUs, the redundant execution of
update_crash_fdt() adds over half an hour of overhead

As shown in the ftrace function graph:
   83)   bash-14351   | $ 2283891 us  |     } /* update_cpus_node */

This patch passes the CPU index to the arch-specific handlers and
modifies the PowerPC implementation to check cpus_booted_once_mask. If
a CPU has been previously initialized, its FDT node is already present,
allowing the handler to skip the redundant update_crash_fdt() call.

Fixes: b741092d5976 ("powerpc/crash: add crash CPU hotplug support")
Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/powerpc/include/asm/kexec.h | 2 +-
 arch/powerpc/kexec/crash.c       | 5 +++--
 arch/x86/include/asm/kexec.h     | 2 +-
 arch/x86/kernel/crash.c          | 2 +-
 include/linux/crash_core.h       | 2 +-
 kernel/crash_core.c              | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index bd4a6c42a5f3..2d6d32942bc0 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -137,7 +137,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 }
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
+void arch_crash_handle_hotplug_event(struct kimage *image, int cpu, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index a325c1c02f96..d280883c8ab6 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -568,7 +568,7 @@ int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
  *	       part of the FDT.
  * Memory add/remove: No action is taken as this is not yet supported.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
+void arch_crash_handle_hotplug_event(struct kimage *image, int cpu, void *arg)
 {
 	struct memory_notify *mn;
 
@@ -577,7 +577,8 @@ void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
 		return;
 
 	case KEXEC_CRASH_HP_ADD_CPU:
-		update_crash_fdt(image);
+		if (!cpumask_test_cpu(cpu, &cpus_booted_once_mask))
+			update_crash_fdt(image);
 		break;
 
 	case KEXEC_CRASH_HP_REMOVE_MEMORY:
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5cfb27f26583..57f5c5067267 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -222,7 +222,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image);
 extern void kdump_nmi_shootdown_cpus(void);
 
 #ifdef CONFIG_CRASH_HOTPLUG
-void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
+void arch_crash_handle_hotplug_event(struct kimage *image, int cpu, void *arg);
 #define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
 
 int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 335fd2ee9766..dda4ad1a163e 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -508,7 +508,7 @@ unsigned int arch_crash_get_elfcorehdr_size(void)
  *
  * Prepare the new elfcorehdr and replace the existing elfcorehdr.
  */
-void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
+void arch_crash_handle_hotplug_event(struct kimage *image, int cpu, void *arg)
 {
 	void *elfbuf = NULL, *old_elfcorehdr;
 	unsigned long nr_mem_ranges;
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index d35726d6a415..118e2e03e0b5 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -42,7 +42,7 @@ static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
 #endif
 
 #ifndef arch_crash_handle_hotplug_event
-static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
+static inline void arch_crash_handle_hotplug_event(struct kimage *image, int cpu, void *arg) { }
 #endif
 
 int crash_check_hotplug_support(void);
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3952b3e102e0..27c6f57e5169 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -634,7 +634,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
 	image->hp_action = hp_action;
 
 	/* Now invoke arch-specific update handler */
-	arch_crash_handle_hotplug_event(image, arg);
+	arch_crash_handle_hotplug_event(image, cpu, arg);
 
 	/* No longer handling a hotplug event */
 	image->hp_action = KEXEC_CRASH_HP_NONE;
-- 
2.53.0



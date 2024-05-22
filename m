Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274D8C25B7A
	for <kexec@archiver.kernel.org>; Wed, 22 May 2024 13:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=M4VcNDA+G5OLR7Lhh1Z1uIwNTymZKwrxq3l1BRMGFnY=; b=jz2B333+2oQe2i
	F6m7Sl6d1hDRajtuxyT8G2FXI5sTiNe3nR009DUiqxyMDXXk64BxpRxIjbkw2RCORXM6qaO1hHCjK
	37B9HCVhoKc7geb3/0BL+WaYl1GPLOY4II5Ycxd+lPas0YwQaI4VuOpGKvUsLUgOz/Rq1JLLSevd+
	d2Gc0kh9+teDzG2mgWekg30wWULLuj2AZL07l3VFW+GyYWlct/oIjbiC6fZIvC5DNYvnUCivUfCvG
	zQoHuapmKiwxpwFVXjfh/h+S774hsvTbzWJItf+C+AxsqC/u3jTe68AIVy8XlEdeInJWu0HtnYNBc
	aa88xvMhABS4jtuyM9pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lnQ-000000031Zz-2aqw;
	Wed, 22 May 2024 13:14:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9lnN-000000031ZP-0pl1
	for kexec@lists.infradead.org;
	Wed, 22 May 2024 13:14:18 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MD8BhZ019689
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VNvAxt6aAp1WFnytJLZLxhLGd00TrqrXbc3S+zaXtX4=;
 b=X1bFoot0p2u1JYre9i37NP1PeuOy4Puy3yK7GS4N4ExK2Ph4YzKcIsVubMCX5UcmpquM
 O9Nyd397QQ0GMhOM6I+9gInSRstfWo6fZG2NTcnUW3o/3QU/z/t31rl9nzgHw1zCfohK
 fZUcbT77c1hnJvc9uTdp7e4iQtp5Hd1RkOWM7PLskqKy3Mi6qUizP1kfyNXkshLVdOoD
 VpOHxVNL436LEie76RfT1fwgCel5lWMbg/AizjJsOqwMstMQZyN17wK1DOionIsUmlyJ
 /knBpJbyuWV0gqG+JowA16s1Uzg+xwKq/ySasf+sq2ws+Gl2yFWaHJJiZ/wE9VX+GFvq RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9hacr0h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MDECKr027998
	for <kexec@lists.infradead.org>; Wed, 22 May 2024 13:14:12 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9hacr0h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44MCQL88007412;
	Wed, 22 May 2024 13:14:11 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y79c33nth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 13:14:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44MDE6a927918610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 13:14:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B555420049;
	Wed, 22 May 2024 13:14:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C515520040;
	Wed, 22 May 2024 13:14:00 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.79.246])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 May 2024 13:14:00 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH 1/3] kexec_load: Use new kexec flag for hotplug support
Date: Wed, 22 May 2024 18:43:51 +0530
Message-ID: <20240522131353.198327-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ceFzZXpvmbGN10R-uNbZRhp9-1kxL2fI
X-Proofpoint-GUID: cXXSaLoxIQZcnYIHr7zcgCT_OIlNtMfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_06,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=773 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405220089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_061417_282360_3F25A9DD 
X-CRM114-Status: GOOD (  27.07  )
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

Kernel commit 79365026f869 (crash: add a new kexec flag for hotplug
support) has introduced a new kexec flag to generalize hotplug support.
The newly introduced kexec flags for hotplug allow architectures to
exclude all the required kexec segments from SHA calculation so that
the kernel can update them on hotplug events. This was not possible
earlier with the KEXEC_UPDATE_ELFCOREHDR kexec flags since it was added
only for the elfcorehdr segment.

To enable architectures to control the list of kexec segments to exclude
when hotplug support is enabled, add a new architecture-specific
function named arch_do_exclude_segment. During the SHA calculation, this
function gets called to let the architecture decide whether a specific
kexec segment should be considered for SHA calculation or not.

Given that the KEXEC_UPDATE_ELFCOREHDR is no longer required and was
colliding with the KEXEC_LIVE_UPDATE update flag, it is removed.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/arm/kexec-arm.c             |  5 +++++
 kexec/arch/arm64/kexec-arm64.c         |  4 ++++
 kexec/arch/cris/kexec-cris.c           |  4 ++++
 kexec/arch/hppa/kexec-hppa.c           |  5 +++++
 kexec/arch/i386/kexec-x86.c            |  8 ++++++++
 kexec/arch/ia64/kexec-ia64.c           |  4 ++++
 kexec/arch/loongarch/kexec-loongarch.c |  5 +++++
 kexec/arch/m68k/kexec-m68k.c           |  5 +++++
 kexec/arch/mips/kexec-mips.c           |  4 ++++
 kexec/arch/ppc/kexec-ppc.c             |  4 ++++
 kexec/arch/ppc64/kexec-ppc64.c         |  5 +++++
 kexec/arch/s390/kexec-s390.c           |  5 +++++
 kexec/arch/sh/kexec-sh.c               |  5 +++++
 kexec/arch/x86_64/kexec-x86_64.c       |  5 +++++
 kexec/kexec-syscall.h                  |  2 +-
 kexec/kexec.c                          | 14 ++++++++------
 kexec/kexec.h                          |  2 ++
 17 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 49f35b1..34531f9 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -148,3 +148,8 @@ int have_sysfs_fdt(void)
 {
 	return !access(SYSFS_FDT, F_OK);
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 4a67b0d..9d052b0 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1363,3 +1363,7 @@ void arch_reuse_initrd(void)
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 3b69709..7f09121 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -109,3 +109,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
                                     buf_min, buf_max, buf_end, 1);
 }
 
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
index 77c9739..a64dc3d 100644
--- a/kexec/arch/hppa/kexec-hppa.c
+++ b/kexec/arch/hppa/kexec-hppa.c
@@ -146,3 +146,8 @@ unsigned long virt_to_phys(unsigned long addr)
 {
 	return addr - phys_offset;
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 444cb69..b4947a0 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -208,3 +208,11 @@ void arch_update_purgatory(struct kexec_info *info)
 	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
 		&panic_kernel, sizeof(panic_kernel));
 }
+
+int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info)
+{
+	if (info->elfcorehdr == (unsigned long) seg_ptr->mem)
+		return 1;
+
+	return 0;
+}
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index 418d997..8d9c1f3 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index 32a42d2..9a50ff6 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -378,3 +378,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
 				    buf_min, buf_max, buf_end, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
index cb54927..0c7dbaf 100644
--- a/kexec/arch/m68k/kexec-m68k.c
+++ b/kexec/arch/m68k/kexec-m68k.c
@@ -108,3 +108,8 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 {
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index d8cbea8..94224ee 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -189,3 +189,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 				    buf_min, buf_max, buf_end, 1);
 }
 
+int arch_do_exclude_segment(const void *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 03bec36..c8af870 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -966,3 +966,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index bd5274c..fb27b6b 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -967,3 +967,8 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 33ba6b9..0561ee7 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -267,3 +267,8 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
 	return parse_iomem_single("Crash kernel\n", start, end);
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index ce341c8..f84c40c 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -257,3 +257,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
 				    buf_min, buf_max, buf_end, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index ffd84f0..42af90a 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -188,3 +188,8 @@ void arch_update_purgatory(struct kexec_info *info)
 	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
 				&panic_kernel, sizeof(panic_kernel));
 }
+
+int arch_do_exclude_segment(struct kexec_segment *UNUSED(seg_ptr), struct kexec_info *UNUSED(info))
+{
+	return 0;
+}
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 73e5254..4675c46 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -112,7 +112,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
-#define KEXEC_UPDATE_ELFCOREHDR	0x00000004
+#define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /* Flags for kexec file based system call */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 222f79e..034cea6 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -701,10 +701,13 @@ static void update_purgatory(struct kexec_info *info)
 			continue;
 		}
 
-		/* Don't include elfcorehdr in the checksum, if hotplug
-		 * support enabled.
+		/*
+		 * Let architecture decide which segments to exclude from checksum
+		 * if hotplug support is enabled.
 		 */
-		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
+		if (do_hotplug && arch_do_exclude_segment(&info->segment[i], info)) {
+			dbgprintf("Skipping segment mem: 0x%lx from SHA calculation\n",
+				  (unsigned long)info->segment[i].mem);
 			continue;
 		}
 
@@ -1651,7 +1654,6 @@ int main(int argc, char *argv[])
 		die("--load-live-update can only be used with xen\n");
 	}
 
-	/* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
 	if (do_hotplug) {
 		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
 		char *buf, *endptr = NULL;
@@ -1665,8 +1667,8 @@ int main(int argc, char *argv[])
 		if (!elfcorehdrsz || (endptr && *endptr != '\0'))
 			die("Path %s does not exist, the kernel needs CONFIG_CRASH_HOTPLUG\n", ces);
 		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
-		/* Indicate to the kernel it is ok to modify the elfcorehdr */
-		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
+		/* Indicate to the kernel it is ok to modify the relevant kexec segments */
+		kexec_flags |= KEXEC_CRASH_HOTPLUG_SUPPORT;
 	}
 
 	fileind = optind;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 1004aff..2d758c9 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -307,6 +307,8 @@ extern int do_hotplug;
 #define BOOTLOADER_VERSION PACKAGE_VERSION
 
 void arch_usage(void);
+/* Return non-zero if segment needs to be excluded from SHA calculation, else 0. */
+int arch_do_exclude_segment(struct kexec_segment *seg_ptr, struct kexec_info *info);
 int arch_process_options(int argc, char **argv);
 int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
-- 
2.44.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

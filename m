Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8462C3065C
	for <kexec@archiver.kernel.org>; Tue,  2 Jul 2024 04:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=htr2LrTisVtqoyyNOkRtP0pBKGRMO9zmFzxdBoRwbwo=; b=LqNc+yqDg47wEo
	JADALjn0F+B4o3wqOee1ndLHb7RRU/pmNnyBRKLg/qMvz1JG4pqI8VS6Rn9ou/OLGcbi6IGCA5/te
	QYWoH7hXynxnrr5H0U7tFNJfzM+kNMc69dxKXkGaDXwjOz0pZeiFzOLBKVI/3/sDK0hM4wT2Ycs5c
	VBSsU9urxFUu0XrFVhrujvmcEcDJwei41/xWOyRaVpsGiGmTb5LZBk/N00H/6njQ+oV6uFBmAIRFY
	oBxuxUjJCTxqltuciozqAyws0cCJbmgLuSKpswvHpJNLo11hDjlfRfRmdkpRw2HOTJeYp7Jca5yjb
	WHixEe0NM2NjIhS8c9og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVAl-00000005Vru-0WBq;
	Tue, 02 Jul 2024 04:31:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOVAh-00000005VqF-1PDw
	for kexec@lists.infradead.org;
	Tue, 02 Jul 2024 04:31:17 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4623qw8U020510;
	Tue, 2 Jul 2024 04:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=mwtHJwoKW/2C4F0vN3kXgMiBW5
	kMZk414sphRNVI2Zk=; b=TSxY+KzD4yNDj+AknuPCSPbvdvyuwpDmxb7e3Knrze
	LqQdaj9DlS365RJRitCY7goWkaeyxwuJmQnL63hmmHBjCbHlMhGKsjIgHRQarkju
	ECYV17ehXeIpPGkWoM4RLkhfgMh3lCilAvCqqfVt7xjaJkAyq3bvymG46IHz453N
	vi0PAYSFkOmENZX4HBSTCN8L4bc5+Wm6qGbo5Sk4f8P6q2S5raWUeS4JH7hTHUrq
	1qZTJsj49IGUkRi6hUvQ8d2ZVNCD6Brs8Q/NIpcdnnh+I00OLk0Yq0aKz7ksDTPO
	iFAahrR/5YHxmlLjkPpnep5zLbVQ3ULpulgNFo9CNz6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4049p1r4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:08 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4624V8JG016736;
	Tue, 2 Jul 2024 04:31:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4049p1r4p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46221Ydg009086;
	Tue, 2 Jul 2024 04:31:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00k1xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 04:31:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4624V2ae52625856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 04:31:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05AA620043;
	Tue,  2 Jul 2024 04:31:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4478920040;
	Tue,  2 Jul 2024 04:31:00 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 04:31:00 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Date: Tue,  2 Jul 2024 10:00:55 +0530
Message-ID: <20240702043057.200211-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5gNYihlq0_pK6pcbRK74AeLTQK4yJN2k
X-Proofpoint-GUID: p0lGcIekFHBlzvSjF6S5vTqk-pkmrJo2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_01,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=838
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_213115_744055_B478E322 
X-CRM114-Status: GOOD (  25.69  )
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
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---

* No changes in v2.

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
index ac75030..ee7b9f1 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -381,3 +381,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
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
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

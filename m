Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD56C3DA40
	for <kexec@archiver.kernel.org>; Sun,  7 Jul 2024 15:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RW4zoCmPFtaJ7YOum3d04xNGFDaQrX7kd2lzPSYKktY=; b=BCdL6v449TcMgt
	Rqt8OIOBdQXk0F3zQGnEoUIRFpEpN6GW29GDNXf5DBg9HzPf7H4U8WdZkzFXFf+NmyAEtnZ9PI8F5
	oy8VQ2WrZokDoVBogF5VhT6VQnlPsKbeqXBTsGQTyW9A0YnVOS/plJcc+B4SXFmsuzA+YS3AVT/Bs
	G7Si3TV4F8HFU/d7BxBqA5rpXgcET47TP3q8Xxqizae4RX1vPEYGC/0TwbYCixDjTkruyvkq40TN5
	aF+ze+QXgxTib+b7L2rg9Xo5k4A3zG0LSJxvXaSOpUyUj93dytYnmCRPiJgQXFashLkk9IqLb+9JM
	Y2H+z7VRht+QxIEy+jBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTlR-00000001w57-2A8T;
	Sun, 07 Jul 2024 15:25:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQTlO-00000001w4a-1n6w
	for kexec@lists.infradead.org;
	Sun, 07 Jul 2024 15:25:20 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467EnBXN019551;
	Sun, 7 Jul 2024 15:25:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=xCskxDPaC/uNy
	zaQshiDZWBHEGx4Zrn77QnvQ0GYrD8=; b=n3SOteOcFYuVgWw+WeRvFIHZHHM11
	JfEx7abVig0y/PgqHSI/Q4eEQUtjo63Kn+0DKEmoLdI2OYh0wrfqpJyuNJixgk0c
	miz/EQtc1PmJkQ6RT6clQrAQ53ZYmzR6qFJPH/qFYDkEOuurCR91qTtKUnMrUO8f
	VOKfWZahH40Ga+zY+L2MbMXfc6iLpTXcADFGPiJtknvC74Z8Ms7dbT/THiwYB9nj
	6LdGf3lgTgZ7F6dz2rdeqZh3NpYpWQmfElLgg03fcRaRZ5SX5hLzUr0IcvUiLSiB
	QtvWiord/W0T3wFHQENKVhq4EQc5OmwlujW7jdsqsqmOfYl3Ow2zmWs7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ux90537-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:14 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 467FPEAX005389;
	Sun, 7 Jul 2024 15:25:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 407ux90534-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 467CKLis014029;
	Sun, 7 Jul 2024 15:25:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 407jy2t941-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 15:25:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 467FP7OB57344418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jul 2024 15:25:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1315520043;
	Sun,  7 Jul 2024 15:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A4F02004D;
	Sun,  7 Jul 2024 15:25:04 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.10.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jul 2024 15:25:03 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        Coiby Xu <coxu@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH v3 1/3] kexec_load: Use new kexec flag for hotplug support
Date: Sun,  7 Jul 2024 20:54:54 +0530
Message-ID: <20240707152456.87899-2-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
References: <20240707152456.87899-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TaiHfTUtz4RNZo9yIi4DbI0qeaTH-MZS
X-Proofpoint-GUID: orHzebSmbOAfV5cTCW3-Gh0hlxeWoVvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=893 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407070126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_082518_746799_2E895B18 
X-CRM114-Status: GOOD (  28.44  )
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

Note: To avoid breaking backward compatibility, the new kexec flag
KEXEC_CRASH_HOTPLUG_SUPPORT is not used for x86 for now.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Coiby Xu <coxu@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/arm/kexec-arm.c             |  5 ++++
 kexec/arch/arm64/kexec-arm64.c         |  5 ++++
 kexec/arch/cris/kexec-cris.c           |  4 +++
 kexec/arch/hppa/kexec-hppa.c           |  5 ++++
 kexec/arch/i386/kexec-x86.c            |  8 ++++++
 kexec/arch/ia64/kexec-ia64.c           |  4 +++
 kexec/arch/loongarch/kexec-loongarch.c |  5 ++++
 kexec/arch/m68k/kexec-m68k.c           |  5 ++++
 kexec/arch/mips/kexec-mips.c           |  4 +++
 kexec/arch/ppc/kexec-ppc.c             |  4 +++
 kexec/arch/ppc64/kexec-ppc64.c         |  5 ++++
 kexec/arch/s390/kexec-s390.c           |  5 ++++
 kexec/arch/sh/kexec-sh.c               |  5 ++++
 kexec/arch/x86_64/kexec-x86_64.c       |  8 ++++++
 kexec/kexec-syscall.h                  |  1 +
 kexec/kexec.c                          | 40 ++++++++++++++++++++++----
 kexec/kexec.h                          |  2 ++
 17 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 49f35b1..4216327 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -148,3 +148,8 @@ int have_sysfs_fdt(void)
 {
 	return !access(SYSFS_FDT, F_OK);
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 4a67b0d..55e822b 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1363,3 +1363,8 @@ void arch_reuse_initrd(void)
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 3b69709..6d048d3 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -109,3 +109,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
                                     buf_min, buf_max, buf_end, 1);
 }
 
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
index 77c9739..b2c74ab 100644
--- a/kexec/arch/hppa/kexec-hppa.c
+++ b/kexec/arch/hppa/kexec-hppa.c
@@ -146,3 +146,8 @@ unsigned long virt_to_phys(unsigned long addr)
 {
 	return addr - phys_offset;
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index 444cb69..eac01e5 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -208,3 +208,11 @@ void arch_update_purgatory(struct kexec_info *info)
 	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
 		&panic_kernel, sizeof(panic_kernel));
 }
+
+int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segment)
+{
+	if (info->elfcorehdr == (unsigned long) segment->mem)
+		return 1;
+
+	return 0;
+}
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index 418d997..548a3af 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -245,3 +245,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index ac75030..ea0c316 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -381,3 +381,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
 				    buf_min, buf_max, buf_end, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
index cb54927..4824a02 100644
--- a/kexec/arch/m68k/kexec-m68k.c
+++ b/kexec/arch/m68k/kexec-m68k.c
@@ -108,3 +108,8 @@ void add_segment(struct kexec_info *info, const void *buf, size_t bufsz,
 {
 	add_segment_phys_virt(info, buf, bufsz, base, memsz, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index d8cbea8..fb5a5d4 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -189,3 +189,7 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 				    buf_min, buf_max, buf_end, 1);
 }
 
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index 03bec36..d3dad0f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -966,3 +966,7 @@ void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
 
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index bd5274c..90734fe 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -967,3 +967,8 @@ int arch_compat_trampoline(struct kexec_info *UNUSED(info))
 void arch_update_purgatory(struct kexec_info *UNUSED(info))
 {
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 33ba6b9..f4dd7dc 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -267,3 +267,8 @@ int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
 	return parse_iomem_single("Crash kernel\n", start, end);
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index ce341c8..7b9ac1c 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -257,3 +257,8 @@ unsigned long add_buffer(struct kexec_info *info, const void *buf,
 	return add_buffer_phys_virt(info, buf, bufsz, memsz, buf_align,
 				    buf_min, buf_max, buf_end, 1);
 }
+
+int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segment *UNUSED(segment))
+{
+	return 0;
+}
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index ffd84f0..7b2453f 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -188,3 +188,11 @@ void arch_update_purgatory(struct kexec_info *info)
 	elf_rel_set_symbol(&info->rhdr, "panic_kernel",
 				&panic_kernel, sizeof(panic_kernel));
 }
+
+int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segment)
+{
+	if (info->elfcorehdr == (unsigned long) segment->mem)
+		return 1;
+
+	return 0;
+}
diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
index 73e5254..cc32c01 100644
--- a/kexec/kexec-syscall.h
+++ b/kexec/kexec-syscall.h
@@ -113,6 +113,7 @@ static inline long kexec_file_load(int kernel_fd, int initrd_fd,
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
 #define KEXEC_UPDATE_ELFCOREHDR	0x00000004
+#define KEXEC_CRASH_HOTPLUG_SUPPORT	0x00000008
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /* Flags for kexec file based system call */
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 222f79e..59be075 100644
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
+		if (do_hotplug && arch_do_exclude_segment(info, &info->segment[i])) {
+			dbgprintf("Skipping segment mem: 0x%lx from SHA calculation\n",
+				  (unsigned long)info->segment[i].mem);
 			continue;
 		}
 
@@ -1419,6 +1422,30 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 	return ret;
 }
 
+/*
+ * Hotplug support for x86 in the kernel was added with the
+ * `KEXEC_UPDATE_ELFCOREHDR` kexec bit, and later it was generalized
+ * with the `KEXEC_CRASH_HOTPLUG_SUPPORT` kexec bit.
+ *
+ * Passing the `KEXEC_CRASH_HOTPLUG_SUPPORT` kexec bit to kernel
+ * versions 6.5 to 6.9 on x86 with the `kexec_load` system call will
+ * fail with `-EINVAL`.
+ *
+ * So for now, pass `KEXEC_UPDATE_ELFCOREHDR` for x86, and for other
+ * architectures, use the `KEXEC_CRASH_HOTPLUG_SUPPORT` kexec bit. But
+ * in the future, we can decide to get rid of `KEXEC_UPDATE_ELFCOREHDR`.
+ *
+ * NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide
+ */
+static inline unsigned long get_hotplug_kexec_flag(void)
+{
+#if defined(__i386__) || defined(__x86_64__)
+		return KEXEC_UPDATE_ELFCOREHDR;
+#else
+		return KEXEC_CRASH_HOTPLUG_SUPPORT;
+#endif
+}
+
 static void print_crashkernel_region_size(void)
 {
 	uint64_t start = 0, end = 0;
@@ -1651,7 +1678,6 @@ int main(int argc, char *argv[])
 		die("--load-live-update can only be used with xen\n");
 	}
 
-	/* NOTE: Xen KEXEC_LIVE_UPDATE and KEXEC_UPDATE_ELFCOREHDR collide */
 	if (do_hotplug) {
 		const char *ces = "/sys/kernel/crash_elfcorehdr_size";
 		char *buf, *endptr = NULL;
@@ -1665,8 +1691,10 @@ int main(int argc, char *argv[])
 		if (!elfcorehdrsz || (endptr && *endptr != '\0'))
 			die("Path %s does not exist, the kernel needs CONFIG_CRASH_HOTPLUG\n", ces);
 		dbgprintf("ELFCOREHDR_SIZE %lu\n", elfcorehdrsz);
-		/* Indicate to the kernel it is ok to modify the elfcorehdr */
-		kexec_flags |= KEXEC_UPDATE_ELFCOREHDR;
+		/* Indicate to the kernel it is ok to modify the relevant kexec segments */
+
+		kexec_flags |= get_hotplug_kexec_flag();
+
 	}
 
 	fileind = optind;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 1004aff..31c323f 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -307,6 +307,8 @@ extern int do_hotplug;
 #define BOOTLOADER_VERSION PACKAGE_VERSION
 
 void arch_usage(void);
+/* Return non-zero if segment needs to be excluded from SHA calculation, else 0. */
+int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segment);
 int arch_process_options(int argc, char **argv);
 int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
-- 
2.45.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

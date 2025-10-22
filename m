Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCDCCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 13:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UdXlftK6Jhn/IiF6+ejgb0fmOi1wZPUdcMv1UFedILM=; b=aySMU5/iw202VPMvTLsYDxk3tD
	E7qnDo7vyWKuqtZgA2rle+T91rSmfUTTW3HOHvGcDk4QydZUUA+4BdSt5y0xnuKO36SFkZGWuGQB6
	poSfoEVfwNehCPtmXTghz3XlgZWmfLw7s/HLyH2kC7JyaNj0kIPelZZYf2inZR/j9eZHW6sKBmPja
	Ti0Z9IbuOSi/XDrY+HubIURMKV2M8BTl/Qf1ZijORiJR+suzVxFB4pdlCXDsPjj2M89E3prfr0U2m
	5XdfDhGhXIBY/5giRCDQFXKS4OX49JIPdyMMlGEVEkK7p6g/spmsV4/i931LNFKnAQuFRCrbI9w1p
	jzHYpoLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAr-000000034jX-1mMe;
	Wed, 22 Oct 2025 13:46:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAn-000000034hn-1xTR
	for kexec@bombadil.infradead.org;
	Wed, 22 Oct 2025 13:46:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=UdXlftK6Jhn/IiF6+ejgb0fmOi1wZPUdcMv1UFedILM=; b=psWFacknha+OQ/MqtqloSQGi1f
	ZZaJ43A3FBbO3lrko/XnrZuCo+GzvDaZQ9WNOhuCGR6S48vmdW4KCbSFHTsJPF1VE8k0Z6nIkxENZ
	FJbN9A/woTVEfuADoFWW4hfkjna6A1T+7JQrZFmjpe6Dmppcx8WdX0sZzbc/IrSZ4NKQw4WWxIFeb
	sjvVVw/5TPDclxyQ5HDb0yTQ8r+n/zayqltFvPtjF+NWV2x5dD6P4ewo1TU6tK/hq23TdxcGzy8Tb
	HsLDg75/BGc8oE7LteBBBX61bnvEdENDu+kJUToi360zkpQRNRozqzHb0ZLdx1ngfd2dIXppYRtLX
	sHbXCwhg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYJ3-00000000bDX-1fWE
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:51:12 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MANQMa027549;
	Wed, 22 Oct 2025 13:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UdXlftK6Jhn/IiF6+
	ejgb0fmOi1wZPUdcMv1UFedILM=; b=WitRqtRN0NkMx/AxoTxqVG01Saf0JERKG
	EEtxNOuUa9Z6imv5TzMAZxuzl4aFbR7dhgfv9Km98WgFV91AwrEuF130I0yInT0N
	tIGVd5OcFvVU69Xc3KeFhH3pYCW2T4F7z4sdhWzLjV8y3uprt2yt2Wqfn7FLuU8D
	X6A0rVGQoV+AZX+ertStpeqpB8OEP1ZmVEvJx9UcDx8MELelRUT45RS7Onl1/1zh
	67Jw7J3jmhVYZgGtlRfy8sSnASPAH3vn5yCFm5ge6p/KUywXTv22zBg1i+stB7CO
	CLPnQnG9eNru5kiFWuE2EdP6wSHekY776rocC7MWF0GCUQ/GQgUqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fd1g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAnB5o032089;
	Wed, 22 Oct 2025 13:46:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n0juy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:31 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MDkRVH50987302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:46:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BCC42004B;
	Wed, 22 Oct 2025 13:46:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10AFC20043;
	Wed, 22 Oct 2025 13:46:25 +0000 (GMT)
Received: from shivang.com (unknown [9.124.221.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 13:46:24 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        kexec@lists.infradead.org
Subject: [PATCH kexec-tools 3/4] Add arch_do_unload hook for arch-specific cleanup
Date: Wed, 22 Oct 2025 19:16:08 +0530
Message-ID: <20251022134611.8921-4-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022134611.8921-1-shivangu@linux.ibm.com>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f8e038 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=lPIOs0nfWen1hvPYDq8A:9
X-Proofpoint-GUID: CnmO4GQOIDz-HPhHmLSlpydzC3ub7FrF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX83cJA8Cw3rbL
 pPxs4eU33M95CRt6/3q7AG7VwUg4x75T6nqisdZMJNvVhUnWDXZ21gGhh+pXDRv9FaDVWNO1iyu
 cwbrrI+N8IBEOK4+ndzNFAJUFd4NQVWP4b1L57y2XWP5g3hMgktUgkWGBYV61qriotWRM/MRRyI
 qY3/SzSTApgiQJUcAOAcsQjJxgPQ3PUjrT3SJYf5sPFD3NmIikSuj8gohtK1wx3imN+yOsku6Rh
 5e2/uGiFKg0w5a/IbwbxdDHXd2nhei5RSKsye3JGKNF8nZBElFk4uVsZYYWT81t7OJIvVdl86a5
 WM7p4q91t6cSCyNPSUHz2U+jMkOuzbb/nK3J7uu6sTP7Dk9whQKIKHmXbRasT+1KGNWD1DKMoJP
 ghz9lx0Q7rBYo5kv63a71hpoIoRgIQ==
X-Proofpoint-ORIG-GUID: CnmO4GQOIDz-HPhHmLSlpydzC3ub7FrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_135110_627742_371375E1 
X-CRM114-Status: GOOD (  14.66  )
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

Provide a new `arch_do_unload` hook that allows architectures to perform
cleanup actions during kexec unload. On ppc64, this hook resets the boot
CPU.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 kexec/arch/arm/kexec-arm.c             | 4 ++++
 kexec/arch/arm64/kexec-arm64.c         | 4 ++++
 kexec/arch/cris/kexec-cris.c           | 4 ++++
 kexec/arch/hppa/kexec-hppa.c           | 4 ++++
 kexec/arch/i386/kexec-x86.c            | 4 ++++
 kexec/arch/ia64/kexec-ia64.c           | 4 ++++
 kexec/arch/loongarch/kexec-loongarch.c | 4 ++++
 kexec/arch/m68k/kexec-m68k.c           | 4 ++++
 kexec/arch/mips/kexec-mips.c           | 4 ++++
 kexec/arch/ppc/kexec-ppc.c             | 4 ++++
 kexec/arch/ppc64/kexec-ppc64.c         | 8 ++++++++
 kexec/arch/riscv/kexec-riscv.c         | 4 ++++
 kexec/arch/s390/kexec-s390.c           | 4 ++++
 kexec/arch/sh/kexec-sh.c               | 4 ++++
 kexec/arch/x86_64/kexec-x86_64.c       | 5 +++++
 kexec/kexec.c                          | 1 +
 kexec/kexec.h                          | 1 +
 17 files changed, 67 insertions(+)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 4216327..af5b511 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -153,3 +153,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 9091f40..58256cf 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -1369,3 +1369,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/cris/kexec-cris.c b/kexec/arch/cris/kexec-cris.c
index 6d048d3..44557ad 100644
--- a/kexec/arch/cris/kexec-cris.c
+++ b/kexec/arch/cris/kexec-cris.c
@@ -113,3 +113,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/hppa/kexec-hppa.c b/kexec/arch/hppa/kexec-hppa.c
index b2c74ab..ef0eab5 100644
--- a/kexec/arch/hppa/kexec-hppa.c
+++ b/kexec/arch/hppa/kexec-hppa.c
@@ -151,3 +151,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/i386/kexec-x86.c b/kexec/arch/i386/kexec-x86.c
index eac01e5..f10b545 100644
--- a/kexec/arch/i386/kexec-x86.c
+++ b/kexec/arch/i386/kexec-x86.c
@@ -216,3 +216,7 @@ int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segme
 
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/ia64/kexec-ia64.c b/kexec/arch/ia64/kexec-ia64.c
index 548a3af..54c8588 100644
--- a/kexec/arch/ia64/kexec-ia64.c
+++ b/kexec/arch/ia64/kexec-ia64.c
@@ -249,3 +249,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
index ea0c316..e8713c8 100644
--- a/kexec/arch/loongarch/kexec-loongarch.c
+++ b/kexec/arch/loongarch/kexec-loongarch.c
@@ -386,3 +386,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/m68k/kexec-m68k.c b/kexec/arch/m68k/kexec-m68k.c
index 4824a02..cbbaaac 100644
--- a/kexec/arch/m68k/kexec-m68k.c
+++ b/kexec/arch/m68k/kexec-m68k.c
@@ -113,3 +113,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index fb5a5d4..6fb481c 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -193,3 +193,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index d3dad0f..7892385 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -970,3 +970,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 6653246..48afc85 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -979,3 +979,11 @@ int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segme
 
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+       /*
+        * setting the reboot cpu to 0
+        */
+       system("echo 0 > /sys/kernel/reboot/cpu");
+}
diff --git a/kexec/arch/riscv/kexec-riscv.c b/kexec/arch/riscv/kexec-riscv.c
index f34b468..a5a12a0 100644
--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -524,3 +524,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index ad3eb93..86c9fb8 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -273,3 +273,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 7b9ac1c..5231402 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -262,3 +262,7 @@ int arch_do_exclude_segment(struct kexec_info *UNUSED(info), struct kexec_segmen
 {
 	return 0;
 }
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/arch/x86_64/kexec-x86_64.c b/kexec/arch/x86_64/kexec-x86_64.c
index f7f59f6..6a0e872 100644
--- a/kexec/arch/x86_64/kexec-x86_64.c
+++ b/kexec/arch/x86_64/kexec-x86_64.c
@@ -197,3 +197,8 @@ int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segme
 
 	return 0;
 }
+
+
+void arch_do_unload(void)
+{
+}
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 6bf12d7..25b5391 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1752,6 +1752,7 @@ int main(int argc, char *argv[])
 		}
 		if (!do_kexec_file_syscall)
 			result = k_unload(kexec_flags);
+		arch_do_unload();
 	}
 	if (do_load && (result == 0)) {
 		if (do_kexec_file_syscall) {
diff --git a/kexec/kexec.h b/kexec/kexec.h
index a2e19c4..d0bccb5 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -310,6 +310,7 @@ extern int do_hotplug;
 void arch_usage(void);
 /* Return non-zero if segment needs to be excluded from SHA calculation, else 0. */
 int arch_do_exclude_segment(struct kexec_info *info, struct kexec_segment *segment);
+void arch_do_unload(void);
 int arch_process_options(int argc, char **argv);
 int arch_compat_trampoline(struct kexec_info *info);
 void arch_update_purgatory(struct kexec_info *info);
-- 
2.51.0



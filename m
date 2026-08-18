Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB0CC5DF7D
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WQBn3BIQOaY/VHXTTbZH8FXBsPqjOyIn3NchcNrz7Sc=; b=KHrdwFZeGtE+BbPIXP/VRkJdVb
	fPNN44/bO8HUbNW1FykBnZI0ZqGdnAzunzWp3LN6TG0cR5lGoY37xzOS9q4CQ4Lx/oF4fGMbIrkdU
	58SPy/6NhHrgUqMhdTtsY2uvgvpC+T6jYeGhhzvpfmLGXGjMYx5txhKl9KEuZIEdqGL6VRzb7FeNz
	ScYnkxFjNsob5KHKBdCgMvwDsf2jiaVn8Tyq50uXJIQfqnqDrzioC8S//BrU78DN5WVpjjq+MAzQg
	UJbI8MyG0/SEJiZGMOX7EnfDdV1LswO8p3tluc62pEBBySuqlkzthNwpeDh7JQtUzHic8XU1kFxI0
	fneD/rGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwLul-00000008HiX-0etJ;
	Tue, 18 Aug 2026 15:39:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwLui-00000008HiD-2v5M
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 15:39:46 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3SSO504686
	for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 15:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WQBn3BIQOaY/VHXTTbZH8FXBsPqjOyIn3NchcNrz7
	Sc=; b=R/ETRd9SxLVJ0tWiFcQYa1VVI/TLtz/fUnK6v5j/hEOnhsf69a2CkVtq2
	oxTebflWw/0A/TP70kXP/Luzi5H3dl5EB6QsAGww4r8dbXA/1qfIg5cUF8vQQI3e
	bzDokN7DD3mKZe1xEDxPZSGSFxpJHuZweGQj+hQifDLpoZ9vYRCeP8+HBknPeWzu
	EcIptw966QDpA5PYjipkEm3Ky4AWFPWm+lyjQnlNxpr2yXwKmbSN0lg5w78OJqSk
	RpCSWQmSQJEXSMW252V6SY9wAuu2A2P4hH+/8RZWi989pZePqhB19IxlB0qYN6xk
	RAm8vmOZqWr819wjgZAyx/fWTidcA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4s78p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 15:39:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IFQJ0W030905
	for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 15:39:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq4477-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Tue, 18 Aug 2026 15:39:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IFdYc351970374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 15:39:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D4EE20049;
	Tue, 18 Aug 2026 15:39:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 329BF20040;
	Tue, 18 Aug 2026 15:39:34 +0000 (GMT)
Received: from b315lp23.lnxne.boe (unknown [9.87.84.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 15:39:34 +0000 (GMT)
From: Joseph Cathcart <josephc@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: eoin.mcnamara@ibm.com, iii@de.ibm.com,
        Joseph Cathcart <josephc@linux.ibm.com>
Subject: [PATCH v1] kexec-tools/s390: add --reuseinitrd support
Date: Tue, 18 Aug 2026 17:39:25 +0200
Message-ID: <20260818153925.6203-1-josephc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bklpV7N0b-ktQbOdQvfr5qAW_yf5-pvn
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a847cbe cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DXaZhtDyEZ7YwAlEE54A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExNCBTYWx0ZWRfX2Jh4gPLg0hlc
 t1xqM1FVKYcNOPOohvtUFJCHYOoDNwFSRAbmiNUpojH16o84iT8BnYnIq8gkhi7dt4Tq0Xw80Be
 skCkEsDY/8DIU4nCZtUzhaTSAL8FDN8=
X-Proofpoint-ORIG-GUID: bklpV7N0b-ktQbOdQvfr5qAW_yf5-pvn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExNCBTYWx0ZWRfX6eX43CDXiRij
 8KvWSOONIi4QnjjkTtsJVbZXWeJOnNnIPMTWsl83gaV5VL4qSPOM4n/DEyXbw/LEaP+NYZHZ+Sj
 TGlOjQYVlu3DKpXEd/8VPpmURWQXcVJqDf/Q2f7v+3l7e1MHx13fGiDKumA7rK95SYetlZoj1lc
 5mMtueMqkKh9eJh1OhfAE54IKc6eU8/M9JByqbMmNslmrnzh6C7p7cRRPn6XQA5oKj+8UpZ/nPE
 rWlOLgIPPrGmjdMFK5Zd2Jj3o3sCCFfIwb+IkshqlLqwgHuQ1KzbQ1AQ7JSsCNAaChgUU+4T/fu
 N0uWshc0bx4ZF5l92rbWgdBzzxGQBVOvpGds+uflyTJR9r5EX+slbO0pvKTt+L+ViASa17F6aDI
 t4SY//tQsAgcoms4s5ajGgYcUIsAY4G9887IQQUvL9zLGsPDw4l904Xs3ntCjFpS5EClLjoQcoM
 xyrfBk8TkChme06nIzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_083944_739922_126694CB 
X-CRM114-Status: GOOD (  20.31  )
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

Currently, the --reuseinitrd param is not supported on s390. This
prevents testing kexec in environments such as virtme-ng, which by
default does not store the initrd on disk.

When --reuseinitrd is specified, add retained initrd memory range to
memory_range[] and fill new kernel parmarea directly with retained
initrd base and size, rather than memory range of a new ramdisk.

Add die() cases for trying to use --reuseinitrd flag in addition to
--ramdisk or --initrd, and for using --kexec-file-syscall instead of
--kexec-syscall while trying to use --reuseinitrd.

Signed-off-by: Joseph Cathcart <josephc@linux.ibm.com>
---

Depends on: https://lore.kernel.org/linux-s390/20260818153559.5700-1-josephc@linux.ibm.com/T/#u

 kexec/arch/s390/Makefile      |  2 ++
 kexec/arch/s390/kexec-image.c | 11 ++++++++++-
 kexec/arch/s390/kexec-s390.c  | 17 +++++++++++++++--
 kexec/arch/s390/kexec-s390.h  |  2 ++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/s390/Makefile b/kexec/arch/s390/Makefile
index fab3e68..17f9dc8 100644
--- a/kexec/arch/s390/Makefile
+++ b/kexec/arch/s390/Makefile
@@ -6,6 +6,8 @@ s390_KEXEC_SRCS += kexec/arch/s390/kexec-image.c
 s390_KEXEC_SRCS += kexec/arch/s390/kexec-elf-rel-s390.c
 s390_KEXEC_SRCS += kexec/arch/s390/crashdump-s390.c
 
+s390_ARCH_REUSE_INITRD =
+
 dist += kexec/arch/s390/Makefile $(s390_KEXEC_SRCS)			\
 	kexec/arch/s390/kexec-s390.h					\
 	kexec/arch/s390/include/arch/options.h
diff --git a/kexec/arch/s390/kexec-image.c b/kexec/arch/s390/kexec-image.c
index 69aaf96..1a59a32 100644
--- a/kexec/arch/s390/kexec-image.c
+++ b/kexec/arch/s390/kexec-image.c
@@ -78,6 +78,9 @@ int image_s390_load_file(int argc, char **argv, struct kexec_info *info)
 		}
 	}
 
+	if (reuse_initrd)
+		die("--reuseinitrd not supported with --kexec-file-syscall. Please use --kexec-syscall\n");
+
 	if (ramdisk) {
 		info->initrd_fd = open(ramdisk, O_RDONLY);
 		if (info->initrd_fd == -1) {
@@ -104,7 +107,7 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 	char *rd_buffer;
 	const char *ramdisk;
 	off_t ramdisk_len;
-	unsigned int ramdisk_origin;
+	unsigned long long ramdisk_origin;
 	int opt, ret = -1;
 
 	if (info->file_mode)
@@ -137,6 +140,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		}
 	}
 
+	if (ramdisk && reuse_initrd)
+		die("Can't specify --ramdisk or --initrd with --reuseinitrd\n");
+
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (parse_iomem_single("Crash kernel\n", &crash_base,
 				       &crash_end))
@@ -165,6 +171,9 @@ image_s390_load(int argc, char **argv, const char *kernel_buf,
 		ramdisk_origin = _ALIGN_UP(ramdisk_origin, 0x100000);
 		add_segment_check(info, rd_buffer, ramdisk_len,
 				  ramdisk_origin, ramdisk_len);
+	} else if (reuse_initrd) {
+		ramdisk_origin = retained_initrd_base;
+		ramdisk_len = retained_initrd_size;
 	}
 	if (info->kexec_flags & KEXEC_ON_CRASH) {
 		if (load_crashdump_segments(info, crash_base, crash_end))
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index 86c9fb8..4e77fc4 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -25,6 +25,13 @@
 #include <arch/options.h>
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
+unsigned long long retained_initrd_base, retained_initrd_size;
+unsigned int reuse_initrd = 0;
+
+void arch_reuse_initrd(void)
+{
+	reuse_initrd = 1;
+}
 
 /*
  * Read string from file
@@ -151,6 +158,7 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 {
 	char crash_kernel[] = "Crash kernel\n";
 	char sys_ram[] = "System RAM\n";
+	char kernel_initrd[] = "initrd\n";
 	const char *iomem = proc_iomem();
 	FILE *fp;
 	char line[80];
@@ -174,11 +182,16 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 		sscanf(line,"%llx-%llx : %n", &start, &end, &cons);
 		str = line+cons;
 		if ((memcmp(str, sys_ram, strlen(sys_ram)) == 0) ||
-		    ((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) &&
-		     with_crashk)) {
+			((memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) && reuse_initrd) ||
+			((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) && with_crashk)) {
 			memory_range[current_range].start = start;
 			memory_range[current_range].end = end;
 			memory_range[current_range].type = RANGE_RAM;
+			if (memcmp(str, kernel_initrd, strlen(kernel_initrd)) == 0) {
+				retained_initrd_base = start;
+				retained_initrd_size = end - start + 1;
+			}
+
 			current_range++;
 		}
 		else {
diff --git a/kexec/arch/s390/kexec-s390.h b/kexec/arch/s390/kexec-s390.h
index 6a99518..a990739 100644
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -34,5 +34,7 @@ extern int load_crashdump_segments(struct kexec_info *info,
 extern int get_memory_ranges_s390(struct memory_range range[], int *ranges,
 				  int with_crashk);
 extern int command_line_add(struct kexec_info *info, const char *str);
+extern unsigned long long retained_initrd_base, retained_initrd_size;
+extern unsigned int reuse_initrd;
 
 #endif /* KEXEC_S390_H */
-- 
2.55.0



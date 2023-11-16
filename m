Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F37BC47071
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XBs++/dwU/es/QsgRxOV+4/nfB7WPbFK4Iv2zyL/GFQ=; b=O+ZNZIgOrJTP/d
	5of3FgS2KD0JEXMrEFU17T9TDYusyuQdTJVXtMJKQwMSBFXpEuvjukoJl3OJ6bZXO/pmOSbxGW3GO
	/HhtxwOAiyz7N11jtw+/OF+yV/1V/PPIet93sNX8p3ygk76uzSYp/DuNUGIhi2/+2h/6zpIuztQMf
	QmP9W7DiKrCVR/Q3QeZcLypRj00xlrGilsvgTglpaJYCkpYdk2HAbfTFGW+w+hEdGhwA7ExpLsWN9
	NPy6BrZLv2Z3dSuoOAFAspRgvrmHpSaqzoFIgudPP4DjXk3vqkR1a8xax8zdG/zw8kVTm3MPL2Omq
	0HFTaqRkg93YaGzGCF3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Xwo-002tMu-0B;
	Thu, 16 Nov 2023 08:42:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Xwk-002tKi-2p
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 08:42:00 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG87KgC031999
	for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 08:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XNzUtfyH4wRT8Ow+aATD2Bg/LaZh+XeT7CyMeFwSwpg=;
 b=VSNp9yMLXZVfMPfYQb28FUC31GClTQkBP7FbzEUSZgXcx6b+X3c195yxp1jrtP/stX/U
 GluEE2JdmhqNfV1VsUWoj+xojzPCWLZReNYKE7ra4UY62T+PJ6dEYUxBoNXxlSeukHZ1
 JZXFxnqWuco7MjpFIneuYFdQ7L/v6d88z6mCJOFyUZ2Z0C2JLU+9UOWNsKZxWY0awdKl
 ZJ80kgAehfnCzn1S2yp7hgIPB0o5Qs45KNHAAv4vxJm6IRhDVV9mQZ75YbRNZR6z1Zpt
 HQKZwPuWOcfyKahJxPFAj/gQqG1eItfcZWv5gCbG1IF+m4I39SH3T6MySy5PI2lV63dg jg== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3udf9r8ucp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 08:41:45 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG8XqP3001298
	for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 08:41:44 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnndd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 08:41:44 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AG8fe6B13042330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 08:41:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C27220043;
	Thu, 16 Nov 2023 08:41:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1F8620040;
	Thu, 16 Nov 2023 08:41:38 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 08:41:38 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <kexec@lists.infradead.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH] kexec: ppc64: print help to stdout instead of stderr
Date: Thu, 16 Nov 2023 14:11:37 +0530
Message-ID: <20231116084137.179818-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZwsHUcFMRovrgkZOgY4frSW23Ffi55wa
X-Proofpoint-ORIG-GUID: ZwsHUcFMRovrgkZOgY4frSW23Ffi55wa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_06,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=984 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_004159_137875_98A465AB 
X-CRM114-Status: GOOD (  19.82  )
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

Currently 'kexec --help' on powerpc64 prints the generic help/usage to
stdout, and the powerpc64 specific options to stderr

That is, if the stdout of 'kexec --help' is redirected to some file,
some of the help options will not be redirected, and instead printed on
the terminal/stderr:

    [root@machine kexec-tools]# kexec --help > /tmp/out
         --command-line=<Command line> command line to append.
         --append=<Command line> same as --command-line.
         --ramdisk=<filename> Initial RAM disk.
         --initrd=<filename> same as --ramdisk.
         --devicetreeblob=<filename> Specify device tree blob file.
                                     Not applicable while using
    --kexec-file-syscall.
         --dtb=<filename> same as --devicetreeblob.
    elf support is still broken
         --elf64-core-headers Prepare core headers in ELF64 format
         --dt-no-old-root Do not reuse old kernel root= param.
                          while creating flatten device tree.

Fix this inconsistency by writing powerpc64 specific options to stdout,
similar to the generic 'kexec --help'

With the proposed changes, it is like this (nothing printed to stderr):

    [root@machine kexec-tools]# ./build/sbin/kexec --help > /tmp/out

Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c    | 22 +++++++++++-----------
 kexec/arch/ppc64/kexec-ppc64.c        |  6 +++---
 kexec/arch/ppc64/kexec-zImage-ppc64.c |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 01d045f..bdcfd20 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -482,15 +482,15 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 
 void elf_ppc64_usage(void)
 {
-	fprintf(stderr, "     --command-line=<Command line> command line to append.\n");
-	fprintf(stderr, "     --append=<Command line> same as --command-line.\n");
-	fprintf(stderr, "     --ramdisk=<filename> Initial RAM disk.\n");
-	fprintf(stderr, "     --initrd=<filename> same as --ramdisk.\n");
-	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
-	fprintf(stderr, "                                 ");
-	fprintf(stderr, "Not applicable while using --kexec-file-syscall.\n");
-	fprintf(stderr, "     --reuse-cmdline Use kernel command line from running system.\n");
-	fprintf(stderr, "     --dtb=<filename> same as --devicetreeblob.\n");
-
-	fprintf(stderr, "elf support is still broken\n");
+	printf("     --command-line=<Command line> command line to append.\n");
+	printf("     --append=<Command line> same as --command-line.\n");
+	printf("     --ramdisk=<filename> Initial RAM disk.\n");
+	printf("     --initrd=<filename> same as --ramdisk.\n");
+	printf("     --devicetreeblob=<filename> Specify device tree blob file.\n");
+	printf("                                 ");
+	printf("Not applicable while using --kexec-file-syscall.\n");
+	printf("     --reuse-cmdline Use kernel command line from running system.\n");
+	printf("     --dtb=<filename> same as --devicetreeblob.\n");
+
+	printf("elf support is still broken\n");
 }
diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 611809f..19f17cb 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -910,9 +910,9 @@ int file_types = sizeof(file_type) / sizeof(file_type[0]);
 
 void arch_usage(void)
 {
-	fprintf(stderr, "     --elf64-core-headers Prepare core headers in ELF64 format\n");
-	fprintf(stderr, "     --dt-no-old-root Do not reuse old kernel root= param.\n" \
-	                "                      while creating flatten device tree.\n");
+	printf("     --elf64-core-headers Prepare core headers in ELF64 format\n");
+	printf("     --dt-no-old-root Do not reuse old kernel root= param.\n"
+	       "                      while creating flatten device tree.\n");
 }
 
 struct arch_options_t arch_options = {
diff --git a/kexec/arch/ppc64/kexec-zImage-ppc64.c b/kexec/arch/ppc64/kexec-zImage-ppc64.c
index e946205..7f45751 100644
--- a/kexec/arch/ppc64/kexec-zImage-ppc64.c
+++ b/kexec/arch/ppc64/kexec-zImage-ppc64.c
@@ -180,5 +180,5 @@ int zImage_ppc64_load(FILE *file, int UNUSED(argc), char **UNUSED(argv),
 
 void zImage_ppc64_usage(void)
 {
-	fprintf(stderr, "zImage support is still broken\n");
+	printf("zImage support is still broken\n");
 }
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

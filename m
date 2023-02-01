Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DE5C05027
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 08:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DgvEcdebdrjFuXUQbyZ3H4cHFlxR75pF4qXPUJ5sMxM=; b=tDJwr3iFOGF6Fy
	BzU+3kjZqzYg4oEwaV51Iss6T7u0SmGPqtGcOfMfnkg6XBAI+k+Gyo09e4oca5cd8t37eH9vOTe/M
	FhcTizb1EtslP5mLULGq17m6aqQQkpE7ZOp8D9h5iVg8HeI0ZjYS4+dnDJmfnfgB1BOfksdjIZfew
	z/TiimwH5+2f9weOVSlBpxKyqGBhIRlTgsReecpohWvBSHp6Re03KXrBR1cA5ofLfbipaXFMKwCiS
	/+zNuebmKoTgwqnsnLGl2yv10/cGaHFMXHR7JRmQJ03PZ3IRQqK/1wT6n+5SNwDG8FNJho4jdezNm
	w4CxYiK7RJ+USHxqcsCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8sN-00AtAv-3J; Wed, 01 Feb 2023 08:53:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN8sK-00At9u-9P
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 08:53:54 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3118fjqN006416;
	Wed, 1 Feb 2023 08:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5uH2gXmMFMd7JNYNvrF27bd/6igigEPx8E3mGgfpCcM=;
 b=CpcR2ooI6R9vAwdsSHcKcR8YvkRE6S4DvchU0hviPKJzvptCxkyZKiBnMzkNjUkA4DX5
 cn0xtBX5mXC5MbKFjA37TcBZS6/DP3AdrK8sa83wDX5A2iRMkLRFoBVi6TpHeYOuI3C/
 zz5P3YilrBWHplPFkDD5t0Gl5k+BO/FY6YReTx+OnfuyDNrNuyK0/Y8HMioDLF4LlYwd
 9sQZ8/qYfEzM7KPA2p1UClfgSy238RKjkAA4IXmH4uNHHx660yZpR/fWlAYk+ubjvXnJ
 zPfDuB5ay/O+B+JkhQji4fnKBqVaHAdQMPOksiPi8PacI3R5/SyuMcUKARbuBaHVzoYk Xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfmsx08an-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 08:53:49 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3116BqOv026906;
	Wed, 1 Feb 2023 08:53:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7mkqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 08:53:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3118rh7g46793148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Feb 2023 08:53:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60D8F20040;
	Wed,  1 Feb 2023 08:53:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C24D2004E;
	Wed,  1 Feb 2023 08:53:42 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.109.52])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Feb 2023 08:53:41 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH] ppc64: add --reuse-cmdline parameter support
Date: Wed,  1 Feb 2023 14:23:31 +0530
Message-Id: <20230201085331.1004355-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eM3C7Q1Ttgwf-icKRO8ArqiTy-c4xron
X-Proofpoint-ORIG-GUID: eM3C7Q1Ttgwf-icKRO8ArqiTy-c4xron
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_03,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230201_005352_356104_229AC11E 
X-CRM114-Status: GOOD (  24.26  )
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
Cc: horms@verge.net.au, Sourabh Jain <sourabhjain@linux.ibm.com>, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

An option to copy the command line arguments from running kernel
to kexec'd kernel. This option works for both kexec and kdump.

In case --append=<args> or --command-line=<args> is provided along
with --reuse-cmdline parameter then args listed against append and
command-line parameter will be combined with command line argument
from running kernel.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/ppc64/include/arch/options.h |  4 +++-
 kexec/arch/ppc64/kexec-elf-ppc64.c      | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/ppc64/include/arch/options.h b/kexec/arch/ppc64/include/arch/options.h
index 71632ec..2bca96a 100644
--- a/kexec/arch/ppc64/include/arch/options.h
+++ b/kexec/arch/ppc64/include/arch/options.h
@@ -10,6 +10,7 @@
 #define OPT_RAMDISK		(OPT_ARCH_MAX+1)
 #define OPT_DEVICETREEBLOB	(OPT_ARCH_MAX+2)
 #define OPT_ARGS_IGNORE		(OPT_ARCH_MAX+3)
+#define OPT_REUSE_CMDLINE	(OPT_ARCH_MAX+4)
 
 /* Options relevant to the architecture (excluding loader-specific ones): */
 #define KEXEC_ARCH_OPTIONS \
@@ -41,7 +42,8 @@
 	{ "initrd",             1, NULL, OPT_RAMDISK },		\
 	{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },	\
 	{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },	\
-	{ "args-linux",         0, NULL, OPT_ARGS_IGNORE },
+	{ "args-linux",         0, NULL, OPT_ARGS_IGNORE },	\
+	{ "reuse-cmdline",      0, NULL, OPT_REUSE_CMDLINE },
 
 #define KEXEC_ALL_OPT_STR KEXEC_OPT_STR
 
diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 695b8b0..01d045f 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -95,6 +95,8 @@ static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
 {
 	int ret = 0;
 	char *cmdline, *dtb;
+	char *append_cmdline = NULL;
+	char *reuse_cmdline = NULL;
 	int opt, cmdline_len = 0;
 
 	/* See options.h -- add any more there, too. */
@@ -107,6 +109,7 @@ static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
 		{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },
 		{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },
 		{ "args-linux",		0, NULL, OPT_ARGS_IGNORE },
+		{ "reuse-cmdline",	0, NULL, OPT_REUSE_CMDLINE},
 		{ 0,                    0, NULL, 0 },
 	};
 
@@ -125,7 +128,7 @@ static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
 			if (opt < OPT_ARCH_MAX)
 				break;
 		case OPT_APPEND:
-			cmdline = optarg;
+			append_cmdline = optarg;
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -135,6 +138,9 @@ static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
 			break;
 		case OPT_ARGS_IGNORE:
 			break;
+		case OPT_REUSE_CMDLINE:
+			reuse_cmdline = get_command_line();
+			break;
 		}
 	}
 
@@ -144,6 +150,10 @@ static int elf_ppc64_load_file(int argc, char **argv, struct kexec_info *info)
 	if (reuse_initrd)
 		die("--reuseinitrd not supported with --kexec-file-syscall.\n");
 
+	cmdline = concat_cmdline(reuse_cmdline, append_cmdline);
+	if (!reuse_cmdline)
+		free(reuse_cmdline);
+
 	if (cmdline) {
 		cmdline_len = strlen(cmdline) + 1;
 	} else {
@@ -175,6 +185,8 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 {
 	struct mem_ehdr ehdr;
 	char *cmdline, *modified_cmdline = NULL;
+	char *reuse_cmdline = NULL;
+	char *append_cmdline = NULL;
 	const char *devicetreeblob;
 	uint64_t max_addr, hole_addr;
 	char *seg_buf = NULL;
@@ -204,6 +216,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 		{ "devicetreeblob",     1, NULL, OPT_DEVICETREEBLOB },
 		{ "dtb",                1, NULL, OPT_DEVICETREEBLOB },
 		{ "args-linux",		0, NULL, OPT_ARGS_IGNORE },
+		{ "reuse-cmdline",	0, NULL, OPT_REUSE_CMDLINE},
 		{ 0,                    0, NULL, 0 },
 	};
 
@@ -229,7 +242,7 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			if (opt < OPT_ARCH_MAX)
 				break;
 		case OPT_APPEND:
-			cmdline = optarg;
+			append_cmdline = optarg;
 			break;
 		case OPT_RAMDISK:
 			ramdisk = optarg;
@@ -239,9 +252,16 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 			break;
 		case OPT_ARGS_IGNORE:
 			break;
+		case OPT_REUSE_CMDLINE:
+			reuse_cmdline = get_command_line();
+			break;
 		}
 	}
 
+	cmdline = concat_cmdline(reuse_cmdline, append_cmdline);
+	if (!reuse_cmdline)
+		free(reuse_cmdline);
+
 	if (!cmdline)
 		fprintf(stdout, "Warning: append= option is not passed. Using the first kernel root partition\n");
 
@@ -469,6 +489,7 @@ void elf_ppc64_usage(void)
 	fprintf(stderr, "     --devicetreeblob=<filename> Specify device tree blob file.\n");
 	fprintf(stderr, "                                 ");
 	fprintf(stderr, "Not applicable while using --kexec-file-syscall.\n");
+	fprintf(stderr, "     --reuse-cmdline Use kernel command line from running system.\n");
 	fprintf(stderr, "     --dtb=<filename> same as --devicetreeblob.\n");
 
 	fprintf(stderr, "elf support is still broken\n");
-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

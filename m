Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A48C64ED6
	for <kexec@archiver.kernel.org>; Wed,  1 Mar 2023 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lAh/BOPblkgkGROjW58fLQsKPhGKSV1dlVchY5bLeLY=; b=Yed09zXYTn56xp
	E9hiY9+hMaMDJJoYfYiL2lGiMsPF8q5THOKxptk9YJMF45xTpABnX4J5j6BZQUB1uigqQgR3899V+
	0sa4XJh/U037CLbY4JmsDCCBQZhWfk7LNnpzPThpTEj2TyDMZozs4VY/ovO0MxOgsV/8V8ZNG+6Yj
	pOwFWIvJSaGgkUF8lm0GQGRjdiH3VLNT004hGSEhw6go4q5PdblxScpIXHYnC7jJh5eNCvaERrsxz
	1DKReEDgEQF+OEz3aenYgbyasVZkNia+qAUByTApoKwRFWquc/SGx+XnLBS7Yk+8R+Uro4wLPU7H0
	Fu80Gndrrr/gyCUbvdnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXIIF-00FUqM-3n; Wed, 01 Mar 2023 08:58:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXIIC-00FUpw-Rp
	for kexec@lists.infradead.org; Wed, 01 Mar 2023 08:58:34 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3218WQEF022924;
	Wed, 1 Mar 2023 08:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=mgVLNnUr6uyUHZdgYwLZZcprBPOgbIEXjfoC7xHtYBg=;
 b=DRCl62E5M3pHi6csUYrWG1DO0qXgoRPMPRnIifoekku+k11PWBoDPcnCmwferRuNSRNu
 aoU28lMRh4WMJi3mOLkGkQyz9M3EXCPIXboXA32OS2VcdwGXxDCuyw2eeFb3zSzoFoMo
 LZpt74/AcD08HMFyQHG2kVbrrsRWPAFJbe1TYvdFO43LIzkjYji5PIn4BYvGxFof0Qq7
 8ciax10UOhbI/9fbnVQ2bJayCNoBJ4+6dxWljvXkWT4A5mhT1r4helpc9dWdeI7hrF4e
 ZvbVLypfHvJhZpJh8owQ/24SE/RiKIIYFJn0gYbgoz8yYy4S197Wmjn6vwy+j6woqctq Ng== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p239nrjyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Mar 2023 08:58:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31SMv6W3012011;
	Wed, 1 Mar 2023 08:58:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3nybcuc935-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Mar 2023 08:58:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3218wM6c16122420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Mar 2023 08:58:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2DEB20043;
	Wed,  1 Mar 2023 08:58:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9FD32004B;
	Wed,  1 Mar 2023 08:58:21 +0000 (GMT)
Received: from zzfp368h.aus.stglabs.ibm.com (unknown [9.41.166.54])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Mar 2023 08:58:21 +0000 (GMT)
From: Gautam Menghani <gautam@linux.vnet.ibm.com>
To: kexec@lists.infradead.org
Cc: Gautam Menghani <gautam@linux.vnet.ibm.com>, horms@verge.net.au,
        sourabhjain@linux.vnet.ibm.com
Subject: [PATCH] ppc64: Add elf-ppc64 file types/options and an arch specific flag to man page
Date: Wed,  1 Mar 2023 03:58:19 -0500
Message-Id: <20230301085819.117295-1-gautam@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J96zkQ2tnhMHZnFt4zwCkdQHhkREJwK3
X-Proofpoint-ORIG-GUID: J96zkQ2tnhMHZnFt4zwCkdQHhkREJwK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_005833_058932_0BE92930 
X-CRM114-Status: GOOD (  17.08  )
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

Document the elf-ppc64 file options and the "--dt-no-old-root" arch 
specific flag in the man page.

Signed-off-by: Gautam Menghani <gautam@linux.vnet.ibm.com>
---
 kexec/kexec.8 | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 66453b8..3a344c5 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -335,6 +335,37 @@ with command-line arguments
 .I "arg1 arg2 ..."
 This parameter can be specified multiple times.
 .RE
+.PP
+.B elf-ppc64
+.RS
+.TP
+.BI \-\-reuse-cmdline
+Use the kernel command line from the running system.
+.TP
+.BI \-\-command\-line= string
+Set the kernel command line to
+.IR string.
+.TP
+.BI \-\-append= string
+Set the kernel command line to
+.IR string.
+.TP
+.BI \-\-ramdisk= file
+Use
+.IR file
+as the initial RAM disk.
+.TP
+.BI \-\-initrd= file
+Use
+.IR file
+as the initial RAM disk.
+.TP
+.BI \-\-devicetreeblob= file
+Specify device tree blob file. Not applicable while using --kexec-file-syscall.
+.TP
+.BI \-\-dtb= file
+Specify device tree blob file. Not applicable while using --kexec-file-syscall.
+.RE
 
 .SH ARCHITECTURE OPTIONS
 .TP
@@ -362,3 +393,7 @@ for debug output.
 Specify the
 .I baud rate
 of the serial port.
+.TP
+.BI \-\-dt\-no\-old\-root
+Do not reuse old kernel root=<device>
+param while creating flatten device tree.
-- 
2.31.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

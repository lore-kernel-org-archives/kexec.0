Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F9CE79CE
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 11:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ADPcfs+oBaGNr7c6XBJohelWlTPUK4MMUFxehM1dSBo=; b=vs4dmX4pb9BlS4
	xA5bXV3z8lJTTk0T239oIFm9kWkyoShCTLkvXVmiFVaBd5JWsYFH1HkZijVERCnE/fFCckm6OfumG
	9gXvqo6pLbWrjy+QUWK5q3SHYCZwZyo3iuxIQOGi3TFkVECMYgj1WQH1F3+3ufHKRjB+wVLUEhyhl
	8ouLZS3ubhwi/ccKp7YQcC+QdxQExnT0TEp3GbQdwO9cRRgd+RvbislO6/q59YDy340CnHSd/L7Da
	iJOtXJUiV5L3e5wNqOf4j1MYv23Mx0kTUMUeMsPLO9Tbnjn2tNOLzWL8eVCp858Yo+RUNW4tdDxPp
	WwLARCbje3GJ3VOfliwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivrw-002wuL-1v;
	Wed, 20 Sep 2023 11:59:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivrs-002wtb-2x
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 11:59:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KBcoWA032068;
	Wed, 20 Sep 2023 11:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DkfQLF2gvOOP9jMRGLK/ZJY06BXOKyJT/mVr92GmFn8=;
 b=jMdp/t9wd2ncsgXrq5T1yXb/T2152WICsHD5GGg5wmAk308sASY+vQJdsbjz0Az+6nM4
 ImyjbFXdkfth1cX6Fbp19BvvTvkGCMSYHQMWHzyqFtzx9nqfnvKwG1xN4tCXUKE6+R6H
 DSSURvI17JVF8y+tQrmTXf0B6nbrGr1ZRTlMyoz7TWNQLyE6ivBIL6/tL1FntExTFP+h
 D/1Pwo92n2B2SQYzLCFJnlviAyLSvBiuLPBadtj8VucZhlTm1qHMLPerSmdAiqet3hLg
 duZL5uYzvmydZSHh9n04XnBHbzTjQuBah3cxg5sUzaAwuOfKlb/B29nSjCTK4mwTF4R9 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7wfa45fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 11:59:32 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KBdseE001645;
	Wed, 20 Sep 2023 11:59:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7wfa45fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 11:59:32 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KApmhY031203;
	Wed, 20 Sep 2023 11:59:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5r6kw9wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Sep 2023 11:59:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KBxT0k24314592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Sep 2023 11:59:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61EEC2004D;
	Wed, 20 Sep 2023 11:59:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 846A220040;
	Wed, 20 Sep 2023 11:59:28 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.106.137])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Sep 2023 11:59:28 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: Kexec-ml <kexec@lists.infradead.org>
Cc: Simon Horman <horms@kernel.org>, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2] kexec: update manpage with explicit mention of clean kexec
Date: Wed, 20 Sep 2023 17:29:27 +0530
Message-ID: <20230920115927.1087546-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I5-Rrip8QJeVbLd9K24OBU9ptG9Eh4bR
X-Proofpoint-GUID: niHdELU8qiHQA7ZdE_zD6pVBW9Tu739o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0 mlxlogscore=797
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_045945_305899_20B1B5B7 
X-CRM114-Status: GOOD (  18.81  )
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

While the manpage does mention about kexec boot with a clean shutdown,
it is not explicit about it. Make it explicit.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Replaced "your linux distribution" with user-space.


 kexec/kexec.8 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 3a344c5..179dcf2 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -95,8 +95,15 @@ then you would use the following command to load the kernel:
 .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
 .RE
 .PP
-After this kernel is loaded, it can be booted to at any time using the
-command:
+After this kernel is loaded, assuming the user-space supports kexec-based
+rebooting, it can be booted to, with a clean shutdown, using the command:
+
+.RS
+.BR reboot
+.RE
+.PP
+Alternatively, it can also be booted to, without calling shutdown(8), with
+the command:
 
 .RS
 .BR kexec \ \-e
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FB0EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 05:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6BqC5pBtBTxt49t/9Uobkn5+39kqOmEWJbWyjDeY9OY=; b=Hu+EHb+elD8WsY
	1Iap66trKDvchrm8eRJnCUX0kGcGzfjAGGA1JrNi2zkCvNYI5he/mBJvp/HW0E/J9HHyRi6JtdS+L
	Aa8GxnLY/QNV6twtM5w2B1rLk9y3o45X2Qx68y+h5oS0NDo7ehVwJGwBhVe0vfWhszh+YXEk+gPES
	iwwm9/cB99GC1/KfQ3LG/Ug4s2+aCnNS+ipDr3Sb33tOG+5eVv89jYFac3MgO98N4hZ9BPhYelJKz
	YZ063agSmhWn7Z/7bBLmtLKy2cSbydmmOMiR/P0fP2NsvjsrhCmUgnKS1uREeNFEw9SrpwMuxBcSt
	bRcDbhCNhCsU6OJqLt5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHe2O-003cig-0e;
	Fri, 07 Jul 2023 05:29:48 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHe2K-003cgw-25
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 05:29:46 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3675PvT3017859
	for <kexec@lists.infradead.org>; Fri, 7 Jul 2023 05:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=zabmfgklVrlJ4JKEzLGbblSVOdVLwJnS25gLGlZWqV8=;
 b=pdSuJBuC/UrxP1PsN+TKRGR4p2YU9IhTzKUqU8jlBHk2zKCW3bM4XKxezTsnGi3kLX0X
 cOc7yrB60GKlAdGyxvqWGLog5zx0z9zAItca/IRYH0GXtN9VHHD9l6SQMbnN3v8wIPE1
 BSn0uus4Q1LMZul85Zr2kXYltRyYaq5uzg6PtIc+6ed8BYrn0wNNTn/pNg38cSoFv3Yt
 Yo09QAy2dvvF9kmtfMbSYwBNF94bXJVu6cGIwiKBu3toMiN1ZbDpaUTy74/zsHd3e9VR
 Wv2duFGo8RDPteX/XgHxsl8/ug11aM8WSDc/pz82amydlTF3wQoqHsbf13qw7e6byFbt tg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpcj801nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 07 Jul 2023 05:29:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3673xPI8007657
	for <kexec@lists.infradead.org>; Fri, 7 Jul 2023 05:29:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4utp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Fri, 07 Jul 2023 05:29:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3675TWjD31523130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <kexec@lists.infradead.org>; Fri, 7 Jul 2023 05:29:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6073720043
	for <kexec@lists.infradead.org>; Fri,  7 Jul 2023 05:29:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FF422004B
	for <kexec@lists.infradead.org>; Fri,  7 Jul 2023 05:29:31 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.111.241])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <kexec@lists.infradead.org>; Fri,  7 Jul 2023 05:29:31 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: Kexec-ml <kexec@lists.infradead.org>
Subject: [PATCH] kexec: update manpage with explicit mention of clean kexec
Date: Fri,  7 Jul 2023 10:59:29 +0530
Message-ID: <20230707052929.427625-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R8Xn0-6ZWCTckoPg2xoKMGbdzz1XkGhf
X-Proofpoint-ORIG-GUID: R8Xn0-6ZWCTckoPg2xoKMGbdzz1XkGhf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_02,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 mlxlogscore=887
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_222944_708991_C064EEC0 
X-CRM114-Status: GOOD (  18.06  )
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
 kexec/kexec.8 | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 3a344c5..87e4ab5 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -95,8 +95,16 @@ then you would use the following command to load the kernel:
 .RB "\-\-append=" "root=/dev/hda1" "\ \-\-initrd=" /boot/initrd
 .RE
 .PP
-After this kernel is loaded, it can be booted to at any time using the
-command:
+After this kernel is loaded, assuming your Linux distribution supports
+kexec-based rebooting, it can be booted to, with a clean shutdown, using
+the command:
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

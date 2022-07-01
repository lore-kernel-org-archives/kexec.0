Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F2C433EF
	for <kexec@archiver.kernel.org>; Fri,  1 Jul 2022 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=nVEcMBjYh9pg5mtZuoEQqKj5nIndIAIaBF2WWDx63us=; b=X21nc/6uVA6yZr
	ISlSBu826X9DBRSLvC3SYxv7hy7xyRrpCNC5Bxhv/ywaYodbfuXSKHJn6Z1hh4un1JXTDivh7uHQC
	EkFFDTL+L1Hn53ObUyGYJcoBiYc38qOpyMgMV5xwdQUxudfQu6uCNijO/UlDZSDKz+u4gTRhBxNZH
	YxPLLu6U8FnBBC/Gokz63hXLe9fK4Y7wYQlL4l0L/pVuD+UsBMObDWg0u8UIhvK8dIOKtVQt3u6/m
	RagbbtrSn0S2C2JBARgibaIiAX2uos4BugNl0a1c9buw4iRxMtEOVRr3V7nvf8DbAx7FsnMpDCbuA
	aeFGnYTYAhHFGUZZX3LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7BBr-003Qks-PE; Fri, 01 Jul 2022 07:35:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o7BBo-003Qjs-9U
	for kexec@lists.infradead.org; Fri, 01 Jul 2022 07:35:45 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2617SUSF018572;
	Fri, 1 Jul 2022 07:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=gLsIGt5mcqLwa6DnbQZyQAdiTpRMEIZyAyathQipuig=;
 b=M75U/GR6ZmabZ+1tSIC/sttID+YgqPI7saYFMIPW5tJDg6mTOsnc1WVvP882nqzLf8Fx
 g6ru0fQ2Otwjs8ve9zEzyrJWwhG3Pqtz02MsSva6T0etbNuVyEB8OYzQnwDKxGrnU/UT
 QxSwH+Gx2RITDbO+HeMBqsec4p4sTAytkZKpadZeVxAQLuDQBbStDbvrSnFjmMtRMmMA
 W0yGbQ2IllIBZVIIz87ChVHSsQTadMpiPQtZt/Eah/xgGPO2e63gRx8/l7jUnpiEQaqi
 qt2cg6iV4xWj+ISXeEnZn2SR8ZM2FQzuPt086rrylG/L17lmxpr7VwQrVWnhBQ6rsyi5 dQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1vjpg751-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 07:35:40 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
	by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2617SSia010563;
	Fri, 1 Jul 2022 07:35:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by ppma03fra.de.ibm.com with ESMTP id 3gwt08y09u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Jul 2022 07:35:38 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2617Za3h22020394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Jul 2022 07:35:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BEA14C04A;
	Fri,  1 Jul 2022 07:35:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29334C046;
	Fri,  1 Jul 2022 07:35:34 +0000 (GMT)
Received: from li-NotSettable.ibm.com.com (unknown [9.43.100.5])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  1 Jul 2022 07:35:34 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc: <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
Subject: [PATCH 0/2] kexec: Drop __weak attributes from functions
Date: Fri,  1 Jul 2022 13:04:03 +0530
Message-Id: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LBOsbtN09GJJq3kw3KNFbeGzH4JSd4IT
X-Proofpoint-GUID: LBOsbtN09GJJq3kw3KNFbeGzH4JSd4IT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_04,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=638 suspectscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220701_003544_486641_7D5FBD2C 
X-CRM114-Status: GOOD (  15.36  )
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

As requested [1], this series converts weak functions in kexec to use 
the #ifdef approach. I have compile-tested this series on arm64, 
powerpc, s390 and x86_64.

- Naveen

[1] http://lkml.kernel.org/r/87ee0q7b92.fsf@email.froward.int.ebiederm.org


Naveen N. Rao (2):
  kexec_file: Drop weak attribute from functions
  kexec: Drop weak attribute from functions

 arch/arm64/include/asm/kexec.h   | 18 +++++++-
 arch/powerpc/include/asm/kexec.h | 14 ++++++
 arch/s390/include/asm/kexec.h    | 14 ++++++
 arch/x86/include/asm/kexec.h     | 12 +++++
 include/linux/kexec.h            | 76 +++++++++++++++++++++++++++-----
 kernel/kexec_core.c              | 27 ------------
 kernel/kexec_file.c              | 35 +--------------
 7 files changed, 124 insertions(+), 72 deletions(-)


base-commit: 13fa82df3449770de37197fa51b610ffc788f555
-- 
2.36.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

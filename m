Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5373EC4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 12:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=83t4Wu03dFUSBmUWz9+im+i6wPHhIFbqfUxVlitmDE4=; b=LvqIbAT+U6y+jI
	3nToCITUqsX5Ze3RATi57R4lx3oCkpjxGe/bDyxeoAjqxICXOgRIko2ufJD+ol14lPsqJb//7Lf3z
	xWqPPAr+pdvGHg84b+fNviE3Y0JNnsop/z+0U68HNS5Z1FwPk6VHmlg5ONMtIT0cCDLUitDw9FVrf
	2/hLA9oaORKVP+Q2cUkOdh8lKpe+liCKblfl65ZJM/NsHzdrYYm1rv8116nE0b3aENEnGO9yuLh3q
	TRdbmq8B8T1N4K0TnouRR9UOVpGK8Rj2KZLEtkcHgXnwbG48MPeyg0mjdq7UWTsUouw4LvHwl6ru6
	SbvsJHsaViftoW/aUYNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1J-008Nxm-0J;
	Wed, 29 Nov 2023 12:50:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8K1E-008NwQ-0l
	for kexec@lists.infradead.org;
	Wed, 29 Nov 2023 12:50:22 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATCgZR8032684
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=xosAZWpGsIiSSnpqfBkYzXcLhYylNK1WZxWC/BnN138=;
 b=LE+aJXyMgF0wGONJXxEu+31mb04uT8Oh3Md5rkp/wMwIIZvYRhchATt8Na8a9sBDdWOG
 SCY0R+wiVoy8Bfjy4ffWBi7ljROi3z30RFbf3G6lpugKjR8Fe/XAFx1taax4NRIC8BNX
 Ws8uDn+y1rDXMmVJc+3xGdxDAHNEO9df9kvZNPpVYMn+TY+1spYWhX9qP4NJ43GRVLnh
 RxJjWYKTBpP+zI1Acg6N/T8Ye2bwr4VkI/gFUp0uYvrNygR5cr3LR9IW5g/kyLNkXbgE
 fCjhPpeoqwS0xTPezGXNYgXhf5pRoJttreRz4oqbdppZphdqt4imBzQ/jO4DSvocgB5i pA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3up5hn89kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATB46uh025730
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfk6urp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Wed, 29 Nov 2023 12:50:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ATCoCa246989590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 12:50:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 553F72004B;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4794220040;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Nov 2023 12:50:12 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 1D5F5E09C6; Wed, 29 Nov 2023 13:50:12 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Subject: [PATCH 0/2] s390x: uncouple physical and virtual memory spaces
Date: Wed, 29 Nov 2023 13:50:10 +0100
Message-Id: <cover.1701261329.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _omMGsOpqx5Lay80dREuWriEdZJXJ9_Y
X-Proofpoint-GUID: _omMGsOpqx5Lay80dREuWriEdZJXJ9_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_09,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=335 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_045020_505598_F770263E 
X-CRM114-Status: GOOD (  17.31  )
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

Hi all,

Currently physical and virtual addresses are the same on S390X,
but in the future it is going to be uncoupled just like on any
other architecture. This series supports that feature, but it
does not impact the current and older kernel versions.

Patch 1 is basically NOP and only fix semantics.
Patch 2 uses the feature if it is available in kernel.

Thanks!

Alexander Gordeev (2):
  s390x: fix virtual vs physical address confusion
  s390x: uncouple virtual and physical address spaces

 arch/s390x.c   | 149 ++++++++++++++++++++++++++++++++++++++++++++++---
 makedumpfile.c |   2 +
 makedumpfile.h |  12 +++-
 3 files changed, 155 insertions(+), 8 deletions(-)

-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

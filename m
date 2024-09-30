Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98182CE8362
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CuHVpiwbWlCZkirUnwQ/aXUHX+EAqcrXkEL8+ujARXw=; b=p2bAQ4U7EanIH2
	ltxHtzqY7N4vKhIJrfBzIsVMCCjIvm2KX+4sRq6vRFfBXD4ZegMZmOmQ2tnA/K6wX4RTGEX4Ir4jt
	OuvSmjaGI64yjdSw5NaLwTOltKE+cOSQc5UcI4oGBWSe9yLUwn7CC4mgjMry9XhaVdJ55sKUrwmjS
	tPJEby5IAYPNNrQ0BY1AEV27kEh4R0+GhJhItJtEfti6mGwA0+Tx09/dmMw2F+MsH5xzFovq5SH1c
	WKvZRMPxdkHVidnyHP4b2RFlY1x4ccirZoql9dlRDZUGj5ubciphyaDk1W9xq2a3wbKbRetiY5Tbn
	vyPt8pRu9HF0dCdYRFPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ3c-00000000CKJ-49jr;
	Mon, 30 Sep 2024 16:15:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ1E-00000000BoY-3c52
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 16:13:06 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCPGV8001587;
	Mon, 30 Sep 2024 16:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=bLYJeS7eR/meJfDsoEVtLA5cal
	4qj32kXHOMtVSXhjo=; b=UnrTXskTdFOQI0rnLbm0lBHet5b0C5hUujHTChB0Nj
	9n4yG3p+TpFoIc4BU1dq+jd7JVmCVu47BW0kChySNn2WnjgGTmgY1dhyEWDyRlRR
	py0zU+UB8CCW8SLB7NLVCXCLvQxFGpsANDZi5UPzaywyRkdeAcXcyNLb2Pd//zKA
	SULLkIuaqJgOYSohMwPHecJifr410BkggXIAAT8rDbq1ui6rDOhnUhy0Sbq3nLSQ
	Z4EPoRzC3bmR1KDB4d0iHf0w1CvOo4cDa9bKwozn/9oW+gFoN64fmCGI9zvR9q03
	mxp4PtJmvWOZE6/AcjLBod4/aTRXzFPzkQdkrdZVTVfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f82f6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UGD157022321;
	Mon, 30 Sep 2024 16:13:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9f82f68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UDvDgb008050;
	Mon, 30 Sep 2024 16:13:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxqkwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UGCxwB53477816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:12:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01EF82004E;
	Mon, 30 Sep 2024 16:12:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E744620043;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 8C530E038D; Mon, 30 Sep 2024 18:12:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>, Philipp Rudo <prudo@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/2] s390 fixes
Date: Mon, 30 Sep 2024 18:12:56 +0200
Message-ID: <cover.1727711991.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FGUYdHqFCGcpi42vF7AQ-A-POyVazUfx
X-Proofpoint-ORIG-GUID: 8pALbqd4lG3w76A0Mzhk4p1JuFRMVYv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 adultscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=561 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_091305_133246_02765BAA 
X-CRM114-Status: GOOD (  11.90  )
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

Hi All,

Please find patches that fix issues on s390 only.

Thanks!

Alexander Gordeev (2):
  Submit physical address to is_phys_addr()
  s390x: Assume zero value of OS_INFO pointer is valid

 arch/s390x.c | 3 +--
 elf_info.c   | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

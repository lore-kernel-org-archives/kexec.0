Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C982CE8364
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S8kG0/DkV9N54CdI08PndrxThic8SyViGarZRcKd3ik=; b=rjBPw3StpSf33y
	BddN78EIz2UrknbSFfaNtrBjf76Ir98hRkiYdR80lAyqMPoHMIqFNyxumYC16Q87vPtE9r0xdcozm
	rep0/OykgvegK29a1XnJPEFXPqz5xNdX3y9mcBVs5hhcEmrs/t+Eq0XuCzUKgytJ+NMNyDp4b+Qv+
	UVUyVHNYV4ihZQEhWfaFZpXI2dKqHLEjgcSeXmDjkTiSweclXnPs2GJV283lOuYOkI9Sn8IbJPRTm
	5S+avELI8ic7qCXxlGmVk8xIXs89YwbGzQ8ChvpkOd5PW/wWLUj5kMYMWuAC968VFA8DVYfWPyjsN
	/O33HSbkMtO6H3kq3aWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ3c-00000000CJa-0401;
	Mon, 30 Sep 2024 16:15:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ1D-00000000BoW-3l1o
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 16:13:05 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UAeigE026308;
	Mon, 30 Sep 2024 16:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=a3TuuXWJ3Ktyy
	vS2MCM+dSjF+7INC6dJeSRnOK61d8M=; b=TLI5h66u3GkMKDfhLU9gn/V3xeLCA
	YdaIvB1Tb1WAWwj8XTNWJhFy+xaz9IBF/okktxRyiLRxDSkrtgZR6CzBUGtyec9j
	6A32XEiFpW85zfkQCgmckisAmdn66pYsLhA6ZLs2ELKq7lC4AFOA4BlTxt2WT0L2
	dGtgDtnLA0hxhdjTNkgiBQ24y7Cj0YwR7SHTxKvQEoo5nC9TcIgSAVHJrhf6JyGc
	tdicQda1p4muTQ7kx8T4hM+dc53ejwuWQo0zaq5DCUKDFPpA3pLN2RVYrLHU+QYF
	Hv/39Bb+6jMfBQUHAvgKft8nCyk1cqIbEN7sH/bVLrbB66PicAaFNDQFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apayx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:02 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UGD1ed017225;
	Mon, 30 Sep 2024 16:13:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apayx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UFh5kQ002367;
	Mon, 30 Sep 2024 16:13:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxu0y4qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UGCxXG58851740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:12:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ECFC20049;
	Mon, 30 Sep 2024 16:12:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0F8420040;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 96C7CE06BA; Mon, 30 Sep 2024 18:12:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>, Philipp Rudo <prudo@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 2/2] s390x: Assume zero value of OS_INFO pointer is valid
Date: Mon, 30 Sep 2024 18:12:58 +0200
Message-ID: <0931d1b16594a48929906d009b26bfa29e0c4484.1727711991.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727711991.git.agordeev@linux.ibm.com>
References: <cover.1727711991.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W8sQ75vg3ipKKAJCQIYukvRLQdUO50E3
X-Proofpoint-GUID: fz--gV_qoZhxknmyHf1SXvxwaymUtqau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=940 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_091303_959252_707D8886 
X-CRM114-Status: GOOD (  14.34  )
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

An assumption that zero value of OS_INFO pointer is not valid
leads to a failure of --mem-usage argument against /proc/kcore:

s390x_init_vm: Can't get s390x os_info ptr.

Reported-by: Philipp Rudo <prudo@redhat.com>
Fixes: 9d58c2630c71 ("s390x: uncouple virtual and physical address spaces")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390x.c b/arch/s390x.c
index 4a993be..f9a055d 100644
--- a/arch/s390x.c
+++ b/arch/s390x.c
@@ -156,8 +156,7 @@ static int s390x_init_vm(void)
 	struct os_info os_info;
 	ulong addr;
 
-	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr,
-			sizeof(addr)) || !addr) {
+	if (!readmem(PADDR, S390X_LC_OS_INFO, &addr, sizeof(addr))) {
 		ERRMSG("Can't get s390x os_info ptr.\n");
 		return FALSE;
 	}
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

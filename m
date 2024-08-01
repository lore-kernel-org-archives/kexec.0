Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2495C3DA64
	for <kexec@archiver.kernel.org>; Thu,  1 Aug 2024 07:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=7DEf3w0nyJGQzSQOyzvlGO7nZi8FjMMEv89UFylYAtY=; b=L7NK4itS4O1fc9
	qWWyEaiVF4NmR0irTaTywJFMi4fVlOZogSYo09NupNdK3U/KhvrAAYlRLpcRMKqBgIE0IcImdnaS6
	QH1ZgFS9nCDHNiMYYDbl+/ntgZFVFB1QCOBQuzhCMVDqJ8azGWBXNePSc1rMZv5AqKdX2pLmcgZb2
	XfnTN1zQ/Gai4cb7lFFFXdJ5U2Fkhjx0VAa/n9OliyvIInlgjsnf4isQSx4DF0fSjnUbmwNA09UlT
	H9R50+SCJw6bFTlH6qOiWgfnGPd3tTxklAeJgAzD+Kv//2Lvmp1JXOAP+Jbi+roc0TWvV7lkA1rOZ
	0/uEgowg8QtqrXJzw4mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQCp-000000049ka-2ElJ;
	Thu, 01 Aug 2024 07:26:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZQCm-000000049k2-1fVK
	for kexec@lists.infradead.org;
	Thu, 01 Aug 2024 07:26:33 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4717QVro021988;
	Thu, 1 Aug 2024 07:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=NIZFTFRdOpN4EsEb2NxfqZxsUR
	5jodumbHz63mYDPzk=; b=dT1BFH1U9G2eVv+zUAszzWbCc693Eg8FaX7gYuS1AW
	h/rMVsE9JkIGBjlemdOEpq9TxVaTSXMXTOVIrx6KAcUwxStKI0U5AnGyQnFKPpw7
	9d0A2YNtBAmijhaTnhB6pWI0aAn0JpYNnf71PrrUSkQtUrECFmAIlLRO+N8isVxI
	pLgKAswrQeiLTvURyOZfP5PQUST6gYqGVuQ8v3LMefkzdy6eBJg+mExLNlYfO6/r
	ChmqR5k2tBZHnbcOMFvWzsJl1SjqXpiLDEUwvwpip8yEDYmDIlwKnUXT3iEw9n67
	j0Xukjqb/v3hMdyXkkdlCuqaY6Wnqm30H2NpXdev3mwA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qx3cs23u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 01 Aug 2024 07:26:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47150PjH011133
	for <kexec@lists.infradead.org>; Thu, 1 Aug 2024 07:22:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqn0b8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <kexec@lists.infradead.org>; Thu, 01 Aug 2024 07:22:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4717MUgk47907122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 07:22:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 117872004B;
	Thu,  1 Aug 2024 07:22:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0ADCA2004E;
	Thu,  1 Aug 2024 07:22:29 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 07:22:28 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <kexec@lists.infradead.org>
Subject: [PATCH] fix comment: Mention current logic for vmalloc_start
Date: Thu,  1 Aug 2024 12:52:27 +0530
Message-ID: <20240801072227.40562-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CTgoAn15nv3DFBin-bwOB_ktQLNAUZxW
X-Proofpoint-ORIG-GUID: CTgoAn15nv3DFBin-bwOB_ktQLNAUZxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 mlxlogscore=980 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240801_002632_465398_5BE03438 
X-CRM114-Status: GOOD (  15.29  )
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

Previous comment is not valid anymore as for newer kernels we are
getting vmalloc_start from NUMBER(vmalloc_start)

The logic was changed in makedumpfile:
    commit 94241fd2feed ("[PATCH] ppc64: get vmalloc start address from vmcoreinfo")

Fix comment for better understanding.

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
repository: makedumpfile

patch should apply on commit 900190de6b67b2de410cfc8023c1b198a416ceb3
---
---
 arch/ppc64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index a54f9a04db7f..8ad9d6e3265f 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -566,7 +566,9 @@ get_machdep_info_ppc64(void)
 	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
 
 	/*
-	 * Get vmalloc_start value from either vmap_area_list or vmlist.
+	 * To get vmalloc_start, prefer NUMBER(vmalloc_start) if exported in
+	 * vmcoreinfo, as 'vmap_area_list' and 'vmlist' in Linux 6.9 and later
+	 * kernels might be empty
 	 */
 	if (NUMBER(vmalloc_start) != NOT_FOUND_NUMBER) {
 		vmalloc_start = NUMBER(vmalloc_start);
-- 
2.45.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

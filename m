Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB5ECAAA1
	for <kexec@archiver.kernel.org>; Thu, 15 Sep 2022 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=e/t9SIUdcSFf3n0wpIoe6plwylK2D0IVbuC/XZ4dM1k=; b=P67sa+DfwfQU/V
	YJY8YKrl90qWtxhSZdPihkycj+F4eg/w21cbjlt2usku5KTRM4LD6hU4HTMjS1bmPkX49//PrSwgS
	esj3zTtjcpz1lOCF1F18GrI8sM4e5VAC4YYzWl55576GRUZzMLNm4FCBh43mKGvIiumgck+pWmk9J
	b0YUgyHinCFm/mbDr1cy+WMrflPxC9pgZYuZs0Cv4itCQNBjVjrmFXUO7s16BqTIL3vK0KuHteTWv
	ZSJQ+9OCrm/KVktn4gbYhuk/AFE1xYBNHe3ouZk5cbfY0q2WtleKA1fOPwIodIKGGiPUtzpQdjNHH
	tTnq8zjyzA5BC99PjKOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYkSh-004Cu8-I3; Thu, 15 Sep 2022 08:43:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYkSf-004Cqs-BD
	for kexec@lists.infradead.org; Thu, 15 Sep 2022 08:43:06 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F84Zr3018569;
	Thu, 15 Sep 2022 08:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=QMa/W2JUXveMcUvabBM73IQZG80K05zBKd5QlykyhTU=;
 b=cYctuGBdqrTyd6PdGnCvCd0B8dOhEFAhMa3trjctxvaTuhEMYTmKEx80TVXkNU7t7QXS
 VrBPZO2isee1GlUwl6HhxWUGyzbGfpjFMiWtZPj1qdJkZQM7Ki90AegTLjU/WyMUYy6Y
 1Y7+UhPWXn7gkKqwZxLz/hKTs2VgKj+LXIwkYFPNVSq/P/HzlveMjSw8b7fQChXTUv92
 HXi+QraMY+ZhluMmmZs8fm52qzbBuDnKJCX+Mbdo2tkavCfPCr9V+3fEsWAkQEeg9OJJ
 ccYPkFw36ls/AGPEFogZcfIDV/iJzNcoa+49Ze1Lalhg/p1z9kULjMMQ1l8M4qQcbv0N dQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkxmfv7xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Sep 2022 08:42:59 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28F8bE05021611;
	Thu, 15 Sep 2022 08:42:58 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by ppma04fra.de.ibm.com with ESMTP id 3jjy2n1kt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Sep 2022 08:42:58 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28F8gsNN35127662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Sep 2022 08:42:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE76D52050;
	Thu, 15 Sep 2022 08:42:54 +0000 (GMT)
Received: from sjain014.ibmuc.com (unknown [9.43.101.180])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4D48B5204E;
	Thu, 15 Sep 2022 08:42:53 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, hbathini@linux.ibm.com,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH] ppc64: remove rma_top limit
Date: Thu, 15 Sep 2022 14:12:40 +0530
Message-Id: <20220915084240.133742-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HDoX_MVha04DUzUv0A3WNQ4hjwneuzC-
X-Proofpoint-GUID: HDoX_MVha04DUzUv0A3WNQ4hjwneuzC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_04,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=840 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220915_014305_739291_BEFDD522 
X-CRM114-Status: GOOD (  17.35  )
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

Restricting kexec tool to allocate hole for kexec segments below 768MB
may not be relavent now since first memory block size can be 1024MB and
more.

Removing rma_top restriction will give more space to find holes for
kexec segments and existing in-place checks make sure that kexec segment
allocation doesn't cross the first memory block because every kexec segment
has to be within first memory block for kdump kernel to boot properly.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-ppc64.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
index 5b17740..611809f 100644
--- a/kexec/arch/ppc64/kexec-ppc64.c
+++ b/kexec/arch/ppc64/kexec-ppc64.c
@@ -717,8 +717,6 @@ static int get_devtree_details(unsigned long kexec_flags)
 			if (base < rma_base) {
 				rma_base = base;
 				rma_top = base + be64_to_cpu(((uint64_t *)buf)[1]);
-				if (rma_top > 0x30000000UL)
-					rma_top = 0x30000000UL;
 			}
 
 			fclose(file);
-- 
2.37.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

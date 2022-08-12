Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B6C25B0F
	for <kexec@archiver.kernel.org>; Fri, 12 Aug 2022 17:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vxMQnUNbCwyCIZb0jkeFiR3ianp+1A+XyTsz3YhJEp0=; b=h9/lz7sU2pNV9M
	FSOaAInFLZsMGTtAvcdSMzp+zpU4cKSmdg7XEfHS6Cge5+XrUCAUx1BkMECVECv1bQv+14zc1bqWL
	2iyAc8P4ZksT0tihh5GKeVXkOzJiRjaG+px7bOT1w2tx3MlN3oWclUXdpFDCBiYJOryfNslFxA4cx
	WmMLLiaZ8YyiHcwJEEV3GCE3dWztV5DbGYzvPHIKdv/RQiqH/7a9T5ch4S6fcOXuCgagF1eMrVtDU
	Ez7/dN2KcvBYuwv3wq738GJ1JSxRW/+s44K4ZZyNR9Ih8WgJyOE9YQc8ztKt7B/J431E3f9iwbKxG
	eafB14q7kShrt96zC9NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMY2C-00BBWi-65; Fri, 12 Aug 2022 17:01:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oMY29-00BBS6-LZ
	for kexec@lists.infradead.org; Fri, 12 Aug 2022 17:01:18 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27CGhbCS005850;
	Fri, 12 Aug 2022 17:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k4rfDl5sjXMkFxZKUuEqZdOSLHex7NUKzrZWhtsr1fw=;
 b=IdsRWAodbLf5S6DRZec/JyCO3UhO8kpJrlXb1jRiH4vZ3zQz4WbjEnINbUwjHJYXKPdN
 7+tnf+LLW+cYqCaKzf7Y3+O1BbpzraVryHhf6zHVXGNI7mjHkF5JZmyvsCR/JpDZNWNO
 AJqPVm8y9Sn55R07BcXftE2No4VnHnU8/P/gDH4YbLq8K01sAag+lc9nltqvQ//Dwy59
 Wmfb7dGF4QIUrGVyYQRBqG5cPhDIdXB+dxx7wz1Rr2/i8R1IDNXCCBSh0eQeeGI7IeXL
 Ap1yAFW/vTcfGwmRGsjSy5E6CRxcb/AMFtsWe13DVe0yTE4Q5nYql2oWFHzUuQxbxddy pQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwtmn8ejx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Aug 2022 17:01:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
	by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27CGad3c004857;
	Fri, 12 Aug 2022 16:43:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
	by ppma03wdc.us.ibm.com with ESMTP id 3huww6j67m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Aug 2022 16:43:12 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27CGhBek524800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Aug 2022 16:43:11 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FB772805E;
	Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B8F2805A;
	Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
	Fri, 12 Aug 2022 16:43:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: nayna@linux.ibm.com, nasastry@in.ibm.com, mpe@ellerman.id.au,
        Palmer Dabbelt <palmer@rivosinc.com>, Rob Herring <robh@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v7 2/6] drivers: of: kexec ima: Support 32-bit platforms
Date: Fri, 12 Aug 2022 12:43:01 -0400
Message-Id: <20220812164305.2056641-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812164305.2056641-1-stefanb@linux.ibm.com>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P20OgIJxfTKAti3Kpge_wkB5Cr85HOrG
X-Proofpoint-GUID: P20OgIJxfTKAti3Kpge_wkB5Cr85HOrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_10,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220812_100117_840228_9AA8B40C 
X-CRM114-Status: GOOD (  19.03  )
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

From: Palmer Dabbelt <palmer@rivosinc.com>

RISC-V recently added kexec_file() support, which uses enables kexec
IMA.  We're the first 32-bit platform to support this, so we found a
build bug.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 drivers/of/kexec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 91b04b04eec4..c4f9b6655a2e 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -253,8 +253,8 @@ static int setup_ima_buffer(const struct kimage *image, void *fdt,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("IMA buffer at 0x%llx, size = 0x%zx\n",
-		 image->ima_buffer_addr, image->ima_buffer_size);
+	pr_debug("IMA buffer at 0x%pa, size = 0x%zx\n",
+		 &image->ima_buffer_addr, image->ima_buffer_size);
 
 	return 0;
 }
-- 
2.35.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

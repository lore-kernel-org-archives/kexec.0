Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05026CCD1BE
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 13:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qq8wDPR1G1OlOoofqcbloHRaiLMsECfV0yl+0cBcSBo=; b=Ah3LEdDOvNcSQRk1g6fypEJXX3
	ZnHkp/AK7SNAetu2PpYASQMqGN1+VIminY5YzIp/oe2QL/Gp9oJFff2v0rnnFzZSUlZ8gSCuOmltH
	So4GZAGiyy2pBqfnv3j/zFrSpa6BNdbbHmq3CYxYm1nDeistcLHzueZM+QWGF0MUd+4bAcQVVtM9K
	SS8HMnYAfmX+RYPW2JPrJeRO6i1aPTIGahZXsf5CykvZI6HQBDnJvSdjvxOrfb0tcerMolIjyF0WO
	aDvSfolaYnOAyHwXmRGOYG2z3dLbYxsbXLOKwYsYIkETJApzjgttngd6yubPbolX5iH1K7VW5yOoF
	TiBBYMGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAw-000000034ku-0QlI;
	Wed, 22 Oct 2025 13:46:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAs-000000034jr-203n
	for kexec@bombadil.infradead.org;
	Wed, 22 Oct 2025 13:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qq8wDPR1G1OlOoofqcbloHRaiLMsECfV0yl+0cBcSBo=; b=F1FzqkvzBFEU5coZfv9KB2MjvQ
	u1UjsGMOBYSqVwvr79Klwh/dkOb9BUHovGOQmd0gEGrdS9rwEwK5MUv69IMFwqtHrQtjYiLwOERAn
	syMXciIKWn2u2CUFZtALiCgcMdAKLG3Gd6aN8en/+xILjmJ+Zc6N8TumAwIqHnvM7usvrcDL5xbxI
	T+0J18NzGv92LlTd/5VQDKh6hWOLLEF8EyLBZv8DQG+1zOSIskJSR38bKoz20TezvvAvStswpGJOR
	oLSp04SVbDZnGozmyVI83FefUvyBpt7o7OSXrxhVPUUqUHGOBFl0Ex34QwJu5MNVgaQqnqKL8TEEw
	kY7+jYVg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYJ4-00000000bDo-3T8d
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:51:13 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MBlVsC030017;
	Wed, 22 Oct 2025 13:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qq8wDPR1G1OlOoofq
	cbloHRaiLMsECfV0yl+0cBcSBo=; b=ROpDFpZHdQd0xoWxgC/OdSMGX4vZSFHok
	vw+s64JZV7SwY9DkORKCHQQxSBp8SXlvGZ+QjOksKuIjDM9TDTMGSYkn8pUYHSpf
	gtZHfz2T74hcyPEPe4HT9bRE9/U0qrwnclkzo6/5AN6XZBhdHeQ+z1+RVxSTPTAw
	2tRr8Yr7K4U2lW1g8Q3QLOxtSVtcY3UMAWT6O0pTkwtJJ5YpQfISiY9yLWkJEq+N
	H4feqGwIR9KM0vvSFhse9V7w5lGfgQVhltOPFXgEDoRwf1OhzskVc+oaXSHrwkpp
	qg518K6SGW58GprkkSfhwrQR0BtkA/zQ3TUNvZgQv2GSzyPbK3Dmg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s513a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MDj7DR017066;
	Wed, 22 Oct 2025 13:46:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky0qj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MDkUST34472270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:46:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980F020043;
	Wed, 22 Oct 2025 13:46:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 835F32004D;
	Wed, 22 Oct 2025 13:46:28 +0000 (GMT)
Received: from shivang.com (unknown [9.124.221.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 13:46:28 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        kexec@lists.infradead.org
Subject: [PATCH kexec-tools 4/4] ppc64: life the dtb and initrd restriction
Date: Wed, 22 Oct 2025 19:16:09 +0530
Message-ID: <20251022134611.8921-5-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022134611.8921-1-shivangu@linux.ibm.com>
References: <20251022134611.8921-1-shivangu@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3Mn1BMSXiXlrXRRELdPYDacpObycZbnT
X-Proofpoint-GUID: 3Mn1BMSXiXlrXRRELdPYDacpObycZbnT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9JDQRu0u5SHz
 l59VIgWhk3IeXjrk1RaIfOv/9oXYH+k7dS1IfPTa0cDgZo3lrBzcFc9xGSzkWu3/enJkJ0If1bi
 Vfrle4wD2sCIYKPG4cCqLRvBzDviYplGC0REZ7SbAWyHCQBCd3wRyQ+zLqvDYCLIxPFGXI3UaSK
 P1xGwjSVZW8kO8UjsVtEgWLLYdxhjJ19WMISAGi3GM56V+QLX0gOV3lZl7j9qyglLe4l1gBaRcX
 YgfNjBsVB7OXVMeq/rwgKUDkqF/YPmwtWbMDj1ZLs4V0vWXv22T4EqLuIX69ct7MlyatN5u9nK2
 RlCYTflUbXnY09N0f0SbWs+oShUp/kMBhO3FCZna2jZ2YxizqL2KS2Dhg+JGp0wOwC9Z16OEmbb
 c7ff/xXI96/Zj6h8fD7qnzZF7Io/bA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f8e03b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=DegWWgokSwm6QpFQitMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_135111_279781_018B4761 
X-CRM114-Status: GOOD (  13.47  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The dtb and initrd restriction is now applied only when performing a
kdump.

Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
---
 kexec/arch/ppc64/kexec-elf-ppc64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kexec/arch/ppc64/kexec-elf-ppc64.c b/kexec/arch/ppc64/kexec-elf-ppc64.c
index 2084356..288ca41 100644
--- a/kexec/arch/ppc64/kexec-elf-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-ppc64.c
@@ -566,15 +566,16 @@ int elf_ppc64_load(int argc, char **argv, const char *buf, off_t len,
 	elf_rel_build_load(info, &info->rhdr, purgatory,
 				purgatory_size, 0, max_addr, 1, 0);
 
+	if (ramdisk && devicetreeblob && (info->kexec_flags & KEXEC_ON_CRASH)) {
+		fprintf(stderr,
+		"Can't use ramdisk with device tree blob input in kdump\n");
+		return -1;
+	}
+
 	/* Add a ram-disk to the current image
 	 * Note: Add the ramdisk after elf_rel_build_load
 	 */
 	if (ramdisk) {
-		if (devicetreeblob) {
-			fprintf(stderr,
-			"Can't use ramdisk with device tree blob input\n");
-			return -1;
-		}
 		seg_buf = slurp_file(ramdisk, &seg_size);
 		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
 			0, 0, max_addr, 1);
-- 
2.51.0



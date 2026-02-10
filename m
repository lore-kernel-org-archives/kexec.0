Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CD6EA3F04
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 05:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/0KmSMdJrbM1guTYKSktJmJwqU9JlptlL0MrOQduYKk=; b=4iV1mh5A9c8Kh8lEoMlFpyrdFS
	YLhoofx6huceEcqtvAd+mBdzjP8/7vK/XVeaxF101+OSxF9oPLIvZz5n4SllxwVbhLDQjRevtNXei
	muwJRxe9KgEOwh2mvc0czrVmBg0r80IpCMlnS9kFQd/4gDR6NBqykxfBQeQUXFwu1lJ7ElZ+J3BRt
	9UthF+voYrQ1riSvQ5cT9yyG2gBWm/mq6JCMiobQAaZgyoHhH1PLqgSYjNO26udLO/LfSyRf+a4k+
	/tqIqmz/lYRWra3/YfmFdf05LHV/XVTyLmQMVzIyYT5pS+Cv7B7A6LJAGb9jjxNy67gdepa187zR4
	u29WIukA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpfwN-0000000GRcB-3FyQ;
	Tue, 10 Feb 2026 05:05:35 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpfwL-0000000GRbo-3g8C
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 05:05:35 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619FikHA316694;
	Tue, 10 Feb 2026 05:05:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/0KmSMdJrbM1guTYKSktJmJwqU9JlptlL0MrOQduY
	Kk=; b=PhUan1Tk7tsNACciS5dHpO0sBoTOADcGqO10ot23Zj0bZbpjkKTblKvqx
	PoW3k5DfQcG0O4o7nd+om450nr/wZJJPQGYZPo1aJORqjHyMn7xGta4LJPXO9r4R
	N60JtLy6OVnuP7mqKv+BvnOSBoo6UmojafJMmuPpOwU0JtVMM0XLSFpuzcvrTIa+
	5+s4I4VNTCdP8egpUddij53SZ4BLYiDkrCzoZuzOW23NuGec8qCiL26l4vk3K6hG
	TnKGLJMpLJmxLhwFneJx1u664UXwv0U1MmnwP0FyCWh6MRycrzaS2TPYLjuqBy/b
	nned2ljjyIamEQqgTCIyFAHYhtZ9w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696uakx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 05:05:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A0akKe001815;
	Tue, 10 Feb 2026 05:05:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6je1yng1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 05:05:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61A55Qnu46268902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 05:05:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42A4A2004B;
	Tue, 10 Feb 2026 05:05:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A8D120040;
	Tue, 10 Feb 2026 05:05:25 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 05:05:24 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCH] ppc64: Reserve FDT memory for full elfcorehdr memory size
Date: Tue, 10 Feb 2026 10:35:36 +0530
Message-ID: <20260210050536.285923-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698abc9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ri4AaqXPZrXSIGdcjC8A:9
X-Proofpoint-ORIG-GUID: 06U7iTSesNOS2X9AgfwYG8aDZrEaO7ty
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAzNyBTYWx0ZWRfXym7nc+Dv7Yvp
 0LJfn69YVH3WDa4fsoaRnQfjQSEHFdufb/KMbQ4mK8rcJTsiLlzxEtbm/YAFTzmxd3XcTNGDFfU
 nMRMfq0mK1oKfbCYfC9npQxryZKmhY2IUHeIUHMnKhA2wpGH0JgamR4e17F7CLqGukTdm3LX7ZE
 JnHgZ2ibOkVYMlzN0RmQqOmDzfHi8B2ArquJuFJ4O99faNOALrNi3WTs815IccgH6S7n07lYmeL
 9RBQDZ+9tJEAElvGm1tIM5R5bbndwE3c+oHCq9O94JVvRKiX7PqNyZBJn51ZsfSGCyYztv87H6l
 jhygKBdA5pAczTwlUiHNCxFjt9Zb9lLsvqtk/EA3YfnQXQE855ofec5I/2q6DqADJCxkkWNomQx
 gzE6Cy6lifVk/zUzaniLFAIbYK/IWMsBGVpWhSzFE0n970tNLexaSl7cD7gPgCBpjf73VBBY3hL
 fjvZGTv0yqpE8vhQs0g==
X-Proofpoint-GUID: 06U7iTSesNOS2X9AgfwYG8aDZrEaO7ty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_210533_946654_7FF896BD 
X-CRM114-Status: GOOD (  14.86  )
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

With --hotplug support, extra memory is added to elfcorehdr kexec
segment to accommodate additional resources during memory hotplug
events. However, the FDT is not updated with the same size, which
can lead to elfcorehdr corruption in the kdump kernel.

Fix this by updating the elfcorehdr size in the FDT memory
reservation entry to use its actual memsz instead of the current
buffer size.

Fixes: b8408c95e7c0 ("powerpc/kexec_load: add hotplug support")
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kexec/arch/ppc64/crashdump-ppc64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/arch/ppc64/crashdump-ppc64.c b/kexec/arch/ppc64/crashdump-ppc64.c
index 98d439a..2816a1b 100644
--- a/kexec/arch/ppc64/crashdump-ppc64.c
+++ b/kexec/arch/ppc64/crashdump-ppc64.c
@@ -543,7 +543,7 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	/* Record the location of the elfcorehdr for hotplug handling */
 	info->elfcorehdr = elfcorehdr = add_buffer(info, tmp, sz, memsz, align,
 						   min_base, max_addr, 1);
-	reserve(elfcorehdr, sz);
+	reserve(elfcorehdr, memsz);
 	/* modify and store the cmdline in a global array. This is later
 	 * read by flatten_device_tree and modified if required
 	 */
-- 
2.52.0



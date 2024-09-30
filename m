Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEB7CE8366
	for <kexec@archiver.kernel.org>; Mon, 30 Sep 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6GDy90BowC3TaNOeckiSQ9gXxBW+jfWT8qRG4bFVmk4=; b=smud/Opd7NNJq3
	Shq5hYCfaOtp49YN8jMXWMDmU/8KdjkECZMbBVkL4y6j7st1ZqN0rkWU7LWl+fdf6PtQbq8QH4GvW
	7IF0+Vlr+3SuAK7mjMUv6jqGK/LtvUmbbm6ib+y1qNVC2fetij+G2tAeW0LPUF2Jq3vdRRJVoEsxm
	Wn++i5f6aewsYVeLojO1+9lj1W7nvOGm4e+kokScDEomyULNjyWG1RneSrk0VEgFMkPM/zqW1OK1A
	0g2FwYDmTuTwl96w2PxLwu7bGpCVpe6eLxIyDdMOWENu7EIsqt7I+fs0QiM03oXP0QPP5e0wTCknw
	DTsT1wHhZ93/FBg4rE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ3c-00000000CJo-1obB;
	Mon, 30 Sep 2024 16:15:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svJ1E-00000000Boa-2Hnt
	for kexec@lists.infradead.org;
	Mon, 30 Sep 2024 16:13:05 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEu6o3003494;
	Mon, 30 Sep 2024 16:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=tmz7x1CeIF/gb
	qVDadi0DPNCTx3Ld4sv0OrvEVTv91c=; b=dKZgij8VIHrsvjH8de9y/Bsj4jyxo
	u9oyBWgcUvdrcIo2+HbyJ79hxO1miBnRqSh2IDaBw2BGsyiItHci31BazRQAL3yn
	m+2eEOLBwVR1NjTb7v7bOeui9WieMxnJ9un/qRFa/vyoz3jDMtqblygv3IZxutQ9
	nOVWaCGH3Rcli9r3XoPtRg6KDN5jcu/7s+Md3qB2K+maRP7u2zy6ZSvLNX4mJlZw
	SmOfbvwV/4duLLHvtFanBZyb88aIpIdSImmluXVL+5Oze+nV664mkTLwZJI0Bnj7
	KW4plPQIkuqRKAnceS6PfJr2TrdfTP5QxRvWxc9BzivbJks/WMPdmNfig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwtw7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:02 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48UGD2vi025601;
	Mon, 30 Sep 2024 16:13:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9fwtw7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UEV9oQ018356;
	Mon, 30 Sep 2024 16:13:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mqfr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 16:13:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UGCxlx34210330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 16:12:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F58120043;
	Mon, 30 Sep 2024 16:12:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F9E20040;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 30 Sep 2024 16:12:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 9090CE064B; Mon, 30 Sep 2024 18:12:58 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>, Philipp Rudo <prudo@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 1/2] Submit physical address to is_phys_addr()
Date: Mon, 30 Sep 2024 18:12:57 +0200
Message-ID: <f7b3f38b610cf6fcf0236461656f6ef7fb0710c7.1727711991.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727711991.git.agordeev@linux.ibm.com>
References: <cover.1727711991.git.agordeev@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Sa0MO9t_p4WH8MFR_8vj_8Aaw4SUYSC
X-Proofpoint-GUID: jUoN0FPMGk7wddxfsFw3Cwj4dQoB3Xf5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_15,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240930_091304_608962_0357E29A 
X-CRM114-Status: GOOD (  17.11  )
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

ELF program table virtual address is submitted to is_phys_addr()
function, most likely as a leftover of replaced is_vmalloc_addr()
function. Submit the physical address instead.

This fixes the below error when CONFIG_RANDOMIZE_IDENTITY_BASE
kernel configuration option on s390 is enabled:

get_kcore_dump_loads: Can't get the correct number of PT_LOAD. Success

Fixes: 2e452d75fa78 ("[PATCH v3] Enable --mem-usage for s390x.")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 elf_info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/elf_info.c b/elf_info.c
index bc24083..7f3d053 100644
--- a/elf_info.c
+++ b/elf_info.c
@@ -765,7 +765,7 @@ int get_kcore_dump_loads(void)
 	for (i = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
 		if (p->phys_start == NOT_PADDR
-				|| !is_phys_addr(p->virt_start))
+				|| !is_phys_addr(p->phys_start))
 			continue;
 		loads++;
 	}
@@ -786,7 +786,7 @@ int get_kcore_dump_loads(void)
 	for (i = 0, j = 0; i < num_pt_loads; ++i) {
 		struct pt_load_segment *p = &pt_loads[i];
 		if (p->phys_start == NOT_PADDR
-				|| !is_phys_addr(p->virt_start))
+				|| !is_phys_addr(p->phys_start))
 			continue;
 		if (j >= loads) {
 			free(pls);
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

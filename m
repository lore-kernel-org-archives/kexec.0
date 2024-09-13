Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA35FA3755
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XEusglvtdG0TtkvC3esEw7igq857BAq7KWtf/6242Ng=; b=yPfMCesiy+qJfG
	sumAICY9fyVM1tw/Adk+7UHvi14vybzIUx6Cbb03ys55nv6opwaEF62cKj0oBpXsiDHEN/jWtoC8S
	Qpo6SQNdCiNOvjKuqYrPXv9CQVfxTrffBimbVfqimbRUXBjEk6q4/LZxYDgNhlsoPERL4GCILMtFr
	id/ugExe1dpv6sDI9V4MxykK+t5meJ6JHBpMWsGUAQtaFg8/FIsSw5pj4kyYu9u7isE5V4eCE8cZn
	A6ma6jRShAI/RfhTm6YHdSxkrgbhvoYZrogvpUjC1AKrbR81/WfnH1+I1vlnBjERrRK3/liK3PO56
	qce4MNFfnW7z1hVNWPrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7Ob-0000000GCde-1NYa;
	Fri, 13 Sep 2024 14:35:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7O6-0000000GCUA-17pV
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 14:35:07 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DDpv4c025206;
	Fri, 13 Sep 2024 14:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=IAYkytz8XSsnohTIVmspGAmLd+
	i/yw5Gg9iqMwB7CyM=; b=d6UmZjluXADBNVfoqdzzVfU24f9t6SyTs+FoGXXHB/
	/z9M6MhY0xje72b97SNYVFL/2hgo26rTIrm08F0/tPbl5DwQfsgEusUrjRTXjUo3
	mOCxwdojRG8OHikWc1nJF5xU7g1uuVY69tMpQmzhEhOFhjZMhSRphbKjgqAyMYL7
	wZEyL7rHCspeZ9Ya/0YZ42FWkGbvFMHV0Yj70qqH9hjxVOwCNaukQKncckGr6/fJ
	RmK4tcrnZu0wlqCwRh6R5fg5TtOiCODTxX4l+xaFBfHro2RogtXioLYo5TjujFIg
	AEcfA7VLD2YgslopjPH2ntvw1/u7FnjPq1qKvcMnNWXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg02caj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 14:35:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DEZ3aM015907;
	Fri, 13 Sep 2024 14:35:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41geg02cag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 14:35:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DC5K21019843;
	Fri, 13 Sep 2024 14:35:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25qeqyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 14:35:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48DEZ04E52232654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 14:35:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFFA420043;
	Fri, 13 Sep 2024 14:35:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D256920040;
	Fri, 13 Sep 2024 14:35:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Sep 2024 14:35:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 83FCDE0260; Fri, 13 Sep 2024 16:35:00 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: kexec@lists.infradead.org
Cc: Masamitsu Yamazaki <yamazaki-msmt@nec.com>,
        Kazuhito Hagio <k-hagio-ab@nec.com>, Philipp Rudo <prudo@redhat.com>
Subject: [PATCH] Submit physical address to is_phys_addr()
Date: Fri, 13 Sep 2024 16:35:00 +0200
Message-ID: <20240913143500.3615218-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y3L5m69Lbt7H2L1-FeZnrSTERn3a6p6t
X-Proofpoint-ORIG-GUID: KpIQ6S1MTUjzfx2SP9Mnjv7kSYAu9Gq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=967 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_073506_456951_E51A86DD 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

ELF program table virtual address is submitted to is_phys_addr()
function, most likely as a leftover of replaced is_vmalloc_addr()
function, as result of commit 2e452d75fa78 ("[PATCH v3] Enable
--mem-usage for s390x."). Submit the physical address instead.

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

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FFAE7717F
	for <kexec@archiver.kernel.org>; Tue, 17 Dec 2024 06:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WH86RupiIpV7nQbN+Vsb8WGy3K790/g1ula/5WgtslI=; b=c2q67X7UdaaWWVZ4mT+D7gkxfy
	m8PJf4x/3qrNOuxUPfAfclbiMGjOKlSb+tQnv8WzHiRea+DEAA7MDuBc4wDfuxZXQUdUdb7y69Wzc
	c5NjBtu5g3WiuPa3cUxbEvwB64ANNmWYS6Fx41ILgCW8kcxkOLuKG4mPgbz2faSvMl9g64FVgEbLJ
	B/COL4jnJ2VUQ/ONCScq6KurC5jKxwpB3uI+4P6uMGP8RWO7stKUKAon6lYa0dqg3FWFu/Es788aU
	HIYCbF0AlT39P73JDjp4e7XuZrJAwvPPmGZ+/4uc1MVSplSUdhrAvYRrhBzEeXGc8fJ5In9RAvWak
	lDW4COWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNRXp-0000000CVFU-3e1y;
	Tue, 17 Dec 2024 06:59:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNRMH-0000000CSiM-46SI
	for kexec@lists.infradead.org;
	Tue, 17 Dec 2024 06:47:07 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3qbCL023635;
	Tue, 17 Dec 2024 06:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WH86RupiIpV7nQbN+
	Vsb8WGy3K790/g1ula/5WgtslI=; b=KvkAYa2WWMKIrp0md1cyAHmJtwwJ2CWfG
	pj3M+DAXOTAlLtFyWCTsV5OpjOrreJFZ46LWUlowGJnnLVlXQqxuxWY/w+/OQW55
	j19/1YcxG7A+7ZsDievjeH278CmJKvKhmxFGWDk8RdT0EG0TveMvvyBYZ09tNlcq
	d5eu7lV+xVwq2oHmy+Wd/VKuXrWh6bMTkKsVxBEPl7vkP3UMcLYhEL/0b/Jrt6Pe
	2T3nnWnCYcdTuI0Md6Wh6hH4gYhGXGQBCYpOd07AyiEfVMqIR9QrIoISQZivb3rH
	auGUT18D6gJv5avDiLrYJ7PQGCAh0U15FRmQ6Hr9wOQUGGTIkTf4Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43k1sb0jcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BH3tGGH011271;
	Tue, 17 Dec 2024 06:46:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjk1bwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 06:46:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BH6krCZ26149512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 06:46:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAB8A2004B;
	Tue, 17 Dec 2024 06:46:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E164C20040;
	Tue, 17 Dec 2024 06:46:50 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.29.128])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 06:46:50 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] powerpc/kdump: preserve user-specified memory limit
Date: Tue, 17 Dec 2024 12:16:11 +0530
Message-ID: <20241217064613.1042866-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
References: <20241217064613.1042866-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Np-xWnIy8W1mKryoou7nF-12SVirY23I
X-Proofpoint-ORIG-GUID: Np-xWnIy8W1mKryoou7nF-12SVirY23I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_224706_020820_61B73A02 
X-CRM114-Status: GOOD (  13.98  )
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

Commit 59d58189f3d9 ("crash: fix crash memory reserve exceed system
memory bug") fails crashkernel parsing if the crash size is found to be
higher than system RAM, which makes the memory_limit adjustment code
ineffective due to an early exit from reserve_crashkernel().

Regardless lets not violated the user-specified memory limit by
adjusting it. Remove this adjustment to ensure all reservations stay
within the limit. Commit f94f5ac07983 ("powerpc/fadump: Don't update
the user-specified memory limit") did the same for fadump.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kexec/core.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index b8333a49ea5d..4945b33322ae 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -150,14 +150,6 @@ void __init reserve_crashkernel(void)
 		return;
 	}
 
-	/* Crash kernel trumps memory limit */
-	if (memory_limit && memory_limit <= crashk_res.end) {
-		memory_limit = crashk_res.end + 1;
-		total_mem_sz = memory_limit;
-		printk("Adjusted memory limit for crashkernel, now 0x%llx\n",
-		       memory_limit);
-	}
-
 	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
 			"for crashkernel (System RAM: %ldMB)\n",
 			(unsigned long)(crash_size >> 20),
-- 
2.47.1



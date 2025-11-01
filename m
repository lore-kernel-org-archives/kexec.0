Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCC9CCFA02
	for <kexec@archiver.kernel.org>; Sat,  1 Nov 2025 19:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n7noBi6+FXl1r4Ffe3YufTyb4NpkxmUZpvnxTho9vbs=; b=jsGGnoVT3/hn02arFIizYhiBM3
	adVYE55lP3vyB51FlC7p8TIL5zlcs/qYj2BPID5Oa88HUcoLQfsN8yzuK4ftFUcwj7oTWPeynSunI
	KzUt28chWXisv8KPt1XWejICbeJxJL1tHKWQqop27gmJqJPBRSzRmoHftYBN2tfO6dO967LYi9iPG
	Mdr7AfWajkVBrBsCLs7DoixbG6bjkyDwNjJmFl2EkEg5Kq1gT0z3b9tWOi45dZhFWpuOP7WfaprhF
	ZaWX0QV+mwrUEaUlh4CDihygzOrABy3zAjmcV9xKDDTUbotR67rlpcEGKa7GtRnZZ/OmmejWoZ6s2
	TmAJvnWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFHQV-0000000838h-3okQ;
	Sat, 01 Nov 2025 19:38:15 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFHQT-0000000838I-1Epf
	for kexec@lists.infradead.org;
	Sat, 01 Nov 2025 19:38:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1EiGov009566;
	Sat, 1 Nov 2025 19:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n7noBi6+FXl1r4Ffe3YufTyb4NpkxmUZpvnxTho9v
	bs=; b=D0HbcYS4nMb/QAeI2oZowCx3Ff+Np3qS7X8w2F8oyIQSGu+0Yga17r2CN
	E59jlE3fxyIVvZ/OPT8K63KMbXlpEAMSnp9MMDhRlOsyMegH7cpVxC2uTJQjl+9O
	lqSgDqqzOrkytXztI5En1O3nsMSlxJNjOwc6P8C66BI1KPEGZFNlXsodH/Wjyxgk
	cnHsvoVHKk7DpwejGwuumoNvrFipzTNFT8MXnx0Kzcv4YBsCEXORRmPlzRmpv6Jh
	ZFD56LUiI1oC6vkA/OxUTil3dPArX26mOWmQKS4xbLc4m9v9JhzpNxvZdxaeaPY/
	6y8Z8iL6XP78PUkRleWXayyjhGojw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mkhvxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 19:37:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A1HjVLC018796;
	Sat, 1 Nov 2025 19:37:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwupke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Nov 2025 19:37:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A1Jbu4L18743702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Nov 2025 19:37:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7323020043;
	Sat,  1 Nov 2025 19:37:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1BEF20040;
	Sat,  1 Nov 2025 19:37:54 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.39.30.101])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Nov 2025 19:37:54 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, kexec@lists.infradead.org
Subject: [PATCH] crash: fix crashkernel resource shrink
Date: Sun,  2 Nov 2025 01:07:41 +0530
Message-ID: <20251101193741.289252-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kMXoSIs9mW8II7IHhqD7Wz4vDw2X9ynF
X-Proofpoint-GUID: kMXoSIs9mW8II7IHhqD7Wz4vDw2X9ynF
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=69066197 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=i0EeH86SAAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8 a=JIB6K9Ufr1_efp9ICtEA:9
 a=HkZW87K1Qel5hWWM3VKY:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfXz8yTfRld4vT7
 fPN6MoGKQ59o0fTLfDxoQF1E15M7wyXtuTCatfX25+eaRRyJGiLWcdOdDiV9Wx2FdXXeAOIZoaH
 7LmNIFpxIpFBEWVE/QzlSFCI5QEAHjmTt6uK0poF79MfMuAO9sr7/o155B//EyRY19VBSNrKcoQ
 EmOCpQZJ3MS5phLG8Mnh3OBEt7UgpJlXzOvbQBDR1UjuQcC0d6dFT8VdQx64AnUGVUl2LiLbXyQ
 r9173XaJTKDXh3bHhJO9GY/Ft2gfXSfc568vcvuueZO30cY+82TvHMxjnHdbJjrISJ3XWsW5LGa
 v1S/DIp37Bcb3MUPNXcfJne67lNLIOUvw2qMfIuWbsa0FXcfRdT3Zd755gdAQWLxIw+SNEk2bGG
 R1pTk2tvwSPGv8PKKF8srizmDRhudQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_123813_820175_E3111241 
X-CRM114-Status: GOOD (  16.82  )
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

When crashkernel is configured with a high reservation, shrinking its
value below the low crashkernel reservation causes two issues:

1. Invalid crashkernel resource objects
2. Kernel crash if crashkernel shrinking is done twice

For example, with crashkernel=200M,high, the kernel reserves 200MB of
high memory and some default low memory (say 256MB). The reservation
appears as:

cat /proc/iomem | grep -i crash
af000000-beffffff : Crash kernel
433000000-43f7fffff : Crash kernel

If crashkernel is then shrunk to 50MB (echo 52428800 >
/sys/kernel/kexec_crash_size), /proc/iomem still shows 256MB reserved:
af000000-beffffff : Crash kernel

Instead, it should show 50MB:
af000000-b21fffff : Crash kernel

Further shrinking crashkernel to 40MB causes a kernel crash with the
following trace (x86):

BUG: kernel NULL pointer dereference, address: 0000000000000038
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
<snip...>
Call Trace: <TASK>
? __die_body.cold+0x19/0x27
? page_fault_oops+0x15a/0x2f0
? search_module_extables+0x19/0x60
? search_bpf_extables+0x5f/0x80
? exc_page_fault+0x7e/0x180
? asm_exc_page_fault+0x26/0x30
? __release_resource+0xd/0xb0
release_resource+0x26/0x40
__crash_shrink_memory+0xe5/0x110
crash_shrink_memory+0x12a/0x190
kexec_crash_size_store+0x41/0x80
kernfs_fop_write_iter+0x141/0x1f0
vfs_write+0x294/0x460
ksys_write+0x6d/0xf0
<snip...>

This happens because __crash_shrink_memory()/kernel/crash_core.c
incorrectly updates the crashk_res resource object even when
crashk_low_res should be updated.

Fix this by ensuring the correct crashkernel resource object is updated
when shrinking crashkernel memory.

Fixes: 16c6006af4d4 ("kexec: enable kexec_crash_size to support two crash kernel regions")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 kernel/crash_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3b1c43382eec..99dac1aa972a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -373,7 +373,7 @@ static int __crash_shrink_memory(struct resource *old_res,
 		old_res->start = 0;
 		old_res->end   = 0;
 	} else {
-		crashk_res.end = ram_res->start - 1;
+		old_res->end = ram_res->start - 1;
 	}
 
 	crash_free_reserved_phys_range(ram_res->start, ram_res->end);
-- 
2.51.0



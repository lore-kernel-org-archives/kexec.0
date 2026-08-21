Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8713CC5DF7D
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6i/yP0REzn9lxzfgjUg8E32OU9DLi22+hqLzFLTzx0E=; b=uRL704Ulg5qKOsctMXwP3dE0gX
	IZieLW+d24MYKZmUQy13rJjP8B19WWoHZPrw+13TbjxY2YdpVTB/f/qIclURwJzQhbwkfzBmDCQDY
	LKnFlqBaztFP1X+ivKl9b5B8VCYP4UqCKiy7IO1g9vqxBVTRNblRTlk0uwo0H2UAUNkLFbPcP6cG7
	tatkgqK3artIyMbP6kZG2v4420qGQ+2OUCM5NC7LeG0ALJ6te+2IdI81PhXaU8HzxLXmR/Ca/lbSt
	QPYhwF1Ho5FS9PGr5jjTeCnYmPPr6fyHeulVPHCVlvkbDSR2zUMViwkzpA+s3S4sa+cxyYERlv2tu
	3Xhagg8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMvk-0000000D8C3-19nA;
	Fri, 21 Aug 2026 10:57:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMvh-0000000D8AS-2na0
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:56:58 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9WMWK999043;
	Fri, 21 Aug 2026 10:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6i/yP0REzn9lxzfgj
	Ug8E32OU9DLi22+hqLzFLTzx0E=; b=MZwxm+mmKXVrro0yW8sAs8T4RtNTa645z
	kjJjwnqs6NN3y7C6lPafolpkhNxJ19fvtLg7GR03xnyF8QPmAftkMAehZsiCiVlx
	dHm6L+OaEg1b2BPWIvPzFLi7QG/ewhw7NzEG5b5srwt2MPvUZyUD7NlpkqOQpkEA
	ydJRgty8MFuRS25zehiuNtDjuef5MdUbkBECoLekOiyYv44ZNf6+9mOadKrJjZGo
	eyJ929FUvvw+3YChf6fHlwCYycP3WDqDL7IVnb0iUg7DW6BmpJS+lZoBvrLd1p9m
	aFwUVFdqv2nPFOHegMHAEpZVI8T1PExafDFTlZDdutRJlb/DvqxvQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4grcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuI2e016376;
	Fri, 21 Aug 2026 10:56:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32twm80j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAucC041746876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E0EB2004D;
	Fri, 21 Aug 2026 10:56:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F1BC20040;
	Fri, 21 Aug 2026 10:56:34 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:34 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>, Alexander Graf <graf@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] powerpc/kho: exclude THP and HUGETLB_PAGE
Date: Fri, 21 Aug 2026 16:26:09 +0530
Message-ID: <20260821105609.983622-4-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfXxkbwyTThBDwg
 NELZnbNGcBIRpd43ywTbq7bJoKupsXLuf24EJdwZ7bSWUnLbl0XqUQEpeWNAr+ylQ5gBjbkzhSk
 KQXOVafoaF6lOSve1zqO7wXyO34+CWs=
X-Proofpoint-GUID: 65iMWXvBDsxap-MDVq5bzcbcYcilH6Y0
X-Proofpoint-ORIG-GUID: kgXdKGWl4OgHoqZlAvytwn-D23Jv81Up
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a882eeb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=T6IRowXMNMGVb2OzyiIA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX7Ej3/twDiIg8
 xeqJ5OqfWnZMEeU/3ebf2BDeSNvYv4dyKtNbiUNMcLo1niBn1GYmmpbN30vqecweFOa7jZk2J4d
 fOskWSGhm1hpwUVYkL0Uhz9nWHsMsADvtEk0+YxfHTSax4VUjdR99nt2Sg0UGIAr2+odm5j7Xi3
 r9Eo2hU8KChIFqVKE0WpZD6ljRX5E4Hw7hy/c4/c8LjDwEeZt+fvEaKaMWHN2h45MVh6QiJUvja
 wywQBCbdFTgqCeWW6J8R4fPa7VHMTSxF96iVPqWcUD5TlQQNjcwzkHEBOQtR7zo8fQAXICx+U1T
 O0kY9Ola9kJ++SLZdYbiAcPAJGZEN4zySdUUS9leNc57MN4Jzp+wVYXTVbTAjsLrwKRDcm9y9RX
 xyoSKClhhQ4KfMD7K838Pw43+izBzqnxG8S7MP0qgcn/P4nzcdpb3FyfN52YLg36VLB9Co2yrYA
 c3iHGF/Bt7SYUsutV6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_035657_821603_E5D1C601 
X-CRM114-Status: GOOD (  16.07  )
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

Enabling CONFIG_KEXEC_HANDOVER together with CONFIG_TRANSPARENT_HUGEPAGE
or CONFIG_HUGETLB_PAGE on powerpc fails to build:

    kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
       49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
    ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
       80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
          |                                                        ^~~~
    kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
       49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);

CMA_MIN_ALIGNMENT_BYTES is derived from pageblock_order, which on
powerpc is not a compile-time constant when THP or HUGETLB_PAGE is
enabled -- powerpc can determine huge page size at runtime in that
configuration, so pageblock_order becomes a variable rather than a
constant expression. KHO's static_assert() on
SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES then fails to
compile, since it requires both sides to be constant expressions.

Until CMA_MIN_ALIGNMENT_BYTES (or KHO's use of it) is made to handle
the non-constant pageblock_order case on powerpc, exclude
TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from ARCH_SUPPORTS_KEXEC_HANDOVER
so the two can't be enabled together and hit this build failure.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 61350d3e7a19..f68b9fc883ba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -720,6 +720,7 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
 	def_bool y
 	depends on PPC64
 	depends on !CRASH_DUMP
+	depends on !TRANSPARENT_HUGEPAGE && !HUGETLB_PAGE
 
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
-- 
2.55.0



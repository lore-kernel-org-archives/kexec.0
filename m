Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AE1C5DF89
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 10:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+5biXI7Kp2tZqvlD1mk5h8DKWfP6jawz3pU35R20vGg=; b=Pj+lmUD4zYTjK02z6PgLmmynYb
	HSjsf4TPvUYTJ5zo90d5Q3YVwWeS81/Z9HSgTOT5N226WESPjMBof3PiTnx4EnB6ta75ZD5sE6Dac
	IeTGdK4SobMYYDmngqFEc3vILnhcv6oeXuUCoMsr4LwPIY9VbzHIdi04X/R34Q8ThQlpCap3xy5Qj
	DM7uJzRdbUUHa/JojaB23Ci8tOCZIolqLGGFaY5DAUyiA7aFC9DwHq/1hg5CrifCB4+0Hv3qU2/xm
	OCaC9aq3zzX+omVBzpcEuGW5FVws5z8/q02PD4dvp/oSR10y6rW+unemNTP67vBCwRnEj7pvQccc8
	41CvbEXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMvh-0000000D8AH-0MVj;
	Fri, 21 Aug 2026 10:56:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxMvd-0000000D89A-0UP3
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 10:56:55 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9VfX91131344;
	Fri, 21 Aug 2026 10:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+5biXI7Kp2tZqvlD1mk5h8DKWfP6jawz3pU35R20v
	Gg=; b=ERGb5wZHQKYnG/NUbGXWpdRYfmHHpEu/i7yZNNr395w74jxd49EbREaua
	X45MXPcNoa5/2kdj3EIu35mowKlmH7/15XP6BK4i+xBmQMwg7N7Xdl7YJgzwvGiF
	2VgHJ2uknk3CEWfmjKSlog2cYmSbru0EeDQI/Ik38IYzcRy3gY7nre5/A9FK2mlW
	4c10wlihFshk9780DlPOlG5S2LbL7vR5JiDfwhGbXHLR9s0fWIQmBgau1FZCqF9V
	bRB9fZNIMb7El0tKJg6XkfgRd5FC+UOf6cDENr06XzWWJvIVi57eCGkmqabDdKUj
	YJZ3pbrpUPWcObchf8frbd73GiDSg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4gne1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LAuOXC009426;
	Fri, 21 Aug 2026 10:56:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhm4p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:56:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LAuMHn39518718
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 10:56:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E4352004D;
	Fri, 21 Aug 2026 10:56:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA7220040;
	Fri, 21 Aug 2026 10:56:18 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.bl1-in.ibm.com (unknown [9.123.14.142])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 10:56:18 +0000 (GMT)
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
Subject: [RFC PATCH 0/3] powerpc: initial support for Kexec HandOver (KHO)
Date: Fri, 21 Aug 2026 16:26:06 +0530
Message-ID: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a882edb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vggBfdFIAAAA:8 a=Z4Rwk6OoAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=7ipKWUHlAAAA:8 a=JfrnYn6hAAAA:8
 a=itPyUPzOZQCiFHcQqVsA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=gpc5p9EgBqZVLdJeV_V1:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: tBgUdosthgsI5jkqkI59kDQIsTYp6i8S
X-Proofpoint-GUID: kYZIQBmvG2oGwz1yYgI-96BusQj3Yuzy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX5+DmDqg9LvvX
 lT6QS5/Ud5155aFWHfylCLDeWHFdHAi0i7zSayZYF0ygMAEKMK9iv511FiIlsIep0xd6K2yNDI/
 ZBjpkD31gOYUhDrPzoAvInfXZuaRUPU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX5RvJ/H9s3RmN
 GbTxMJX/2kqIh+84r5Zxx17qqnTSj4iXSPwSbXhC0WproFwHOr+A56AGcqJ7K/xGsTgu1JOi2nv
 1BDjVUXhA0ApEp0MIcC5XdiOQbN0f93WjxsBzLRHt2MHDT/e9ZTqOcCjAeyptjpv5IlBC2rVzOo
 bhoSOW3+Z+vhty2GA3jQ2jLzWt9W5eb5DBA9eAI/9BzrJh4v3smM8l6KspN6rEJnvxvnmXxalwi
 jQ4CXo118VEBq/CProbt0sCTvQ4qkfzfJ5Q+mPGlPJKnl8GBhqnoZ46DQtqmmE9yi82anL7pADT
 Uzkvtxa98QEFrbA0cxFAm5rSNgUn/V3eNWfg/wIvI9aCycSuBs1PNbAYMK17wcWIm652KpV0KyT
 bjTEmrx3oY31V4hycV+3RPeFBzejOTTBiBRPOV3BMFAxIFqNm8iMZ3ywKIukznwq5nx3aUdGXUm
 M4P0x4Ey2wEWTcVBQBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_035653_290672_ACC90558 
X-CRM114-Status: GOOD (  18.81  )
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

This series adds initial powerpc support for Kexec HandOver (KHO),
allowing state to be preserved across kexec on powerpc. Posting as RFC
because some of the patches are workarounds for issues I ran into, and
I'd like input on how best to address them.

Patch 1 is a small Kconfig fix needed to unblock patch 2. It won't be
needed once the ordering problem described under patch 2 is
addressed properly.

Patch 2 wires up ARCH_SUPPORTS_KEXEC_HANDOVER and adds the code to
retrieve the KHO FDT and scratch region from /chosen on boot. On
powerpc, crashkernel memory is reserved very early, from arch-specific
code, while KHO's scratch region is reserved later, from generic code
(kho_memory_init()). Crashkernel reservation always runs first, so by
the time KHO reserves its scratch region, not enough memory is left
and the reservation fails. Until scratch reservation can be moved
ahead of crashkernel reservation, this patch makes KHO and CRASH_DUMP
mutually exclusive on powerpc as a stopgap. The failure scenario and
the reasoning behind this restriction are described in the commit
message with an example.

Patch 3 excludes TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from
ARCH_SUPPORTS_KEXEC_HANDOVER, since KHO's static_assert() on
SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES fails to build
when either is enabled -- pageblock_order isn't a compile-time
constant on powerpc in that configuration.

With all three patches applied, CONFIG_TEST_KEXEC_HANDOVER passes on
powerpc.

Open questions I'd appreciate feedback on:

 - How should KHO scratch reservation and powerpc's crashkernel
   reservation be ordered so both can be enabled together, given that
   scratch reservation currently happens in generic code
   (kho_memory_init())?

- Excluding THP/HUGETLB_PAGE is a workaround for the build failure.
  Looking for input on how to handle CMA_MIN_ALIGNMENT_BYTES when
  pageblock_order is non-constant.

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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Sourabh Jain (3):
  kernel/liveupdate: make KEXEC_HANDOVER depend on KEXEC_FILE instead of
    selecting it
  powerpc: add support for Kexec HandOver (KHO)
  powerpc/kho: exclude THP and HUGETLB_PAGE

 arch/powerpc/Kconfig               |  6 ++++++
 arch/powerpc/kernel/setup-common.c | 33 ++++++++++++++++++++++++++++++
 kernel/liveupdate/Kconfig          |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

-- 
2.55.0



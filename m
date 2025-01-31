Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C2CC0218F
	for <kexec@archiver.kernel.org>; Fri, 31 Jan 2025 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9ccUDYc1EcHDH2NmxewPM72NWsh2GLRbN3XP7uqVYz4=; b=4LURc/cbIyApxUXZIBzYCzocVS
	AI6EF6yWPOskBYXDw3K4rUQ2iQD6k07bV12B11qDSLU6CzmpcEmTWQH0fvyxSwHKFYMN92q1LtMqH
	5jZIT5kJqNmTtbIjgKtE4ucKbiJXt1wMCR4rfdSLNKEqSPuskjM8+pTHSDUnAroqG5kvYvnw9MMv8
	lnDmyzk+gKS4dw13obd1a4M7Uhrpq6hbTiMuTslt9NbAJE19Yl85UUkhQu6J3lfL6w+9ACP+gYZFg
	Ff5M6BSj6HekLgfjaH2UUra9FFxhpXu9S0QKLs3qKASVSpG8sWR1qal3RSgy2Zgz7c61QQSHe6PkD
	fFGAyOXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdq5i-0000000AbHZ-1J3B;
	Fri, 31 Jan 2025 12:25:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdq5f-0000000AbGm-2qel
	for kexec@lists.infradead.org;
	Fri, 31 Jan 2025 12:25:44 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OJkW016476;
	Fri, 31 Jan 2025 12:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9ccUDYc1EcHDH2NmxewPM72NWsh2GLRbN3XP7uqVY
	z4=; b=mibX7pezBgydwGC9klaT6XtbjGxjTRnUifweGaIlRaq8N2Utgw6kzIIeu
	Wz9aU/SaN4b8tNyv6boj11TDEk+NWbj9ck//AZ9Oge2mvey8uFSbmGHHlz8k4Ju/
	wima7q3AhAzk0pA4I5q3nU58FPIrsBnU/w2h5In+ys38YXK2MFZlzIOeajTBvvfz
	bSYVtuuTPW+g8IyuE+3aSxaVzGH4laW2JRWjVb9h4wfgnqUYBr87CGSUUj8PmzZ6
	Ct2hkRhHPx1nIKKxBum+CJqz/deMFW+EPiluEp7w80oZzBYVbK5juGupwVXGEWZK
	Vm/4X3nfOf+KwxP1VsPi27XPB909g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk92css-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 12:25:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50VCAvcP017237;
	Fri, 31 Jan 2025 12:25:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfaybgwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 12:25:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VCPWuO35193348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 12:25:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A1EE200F6;
	Fri, 31 Jan 2025 11:38:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 881FF200F0;
	Fri, 31 Jan 2025 11:38:33 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.16.21])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 11:38:33 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/7] powerpc/crash: use generic crashkernel reservation
Date: Fri, 31 Jan 2025 17:08:23 +0530
Message-ID: <20250131113830.925179-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IpMBxVikNIkI1ge4T6Sppr_sgL2rkU2_
X-Proofpoint-ORIG-GUID: IpMBxVikNIkI1ge4T6Sppr_sgL2rkU2_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_042543_721962_39276968 
X-CRM114-Status: GOOD (  19.01  )
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

Commit 0ab97169aa05 ("crash_core: add generic function to do
reservation") added a generic function to reserve crashkernel memory.
So let's use the same function on powerpc and remove the
architecture-specific code that essentially does the same thing.

The generic crashkernel reservation also provides a way to split the
crashkernel reservation into high and low memory reservations, which can
be enabled for powerpc in the future.

Additionally move powerpc to use generic APIs to locate memory hole for
kexec segments while loading kdump kernel.

Patch series summary:
=====================
Patch 1-3: generic changes
Patch 4-7: powerpc changes

Changelog:

v1:
 https://lore.kernel.org/all/20241217064613.1042866-1-sourabhjain@linux.ibm.com/

v1 Resend:
 https://lore.kernel.org/all/20250108101458.406806-1-sourabhjain@linux.ibm.com/
 - Rebased on top of 6.13-rc6

v2:
 https://lore.kernel.org/all/20250121115442.1278458-1-sourabhjain@linux.ibm.com/
 - 01/06 new patch, fixes a bug with ELF load address
   It was posted in community as individual path but
   since it align with this patch series so include here:
   https://lore.kernel.org/all/20241210091314.185785-1-sourabhjain@linux.ibm.com/
 - Fixed a typo 06/06

 - Added Acked-by and Reviewed-by tags

 - Rebased it on 6.13

 - It was suggested to try HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY and
   see if 03/06 patch can be avoided:
   https://lore.kernel.org/all/Z35gnO2N%2FLFt1E7E@MiWiFi-R3L-srv/
   But after adding HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY the issue
   persisted and kernel prints below logs on boot:
   ...snip ...

v3:
 - Split the patch that adds the arch hook to handle special regions in
   crashkernel reserved: Now 03/07 and 04/07.

 - Dropped the patch that adds arch hooks to skip `Crash Kernel` from
   iomem_resource (/proc/iomem). Instead, a patch is added to include
   both `System RAM` and `Crash Kernel` memory ranges in iomem_resource: 06/07.

 - Rearranged the patches to ensure that generic patches come first,
   followed by PowerPC-specific patches.

 - Added Acked-by tags.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: sourabhjain@linux.ibm.com

Sourabh Jain (7):
  kexec: Initialize ELF lowest address to ULONG_MAX
  crash: remove an unused argument from reserve_crashkernel_generic()
  crash: Let arch decide usable memory range in reserved area
  powerpc/crash: Use generic APIs to locate memory hole for kdump
  powerpc/crash: preserve user-specified memory limit
  powerpc: insert System RAM resource to prevent crashkernel conflict
  powerpc/crash: use generic crashkernel reservation

 arch/arm64/mm/init.c                     |   6 +-
 arch/loongarch/kernel/setup.c            |   5 +-
 arch/powerpc/Kconfig                     |   3 +
 arch/powerpc/include/asm/crash_reserve.h |   8 +
 arch/powerpc/include/asm/kexec.h         |  10 +-
 arch/powerpc/kernel/prom.c               |   2 +-
 arch/powerpc/kexec/core.c                |  96 ++++-----
 arch/powerpc/kexec/file_load_64.c        | 259 +----------------------
 arch/powerpc/mm/mem.c                    |   2 +-
 arch/riscv/mm/init.c                     |   6 +-
 arch/x86/kernel/setup.c                  |   6 +-
 include/linux/crash_reserve.h            |  11 +-
 include/linux/kexec.h                    |   9 +
 kernel/crash_reserve.c                   |   9 +-
 kernel/kexec_elf.c                       |   2 +-
 kernel/kexec_file.c                      |  12 ++
 16 files changed, 105 insertions(+), 341 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crash_reserve.h

-- 
2.48.1



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582C5E77199
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W1r5waazukROmJZjcrfHhKFG3R48sy2zH19SxlSm3AU=; b=HqJttpoqcj7Q5xmVEDd5pQvk8w
	+S53tgvkJN1F9yPTrRmt7CZaMGeBbDnpGSzrB5hK24pqHbL2qU5v1JWjZveKniVsBJCS613RT1p/S
	a8TVUI8Sg8Kvk8yPz1QUmwOkDSQFjiPab0+RaosO91rA2LolEMdvx7aanPuOnOcx3yC4xCamgfCln
	ddQuOC3/Z16+Aum815i7QrvVeibDFXpXF9jm1staD9QIvqa1He/ZMu9x6x9BYts3t1ge54AU3GeEI
	7kquYjmyzsP3IAZZK7xxUvcGftuAIFSJWC4HL/fJFWbTsZDl0wAcyNhX8pbVYGiD9cfJdcvwfcems
	rYeKaPww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTCz-00000007xzR-43Fg;
	Wed, 08 Jan 2025 10:22:41 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVT5p-00000007wHn-0Rm1
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 10:15:18 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50886LaD023325;
	Wed, 8 Jan 2025 10:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=W1r5waazukROmJZjcrfHhKFG3R48sy2zH19SxlSm3
	AU=; b=gReSIrIq+z5lVt/iY4+pfDVy0s+e0bjkqYMUTuo5zcFm/D7W+PjX94TvH
	tVGErjDoKEAcoHqAxcOmmv+jxM/4a1CQQteTtYEyZt/NEUNxZw2/M/salt/EfxyE
	lp+uuvws4DytDInHwYEmAvU0Mv8klnIVnQi7+IfJAoxb5U13w+3Nh74JiQCXWiU7
	16vxmp0Hu1mv2Y1D/FWZRVXMF1UsPk2EjfkdH62uwFesWw1t5M61HD7DE82L5C8Z
	ucv+QfVVDlu9Gwrh/4Z/kNwfYLNgWxsoxI8O2Dx1KsuRoEWu6ik0E0honr714J2P
	ItGBM+oBHcKvIDjHw83uvUM9DBamQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441nj38ksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:15:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5089gP05015809;
	Wed, 8 Jan 2025 10:15:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtky3vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 10:15:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508AF34135652148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 10:15:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E4E20063;
	Wed,  8 Jan 2025 10:15:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA57720065;
	Wed,  8 Jan 2025 10:15:01 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.94])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 10:15:01 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 0/5] powerpc/crash: use generic crashkernel reservation
Date: Wed,  8 Jan 2025 15:44:53 +0530
Message-ID: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: llUUr_k1JdtpQE9XB-6rXzYJ6Mvq2QNm
X-Proofpoint-GUID: llUUr_k1JdtpQE9XB-6rXzYJ6Mvq2QNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=926 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_021517_262305_CE8B467B 
X-CRM114-Status: GOOD (  14.30  )
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
Patch 1-2: generic changes
Patch 3-4: powerpc changes
Patch 5:   generic + powerpc changes

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: sourabhjain@linux.ibm.com

Changelog:

v1 Resend:
 - Rebased on top of 6.13-rc6

Sourabh Jain (5):
  crash: remove an unused argument from reserve_crashkernel_generic()
  crash: let arch decide crash memory export to iomem_resource
  powerpc/kdump: preserve user-specified memory limit
  powerpc/crash: use generic crashkernel reservation
  crash: option to let arch decide mem range is usable

 arch/arm64/mm/init.c                     |   6 +-
 arch/loongarch/kernel/setup.c            |   5 +-
 arch/powerpc/Kconfig                     |   3 +
 arch/powerpc/include/asm/crash_reserve.h |  18 ++
 arch/powerpc/include/asm/kexec.h         |  10 +-
 arch/powerpc/kernel/prom.c               |   2 +-
 arch/powerpc/kexec/core.c                |  96 ++++-----
 arch/powerpc/kexec/file_load_64.c        | 259 +----------------------
 arch/riscv/mm/init.c                     |   6 +-
 arch/x86/kernel/setup.c                  |   6 +-
 include/linux/crash_reserve.h            |  22 +-
 include/linux/kexec.h                    |   9 +
 kernel/crash_reserve.c                   |  12 +-
 kernel/kexec_file.c                      |  12 ++
 14 files changed, 127 insertions(+), 339 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crash_reserve.h

-- 
2.47.1



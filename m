Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDAACCD1AB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 13:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZUJginNUg7KtvIf3qZwX/wJ8u2AJkf3IYYGL71zvJ2o=; b=vfhaff+1lJvTVGtwIXStdxuhqr
	De4h+mDldGrLwz5L/sy2WrhpK657n0tx2ZfnhHyWFrQ/qdLqA3G6xSxnhEKxdECUtSd7/MYOaDzeM
	1Ige0tVxUYf9raUCd5m0hSXWuzrt1Ykh0HigChFqunuQs3G1KbzoOvcickJTWVMp89Lr4Ck0PFCUO
	hgMVAzcPER7V3IHqEW41VEVsVAXPBeaztVfRm1dJvhj9qMSUME3NxlfQ9laCwH4XgKUvCLFgES7l3
	FlLs8tcwplhHzke7EXeTpgV5N4yjSQRLRLCTal9fW/fghXLVzufy5U7lGcHU0odCNcs10qjkwbJYe
	xL9oAh6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAg-000000034fm-1Y2Z;
	Wed, 22 Oct 2025 13:46:34 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZAe-000000034fB-0NXD
	for kexec@bombadil.infradead.org;
	Wed, 22 Oct 2025 13:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ZUJginNUg7KtvIf3qZwX/wJ8u2AJkf3IYYGL71zvJ2o=; b=BrioeVSYVUmC3Gp/w29qq+rRMU
	Qgj7F7L+1qhzIv8JxYgMqoJmXpc0HyMIjGZ8W/MWiMRNeNAE4BDhehTvc3+NUN9vHAmB6vonVpNA3
	jWh0E0xVc1n8EyUX6Mze1rwi8vCvRt4S1rGLCWUjnRLi4We7SmvAavbiiKLW/yF1tPEY5QTnaypix
	85nz1DI1WXI1m/MXsXjF+LztojTA5LIdMxFcG30zT4Qhd7Q0/c+X6inIVeK6czs7iiR7TFlHYcayK
	2tdspNdAHPEZArHF3DhY4bYO6TpPb5sHX3YG/VBYuxXJ93SaoFXmcGNFTec3Dy/SMirGbSeCX3DVJ
	LGN+SwVQ==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBYIu-00000000bBT-3YgF
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 12:51:02 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M5M6Qe011773;
	Wed, 22 Oct 2025 13:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ZUJginNUg7KtvIf3qZwX/wJ8u2AJ
	kf3IYYGL71zvJ2o=; b=eek1LE5ITgRmy26ib8UukCegoVjMLkH36OT5z/3e7zCE
	DFBpnCJTscbfEGU2DPy8lweo45edBkURdUDP/OTopEpOMKc7/QM8rXVBFO9wtztq
	03LWDGBFAp3iCxTsRlEj2ORfkhYsz7UrijAdhhIvoTyMEBfMilQt/PBersLbpYsP
	uTYnp8f2/f5zubxji3SO9rOgNw75bK4odkT/ARxQSyRs4FoD/5JWOWwGr7hLMrxh
	+rhSSChMsbtrN5Q9D/Nnyv4xpKBthlM5tJySgWsBjlm0IeSrBgdOmSE6QTiN742s
	+8jf3qQTgU3d3F3XUpkeOEaMG4cB3+9PUIMdN8JxaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cbnds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAtXs2024987;
	Wed, 22 Oct 2025 13:46:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk0hm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 13:46:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MDkHAu20316770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 13:46:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6404E2004D;
	Wed, 22 Oct 2025 13:46:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 518DF20043;
	Wed, 22 Oct 2025 13:46:15 +0000 (GMT)
Received: from shivang.com (unknown [9.124.221.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 13:46:15 +0000 (GMT)
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: horms@kernel.org
Cc: shivangu@linux.ibm.com, sourabhjain@linux.ibm.com,
        kexec@lists.infradead.org
Subject: [PATCH kexec-tools 0/4] ppc64: Support kexec with initrd and DTB together
Date: Wed, 22 Oct 2025 19:16:05 +0530
Message-ID: <20251022134611.8921-1-shivangu@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zdabEkz8dlbE57JQql6FQLMbSL2GLwot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2Gb5r1ATL5Mq
 PjBkqBuHiPpcl+GTV7+SciiLMqTyFd6zcjUSWxb7eeASOFgi9ykNUSkSkMM+eB+Zs6MarKKRLk2
 VuayIttD/AlZXovK5odq9uwEaYHsNzpekATk+tepXbklLbK+xIgu9lUQYzAqFcF2V0IK9fYA2lz
 FDCklnil4lDROUw2V53R7NTialkmlFkzHlx1sXukQAtTVoHq/ZW2Gbqno2/MOibvmGixgpdBz61
 7+8t7seBB2THRxo+lS85C2ntEfbtxpjC9SKDsmdARPySa9KiDgH88JbbkO3o9ijUqRVklCK37u9
 MQdPFKm/KPqmVwBjfaLsYwF3gQzUu9hBoRuFuGTP1KGS9LA9Sjb2HIzlGeBctV6zN44PCNPV6bb
 t3V0fSSKKimXVaTBlfeBL5L5n6fK6A==
X-Proofpoint-GUID: zdabEkz8dlbE57JQql6FQLMbSL2GLwot
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f8e02e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=qV5XY4kPW2cDrvb8Q8kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_135101_306146_FD3E0776 
X-CRM114-Status: GOOD (  15.49  )
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

Currently, on ppc64 systems, kexec cannot directly use a
user-provided devicetreeblob (dtb) when booting a new
kernel with an initrd. This limitation exists because the
dtb must be modified at runtime — for example, to include
the initrd’s memory location and size, and to add
/memreserve/ entries based on the current system memory
layout.

Previously, kexec handled this by generating a fresh dtb in
memory from the running system’s /proc/device-tree directory.
However, this approach prevents users from making
intentional modifications to the dtb — such as changin boot
arguments, enabling or disabling devices, or testing kernel
changes that depend on specific device tree properties.

Adding support for user-provided dtb (with appropriate
patching by kexec) allows more control for developers,
particularly when experimenting with custom kernels or
hardware configurations.

This patch series lifts this restriction and ensures that
the necessary /memreserve/ sections are properly added to
the new DTB. on ppc64, it is mandatory, for the rebooting
cpu to be present in the new kernel’s dtb, so additional
logic has been added to identify and mark one of available
cpu as reboot cpu on currect system.

A new architecture-specific function, arch_do_unload(), has
been introduced to perform the necessary cleanup during
kexec unload. in ppc64, the reboot CPU changes due to kexec,
and it gets reset back on kexec unload.

Shivang Upadhyay (4):
  ppc64: ensure /memreserve/ sections exist in user-provided FDT
  ppc64: handle reboot CPU in case of user provided DTB
  Add arch_do_unload hook for arch-specific cleanup
  ppc64: life the dtb and initrd restriction

 kexec/arch/arm/kexec-arm.c             |   4 +
 kexec/arch/arm64/kexec-arm64.c         |   4 +
 kexec/arch/cris/kexec-cris.c           |   4 +
 kexec/arch/hppa/kexec-hppa.c           |   4 +
 kexec/arch/i386/kexec-x86.c            |   4 +
 kexec/arch/ia64/kexec-ia64.c           |   4 +
 kexec/arch/loongarch/kexec-loongarch.c |   4 +
 kexec/arch/m68k/kexec-m68k.c           |   4 +
 kexec/arch/mips/kexec-mips.c           |   4 +
 kexec/arch/ppc/kexec-ppc.c             |   4 +
 kexec/arch/ppc64/kexec-elf-ppc64.c     | 262 ++++++++++++++++++++++++-
 kexec/arch/ppc64/kexec-ppc64.c         |   8 +
 kexec/arch/riscv/kexec-riscv.c         |   4 +
 kexec/arch/s390/kexec-s390.c           |   4 +
 kexec/arch/sh/kexec-sh.c               |   4 +
 kexec/arch/x86_64/kexec-x86_64.c       |   5 +
 kexec/kexec.c                          |   1 +
 kexec/kexec.h                          |   1 +
 18 files changed, 324 insertions(+), 5 deletions(-)

-- 
2.51.0



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6E7C05027
	for <kexec@archiver.kernel.org>; Wed,  1 Feb 2023 06:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=JqERUJyLHn4S/qWgyX+AAi9qGEMhXMndJJT5a28oap8=; b=FcDj4iTjMzOquX
	g2uKM2teUmsUE6eM2T/RV4IRfWbmB9MG4v8sPZn1Mmn43jZwmAZqTTR8timqVw9EQjA/PVTm9MKEy
	tTtq2fMWktqjltW1ah76/9bwxUoOrOeMSQiWEzaAh6HazFZBr7FmijVNCC2XuPp3c+LrseLu2liLJ
	LiKU06QrWv2mDvn1MU/r4QTZcl1SCies6AGuNLCBjbKMXsLr5UkarfGwJFMbi6KBx+lEn4/RcBHnt
	hHz2TWemO/tTMzrM5mOrcvV385HMAb7i3NsTwkpRZzzr/4m+UNKNRCJL5g7sstnYxeadDgCBMAlB8
	2341G53yNbEXYm/rH7Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6fv-00ATVz-SB; Wed, 01 Feb 2023 06:32:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5] helo=mx0a-001b2d01.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pN6fs-00ATUa-S2
	for kexec@lists.infradead.org; Wed, 01 Feb 2023 06:32:55 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3116VvPk029433;
	Wed, 1 Feb 2023 06:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=2K9u0HOV6aWe3Ve0ljcXL8szjNAZ8dM73Mk4mBaqQZ8=;
 b=XQh2nL+nUxNTweJtIOEq4t9NqQlRKwB4PzLSLQ7wXcjq82R/ghXo7bTr4SaG7UQxjtTb
 1k5uzFgUoM4AwVgK4Bfxc7efL50IhKagKX82v6kwgAhGutIqywiOd8mxrYSzWmR0Fr5U
 1ZwvLdhPWZfRGzr/VIRg+42xUvNWhg+44xx3f50epV16QQyF9Iq5meO9tMXdU8R4O1AP
 bQmBRMvpf/k7++rUH2qw0+L8NNUitqo9XvJwnyp0QP9t/G17+T2K4akUHriVoo022sk1
 6OhEODDz25/RXOm1smAYta20PLMHwLmjfzGf6rJz2P6LKtuPEyxVLjPshM4JXX+417Sq Og== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw6g0hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:32:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3116WQbH030778;
	Wed, 1 Feb 2023 06:32:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
	by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nfjw6g0h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:32:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
	by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3116IeKY026867;
	Wed, 1 Feb 2023 06:32:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3ncvs7mdpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Feb 2023 06:32:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3116We1F26411390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Feb 2023 06:32:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527382004D;
	Wed,  1 Feb 2023 06:32:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D3BF20040;
	Wed,  1 Feb 2023 06:32:37 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.109.52])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Feb 2023 06:32:37 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v8 0/8] In kernel handling of CPU hotplug events for crash kernel
Date: Wed,  1 Feb 2023 12:02:28 +0530
Message-Id: <20230201063236.963344-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-6EA_RnhDoFCJ_6YRQ0989fpTjtOHA2
X-Proofpoint-ORIG-GUID: 2lOys8jiowwv40zYSya0dpSMJAEnZJaJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302010051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_223253_061183_5F2F30BB 
X-CRM114-Status: GOOD (  24.54  )
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
Cc: eric.devolder@oracle.com, bhe@redhat.com, kexec@lists.infradead.org, ldufour@linux.ibm.com, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The Problem:
============
Post hotplug/DLPAR events the capture kernel holds stale information about the
system. Dump collection with stale capture kernel might end up in dump capture
failure or an inaccurate dump collection.

Existing solution:
==================
The existing solution to keep the capture kernel up-to-date by monitoring
hotplug event via udev rule and trigger a full capture kernel reload for
every hotplug event.

Shortcomings:
------------------------------------------------
- Leaves a window where kernel crash might not lead to a successful dump
  collection.
- Reloading all kexec components for each hotplug is inefficient.
- udev rules are prone to races if hotplug events are frequent.

More about issues with an existing solution is posted here:
 - https://lkml.org/lkml/2020/12/14/532
 - https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html

Proposed Solution:
==================
Instead of reloading all kexec segments on hotplug event, this patch series
focuses on updating only the relevant kexec segment. Once the kexec segments
are loaded in the kernel reserved area then an arch-specific hotplug handler
will update the relevant kexec segment based on hotplug event type.

Series Dependecies
==================
This patch series implements the crash hotplug handler on PowerPC. The generic
for crash hotplug update is introduced by https://lkml.org/lkml/2022/12/9/520 patch series.

Git tree for testing:
=====================
The below git tree has this patch series applied on top of dependent patch
series.
https://github.com/sourabhjains/linux/commits/in-kernel-crash-update

Note: only kexec_file_load syscall will work. For kexec_load mirnor
changes are required in kexec tool.

To realise the feature the kdump udev rules must be disabled for CPU/Memory
hotplug events. Comment out the below line in kdump udev rule file:

  RHEL: /usr/lib/udev/rules.d/98-kexec.rules

  	#SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"
	#SUBSYSTEM=="memory", ACTION=="online", GOTO="kdump_reload_mem"
	#SUBSYSTEM=="memory", ACTION=="offline", GOTO="kdump_reload_mem"

  SLES: /usr/lib/kdump/70-kdump.rules

	#SUBSYSTEM=="memory", ACTION=="add|remove", GOTO="kdump_try_restart"
	#SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_try_restart"
---
Changelog:

v7 -> v8:
  - Restrict fdt_index initialization to machine_kexec_post_load
    it work for both kexec_load and kexec_file_load.[3/8] Laurent Dufour

  - Updated the logic to find the number of offline core. [6/8]

  - Changed the logic to find the elfcore program header to accommodate
    future memory ranges due memory hotplug events. [8/8]

v6 -> v7
  - added a new config to configure this feature
  - pass hotplug action type to arch specific handler

v5 -> v6
  - Added crash memory hotplug support

v4 -> v5:
  - Replace COFNIG_CRASH_HOTPLUG with CONFIG_HOTPLUG_CPU.
  - Move fdt segment identification for kexec_load case to load path
    instead of crash hotplug handler
  - Keep new attribute defined under kimage_arch to track FDT segment
    under CONFIG_HOTPLUG_CPU config.

v3 -> v4:
  - Update the logic to find the additional space needed for hotadd CPUs post
    kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash hotplug
    support for kexec_file_load" patch to know more about the change.
  - Fix a couple of typo.
  - Replace pr_err to pr_info_once to warn user about memory hotplug
    support.
  - In crash hotplug handle exit the for loop if FDT segment is found.

v2 -> v3
  - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
  - Rebase patche on top of https://lkml.org/lkml/2022/3/3/674 [v5]
  - Fixed warning reported by checpatch script

v1 -> v2:
  - Use generic hotplug handler introduced by https://lkml.org/lkml/2022/2/9/1406, a
    significant change from v1.

Sourabh Jain (8):
  powerpc/kexec: turn some static helper functions public
  powerpc/crash hp: introduce a new config option CRASH_HOTPLUG
  powerpc/crash: update kimage_arch struct
  crash: add phdr for possible CPUs in elfcorehdr
  crash: pass hotplug action type to arch crash hotplug handler
  powerpc/crash: add crash CPU hotplug support
  crash: forward memory_notify args to arch crash hotplug handler
  powerpc/kexec: add crash memory hotplug support

 arch/powerpc/Kconfig                    |  12 +
 arch/powerpc/include/asm/kexec.h        |  18 ++
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/core_64.c            | 335 ++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c             |  19 +-
 arch/powerpc/kexec/file_load_64.c       | 237 +++--------------
 arch/powerpc/kexec/ranges.c             |  60 +++++
 arch/x86/include/asm/kexec.h            |   3 +-
 arch/x86/kernel/crash.c                 |   5 +-
 include/linux/kexec.h                   |   6 +-
 kernel/crash_core.c                     |  23 +-
 11 files changed, 502 insertions(+), 217 deletions(-)

-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

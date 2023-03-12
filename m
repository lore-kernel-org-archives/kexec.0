Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8E0C6FA99
	for <kexec@archiver.kernel.org>; Sun, 12 Mar 2023 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UsztIbMhEwEMoYpencGXUkLXUkx4AygxFJ3lFbAwaRc=; b=YNR0PT73m9J2Tr
	G45vPW3yBWHxtVrqLDbDBlQBGgl7lYi+3aidZ+7XJ1+UeYvFbgIIA4L3x7YgAWsOFskEy+lHi3AX0
	8B3W+cVx+5Zt4O+R0FUNl+j9e5PX9OieAjjGtwXahL1e8jlNQ2RVcxuwGPgRaoIdNqxllzOWc26u5
	vNn2XnhJVeiqKBtJFc/stx7BuiphMTLf4YdUJhrDpSOtF0RsQxter8t5GRCuLXAtTOVMEh8fmfV0u
	JHPG/vUOxVmOhe43tvqZbclJU0CvRCguNGCHeBfJ9XKn3FcbwEue1ztobfY6p5W4FGu3pYrwXK3Rj
	pw2FWJRptg2JJi7feCrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQBU-003C6C-F4; Sun, 12 Mar 2023 18:12:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbQB3-003BsT-3M
	for kexec@lists.infradead.org; Sun, 12 Mar 2023 18:12:20 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32CG1WUN015021;
	Sun, 12 Mar 2023 18:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=NCYC2CrSEC496oPd47Iw5oIoSCXNPPUMKxXM/2Xrt8o=;
 b=XTqQOt8CUws1XU6IAC4GSx3qDeBDb6NNBq9V30W914dWqjuBgTiiEKSkWxbRmlDEr2fC
 pWto9oTKvRy0ymG185LCACPXL7ACDWYS1iCdcG+xQDmKn4PNV2diUh+bg7WU5xqE+ngQ
 wB5TiiTdxPXN9Gl7QCY/DemL7PEai5w8HY9wnkp3CQja+zv+isBYmvSsNYzM7fpPY8Yt
 hZ1BF1NT5IhwZqF6cQGDiqqMZrJepSxX87ynCueBLFJywPay31pN3boq33ru3VHkPBT1
 D7SUn7JX786pfpkf/ja4C1aKBux/W/yRDj7PzYdh3A2DuY1bawtnP/di6vfkbLkLJmxB oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93esr2ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:05 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32CI8l2q022198;
	Sun, 12 Mar 2023 18:12:05 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p93esr2y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:05 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
	by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32BNWR5k006974;
	Sun, 12 Mar 2023 18:12:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p8h96hpgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 Mar 2023 18:12:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32CIBwHL21037412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 12 Mar 2023 18:11:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBD420043;
	Sun, 12 Mar 2023 18:11:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2EA220040;
	Sun, 12 Mar 2023 18:11:56 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.41.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 12 Mar 2023 18:11:56 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v9 0/6] PowerPC: in kernel handling of CPU hotplug events for crash kernel
Date: Sun, 12 Mar 2023 23:41:48 +0530
Message-Id: <20230312181154.278900-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZOF450uwX5v3SYZNNPobGOMmluQjccVe
X-Proofpoint-ORIG-GUID: i3NA2K0FB-kcl-mLCrxGrie5hhoh3QNM
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-12_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303120157
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230312_111214_863464_D1533ADE 
X-CRM114-Status: GOOD (  24.06  )
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
crash hotplug update is introduced by https://lkml.org/lkml/2023/3/6/1358 patch
series.

Git tree for testing:
=====================
The below git tree has this patch series applied on top of dependent patch
series.
https://github.com/sourabhjains/linux/tree/in-kernel-crash-update-v9

To realise the feature the kdump udev rules must be disabled for CPU/Memory
hotplug events. Comment out the below line in kdump udev rule file:

  RHEL: /usr/lib/udev/rules.d/98-kexec.rules

  	#SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"
	#SUBSYSTEM=="memory", ACTION=="online", GOTO="kdump_reload_mem"
	#SUBSYSTEM=="memory", ACTION=="offline", GOTO="kdump_reload_mem"

  SLES: /usr/lib/kdump/70-kdump.rules

	#SUBSYSTEM=="memory", ACTION=="add|remove", GOTO="kdump_try_restart"
	#SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_try_restart"

Note: only kexec_file_load syscall will work. For kexec_load minor
changes are required in kexec tool.

---
Changelog:

v9:
  - Removed patch to prepare elfcorehdr crash notes for possible CPUs.
    The patch is moved to generic patch series that introduces generic
    infrastructure for in kernel crash update.
  - Removed patch to pass the hotplug action type to the arch crash
    hotplug handler function. The generic patch series has introduced
    the hotplug action type in kimage struct.
  - Add detail commit message for better understanding.

v8:
  - Restrict fdt_index initialization to machine_kexec_post_load
    it work for both kexec_load and kexec_file_load.[3/8] Laurent Dufour

  - Updated the logic to find the number of offline core. [6/8]

  - Changed the logic to find the elfcore program header to accommodate
    future memory ranges due memory hotplug events. [8/8]

v7
  - added a new config to configure this feature
  - pass hotplug action type to arch specific handler

v6
  - Added crash memory hotplug support

v5:
  - Replace COFNIG_CRASH_HOTPLUG with CONFIG_HOTPLUG_CPU.
  - Move fdt segment identification for kexec_load case to load path
    instead of crash hotplug handler
  - Keep new attribute defined under kimage_arch to track FDT segment
    under CONFIG_HOTPLUG_CPU config.

v4:
  - Update the logic to find the additional space needed for hotadd CPUs post
    kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash hotplug
    support for kexec_file_load" patch to know more about the change.
  - Fix a couple of typo.
  - Replace pr_err to pr_info_once to warn user about memory hotplug
    support.
  - In crash hotplug handle exit the for loop if FDT segment is found.

v3
  - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
  - Rebase patche on top of https://lkml.org/lkml/2022/3/3/674 [v5]
  - Fixed warning reported by checpatch script

v2:
  - Use generic hotplug handler introduced by https://lkml.org/lkml/2022/2/9/1406, a
    significant change from v1.

Sourabh Jain (6):
  powerpc/kexec: turn some static helper functions public
  powerpc/crash: introduce a new config option CRASH_HOTPLUG
  powerpc/crash: add a new member to the kimage_arch struct
  powerpc/crash: add crash CPU hotplug support
  crash: forward memory_notify args to arch crash hotplug handler
  powerpc/kexec: add crash memory hotplug support

 arch/powerpc/Kconfig                    |  12 +
 arch/powerpc/include/asm/kexec.h        |  15 ++
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/core_64.c            | 322 ++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c             |  13 +-
 arch/powerpc/kexec/file_load_64.c       | 212 ++++------------
 arch/powerpc/kexec/ranges.c             |  85 +++++++
 arch/x86/include/asm/kexec.h            |   2 +-
 arch/x86/kernel/crash.c                 |   3 +-
 include/linux/kexec.h                   |   2 +-
 kernel/crash_core.c                     |  14 +-
 11 files changed, 506 insertions(+), 175 deletions(-)

-- 
2.39.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

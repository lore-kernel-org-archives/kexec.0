Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0888BC77B76
	for <kexec@archiver.kernel.org>; Sun, 23 Apr 2023 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Xyqvr6W5tY5ZFk2kW3ttHO/Fs2Uwms/x0gRDkCzgx3g=; b=VGQEBRBjxwo+pH
	7FL/e7xOVIUz9BSUzutAkVjIkQHjdEOdFFQStCI7ZRFgH/rDFjmkBRqKjOjCmslgxZjN7pE1peo/y
	rMUacIyONpmhO656F3bjQrpPk8Ob3WX1lZ4zSNHo2WFGJM3Q9nyXkUW2XExbHxWEIF2u1pZHFz9H2
	lIL+yFq3VLE0yYV/aT9kw22jltEFEK/lLdTTre27/RW7CkLPVMxgW8DdCzI4UyX+7H79rjvnfZ1QW
	cOSPCy61V9covIaWqAvNTzVY5A0LrFZ8yR/Z79Y/gPDs6eRYm+ihUV1GkjYipphc3RI1YapeSMybL
	/KSWzPxh8cN8xolnIdew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKf-00EAsp-1l;
	Sun, 23 Apr 2023 10:52:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqXKa-00EAs1-2d
	for kexec@lists.infradead.org;
	Sun, 23 Apr 2023 10:52:34 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33NAbxhn031133;
	Sun, 23 Apr 2023 10:52:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=erYOZloGbili+rtx+wBv9FGcgMrrFDiu//ufXaNQbxU=;
 b=RNqsiMYE9HzmBgmipn+NYKegLVcXKwHGD3+52Me6uZziXVJoZf/nFSORoecrAxqSDjTl
 4MYLSzksFAhHulb9YWSX39XP4vKIC2UoQmo+xiSIEfyGntOrWaKr2dPIvzaJF1pLG39D
 WxJtfk6mmiYMPaf1WSsF7SUTLv+6nkbmGG41dlM6BA+UmkKCuu8y8EcoEbbiZ1WC8Ef2
 etOtJ/2FQxwyCt8ivEb0ss+NdYBfskHEkgfXf+IB9ilU4ctgHrztsB/ZX+jsFmYJ4GGD
 ki250/OnZgbLfWiVMEHKwnIKAU/Bf667zNrdTQEx4E356qR7nb8uYnVjN1sJcmBGpBOj /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33NAidix014139;
	Sun, 23 Apr 2023 10:52:24 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q461b13jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:24 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33N4r9OS015124;
	Sun, 23 Apr 2023 10:52:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q47770j74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Apr 2023 10:52:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33NAqJjv12059156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Apr 2023 10:52:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 078912004D;
	Sun, 23 Apr 2023 10:52:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB69920049;
	Sun, 23 Apr 2023 10:52:15 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.22.217])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Apr 2023 10:52:15 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v10 0/5] PowerPC: In-kernel handling of CPU/Memory hotplug/online/offline events for kdump kernel
Date: Sun, 23 Apr 2023 16:22:08 +0530
Message-Id: <20230423105213.70795-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pZmSpiqcDN1AcWYtTM01-urNSCxt6AJ_
X-Proofpoint-ORIG-GUID: _AFm65y5WQnojapYkHRj0MmStpUgRxLd
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-23_06,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304230097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_035233_098955_F472A41E 
X-CRM114-Status: GOOD (  23.98  )
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
Post CPU/Memory hot plug/unplug and online/offline events the  kernel
holds stale information about the system. Dump collection with stale
kdump kernel might end up in dump capture failure or an inaccurate dump
collection.

Existing solution:
==================
The existing solution to keep the kdump kernel up-to-date by monitoring
CPU/Memory hotplug/online/offline events via udev rule and trigger a full
kdump kernel reload for every hotplug event.

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
Instead of reloading all kexec segments on CPU/Memory hotplug/online/offline
event, this patch series focuses on updating only the relevant kexec segment.
Once the kexec segments are loaded in the kernel reserved area then an
arch-specific hotplug handler will update the relevant kexec segment based on
hotplug event type.

Series Dependencies
====================
This patch series implements the crash hotplug handler on PowerPC. The generic
crash hotplug handler is introduced by https://lkml.org/lkml/2023/4/4/1136 patch
series.

Git tree for testing:
=====================
The below git tree has this patch series applied on top of dependent patch
series.
https://github.com/sourabhjains/linux/tree/e21-s10

To realise the feature the kdump udev rule must updated to avoid
reloading of kdump reload on CPU/Memory hotplug/online/offline events.

  RHEL: /usr/lib/udev/rules.d/98-kexec.rules

	-SUBSYSTEM=="cpu", ACTION=="online", GOTO="kdump_reload_cpu"
	-SUBSYSTEM=="memory", ACTION=="online", GOTO="kdump_reload_mem"
	-SUBSYSTEM=="memory", ACTION=="offline", GOTO="kdump_reload_mem"
	+SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
	+SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

Note: only kexec_file_load syscall will work. For kexec_load minor changes are
required in kexec tool.

---
Changelog:

v10:
  - Drop the patch that adds fdt_index attribute to struct kimage_arch
    Find the fdt segment index when needed.
  - Added more details into commits messages.
  - Rebased onto 6.3.0-rc5

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

Sourabh Jain (5):
  powerpc/kexec: turn some static helper functions public
  powerpc/crash: introduce a new config option CRASH_HOTPLUG
  powerpc/crash: add crash CPU hotplug support
  crash: forward memory_notify args to arch crash hotplug handler
  powerpc/kexec: add crash memory hotplug support

 arch/powerpc/Kconfig                    |  12 +
 arch/powerpc/include/asm/kexec.h        |  10 +
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/core_64.c            | 301 ++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c             |  12 +-
 arch/powerpc/kexec/file_load_64.c       | 212 ++++-------------
 arch/powerpc/kexec/ranges.c             |  85 +++++++
 arch/x86/include/asm/kexec.h            |   2 +-
 arch/x86/kernel/crash.c                 |   3 +-
 include/linux/kexec.h                   |   2 +-
 kernel/crash_core.c                     |  14 +-
 11 files changed, 479 insertions(+), 175 deletions(-)

-- 
2.39.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

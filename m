Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9012EC4707B
	for <kexec@archiver.kernel.org>; Thu, 11 Jan 2024 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YefFiC1truzSbNsI0KP25+QWiRiQlu/IfkdS5V6dyZc=; b=y0af413Xv2gzV7
	oNSPHXeZJPSEnwM0DrbzJLEfuGmmXIkNdjNp8n0WYVJehH+Mtj8O0ewu4TxwR48olqRw7TSEx5eq5
	4JRpUKEVYrcAeAWGPv4JdoJxe4UlHvZeCzGXX5DOHmtVKBj4xCoDEDvLDYIBS10eke/CkYpNeDfM0
	TzVeTeX6DFxEtLt07qj2nn3zMGfZjO3urjgMmZs6sLX+BbJfnpRS2A/TVpYGZkQSgPfNFqGNmwQDa
	3rc8T0iuinkl52i8pki9wGwGKbwZCrkFNGSUMf0xrQjGSWeet9FSrHsyvyHTBeDgjmBq0A7qNEqQ2
	2SurxLOee+g8ok8RSPhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNsij-00H7n3-2X;
	Thu, 11 Jan 2024 10:55:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNsig-00H7l5-0K
	for kexec@lists.infradead.org;
	Thu, 11 Jan 2024 10:55:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BAOdgc005607;
	Thu, 11 Jan 2024 10:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=7j8uAuwOxnxnMGwD5t7Viwj8VPV1fzKUI0PlxMs0N8E=;
 b=iFNQGiWY1kLbGajOXBXrjiqkmrGZ0JRYTp18HcqTJCoBEI13UTPRn1+JRTSt7WTSiaWH
 E5xNJVA/HWq9lFe5i29V/Nxo0kM/M6Fc9I4TdH9mLjQroj/rcfyDnGWQFft5n+smV+rb
 b3/WRyDfW628qVpcXXPKXOzUrDomsrnLvInSW2ZtOlnzAR+FYSdV3H2IITy3haVFDXmF
 DSDyV6foRuA3jEQsgpgjhw0aoxXquXC+mrbPMDjZljhNHv54r7DrPQ1kXv07cFO2yNO/
 dGoeDY/3MOFm4Yi04glAPaQVJGsrELMDm3b87MByYQS9R8cqOIUu0D4r1Z0Y8PPdKkCN uA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjdv21n9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 10:54:57 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BAjQ9r006999;
	Thu, 11 Jan 2024 10:54:56 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjdv21mp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 10:54:56 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40B9pseT027254;
	Thu, 11 Jan 2024 10:51:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2afwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 10:51:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BApuQx42860870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 10:51:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D8852004F;
	Thu, 11 Jan 2024 10:51:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6226C2004E;
	Thu, 11 Jan 2024 10:51:52 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.79.182.66])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 10:51:52 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Akhil Raj <lf32.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Young <dyoung@redhat.com>, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, Naveen N Rao <naveen@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH v15 0/5] powerpc/crash: Kernel handling of CPU and memory hotplug
Date: Thu, 11 Jan 2024 16:21:33 +0530
Message-ID: <20240111105138.251366-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S6ieKoq0MjjNk1NEoxijqyId_BfzY-18
X-Proofpoint-GUID: 85kIJ8Anl9DHSXUI5k0Pm1ic6dQ9Ee_i
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_05,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401110088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_025530_255107_144C2465 
X-CRM114-Status: GOOD (  37.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Commit 247262756121 ("crash: add generic infrastructure for crash
hotplug support") added a generic infrastructure that allows
architectures to selectively update the kdump image component during CPU
or memory add/remove events within the kernel itself.

This patch series adds crash hotplug handler for PowerPC and enable
support to update the kdump image on CPU/Memory add/remove events.

Among the 5 patches in this series, the first two patches make changes
to the generic crash hotplug handler to assist PowerPC in adding support
for this feature. The last three patches add support for this feature.

The following section outlines the problem addressed by this patch
series, along with the current solution, its shortcomings, and the
proposed resolution.

Problem:
========
Due to CPU/Memory hotplug or online/offline events the elfcorehdr
(which describes the CPUs and memory of the crashed kernel) and FDT
(Flattened Device Tree) of kdump image becomes outdated. Consequently,
attempting dump collection with an outdated elfcorehdr or FDT can lead
to failed or inaccurate dump collection.

Going forward CPU hotplug or online/offline events are referred as
CPU/Memory add/remove events.

Existing solution and its shortcoming:
======================================
The current solution to address the above issue involves monitoring the
CPU/memory add/remove events in userspace using udev rules and whenever
there are changes in CPU and memory resources, the entire kdump image
is loaded again. The kdump image includes kernel, initrd, elfcorehdr,
FDT, purgatory. Given that only elfcorehdr and FDT get outdated due to
CPU/Memory add/remove events, reloading the entire kdump image is
inefficient. More importantly, kdump remains inactive for a substantial
amount of time until the kdump reload completes.

Proposed solution:
==================
Instead of initiating a full kdump image reload from userspace on
CPU/Memory hotplug and online/offline events, the proposed solution aims
to update only the necessary kdump image component within the kernel
itself.

Git tree for testing:
=====================
Git tree rebased on top of v6.7:
https://github.com/sourabhjains/linux/tree/kdump-in-kernel-crash-update-v15

To realize this feature, the kdump udev rule must be updated. On RHEL,
add the following two lines at the top of the
"/usr/lib/udev/rules.d/98-kexec.rules" file.

SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

With the above change to the kdump udev rule, kdump reload is avoided
during CPU/Memory add/remove events if this feature is enabled in the
kernel.

Note: only kexec_file_load syscall will work. For kexec_load minor changes
are required in kexec tool.

Changelog:
----------
v15:
  - Remove the patch that adds a new kexec flag for FDT update.
  - Introduce a generic kexec flag bit to share hotplug support
    intent between the kexec tool and the kernel for the kexec_load
    syscall. (2/5)
  - Introduce an architecture-specific handler to process the kexec
    flag for crash hotplug support. (2/5)
  - Rename the @update_elfcorehdr member of the struct kimage to
    @hotplug_support. (2/5)
  - Use a common function to advertise hotplug support for both CPU
    and Memory. (2/5)

v14:
  - Fix build warnings by including necessary header files
  - Rebase to v6.7-rc5

v13:
  - Fix a build warning, take ranges.c out of CONFIG_KEXEC_FILE
  - Rebase to v6.7-rc4

v12:
  - A patch to add new kexec flags to support this feature on kexec_load
    system call
  - Change in the way this feature is advertise to userspace for both
    kexec_load syscall
  - Rebase to v6.6-rc7

v11:
  - Rebase to v6.4-rc6
  - The patch that introduced CONFIG_CRASH_HOTPLUG for PowerPC has been
    removed. The config is now part of common configuration:
    https://lore.kernel.org/all/87ilbpflsk.fsf@mail.lhotse/

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
  - Update the logic to find the additional space needed for hotadd CPUs
    post kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash
    hotplug support for kexec_file_load" patch to know more about the
    change.
  - Fix a couple of typo.
  - Replace pr_err to pr_info_once to warn user about memory hotplug
    support.
  - In crash hotplug handle exit the for loop if FDT segment is found.

v3
  - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
  - Rebase patche on top of
    https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
  - Fixed warning reported by checpatch script

v2:
  - Use generic hotplug handler introduced by
    https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
    a significant change from v1.

Cc: Akhil Raj <lf32.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: x86@kernel.org

Sourabh Jain (5):
  crash: forward memory_notify arg to arch crash hotplug handler
  crash: add a new kexec flag for hotplug support
  powerpc/kexec: turn some static helper functions public
  powerpc: add crash CPU hotplug support
  powerpc: add crash memory hotplug support

 arch/powerpc/Kconfig                    |   4 +
 arch/powerpc/include/asm/kexec.h        |  15 ++
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/Makefile             |   4 +-
 arch/powerpc/kexec/core_64.c            | 334 ++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c             |  12 +-
 arch/powerpc/kexec/file_load_64.c       | 211 ++++-----------
 arch/powerpc/kexec/ranges.c             |  85 ++++++
 arch/x86/include/asm/kexec.h            |   5 +-
 arch/x86/kernel/crash.c                 |  21 +-
 drivers/base/cpu.c                      |   2 +-
 drivers/base/memory.c                   |   2 +-
 include/linux/kexec.h                   |  27 +-
 include/uapi/linux/kexec.h              |   1 +
 kernel/crash_core.c                     |  25 +-
 kernel/kexec.c                          |   4 +-
 kernel/kexec_file.c                     |   5 +
 17 files changed, 549 insertions(+), 209 deletions(-)

-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

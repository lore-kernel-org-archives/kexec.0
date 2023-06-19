Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E9EB64D8
	for <kexec@archiver.kernel.org>; Mon, 19 Jun 2023 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=znsveTwRwf8cQeTb9cmXWrlbxM8s0e0BSKv+PezqlaM=; b=F1iT9fbHqJLh1i
	dlOHtAtuFemspVMkF7C6WqFfM4gAndrITOTwbv8F1v0ub5Ni5TBBx6J4/YWo78yMI5u+s0oh37qdV
	I5ve5fpqiOnKrU8hZqHQsyxsKaGEGvn3H6dQEYKJl4GsKbZvn32MJOLgz687xhLRoGIgm+s7qJdH3
	W6YuT4Pr2xfjUnyM5YmGgG9CtNqZAmYBP9+KpvZ/Omx3g2Xa7zUZkyOLKcaeuo15atrAx1uLmgofd
	ICYOp3FhTP43NSLXMtCqMZTDWdi0GY2ykHH0fTFGtVjOWfy4Snkzom+pxpipn28ctGVIRD5vTf3B5
	0UEf5ecdhgnzr8+V8Uzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qB4xo-007En9-2b;
	Mon, 19 Jun 2023 02:49:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qB4xh-007Elk-2y
	for kexec@lists.infradead.org;
	Mon, 19 Jun 2023 02:49:51 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J2kFFP008921;
	Mon, 19 Jun 2023 02:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=i0pleWiUr9wJnF3pY/32Ej+SzvLvPwsiY8m4QrgyhUk=;
 b=sagGRciX8vGsrOE7apatfxZR77Zk8Xjdltb3seRXekqKaMayx2frKFw+9K1zt6jcss0E
 jevnaTuQzACG7OZRjlWUaZAR3RB0b1uVgw8Qng6JZMC4tqi+UPXv1v6zd4PINutqwwZs
 Mj/fyCoPSOn2m+Ou/u3F1uA5Kd4jldB6rfB3KtYONx8X4cMERUI1hn2ICSdU6qHM+3pg
 ufpKev9GFCwm7Zcsy1M2A94ELuhXi0FYWLPUwRLE3JILOwARPMDIY2+W8yggTWfK15kL
 +akkPwgSjNUU7oEj3NpMhxO7JWavnOujcbcw/kfS2gsy87o9fauNLmmyQltYYnnFb+Ba 7w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3raehcr1d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 02:49:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
	by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35J2bHjo014362;
	Mon, 19 Jun 2023 02:49:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f513bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jun 2023 02:49:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35J2nb9H34341314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jun 2023 02:49:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438F720043;
	Mon, 19 Jun 2023 02:49:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A97C520040;
	Mon, 19 Jun 2023 02:49:35 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.70.141])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jun 2023 02:49:35 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v11 0/4] PowerPC: In-kernel handling of CPU/Memory hotplug/online/offline events for kdump kernel
Date: Mon, 19 Jun 2023 08:19:30 +0530
Message-Id: <20230619024934.567046-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0TB_lTfk9ZkZtCn4Z9Pt4ZQXh6tD-nDm
X-Proofpoint-ORIG-GUID: 0TB_lTfk9ZkZtCn4Z9Pt4ZQXh6tD-nDm
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-18_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 mlxscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230618_194950_094992_D8ED28A0 
X-CRM114-Status: GOOD (  33.39  )
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
Cc: ldufour@linux.ibm.com, eric.devolder@oracle.com, kexec@lists.infradead.org, hbathini@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The Problem:
============
Post CPU/Memory hot plug/unplug and online/offline events occur, the
kdump kernel often retains outdated system information. This presents
a significant challenge when attempting to perform a dump collection
using an outdated or stale kdump kernel. In such situations, there
are two potential outcomes that pose risks: either the dump collection
fails to capture the required data entirely, leading to a failed dump,
or the collected dump data is inaccurate, thereby compromising its
reliability for analysis and troubleshooting purposes

Existing solution:
==================
The existing solution to keep the kdump kernel up-to-date involves
monitoring CPU/Memory hotplug/online/offline events via a udev rule.
This approach triggers a full kdump kernel reload for each hotplug event,
ensuring that the kdump kernel is always synchronized with the latest
system resource changes.

Shortcomings of existing solution:
==================================
- Leaves a window where kernel crash might not lead to a successful dump
  collection.
- Reloading all kexec segments for each hotplug is inefficient.
- udev rules are prone to races if hotplug events are frequent.

Further information regarding the problems associated with a current
solution can be found here.
 - https://lore.kernel.org/lkml/b04ed259-dc5f-7f30-6661-c26f92d9096a@oracle.com/
 - https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-February/240254.html

Proposed Solution:
==================
To address the limitations of the current approach, a proposed solution
focuses on implementing a more targeted update strategy. Instead of
performing a full reload of all kexec segments for every CPU/Memory hot
plug/unplug and online/offline events, the proposed solution aims to update
only the relevant kexec segment. After loading the kexec segments into the
reserved area, a newly introduced hotplug handler will be responsible for
updating the specific kexec segment based on the type of hotplug event.
This selective update approach enhances overall efficiency by minimizing
unnecessary overhead and significantly reduces the chances of a kernel
crash leading to a failed or inaccurate dump collection.

Series Dependencies:
====================
The implementation of the crash hotplug handler on PowerPC is included in
this patch series. The introduction of the generic crash hotplug handler
is done through the patch series available at
https://lore.kernel.org/all/20230612210712.683175-1-eric.devolder@oracle.com/

Git tree for testing:
=====================
The following Git tree incorporates this patch series applied on top of
the dependent patch series.
https://github.com/sourabhjains/linux/tree/e23-s11-with-kexec-config

In order to enable this feature, it is necessary to disable the udev rule
responsible for reloading the kdump service. To do this, you can make the
following additions to the file "/usr/lib/udev/rules.d/98-kexec.rules" on RHEL:

Add the following two lines at top:

   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

The changes mentioned above ensure that the kdump reload process is skipped
for CPU/Memory hot plug/unplug events when the path
"/sys/devices/system/[cpu|memory]/crash_hotplug" exists.

Note: only kexec_file_load syscall will work. For kexec_load minor changes are
required in kexec tool.

---
Changelog:

v11:
  - Rebase to v6.4-rc6
  - The patch that introduced CONFIG_CRASH_HOTPLUG for PowerPC has been removed.
    The config is now part of common configuration:
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
  - Update the logic to find the additional space needed for hotadd CPUs post
    kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash hotplug
    support for kexec_file_load" patch to know more about the change.
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

Sourabh Jain (4):
  powerpc/kexec: turn some static helper functions public
  powerpc/crash: add crash CPU hotplug support
  crash: forward memory_notify args to arch crash hotplug handler
  powerpc/crash: add crash memory hotplug support

 arch/powerpc/Kconfig                    |   3 +
 arch/powerpc/include/asm/kexec.h        |  22 ++
 arch/powerpc/include/asm/kexec_ranges.h |   1 +
 arch/powerpc/kexec/core_64.c            | 301 ++++++++++++++++++++++++
 arch/powerpc/kexec/elf_64.c             |  12 +-
 arch/powerpc/kexec/file_load_64.c       | 212 ++++-------------
 arch/powerpc/kexec/ranges.c             |  85 +++++++
 arch/x86/include/asm/kexec.h            |   2 +-
 arch/x86/kernel/crash.c                 |   5 +-
 include/linux/kexec.h                   |   2 +-
 kernel/crash_core.c                     |  14 +-
 11 files changed, 483 insertions(+), 176 deletions(-)

-- 
2.40.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

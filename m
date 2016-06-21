Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bFAkh-0004mC-1M
 for kexec@lists.infradead.org; Tue, 21 Jun 2016 01:45:21 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L1hXBv074608
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:44:57 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2ek7e5s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:44:57 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:44:55 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 0CFC01DC006E
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 21:44:46 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5L1ir0Y4444174
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:53 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5L1iqsg029915
 for <kexec@lists.infradead.org>; Mon, 20 Jun 2016 22:44:53 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/6] kexec_file: Add buffer hand-over for the next kernel
Date: Mon, 20 Jun 2016 22:44:30 -0300
Message-Id: <1466473476-10104-1-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Eric Richter <erichte@linux.vnet.ibm.com>

Hello,

This patch series implements a mechanism which allows the kernel to pass on
a buffer to the kernel that will be kexec'd. This buffer is passed as a
segment which is added to the kimage when it is being prepared by
kexec_file_load.

How the second kernel is informed of this buffer is architecture-specific.
On PowerPC, this is done via the device tree, by checking the properties
/chosen/linux,kexec-handover-buffer-start and
/chosen/linux,kexec-handover-buffer-end, which is analogous to how the
kernel finds the initrd.

This feature was implemented because the Integrity Measurement Architecture
subsystem needs to preserve its measurement list accross the kexec reboot.
This is so that IMA can implement trusted boot support on the OpenPower
platform, because on such systems an intermediary Linux instance running as
part of the firmware is used to boot the target operating system via kexec.
Using this mechanism, IMA on this intermediary instance can hand over to the
target OS the measurements of the components that were used to boot it.

Because there could be additional measurement events between the
kexec_file_load call and the actual reboot, IMA needs a way to update the
buffer with those additional events before rebooting. One can minimize
the interval between the kexec_file_load and the reboot syscalls, but as
small as it can be, there is always the possibility that the measurement
list will be out of date at the time of reboot.

To address this issue, this patch series also introduces kexec_update_segment,
which allows a reboot notifier to change the contents of the image segment
during the reboot process.

There's one patch which makes kimage_load_normal_segment and
kexec_update_segment share code. It's not much code that they can share
though, so I'm not sure if it's worth including this patch.

The last patch is not intended to be merged, it just demonstrates how this
feature can be used.

This series applies on top of v2 of the "kexec_file_load implementation
for PowerPC" patch series at:

http://lists.infradead.org/pipermail/kexec/2016-June/016078.html

Thiago Jung Bauermann (6):
  kexec_file: Add buffer hand-over support for the next kernel
  powerpc: kexec_file: Add buffer hand-over support for the next kernel
  kexec_file: Allow skipping checksum calculation for some segments.
  kexec_file: Add mechanism to update kexec segments.
  kexec: Share logic to copy segment page contents.
  IMA: Demonstration code for kexec buffer passing.

 arch/powerpc/include/asm/kexec.h       |   9 ++
 arch/powerpc/kernel/kexec_elf_64.c     |  50 +++++++-
 arch/powerpc/kernel/machine_kexec_64.c |  64 ++++++++++
 arch/x86/kernel/crash.c                |   4 +-
 arch/x86/kernel/kexec-bzimage64.c      |   6 +-
 include/linux/ima.h                    |  11 ++
 include/linux/kexec.h                  |  47 +++++++-
 kernel/kexec_core.c                    | 205 ++++++++++++++++++++++++++-------
 kernel/kexec_file.c                    | 102 ++++++++++++++--
 security/integrity/ima/ima.h           |   5 +
 security/integrity/ima/ima_init.c      |  26 +++++
 security/integrity/ima/ima_template.c  |  79 +++++++++++++
 12 files changed, 547 insertions(+), 61 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

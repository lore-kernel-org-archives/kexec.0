Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bkKxY-00012k-BJ
 for kexec@lists.infradead.org; Thu, 15 Sep 2016 00:55:28 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8F0qfV4107999
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 20:55:02 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25es0pde37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 20:55:02 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 21:55:00 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 5343A1DC0070
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 20:54:57 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8F0svr24788448
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 21:54:57 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8F0sudD005215
 for <kexec@lists.infradead.org>; Wed, 14 Sep 2016 21:54:57 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v5 0/5] kexec_file: Add buffer hand-over for the next kernel
Date: Wed, 14 Sep 2016 21:54:45 -0300
Message-Id: <1473900890-1476-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: kexec@lists.infradead.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-kernel@vger.kernel.org, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Hello,

This version of the patch series fixes two issues:

1. The previous version modified struct kexec_segment, but that broke
   the ABI for at least 32-bit ARM.

2. The previous version didn't include the hand-over buffer in the kexec
   image checksum verification.

Now the kexec image checksum covers the hand-over buffer, and
kexec_update_segment verifes the checksum before updating the segment,
and calculates the new checksum afterwards.

In fact, for powerpc the image checksum now covers everything except the
digest itself so even the purgatory is verified. This is accomplished in
patch 1, and is an improvement that can be considered separately from the
other patches in the series. Unfortunately, x86 modifies the purgatory
segment during kernel_kexec so it still has to skip the purgatory from
the checksum.

Original cover letter:

This patch series implements a mechanism which allows the kernel to pass
on a buffer to the kernel that will be kexec'd. This buffer is passed
as a segment which is added to the kimage when it is being prepared
by kexec_file_load.

How the second kernel is informed of this buffer is architecture-specific.
On powerpc, this is done via the device tree, by checking
the properties /chosen/linux,kexec-handover-buffer-start and
/chosen/linux,kexec-handover-buffer-end, which is analogous to how the
kernel finds the initrd.

This is needed because the Integrity Measurement Architecture subsystem
needs to preserve its measurement list accross the kexec reboot. The
following patch series for the IMA subsystem uses this feature for that
purpose:

https://lists.infradead.org/pipermail/kexec/2016-August/016745.html

This is so that IMA can implement trusted boot support on the OpenPower
platform, because on such systems an intermediary Linux instance running
as part of the firmware is used to boot the target operating system via
kexec. Using this mechanism, IMA on this intermediary instance can
hand over to the target OS the measurements of the components that were
used to boot it.

Because there could be additional measurement events between the
kexec_file_load call and the actual reboot, IMA needs a way to update the
buffer with those additional events before rebooting. One can minimize
the interval between the kexec_file_load and the reboot syscalls, but as
small as it can be, there is always the possibility that the measurement
list will be out of date at the time of reboot.

To address this issue, this patch series also introduces
kexec_update_segment, which allows a reboot notifier to change the
contents of the image segment during the reboot process.

The last patch is not intended to be merged, it just demonstrates how
this feature can be used.

This series applies on top of v8 of the "kexec_file_load implementation
for PowerPC" patch series (which applies on top of v4.8-rc5 and -rc6):

https://lists.infradead.org/pipermail/kexec/2016-September/017123.html

Changes for v5:
- Rebased series on kexec_file_load patch series v8.
- Patch "kexec_file: Include the purgatory segment in the kexec image checksum."
  - New patch.
- Patch "kexec_file: Allow skipping checksum calculation for some segments."
  - Dropped patch.
- Patch "kexec_file: Add mechanism to update kexec segments."
  - Mostly rewritten.
  - Verify the kexec image checksum before updating the segment, and calculate
    the new checksum afterwards.

Changes for v4:
- Rebased series on kexec_file_load patch series v7.
- Patch "powerpc: kexec_file: Add buffer hand-over support for the next kernel"
  - Convert hand-over buffer address to physical address when calling
    memblock_free in kexec_free_handover_buffer.
  - Delete hand-over buffer properties from the live device tree in
    kexec_free_handover_buffer.
  - Remove the memory reservation and the properties for the hand-over
    buffer received from the previous kernel in setup_handover_buffer.
- Patch "IMA: Demonstration code for kexec buffer passing."
  - Fix checkpatch warnings. (Andrew Morton)

Changes for v3:
- Rebased series on kexec_file_load patch series v6.
  Both patch series apply cleanly on todays' Linus master branch, except
  for a few lines of fuzz in arch/powerpc/Makefile and arch/powerpc/Kconfig.
- Patch "kexec_file: Add buffer hand-over support for the next kernel"
  - Fix compilation warning in <linux/kexec.h> by adding a struct kexec_buf
    forward declaration when CONFIG_KEXEC_FILE=n. (Fenguang Wu)
- Patch "kexec_file: Allow skipping checksum calculation for some segments."
  - Substitute checksum argument in kexec_add_buffer with skip_checksum
    member in struct kexec_buf, as suggested by Dave Young.
- Patch "kexec_file: Add mechanism to update kexec segments."
  - Use kmap_atomic in kexec_update_segment, as suggested by Andrew Morton.
  - Fix build warning on m68k by passing unsigned long value to __va instead
    of void *. (Fenguang Wu)
  - Change bufsz and memsz arguments of kexec_update_segment to size_t to fix
    compilation warning. (Fenguang Wu)
- Patch "kexec: Share logic to copy segment page contents."
  - Dropped this patch.
- Patch "IMA: Demonstration code for kexec buffer passing."
  - Update to use kexec_buf.skip_checksum instead of passing it in
    kexec_add_buffer.

Changes for v2:
- Rebased on v5 of kexec_file_load implementation for PowerPC patch series.
- Patch "kexec_file: Add buffer hand-over support for the next kernel"
  - Changed kexec_add_handover_buffer to receive a struct kexec_buf, as
    suggested by Dave Young.
- Patch "powerpc: kexec_file: Add buffer hand-over support for the next kernel"
  - Moved setup_handover_buffer from kexec_elf_64.c to machine_kexec_64.c.
  - Call setup_handover_buffer from setup_new_fdt instead of elf64_load.
  - Changed kexec_get_handover_buffer to read from the expanded device tree
    instead of the flattened device tree.
- Patch "kexec_file: Add mechanism to update kexec segments.":
  - Removed unnecessary "#include <linux/highmem.h>" in kexec_file.c.
  - Round up memsz argument to PAGE_SIZE.
  - Check if kexec_image is NULL in kexec_update_segment.
- Patch "IMA: Demonstration code for kexec buffer passing."
  - Avoid registering reboot notifier again if kexec_file_load is called
    more than once.


Thiago Jung Bauermann (5):
  kexec_file: Include the purgatory segment in the kexec image checksum.
  kexec_file: Add buffer hand-over support for the next kernel
  powerpc: kexec_file: Add buffer hand-over support for the next kernel
  kexec_file: Add mechanism to update kexec segments.
  IMA: Demonstration code for kexec buffer passing.

 arch/powerpc/include/asm/kexec.h       |  12 +-
 arch/powerpc/kernel/kexec_elf_64.c     |   2 +-
 arch/powerpc/kernel/machine_kexec_64.c | 274 +++++++++++++++---
 arch/powerpc/purgatory/purgatory.c     |   4 +-
 arch/x86/Kconfig                       |   6 +
 arch/x86/purgatory/purgatory.c         |   2 +-
 include/linux/ima.h                    |  11 +
 include/linux/kexec.h                  |  39 +++
 kernel/kexec_core.c                    |   5 -
 kernel/kexec_file.c                    | 503 +++++++++++++++++++++++++++++++--
 kernel/kexec_internal.h                |   6 +
 security/integrity/ima/ima.h           |   5 +
 security/integrity/ima/ima_init.c      |  26 ++
 security/integrity/ima/ima_template.c  |  85 ++++++
 14 files changed, 893 insertions(+), 87 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

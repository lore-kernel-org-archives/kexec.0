Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bczF4-0003IE-Ty
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 18:19:08 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7PIG7MW133690
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 14:18:45 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 250xbkry2a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 14:18:45 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 25 Aug 2016 15:18:42 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 9BA0A352006C
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 14:18:19 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7PIIfcU5210298
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 15:18:41 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7PIIevA017506
 for <kexec@lists.infradead.org>; Thu, 25 Aug 2016 15:18:41 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH v3 0/5] kexec_file: Add buffer hand-over for the next kernel
Date: Thu, 25 Aug 2016 15:18:26 -0300
Message-Id: <1472149111-30598-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org, Eric Richter <erichte@linux.vnet.ibm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-ima-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hello,

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

This series applies on top of v6 of the "kexec_file_load implementation
for PowerPC" patch series (which applies on top of v4.8-rc1):

https://lists.infradead.org/pipermail/kexec/2016-August/016960.html

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
  kexec_file: Add buffer hand-over support for the next kernel
  powerpc: kexec_file: Add buffer hand-over support for the next kernel
  kexec_file: Allow skipping checksum calculation for some segments.
  kexec_file: Add mechanism to update kexec segments.
  IMA: Demonstration code for kexec buffer passing.

 arch/powerpc/include/asm/kexec.h       |  12 +++-
 arch/powerpc/kernel/kexec_elf_64.c     |   2 +-
 arch/powerpc/kernel/machine_kexec_64.c | 114 +++++++++++++++++++++++++++++++--
 include/linux/ima.h                    |  11 ++++
 include/linux/kexec.h                  |  56 +++++++++++++---
 kernel/kexec_core.c                    |  99 ++++++++++++++++++++++++++++
 kernel/kexec_file.c                    |  87 ++++++++++++++++++++++---
 security/integrity/ima/ima.h           |   5 ++
 security/integrity/ima/ima_init.c      |  26 ++++++++
 security/integrity/ima/ima_template.c  |  85 ++++++++++++++++++++++++
 10 files changed, 472 insertions(+), 25 deletions(-)

-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

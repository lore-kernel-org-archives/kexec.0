Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bPhiU-0001BV-RU
 for kexec@lists.infradead.org; Wed, 20 Jul 2016 02:58:35 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/3] Enable legacy irq mode before jump to kexec/kdump kernel
Date: Wed, 20 Jul 2016 10:58:00 +0800
Message-Id: <1468983483-3952-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, Baoquan He <bhe@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, weijg.fnst@cn.fujitsu.com, jiang.liu@linux.intel.com, vgoyal@redhat.com

Wei Jiangang reported kdump kernel always hang when "notsc" is specified
in boot parameter. After debugging I found there's no timer interrupt
in the current kexec/kdump kernel. This is caused by commit 522e66464467
("x86/apic: Disable I/O APIC before shutdown of the local APIC"). Originally
Eric posted below patch to make system be virtual wire mode in which 8259-
equivalent PIC fields all interrupts and the LAPIC becomes a virtual wire.
Like this interrupts can be delivered from PIC to CPU via the LAPIC's local
interrupt 0 (LINTIN0). In virtual wire APIC mode is disabled while LAPIC
is software enabled and its LINT0 and LINT1 need be programmed specifically.

https://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm1/broken-out/x86_64-apic-virtwire-on-shutdown.patch

But with commit 522e66464 you can see after disable_IO_APIC had setting
virtual wire mode, lapic_shutdown disabled LAPIC again. Now virtual wire
mode doesn't work, then it cause no timer interrupt during kdump kernel
initialization stage until system enter into APIC mode.

So people may be wondering why only kdump kernel hang, the normal kernel
with "notsc" can still work. This is because BIOS has already built PIC mode
or virtual wire mode while kexec/kdump kernel doesn't go through BIOS
initialization. That is why we have to change system to be PIC mode or
virtual wire mode before jump to kexec/kdump kernel.

Then why kdump kernel didn't hang when "notsc" is not specified. This is
because tsc_init will assign the already calibrated value to lpj_fine.
Then kernel doesn't need to count cpu loops between jiffies with the help
of timer interrupt. So "notsc" is not victim, but a informer.

In patch 1/3 disable_IO_APIC is changed to only contain code of changeing
system to be PIC mode or virtual wire mode and is renamed as
switch_to_legacy_irq_mode. Now only call clear_IO_APIC where IO-APIC need
be disabled, and call switch_to_legacy_irq_mode before jump to kexe/kdump
kernel.

Patch 2/3 and 3/3 are clean up patch.

Baoquan He (3):
  x86/apic/kexec: Enable legacy irq mode before jump to kexec/kdump
    kernel
  x86/apic: Clean up the names of legacy irq mode setting related
    functions
  x86/apic: Clean up the apic delivery mode macro definition

 arch/x86/include/asm/apic.h        |  2 +-
 arch/x86/include/asm/apicdef.h     |  1 -
 arch/x86/include/asm/io_apic.h     |  6 +++---
 arch/x86/kernel/apic/apic.c        | 19 +++++++++++--------
 arch/x86/kernel/apic/io_apic.c     | 32 +++++++++++++++++---------------
 arch/x86/kernel/crash.c            |  2 +-
 arch/x86/kernel/machine_kexec_32.c | 15 +++++----------
 arch/x86/kernel/machine_kexec_64.c | 15 +++++----------
 arch/x86/kernel/reboot.c           |  2 +-
 arch/x86/kernel/x86_init.c         |  2 +-
 drivers/iommu/irq_remapping.c      |  2 +-
 11 files changed, 46 insertions(+), 52 deletions(-)

-- 
2.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

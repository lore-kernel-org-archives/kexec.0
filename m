Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjJZp-00068v-HO
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 02:01:07 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2254E3EE1D9
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:00:35 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 12F2C45DE6C
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:00:35 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.nic.fujitsu.com [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DE61845DE53
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:00:34 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CEFD8E08004
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:00:34 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 63BCDE08012
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 11:00:34 +0900 (JST)
Subject: [PATCH v6 0/3] x86, apic, kexec: Add disable_cpu_apic kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Thu, 21 Nov 2013 11:00:33 +0900
Message-ID: <20131121015951.2748.47826.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: hpa@linux.intel.com, ebiederm@xmission.com, vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bp@alien8.de, akpm@linux-foundation.org, fengguang.wu@intel.com, jingbai.ma@hp.com

This patch set is to allow kdump 2nd kernel to wake up multiple CPUs,
a continueing work from:

  [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
  https://lkml.org/lkml/2013/10/16/300.

At v4, basic design has changed. Now users need to figure out initial
APIC ID of BSP in the 1st kernel and configures kernel parameter for
the 2nd kernel manually using disable_cpu_apic kernel parameter, which
is newly introduced by this patch set. This design is more flexible
than the previous version in that we no longer have to rely on ACPI/MP
table to get initial APIC ID of BSP.

Sorry, this patch set have not include in-source documentation
requested by Borislav Petkov yet, but I'll post it later separately,
which would be better to focus on documentation reviewing.

ChangeLog

v5 => v6)

- Remove use of rdmsr(IA32_APIC_BASE) to initialize
  bsp_physical_apicid since the MSR doesn't work well on some cluster
  systems, suggested by HPA. Also, current users of the variable
  expects the initial apicid reported through MP table only; removing
  the use of the MSR is not problematic.

- Rename bsp_physical_apicid as bios_bsp_physical_apicid to make it
  clear that the apidid contained there is the one reported from some
  BIOS table. Also, initialize it not only by MP table but also by
  ACPI MADT.

- Change message displayed when specified cpu is disabled from:

  ACPI: Disable specified CPU. Processor 0/0x0 ignored.

  to:

  ACPI: Disabling requested cpu. Processor 0/0x0 ignored.

v4 => v5)

- Rebased on top of v3.12

- Introduce bsp_physical_apicid that has the initial APIC ID for the
  processor with BSP flag on IA32_APIC_BASE MSR. Without this,
  boot_cpu_physical_apicid has temporarilly the value around MP table
  related codes, although it's designed to have the initial APIC ID
  for the processor that is doing the boot up. Use the
  bsp_physical_apicid in MP table related codes; no impact on
  semantics at runtime there.

v3 => v4)

- Rebased on top of v3.12-rc6

- Basic design has been changed. Now users need to figure out initial
  APIC ID of BSP in the 1st kernel and configures kernel parameter for
  the 2nd kernel manually using disable_cpu_apic kernel parameter to
  be newly introduced in this patch set. This design is more flexible
  than the previous version in that we no longer have to rely on
  ACPI/MP table to get initial APIC ID of BSP.

v2 => v3)

- Change default value of boot_cpu_is_bsp to true.

- Before executing rdmsr(MSR_IA32_APICBASE), check if the number of
  processor family is larger than or equal to 6 in order to avoid
  invalid opcode exception on processors where MSR_IA32_APICBASE is
  not supported.

v1 => v2)

- Rebased on top of v3.12-rc5.

- Fix linking time error of boot_cpu_is_bsp_init() in case of
  CONFIG_LOCAL_APIC disabled by adding empty static inline function
  instead.

- Fix missing feature check by means of cpu_has_apic macro in
  boot_cpu_is_bsp_init() before calling rdmsr_safe(MSR_IA32_APICBASE).

  NOTE: I've checked local apic-present case only; I don't have any
  x86 processor without local apic.

- Add __init annotation to boot_cpu_is_bsp_init().

Test

- built with and without CONFIG_LOCAL_APIC
- tested x86_64 in case of acpi and MP table
- tested disable_cpu_apicid=<n> to disable both AP and BSP

---

HATAYAMA Daisuke (3):
      x86, apic: add bios_bsp_physical_apicid
      x86, apic: Add disable_cpu_apicid kernel parameter
      Documentation, x86, apic, kexec: Add disable_cpu_apicid kernel parameter


 Documentation/kernel-parameters.txt    |    9 ++++++++
 arch/x86/include/asm/mpspec.h          |    1 +
 arch/x86/kernel/acpi/boot.c            |    8 +++++++
 arch/x86/kernel/apic/apic.c            |   38 ++++++++++++++++++++++++++++++++
 arch/x86/kernel/mpparse.c              |    2 +-
 arch/x86/mm/amdtopology.c              |    6 +++--
 arch/x86/platform/visws/visws_quirks.c |    2 +-
 7 files changed, 61 insertions(+), 5 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

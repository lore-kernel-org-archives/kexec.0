Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VYdSz-0005Zr-AA
 for kexec@lists.infradead.org; Tue, 22 Oct 2013 15:01:55 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D6D623EE0BD
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:26 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B1A4B45DE55
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 775BE45DE65
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:26 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5BA211DB803F
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:26 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2DACB1DB8073
 for <kexec@lists.infradead.org>; Wed, 23 Oct 2013 00:01:22 +0900 (JST)
Subject: [PATCH v4 0/3] x86, apic, kexec: Add disable_cpu_apic kernel parameter
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Wed, 23 Oct 2013 00:01:18 +0900
Message-ID: <20131022150015.24240.39686.stgit@localhost6.localdomain6>
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

This patch set is to allow kdump 2nd kernel to wake up multiple CPUs
even if 1st kernel crashs on some AP, a continueing work from:

  [PATCH v3 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
  https://lkml.org/lkml/2013/10/16/300.

In this version, basic design has changed. Now users need to figure
out initial APIC ID of BSP in the 1st kernel and configures kernel
parameter for the 2nd kernel manually using disable_cpu_apic kernel
parameter to be newly introduced in this patch set. This design is
more flexible than the previous version in that we no longer have to
rely on ACPI/MP table to get initial APIC ID of BSP.

Sorry, this patch set have not include in-source documentation
requested by Borislav Petkov yet, but I'll post it later separately,
which would be better to focus on documentation reviewing.

ChangeLog

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

---

HATAYAMA Daisuke (3):
      x86, apic: Don't count the CPU with BP flag from MP table as booting-up CPU
      x86, apic: Add disable_cpu_apicid kernel parameter
      Documentation, x86, apic, kexec: Add disable_cpu_apicid kernel parameter


 Documentation/kernel-parameters.txt |    9 +++++++++
 arch/x86/kernel/apic/apic.c         |   29 +++++++++++++++++++++++++++++
 arch/x86/kernel/mpparse.c           |    1 -
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVxQ2-0005Dn-N8
 for kexec@lists.infradead.org; Tue, 15 Oct 2013 05:43:47 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id DE8123EE0BC
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:17 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id CEE0545DE5A
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id B713445DE54
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:17 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A55581DB8044
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:17 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5BBB81DB804C
 for <kexec@lists.infradead.org>; Tue, 15 Oct 2013 14:43:17 +0900 (JST)
Subject: [PATCH v2 0/2] x86, apic, kdump: Disable BSP if boot cpu is AP
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Tue, 15 Oct 2013 14:43:16 +0900
Message-ID: <20131015054214.13666.11737.stgit@localhost6.localdomain6>
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
even if 1st kernel crashs on some AP.

This version is for fixing building failure of tip tree reported by
some bot and also adding the other fixes I missed out from previous
experimental version I posted last year; see ChangeLog.

Sorry, this patch set have not include in-source documentation
requested by Borislav Petkov yet, but I'll post it later separately,
which would be better to focus on documentation reviewing.

ChangeLog

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

HATAYAMA Daisuke (2):
      x86, apic: Add boot_cpu_is_bsp() to check if boot cpu is BSP
      x86, apic: Disable BSP if boot cpu is AP


 arch/x86/include/asm/mpspec.h |    9 ++++++++-
 arch/x86/kernel/acpi/boot.c   |    6 +++++-
 arch/x86/kernel/apic/apic.c   |   34 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/devicetree.c  |    1 +
 arch/x86/kernel/mpparse.c     |   15 +++++++++++++--
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/platform/sfi/sfi.c   |    2 +-
 7 files changed, 63 insertions(+), 6 deletions(-)

-- 

Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

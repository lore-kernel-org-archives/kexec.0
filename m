Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TNysI-0003b0-0C
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 04:35:26 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1CCB43EE0C0
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 13:35:23 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 2C38945DE63
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 13:35:19 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id E992F45DE4D
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 13:35:18 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B7CEC1DB8051
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 13:35:18 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 372791DB804A
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 13:35:18 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH v1 0/2] x86, apic: Disable BSP if boot cpu is AP
Date: Tue, 16 Oct 2012 13:35:17 +0900
Message-ID: <20121016043357.20003.5885.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: len.brown@intel.com, fenghua.yu@intel.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, d.hatayama@jp.fujitsu.com, ebiederm@xmission.com, hpa@zytor.com, mingo@elte.hu, tglx@linutronix.de, vgoyal@redhat.com

Multiple CPUs are useful for CPU-bound processing like compression and
I do want to use compression to generate crash dump quickly. But now
we cannot wakeup the 2nd and later cpus in the kdump 2nd kernel if
crash happens on AP. If crash happens on AP, kexec enters the 2nd
kernel with the AP, and there BSP in the 1st kernel is expected to be
haling in the 1st kernel or possibly in any fatal system error state.

To wake up AP, we use the method called INIT-INIT-SIPI. INIT causes
BSP to jump into BIOS init code. A typical visible behaviour is hang
or immediate reset, depending on the BIOS init code.

AP can be initiated by INIT even in a fatal state: MP spec explains
that processor-specific INIT can be used to recover AP from a fatal
system error. On the other hand, there's no method for BSP to recover;
it might be possible to do so by NMI plus any hand-coded reset code
that is carefully designed, but at least I have no idea in this
direction now.

Therefore, the idea I do in this patch set is simply to disable BSP if
vboot cpu is AP.

My motivation is to use multiple CPUs in order to quickly generate
crash dump on the machine with huge amount of memory. I assume such
machine tends to also have a lot of CPUs. So disabling one CPU would
be no problem.

On most BIOSs, BSP is always assigned to cpu#1; on other BIOSs, BSP
could probably be assigned to a fixed cpu number. Assuming this fact,
it might be possible to choose an idea that waking up the cpus except
for cpu#1, not waking up cpu#1 only. But I don't choose this in this
patch set because:

- It's ugly desgin to keep switch in sysfs that can unintentionally
  cause system to enter undefined behaviour.

- Memory space for BSP is never used if BSP is not running. Amount of
  reserved memory for 2nd kernel is typically from 128MB to 512MB
  only, severely limited. If BSP is unused, I want to use the space
  for another AP instead.

Note: recent upstream kernel fails reserving memory for kdump 2nd
kernel. To run kdump, please apply the patch below on top of this
patch set:
https://lkml.org/lkml/2012/8/31/238

---

HATAYAMA Daisuke (2):
      x86, apic: Disable BSP if boot cpu is AP
      x86, apic: Introduce boot_cpu_is_bsp indicating whether boot cpu is BSP or not


 arch/x86/include/asm/mpspec.h |    5 ++++-
 arch/x86/kernel/acpi/boot.c   |   10 +++++++++-
 arch/x86/kernel/apic/apic.c   |   34 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/devicetree.c  |    2 +-
 arch/x86/kernel/mpparse.c     |   15 +++++++++++++--
 arch/x86/kernel/setup.c       |    2 ++
 arch/x86/platform/sfi/sfi.c   |    2 +-
 7 files changed, 63 insertions(+), 7 deletions(-)

-- 
Thanks.
HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

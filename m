Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2Rkw-0006YJ-M4
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 03:02:52 +0000
Received: by mail-pl1-x641.google.com with SMTP id d3so11044143plr.1
 for <kexec@lists.infradead.org>; Mon, 26 Aug 2019 20:02:48 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCHv2 0/4] x86/mce: protect nr_cpus from rebooting by broadcast mce
Date: Tue, 27 Aug 2019 11:02:19 +0800
Message-Id: <1566874943-4449-1-git-send-email-kernelfans@gmail.com>
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
To: Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, Daniel Drake <drake@endlessm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qian Cai <cai@lca.pw>, Dave Young <dyoung@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Eric Biederman <ebiederm@xmission.com>

v1 -> v2: fix compile warning and error on x86_32


This series include two related groups:
[1-3/4]: protect nr_cpus from rebooting by broadcast mce
[4/4]: improve "kexec -l" robustness against broadcast mce

When I tried to fix [1], Thomas raised concern about the nr_cpus' vulnerability
to unexpected rebooting by broadcast mce. After analysis, I think only the
following first case suffers from the rebooting by broadcast mce. [1-3/4] aims
to fix that issue.

*** Back ground ***

On x86 it's required to have all logical CPUs set CR4.MCE=1. Otherwise, a
broadcast MCE observing CR4.MCE=0b on any core will shutdown the machine.

The option 'nosmt' has already complied with the above rule by Thomas's patch.
For detail, refer to 506a66f3748 (Revert "x86/apic: Ignore secondary threads if
nosmt=force")

But for nr_cpus option, the exposure to broadcast MCE is a little complicated,
and can be categorized into three cases.

-1. boot up by BIOS. Since no one set CR4.MCE=1, nr_cpus risks rebooting by
broadcast MCE.

-2. boot up by "kexec -p nr_cpus=".  Since the 1st kernel has all cpus'
CR4.MCE=1 set before kexec -p, nr_cpus is free of rebooting by broadcast MCE.
Furthermore, the crashed kernel's wreckage, including page table and text, is
not touched by capture kernel. Hence if MCE event happens on capped cpu,
do_machine_check->__mc_check_crashing_cpu() runs smoothly and returns
immediately, the capped cpu is still pinned on "halt".

-3. boot up by "kexec -l nr_cpus=". As "kexec -p", it is free of rebooting by
broadcast MCE. But the 1st kernel's wreckage is discarded and changed.  when
capped cpus execute do_machine_check(), they may crack the new kernel.  But
this is not related with broadcast MCE, and need an extra fix.

*** Solution ***
"nr_cpus" can not follow the same way as "nosmt".  Because nr_cpus limits the
allocation of percpu area and some other kthread memory, which is critical to
cpu hotplug framework.  Instead, developing a dedicated SIPI callback
make_capped_cpu_stable() for capped cpu, which does not lean on percpu area to
work.

[1]: https://lkml.org/lkml/2019/7/5/3

To: Gleixner <tglx@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

---
Pingfan Liu (4):
  x86/apic: correct the ENO in generic_processor_info()
  x86/apic: record capped cpu in generic_processor_info()
  x86/smp: send capped cpus to a stable state when smp_init()
  x86/smp: disallow MCE handler on rebooting AP

 arch/x86/include/asm/apic.h  |  1 +
 arch/x86/include/asm/smp.h   |  3 ++
 arch/x86/kernel/apic/apic.c  | 23 ++++++++----
 arch/x86/kernel/cpu/common.c |  7 ++++
 arch/x86/kernel/smp.c        |  8 +++++
 arch/x86/kernel/smpboot.c    | 83 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/smp.c                 |  6 ++++
 7 files changed, 124 insertions(+), 7 deletions(-)

-- 
2.7.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

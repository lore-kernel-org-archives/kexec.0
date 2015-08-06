Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZNE1y-0001D9-M5
 for kexec@lists.infradead.org; Thu, 06 Aug 2015 05:47:56 +0000
Subject: [V3 PATCH 0/4] Fix race issues among panic, NMI and crash_kexec
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 06 Aug 2015 14:45:43 +0900
Message-ID: <20150806054543.25766.29590.stgit@softrs>
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
To: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

When an HA cluster software or administrator detects non-response
of a host, they issue an NMI to the host to completely stop current
works and take a crash dump.  If the kernel has already panicked
or is capturing a crash dump at that time, further NMI can cause
a crash dump failure.

Also, crash_kexec() called from oops context and panic() can
cause race conditions.

To solve these issue, this patch set does following things:

- Don't panic on NMI if the kernel has already panicked
- Extend exclusion control currently done by panic_lock to crash_kexec
- Introduce "noextnmi" boot option which masks external NMI at the
  boot time (supported only for x86)

V3:
- Introduce nmi_panic() macro to reduce code duplication
- In the case of panic on NMI, don't return from NMI handlers
  if another cpu already panicked

V2:
- Use atomic_cmpxchg() instead of current spin_trylock() to exclude
  concurrent accesses to panic() and crash_kexec()
- Don't introduce no-lock version of panic() and crash_kexec()

---

Hidehiro Kawai (4):
      panic/x86: Fix re-entrance problem due to panic on NMI
      panic/x86: Allow cpus to save registers even if they are looping in NMI context
      kexec: Fix race between panic() and crash_kexec() called directly
      x86/apic: Introduce noextnmi boot option


 Documentation/kernel-parameters.txt |    4 ++++
 arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
 arch/x86/kernel/nmi.c               |   15 +++++++++++----
 arch/x86/kernel/reboot.c            |   11 +++++++++++
 include/linux/kernel.h              |   21 +++++++++++++++++++++
 kernel/kexec.c                      |   20 ++++++++++++++++++++
 kernel/panic.c                      |   23 ++++++++++++++++++++---
 kernel/watchdog.c                   |    5 +++--
 8 files changed, 106 insertions(+), 10 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

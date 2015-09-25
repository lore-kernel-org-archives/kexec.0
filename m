Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfRin-0005VX-2o
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 12:03:27 +0000
Subject: [V4 PATCH 0/4] Fix race issues among panic, NMI and crash_kexec
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 25 Sep 2015 20:28:03 +0900
Message-ID: <20150925112803.4258.94241.stgit@softrs>
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

When an HA clustering software or administrator detects unresponsivenes
of a host, they issue an NMI to the host to completely stop current
works and take a crash dump.  If the kernel has already panicked
or is capturing a crash dump at that time, further NMI can cause
a crash dump failure.

Also, crash_kexec() called from oops context and panic() can
cause race conditions.

To solve these issues, this patch set does following things:

- Don't call panic() on NMI if the kernel has already panicked
- Extend exclusion control currently done by panic_lock to crash_kexec
- Introduce "noextnmi" boot option which masks external NMI at the
  boot time (supported only for x86)

This patch set can be applied to current -tip tree.

V4:
- Improve comments and descriptions (PATCH 1/4 to 3/4)
- Use new __crash_kexec(), no exclusion check version of crash_kexec(),
  instead of checking if panic_cpu is the current cpu or not
  (PATCH 3/4)

V3: https://lkml.org/lkml/2015/8/6/39
- Introduce nmi_panic() macro to reduce code duplication
- In the case of panic on NMI, don't return from NMI handlers
  if another cpu already panicked

V2: https://lkml.org/lkml/2015/7/27/31
- Use atomic_cmpxchg() instead of current spin_trylock() to exclude
  concurrent accesses to panic() and crash_kexec()
- Don't introduce no-lock version of panic() and crash_kexec()

V1: https://lkml.org/lkml/2015/7/22/81

---

Hidehiro Kawai (4):
      panic/x86: Fix re-entrance problem due to panic on NMI
      panic/x86: Allow cpus to save registers even if they are looping in NMI context
      kexec: Fix race between panic() and crash_kexec() called directly
      x86/apic: Introduce noextnmi boot option


 Documentation/kernel-parameters.txt |    4 ++++
 arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
 arch/x86/kernel/nmi.c               |   16 ++++++++++++----
 arch/x86/kernel/reboot.c            |   11 +++++++++++
 include/linux/kernel.h              |   21 +++++++++++++++++++++
 include/linux/kexec.h               |    1 +
 kernel/kexec_core.c                 |   26 +++++++++++++++++++++++++-
 kernel/panic.c                      |   29 ++++++++++++++++++++++++-----
 kernel/watchdog.c                   |    5 +++--
 9 files changed, 117 insertions(+), 13 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

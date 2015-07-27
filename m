Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJahK-0000Qj-KS
 for kexec@lists.infradead.org; Mon, 27 Jul 2015 05:11:36 +0000
Subject: [V2 PATCH 0/3] x86: Fix panic vs. NMI issues
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Mon, 27 Jul 2015 10:58:50 +0900
Message-ID: <20150727015850.4928.87717.stgit@softrs>
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

To solve this issue, this patch set does two things:

- Don't panic on NMI if the kernel has already panicked
- Introduce "noextnmi" boot option which masks external NMI at the
  boot time (supported only for x86)

V2:
- Use atomic_cmpxchg() instead of current spin_trylock() to exclude
  concurrent accesses to panic() and crash_kexec()
- Don't introduce no-lock version of panic() and crash_kexec()

---

Hidehiro Kawai (3):
      x86/panic: Fix re-entrance problem due to panic on NMI
      kexec: Fix race between panic() and crash_kexec() called directly
      x86/apic: Introduce noextnmi boot option


 Documentation/kernel-parameters.txt |    4 ++++
 arch/x86/kernel/apic/apic.c         |   17 ++++++++++++++++-
 arch/x86/kernel/nmi.c               |   15 +++++++++++----
 include/linux/kernel.h              |    1 +
 kernel/kexec.c                      |   20 ++++++++++++++++++++
 kernel/panic.c                      |   13 ++++++++++---
 6 files changed, 62 insertions(+), 8 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

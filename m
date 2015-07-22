Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail4.hitachi.co.jp ([133.145.228.5])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZHobE-0006Xz-Cq
 for kexec@lists.infradead.org; Wed, 22 Jul 2015 07:37:57 +0000
Subject: [PATCH 0/3] x86: Fix panic vs. NMI issues
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 22 Jul 2015 11:14:21 +0900
Message-ID: <20150722021421.5155.74460.stgit@softrs>
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
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

When an HA cluster software or administrator detects non-response
of a host, they issue an NMI to the host to completely stop current
works and take a crash dump.  If the kernel has already panicked
or is capturing a crash dump at that time, further NMI can cause
a crash dump failure.

To solve this issue, this patch set does two things:

- Don't panic on NMI if the kernel has already panicked
- Introduce "noextnmi" boot option which masks external NMI at the
  boot time (supported only for x86)

---

Hidehiro Kawai (3):
      x86/panic: Fix re-entrance problem due to panic on NMI
      kexec: Fix race between panic() and crash_kexec() directly called
      x86/apic: Introduce noextnmi boot option


 Documentation/kernel-parameters.txt |    4 ++++
 arch/x86/kernel/apic/apic.c         |   17 +++++++++++++++-
 arch/x86/kernel/nmi.c               |   18 +++++++++++------
 include/linux/kernel.h              |    4 ++++
 include/linux/kexec.h               |    2 ++
 kernel/kexec.c                      |   12 ++++++++++-
 kernel/panic.c                      |   37 ++++++++++++++++++++++++++---------
 7 files changed, 76 insertions(+), 18 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

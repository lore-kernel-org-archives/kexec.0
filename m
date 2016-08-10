Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXOex-0008JG-8f
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 08:14:45 +0000
Subject: [V4 PATCH 0/2] kexec: crash_kexec_post_notifiers boot option related
 fixes
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Wed, 10 Aug 2016 17:09:46 +0900
Message-ID: <20160810080946.11028.97686.stgit@sysi4-13.yrl.intra.hitachi.co.jp>
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
To: Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Xunlei Pang <xpang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel Walker <dwalker@fifo99.com>, xen-devel@lists.xenproject.org, Vivek Goyal <vgoyal@redhat.com>

Daniel Walker reported problems which happens when
crash_kexec_post_notifiers kernel option is enabled
(https://lkml.org/lkml/2015/6/24/44).

In that case, smp_send_stop() is called before entering kdump routines
which assume other CPUs are still online.  This causes some issues
depending on architectures.  For example, for x86, kdump routines fail
to save other CPUs' registers and disable virtualization extensions.
For MIPS OCTEON, it fails to stop the watchdog timer.

To fix this problem, call a new kdump friendly function,
crash_smp_send_stop(), instead of the smp_send_stop() when
crash_kexec_post_notifiers is enabled.  crash_smp_send_stop() is a
weak function, and it just call smp_send_stop().  Architecture
codes should override it so that kdump can work appropriately.
This patch set supports only x86 and MIPS.

NOTE:
- Right solution would be to place crash_smp_send_stop() before
  __crash_kexec() invocation in all cases and remove smp_send_stop(),
  but we can't do that until all architectures implement own
  crash_smp_send_stop()
- crash_smp_send_stop()-like work is still needed by
  machine_crash_shutdown() because crash_kexec() can be called without
  entering panic()

Changes in V4:
- Keep to use smp_send_stop if crash_kexec_post_notifiers is not set
- Rename panic_smp_send_stop to crash_smp_send_stop
- Don't change the behavior for Xen's PV kernel
- Support MIPS

Changes in V3: https://lkml.org/lkml/2016/7/5/221
- Revise comments, description, and symbol names (the logic doesn't
  change)
- Make crash_kexec_post_notifiers boot option modifiable after boot

Changes in V2: https://lkml.org/lkml/2015/7/23/864
- Replace smp_send_stop() call with crash_kexec version which
  saves cpu states and does cleanups instead of changing execution
  flow
- Drop a fix for Problem 1
- Drop other patches because they aren't needed anymore

V1: https://lkml.org/lkml/2015/7/10/316

---

Hidehiro Kawai (2):
      x86/panic: Replace smp_send_stop() with kdump friendly version in panic path
      mips/panic: Replace smp_send_stop() with kdump friendly version in panic path


 arch/mips/cavium-octeon/setup.c  |   14 +++++++++++
 arch/mips/include/asm/kexec.h    |    1 +
 arch/mips/kernel/crash.c         |   18 ++++++++++++++-
 arch/mips/kernel/machine_kexec.c |    1 +
 arch/x86/include/asm/kexec.h     |    1 +
 arch/x86/include/asm/smp.h       |    1 +
 arch/x86/kernel/crash.c          |   22 +++++++++++++++---
 arch/x86/kernel/smp.c            |    5 ++++
 kernel/panic.c                   |   47 ++++++++++++++++++++++++++++++++------
 9 files changed, 99 insertions(+), 11 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

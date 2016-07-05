Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bKOfC-00041u-Up
 for kexec@lists.infradead.org; Tue, 05 Jul 2016 11:37:15 +0000
Subject: [V3 PATCH 0/2] kexec: crash_kexec_post_notifiers boot option
 related fixes
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Tue, 05 Jul 2016 20:33:23 +0900
Message-ID: <20160705113323.5864.66834.stgit@softrs>
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
To: Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <mhiramat@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Daniel Walker <dwalker@fifo99.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

This is the update version of the patch which I posted one year ago
(https://lkml.org/lkml/2015/7/23/864).  Because I couldn't received
positive opinions against the previous version, I had changed the
approach to another one which utilizes kexec purgatory.  Then I'm
back here.

PATCH 1/2 is a bugfix for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.  When this option is enabled, smp_send_stop() is used to stop
other CPUs instead of a function provided by kdump.  smp_send_stop()
just stops other CPUs and doesn't other things needed for kdump.
So, fix it by replacing smp_send_stop() with new appropriate one,
panic_smp_send_stop().  Since panic_smp_send_stop() is architecture
specific and I can't simply copy from kdump routines, only
x86-specific version is provided.

PATCH 2/2 makes crash_kexec_post_notifiers boot option modifiable
after boot.  We don't need to limit it to being modifiable at boot
time.

Changes in V3:
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
      x86/panic: Replace smp_send_stop() with kdump friendly version
      kexec: Use core_param for crash_kexec_post_notifiers boot option


 arch/x86/kernel/crash.c |   14 ++++++++----
 kernel/panic.c          |   56 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 24 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

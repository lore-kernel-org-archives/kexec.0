Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZIRg5-0004PC-PP
 for kexec@lists.infradead.org; Fri, 24 Jul 2015 01:21:34 +0000
Subject: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot option
 related fixes
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 24 Jul 2015 10:16:15 +0900
Message-ID: <20150724011615.6834.79628.stgit@softrs>
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
To: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Daniel Walker <dwalker@fifo99.com>, Ingo Molnar <mingo@kernel.org>

This is a bugfix patch for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.

This fixes one of the problems reported by Daniel Walker
(https://lkml.org/lkml/2015/6/24/44). 

 Problem 1:
 If crash_kexec_post_notifiers boot option is specified, some
 shutting down process which assume other cpus are still alive
 don't work properly.

 Problem 2 (addressed by this patch):
 If crash_kexec_post_notifiers boot option is specified, register
 information of other cpus are not saved to crash dumps.

Following Vivek's opinion, this patch replaces smp_send_stop()
in panic() with suitable version for crash_kexec which saves
cpu states and other things like cleaning up VMX/SVM.  Since this
needs architecture specific implementation and it's not so trivial,
this version only support for x86.  So the problem 1, known to
happen on MIPS/OCTEON, is not addressed now.

To keep the modification impact low, this patch doesn't change
the logic basically if crash_kexec_post_notifiers is not specified.

Please note that crash_kexec() can be called directly without
entering panic().  Stopping other cpus functionality is still
needed in crash_kexec().

Changes in V2:
- Replace smp_send_stop() call with crash_kexec version which
  saves cpu states and does cleanups instead of changing execution
  flow
- Drop a fix for Problem 1
- Drop other patches because they aren't needed anymore

V1: https://lkml.org/lkml/2015/7/10/316

---

Hidehiro Kawai (1):
      panic/x86: Replace smp_send_stop() with crash_kexec version


 arch/x86/kernel/crash.c |   16 +++++++++++-----
 kernel/panic.c          |   29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 11 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

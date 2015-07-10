Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: [PATCH 0/3] kexec: crash_kexec_post_notifiers boot option related
 fixes
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Fri, 10 Jul 2015 20:33:31 +0900
Message-ID: <20150710113331.4368.10495.stgit@softrs>
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
Cc: linux-mips@linux-mips.org, Baoquan He <bhe@redhat.com>, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-metag@vger.kernel.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Daniel Walker <dwalker@fifo99.com>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org

This is a bugfix patch set for crash_kexec_post_notifiers boot option
which allows users to call panic notifiers and kmsg dumpers before
kdump.

The main patch is PATCH 3/3, and it fixes two problems reported by
Daniel Walker (https://lkml.org/lkml/2015/6/24/44). 

 Problem 1:
 If crash_kexec_post_notifiers boot option is specified, some
 shutting down process which assume other cpus are still alive
 don't work properly.

 Problem 2:
 If crash_kexec_post_notifiers boot option is specified, register
 information of other cpus are not saved to crash dumps.

PATCH 3/3 is also another solution for a bug reported by Daisuke
Hatayama (https://lkml.org/lkml/2015/5/15/284).  So, this patch
replace commits 5375b70 and f45d85f which fix the bug.

---

Hidehiro Kawai (3):
      panic: Disable crash_kexec_post_notifiers if kdump is not available
      kexec: Pass panic message to crash_kexec()
      kexec: Change the timing of callbacks related to "crash_kexec_post_notifiers" boot option


 Documentation/kernel-parameters.txt |    4 ++
 arch/arm/kernel/traps.c             |    2 +
 arch/arm64/kernel/traps.c           |    2 +
 arch/metag/kernel/traps.c           |    2 +
 arch/mips/kernel/traps.c            |    2 +
 arch/powerpc/kernel/traps.c         |    2 +
 arch/s390/kernel/ipl.c              |    2 +
 arch/sh/kernel/traps.c              |    2 +
 arch/x86/kernel/dumpstack.c         |    2 +
 arch/x86/platform/uv/uv_nmi.c       |    2 +
 include/linux/kernel.h              |    1 +
 include/linux/kexec.h               |    7 +++-
 kernel/kexec.c                      |   62 ++++++++++++++++++++++++++++++-----
 kernel/panic.c                      |   23 ++++---------
 14 files changed, 80 insertions(+), 35 deletions(-)


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

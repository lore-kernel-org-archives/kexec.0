Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llkcR-00AfWL-Nn
 for kexec@lists.infradead.org; Wed, 26 May 2021 03:54:09 +0000
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/1] kernel: fix numerous spelling mistakes
Date: Wed, 26 May 2021 11:53:44 +0800
Message-ID: <20210526035345.9113-1-thunder.leizhen@huawei.com>
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
To: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Balbir Singh <bsingharora@gmail.com>, Barry Song <song.bao.hua@hisilicon.com>, Christoph Hellwig <hch@lst.de>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, Eric Biederman <ebiederm@xmission.com>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Jessica Yu <jeyu@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, Oleg Nesterov <oleg@redhat.com>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, kgdb-bugreport <kgdb-bugreport@lists.sourceforge.net>, kexec <kexec@lists.infradead.org>, linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>

These files are not organized by module(subdirectory), or even if they can, the
number of spelling mistakes is small and not worth generating a separate patch.

This patch is based on the latest linux-next. But except the modification of
kernel/delayacct.c, the remaining can also be applied on 5.13-rc3.


Zhen Lei (1):
  kernel: fix numerous spelling mistakes

 kernel/acct.c                  | 2 +-
 kernel/context_tracking.c      | 2 +-
 kernel/cpu.c                   | 2 +-
 kernel/debug/debug_core.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 2 +-
 kernel/delayacct.c             | 2 +-
 kernel/dma/map_benchmark.c     | 2 +-
 kernel/dma/swiotlb.c           | 2 +-
 kernel/exit.c                  | 2 +-
 kernel/hung_task.c             | 2 +-
 kernel/kexec_core.c            | 2 +-
 kernel/kprobes.c               | 2 +-
 kernel/latencytop.c            | 2 +-
 kernel/module.c                | 4 ++--
 kernel/notifier.c              | 2 +-
 kernel/padata.c                | 2 +-
 kernel/panic.c                 | 2 +-
 kernel/pid.c                   | 2 +-
 kernel/ptrace.c                | 2 +-
 kernel/relay.c                 | 2 +-
 kernel/signal.c                | 4 ++--
 kernel/smp.c                   | 2 +-
 kernel/taskstats.c             | 2 +-
 kernel/time/alarmtimer.c       | 2 +-
 kernel/time/timer.c            | 4 ++--
 kernel/umh.c                   | 2 +-
 kernel/user_namespace.c        | 2 +-
 kernel/usermode_driver.c       | 2 +-
 kernel/watchdog.c              | 2 +-
 kernel/workqueue.c             | 4 ++--
 31 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmwkc-0052GL-S6
 for kexec@lists.infradead.org; Sat, 29 May 2021 11:03:32 +0000
From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/4] kernel: fix some spelling mistakes
Date: Sat, 29 May 2021 19:03:01 +0800
Message-ID: <20210529110305.9446-1-thunder.leizhen@huawei.com>
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

v1 --> v2:
Split into several small patches and add fixes to header files. Since there are
so many patches after the split, only three reviewed modules and one time module
with relatively more changes are retained. The spelling mistakes on the rest of
the modules will be fixed in later versions.

The header file linux/freelist.h is only included by linux/kprobes.h, so grouped
it with kprobes.c

Zhen Lei (4):
  kprobes: Fix spelling mistakes
  kgdb: Fix spelling mistakes
  kexec: fix a spelling mistake in comment
  time: Fix spelling mistakes

 include/linux/freelist.h       | 2 +-
 include/linux/kgdb.h           | 8 ++++----
 include/linux/timekeeping.h    | 2 +-
 include/linux/timer.h          | 2 +-
 kernel/debug/debug_core.c      | 2 +-
 kernel/debug/kdb/kdb_main.c    | 8 ++++----
 kernel/debug/kdb/kdb_private.h | 2 +-
 kernel/kexec_core.c            | 2 +-
 kernel/kprobes.c               | 2 +-
 kernel/time/alarmtimer.c       | 2 +-
 kernel/time/timer.c            | 4 ++--
 11 files changed, 18 insertions(+), 18 deletions(-)

-- 
2.25.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

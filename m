Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v3 0/6] printk: remove safe buffers
Date: Thu, 24 Jun 2021 13:17:42 +0206
Message-Id: <20210624111148.5190-1-john.ogness@linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Yue Hu <huyue2@yulong.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Pekka Enberg <penberg@kernel.org>, Mike Rapoport <rppt@kernel.org>, "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Alexei Starovoitov <ast@kernel.org>, Nick Terrell <terrelln@fb.com>, Chris Wilson <chris@chris-wilson.co.uk>, Vlastimil Babka <vbabka@suse.cz>, linux-arm-kernel@lists.infradead.org

Hi,

Here is v3 of a series to remove the safe buffers. v2 can be
found here [0]. The safe buffers are no longer needed because
messages can be stored directly into the log buffer from any
context.

However, the safe buffers also provided a form of recursion
protection. For that reason, explicit recursion protection is
implemented for this series.

The safe buffers also implicitly provided serialization
between multiple CPUs executing in NMI context. This was
particularly necessary for the nmi_backtrace() output. This
serializiation is now preserved by using the printk_cpu_lock.

And finally, with the removal of the safe buffers, there is no
need for extra NMI enter/exit tracking. So this is also removed
(which includes removing config option CONFIG_PRINTK_NMI).

Changes since v2:

- Move irq disabling/enabling out of the
  console_lock_spinning_*() functions to simplify the patches
  keep the function prototypes simple.

- Change printk_enter_irqsave()/printk_exit_irqrestore() to
  macros to allow a more common calling convention for irq
  flags.

- Use the counter pointer from printk_enter_irqsave() in
  printk_exit_irqrestore() rather than fetching it again. This
  avoids any possible race conditions when printk's percpu
  flag is set.

- Use the printk_cpu_lock to serialize banner and regs with
  the stack dump in nmi_cpu_backtrace().

John Ogness

[0] https://lore.kernel.org/lkml/20210330153512.1182-1-john.ogness@linutronix.de

John Ogness (6):
  lib/nmi_backtrace: explicitly serialize banner and regs
  printk: track/limit recursion
  printk: remove safe buffers
  printk: remove NMI tracking
  printk: convert @syslog_lock to mutex
  printk: syslog: close window between wait and read

 arch/arm/kernel/smp.c          |   2 -
 arch/powerpc/kernel/traps.c    |   1 -
 arch/powerpc/kernel/watchdog.c |   5 -
 arch/powerpc/kexec/crash.c     |   3 -
 include/linux/hardirq.h        |   2 -
 include/linux/printk.h         |  22 --
 init/Kconfig                   |   5 -
 kernel/kexec_core.c            |   1 -
 kernel/panic.c                 |   3 -
 kernel/printk/internal.h       |  23 ---
 kernel/printk/printk.c         | 273 +++++++++++++++----------
 kernel/printk/printk_safe.c    | 361 +--------------------------------
 kernel/trace/trace.c           |   2 -
 lib/nmi_backtrace.c            |  13 +-
 14 files changed, 176 insertions(+), 540 deletions(-)


base-commit: 48e72544d6f06daedbf1d9b14610be89dba67526
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH printk v2 0/5] printk: remove safe buffers
Date: Tue, 30 Mar 2021 17:35:07 +0200
Message-Id: <20210330153512.1182-1-john.ogness@linutronix.de>
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
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>, Alistair Popple <alistair@popple.id.au>, Jordan Niethe <jniethe5@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>, "Paul E. McKenney" <paulmck@kernel.org>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Mike Rapoport <rppt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Leonardo Bras <leobras.c@gmail.com>, Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Nick Terrell <terrelln@fb.com>, David Howells <dhowells@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-arm-kernel@lists.infradead.org

Hi,

Here is v2 of a series to remove the safe buffers. v1 can be
found here [0]. The safe buffers are no longer needed because
messages can be stored directly into the log buffer from any
context.

However, the safe buffers also provided a form of recursion
protection. For that reason, explicit recursion protection is
also implemented for this series.

And finally, with the removal of the safe buffers, there is no
need for extra NMI enter/exit tracking. So this is also removed
(which includes removing config option CONFIG_PRINTK_NMI).

This series is based on the printk-rework branch of
printk/linux.git:

    commit acebb5597ff1 ("kernel/printk.c: Fixed mundane typos")

Changes since v1:

- remove the printk nmi enter/exit tracking

- remove CONFIG_PRINTK_NMI config option

- use in_nmi() to detect NMI context

- remove unused printk_safe_enter/exit macros

- after switching to the dynamic buffer, copy over NMI records
  that may have arrived during the switch window

- use local_irq_*() instead of printk_safe_*() for console
  spinning

- use separate variables rather than arrays for the per-cpu
  recursion tracking

- make @syslog_lock a mutex instead of a spin_lock

- close the wait-read window for SYSLOG_ACTION_READ

- adjust various comments and commit messages as requested

John Ogness

[0] https://lore.kernel.org/lkml/20210316233326.10778-1-john.ogness@linutronix.de

John Ogness (5):
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
 kernel/printk/printk.c         | 281 +++++++++++++++----------
 kernel/printk/printk_safe.c    | 362 +--------------------------------
 kernel/trace/trace.c           |   2 -
 lib/nmi_backtrace.c            |   6 -
 14 files changed, 171 insertions(+), 547 deletions(-)

-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 27 Jul 2021 09:26:54 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH printk v4 0/6] printk: remove safe buffers
Message-ID: <YP+1PqaKTfZXHjmU@alley>
References: <20210715193359.25946-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715193359.25946-1-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Kardashevskiy <aik@ozlabs.ru>, Yue Hu <huyue2@yulong.com>, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Marc Zyngier <maz@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Mike Rapoport <rppt@kernel.org>, "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Xiongwei Song <sxwjean@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>, Vipin Sharma <vipinsh@google.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Daniel Borkmann <daniel@iogearbox.net>, Vlastimil Babka <vbabka@suse.cz>, linux-arm-kernel@lists.infradead.org

On Thu 2021-07-15 21:39:53, John Ogness wrote:
> Hi,
> 
> Here is v4 of a series to remove the safe buffers. v3 can be
> found here [0]. The safe buffers are no longer needed because
> messages can be stored directly into the log buffer from any
> context.
> 
> However, the safe buffers also provided a form of recursion
> protection. For that reason, explicit recursion protection is
> implemented for this series.
> 
> The safe buffers also implicitly provided serialization
> between multiple CPUs executing in NMI context. This was
> particularly necessary for the nmi_backtrace() output. This
> serializiation is now preserved by using the printk cpulock.
> 
> With the removal of the safe buffers, there is no need for
> extra NMI enter/exit tracking. So this is also removed
> (which includes removing the config option CONFIG_PRINTK_NMI).
> 
> And finally, there are a few places in the kernel that need to
> specify code blocks where all printk calls are to be deferred
> printing. Previously the NMI tracking API was being (mis)used
> for this purpose. This series introduces an official and
> explicit interface for such cases. (Note that all deferred
> printing will be removed anyway, once printing kthreads are
> introduced.)
> 
> John Ogness (6):
>   lib/nmi_backtrace: explicitly serialize banner and regs
>   printk: track/limit recursion
>   printk: remove safe buffers
>   printk: remove NMI tracking
>   printk: convert @syslog_lock to mutex
>   printk: syslog: close window between wait and read

The entire patchset has been committed into printk/linux.git,
branch rework/printk_safe-removal.

Note that I have updated the 4th patch as discussed, see
https://lore.kernel.org/r/20210721120026.y3dqno24ahw4sazy@pathway.suse.cz
https://lore.kernel.org/r/20210721130852.zrjnti6b3fwjgdzj@pathway.suse.cz

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

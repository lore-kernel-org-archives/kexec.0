Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usmamail.tilera.com ([206.83.70.75])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ROuV8-0007Pp-Pg
 for kexec@lists.infradead.org; Fri, 11 Nov 2011 17:02:51 +0000
Message-ID: <4EBD5536.7010806@tilera.com>
Date: Fri, 11 Nov 2011 12:02:46 -0500
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
 <1320934932.16425.14.camel@br98xy6r> <4EBBE9B4.3040009@tilera.com>
 <1321014494.2745.7.camel@br98xy6r>
In-Reply-To: <1321014494.2745.7.camel@br98xy6r>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Howells <dhowells@redhat.com>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, Richard Weinberger <richard@nod.at>, Helge Deller <deller@gmx.de>, "James E.J.
 Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, Matt Turner <mattst88@gmail.com>, Vivek Goyal <vgoyal@redhat.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Don Zickus <dzickus@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>, Mikael Starvik <starvik@axis.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Kuo <rkuo@codeaurora.org>, Kyle McMartin <kyle@mcmartin.ca>, Paul Mundt <lethal@linux-sh.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Hirokazu Takata <takata@linux-m32r.org>

On 11/11/2011 7:28 AM, Michael Holzheu wrote:
> Hello Chris,
>
> On Thu, 2011-11-10 at 10:11 -0500, Chris Metcalf wrote:
>> On 11/10/2011 9:22 AM, Michael Holzheu wrote:
> [snip]
>
>> If a cleaner API seems useful (either for power reasons or restartability
>> or whatever), I suppose a standard global function name could be specified
>> that's the thing you execute when you get an smp_send_stop IPI (in tile's
>> case it's "smp_stop_cpu_interrupt()") and the panic() code could instead
>> just do an atomic_inc_return() of a global panic counter, and if it wasn't
>> the first panicking cpu, call directly into the smp_stop handler routine to
>> quiesce itself.  Then the panicking cpu could finish whatever it needs to
>> do and then halt, reboot, etc., all the cpus.
> Thanks for the info. So introducing a "weak" function that can stop the
> CPU it is running on could solve the problem. Every architecture can
> override the function with something appropriate. E.g. "tile" can use
> the lower-power "nap" instruction there.
>
> What about the following patch.

Seems reasonable to me.

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

>
> Michael
> ---
> From: Michael Holzheu<holzheu@linux.vnet.ibm.com>
> Subject: kdump: fix crash_kexec()/smp_send_stop() race in panic
>
> When two CPUs call panic at the same time there is a possible race
> condition that can stop kdump.  The first CPU calls crash_kexec() and the
> second CPU calls smp_send_stop() in panic() before crash_kexec() finished
> on the first CPU.  So the second CPU stops the first CPU and therefore
> kdump fails:
>
> 1st CPU:
> panic()->crash_kexec()->mutex_trylock(&kexec_mutex)->  do kdump
>
> 2nd CPU:
> panic()->crash_kexec()->kexec_mutex already held by 1st CPU
>         ->smp_send_stop()->  stop 1st CPU (stop kdump)
>
> This patch fixes the problem by introducing a spinlock in panic that
> allows only one CPU to process crash_kexec() and the subsequent panic
> code.
>
> Signed-off-by: Michael Holzheu<holzheu@linux.vnet.ibm.com>
> ---
>   kernel/panic.c |   18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -49,6 +49,15 @@ static long no_blink(int state)
>   long (*panic_blink)(int state);
>   EXPORT_SYMBOL(panic_blink);
>
> +/*
> + * Stop ourself in panic -- architecture code may override this
> + */
> +void __attribute__ ((weak)) panic_smp_self_stop(void)
> +{
> +	while (1)
> +		cpu_relax();
> +}
> +
>   /**
>    *	panic - halt the system
>    *	@fmt: The text string to print
> @@ -59,6 +68,7 @@ EXPORT_SYMBOL(panic_blink);
>    */
>   NORET_TYPE void panic(const char * fmt, ...)
>   {
> +	static DEFINE_SPINLOCK(panic_lock);
>   	static char buf[1024];
>   	va_list args;
>   	long i, i_next = 0;
> @@ -68,8 +78,14 @@ NORET_TYPE void panic(const char * fmt,
>   	 * It's possible to come here directly from a panic-assertion and
>   	 * not have preempt disabled. Some functions called from here want
>   	 * preempt to be disabled. No point enabling it later though...
> +	 *
> +	 * Only one CPU is allowed to execute the panic code from here. For
> +	 * multiple parallel invocations of panic, all other CPUs either
> +	 * stop themself or will wait until they are stopped by the 1st CPU
> +	 * with smp_send_stop().
>   	 */
> -	preempt_disable();
> +	if (!spin_trylock(&panic_lock))
> +		panic_smp_self_stop();
>
>   	console_verbose();
>   	bust_spinlocks(1);
>
>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

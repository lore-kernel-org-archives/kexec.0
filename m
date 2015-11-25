Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1WnM-0005at-JV
 for kexec@lists.infradead.org; Wed, 25 Nov 2015 09:55:25 +0000
Date: Wed, 25 Nov 2015 10:54:57 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [V5 PATCH 3/4] kexec: Fix race between panic() and crash_kexec()
 called directly
Message-ID: <20151125095457.GB29499@pd.tnic>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093648.4285.17715.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151120093648.4285.17715.stgit@softrs>
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
To: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Nov 20, 2015 at 06:36:48PM +0900, Hidehiro Kawai wrote:
> Currently, panic() and crash_kexec() can be called at the same time.
> For example (x86 case):
> 
> CPU 0:
>   oops_end()
>     crash_kexec()
>       mutex_trylock() // acquired
>         nmi_shootdown_cpus() // stop other cpus
> 
> CPU 1:
>   panic()
>     crash_kexec()
>       mutex_trylock() // failed to acquire
>     smp_send_stop() // stop other cpus
>     infinite loop
> 
> If CPU 1 calls smp_send_stop() before nmi_shootdown_cpus(), kdump
> fails.
> 
> In another case:
> 
> CPU 0:
>   oops_end()
>     crash_kexec()
>       mutex_trylock() // acquired
>         <NMI>
>         io_check_error()
>           panic()
>             crash_kexec()
>               mutex_trylock() // failed to acquire
>             infinite loop
> 
> Clearly, this is an undesirable result.
> 
> To fix this problem, this patch changes crash_kexec() to exclude
> others by using atomic_t panic_cpu.
> 
> V5:
> - Add missing dummy __crash_kexec() for !CONFIG_KEXEC_CORE case
> - Replace atomic_xchg() with atomic_set() in crash_kexec() because
>   it is used as a release operation and there is no need of memory
>   barrier effect.  This change also removes an unused value warning
> 
> V4:
> - Use new __crash_kexec(), no exclusion check version of crash_kexec(),
>   instead of checking if panic_cpu is the current cpu or not
> 
> V2:
> - Use atomic_cmpxchg() instead of spin_trylock() on panic_lock
>   to exclude concurrent accesses
> - Don't introduce no-lock version of crash_kexec()
> 
> Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> ---
>  include/linux/kexec.h |    2 ++
>  kernel/kexec_core.c   |   26 +++++++++++++++++++++++++-
>  kernel/panic.c        |    4 ++--
>  3 files changed, 29 insertions(+), 3 deletions(-)

...

> +void crash_kexec(struct pt_regs *regs)
> +{
> +	int old_cpu, this_cpu;
> +
> +	/*
> +	 * Only one CPU is allowed to execute the crash_kexec() code as with
> +	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
> +	 * may stop each other.  To exclude them, we use panic_cpu here too.
> +	 */
> +	this_cpu = raw_smp_processor_id();
> +	old_cpu = atomic_cmpxchg(&panic_cpu, -1, this_cpu);
> +	if (old_cpu == -1) {
> +		/* This is the 1st CPU which comes here, so go ahead. */
> +		__crash_kexec(regs);
> +
> +		/*
> +		 * Reset panic_cpu to allow another panic()/crash_kexec()
> +		 * call.

So can we make __crash_kexec() return error values?

* failed to grab kexec_mutex -> reset panic_cpu

* no kexec_crash_image -> no need to reset it, all future crash_kexec()
calls won't work so no need to run into that path anymore. However, this could
be problematic if we want the other CPUs to panic. Do we care?

* machine_kexec successful -> doesn't matter

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

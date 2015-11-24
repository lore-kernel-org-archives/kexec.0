Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.232]
 helo=cdptpa-oedge-vip.email.rr.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a1FIl-0003Zj-Cf
 for kexec@lists.infradead.org; Tue, 24 Nov 2015 15:14:40 +0000
Date: Tue, 24 Nov 2015 10:05:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [V5 PATCH 1/4] panic/x86: Fix re-entrance problem due to panic
 on NMI
Message-ID: <20151124150510.GA6100@home.goodmis.org>
References: <20151120093641.4285.97253.stgit@softrs>
 <20151120093644.4285.9349.stgit@softrs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20151120093644.4285.9349.stgit@softrs>
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
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Nov 20, 2015 at 06:36:44PM +0900, Hidehiro Kawai wrote:
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 350dfb0..480a4fd 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -445,6 +445,19 @@ extern int sysctl_panic_on_stackoverflow;
>  
>  extern bool crash_kexec_post_notifiers;
>  
> +extern atomic_t panic_cpu;
> +
> +/*
> + * A variant of panic() called from NMI context.
> + * If we've already panicked on this cpu, return from here.
> + */
> +#define nmi_panic(fmt, ...)						\
> +	do {								\
> +		int this_cpu = raw_smp_processor_id();			\
> +		if (atomic_cmpxchg(&panic_cpu, -1, this_cpu) != this_cpu) \
> +			panic(fmt, ##__VA_ARGS__);			\

Hmm,

What happens if:

	CPU 0:				CPU 1:
	------				------
	nmi_panic();

					nmi_panic();
					<external nmi>
					nmi_panic();

?

cmpxchg(&panic_cpu, -1, 0) != 0

returns -1 for cpu 0, thus 0 != 0, and sets panic_cpu to 0


cmpxchg(&panic_cpu, -1, 1) != 1

returns 0, and then it too panics, but does not set panic_cpu to 1

Now you have your external NMI triggering on CPU 1

cmpxchg(&panic_cpu, -1, 1) != 1

returns 0 again, and you call panic again within the panic of CPU 1.

Is this OK?

Perhaps you want a per cpu bitmask, and do a test_and_set() on the CPU. That
would prevent any CPU from rerunning a panic() twice on any CPU.

-- Steve

> +	} while (0)
> +
>  /*
>   * Only to be used by arch init code. If the user over-wrote the default
>   * CONFIG_PANIC_TIMEOUT, honor it.
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 4579dbb..24ee2ea 100644

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZJuE4-0004yh-5v
 for kexec@lists.infradead.org; Tue, 28 Jul 2015 02:02:41 +0000
Message-ID: <55B6E2A3.8070004@hitachi.com>
Date: Tue, 28 Jul 2015 11:02:11 +0900
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
MIME-Version: 1.0
Subject: Re: [V2 PATCH 1/3] x86/panic: Fix re-entrance problem due to panic
 on NMI
References: <20150727015850.4928.87717.stgit@softrs>
 <20150727015850.4928.50289.stgit@softrs>
 <20150727143405.GF11317@dhcp22.suse.cz>
In-Reply-To: <20150727143405.GF11317@dhcp22.suse.cz>
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
To: Michal Hocko <mhocko@kernel.org>
Cc: x86@kernel.org, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Hi,

Thanks for the review.

(2015/07/27 23:34), Michal Hocko wrote:
> On Mon 27-07-15 10:58:50, Hidehiro Kawai wrote:
> [...]
>> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
>> index d05bd2e..5b32d81 100644
>> --- a/arch/x86/kernel/nmi.c
>> +++ b/arch/x86/kernel/nmi.c
>> @@ -230,7 +230,8 @@ void unregister_nmi_handler(unsigned int type, const char *name)
>>  	}
>>  #endif
>>  
>> -	if (panic_on_unrecovered_nmi)
>> +	if (panic_on_unrecovered_nmi &&
>> +	    atomic_cmpxchg(&panicking_cpu, -1, raw_smp_processor_id()) == -1)
>>  		panic("NMI: Not continuing");
> 
> Spreading the check to all NMI callers is quite ugly. Wouldn't it be
> better to introduce nmi_panic() which wouldn't be __noreturn unlike the
> regular panic.

Sure.  I'll fix it.

> The check could be also relaxed a bit and nmi_panic would
> return only if the ongoing panic is the current cpu when we really have
> to return and allow the preempted panic to finish.

It's reasonable.  I'll do that in the next version.

> Something like
[...]
> +void nmi_panic(const char *fmt, ...)

Since we can't directly pass variable arguments to a subroutine,
we have to use a macro or do like this:

void nmi_panic(const char *msg)
{
...
	panic("%s", msg);
}

If there is no objection, I'm going to use a macro.

> +{
> +	/*
> +	 * We have to back off if the NMI has preempted an ongoing panic and
> +	 * allow it to finish
> +	 */
> +	if (atomic_read(&panic_cpu) == raw_smp_processor_id())
> +		return;
> +
> +	panic();
> +}
> +EXPORT_SYMBOL(nmi_panic);
>  
>  struct tnt {
>  	u8	bit;
> 


-- 
Hidehiro Kawai
Hitachi, Ltd. Research & Development Group



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

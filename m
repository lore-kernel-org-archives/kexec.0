Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH -v2 6/8] kexec jump: fix for lockdep
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <1218178365.22039.79.camel@caritas-dev.intel.com>
References: <1218178365.22039.79.camel@caritas-dev.intel.com>
Date: Fri, 08 Aug 2008 12:13:46 +0200
Message-Id: <1218190426.8625.71.camel@twins>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Huang Ying <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu, Vivek Goyal <vgoyal@redhat.com>

On Fri, 2008-08-08 at 14:52 +0800, Huang Ying wrote:
> Replace local_irq_disable() with raw_local_irq_disable() to prevent
> lockdep complain.


Uhhm, please provide more information - just using raw_* to silence
lockdep is generally the wrong thing to do.

> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  arch/x86/kernel/machine_kexec_32.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -123,7 +123,7 @@ void machine_kexec(struct kimage *image)
>  	tracer_disable();
>  
>  	/* Interrupts aren't acceptable while we reboot */
> -	local_irq_disable();
> +	raw_local_irq_disable();
>  
>  	if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

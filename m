Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJTxr-0005WV-Du
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 17:42:04 +0000
Date: Thu, 27 Oct 2011 13:40:53 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Message-ID: <20111027174053.GK7491@redhat.com>
References: <1319639649.3321.11.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319639649.3321.11.camel@br98xy6r>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, akpm@linux-foundation.org

On Wed, Oct 26, 2011 at 04:34:09PM +0200, Michael Holzheu wrote:
> Hello Andrew,
> 
> After the discussion with Eric and Vivek the following patch
> seems to be a good solution to me. Could you accept this patch?
> 
> When two CPUs call panic at the same time there is a
> possible race condition that can stop kdump. The first
> CPU calls crash_kexec() and the second CPU calls
> smp_send_stop() in panic() before crash_kexec() finished
> on the first CPU. So the second CPU stops the first CPU
> and therefore kdump fails:
> 
> 1st CPU:
> panic()->crash_kexec()->mutex_trylock(&kexec_mutex)-> do kdump
> 
> 2nd CPU:
> panic()->crash_kexec()->kexec_mutex already held by 1st CPU
>        ->smp_send_stop()-> stop 1st CPU (stop kdump)
> 
> This patch fixes the problem by introducing a spinlock in
> panic that allows only one CPU to process crash_kexec() and
> the subsequent panic code.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Sounds reasonable to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> ---
>  kernel/panic.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -59,6 +59,7 @@ EXPORT_SYMBOL(panic_blink);
>   */
>  NORET_TYPE void panic(const char * fmt, ...)
>  {
> +	static DEFINE_SPINLOCK(panic_lock);
>  	static char buf[1024];
>  	va_list args;
>  	long i, i_next = 0;
> @@ -82,6 +83,13 @@ NORET_TYPE void panic(const char * fmt,
>  #endif
>  
>  	/*
> +	 * Only one CPU is allowed to execute the panic code from here. For
> +	 * multiple parallel invocations of panic all other CPUs will wait on
> +	 * the panic_lock. They are stopped afterwards by smp_send_stop().
> +	 */
> +	spin_lock(&panic_lock);
> +
> +	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
>  	 * Do we want to call this before we try to display a message?
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

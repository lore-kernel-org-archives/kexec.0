Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR5Aa-0003jb-O0
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 13:04:45 +0000
Date: Thu, 7 Aug 2008 09:04:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 1/6] kexec jump: clean up #ifdef and comments
Message-ID: <20080807130401.GA27783@redhat.com>
References: <1218099923.5164.32.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099923.5164.32.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Thu, Aug 07, 2008 at 05:05:23PM +0800, Huang Ying wrote:
> Move if (kexec_image->preserve_context) { ... } into #ifdef
> CONFIG_KEXEC_JUMP to make code looks cleaner.
> 
> Fix no longer correct comments of kernel_kexec().
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  kernel/kexec.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1427,8 +1427,6 @@ static int __init crash_save_vmcoreinfo_
>  module_init(crash_save_vmcoreinfo_init)
>  
>  /**
> - *	kernel_kexec - reboot the system
> - *
>   *	Move into place and start executing a preloaded standalone
>   *	executable.  If nothing was preloaded return an error.
>   */
> @@ -1443,8 +1441,8 @@ int kernel_kexec(void)
>  		goto Unlock;
>  	}
>  
> -	if (kexec_image->preserve_context) {
>  #ifdef CONFIG_KEXEC_JUMP
> +	if (kexec_image->preserve_context) {
>  		mutex_lock(&pm_mutex);
>  		pm_prepare_console();
>  		error = freeze_processes();
> @@ -1471,8 +1469,9 @@ int kernel_kexec(void)
>  		if (error)
>  			goto Enable_irqs;
>  		save_processor_state();
> +	} else
>  #endif
> -	} else {
> +	{
>  		blocking_notifier_call_chain(&reboot_notifier_list,
>  					     SYS_RESTART, NULL);
>  		system_state = SYSTEM_RESTART;
> @@ -1484,8 +1483,8 @@ int kernel_kexec(void)
>  
>  	machine_kexec(kexec_image);
>  
> -	if (kexec_image->preserve_context) {
>  #ifdef CONFIG_KEXEC_JUMP
> +	if (kexec_image->preserve_context) {
>  		restore_processor_state();
>  		device_power_up(PMSG_RESTORE);
>   Enable_irqs:
> @@ -1499,8 +1498,8 @@ int kernel_kexec(void)
>   Restore_console:
>  		pm_restore_console();
>  		mutex_unlock(&pm_mutex);
> -#endif
>  	}
> +#endif
>  
>   Unlock:
>  	xchg(&kexec_lock, 0);

Thanks Huang. Looks good to me.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR5NN-00055A-KB
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 13:17:57 +0000
Date: Thu, 7 Aug 2008 09:17:42 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 3/6] kexec jump: remove duplication of
	kexec_restart_prepare()
Message-ID: <20080807131742.GC27783@redhat.com>
References: <1218099928.5164.34.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099928.5164.34.camel@caritas-dev.intel.com>
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

On Thu, Aug 07, 2008 at 05:05:28PM +0800, Huang Ying wrote:
> Call kernel_restart_prepare() in kernel_kexec() instead of duplicating
> the code.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  include/linux/reboot.h |    1 +
>  kernel/kexec.c         |    6 +-----
>  kernel/sys.c           |    2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -59,6 +59,7 @@ extern void machine_crash_shutdown(struc
>   * Architecture independent implemenations of sys_reboot commands.
>   */
>  
> +extern void kernel_restart_prepare(char *cmd);
>  extern void kernel_restart(char *cmd);
>  extern void kernel_halt(void);
>  extern void kernel_power_off(void);
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -274,7 +274,7 @@ void emergency_restart(void)
>  }
>  EXPORT_SYMBOL_GPL(emergency_restart);
>  
> -static void kernel_restart_prepare(char *cmd)
> +void kernel_restart_prepare(char *cmd)
>  {
>  	blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>  	system_state = SYSTEM_RESTART;
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1472,11 +1472,7 @@ int kernel_kexec(void)
>  	} else
>  #endif
>  	{
> -		blocking_notifier_call_chain(&reboot_notifier_list,
> -					     SYS_RESTART, NULL);
> -		system_state = SYSTEM_RESTART;
> -		device_shutdown();
> -		sysdev_shutdown();
> +		kernel_restart_prepare(NULL);
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
>  	}

Looks good to me. 

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

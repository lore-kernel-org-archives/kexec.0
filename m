Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1coUVx-0003b1-Am
 for kexec@lists.infradead.org; Thu, 16 Mar 2017 12:28:21 +0000
Date: Thu, 16 Mar 2017 20:27:30 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Update vmcoreinfo after crash happened
Message-ID: <20170316122730.GB23625@x1>
References: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1489666587-24103-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Hi Xunlei,

Did you really see this ever happened? Because the vmcore size estimate
feature, namely --mem-usage option of makedumpfile, depends on the
vmcoreinfo in 1st kernel, your change will break it.

If not, it could be not good to change that.

Baoquan

On 03/16/17 at 08:16pm, Xunlei Pang wrote:
> Currently vmcoreinfo data is updated at boot time subsys_initcall(),
> it has the risk of being modified by some wrong code during system
> is running.
> 
> As a result, vmcore dumped will contain the wrong vmcoreinfo. Later on,
> when using "crash" utility to parse this vmcore, we probably will get
> "Segmentation fault".
> 
> Based on the fact that the value of each vmcoreinfo stays invariable
> once kernel boots up, we safely move all the vmcoreinfo operations into
> crash_save_vmcoreinfo() which is called after crash happened. In this
> way, vmcoreinfo data correctness is always guaranteed.
> 
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  kernel/kexec_core.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index bfe62d5..1bfdd96 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1367,12 +1367,6 @@ static void update_vmcoreinfo_note(void)
>  	final_note(buf);
>  }
>  
> -void crash_save_vmcoreinfo(void)
> -{
> -	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
> -	update_vmcoreinfo_note();
> -}
> -
>  void vmcoreinfo_append_str(const char *fmt, ...)
>  {
>  	va_list args;
> @@ -1402,7 +1396,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
>  }
>  
> -static int __init crash_save_vmcoreinfo_init(void)
> +void crash_save_vmcoreinfo(void)
>  {
>  	VMCOREINFO_OSRELEASE(init_uts_ns.name.release);
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> @@ -1474,13 +1468,11 @@ static int __init crash_save_vmcoreinfo_init(void)
>  #endif
>  
>  	arch_crash_save_vmcoreinfo();
> -	update_vmcoreinfo_note();
> +	vmcoreinfo_append_str("CRASHTIME=%ld\n", get_seconds());
>  
> -	return 0;
> +	update_vmcoreinfo_note();
>  }
>  
> -subsys_initcall(crash_save_vmcoreinfo_init);
> -
>  /*
>   * Move into place and start executing a preloaded standalone
>   * executable.  If nothing was preloaded return an error.
> -- 
> 1.8.3.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

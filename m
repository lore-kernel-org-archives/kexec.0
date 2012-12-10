Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TiAiv-0007bE-T0
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 21:17:15 +0000
Date: Mon, 10 Dec 2012 18:30:14 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] x86/kexec: crash_vmclear_local_vmcss needs __rcu
Message-ID: <20121210203014.GB2402@amt.cnet>
References: <50C18168.305@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C18168.305@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Gleb Natapov <gleb@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kbuild test robot <fengguang.wu@intel.com>

On Fri, Dec 07, 2012 at 01:40:56PM +0800, Zhang Yanfei wrote:
> This removes the sparse warning:
> arch/x86/kernel/crash.c:49:32: sparse: incompatible types in comparison expression (different address spaces)
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  arch/x86/include/asm/kexec.h |    4 +++-
>  arch/x86/kernel/crash.c      |    4 ++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> index 28feeba..16882cd 100644
> --- a/arch/x86/include/asm/kexec.h
> +++ b/arch/x86/include/asm/kexec.h
> @@ -163,7 +163,9 @@ struct kimage_arch {
>  };
>  #endif
>  
> -extern void (*crash_vmclear_loaded_vmcss)(void);
> +extern void __rcu (*crash_vmclear_loaded_vmcss)(void);
> +#define vmclear_func_rcu(vmclear_func) \
> +	((void (*)(void)) rcu_dereference(vmclear_func))
>  
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 2f6b8e8..50ce1d6 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -38,7 +38,7 @@ int in_crash_kexec;
>   *
>   * protected by rcu.
>   */
> -void (*crash_vmclear_loaded_vmcss)(void) = NULL;
> +void __rcu (*crash_vmclear_loaded_vmcss)(void) = NULL;

Isnt this (__rcu AS tag) sufficient? After all, sparse is complaining
about namespaces.

Creating a #define to cast seems excessive.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

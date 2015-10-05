Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZjBBT-00061q-IG
 for kexec@lists.infradead.org; Mon, 05 Oct 2015 19:12:28 +0000
Date: Mon, 5 Oct 2015 15:12:05 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] kexec: Remove obsolete flag 'in_crash_kexec'
Message-ID: <20151005191205.GD100301@redhat.com>
References: <1444070155-17934-1-git-send-email-mhuang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444070155-17934-1-git-send-email-mhuang@redhat.com>
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
To: Minfei Huang <mhuang@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, cpw@sgi.com, Minfei Huang <mnfhuang@gmail.com>, akpm@linux-foundation.org, tglx@linutronix.de

On Tue, Oct 06, 2015 at 02:35:55AM +0800, Minfei Huang wrote:
> From: Minfei Huang <mnfhuang@gmail.com>
> 
> Previously, UV NMI used 'in_crash_kexec' flag to be sure that we are in
> kdump kernel or not in commit 5edd19af18a36a4e22c570b1b969179e0ca1fe4c
> ("x86, UV: Make kdump avoid stack dumps"). But this flags is removed in
> commit 9c48f1c629ecfa114850c03f875c6691003214de ("x86, nmi: Wire up NMI
> handlers to new routines").

Sounds right.

Acked-by: Don Zickus <dzickus@redhat.com>


> 
> Since it isn't used any more, remove it.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> ---
>  arch/x86/include/asm/kdebug.h | 6 ------
>  arch/x86/kernel/crash.c       | 3 ---
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
> index b130d59..e5f5dc9 100644
> --- a/arch/x86/include/asm/kdebug.h
> +++ b/arch/x86/include/asm/kdebug.h
> @@ -29,11 +29,5 @@ extern void show_trace(struct task_struct *t, struct pt_regs *regs,
>  extern void __show_regs(struct pt_regs *regs, int all);
>  extern unsigned long oops_begin(void);
>  extern void oops_end(unsigned long, struct pt_regs *, int signr);
> -#ifdef CONFIG_KEXEC_CORE
> -extern int in_crash_kexec;
> -#else
> -/* no crash dump is ever in progress if no crash kernel can be kexec'd */
> -#define in_crash_kexec 0
> -#endif
>  
>  #endif /* _ASM_X86_KDEBUG_H */
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 74ca2fe..2c1910f 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -75,8 +75,6 @@ struct crash_memmap_data {
>  	unsigned int type;
>  };
>  
> -int in_crash_kexec;
> -
>  /*
>   * This is used to VMCLEAR all VMCSs loaded on the
>   * processor. And when loading kvm_intel module, the
> @@ -132,7 +130,6 @@ static void kdump_nmi_callback(int cpu, struct pt_regs *regs)
>  
>  static void kdump_nmi_shootdown_cpus(void)
>  {
> -	in_crash_kexec = 1;
>  	nmi_shootdown_cpus(kdump_nmi_callback);
>  
>  	disable_local_APIC();
> -- 
> 2.4.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

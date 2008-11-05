Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KxmHi-00041a-Fd
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 17:35:14 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1225810364-8990-1-git-send-email-ehabkost@redhat.com>
	<1225810364-8990-16-git-send-email-ehabkost@redhat.com>
Date: Wed, 05 Nov 2008 09:26:53 -0800
In-Reply-To: <1225810364-8990-16-git-send-email-ehabkost@redhat.com> (Eduardo
	Habkost's message of "Tue, 4 Nov 2008 12:52:43 -0200")
Message-ID: <m1od0u3wyq.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 15/16] kvm: x86: set kdump virt_disable function on
	initialization
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Finally implement the virt_disable function for kdump. It will call
> kvm_x86_ops->crash_hardware_disable(), that will disable virtualization
> extensions on the CPU if it is not disabled yet.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  arch/x86/kvm/x86.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 049c6a0..9e61baf 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -40,6 +40,7 @@
>  #include <asm/msr.h>
>  #include <asm/desc.h>
>  #include <asm/mtrr.h>
> +#include <asm/virtext.h>
>  
>  #define MAX_IO_MSRS 256
>  #define CR0_RESERVED_BITS						\
> @@ -2581,6 +2582,13 @@ int kvm_emulate_pio_string(struct kvm_vcpu *vcpu, struct
> kvm_run *run, int in,
>  }
>  EXPORT_SYMBOL_GPL(kvm_emulate_pio_string);
>  
> +/* Called at crash time, so we can disable virtualization if needed
> + */
> +static void crash_hardware_disable(void)
> +{
> +	kvm_x86_ops->crash_hardware_disable(NULL);
> +}
> +
>  int kvm_arch_init(void *opaque)
>  {
>  	int r;
> @@ -2605,9 +2613,15 @@ int kvm_arch_init(void *opaque)
>  
>  	kvm_x86_ops = ops;
>  
> +	r = set_virt_disable_func(crash_hardware_disable);

Can we make this say:
set_virt_disable_func(kvm_x86_ops->crash_hardware_disable);

So we can avoid going through 2 levels of function pointers?
I find that a little scary in code that might be running
at the edge of stack overflow.

> +	if (r) {
> +		printk(KERN_ERR "kvm: virt_disable function already set?\n");
> +		goto out_clear_ops;
> +	}
> +
>  	r = kvm_mmu_module_init();
>  	if (r)
> -		goto out_clear_ops;
> +		goto out_clear_crash;
>  
>  	kvm_init_msr_list();
>  
> @@ -2617,6 +2631,8 @@ int kvm_arch_init(void *opaque)
>  			PT_DIRTY_MASK, PT64_NX_MASK, 0, 0);
>  	return 0;
>  
> +out_clear_crash:
> +	clear_virt_disable_func();
>  out_clear_ops:
>  	kvm_x86_ops = NULL;
>  out:
> @@ -2625,6 +2641,7 @@ out:
>  
>  void kvm_arch_exit(void)
>  {
> +	clear_virt_disable_func();
>  	kvm_x86_ops = NULL;
>  	kvm_mmu_module_exit();
>  }
> -- 
> 1.5.5.GIT

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

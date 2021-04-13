Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lW6q9-006eKq-Fe
 for kexec@lists.infradead.org; Tue, 13 Apr 2021 00:23:38 +0000
Received: by mail-il1-x131.google.com with SMTP id p15so1731426iln.3
 for <kexec@lists.infradead.org>; Mon, 12 Apr 2021 17:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1618254007.git.ashish.kalra@amd.com>
 <c349516d85d9e3fc7404d564ff81d7ebecc1162c.1618254007.git.ashish.kalra@amd.com>
In-Reply-To: <c349516d85d9e3fc7404d564ff81d7ebecc1162c.1618254007.git.ashish.kalra@amd.com>
From: Steve Rutherford <srutherford@google.com>
Date: Mon, 12 Apr 2021 17:22:57 -0700
Message-ID: <CABayD+cNLdoPHYvw0ZAXZS2wRg4cCFGTMvON0Ja2cWJ4juHNbA@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] x86/kvm: Add kexec support for SEV Live
 Migration.
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
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>, X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, Venu Busireddy <venu.busireddy@oracle.com>, Brijesh Singh <brijesh.singh@amd.com>, kexec@lists.infradead.org

On Mon, Apr 12, 2021 at 12:48 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Reset the host's shared pages list related to kernel
> specific page encryption status settings before we load a
> new kernel by kexec. We cannot reset the complete
> shared pages list here as we need to retain the
> UEFI/OVMF firmware specific settings.
>
> The host's shared pages list is maintained for the
> guest to keep track of all unencrypted guest memory regions,
> therefore we need to explicitly mark all shared pages as
> encrypted again before rebooting into the new guest kernel.
>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/kernel/kvm.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index bcc82e0c9779..4ad3ed547ff1 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -39,6 +39,7 @@
>  #include <asm/cpuidle_haltpoll.h>
>  #include <asm/ptrace.h>
>  #include <asm/svm.h>
> +#include <asm/e820/api.h>
>
>  DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
>
> @@ -384,6 +385,29 @@ static void kvm_pv_guest_cpu_reboot(void *unused)
>          */
>         if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>                 wrmsrl(MSR_KVM_PV_EOI_EN, 0);
> +       /*
> +        * Reset the host's shared pages list related to kernel
> +        * specific page encryption status settings before we load a
> +        * new kernel by kexec. NOTE: We cannot reset the complete
> +        * shared pages list here as we need to retain the
> +        * UEFI/OVMF firmware specific settings.
> +        */
> +       if (sev_live_migration_enabled & (smp_processor_id() == 0)) {
What happens if the reboot of CPU0 races with another CPU servicing a
device request (while the reboot is pending for that CPU)?
Seems like you could run into a scenario where you have hypercalls racing.

Calling this on every core isn't free, but it is an easy way to avoid this race.
You could also count cores, and have only last core do the job, but
that seems more complicated.

Steve
> +               int i;
> +               unsigned long nr_pages;
> +
> +               for (i = 0; i < e820_table->nr_entries; i++) {
> +                       struct e820_entry *entry = &e820_table->entries[i];
> +
> +                       if (entry->type != E820_TYPE_RAM)
> +                               continue;
> +
> +                       nr_pages = DIV_ROUND_UP(entry->size, PAGE_SIZE);
> +
> +                       kvm_sev_hypercall3(KVM_HC_PAGE_ENC_STATUS,
> +                                          entry->addr, nr_pages, 1);
> +               }
> +       }
>         kvm_pv_disable_apf();
>         kvm_disable_steal_time();
>  }
> --
> 2.17.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

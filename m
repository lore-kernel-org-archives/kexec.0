Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f6uyq-0003dD-L8
 for kexec@lists.infradead.org; Fri, 13 Apr 2018 09:27:00 +0000
Received: by mail-lf0-f41.google.com with SMTP id j68-v6so11628120lfg.13
 for <kexec@lists.infradead.org>; Fri, 13 Apr 2018 02:26:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALKbUJSPYGyk6rmTaZ8NOD9re1X=Qb1Y8NjTzPc8EhtVWnYzcQ@mail.gmail.com>
References: <CALKbUJSPYGyk6rmTaZ8NOD9re1X=Qb1Y8NjTzPc8EhtVWnYzcQ@mail.gmail.com>
From: Sunil Kumar <sukumar@mvista.com>
Date: Fri, 13 Apr 2018 14:55:58 +0530
Message-ID: <CALKbUJQPKvBwG6ibUcTRa-SVnNJLysvW3v7tJV1NYt6-wiTfbQ@mail.gmail.com>
Subject: Re: PowerPC External interrupts are not triggered in secondary kernel
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
To: kexec@lists.infradead.org

Hi All,

There was problem in MPIC controller when operating in External proxy
mode for t104x based boards
Issue fixed by taking below change from 4.4 kernel.
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=9f640bf53

Thanks Scott for your efforts, otherwise it would be another few
months I have been struggle to fix this issue.

Thanks,
Sunil Kumar
Thanks & Regards,
Sunil Kumar
Technical Lead
Montavista Software
Bengaluru, India - 560008
www.mvista.com | +91-80-67228800 [+8865]


On Tue, Apr 3, 2018 at 1:57 PM, Sunil Kumar <sukumar@mvista.com> wrote:
> Hi All,
>
> I came across very interesting issue while working kexec with the 3.10
> kernel on NXP's t1042ds reference board.
> whenever crashing the primary kernel using the "echo c >
> /proc/sysrq-trigger' command. i am getting "mmc0: Timeout waiting for
> hardware interrupt." during bootup of secondary crash kernel. The mmc
> timeout is comming because the sdhci driver initialiation code sends
> the set of commands to the esdhc host controller and expecting it to
> get the interrupt from sdcard( i.e esdhc) host controller. When the
> interrupt is not raised within 10ms of time, sdhci reports the
> interrupt is not recieved from the sdcard controller by throwing mmc
> timeout error.
>
> To debug it further added print in do_IRQ routine to check whether
> external interrupts are comming or not, but as soon as interrupts are
> enabled in the secondary kernel ( inside start_kernel() ),  I am
> getting spurious interrupt (i.e. irq=0 ~ NO_IRQ ) and a doorbell
> exception.
>
> Not sure why doorbell exception, as SMP support is not enabled in my
> secondary kernel ?
> If I am not wrong doorbell exception are mainly used for IPI
> communication across different CPU cores.
>
> Whenever getting this supurious interrupt during boots, Secondary
> kernel is not booting up due to mmc timeout error.
> Debugged it further by printing all the irq which are pending in the
> primary kernel before jumping to secondary kernel and found that one
> of the irq is not processed in the primary kernel. Looks like whenever
> having any pending interrupts from the primary kernel, the secondary
> kernel treat that as spurious interrupt.
>
> Ideally there should not be any pending interrupts from primary kernel
> as we are send EOI to all the interrupts and masking them in the
> machine_kexec_mask_interrupts() routine. As per my understanding even
> if spurious interrupt comes its should not cause any harm and
> secondary kernel should boot ideally.
>
> The problem get fixed when all the pending interrupts are processed in
> the primary kernel just before jumping to secondary kernel. Below are
> the changes which fixes the issue
> ==============================================================================
> diff --git a/arch/powerpc/kernel/machine_kexec_32.c
> b/arch/powerpc/kernel/machine_kexec_32.c
> index affe5dc..b2256d7 100644
> --- a/arch/powerpc/kernel/machine_kexec_32.c
> +++ b/arch/powerpc/kernel/machine_kexec_32.c
> @@ -36,6 +36,13 @@ void default_machine_kexec(struct kimage *image)
>         unsigned long reboot_code_buffer, reboot_code_buffer_phys;
>         relocate_new_kernel_t rnk;
>
> +       /*
> +         Allow pending interrupts to execute before jumping to
> +         secondary kernel if kexec called from atomic context.
> +       */
> +       if (irqs_disabled())
> +               local_irq_enable();
> +
>         /* Interrupts aren't acceptable while we reboot */
>         local_irq_disable();
> ==============================================================================
>
> Similiar kind of solution has been merged to linux-stable for CPU
> HOTPLUG feature, where before disabling the cpu, kernel process all
> pending interrupts before going offline.
>
> Below is the reference
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=687b8f24f14db842c8c3f8cb8b24c9a29b691db8
>
> Is this good idea to process all the pending interrupt before jumping
> to secondary kernel ?
> Please provide your suggestion.
>
> Regards
> Sunil Kumar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

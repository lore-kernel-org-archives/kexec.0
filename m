Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fix3w-0001Wt-53
 for kexec@lists.infradead.org; Fri, 27 Jul 2018 07:21:21 +0000
Received: by mail-pg1-x541.google.com with SMTP id p23-v6so2701158pgv.13
 for <kexec@lists.infradead.org>; Fri, 27 Jul 2018 00:21:10 -0700 (PDT)
Date: Fri, 27 Jul 2018 16:22:43 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v12 13/16] arm64: kexec_file: invoke the kernel without
 purgatory
Message-ID: <20180727072242.GH11258@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-14-takahiro.akashi@linaro.org>
 <b9257c90-a538-fb82-b9de-574d68d06fbd@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b9257c90-a538-fb82-b9de-574d68d06fbd@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Thu, Jul 26, 2018 at 02:36:07PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 24/07/18 07:57, AKASHI Takahiro wrote:
> > On arm64, purgatory would do almost nothing. So just invoke secondary
> > kernel directly by jumping into its entry code.
> > 
> > While, in this case, cpu_soft_restart() must be called with dtb address
> > in the fifth argument, the behavior still stays compatible with kexec_load
> > case as long as the argument is null.
> 
> This patch conflicts with commit 76f4e2da45b4 ("arm64: kexec: always reset to
> EL2 if present") in the arm64 tree.

I haven't noticed Mark's patch.

I'm going to have to refresh my memory regarding why I introduced
el2_switch when I implemented kdump.
According to my current memory, however, I added
kvm_arch_hardware_enable/disable(), and associated functions, to gracefully
shutdown EL2 in case of kexec. Since we have no chance to call reset
function (via notifier) at kdump, I believed that el2_switch was necessary
for better chance of successful kdump.

Thanks,
-Takahiro AKASHI

> Thanks,
> 
> James
> 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index f76ea92dff91..830a5063e09d 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -205,10 +205,18 @@ void machine_kexec(struct kimage *kimage)
> >  	 * uses physical addressing to relocate the new image to its final
> >  	 * position and transfers control to the image entry point when the
> >  	 * relocation is complete.
> > +	 * In kexec case, kimage->start points to purgatory assuming that
> > +	 * kernel entry and dtb address are embedded in purgatory by
> > +	 * userspace (kexec-tools).
> > +	 * In kexec_file case, the kernel starts directly without purgatory.
> >  	 */
> > -
> >  	cpu_soft_restart(kimage != kexec_crash_image,
> > -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> > +		reboot_code_buffer_phys, kimage->head, kimage->start,
> > +#ifdef CONFIG_KEXEC_FILE
> > +						kimage->arch.dtb_mem);
> > +#else
> > +						0);
> > +#endif
> >  
> >  	BUG(); /* Should never get here. */
> >  }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

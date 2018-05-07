Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fFYac-0001FC-M3
 for kexec@lists.infradead.org; Mon, 07 May 2018 05:21:36 +0000
Received: by mail-io0-x243.google.com with SMTP id r9-v6so32206300iod.6
 for <kexec@lists.infradead.org>; Sun, 06 May 2018 22:21:23 -0700 (PDT)
Date: Mon, 7 May 2018 14:22:09 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
Message-ID: <20180507052208.GD11326@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
 <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Tue, May 01, 2018 at 06:46:06PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 25/04/18 07:26, AKASHI Takahiro wrote:
> > On arm64, purugatory would do almosty nothing. So just invoke secondary
> > kernel directy by jumping into its entry code.
> 
> (Nits: purgatory, almost, directly)

Oops, I think I ran spell before ...

> 
> > While, in this case, cpu_soft_restart() must be called with dtb address
> > in the fifth argument, the behavior still stays compatible with kexec_load
> > case as long as the argument is null.
> 
> 
> > diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> > index 8021b46c9743..391df91328ac 100644
> > --- a/arch/arm64/kernel/cpu-reset.S
> > +++ b/arch/arm64/kernel/cpu-reset.S
> > @@ -24,9 +24,9 @@
> >   *
> >   * @el2_switch: Flag to indicate a swich to EL2 is needed.
> 
> (Nit: switch)

ditto

> >   * @entry: Location to jump to for soft reset.
> > - * arg0: First argument passed to @entry.
> > - * arg1: Second argument passed to @entry.
> > - * arg2: Third argument passed to @entry.
> > + * arg0: First argument passed to @entry. (relocation list)
> > + * arg1: Second argument passed to @entry.(physcal kernel entry)
> 
> (Nit: physical)

ditto
> 
> > + * arg2: Third argument passed to @entry. (physical dtb address)
> >   *
> >   * Put the CPU into the same state as it would be if it had been reset, and
> >   * branch to what would be the reset vector. It must be executed with the
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index f76ea92dff91..f7dbba00be10 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
> >  	 * uses physical addressing to relocate the new image to its final
> >  	 * position and transfers control to the image entry point when the
> >  	 * relocation is complete.
> > +	 * In case of kexec_file_load syscall, we directly start the kernel,
> > +	 * skipping purgatory.
> 
> We're not really skipping purgatory, purgatory doesn't exist! For regular kexec
> the image/payload we run is up to kexec-tools. For kexec_file_load its a
> kernel-image. Purgatory is a kexec-tools-ism.

You are right, but in general, purgatory is expected to exist by
generic kexec code and does exist on all architectures,  kexec_load()
or kexec_file_load(), except arm64's kexec_file_load case.
So it would be nice to have some explicit notes here.

> 
> >  	cpu_soft_restart(kimage != kexec_crash_image,
> > -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> > +		reboot_code_buffer_phys, kimage->head, kimage->start,
> > +#ifdef CONFIG_KEXEC_FILE
> > +				kimage->purgatory_info.purgatory_buf ?
> > +						0 : kimage->arch.dtb_mem);
> > +#else
> > +				0);
> > +#endif
> 
> Where does kimage->arch.dtb_mem come from? This patch won't build until patch 8
> adds the config option, which is going to make bisecting any kexec side-effects
> tricky.

CONFIG_KEXEC_FILE is also used in patch #4, #5 and #6.
I don't know how we can fix this as the implementation is divided
into several patches.
(So bisecting doesn't work anyway.)

> purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
> kexec_load_purgatory(), which we don't use. How does this get a value?
> 
> Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
> regular kexec (as we can't know where the dtb is)? (image_arg may then be a
> better name).

The problem is arch.dtb_mem is currently defined only if CONFIG_KEXEC_FILE.
So I would like to
- merge this patch with patch#8
- change the condition
        #ifdef CONFIG_KEXEC_FILE
       				kimage->file_mode ? kimage->arch.dtb_mem : 0);
        #else
        			0);
        #endif

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fIRqd-0006xz-54
 for kexec@lists.infradead.org; Tue, 15 May 2018 04:46:04 +0000
Received: by mail-pg0-x244.google.com with SMTP id z4-v6so6429172pgu.13
 for <kexec@lists.infradead.org>; Mon, 14 May 2018 21:45:53 -0700 (PDT)
Date: Tue, 15 May 2018 13:45:43 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v9 03/11] arm64: kexec_file: invoke the kernel without
 purgatory
Message-ID: <20180515044542.GC2737@linaro.org>
References: <20180425062629.29404-1-takahiro.akashi@linaro.org>
 <20180425062629.29404-4-takahiro.akashi@linaro.org>
 <9c830fe8-56d8-b43a-6265-43d31dffe61a@arm.com>
 <20180507052208.GD11326@linaro.org>
 <ece8d3cc-127f-6855-52fb-24e4a1d4e823@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ece8d3cc-127f-6855-52fb-24e4a1d4e823@arm.com>
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

James,

On Fri, May 11, 2018 at 06:03:49PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 07/05/18 06:22, AKASHI Takahiro wrote:
> > On Tue, May 01, 2018 at 06:46:06PM +0100, James Morse wrote:
> >> On 25/04/18 07:26, AKASHI Takahiro wrote:
> >>> diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> >>> index f76ea92dff91..f7dbba00be10 100644
> >>> --- a/arch/arm64/kernel/machine_kexec.c
> >>> +++ b/arch/arm64/kernel/machine_kexec.c
> >>> @@ -205,10 +205,17 @@ void machine_kexec(struct kimage *kimage)
> 
> >>>  	cpu_soft_restart(kimage != kexec_crash_image,
> >>> -		reboot_code_buffer_phys, kimage->head, kimage->start, 0);
> >>> +		reboot_code_buffer_phys, kimage->head, kimage->start,
> >>> +#ifdef CONFIG_KEXEC_FILE
> >>> +				kimage->purgatory_info.purgatory_buf ?
> >>> +						0 : kimage->arch.dtb_mem);
> >>> +#else
> >>> +				0);
> >>> +#endif
> 
> 
> >> purgatory_buf seems to only be set in kexec_purgatory_setup_kbuf(), called from
> >> kexec_load_purgatory(), which we don't use. How does this get a value?
> >>
> >> Would it be better to always use kimage->arch.dtb_mem, and ensure that is 0 for
> >> regular kexec (as we can't know where the dtb is)? (image_arg may then be a
> >> better name).
> > 
> > The problem is arch.dtb_mem is currently defined only if CONFIG_KEXEC_FILE.
> 
> I thought it was ARCH_HAS_KIMAGE_ARCH, which we can define all the time if
> that's what we want.
> 
> 
> > So I would like to
> > - merge this patch with patch#8
> > - change the condition
> >         #ifdef CONFIG_KEXEC_FILE
> >        				kimage->file_mode ? kimage->arch.dtb_mem : 0);
> >         #else
> >         			0);
> >         #endif
> 
> If we can avoid even this #ifdef by always having kimage->arch, I'd prefer that.
> If we do that 'dtb_mem' would need some thing that indicates its for kexec_file,
> as kexec has a DTB too, we just don't know where it is...

OK, but I want to have a minimum of kexec.arch always exist.
How about this?

| #define ARCH_HAS_KIMAGE_ARCH
|
| struct kimage_arch {
| 	phys_addr_t dtb_mem;
| #ifdef CONFIG_KEXEC_FILE
| 	void *dtb_buf;
| 	/* Core ELF header buffer */
| 	void *elf_headers;
| 	unsigned long elf_headers_sz;
| 	unsigned long elf_load_addr;
| #endif

| void machine_kexec(struct kimage *kimage)
| {
| 	...
| 	cpu_soft_restart(kimage != kexec_crash_image,
| 		reboot_code_buffer_phys, kimage->head, kimage->start,
| 						kimage->arch.dtb_mem);

Thanks
-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

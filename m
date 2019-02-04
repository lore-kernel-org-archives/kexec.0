Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date: Mon, 4 Feb 2019 16:04:33 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>, Bhupesh Sharma <bhsharma@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 1/30/2019 8:48 PM, Dave Young wrote:
> + more people
> On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
> > With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> > supports these extensions can support upto 52-bit virtual and 52-bit
> > physical addresses respectively.
> >
> > Since at the moment we enable the support of these extensions via CONFIG
> > flags, e.g.
> >  - LPA via CONFIG_ARM64_PA_BITS_52
> >
> > there are no clear mechanisms in user-space right now to
> > deteremine these CONFIG flag values and also determine the PARange and
> > VARange address values.
> >
> > User-space tools like 'makedumpfile' and 'crash-utility' can instead
> > use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> > the maximum virtual address and physical address (respectively)
> > supported by underlying kernel.
> >
> > A reference 'makedumpfile' implementation which uses this approach to
> > determining the maximum physical address is available in [0].
> >
> > [0].
> https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
> 
> I'm not objecting the patch, just want to make sure to make clear about
> things and make sure these issues are aware by people, and leave arm
> people to review the arm bits.
> 
> 1. MAX_PHYSMEM_BITS
> As we previously found, back to 2014 makedumpfile took a patch to read the
> value from vmcore but the kernel patch was not accepted.
> So we should first make clear if this is really needed, why other arches
> do not need this in makedumpfile.
> 
> If we really need it then should it be arm64 only?
> 
> If it is arm64 only then the makedumpfile code should read this number
> only for arm64.

Sorry for the delay.

According to the kernel patch, some of arm32 platforms may need it
http://lists.infradead.org/pipermail/kexec/2014-May/011909.html
but except for them (and arm64), makedumpfile can manage with kernel
version and some switches to determine this value so far.

> 
> Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> tree,  need to make sure to document this as well.
> 
> 2. MAX_USER_VA_BITS
> Does makedumpfile care about userspace VA bits?  I do not see other code
> doing this,  Kazu and Dave A should be able to comment.

The mapping makedumpfile uses on arm64 is swapper_pg_dir only, so
unless the config affects its structure or something, makedumpfile
will not need this value.

Thanks,
Kazu

> 
> I tend to doubt about this.
> 
> >
> > Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: James Morse <james.morse@arm.com>
> > Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> > ---
> >  arch/arm64/kernel/crash_core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> > index ca4c3e12d8c5..ad231be5c0d8 100644
> > --- a/arch/arm64/kernel/crash_core.c
> > +++ b/arch/arm64/kernel/crash_core.c
> > @@ -10,6 +10,8 @@
> >  void arch_crash_save_vmcoreinfo(void)
> >  {
> >  	VMCOREINFO_NUMBER(VA_BITS);
> > +	VMCOREINFO_NUMBER(MAX_USER_VA_BITS);
> > +	VMCOREINFO_NUMBER(MAX_PHYSMEM_BITS);
> >  	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
> >  	vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> >  						kimage_voffset);
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> Thanks
> Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

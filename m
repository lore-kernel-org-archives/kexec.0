Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gteD5-0002qF-8I
 for kexec@lists.infradead.org; Tue, 12 Feb 2019 19:59:18 +0000
Received: by mail-lf1-f68.google.com with SMTP id t14so2994045lfk.7
 for <kexec@lists.infradead.org>; Tue, 12 Feb 2019 11:59:14 -0800 (PST)
MIME-Version: 1.0
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed, 13 Feb 2019 01:29:00 +0530
Message-ID: <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Feb 12, 2019 at 4:14 PM Dave Young <dyoung@redhat.com> wrote:
>
> On 02/12/19 at 10:37am, Bhupesh Sharma wrote:
> > Hi Kazu,
> >
> > On 02/04/2019 09:34 PM, Kazuhito Hagio wrote:
> > > On 1/30/2019 8:48 PM, Dave Young wrote:
> > > > + more people
> > > > On 01/30/19 at 05:53pm, Bhupesh Sharma wrote:
> > > > > With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
> > > > > supports these extensions can support upto 52-bit virtual and 52-bit
> > > > > physical addresses respectively.
> > > > >
> > > > > Since at the moment we enable the support of these extensions via CONFIG
> > > > > flags, e.g.
> > > > >   - LPA via CONFIG_ARM64_PA_BITS_52
> > > > >
> > > > > there are no clear mechanisms in user-space right now to
> > > > > deteremine these CONFIG flag values and also determine the PARange and
> > > > > VARange address values.
> > > > >
> > > > > User-space tools like 'makedumpfile' and 'crash-utility' can instead
> > > > > use the 'MAX_USER_VA_BITS' and 'MAX_PHYSMEM_BITS' values to determine
> > > > > the maximum virtual address and physical address (respectively)
> > > > > supported by underlying kernel.
> > > > >
> > > > > A reference 'makedumpfile' implementation which uses this approach to
> > > > > determining the maximum physical address is available in [0].
> > > > >
> > > > > [0].
> > > > https://github.com/bhupesh-sharma/makedumpfile/blob/52-bit-pa-support-via-vmcore-v1/arch/arm64.c#L490
> > > >
> > > > I'm not objecting the patch, just want to make sure to make clear about
> > > > things and make sure these issues are aware by people, and leave arm
> > > > people to review the arm bits.
> > > >
> > > > 1. MAX_PHYSMEM_BITS
> > > > As we previously found, back to 2014 makedumpfile took a patch to read the
> > > > value from vmcore but the kernel patch was not accepted.
> > > > So we should first make clear if this is really needed, why other arches
> > > > do not need this in makedumpfile.
> > > >
> > > > If we really need it then should it be arm64 only?
> > > >
> > > > If it is arm64 only then the makedumpfile code should read this number
> > > > only for arm64.
> > >
> > > Sorry for the delay.
> > >
> > > According to the kernel patch, some of arm32 platforms may need it
> > > http://lists.infradead.org/pipermail/kexec/2014-May/011909.html
> > > but except for them (and arm64), makedumpfile can manage with kernel
> > > version and some switches to determine this value so far.
> > >
> > > >
> > > > Also Lianbo added the vmcoreinfo documents, I believe it stays in -tip
> > > > tree,  need to make sure to document this as well.
> > > >
> > > > 2. MAX_USER_VA_BITS
> > > > Does makedumpfile care about userspace VA bits?  I do not see other code
> > > > doing this,  Kazu and Dave A should be able to comment.
> > >
> > > The mapping makedumpfile uses on arm64 is swapper_pg_dir only, so
> > > unless the config affects its structure or something, makedumpfile
> > > will not need this value.
> >
> > I captured this case in more details while sending out the makedumpfile
> > enablement patch for ARMv8.2-LVA (see [0]), but here is a brief summary on
> > the same:
> >
> > Since at the moment we enable the support of the ARMv8.2-LVA extension for
> > 52-bit user-space VA in the kernel via a CONFIG flags
> > (CONFIG_ARM64_USER_VA_BITS_52), so there are no clear mechanisms in
> > user-space to determine this CONFIG
> > flag value and use it to determine the address range values.
> >
> > Since 'VA_BITS' are already exported via vmcoreinfo, if we export
> > 'MAX_USER_VA_BITS' as well, we can use the same in user-space to check if
> > the 'MAX_USER_VA_BITS' value is greater than 'VA_BITS'. If yes, then we are
> > running a use-case where user-space is 52-bit while the underlying kernel is
> > still 48-bit.
>
> Problem is why this is needed, it sounds like you are talking about some
> non-exist use case.

I already explained this in an earlier reply to your initial comments
(see <http://lists.infradead.org/pipermail/kexec/2019-January/022395.html>).
Perhaps you missed reading it, so here are the architecturally
possible and kernel supported uses cases with ARMv8.2 extensions
(depending on the combination of CONFIG flags and kernel version):

- 48-bit kernel VA + 48-bit user-space VA + 52-bit PA
- 48-bit kernel VA + 52-bit user-space VA + 52-bit PA
- 52-bit kernel VA + 52-bit user-space VA + 52-bit PA

Please see 'config ARM64_USER_VA_BITS_52'  help text inside
'arch/arm64/Kconfig' for more details:
config ARM64_USER_VA_BITS_52
    bool "52-bit (user)"
    depends on ARM64_64K_PAGES && (ARM64_PAN || !ARM64_SW_TTBR0_PAN)
    help
      Enable 52-bit virtual addressing for userspace when explicitly
      requested via a hint to mmap(). The kernel will continue to
      use 48-bit virtual addresses for its own mappings.

BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
(which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
mentioned that the changes look necessary.

[0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html

Thanks,
Bhupesh

> >
> > The increased 'PTRS_PER_PGD' value for such cases needs to be then
> > calculated as is done by the underlying kernel (see
> > 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> >
> > #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
> >
> > Also, note that 'arch/arm64/include/asm/memory.h' defines 'MAX_USER_VA_BITS'
> > as 'VA_BITS' in case 'CONFIG_ARM64_USER_VA_BITS_52' is set to 'n':
> >
> > #ifdef CONFIG_ARM64_USER_VA_BITS_52
> > #define MAX_USER_VA_BITS      52
> > #else
> > #define MAX_USER_VA_BITS      VA_BITS
> > #endif
> >
> > So, makedumpfile will need this symbol exported in vmcore to make the above
> > determination.
> >
> > [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
> >
> > Thanks,
> > Bhupesh
>
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

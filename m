Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ek7zN-0005u5-VU
 for kexec@lists.infradead.org; Fri, 09 Feb 2018 12:41:15 +0000
Received: by mail-pl0-x241.google.com with SMTP id 36so1408802ple.13
 for <kexec@lists.infradead.org>; Fri, 09 Feb 2018 04:41:03 -0800 (PST)
Date: Fri, 9 Feb 2018 21:40:56 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v7 05/11] arm64: kexec_file: create purgatory
Message-ID: <20180209124055.xlwqdvb33uxsqlzh@fireball>
References: <20171204025801.12161-1-takahiro.akashi@linaro.org>
 <20171204025801.12161-6-takahiro.akashi@linaro.org>
 <5A7B475C.2080008@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5A7B475C.2080008@arm.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Wed, Feb 07, 2018 at 06:37:16PM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 04/12/17 02:57, AKASHI Takahiro wrote:
> > This is a basic purgatory, or a kind of glue code between the two kernels,
> > for arm64.
> > 
> > Since purgatory is assumed to be relocatable (not executable) object by
> > kexec generic code, arch_kexec_apply_relocations_add() is required in
> > general. Arm64's purgatory, however, is a simple asm and all the references
> > can be resolved as local, no re-linking is needed here.
> > 
> > Please note that even if we don't support digest check at purgatory we
> 
> (You knew what I was going to ask!)

Yes, definitely.

> 
> > need purgatory_sha_regions and purgatory_sha256_digest as they are
> > referenced by generic kexec code.
> 
> As somewhere to store the values? If we aren't doing the validation could we add
> something about why not to the commit message? I think its because we only worry
> about memory corruption for kdump, and for kdump we unmap the crash-kernel
> region during normal-operation to prevent it getting corrupted.
> 
> As we aren't doing the hash validation, could we hide its core-code behind some
> ARCH_HAS_KEXEC_PURGATORY_HASH, instead of defining dummy symbols and doing
> unnecessary work to fill them in?

Yes, this is one idea.
But as you mentioned below, adding a purgatory for arm64's kexec_file
does make little sense as I've already removed digest check code after
MarkR's comment.

> 
> > diff --git a/arch/arm64/purgatory/entry.S b/arch/arm64/purgatory/entry.S
> > new file mode 100644
> > index 000000000000..fe6e968076db
> > --- /dev/null
> > +++ b/arch/arm64/purgatory/entry.S
> > @@ -0,0 +1,55 @@
> > +/*
> > + * kexec core purgatory
> > + */
> > +#include <linux/linkage.h>
> > +#include <uapi/linux/kexec.h>
> > +
> > +#define SHA256_DIGEST_SIZE	32 /* defined in crypto/sha.h */
> > +
> > +.text
> > +
> > +ENTRY(purgatory_start)
> > +	/* Start new image. */
> > +	ldr	x17, __kernel_entry
> > +	ldr	x0, __dtb_addr
> > +	mov	x1, xzr
> > +	mov	x2, xzr
> > +	mov	x3, xzr
> > +	br	x17
> > +END(purgatory_start)
> 
> Is this what arm64_relocate_new_kernel() drops into? I thought that had the
> kernel boot register values already so we wouldn't need another trampoline for
> kexec_file_load()...

Indeed

> .. but now that I look, it doesn't have the DTB, presumably because for regular
> kexec we don't know where user-space put it.
> 
> Could we add some x0_for_kexec that is 0 by default (if that's the ABI), or the

First, I didn't get what you meaned here.
After managing to modify my code, I found that we could re-use
cpu_soft_restart(), especially, the fifth argument, which is currently
contant 0, but we will be able to pass dtb address here.
In turn, we can also use this argument to determine, in relocate_new_kernel(),
whether we should call puragatory (kexec_load) or directly jump into the kernel
(kexec_file_load).


> DTB address for kexec_file_load()? This would avoid this extra trampoline, and
> patching in the values from load_other_segments().
> 
> I'd love to avoid an in-kernel purgatory! (its code with funny
> compile/link/relocation requirements that is impossible to debug)

Lovely!

I really appreicated your valuable comments.
and more on other patches comming?

-Takahiro AKASHI

> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

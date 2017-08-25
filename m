Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dl302-0002ei-1J
 for kexec@lists.infradead.org; Fri, 25 Aug 2017 01:01:27 +0000
Received: by mail-pg0-x230.google.com with SMTP id r133so6058078pgr.3
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 18:01:05 -0700 (PDT)
Date: Fri, 25 Aug 2017 10:00:59 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 08/14] arm64: kexec_file: create purgatory
Message-ID: <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170824165617.GC29665@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
> On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
> > This is a basic purgtory, or a kind of glue code between the two kernel,
> > for arm64. We will later add a feature of verifying a digest check against
> > loaded memory segments.
> > 
> > arch_kexec_apply_relocations_add() is responsible for re-linking any
> > relative symbols in purgatory. Please note that the purgatory is not
> > an executable, but a non-linked archive of binaries so relative symbols
> > contained here must be resolved at kexec load time.
> > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> > variables now, arch_kexec_apply_relocations_add() can manage more various
> > types of relocations.
> 
> Why does the purgatory code need to be so complex?
> 
> Why is it not possible to write this as position-independent asm?

I don't get your point, but please note that these values are also
re-written by the 1st kernel when it loads the 2nd kernel and so
they must appear as globals.

> > +/*
> > + * Apply purgatory relocations.
> > + *
> > + * ehdr: Pointer to elf headers
> > + * sechdrs: Pointer to section headers.
> > + * relsec: section index of SHT_RELA section.
> > + *
> > + * Note:
> > + * Currently R_AARCH64_ABS64, R_AARCH64_LD_PREL_LO19 and R_AARCH64_CALL26
> > + * are the only types to be generated from purgatory code.
> 
> Is this all that has been observed, or is this ensured somehow?

It was observed by inserting a debug print message in this function,
I'm not sure whether we can restrict only those three types.

> The arch_kexec_apply_relocations_add() function below duplicates a lot
> of logic that already exists in the arm64 module loader's
> apply_relocate_add() function.
> 
> Please reuse that code. Having a duplicate or alternative implementation
> is just asking for subtle bugs.

Okey, I'll look at it.

Thanks,
-Takahiro AKASHI


> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

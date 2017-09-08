Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x233.google.com ([2607:f8b0:400e:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dq9IS-0002Vq-2A
 for kexec@lists.infradead.org; Fri, 08 Sep 2017 02:45:34 +0000
Received: by mail-pg0-x233.google.com with SMTP id m9so2662194pgd.3
 for <kexec@lists.infradead.org>; Thu, 07 Sep 2017 19:45:11 -0700 (PDT)
Date: Fri, 8 Sep 2017 11:46:53 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 08/14] arm64: kexec_file: create purgatory
Message-ID: <20170908024653.GC17186@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
 <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825102250.GA3127@leverpostej>
 <878ti7fws9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <878ti7fws9.fsf@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

On Fri, Aug 25, 2017 at 01:16:06PM -0300, Thiago Jung Bauermann wrote:
> 
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> > On Fri, Aug 25, 2017 at 10:00:59AM +0900, AKASHI Takahiro wrote:
> >> On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
> >> > On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
> >> > > This is a basic purgtory, or a kind of glue code between the two kernel,
> >> > > for arm64. We will later add a feature of verifying a digest check against
> >> > > loaded memory segments.
> >> > > 
> >> > > arch_kexec_apply_relocations_add() is responsible for re-linking any
> >> > > relative symbols in purgatory. Please note that the purgatory is not
> >> > > an executable, but a non-linked archive of binaries so relative symbols
> >> > > contained here must be resolved at kexec load time.
> >> > > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
> >> > > variables now, arch_kexec_apply_relocations_add() can manage more various
> >> > > types of relocations.
> >> > 
> >> > Why does the purgatory code need to be so complex?
> >> > 
> >> > Why is it not possible to write this as position-independent asm?
> >> 
> >> I don't get your point, but please note that these values are also
> >> re-written by the 1st kernel when it loads the 2nd kernel and so
> >> they must appear as globals.
> >
> > My fear about complexity is that we must "re-link" the purgatory.
> >
> > I don't understand why that has to be necessary. Surely we can have the
> > purgatory code be position independent, and store those globals in a
> > single struct purgatory_info that we can fill in from the host?
> >
> > i.e. similar to what we do for values shared with the VDSO, where we
> > just poke vdso_data->field, no re-linking required.
> 
> Right. I'm not sure why it is a partially linked object. I believe that
> the purgatory could be linked at build time into a PIE executable with
> exported symbols for the variables that need to be filled in from the
> host.

For clarification, generic kexec code expects that the purgatory is
*relocatable* (not executable in ELF terms) as compiled with -r gcc option.
On arm64, in this case, all the *global* symbols remain to be un-resolved
even if the references are local within a single section (in a file).
This would require re-linking at purgatory load time.

I'm going to resolve this issue by adding extra *local labels*.
(See my v2.)

> On some architectures (e.g., powerpc), this would greatly reduce the
> number of relocation types that the kernel needs to know how to process.
> On x86 it make less of a difference because the partially linked object
> already has just a handful of relocation types.
> 
> > Otherwise, why can't the purgatory code be written in assembly? AFAICT,
> > the only complex part is the hashing code, which I don't beleive is
> > strictly necessary.
> 
> When I posted a similar series for powerpc with similar changes to
> handle a partially linked purgatory in the kernel, Michael Ellerman
> preferred to go for a purgatory written in assembly, partially based on
> the one from kexec-lite. That purgatory doesn't do the checksum
> verification of the segments.

Anyhow, I will drop hash-check code from the purgatory in v2 so that
it will now be quite a simple asm.

Thanks,
-Takahiro AKASHI

> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

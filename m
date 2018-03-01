Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erERK-0004Qg-5e
 for kexec@lists.infradead.org; Thu, 01 Mar 2018 02:59:28 +0000
Received: by mail-pg0-x241.google.com with SMTP id l131so1772230pga.2
 for <kexec@lists.infradead.org>; Wed, 28 Feb 2018 18:59:15 -0800 (PST)
Date: Thu, 1 Mar 2018 11:59:22 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v8 02/13] kexec_file: make an use of purgatory optional
Message-ID: <20180301025921.GL6019@linaro.org>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-3-takahiro.akashi@linaro.org>
 <20180223084934.GB4433@dhcp-128-65.nay.redhat.com>
 <20180226102418.GD6019@linaro.org>
 <20180228123359.GB2228@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180228123359.GB2228@dhcp-128-65.nay.redhat.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, julien.thierry@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, davem@davemloft.net, vgoyal@redhat.com

On Wed, Feb 28, 2018 at 08:33:59PM +0800, Dave Young wrote:
> On 02/26/18 at 07:24pm, AKASHI Takahiro wrote:
> > On Fri, Feb 23, 2018 at 04:49:34PM +0800, Dave Young wrote:
> > > Hi AKASHI,
> > > 
> > > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > > > On arm64, no trampline code between old kernel and new kernel will be
> > > > required in kexec_file implementation. This patch introduces a new
> > > > configuration, ARCH_HAS_KEXEC_PURGATORY, and allows related code to be
> > > > compiled in only if necessary.
> > > 
> > > Here also need the explanation about why no purgatory is needed, it would be
> > > required for kexec if no strong reason.
> > 
> > OK, I will add the reason:
> > On arm64, crash dump kernel's usable memory is protected by
> > *unmapping* it from kernel virtual space unlike other architectures
> > where the region is just made read-only.
> > So our key developers think that it is highly unlikely that the region
> > is accidentally corrupted and this rationalizes that digest check code
> > be also dropped from purgatory.
> > This greatly simplifies our purgatory without any need for a bit ugly
> > relocation stuff, i.e. arch_kexec_apply_relocations_add().
> > 
> > Please see:
> >    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
> > to find out how simple our purgatory was. All that it does is
> > to shuffle arguments and jump into a new kernel.
> > 
> > Without this patch, we would have to have purgatory with a space for
> > a hash value (purgatory_sha256_digest) which is never checked against.
> > 
> > Do you think it makes sense?
> 
> Hmm, it looks reasonable, I remember there could be some performance
> issue for a purgatory because of cache disabled for arm64. I do not
> object this.

Yeah, Pratyush(redhat) had expressed his concerns on slow boot-up of
the 2nd kernel which is due to hash value calculation.

-Takahiro AKASHI

> 
> [snip]
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

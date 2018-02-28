Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Wed, 28 Feb 2018 20:33:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v8 02/13] kexec_file: make an use of purgatory optional
Message-ID: <20180228123359.GB2228@dhcp-128-65.nay.redhat.com>
References: <20180222111732.23051-1-takahiro.akashi@linaro.org>
 <20180222111732.23051-3-takahiro.akashi@linaro.org>
 <20180223084934.GB4433@dhcp-128-65.nay.redhat.com>
 <20180226102418.GD6019@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180226102418.GD6019@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dhowells@redhat.com, vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net, akpm@linux-foundation.org, mpe@ellerman.id.au, bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org, julien.thierry@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 02/26/18 at 07:24pm, AKASHI Takahiro wrote:
> On Fri, Feb 23, 2018 at 04:49:34PM +0800, Dave Young wrote:
> > Hi AKASHI,
> > 
> > On 02/22/18 at 08:17pm, AKASHI Takahiro wrote:
> > > On arm64, no trampline code between old kernel and new kernel will be
> > > required in kexec_file implementation. This patch introduces a new
> > > configuration, ARCH_HAS_KEXEC_PURGATORY, and allows related code to be
> > > compiled in only if necessary.
> > 
> > Here also need the explanation about why no purgatory is needed, it would be
> > required for kexec if no strong reason.
> 
> OK, I will add the reason:
> On arm64, crash dump kernel's usable memory is protected by
> *unmapping* it from kernel virtual space unlike other architectures
> where the region is just made read-only.
> So our key developers think that it is highly unlikely that the region
> is accidentally corrupted and this rationalizes that digest check code
> be also dropped from purgatory.
> This greatly simplifies our purgatory without any need for a bit ugly
> relocation stuff, i.e. arch_kexec_apply_relocations_add().
> 
> Please see:
>    http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545428.html
> to find out how simple our purgatory was. All that it does is
> to shuffle arguments and jump into a new kernel.
> 
> Without this patch, we would have to have purgatory with a space for
> a hash value (purgatory_sha256_digest) which is never checked against.
> 
> Do you think it makes sense?

Hmm, it looks reasonable, I remember there could be some performance
issue for a purgatory because of cache disabled for arm64. I do not
object this.

[snip]

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

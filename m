Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqoFb-00BT3J-DU
 for kexec@lists.infradead.org; Wed, 09 Jun 2021 02:47:28 +0000
Date: Wed, 9 Jun 2021 10:47:09 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] crash_core, vmcoreinfo: Append 'SECTION_SIZE_BITS' to
 vmcoreinfo
Message-ID: <20210609024709.GA591017@MiWiFi-R3L-srv>
References: <20210608103359.84907-1-kernelfans@gmail.com>
 <20210608142432.GA587883@MiWiFi-R3L-srv>
 <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210608141410.0026a925ba3a609b0dd4e560@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pingfan Liu <kernelfans@gmail.com>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Dave Young <dyoung@redhat.com>, Boris Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org

On 06/08/21 at 02:14pm, Andrew Morton wrote:
> On Tue, 8 Jun 2021 22:24:32 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > On 06/08/21 at 06:33am, Pingfan Liu wrote:
> > > As mentioned in kernel commit 1d50e5d0c505 ("crash_core, vmcoreinfo:
> > > Append 'MAX_PHYSMEM_BITS' to vmcoreinfo"), SECTION_SIZE_BITS in the
> > > formula:
> > >     #define SECTIONS_SHIFT    (MAX_PHYSMEM_BITS - SECTION_SIZE_BITS)
> > > 
> > > Besides SECTIONS_SHIFT, SECTION_SIZE_BITS is also used to calculate
> > > PAGES_PER_SECTION in makedumpfile just like kernel.
> > > 
> > > Unfortunately, this arch-dependent macro SECTION_SIZE_BITS changes, e.g.
> > > recently in kernel commit f0b13ee23241 ("arm64/sparsemem: reduce
> > > SECTION_SIZE_BITS"). But user space wants a stable interface to get this
> > > info. Such info is impossible to be deduced from a crashdump vmcore.
> > > Hence append SECTION_SIZE_BITS to vmcoreinfo.
> > 
> > ...
> >
> > Add the discussion of the original thread in kexec ML for reference:
> > http://lists.infradead.org/pipermail/kexec/2021-June/022676.html
> 
> I added a Link: for this.

Thanks, Andrew.

>  
> > This looks good to me.
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> 
> I'm thinking we should backport this at least to Fixes:f0b13ee23241. 
> But perhaps it's simpler to just backport it as far as possible, so I
> added a bare cc:stable with no Fixes:.  Thoughts?

Yeah, it should add cc:stable, thanks. Otherwise it will break
vmcore dumping on 5.12 stable kernel even though with the updated
makedumpfile utility. Fixes:f0b13ee23241 will help stable kernel
maintainer easier to identify which kernel this patch need be applied
on? If only having cc:stable with no Fixes is allowed, it's also OK. 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

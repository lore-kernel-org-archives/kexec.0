Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxoX3-0051a5-Sl
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 11:02:43 +0000
Date: Thu, 16 Dec 2021 12:02:36 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/3] arm64: read VA_BITS from kcore for 52-bits VA kernel
Message-ID: <20211216110236.GB19841@vergenet.net>
References: <20211210030735.53155-1-piliu@redhat.com>
 <20211210030735.53155-4-piliu@redhat.com>
 <20211215130557.GB4314@vergenet.net>
 <CAF+s44TYhz0_MG0Fpv2e7kTqyLgS2SwpB=+_=QQGv0vdx1qs1A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44TYhz0_MG0Fpv2e7kTqyLgS2SwpB=+_=QQGv0vdx1qs1A@mail.gmail.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org

On Thu, Dec 16, 2021 at 09:59:42AM +0800, Pingfan Liu wrote:
> On Wed, Dec 15, 2021 at 9:06 PM Signed-off-by@vergenet.net:Simon
> Horman <horms@verge.net.au> wrote:
> >
> > On Fri, Dec 10, 2021 at 11:07:35AM +0800, Pingfan Liu wrote:
> > > phys_to_virt() calculates virtual address. As a important factor,
> > > page_offset is excepted to be accurate.
> > >
> > > Since arm64 kernel exposes va_bits through vmcore, using it.
> > >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > ---
> > >  kexec/arch/arm64/kexec-arm64.c | 31 +++++++++++++++++++++++++++----
> > >  kexec/arch/arm64/kexec-arm64.h |  1 +
> > >  util_lib/elf_info.c            |  5 +++++
> > >  3 files changed, 33 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > > index bd650e6..ccc92db 100644
> > > --- a/kexec/arch/arm64/kexec-arm64.c
> > > +++ b/kexec/arch/arm64/kexec-arm64.c
> > > @@ -54,7 +54,7 @@
> > >  static bool try_read_phys_offset_from_kcore = false;
> > >
> > >  /* Machine specific details. */
> > > -static int va_bits;
> > > +static int va_bits = -1;
> > >  static unsigned long page_offset;
> > >
> > >  /* Global varables the core kexec routines expect. */
> > > @@ -876,7 +876,15 @@ static inline void set_phys_offset(long v, char *set_method)
> > >
> > >  static int get_va_bits(void)
> > >  {
> > > -     unsigned long long stext_sym_addr = get_kernel_sym("_stext");
> > > +     unsigned long long stext_sym_addr;
> > > +
> > > +     /*
> > > +      * if already got from kcore
> > > +      */
> > > +     if (va_bits != -1)
> > > +             goto out;
> >
> > If va_bits is exposed by the kernel then it will be used.
> > Else we continue here. Are there actually cases (old kernels) where
> > we expect to continue. Or could we get rid of the fallback code here?
> >
> 
> va_bits is exposed by kernel commit 84c57dbd3c48 ("arm64: kernel:
> arch_crash_save_vmcoreinfo() should depend on CONFIG_CRASH_CORE")
> And the first kernel which contains VA_BITS is v4.19.
> I have no idea about the need for old kernels. Maybe just keep the
> compatible code and throw a warning to remind users?

I suspect that kexec for ARM64 was present in v4.19, so we
should leave this part as-is.

> > > +
> > > +     stext_sym_addr = get_kernel_sym("_stext");
> > >
> > >       if (stext_sym_addr == 0) {
> > >               fprintf(stderr, "Can't get the symbol of _stext.\n");
> > > @@ -900,6 +908,7 @@ static int get_va_bits(void)
> > >               return -1;
> > >       }
> > >
> > > +out:
> > >       dbgprintf("va_bits : %d\n", va_bits);
> > >
> > >       return 0;
> > > @@ -917,14 +926,27 @@ int get_page_offset(unsigned long *page_offset)
> > >       if (ret < 0)
> > >               return ret;
> > >
> >
> > I'm confused about why there is both a (va_bits - 1)
> > and va_bits case here.
> >
> 
> It originates from the changes of memory layout on arm64.
> And mostly it is contributed by kernel commit 14c127c957c1 ("arm64:
> mm: Flip kernel VA space"),
> where sees the changes:
> -#define PAGE_OFFSET            (UL(0xffffffffffffffff) - \
>         (UL(1) << (VA_BITS - 1)) + 1)
> +#define PAGE_OFFSET            (UL(0xffffffffffffffff) - \
> +       (UL(1) << VA_BITS) + 1)
> 
> 
> Thanks,
> 
> Pingfan
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

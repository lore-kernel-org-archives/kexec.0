Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxgmj-003L5u-4x
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 02:46:22 +0000
Received: by mail-io1-f72.google.com with SMTP id
 i20-20020a0566022c9400b005ec5bb1e85eso22288382iow.1
 for <kexec@lists.infradead.org>; Wed, 15 Dec 2021 18:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20211210030735.53155-1-piliu@redhat.com>
 <20211210030735.53155-4-piliu@redhat.com>
 <20211215143431.5ec72a36@rhtmp>
In-Reply-To: <20211215143431.5ec72a36@rhtmp>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 16 Dec 2021 10:46:07 +0800
Message-ID: <CAF+s44SaE=+OxOQcrbcYEs=76-ycJV3pyxRRYdN2bfACyR-iyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: read VA_BITS from kcore for 52-bits VA kernel
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
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, Dec 15, 2021 at 9:35 PM Philipp Rudo <prudo@redhat.com> wrote:
>
> Hi Pingfang,
>
> On Fri, 10 Dec 2021 11:07:35 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
>
> > phys_to_virt() calculates virtual address. As a important factor,
> > page_offset is excepted to be accurate.
> >
> > Since arm64 kernel exposes va_bits through vmcore, using it.
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > ---
> >  kexec/arch/arm64/kexec-arm64.c | 31 +++++++++++++++++++++++++++----
> >  kexec/arch/arm64/kexec-arm64.h |  1 +
> >  util_lib/elf_info.c            |  5 +++++
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > index bd650e6..ccc92db 100644
> > --- a/kexec/arch/arm64/kexec-arm64.c
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -54,7 +54,7 @@
> >  static bool try_read_phys_offset_from_kcore = false;
> >
> >  /* Machine specific details. */
> > -static int va_bits;
> > +static int va_bits = -1;
> >  static unsigned long page_offset;
> >
> >  /* Global varables the core kexec routines expect. */
> > @@ -876,7 +876,15 @@ static inline void set_phys_offset(long v, char *set_method)
> >
> >  static int get_va_bits(void)
> >  {
> > -     unsigned long long stext_sym_addr = get_kernel_sym("_stext");
> > +     unsigned long long stext_sym_addr;
> > +
> > +     /*
> > +      * if already got from kcore
> > +      */
> > +     if (va_bits != -1)
> > +             goto out;
> > +
> > +     stext_sym_addr = get_kernel_sym("_stext");
> >
> >       if (stext_sym_addr == 0) {
> >               fprintf(stderr, "Can't get the symbol of _stext.\n");
> > @@ -900,6 +908,7 @@ static int get_va_bits(void)
> >               return -1;
> >       }
> >
> > +out:
> >       dbgprintf("va_bits : %d\n", va_bits);
> >
> >       return 0;
> > @@ -917,14 +926,27 @@ int get_page_offset(unsigned long *page_offset)
> >       if (ret < 0)
> >               return ret;
> >
> > -     page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +     if (va_bits < 52)
> > +             *page_offset = (0xffffffffffffffffUL) << (va_bits - 1);
> > +     else
> > +             *page_offset = (0xffffffffffffffffUL) << va_bits;
>
> wouldn't it make sense to use ULONG_MAX here? At least for me it would
> be much better readable.
>

Yes, I tend to agree and will update it in V2 (if there is no need to
compile it on 32-bits machine, which I consider as a rare case
nowadays.)


> >       dbgprintf("page_offset : %lx\n", page_offset);
> >
> >       return 0;
> >  }
> >
> > +static void arm64_scan_vmcoreinfo(char *pos)
> > +{
> > +     const char *str;
> > +
> > +     str = "NUMBER(VA_BITS)=";
> > +     if (memcmp(str, pos, strlen(str)) == 0)
> > +             va_bits = strtoul(pos + strlen(str), NULL, 10);
> > +}
> > +
> >  /**
> > - * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET
> > + * get_phys_offset_from_vmcoreinfo_pt_note - Helper for getting PHYS_OFFSET (and va_bits)
> >   * from VMCOREINFO note inside 'kcore'.
> >   */
> >
> > @@ -937,6 +959,7 @@ static int get_phys_offset_from_vmcoreinfo_pt_note(long *phys_offset)
> >               return EFAILED;
> >       }
> >
> > +     arch_scan_vmcoreinfo = arm64_scan_vmcoreinfo;
> >       ret = read_phys_offset_elf_kcore(fd, phys_offset);
> >
> >       close(fd);
> > diff --git a/kexec/arch/arm64/kexec-arm64.h b/kexec/arch/arm64/kexec-arm64.h
> > index ed99d9d..d291705 100644
> > --- a/kexec/arch/arm64/kexec-arm64.h
> > +++ b/kexec/arch/arm64/kexec-arm64.h
> > @@ -66,6 +66,7 @@ struct arm64_mem {
> >
> >  #define arm64_mem_ngv UINT64_MAX
> >  extern struct arm64_mem arm64_mem;
> > +extern void (*arch_scan_vmcoreinfo)(char *pos);
>
> This definition isn't arm64 specific. I think this should go to
> util_lib/include/elf_info.h.
>
Good suggestion and update it in V2.


Thanks,

Pingfan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

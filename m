Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hyMD1-0007S2-Es
 for kexec@lists.infradead.org; Thu, 15 Aug 2019 20:18:58 +0000
Received: by mail-ed1-x544.google.com with SMTP id a21so3201757edt.11
 for <kexec@lists.infradead.org>; Thu, 15 Aug 2019 13:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <20190801152439.11363-3-pasha.tatashin@soleen.com>
 <e00455af-a9f6-82e1-4c0d-78fae01ae00a@arm.com>
In-Reply-To: <e00455af-a9f6-82e1-4c0d-78fae01ae00a@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Aug 2019 16:18:43 -0400
Message-ID: <CA+CK2bD-_34o0McpFwSYgEDyFa8MDXWUNid0GgVsUKC=ZiQzMg@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] arm64, mm: transitional tables
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
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 15, 2019 at 2:11 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 01/08/2019 16:24, Pavel Tatashin wrote:
> > There are cases where normal kernel pages tables, i.e. idmap_pg_dir
> > and swapper_pg_dir are not sufficient because they may be overwritten.
> >
> > This happens when we transition from one world to another: for example
> > during kexec kernel relocation transition, and also during hibernate
> > kernel restore transition.
> >
> > In these cases, if MMU is needed, the page table memory must be allocated
> > from a safe place. Transitional tables is intended to allow just that.
>
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index db92950bb1a0..dcb4f13c7888 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -110,6 +110,7 @@
> >  #define PUD_TABLE_BIT                (_AT(pudval_t, 1) << 1)
> >  #define PUD_TYPE_MASK                (_AT(pudval_t, 3) << 0)
> >  #define PUD_TYPE_SECT                (_AT(pudval_t, 1) << 0)
> > +#define PUD_SECT_RDONLY              (_AT(pudval_t, 1) << 7)         /* AP[2] */
>
> This shouldn't be needed. As far as I'm aware, we only get read-only pages in the linear
> map from debug-pagealloc, and the module aliases. Both of which require the linear map to
> be made of page-size mappings.
>
> Where are you seeing these?

This was done simply for generalization.

In old copy_pud:

445   set_pud(dst_pudp,
446   __pud(pud_val(pud) & ~PMD_SECT_RDONLY));

In new trans_table_copy_pud():
119                 if (!pud_table(src_pud)) {
120                         if (info->trans_flags & TRANS_MKWRITE)
121                                 pud_val(src_pud) &= ~PUD_SECT_RDONLY;

If you want, I can replace it with PMD_SECT_RDONLY

> > + * trans_flags
> > + *   - bitmap with flags that control how page table is filled.
> > + *     TRANS_MKWRITE: during page table copy make PTE, PME, and PUD page
> > + *                    writeable by removing RDONLY flag from PTE.
> > + *     TRANS_MKVALID: during page table copy, if PTE present, but not valid,
> > + *                    make it valid.
> > + *     TRANS_CHECKPFN: During page table copy, for every PTE entry check that
> > + *                     PFN that this PTE points to is valid. Otherwise return
> > + *                     -ENXIO
>
> Adding top-level global knobs to manipulate the copied linear map is going to lead to
> bugs. The existing code will only change the PTE in specific circumstances, that it tests
> for, that only happen at the PTE level.

I am simply doing the same what the old code is doing:

hibernate sets this flag if: debug_pagealloc_enabled() and trans_table
in this case check if pfn_valid() or not. This is part of
generalization, without which it is not possible to re-use the code
between kexec and hibernate.

>
>
> > + *     TRANS_FORCEMAP: During page map, if translation exists, force
> > + *                     overwrite it. Otherwise -ENXIO may be returned by
> > + *                     trans_table_map_* functions if conflict is detected.
>

I will remove it.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

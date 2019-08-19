Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hzkTA-0001eN-OE
 for kexec@lists.infradead.org; Mon, 19 Aug 2019 16:25:22 +0000
Received: by mail-ed1-x544.google.com with SMTP id s49so2236339edb.1
 for <kexec@lists.infradead.org>; Mon, 19 Aug 2019 09:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190817024629.26611-1-pasha.tatashin@soleen.com>
 <20190817024629.26611-3-pasha.tatashin@soleen.com>
 <20190819155014.GD9927@lakrids.cambridge.arm.com>
In-Reply-To: <20190819155014.GD9927@lakrids.cambridge.arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 19 Aug 2019 12:25:07 -0400
Message-ID: <CA+CK2bCnGVdNS=1wRBFhzKTkQJoi1=uD0Kof=pcePfG2eKHUYw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] arm64, hibernate: create_safe_exec_page cleanup
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
Cc: Sasha Levin <sashal@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Mark,

Thank you for your review comments. My replies below:

On Mon, Aug 19, 2019 at 11:50 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Aug 16, 2019 at 10:46:17PM -0400, Pavel Tatashin wrote:
> > create_safe_exec_page() is going to be split into two parts in preparation
> > of moving page table handling code out of hibernate.c
> >
> > Remove allocator parameter, and rename dst to page. Also, remove the
> > goto's, as we can return directly without cleanups.
>
> It would be nice if you could do the goto/allocator/rename changes as
> separate patches, since it's vastly easier to verify each change in
> isolation that way.

Sure, I will split these changes into separate patches in the next
version of this patch series.

>
> What's the point of the rename? It's inconsistent with the phys_dst_addr
> that you leave as-is, so I'm not sure that's worthwhile.

dst_addr, phys_dst_addr VA/PA destination addresses. But, page is a
buffer in the current VA space (hence changed to void *), dst looked
confusing as it seemed as it was part of the
destination addresses.

>
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/kernel/hibernate.c | 60 +++++++++++++++--------------------
> >  1 file changed, 26 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> > index 9341fcc6e809..96b6f8da7e49 100644
> > --- a/arch/arm64/kernel/hibernate.c
> > +++ b/arch/arm64/kernel/hibernate.c
> > @@ -196,57 +196,51 @@ EXPORT_SYMBOL(arch_hibernation_header_restore);
> >   */
> >  static int create_safe_exec_page(void *src_start, size_t length,
> >                                unsigned long dst_addr,
> > -                              phys_addr_t *phys_dst_addr,
> > -                              void *(*allocator)(gfp_t mask),
> > -                              gfp_t mask)
> > +                              phys_addr_t *phys_dst_addr)
> >  {
> > -     int rc = 0;
> > +     void *page = (void *)get_safe_page(GFP_ATOMIC);
> > +     pgd_t *trans_table;
>
> The addition of this trans_table variable wasn't mentioned in the commit
> message...
>
> > +     trans_table = (void *)get_safe_page(GFP_ATOMIC);
> > +     if (!trans_table)
> > +             return -ENOMEM;
> >
> > -     pgdp = pgd_offset_raw(allocator(mask), dst_addr);
> > +     pgdp = pgd_offset_raw(trans_table, dst_addr);
>
> > -     write_sysreg(phys_to_ttbr(virt_to_phys(pgdp)), ttbr0_el1);
> > +     write_sysreg(phys_to_ttbr(virt_to_phys(trans_table)), ttbr0_el1);
>
>
> ... and I guess you're trying to ensure that we program the TTBR with
> the correct base address, without the offset of whatever pgd entry we
> happen to have plumbed in?
>
> I think that's a fix, and should come before any other cleanup or
> rework.

Yes.

>
> If you can respin that specific change with s/trans_table/pgdir/, that
> would make sense to me.

I will split this patch into several changes. I will describe
trans_table rational in different e-mail. There we will decide what
namespace to use.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

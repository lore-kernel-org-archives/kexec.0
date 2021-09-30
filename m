Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVnRT-00CwHl-29
 for kexec@lists.infradead.org; Thu, 30 Sep 2021 04:13:08 +0000
Received: by mail-lf1-x133.google.com with SMTP id x27so19558201lfa.9
 for <kexec@lists.infradead.org>; Wed, 29 Sep 2021 21:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
 <20210916231325.125533-16-pasha.tatashin@soleen.com>
 <YVSXtswhm6iTC3yz@arm.com>
In-Reply-To: <YVSXtswhm6iTC3yz@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Sep 2021 00:12:28 -0400
Message-ID: <CA+CK2bA4LXSqRNDhen0GVVTz=gYwLmr8FgKCJeyG3iRpy=ULSA@mail.gmail.com>
Subject: Re: [PATCH v17 15/15] arm64: trans_pgd: remove trans_pgd_map_page()
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

On Wed, Sep 29, 2021 at 12:43 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Thu, Sep 16, 2021 at 07:13:25PM -0400, Pasha Tatashin wrote:
> > The intend of trans_pgd_map_page() was to map contiguous range of VA
> > memory to the memory that is getting relocated during kexec. However,
> > since we are now using linear map instead of contiguous range this
> > function is not needed
> >
> > Suggested-by: Pingfan Liu <kernelfans@gmail.com>
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/include/asm/trans_pgd.h |  5 +--
> >  arch/arm64/mm/trans_pgd.c          | 57 ------------------------------
> >  2 files changed, 1 insertion(+), 61 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
> > index 7b04d32b102c..033d400a4ea4 100644
> > --- a/arch/arm64/include/asm/trans_pgd.h
> > +++ b/arch/arm64/include/asm/trans_pgd.h
> > @@ -15,7 +15,7 @@
> >  /*
> >   * trans_alloc_page
> >   *   - Allocator that should return exactly one zeroed page, if this
> > - *     allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
> > + *     allocator fails, trans_pgd_create_copy() and trans_pgd_idmap_page()
> >   *     return -ENOMEM error.
> >   *
> >   * trans_alloc_arg
> > @@ -30,9 +30,6 @@ struct trans_pgd_info {
> >  int trans_pgd_create_copy(struct trans_pgd_info *info, pgd_t **trans_pgd,
> >                         unsigned long start, unsigned long end);
> >
> > -int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
> > -                    void *page, unsigned long dst_addr, pgprot_t pgprot);
>
> So this function never got used in mainline after commit 7018d467ff2d
> ("arm64: trans_pgd: hibernate: idmap the single page that holds the copy
> page routines"). I guess it's because we merged part of v10 of this
> series and in v12 you dropped the contiguous VA range in favour of a
> copy of the linear map.

This is exactly right. This function was meant for the contiguous-va
relocation version of this series.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

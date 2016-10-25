Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzB8v-000794-5H
 for kexec@lists.infradead.org; Tue, 25 Oct 2016 23:28:29 +0000
Date: Wed, 26 Oct 2016 07:28:04 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH Makedumpfile 2/4] x86_64: translate all VA to PA using
 page table values
Message-ID: <20161025232804.GB2975@x1>
References: <cover.1477327674.git.panand@redhat.com>
 <b54b1e73bc4302fa7222c44a9cf46d57aa93b8ba.1477327674.git.panand@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E7A30E@BPXM01GP.gisp.nec.co.jp>
 <f29a272d-8b82-d0d7-a2f2-c4af6474fff6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f29a272d-8b82-d0d7-a2f2-c4af6474fff6@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, "dyoung@redhat.com" <dyoung@redhat.com>

On 10/25/16 at 08:42pm, Pratyush Anand wrote:
> > > With -d 1:
> > > Trial 1: 2768.424565806 S
> > > Trial 2: 2749.622115455 S
> > > Trail 3: 2537.770359073 S
> > 
> > Could you increase the number of trials ?
> 
> OK, I can do that. Might take some time, as I will have to arrange that high
> memory machine again.
> 
> > If the average time is close to the results of Trial 1 (2768s) and 2 (2749s),
> > the regression rate is 8% and it sounds neither large nor small.
> > If the average is a level of 2500s like Trial 3, it's ideal.
> > 
> > > Signed-off-by: Pratyush Anand <panand@redhat.com>
> > > ---
> > > arch/x86_64.c  | 42 ++++++++----------------------------------
> > > makedumpfile.h |  4 ++--
> > > 2 files changed, 10 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/arch/x86_64.c b/arch/x86_64.c
> > > index a96fd8ae00a1..fe2764a8bec2 100644
> > > --- a/arch/x86_64.c
> > > +++ b/arch/x86_64.c
> > > @@ -203,6 +203,12 @@ vtop4_x86_64(unsigned long vaddr)
> > > {
> > > 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
> > > 	unsigned long pte_paddr, pte;
> > > +	unsigned long phys_base;
> > > +
> > > +	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
> > > +		phys_base = info->phys_base;
> > > +	else
> > > +		phys_base = 0;
> > > 
> > > 	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> > > 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> > > @@ -212,9 +218,9 @@ vtop4_x86_64(unsigned long vaddr)
> > > 	/*
> > > 	 * Get PGD.
> > > 	 */
> > > -	page_dir  = SYMBOL(init_level4_pgt);
> > > +	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
> > 
> > I want to confirm that this VA to PA translation is always safe,
> > otherwise we should do the condition check which was done in
> > vaddr_to_paddr_x86_64(), isn't it ?
> > 
> 
> I think this should be safe, however x86 expert can comment better. Baoquan
> any comment here?

Yes, I think this is safe. Below is the physical to virtual address
translation function in x86 64. And init_level4_pgt is a global variable
located in kernel text region. 

arch/x86/include/asm/page_64.h

static inline unsigned long __phys_addr_nodebug(unsigned long x)
{
        unsigned long y = x - __START_KERNEL_map;
 
        /* use the carry flag to determine if x was < __START_KERNEL_map */
        x = y + ((x > y) ? phys_base : (__START_KERNEL_map - PAGE_OFFSET));
 
        return x;
}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

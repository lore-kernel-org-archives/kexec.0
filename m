Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X8575-0004yS-Go
 for kexec@lists.infradead.org; Fri, 18 Jul 2014 10:10:05 +0000
Date: Fri, 18 Jul 2014 18:08:24 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140718100824.GF11399@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140714063018.GC1717@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97241BA0@BPXM01GP.gisp.nec.co.jp>
 <20140718021616.GA7279@dhcp-16-105.nay.redhat.com>
 <20140718093814.3fd2897b@hananiah.suse.cz>
 <20140718084726.GE11399@dhcp-16-105.nay.redhat.com>
 <20140718114127.129c503b@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140718114127.129c503b@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 07/18/14 at 11:41am, Petr Tesarik wrote:
> On Fri, 18 Jul 2014 16:47:26 +0800
> "bhe@redhat.com" <bhe@redhat.com> wrote:
> 
> > On 07/18/14 at 09:38am, Petr Tesarik wrote:
> > > On Fri, 18 Jul 2014 10:16:16 +0800
> > > "bhe@redhat.com" <bhe@redhat.com> wrote:
> > > 
> > Thanks, Petr. This help. 
> > 
> > > I'm afraid you misunderstand the concept. Let me explain:
> > > 
> > > page:
> > >   The basic memory management block (usually 4K).
> > > 
> > > compound page:
> > >   The kernel may group adjacent pages into a larger object, and track
> > >   page flags, refcount, etc. at one place for the whole group. This is
> > >   called compound pages.
> > > 
> > >   Compound pages may be used for different things, either kernel
> > >   internal allocations or by applications.
> > > 
> > >   Note that compound pages may or may not correspond to fewer levels of
> > >   paging in hardware. Take x86_64 as an example. You can have compound
> > >   pages with order=1 (i.e. 8K). There is nothing in the hardware to
> > >   support such page size, so the page table just contains 2 consecutive
> > >   4K pages. Only if you have a compound page with order=9 (i.e. 2M), the
> > >   kernel can use 3-level paging, creating a 2M page in hardware.
> > > 
> > > hugetlbfs:
> > >   Some compound pages are available through a special filesystem. This
> > >   filesystem is used solely by user-space applications. However, these
> > >   pages are formally owned by the kernel (after all, they belong to a
> > >   filesystem, albeit a very special one). There is nothing in the page
> > >   flags to tell that they are in fact used by user-space.
> > 
> > I do have a confusion on this. Here it means user space benefits from
> > hugetlb only through hugetlbfs. If except of that, kernel may make use
> > of hugetlb to get large memory by merging continuous pages, doesn't it?
> 
> Well, yes, it _is_ confusing:
> 
> 1. hugetlbfs makes use of compound pages, but not every compound page
>    is a hugetlbfs page, even if it is implemented with fewer levels of
>    paging in hardware.

I agree on this, it includes thp. And other kernel using from memory
allocation interface with __GFP_COMP flag.

> 
> 2. The kernel does not use hugetlbfs for its allocations. The kernel
>    does use compound pages in many places.

This confuses me. Could you please take several usage as example?
Because all metarial I can find says they are used for user space app.

> 
> 3. Pages assigned to hugetlbfs are not marked as user-space.
>    Nevertheless, users of makedumpfile expect that these pages are
>    filtered out if they say to filter out "user data".

Yes, they are not marked as user space. That's why I am wondering how
they differentiate the hugetlbfs pages for user space and for kernel
space. I can' get it from this patch. Or I misunderstood. Since in this
patch it only check free_huge_page because this is only set for
hugetlbfs by call set_compound_page_dtor(). But if hugetlbfs pages for
kernel space, what can we do? They don't set free_huge_page for
hugetlbfs when it's used for kernel space?

If kernel using of large parge doesn't set free_huge_page, I admit
current check is enough.

> 
> Support for compound pages is (relatively) easy - just check the head
> page to determine the order and then act on the group as a whole (using
> the information from the head page). But this not enough to treat
> hugetlbfs pages as "user data", so makedumpfile must have a way to tell
> a hugetlbfs compound page from other compound pages, and page flags do
> not help in that regard.
> 
> Petr T
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X82ka-0002KU-HB
 for kexec@lists.infradead.org; Fri, 18 Jul 2014 07:38:41 +0000
Date: Fri, 18 Jul 2014 09:38:14 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2] makedumpfile: Exclude unnecessary hugepages.
Message-ID: <20140718093814.3fd2897b@hananiah.suse.cz>
In-Reply-To: <20140718021616.GA7279@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9722301C@BPXM01GP.gisp.nec.co.jp>
 <20140714063018.GC1717@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97241BA0@BPXM01GP.gisp.nec.co.jp>
 <20140718021616.GA7279@dhcp-16-105.nay.redhat.com>
Mime-Version: 1.0
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
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Fri, 18 Jul 2014 10:16:16 +0800
"bhe@redhat.com" <bhe@redhat.com> wrote:

> On 07/17/14 at 06:34am, Atsushi Kumagai wrote:
> > Hello Baoquan,
> > 
> > >On 06/17/14 at 02:32am, Atsushi Kumagai wrote:
> > >> +		else if (info->dump_level & DL_EXCLUDE_USER_DATA) {
> > >Hi Atsushi,
> > >
> > >Could it be changed to checking hugepage first, then anonymous page?
> > >This can avoid involving the free_huge_page.
> > >
> > >like this:
> > >	int nr_pages;
> > >	if (page_is_hugepage(flags) {
> > >		int nr_pages = 1 << compound_order;
> > >
> > >		exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
> > >
> > >		pfn += nr_pages - 1;
> > >		mem_map += (nr_pages - 1) * SIZE(page);
> > >	} else if (isAnon(mapping)) {
> > >		int nr_pages = 1;
> > >
> > >		exclude_range(&pfn_user, pfn, pfn + nr_pages, cycle);
> > >
> > >		pfn += nr_pages - 1;
> > >		mem_map += (nr_pages - 1) * SIZE(page);
> > >	}
> > >
> > >But I may not know the meaning of free_huge_page completely. If you
> > >think introducing free_huge_page is better, I am fine too, can ACK that
> > >kernel patch to export free_huge_page you posted.
> > 
> > The assumption that all compound pages are user pages is wrong since some
> > kernel pages can be compound. For example, kmalloc_large_node() calls 
> > alloc_pages_node() with __GFP_COMP. This means we have to check compound
> > user pages without only depending on page_is_hugepage(). We can detect THPs
> > with the combination of page_is_hugepage() and isAnon(), but it can't be
> > applied to hugetlbfs pages.
> > This is why we need to export free_huge_page.
> > 
> > BTW, the v2 code can misdetect hugetlbfs due to the wrong check order, 
> > I'm going to fix it in the next version.
> 
> Yeah, I checked that and found it's related to slub implementation.
> 
> But if hugetlbfs is used by kernel space, current checking condition
> may not be enough. Anyway, expect your new post of v3.

I'm afraid you misunderstand the concept. Let me explain:

page:
  The basic memory management block (usually 4K).

compound page:
  The kernel may group adjacent pages into a larger object, and track
  page flags, refcount, etc. at one place for the whole group. This is
  called compound pages.

  Compound pages may be used for different things, either kernel
  internal allocations or by applications.

  Note that compound pages may or may not correspond to fewer levels of
  paging in hardware. Take x86_64 as an example. You can have compound
  pages with order=1 (i.e. 8K). There is nothing in the hardware to
  support such page size, so the page table just contains 2 consecutive
  4K pages. Only if you have a compound page with order=9 (i.e. 2M), the
  kernel can use 3-level paging, creating a 2M page in hardware.

hugetlbfs:
  Some compound pages are available through a special filesystem. This
  filesystem is used solely by user-space applications. However, these
  pages are formally owned by the kernel (after all, they belong to a
  filesystem, albeit a very special one). There is nothing in the page
  flags to tell that they are in fact used by user-space.

  The primary intent was to let applications use less levels of paging
  in hardware to improve performance. This mechanism requires special
  support in the application.

transparent huge pages:
  THP is a method to offer the performance benefits of hugetlbfs to
  applications that don't use the special hugetlbfs API. To do that,
  the kernel automatically merges adjacent physical pages into compound
  pages. In this case, the page flags (stored in the "head page") can
  be used to determine the use of that page.

Hope that helps,
Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

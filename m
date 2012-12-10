Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ThtLj-00055Y-0d
 for kexec@lists.infradead.org; Mon, 10 Dec 2012 02:44:09 +0000
Date: Mon, 10 Dec 2012 11:42:32 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] Add the values related to buddy system for filtering
 free pages
Message-Id: <20121210114232.625dd1acd7d0f88b58d85619@mxc.nes.nec.co.jp>
In-Reply-To: <20121207150805.GC4928@redhat.com>
References: <20121121170247.6b57465f2fc1d7f91cd1cddf@mxc.nes.nec.co.jp>
 <20121207150805.GC4928@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Vivek,

On Fri, 7 Dec 2012 10:08:05 -0500
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Wed, Nov 21, 2012 at 05:02:47PM +0900, Atsushi Kumagai wrote:
> > This patch adds the values related to buddy system to vmcoreinfo data
> > so that makedumpfile (dump filtering command) can filter out all free
> > pages with the new logic.
> > It's faster than the current logic because it can distinguish free page
> > by analyzing page structure at the same time as filtering for other
> > unnecessary pages (e.g. anonymous page).
> > OTOH, the current logic has to trace free_list to distinguish free 
> > pages while analyzing page structure to filter out other unnecessary
> > pages.
> > 
> > The new logic uses the fact that buddy page is marked by _mapcount == 
> > PAGE_BUDDY_MAPCOUNT_VALUE. The values below are required to distinguish
> > it.
> > 
> > Required values:
> >   - OFFSET(page._mapcount)
> >   - OFFSET(page.private)
> >   - SIZE(pageflags)
> >   - NUMBER(PG_slab)
> >   - NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE)
> >   
> 
> As per your explanation, you should just need to export page._mapcount
> offset and PAGE_BUDDY_MAPCOUNT_VALUE value so that you can figure out
> if a page is free or not.
> 
> Why do we need rest of the three fields.
> 
> - OFFSET(page.private)
> - SIZE(pageflags)
> - NUMBER(PG_slab)

Thanks for your comment.

SIZE(pageflags) is unnecessary as you said, but the other two are
certainly necessary.
I modified the description in v2 to make it clear, please see below:

  https://lkml.org/lkml/2012/12/9/138


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

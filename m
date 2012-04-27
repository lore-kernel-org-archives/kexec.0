Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SNlJD-0001vX-7x
 for kexec@lists.infradead.org; Fri, 27 Apr 2012 13:34:04 +0000
Date: Fri, 27 Apr 2012 09:33:58 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120427133358.GE10579@redhat.com>
References: <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
 <20120410125205.GA21801@redhat.com>
 <20120412124040.bad03498.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120412.164714.39159547.d.hatayama@jp.fujitsu.com>
 <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Fri, Apr 27, 2012 at 04:46:49PM +0900, Atsushi Kumagai wrote:
> Hello,
> 
> On Thu, 12 Apr 2012 16:47:14 +0900 (JST)
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
> [..]
> > > I said I want to avoid changing behavior based on kernel versions, 
> > > but it seems difficult as Vivek said. So, I will accept the changing
> > > if it is necessary.
> > > 
> > > Now, I will make two prototypes to consider the method to figure out
> > > free pages.
> > > 
> > >   - a prototype based on _count
> > >   - a prototype based on PG_buddy (or _mapcount)
> > >   
> > > If prototypes work fine, then we can select the method.
> > 
> > I think the first one would work well and it's more accurate in
> > meaning of free page.
> > 
> > Although this might be not problematic in practice, new method that
> > walks on page tables can lead to different result from the previous
> > one that looks up free_list: looking at __free_pages(), it first
> > decreases page->_count and then add the page to free_list, and looking
> > at __alloc_pages(), it first retrieves a page from free_list and then
> > set page->_count to 1.
> 
> I tested the prototype based on _count and the other based on _mapcount.
> So, the former didn't work as expected while the latter worked fine.
> (The former excluded some used pages as free pages.)
> 
> As a next step, I measured performance of the prototype based on _mapcount,
> please see below.
> 
> 
> Performance Comparison:
> 
>   Explanation:
>     - The new method supports 2.6.39 and later, and it needs vmlinux.
> 
>     - Now, the prototype doesn't support PG_buddy because the value of PG_buddy
>       is different depending on kernel configuration and it isn't stored into 
>       VMCOREINFO. However, I'll extend get_length_of_free_pages() for PG_buddy 
>       when the value of PG_buddy is stored into VMCOREINFO.
> 
>     - The prototype has dump_level "32" to use new method, but I don't think
>       to extend dump_level for official version.

Thanks for your work. Yes, introducing new dump_level for new filtering
method will not be appropriate. If it is found that going through struct
pages and parsing _mapcount is not too bad from performance point of view,
then makedumpfile should just switch its default on newer kernels. 

Or, I am assuming that anyway we will intorduce a new option to
makedumpfile to tell whether we want to a fixed memory usage filtering
or not (assuming there is significant performance penalty on large
machines, 1TB or more). So with that option we can do free page filtering
using struct page otherwise we can continue to go through free pages
list.

Anyway, I think it is too early to discuss various user visible options.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

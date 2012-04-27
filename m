Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SNl8Z-0000ep-Hn
 for kexec@lists.infradead.org; Fri, 27 Apr 2012 13:23:05 +0000
Date: Fri, 27 Apr 2012 08:52:14 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120427125214.GF28185@redhat.com>
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
Cc: oomichi@mxs.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org, vgoyal@redhat.com

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

Thanks for this work.  I assume this work just switches the free page
referencing and does not attempt to try and cut down on the memory usage
(I guess that would be the next step if using mapcount is acceptable)?

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
> 
>   How to measure:
>     I measured execution times with vmcore of 5GB in below cases with 
>     attached patches.
> 
>       - dump_level 16: exclude only free pages with the current method
>       - dump_level 31: exclude all excludable pages with the current method
>       - dump_level 32: exclude only free pages with the new method
>       - dump_level 47: exclude all excludable pages with the new method
> 
>   Result:
>      ------------------------------------------------------------------------
>      dump_level	     size [Bytes]    total time	   d_all_time     d_new_time	
>      ------------------------------------------------------------------------
>      	16		431864384	28.6s	     4.19s	      0s
>      	31		111808568	14.5s	      0.9s	      0s
>      	32		431864384	41.2s	     16.8s	   0.05s
>      	47		111808568	31.5s	     16.6s	   0.05s
>      ------------------------------------------------------------------------
> 
>   Discussion:
>     I think the new method can be used instead of the current method in many cases.
>     (However, the result of dump_level 31 looks too fast, I'm researching why
>     the case can execute so fast.)
> 
>     I would like to get your opinion.

I am curious.  Looking through your patches, it seems d_all_time's
increase in time should be from the new method because the if-statement is
setup to only accept the new method.  Therefore I was expecting d_new_time
for the new method when added to d_all_time for the current method would
come close to d_all_time for the new method.  IOW I would have expected
the extra 10-12 seconds from the new method to be found in d_new_time.

However, I do not see that.  d_new_time hardly increases at all.  So what
is accounting for the increase in d_all_time for the new method?

Thanks,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

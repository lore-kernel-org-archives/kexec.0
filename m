Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SSeYf-0004J7-NS
 for kexec@lists.infradead.org; Fri, 11 May 2012 01:22:17 +0000
Date: Fri, 11 May 2012 10:19:52 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-Id: <20120511101952.7530db09.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120427125214.GF28185@redhat.com>
References: <20120410.085824.193685565.d.hatayama@jp.fujitsu.com>
 <20120410125205.GA21801@redhat.com>
 <20120412124040.bad03498.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120412.164714.39159547.d.hatayama@jp.fujitsu.com>
 <20120427164649.9932a33f.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120427125214.GF28185@redhat.com>
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
To: kexec@lists.infradead.org
Cc: dzickus@redhat.com, oomichi@mxs.nes.nec.co.jp, d.hatayama@jp.fujitsu.com, vgoyal@redhat.com

Hello, 

On Fri, 27 Apr 2012 08:52:14 -0400
Don Zickus <dzickus@redhat.com> wrote:

[..]
> > I tested the prototype based on _count and the other based on _mapcount.
> > So, the former didn't work as expected while the latter worked fine.
> > (The former excluded some used pages as free pages.)
> > 
> > As a next step, I measured performance of the prototype based on _mapcount,
> > please see below.
> 
> Thanks for this work.  I assume this work just switches the free page
> referencing and does not attempt to try and cut down on the memory usage
> (I guess that would be the next step if using mapcount is acceptable)?

Thank you for your reply, Don, Vivek.

As Don said, I tried to change the method to exclude free pages and
planed to resolve the memory consumption issue after it, because
parsing free list repeatedly may cause a performance issue.

However, I'm thinking that to fix the size of memory consumption is more
important than to resolve a performance issue for large system.

So I'm afraid that I would like to change the plan as:

  1. Implement "iterating filtering processing" to fix the size of memory
     consumption. At this stage, makedumpfile will parse free list repeatedly
     even though it may cause a performance issue.
     
  2. Take care of the performance issue after the 1st step.


Thanks
Atsushi Kumagai

> 
> > 
> > 
> > Performance Comparison:
> > 
> >   Explanation:
> >     - The new method supports 2.6.39 and later, and it needs vmlinux.
> > 
> >     - Now, the prototype doesn't support PG_buddy because the value of PG_buddy
> >       is different depending on kernel configuration and it isn't stored into 
> >       VMCOREINFO. However, I'll extend get_length_of_free_pages() for PG_buddy 
> >       when the value of PG_buddy is stored into VMCOREINFO.
> > 
> >     - The prototype has dump_level "32" to use new method, but I don't think
> >       to extend dump_level for official version.
> > 
> >   How to measure:
> >     I measured execution times with vmcore of 5GB in below cases with 
> >     attached patches.
> > 
> >       - dump_level 16: exclude only free pages with the current method
> >       - dump_level 31: exclude all excludable pages with the current method
> >       - dump_level 32: exclude only free pages with the new method
> >       - dump_level 47: exclude all excludable pages with the new method
> > 
> >   Result:
> >      ------------------------------------------------------------------------
> >      dump_level	     size [Bytes]    total time	   d_all_time     d_new_time	
> >      ------------------------------------------------------------------------
> >      	16		431864384	28.6s	     4.19s	      0s
> >      	31		111808568	14.5s	      0.9s	      0s
> >      	32		431864384	41.2s	     16.8s	   0.05s
> >      	47		111808568	31.5s	     16.6s	   0.05s
> >      ------------------------------------------------------------------------
> > 
> >   Discussion:
> >     I think the new method can be used instead of the current method in many cases.
> >     (However, the result of dump_level 31 looks too fast, I'm researching why
> >     the case can execute so fast.)
> > 
> >     I would like to get your opinion.
> 
> I am curious.  Looking through your patches, it seems d_all_time's
> increase in time should be from the new method because the if-statement is
> setup to only accept the new method.  Therefore I was expecting d_new_time
> for the new method when added to d_all_time for the current method would
> come close to d_all_time for the new method.  IOW I would have expected
> the extra 10-12 seconds from the new method to be found in d_new_time.
> 
> However, I do not see that.  d_new_time hardly increases at all.  So what
> is accounting for the increase in d_all_time for the new method?
> 
> Thanks,
> Don
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

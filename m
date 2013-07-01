Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UtgiK-0001ZG-SK
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 16:12:29 +0000
Date: Mon, 1 Jul 2013 12:12:06 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: 32TB kdump
Message-ID: <20130701161206.GC9840@redhat.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com> <20130628215631.GA11017@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130628215631.GA11017@sgi.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org

On Fri, Jun 28, 2013 at 04:56:31PM -0500, Cliff Wickman wrote:

[..]
> > > page scanning  570 sec.
> > > copying data  5795 sec. (72G)
> > > (The data copy ran out of disk space at 23%, so the time and size above are
> > >  extrapolated.)
> > 
> > That's almost 110 mins. Approximately 2 hrs to dump. I think it is still
> > a lot. How many people can afford to keep a machine dumping for 2hrs. They
> > would rather bring the servies back online.
> 
> It is a long time, agreed.  But a vast improvement over the hours and
> hours (maybe 12 or more) it would have taken just to scan pages before the
> fix of ioremap() per page.

Which ioremap() fix you are referring to. I thought using mmap() was the
fix for per page ioremap() issue and that's not showing significant
improvements. Looks like you are referring to some other makeudmpfile
changes which I am not aware of.

> A 32T machine is probably a research engine rather than a server, and 2hrs
> might be pretty acceptable to track down a system bug that's blocking some
> important application.
>  
> > So more work needed in scalability area. And page scanning seems to have
> > been not too bad. Copying data has taken majority of time. Is it because
> > of slow disk.
> 
> I think compression is the bottleneck.
> 
> On an idle 2TB machine: (times in seconds)
>                                 copy time
> uncompressed, to /dev/null      61
> uncompressed, to file           336    (probably 37G, I extrapolate, disk full)
> compressed, to /dev/null        387
> compressed, to file             402    (file 3.7G)
> 
> uncompressed disk time  336-61  275
> compressed disk time    402-387  15
> compress time           387-61  326
> 

Ok, so now compression is the biggest bottleneck on large machines.

[..]
> > > - Use of crashkernel=1G,high was usually problematic.  I assume some problem
> > >   with a conflict with something else using high memory.  I always use
> > >   the form like 1G@5G, finding memory by examining /proc/iomem.
> > 
> > Hmm..., do you think you need to reserve some low mem too for swiotlb. (In
> > case you are not using iommu).
> 
> It is reserving 72M in low mem for swiotlb + 8M.  But this seems not
> enough.
> I did not realize that I could specify crashkernel=xxx,high and
> crashkernel=xxx,low together, until you mentioned it below.  This seems
> to solve my crashkernel=1G,high problem.  I need to specify
> crashkernel=128M,low on some systems or else my crash kernel panics on
> not finding enough low memory.

Is it possible to dive deeper and figure out why do you need more low
memory. We might need some fixing in upstream kernel. Otherwise how a
user would know how much low memory to reserve.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

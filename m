Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Usgf1-0000CA-6j
 for kexec@lists.infradead.org; Fri, 28 Jun 2013 21:56:56 +0000
Date: Fri, 28 Jun 2013 16:56:31 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: 32TB kdump
Message-ID: <20130628215631.GA11017@sgi.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130627211725.GM4899@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org

On Thu, Jun 27, 2013 at 05:17:25PM -0400, Vivek Goyal wrote:
> On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:
> > 
> > I have been testing recent kernel and kexec-tools for doing kdump of large
> > memories, and found good results.
> > 
> > --------------------------------
> > UV2000  memory: 32TB  crashkernel=2G@4G
> 
> > command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
> >    --map-size 4096 -x /boot/vmlinux-3.10.0-rc5-linus-cpw+ /proc/vmcore \
> >    /tmp/cpw/dumpfile
> 
> Is --cyclic mode significantly slower for above configuration? Now cyclic
> mode already uses 80% of available memory (I guess we are little
> conservative and could bump it to 90 - 95% of available memory). That
> should mean that by default cyclic mode should be as fast as non-cyclic
> mode.
> 
> Added benefit is that even if one reserves less memory, cyclic mode
> will atleast be able to save dump (at the cost of some time).

Cyclic mode is not significantly slower.  On an idle 2TB machine it can
scan pages in 60 seconds then copy in 402.  Using non-cylic the scan is
35 seconds and the copy about 395 -- but with crashkernel=512M
getmakedumpfile then runs out of memory and the crash kernel panics, so
the 30-or-so seconds saved are definitely not worth it.
I am able to dump an idle 2TB system in about 500 seconds in cyclic mode
and crashkernel=384M.
> 
> > 
> > page scanning  570 sec.
> > copying data  5795 sec. (72G)
> > (The data copy ran out of disk space at 23%, so the time and size above are
> >  extrapolated.)
> 
> That's almost 110 mins. Approximately 2 hrs to dump. I think it is still
> a lot. How many people can afford to keep a machine dumping for 2hrs. They
> would rather bring the servies back online.

It is a long time, agreed.  But a vast improvement over the hours and
hours (maybe 12 or more) it would have taken just to scan pages before the
fix of ioremap() per page.
A 32T machine is probably a research engine rather than a server, and 2hrs
might be pretty acceptable to track down a system bug that's blocking some
important application.
 
> So more work needed in scalability area. And page scanning seems to have
> been not too bad. Copying data has taken majority of time. Is it because
> of slow disk.

I think compression is the bottleneck.

On an idle 2TB machine: (times in seconds)
                                copy time
uncompressed, to /dev/null      61
uncompressed, to file           336    (probably 37G, I extrapolate, disk full)
compressed, to /dev/null        387
compressed, to file             402    (file 3.7G)

uncompressed disk time  336-61  275
compressed disk time    402-387  15
compress time           387-61  326

> BTW, in non-cyclic mode, 32TB physical memory will require 2G just for
> bitmap (2bits per 4K page).  And then you require some memory for
> other stuff (around 128MB). I am not sure how did it work for you just
> by reserving 2G of RAM.

Could it be that this bitmap is being kept only partially in memory,
with the non-current parts in a file?
 
> > 
> > --------------------------------
> > UV1000  memory: 8.85TB  crashkernel=1G@5G
> > command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
> >    --map-size 4096 -x /boot/vmlinux-3.9.6-cpw-medusa /proc/vmcore \
> >    /tmp/cpw/dumpfile
> > 
> > page scanning  175 sec.
> > copying data  2085 sec. (15G)
> > (The data copy ran out of disk space at 60%, so the time and size above are
> >  extrapolated.)
> > 
> > Notes/observations:
> > - These systems were idle, so this is the capture of basically system
> >   memory only.
> > - Both stable 3.9.6 and 3.10.0-rc5 worked.
> > - Use of crashkernel=1G,high was usually problematic.  I assume some problem
> >   with a conflict with something else using high memory.  I always use
> >   the form like 1G@5G, finding memory by examining /proc/iomem.
> 
> Hmm..., do you think you need to reserve some low mem too for swiotlb. (In
> case you are not using iommu).

It is reserving 72M in low mem for swiotlb + 8M.  But this seems not
enough.
I did not realize that I could specify crashkernel=xxx,high and
crashkernel=xxx,low together, until you mentioned it below.  This seems
to solve my crashkernel=1G,high problem.  I need to specify
crashkernel=128M,low on some systems or else my crash kernel panics on
not finding enough low memory.
 
> > - Time for copying data is dominated by data compression.  Writing 15G of
> >   compressed data to /dev/null takes about 35min.  Writing the same data
> >   but uncompressed (140G) to /dev/null takes about 6min.
> 
> Try using snappy or lzo for faster compression.

I don't have liblzo2 or snappy-c.h
I must need to install some packages on our build server.
Would you expect multiple times faster compression with those?
 
> >   So a good workaround for a very large system might be to dump uncompressed
> >   to an SSD.
> 
> Interesting.
> 
> >   The multi-threading of the crash kernel would produce a big gain.
> 
> Hatayama once was working on patches to bring up multiple cpus in second
> kernel. Not sure what happened to those patches.

I hope he pursues that. It is 'the' big performance issue remaining, I think.

 
> > - Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
> >   to 3 minutes.  It also increased data copying speed (unexpectedly) from
> >   38min. to 35min.
> 
> Hmm.., so on large memory systems, mmap() will not help a lot? In those
> systems dump times are dominidated by disk speed and compression time.
> 
> So far I was thinking that ioremap() per page was big issue and you
> also once had done the analysis that passing page list to kernel made
> things significantly faster.
> 
> So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
> it by only few minutes, it really is not significant win.
> 
> >   So I think it is worthwhile to push Hatayama's 9-patch set into the kernel.
> 
> I think his patches are in --mm tree and should show up in next kernel
> realease. But it really does not sound much in overall scheme of things.

Agreed.  Not a big speedup compared to multithreading the crash kernel.
 
> > - I applied a 5-patch set from Takao Indoh to fix reset_devices handling of
> >   PCI devices.
> >   And I applied 3 kernel hacks of my own:
> >     - making a "Crash kernel low" section in /proc/iomem
> 
> And you did it because crashkernel=2G,high crashkernel=XM,low did not
> work for you?
>
> >     - make crashkernel avoid some things in pci_swiotlb_detect_override(),
> >       pci_swiotlb_detect_4gb() and register_mem_sect_under_node()
> >     - doing a crashkernel return from cpu_up()
> >   I don't understand why these should be necessary for my kernels but are
> >   not reported as problems elsewhere. I'm still investigating and will discuss
> >   those patches separately.
> 
> Nobody might have tested it yet on such large machines and these problems
> might be present for everyone.
> 
> So would be great if you could fix these in upstream kernel.

In further testing I find that none of these kernel patches are needed if
I'm using the current kexec command and if I don't try to bring the crash
kernel up to multiuser mode.
So the current kexec command also works well for me, as well as the 3.10
kernel.

I have a small wish list for makedumpfile. Nothing major, but I'll post
those later.


Could you give me an estimate when the kexec
 (as in git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git)
and makedumpfile 
 (as in git://git.code.sf.net/p/makedumpfile/code  mmap branch)
will be released?  We would like to advise the distro's about what level
of those things we require.

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

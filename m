Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UsJZc-0003m0-Vr
 for kexec@lists.infradead.org; Thu, 27 Jun 2013 21:17:50 +0000
Date: Thu, 27 Jun 2013 17:17:25 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: 32TB kdump
Message-ID: <20130627211725.GM4899@redhat.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
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

On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:
> 
> I have been testing recent kernel and kexec-tools for doing kdump of large
> memories, and found good results.
> 
> --------------------------------
> UV2000  memory: 32TB  crashkernel=2G@4G

> command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
>    --map-size 4096 -x /boot/vmlinux-3.10.0-rc5-linus-cpw+ /proc/vmcore \
>    /tmp/cpw/dumpfile

Is --cyclic mode significantly slower for above configuration? Now cyclic
mode already uses 80% of available memory (I guess we are little
conservative and could bump it to 90 - 95% of available memory). That
should mean that by default cyclic mode should be as fast as non-cyclic
mode.

Added benefit is that even if one reserves less memory, cyclic mode
will atleast be able to save dump (at the cost of some time).

> 
> page scanning  570 sec.
> copying data  5795 sec. (72G)
> (The data copy ran out of disk space at 23%, so the time and size above are
>  extrapolated.)

That's almost 110 mins. Approximately 2 hrs to dump. I think it is still
a lot. How many people can afford to keep a machine dumping for 2hrs. They
would rather bring the servies back online.

So more work needed in scalability area. And page scanning seems to have
been not too bad. Copying data has taken majority of time. Is it because
of slow disk.

BTW, in non-cyclic mode, 32TB physical memory will require 2G just for
bitmap (2bits per 4K page).  And then you require some memory for
other stuff (around 128MB). I am not sure how did it work for you just
by reserving 2G of RAM.

> 
> --------------------------------
> UV1000  memory: 8.85TB  crashkernel=1G@5G
> command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
>    --map-size 4096 -x /boot/vmlinux-3.9.6-cpw-medusa /proc/vmcore \
>    /tmp/cpw/dumpfile
> 
> page scanning  175 sec.
> copying data  2085 sec. (15G)
> (The data copy ran out of disk space at 60%, so the time and size above are
>  extrapolated.)
> 
> Notes/observations:
> - These systems were idle, so this is the capture of basically system
>   memory only.
> - Both stable 3.9.6 and 3.10.0-rc5 worked.
> - Use of crashkernel=1G,high was usually problematic.  I assume some problem
>   with a conflict with something else using high memory.  I always use
>   the form like 1G@5G, finding memory by examining /proc/iomem.

Hmm..., do you think you need to reserve some low mem too for swiotlb. (In
case you are not using iommu).

> - Time for copying data is dominated by data compression.  Writing 15G of
>   compressed data to /dev/null takes about 35min.  Writing the same data
>   but uncompressed (140G) to /dev/null takes about 6min.

Try using snappy or lzo for faster compression.

>   So a good workaround for a very large system might be to dump uncompressed
>   to an SSD.

Interesting.

>   The multi-threading of the crash kernel would produce a big gain.

Hatayama once was working on patches to bring up multiple cpus in second
kernel. Not sure what happened to those patches.

> - Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
>   to 3 minutes.  It also increased data copying speed (unexpectedly) from
>   38min. to 35min.

Hmm.., so on large memory systems, mmap() will not help a lot? In those
systems dump times are dominidated by disk speed and compression time.

So far I was thinking that ioremap() per page was big issue and you
also once had done the analysis that passing page list to kernel made
things significantly faster.

So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
it by only few minutes, it really is not significant win.

>   So I think it is worthwhile to push Hatayama's 9-patch set into the kernel.

I think his patches are in --mm tree and should show up in next kernel
realease. But it really does not sound much in overall scheme of things.

> - I applied a 5-patch set from Takao Indoh to fix reset_devices handling of
>   PCI devices.
>   And I applied 3 kernel hacks of my own:
>     - making a "Crash kernel low" section in /proc/iomem

And you did it because crashkernel=2G,high crashkernel=XM,low did not
work for you?

>     - make crashkernel avoid some things in pci_swiotlb_detect_override(),
>       pci_swiotlb_detect_4gb() and register_mem_sect_under_node()
>     - doing a crashkernel return from cpu_up()
>   I don't understand why these should be necessary for my kernels but are
>   not reported as problems elsewhere. I'm still investigating and will discuss
>   those patches separately.

Nobody might have tested it yet on such large machines and these problems
might be present for everyone.

So would be great if you could fix these in upstream kernel.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

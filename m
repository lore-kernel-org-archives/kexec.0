Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UtSDs-0004r4-CI
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 00:44:06 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4EDB43EE0BC
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:43:47 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 41CD945DE59
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:43:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2905B45DE56
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:43:47 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0D0371DB804B
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:43:47 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id A5DF31DB8046
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:43:46 +0900 (JST)
Message-ID: <51D0D079.7010300@jp.fujitsu.com>
Date: Mon, 01 Jul 2013 09:42:33 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: 32TB kdump
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com> <20130628215631.GA11017@sgi.com>
In-Reply-To: <20130628215631.GA11017@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

(2013/06/29 6:56), Cliff Wickman wrote:
> On Thu, Jun 27, 2013 at 05:17:25PM -0400, Vivek Goyal wrote:
>> On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:
>>>
>>> I have been testing recent kernel and kexec-tools for doing kdump of large
>>> memories, and found good results.
>>>
>>> --------------------------------
>>> UV2000  memory: 32TB  crashkernel=2G@4G
>>
>>> command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
>>>     --map-size 4096 -x /boot/vmlinux-3.10.0-rc5-linus-cpw+ /proc/vmcore \
>>>     /tmp/cpw/dumpfile
>>
>> Is --cyclic mode significantly slower for above configuration? Now cyclic
>> mode already uses 80% of available memory (I guess we are little
>> conservative and could bump it to 90 - 95% of available memory). That
>> should mean that by default cyclic mode should be as fast as non-cyclic
>> mode.
>>
>> Added benefit is that even if one reserves less memory, cyclic mode
>> will atleast be able to save dump (at the cost of some time).
>
> Cyclic mode is not significantly slower.  On an idle 2TB machine it can
> scan pages in 60 seconds then copy in 402.  Using non-cylic the scan is
> 35 seconds and the copy about 395 -- but with crashkernel=512M
> getmakedumpfile then runs out of memory and the crash kernel panics, so
> the 30-or-so seconds saved are definitely not worth it.
> I am able to dump an idle 2TB system in about 500 seconds in cyclic mode
> and crashkernel=384M.
>>
>>>
>>> page scanning  570 sec.
>>> copying data  5795 sec. (72G)
>>> (The data copy ran out of disk space at 23%, so the time and size above are
>>>   extrapolated.)
>>
>> That's almost 110 mins. Approximately 2 hrs to dump. I think it is still
>> a lot. How many people can afford to keep a machine dumping for 2hrs. They
>> would rather bring the servies back online.
>
> It is a long time, agreed.  But a vast improvement over the hours and
> hours (maybe 12 or more) it would have taken just to scan pages before the
> fix of ioremap() per page.

What does this mean?

> A 32T machine is probably a research engine rather than a server, and 2hrs
> might be pretty acceptable to track down a system bug that's blocking some
> important application.
>

Yes, this is true. It's of course impossible to stop the currently running
system, but it's possible to stop if it's still in development phase for
the purpose of bug fixing.

>> So more work needed in scalability area. And page scanning seems to have
>> been not too bad. Copying data has taken majority of time. Is it because
>> of slow disk.
>
> I think compression is the bottleneck.
>
> On an idle 2TB machine: (times in seconds)
>                                  copy time
> uncompressed, to /dev/null      61
> uncompressed, to file           336    (probably 37G, I extrapolate, disk full)
> compressed, to /dev/null        387
> compressed, to file             402    (file 3.7G)
>
> uncompressed disk time  336-61  275
> compressed disk time    402-387  15
> compress time           387-61  326
>
>> BTW, in non-cyclic mode, 32TB physical memory will require 2G just for
>> bitmap (2bits per 4K page).  And then you require some memory for
>> other stuff (around 128MB). I am not sure how did it work for you just
>> by reserving 2G of RAM.
>
> Could it be that this bitmap is being kept only partially in memory,
> with the non-current parts in a file?
>

makedumpfile runs on ramdisk in kdump 2nd kernel, so although makedumpfile
writes the non-current part in a temporary file (I assume the temporary file
is not using tmpfs), it's still on memory.

>>>
>>> --------------------------------
>>> UV1000  memory: 8.85TB  crashkernel=1G@5G
>>> command line  /usr/bin/makedumpfile --non-cylic -c --message-level 23 -d 31 \
>>>     --map-size 4096 -x /boot/vmlinux-3.9.6-cpw-medusa /proc/vmcore \
>>>     /tmp/cpw/dumpfile
>>>
>>> page scanning  175 sec.
>>> copying data  2085 sec. (15G)
>>> (The data copy ran out of disk space at 60%, so the time and size above are
>>>   extrapolated.)
>>>
>>> Notes/observations:
>>> - These systems were idle, so this is the capture of basically system
>>>    memory only.
>>> - Both stable 3.9.6 and 3.10.0-rc5 worked.
>>> - Use of crashkernel=1G,high was usually problematic.  I assume some problem
>>>    with a conflict with something else using high memory.  I always use
>>>    the form like 1G@5G, finding memory by examining /proc/iomem.
>>
>> Hmm..., do you think you need to reserve some low mem too for swiotlb. (In
>> case you are not using iommu).
>
> It is reserving 72M in low mem for swiotlb + 8M.  But this seems not
> enough.
> I did not realize that I could specify crashkernel=xxx,high and
> crashkernel=xxx,low together, until you mentioned it below.  This seems
> to solve my crashkernel=1G,high problem.  I need to specify
> crashkernel=128M,low on some systems or else my crash kernel panics on
> not finding enough low memory.
>
>>> - Time for copying data is dominated by data compression.  Writing 15G of
>>>    compressed data to /dev/null takes about 35min.  Writing the same data
>>>    but uncompressed (140G) to /dev/null takes about 6min.
>>
>> Try using snappy or lzo for faster compression.
>
> I don't have liblzo2 or snappy-c.h
> I must need to install some packages on our build server.
> Would you expect multiple times faster compression with those?
>

My benchmark showed 180 ~ 200 MiB/sec for snappy while 50 ~ 70 MiB/sec for zlib
on my i7-860. So did the other Xeon processors too.

>>>    So a good workaround for a very large system might be to dump uncompressed
>>>    to an SSD.
>>
>> Interesting.
>>

Just as above, compression time is slower than SSD. Current makedumpfile uses 4KiB
block size for compression (it uses page frmae size as compression block size on
each architecture) but it's not best for compression speed. If you want to use SSD,
it's better to optimize the compression block size.

In my small benchmark, I saw over 1 GiB/sec by simply increasing block size, but
it took longer compression time and I suspect it causes reducing average I/O requests.

>>>    The multi-threading of the crash kernel would produce a big gain.
>>
>> Hatayama once was working on patches to bring up multiple cpus in second
>> kernel. Not sure what happened to those patches.
>
> I hope he pursues that. It is 'the' big performance issue remaining, I think.
>
>

Yes, there's progress. I'll post the next version soon.

>>> - Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
>>>    to 3 minutes.  It also increased data copying speed (unexpectedly) from
>>>    38min. to 35min.
>>
>> Hmm.., so on large memory systems, mmap() will not help a lot? In those
>> systems dump times are dominidated by disk speed and compression time.
>>
>> So far I was thinking that ioremap() per page was big issue and you
>> also once had done the analysis that passing page list to kernel made
>> things significantly faster.
>>
>> So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
>> it by only few minutes, it really is not significant win.
>>
>>>    So I think it is worthwhile to push Hatayama's 9-patch set into the kernel.
>>
>> I think his patches are in --mm tree and should show up in next kernel
>> realease. But it really does not sound much in overall scheme of things.
>
> Agreed.  Not a big speedup compared to multithreading the crash kernel.
>
>>> - I applied a 5-patch set from Takao Indoh to fix reset_devices handling of
>>>    PCI devices.
>>>    And I applied 3 kernel hacks of my own:
>>>      - making a "Crash kernel low" section in /proc/iomem
>>
>> And you did it because crashkernel=2G,high crashkernel=XM,low did not
>> work for you?
>>
>>>      - make crashkernel avoid some things in pci_swiotlb_detect_override(),
>>>        pci_swiotlb_detect_4gb() and register_mem_sect_under_node()
>>>      - doing a crashkernel return from cpu_up()
>>>    I don't understand why these should be necessary for my kernels but are
>>>    not reported as problems elsewhere. I'm still investigating and will discuss
>>>    those patches separately.
>>
>> Nobody might have tested it yet on such large machines and these problems
>> might be present for everyone.
>>
>> So would be great if you could fix these in upstream kernel.
>
> In further testing I find that none of these kernel patches are needed if
> I'm using the current kexec command and if I don't try to bring the crash
> kernel up to multiuser mode.
> So the current kexec command also works well for me, as well as the 3.10
> kernel.
>
> I have a small wish list for makedumpfile. Nothing major, but I'll post
> those later.
>

It's best if they are given as patch set.

>
> Could you give me an estimate when the kexec
>   (as in git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git)
> and makedumpfile
>   (as in git://git.code.sf.net/p/makedumpfile/code  mmap branch)
> will be released?  We would like to advise the distro's about what level
> of those things we require.
>
> -Cliff
>


-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

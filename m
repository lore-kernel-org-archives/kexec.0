Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UuMjr-0005Iu-J2
 for kexec@lists.infradead.org; Wed, 03 Jul 2013 13:04:54 +0000
Date: Wed, 3 Jul 2013 09:03:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: 32TB kdump
Message-ID: <20130703130324.GA1460@redhat.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com>
 <51D0D399.1070501@jp.fujitsu.com>
 <20130701160635.GB9840@redhat.com>
 <51D3D15D.5090600@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D3D15D.5090600@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

On Wed, Jul 03, 2013 at 04:23:09PM +0900, HATAYAMA Daisuke wrote:
> (2013/07/02 1:06), Vivek Goyal wrote:
> > On Mon, Jul 01, 2013 at 09:55:53AM +0900, HATAYAMA Daisuke wrote:
> >> (2013/06/28 6:17), Vivek Goyal wrote:
> >>> On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:
> >>
> >>>
> >>> Try using snappy or lzo for faster compression.
> >>>
> >>>>    So a good workaround for a very large system might be to dump uncompressed
> >>>>    to an SSD.
> >>>
> >>> Interesting.
> >>>
> >>>>    The multi-threading of the crash kernel would produce a big gain.
> >>>
> >>> Hatayama once was working on patches to bring up multiple cpus in second
> >>> kernel. Not sure what happened to those patches.
> >>>
> >>>> - Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
> >>>>    to 3 minutes.  It also increased data copying speed (unexpectedly) from
> >>>>    38min. to 35min.
> >>>
> >>> Hmm.., so on large memory systems, mmap() will not help a lot? In those
> >>> systems dump times are dominidated by disk speed and compression time.
> >>>
> >>> So far I was thinking that ioremap() per page was big issue and you
> >>> also once had done the analysis that passing page list to kernel made
> >>> things significantly faster.
> >>>
> >>> So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
> >>> it by only few minutes, it really is not significant win.
> >>>
> >>
> >> Sorry, I've explained this earlier in this ML.
> >>
> >> Some patches have been applied on makedumpfile to improve the filtering speed.
> >> Two changes that were useful for the improvement are the one implementing
> >> a 8-slot cache for physical page for the purpose of reducing the number of
> >> /proc/vmcore access for paging (just as TLB), and the one that cleanups
> >> makedumpfile's filtering path.
> >
> > So biggest performance improvement came from implementing some kind of
> > TLB cache in makedumpfile?
> >
> 
> Yes, for filtering. We need to do paging on filtering since mem_map[] is
> mapped in VMEMMAP region (of course depending on kernel configuration).
> The TLB like cache works very well. OTOH, copying pages are done in pages.
> We don't need to do paging at all.
> 
> >>
> >> Performance degradation by ioremap() is now being hided on a single cpu, but
> >> it would again occur on multiple cpus. Sorry, but I have yet to do benchmark
> >> showing the fact cleanly as numeral values.
> >
> > IIUC, are you saying that now ioremap() overhead per page is not very
> > significant on single cpu system (after above makeudmpfile changes). And
> > that's the reason using mmap() does not show a very significant
> > improvement in overall scheme of things. And these overheads will become
> > more important when multiple cpus are brought up in kdump environment.
> >
> > Please correct me if I am wrong, I just want to understand it better. So
> > most of our performance problems w.r.t to scanning got solved by
> > makeumpdfile changes and mmap() changes bring us only little bit of
> > improvements in overall scheme of things on large machines?
> >
> > Vivek
> >
> 
> Filtering performance has been improved by other makedumpfile specific changes,
> and they are as small as we can ignore, but for huge crash dump, we need to
> be concerned about the performance difference between mmap() and read() without
> I/O to actual disks.
> 
> Please see the following simple benchmark where I tried to compare mmap() and
> read() with ioremap() in multiple cpu configuration, writing I/O into /dev/null.
> I also profiled them using perf record/report to understand the current ioremap()
> overheads accurately.
> 
> >From the result, mmap() is better than read() since:
> 
>  1. In case of read (ioremap), single thread takes about 180 seconds for filtering
>     and copying 32 GiB memory. In case of mmap, about 25 seconds.
> 
>     Therefore, I guess read (ioremap) would take about 96 minutes and mmap would
>     take about 14 minutes on 1 TiB memory.
> 
>     This is significant since there's situations where we cannot reduce crash dump
>     size by filtering and we have to collect huge crash dump. For example,
> 
>     - Debugging qemu/KVM system, i.e., get host machine's crash dump and analyze
>       guest machines' image included in the host machine's crash dump. To do so,
>       we cannot filter user-space memory from the host machine's crash dump.
> 
>     - Debugging application of High Availability system such as cluster, where
>       when crash happens, active node at the time triggers kdump when the main
>       application of the HA system crashes in order to switch into inactive node
>       as soon as possible by skipping the application's shutdown. We debug
>       application's debug after retrieving the application's image as user-space
>       process dump from generated crash dump. To do so, we cannot filter user-space
>       memory from the active node's crash dump.
> 
>     - In general, how much data size is reduced by filtering depends on memory
>       situation at the time of crash. We need to be concerned about the worst case;
>       at least bad case.
> 
>   2. For scalability of multiple cpus and disks. Improvement ratio shows 3.39 for
>     mmap() and 2.70 for read() on 4 cpus. I guess part of these degradation comes
>     from TLB purge and IPI interupts to call TLB flush call back function
>     on each CPU. The number of the interrupts depends on mapping size. For mmap(),
>     it's possible to support large 1GiB pages for remap_pfn_range() and then
>     we can map a whole range of vmcore by one call of mmap().
> 
> Benchmark:
> 
> * Environment
> | System           | RX600 S6                                                        |
> | CPU              | Intel(R) Xeon(R) CPU E7- 4820  @ 2.00GHz x 4                    |
> | Memory           | 32 GiB                                                          |
> | Kernel           | 3.10.0-rc2 + mmap() patch set                                   |
> | makedumpfile (*) | devel branch of git: http://git.code.sf.net/p/makedumpfile/code |
> 
> (*) I customized the makedumpfile so that for ease of benchmark, I can
> specify for makedumpfile to use read() explicitly via -W option.
> 
> The mmap size of the version of makedumpfile is 4 MiB.
> 
> * How to measure
> ** Configuration
> - Use 4 CPUS on the kdump 2nd kernel by specifying nr_cpus=4 to the
>   kdump kernel parameter.
> - Trigger kdump by taskset -c 0 sh -c "echo c > /proc/sysrq-trigger"
>   - NOTE: System hangs at the boot of 2nd kernel if crash happens on
>     the CPU except for the CPU0. To avoid this situation, you need to
>     specify CPU0 explicitly.
> 
> ** Benchmark Script
> #+BEGIN_QUOTE
> #! /bin/sh
> 
> VMCORE="$1"
> DUMPFILE="$2"
> 
> DUMPFILEDIR="$(dirname $DUMPFILE)"
> 
> MAKEDUMPFILE=/home/hat/repos/code/makedumpfile
> PERF=/var/crash/perf
> 
> drop_cache() {
>     sync
>     echo 3 > /proc/sys/vm/drop_caches
> }
> 
> upcpu() {
>     local CPU="cpu$1"
>     echo 1 >/sys/devices/system/cpu/$CPU/online
> }
> 
> downcpu() {
>     local CPU="cpu$1"
>     echo 0 >/sys/devices/system/cpu/$CPU/online
> }
> 
> downcpu 1; downcpu 2; downcpu 3
> 
> # number of CPUs: 1
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.mmap1 $MAKEDUMPFILE -f --message-level 31 $VMCORE /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.read1 $MAKEDUMPFILE -W -f --message-level 31 $VMCORE /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> 
> # number of CPUs: 2
> upcpu 1
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.mmap2 $MAKEDUMPFILE -f --message-level 31 --split $VMCORE /dev/null /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.read2 $MAKEDUMPFILE -W -f --message-level 31 --split $VMCORE /dev/null /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> 
> # number of CPUs: 4
> upcpu 2; upcpu 3
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.mmap4 $MAKEDUMPFILE -f --message-level 31 --split $VMCORE /dev/null /dev/null /dev/null /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> drop_cache
> $PERF record -g -o $DUMPFILEDIR/perf.data.read4 $MAKEDUMPFILE -W -f --message-level 31 --split $VMCORE /dev/null /dev/null /dev/null /dev/null >>$DUMPFILEDIR/msg.txt 2>&1
> 
> exit 0
> #+END_QUOTE
> 
> * benchmark result (Copy time)
> ** mmap
> | #threads | thr 1 [s] | thr 2 [s] | thr 3 [s] | thr 4 [s] | avg [s] | per [MB/s] | ratio |
> |----------+-----------+-----------+-----------+-----------+---------+------------+-------|
> |        1 |     25.10 |         - | -         | -         |   25.10 |    1305.50 |  1.00 |
> |        2 |     11.88 |     14.25 | -         | -         |  13.065 |    2508.08 |  1.92 |
> |        4 |      5.66 |      7.92 | 7.99      | 8.06      |  7.4075 |    4423.62 |  3.39 |
> 
> ** read (ioremap)
> | #threads | thr 1 [s] | thr 2 [s] | thr 3 [s] | thr 4 [s] | avg [s] | per [MB/s] | ratio |
> |----------+-----------+-----------+-----------+-----------+---------+------------+-------|
> |        1 |    149.39 |         - | -         | -         |  149.39 |     219.35 |  1.00 |
> |        2 |     89.24 |    104.33 | -         | -         |   96.79 |     338.55 |  1.54 |
> |        4 |     41.74 |     59.59 | 59.60     | 60.03     |   55.24 |     593.19 |  2.70 |

Hi Hatayama,

Thanks for testing and providing these results. Above table gives pretty
good idea about mmap() vs read() interface performance.

So mmap() does help significantly. I did not know that makedumpfile could
handle more than 1 cpu and divide work among threads to exploit
parallelism. Good to see that in case of 4 cpus, mmap() speeds up by 
a factor of 3.39.

So looks like now on large machine dump times will be dominated by
compression time and time taken to write to disk. Cliff Wickman's numbers
seems to suggest that compression time is much more than time it takes
to write dump to disk (idle system on a 2TB machine).

I have taken following snippet from his other mail.

*****************************************************
On an idle 2TB machine: (times in seconds)
                                copy time
uncompressed, to /dev/null	61
uncompressed, to file           336    (probably 37G, I extrapolate, disk
full)
compressed, to /dev/null        387
compressed, to file             402    (file 3.7G)

uncompressed disk time  336-61  275
compressed disk time    402-387  15
compress time           387-61  326
*****************************************************

It took around 400 seconds to capture compressed dump on disk and out of
that 326 seconds were consumed by compression only. Around 80% of total
dump time in this case was attributed to compression.

So this sounds like the next big fish to go after. Using lzo and
snappy might help a bit. But I think bringing up more cpus in second
kernel should help too.

What's the status of your patches to bring up multiple cpus in kdump
kernel. Are you planning to push these upstream?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

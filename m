Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz634-0005zZ-SI
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 14:16:16 +0000
Date: Tue, 16 Jul 2013 10:15:50 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.4, 734G kdump tests
Message-ID: <20130716141550.GA3398@redhat.com>
References: <20130709162403.GA25441@sgi.com>
 <20130711130647.GA20962@redhat.com>
 <20130712161427.GA13876@sgi.com> <20130712164202.GG2272@redhat.com>
 <51E510C9.1060200@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51E510C9.1060200@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, Cliff Wickman <cpw@sgi.com>

On Tue, Jul 16, 2013 at 06:22:17PM +0900, HATAYAMA Daisuke wrote:
> (2013/07/13 1:42), Vivek Goyal wrote:
> >On Fri, Jul 12, 2013 at 11:14:27AM -0500, Cliff Wickman wrote:
> >>On Thu, Jul 11, 2013 at 09:06:47AM -0400, Vivek Goyal wrote:
> >>>On Tue, Jul 09, 2013 at 11:24:03AM -0500, Cliff Wickman wrote:
> >>>
> >>>[..]
> >>>>UV2000   memory: 734G
> >>>>makedumpfile: makedumpfile-1.5.4
> >>>>kexec:   git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >>>>booted with   crashkernel=1G,high crashkernel=192M,low
> >>>>non-cyclic mode
> >>>>
> >>>>write to       option            init&scan sec.   copy sec.  dump size
> >>>>-------------  -----------------           ----   ---------  ---------
> >>>>megaraid disk  no compression                19          91      11.7G
> >>>>megaraid disk  zlib compression              20         209       1.4G
> >>>>megaraid disk  snappy compression            20          46       2.4G
> >>>>megaraid disk  snappy compression no mmap    30          72       2.4G
> >>>>/dev/null      no compression                19          28          -
> >>>>/dev/null      zlib compression              19         206          -
> >>>>/dev/null      snappy compression            19          41          -
> >>>>
> >>>>Notes and observations
> >>>>- Snappy compression is a big win over zlib compression; over 4 times faster
> >>>>   with a cost of relatively little disk space.
> >>>
> >>>Thanks for the results Cliff. If it is not too much of trouble, can you
> >>>please also test with lzo compression on same configuration. I am
> >>>curious to know how much better snappy performs as compared to lzo.
> >>>
> >>>Thanks
> >>>Vivek
> >>
> >>Ok.  I repeated the tests and included LZO compression.
> >>
> >>UV2000   memory: 734G
> >>makedumpfile: makedumpfile-1.5.4     non-cyclic mode
> >>kexec: git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >>3.10 kernel with vmcore mmap patches
> >>booted with   crashkernel=1G,high crashkernel=192M,low
> >>
> >>write to       compression       init&scan sec.   copy sec.  dump size
> >>-------------  -----------------           ----   ---------  ---------
> >>megaraid disk  no compression                20          86      11.6G
> >>megaraid disk  zlib compression              19         209       1.4G
> >>megaraid disk  snappy compression            20          47       2.4G
> >>megaraid disk  lzo compression               19          54       2.8G
> >>
> >>/dev/null      no compression                19          28          -
> >>/dev/null      zlib compression              20         206          -
> >>/dev/null      snappy compression            19          42          -
> >>/dev/null      lzo compression               20          47          -
> >>
> >>Notes:
> >>- Snappy compression is still be fastest (and more compressed than LZO),
> >>   but LZO is close.
> >>- Compression and I/O seem pretty well overlapped, so I am not sure that
> >>   multithreading the crash kernel (to speed compression) will speed the
> >>   dump as much I was hoping, unless perhaps the I/O device is an SSD.
> >
> >Thanks Cliff. So LZO is pretty close to snappy in this case.
> >
> 
> This benchmarks lack considering randamized part ratio of data.
> On my benchmark, LZO was slower than snappy from 50% to 100% randomized.
> 
> The attached is a graph of benchmark result that compares LZO and snappy
> on a variety of ratio of randomized data. The benchmark detail is that
> 
> - block size is 4KiB
> - sample data is 4MiB
>   - so 4K blocks in total
> - x value is percentage of amount of randomized data
> - y value is performance of compression, i.e. 4MiB / (the time consumed for
>   compressing the 4MiB sample data)
> - processor is Xeon E7540
> - randomizing data is done per a single byte. The 1-byte randomized data
>   is chosen from /dev/urandom. Other part is filled with '\000'.
> 
> On this result, LZO remains 100 [MiB/sec] on data whose more than 50 percent
> is randomized, while snappy shows better performance on more randomized
> ratio.
> 
> On the worst case of this 100 [MiB/sec], 1TiB system memory needs about 3
> hours to take crash dump.
> 
> While I don't think it's typical case, it's problematic that crash dump
> requires some more hours depending on contents of memory at crash time.
> It should always complete in as stable time as possible.

As per your performance graphs, both lzo and snappy vary in performance
based on randomized data in the system. So that means total dump time will
vary based on contents in memory at crash time (until and unless there is
a fast compression algorithm which does not get impacted much due to
randomness of data). So being able to dump in constant time irresepctive
of randomness of data in  memory is probably not the goal here.

Instead being able to dump faster in most of the scenarios is the goal.
And your graph does show that snappy performs much better at higher
ranomness ratios.

So based on your graph, I agree that lzo is not a replacement for snappy
and snappy can be much faster depending on randomness of data.

Thanks
Vivek

be faster in 
> 
> -- 
> Thanks.
> HATAYAMA, Daisuke



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

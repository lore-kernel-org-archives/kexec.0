Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RRF3A-0003od-AI
 for kexec@lists.infradead.org; Fri, 18 Nov 2011 03:23:38 +0000
Date: Fri, 18 Nov 2011 12:14:58 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC] makedumpfile, crash: LZO compression support
Message-Id: <20111118121458.5c007bda.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20111117211946.3e27b840.d.hatayama@jp.fujitsu.com>
References: <20111117211946.3e27b840.d.hatayama@jp.fujitsu.com>
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
To: crash-utility@redhat.com, kexec@lists.infradead.org

Hello Hatayama-san,

Thank you for your work.

> Performance Comparison:
> 
>   Sample Data
> 
>     Ideally, I must have measured the performance for many enough
>     vmcores generated from machines that was actually running, but now
>     I don't have enough sample vmcores, I couldn't do so. So this
>     comparison doesn't answer question on I/O time improvement. This
>     is TODO for now.

I'll measure the performance for actual vmcores by makedumpfile.
Please wait for a while.

Thanks.
KUMAGAI, Atsushi

> 
>     Instead, I choosed worst and best cases regarding compression
>     ratio and speed only. Specifically, the former is /dev/urandom and
>     the latter is /dev/zero.
> 
>     I get the sample data of 10MB, 100MB and 1GB by doing like this:
> 
>       $ dd bs=4096 count=$((1024*1024*1024/4096)) if=/dev/urandom of=urandom.1GB
> 
>   How to measure
> 
>     Then I performed compression for each block, 4096 bytes, and
>     measured total compression time and output size. See attached
>     mycompress.c.
> 
>   Result
> 
>     See attached file result.txt.
> 
>   Discussion
> 
>     For both kinds of data, lzo's compression was considerably quicker
>     than zlib's. Compression ratio is about 37% for urandom data, and
>     about 8.5% for zero data. Actual situation of physical memory
>     would be in between the two cases, and so I guess average
>     compression time ratio is between 37% and 8.5%.
> 
>     Although beyond the topic of this patch set, we can estimate worst
>     compression time on more data size since compression is performed
>     block size wise and the compression time increases
>     linearly. Estimated worst time on 2TB memory is about 15 hours for
>     lzo and about 40 hours for zlib. In this case, compressed data
>     size is larger than the original, so they are really not used,
>     compression time is fully meaningless. I think compression must be
>     done in parallel, and I'll post such patch later.
> 
> Diffstat
> 
>   * makedumpfile
> 
>  diskdump_mod.h |    3 +-
>  makedumpfile.c |   98 +++++++++++++++++++++++++++++++++++++++++++++++++------
>  makedumpfile.h |   12 +++++++
>  3 files changed, 101 insertions(+), 12 deletions(-)
> 
>   * crash
> 
>  defs.h     |    1 +
>  diskdump.c |   20 +++++++++++++++++++-
>  diskdump.h |    3 ++-
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> TODO
> 
>   * evaluation including I/O time using actual vmcores
> 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

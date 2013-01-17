Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvxid-0005iL-Bz
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 22:13:56 +0000
Date: Thu, 17 Jan 2013 17:13:48 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v1 0/3] kdump, vmcore: Map vmcore memory in direct
 mapping region
Message-ID: <20130117221348.GJ2237@redhat.com>
References: <20130110115615.645.56499.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130110115615.645.56499.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Jan 10, 2013 at 08:59:34PM +0900, HATAYAMA Daisuke wrote:
> Currently, kdump reads the 1st kernel's memory, called old memory in
> the source code, using ioremap per a single page. This causes big
> performance degradation since page tables modification and tlb flush
> happen each time the single page is read.
> 
> This issue turned out from Cliff's kernel-space filtering work.
> 
> To avoid calling ioremap, we map a whole 1st kernel's memory targeted
> as vmcore regions in direct mapping table. By this we got big
> performance improvement. See the following simple benchmark.
> 
> Machine spec:
> 
> | CPU    | Intel(R) Xeon(R) CPU E7- 4820  @ 2.00GHz (4 sockets, 8 cores) (*) |
> | Memory | 32 GB                                                             |
> | Kernel | 3.7 vanilla and with this patch set                               |
> 
>  (*) only 1 cpu is used in the 2nd kenrel now.
> 
> Benchmark:
> 
> I executed the following commands on the 2nd kernel and recorded real
> time.
> 
>   $ time dd bs=$((4096 * n)) if=/proc/vmcore of=/dev/null
> 
> [3.7 vanilla]
> 
> | block size | time      | performance |
> |       [KB] |           | [MB/sec]    |
> |------------+-----------+-------------|
> |          4 | 5m 46.97s | 93.56       |
> |          8 | 4m 20.68s | 124.52      |
> |         16 | 3m 37.85s | 149.01      |
> 
> [3.7 with this patch]
> 
> | block size | time   | performance |
> |       [KB] |        |    [GB/sec] |
> |------------+--------+-------------|
> |          4 | 17.59s |        1.85 |
> |          8 | 14.73s |        2.20 |
> |         16 | 14.26s |        2.28 |
> |         32 | 13.38s |        2.43 |
> |         64 | 12.77s |        2.54 |
> |        128 | 12.41s |        2.62 |
> |        256 | 12.50s |        2.60 |
> |        512 | 12.37s |        2.62 |
> |       1024 | 12.30s |        2.65 |
> |       2048 | 12.29s |        2.64 |
> |       4096 | 12.32s |        2.63 |
> 

These are impressive improvements. I missed the discussion on mmap().
So why couldn't we provide mmap() interface for /proc/vmcore. If that
works then application can select to mmap/unmap bigger chunks of file
(instead ioremap mapping/remapping a page at a time). 

And if application controls the size of mapping, then it can vary the
size of mapping based on available amount of free memory. That way if
somebody reserves less amount of memory, we could still dump but with
some time penalty.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

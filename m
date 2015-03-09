Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YV0FB-00038r-5F
 for kexec@lists.infradead.org; Mon, 09 Mar 2015 16:09:26 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Mon, 9 Mar 2015 16:09:02 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9D1072190056
 for <kexec@lists.infradead.org>; Mon,  9 Mar 2015 16:08:50 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t29G8xru7012636
 for <kexec@lists.infradead.org>; Mon, 9 Mar 2015 16:08:59 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t29G8xY1020736
 for <kexec@lists.infradead.org>; Mon, 9 Mar 2015 10:08:59 -0600
Date: Mon, 9 Mar 2015 17:08:58 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] Handle mmaped regions in cache [more analysis]
Message-ID: <20150309170858.0e8bf357@holzheu>
In-Reply-To: <cover.1425650592.git.ptesarik@suse.cz>
References: <cover.1425650592.git.ptesarik@suse.cz>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Jan Willeke <willeke@de.ibm.com>

Hello Petr,

With your patches I now used "perf record" and "perf stat"
to check where the CPU time is consumed for -d31 and -d0.

For -d31 the read case is better and for -d0 the mmap case
is better.

  $ time ./makedumpfile  -d 31 /proc/vmcore  /dev/null -f [--non-mmap]

                    user   sys   = total
  =======================================
  mmap              0.156  0.248   0.404
  non-mmap          0.090  0.180   0.270

  $ time ./makedumpfile  -d 0 /proc/vmcore  /dev/null -f [--non-mmap]

                    user   sys   = total
  ======================================
  mmap              0.637  0.018   0.655
  non-mmap          0.275  1.153   1.428

As already said, we think the reason is that for -d0 we issue
only a small number of mmap/munmap calls because the mmap
chunks are larger than the read chunks.

For -d31 memory is fragmented and we issue lots of small
mmap/munmap calls. Because munmap (at least on s390) is a
very expensive operation and we need two calls (mmap/munmap),
the mmap mode is slower that the read mode.

I counted the mmap and read system calls with "perf stat":

                     mmap   unmap   read =    sum
  ===============================================
  mmap -d0            482     443    165     1090          
  mmap -d31         13454   13414    165    27033 
  non-mmap -d0         34       3 458917   458954 
  non-mmap -d31        34       3  74273    74310

Here the actual results I got with "perf record":

$ time ./makedumpfile  -d 31 /proc/vmcore  /dev/null -f

  Output of "perf report" for mmap case:

   /* Most time spent for unmap in kernel */
   29.75%  makedumpfile  [kernel.kallsyms]  [k] unmap_single_vma
    9.84%  makedumpfile  [kernel.kallsyms]  [k] remap_pfn_range
    8.49%  makedumpfile  [kernel.kallsyms]  [k] vm_normal_page

   /* Still some mmap overhead in makedumpfile readmem() */
   21.56%  makedumpfile  makedumpfile       [.] readmem
    8.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic

  Output of "perf report" for non-mmap case:

   /* Time spent for sys_read (that needs also two copy operations on s390 :() */
   25.32%  makedumpfile  [kernel.kallsyms]  [k] memcpy_real
   22.74%  makedumpfile  [kernel.kallsyms]  [k] __copy_to_user

   /* readmem() for read path is cheaper ? */
   13.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
    4.53%  makedumpfile  makedumpfile       [.] readmem

$ time ./makedumpfile  -d 0 /proc/vmcore  /dev/null -f

  Output of "perf report" for mmap case:

   /* Almost no kernel time because we issue very view system calls */
    0.61%  makedumpfile  [kernel.kallsyms]  [k] unmap_single_vma
    0.61%  makedumpfile  [kernel.kallsyms]  [k] sysc_do_svc

   /* Almost all time consumed in user space */
   84.64%  makedumpfile  makedumpfile       [.] readmem
    8.82%  makedumpfile  makedumpfile       [.] write_cache

  Output of "perf report" for non-mmap case:

   /* Time spent for sys_read (that needs also two copy operations on s390) */
   31.50%  makedumpfile  [kernel.kallsyms]  [k] memcpy_real
   29.33%  makedumpfile  [kernel.kallsyms]  [k] __copy_to_user

   /* Very little user space time */
    3.87%  makedumpfile  makedumpfile       [.] write_cache
    3.82%  makedumpfile  makedumpfile       [.] readmem

I hope this analysis helps more than it confuses :-)

As a conclusion, we could think of mapping larger chunks
also for the fragmented case of -d 31 to reduce the amount
of mmap/munmap calls.

Another open question was why the mmap case consumes more CPU
time in readmem() than the read case. Our theory is that the
first memory access is slower because it is not in the HW
cache. For the mmap case userspace issues the first access (copy
to makdumpfile cache) and for the read case the kernel issues
the first access (memcpy_real/copy_to_user). Therefore the
cache miss is accounted to userspace for mmap and to kernel for
read.

And last but not least, perhaps on s390 we could replace
the bounce buffer used for memcpy_real()/copy_to_user() by
some more inteligent solution.

Best Regards
Michael

On Fri, 6 Mar 2015 15:03:12 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> Because all pages must go into the cache, data is unnecessarily
> copied from mmapped regions to cache. Avoid this copying by storing
> the mmapped regions directly in the cache.
> 
> First, the cache code needs a clean up clarification of the concept,
> especially the meaning of the pending list (allocated cache entries
> whose content is not yet valid).
> 
> Second, the cache must be able to handle differently sized objects
> so that it can store individual pages as well as mmapped regions.
> 
> Last, the cache eviction code must be extended to allow either
> reusing the read buffer or unmapping the region.
> 
> Changelog:
>   v2: cache cleanup _and_ actuall mmap implementation
>   v1: only the cache cleanup
> 
> Petr Tesarik (8):
>   cache: get rid of search loop in cache_add()
>   cache: allow to return a page to the pool
>   cache: do not allocate from the pending list
>   cache: add hit/miss statistics to the final report
>   cache: allocate buffers in one big chunk
>   cache: allow arbitrary size of cache entries
>   cache: store mapped regions directly in the cache
>   cleanup: remove unused page_is_fractional
> 
>  cache.c        |  81 +++++++++++++++++----------------
>  cache.h        |  16 +++++--
>  elf_info.c     |  16 -------
>  elf_info.h     |   2 -
>  makedumpfile.c | 138 ++++++++++++++++++++++++++++++++++-----------------------
>  5 files changed, 138 insertions(+), 115 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

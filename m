Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YW5CD-0008O5-Qf
 for kexec@lists.infradead.org; Thu, 12 Mar 2015 15:38:51 +0000
Date: Thu, 12 Mar 2015 16:38:22 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v2 0/8] Handle mmaped regions in cache [more analysis]
Message-ID: <20150312163822.7df1dee6@hananiah.suse.cz>
In-Reply-To: <20150309170858.0e8bf357@holzheu>
References: <cover.1425650592.git.ptesarik@suse.cz>
 <20150309170858.0e8bf357@holzheu>
MIME-Version: 1.0
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

On Mon, 9 Mar 2015 17:08:58 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Petr,
> 
> With your patches I now used "perf record" and "perf stat"
> to check where the CPU time is consumed for -d31 and -d0.
> 
> For -d31 the read case is better and for -d0 the mmap case
> is better.
> 
>[...]
> 
> As already said, we think the reason is that for -d0 we issue
> only a small number of mmap/munmap calls because the mmap
> chunks are larger than the read chunks.

This is very likely.

> For -d31 memory is fragmented and we issue lots of small
> mmap/munmap calls. Because munmap (at least on s390) is a
> very expensive operation and we need two calls (mmap/munmap),
> the mmap mode is slower that the read mode.

Yes. And it may provide an explanation why my patch set improves the
situation. By keeping the mmapped regions in the cache, rather than
individual pages copied out of the mmap region, the cache is in fact
much larger, resulting in less mmap/munmap syscalls.

> I counted the mmap and read system calls with "perf stat":
> 
>                      mmap   unmap   read =    sum
>   ===============================================
>   mmap -d0            482     443    165     1090          
>   mmap -d31         13454   13414    165    27033 
>   non-mmap -d0         34       3 458917   458954 
>   non-mmap -d31        34       3  74273    74310

If your VM has 1.5 GiB of RAM, then the numbers for -d0 look
reasonable. For -d31, we should be able to do better than this
by allocating more cache slots and improving the algorithm.
I originally didn't deem it worth the effort, but seeing almost
30 times more mmaps than with -d0 may change my mind.

> Here the actual results I got with "perf record":
> 
> $ time ./makedumpfile  -d 31 /proc/vmcore  /dev/null -f
> 
>   Output of "perf report" for mmap case:
> 
>    /* Most time spent for unmap in kernel */
>    29.75%  makedumpfile  [kernel.kallsyms]  [k] unmap_single_vma
>     9.84%  makedumpfile  [kernel.kallsyms]  [k] remap_pfn_range
>     8.49%  makedumpfile  [kernel.kallsyms]  [k] vm_normal_page
> 
>    /* Still some mmap overhead in makedumpfile readmem() */
>    21.56%  makedumpfile  makedumpfile       [.] readmem

This number is interesting. Did you compile makedumpfile with
optimizations? If yes, then this number probably includes some
functions which were inlined.

>     8.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
> 
>   Output of "perf report" for non-mmap case:
> 
>    /* Time spent for sys_read (that needs also two copy operations on s390 :() */
>    25.32%  makedumpfile  [kernel.kallsyms]  [k] memcpy_real
>    22.74%  makedumpfile  [kernel.kallsyms]  [k] __copy_to_user
> 
>    /* readmem() for read path is cheaper ? */
>    13.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
>     4.53%  makedumpfile  makedumpfile       [.] readmem

Yes, much lower overhead of readmem is strange. For a moment I
suspected wrong accounting of the page fault handler, but then I
realized that for /proc/vmcore, all page table entries are created
with the present bit set already, so there are no page faults...

I haven't had time yet to set up a system for reproduction, but I'll
try to identify what's eating up the CPU time in readmem().

>[...]
> I hope this analysis helps more than it confuses :-)
> 
> As a conclusion, we could think of mapping larger chunks
> also for the fragmented case of -d 31 to reduce the amount
> of mmap/munmap calls.

I agree in general. Memory mapped through /proc/vmcore does not
increase run-time memory requirements, because it only adds a mapping
to the old kernel's memory. The only limiting factor is the virtual
address space. On many architectures, this is no issue at all, and we
could simply map the whole file at beginning. On some architectures,
the virtual address space is smaller than possible physical RAM, so
this approach would not work for them.

> Another open question was why the mmap case consumes more CPU
> time in readmem() than the read case. Our theory is that the
> first memory access is slower because it is not in the HW
> cache. For the mmap case userspace issues the first access (copy
> to makdumpfile cache) and for the read case the kernel issues
> the first access (memcpy_real/copy_to_user). Therefore the
> cache miss is accounted to userspace for mmap and to kernel for
> read.

I have no idea how to measure this on s390. On x86_64 I would add some
asm code to read TSC before and after the memory access instruction. I
guess there is a similar counter on s390. Suggestions?

> And last but not least, perhaps on s390 we could replace
> the bounce buffer used for memcpy_real()/copy_to_user() by
> some more inteligent solution.

Which would then improve the non-mmap times even more, right?

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

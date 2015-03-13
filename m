Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YWSK4-0002xr-Q7
 for kexec@lists.infradead.org; Fri, 13 Mar 2015 16:20:30 +0000
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 13 Mar 2015 16:20:01 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A789F17D8042
 for <kexec@lists.infradead.org>; Fri, 13 Mar 2015 16:20:22 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2DGJxeh196978
 for <kexec@lists.infradead.org>; Fri, 13 Mar 2015 16:19:59 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2DGJxYE029273
 for <kexec@lists.infradead.org>; Fri, 13 Mar 2015 10:19:59 -0600
Date: Fri, 13 Mar 2015 17:19:57 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/8] Handle mmaped regions in cache [more analysis]
Message-ID: <20150313171957.208aab9a@holzheu>
In-Reply-To: <20150312163822.7df1dee6@hananiah.suse.cz>
References: <cover.1425650592.git.ptesarik@suse.cz>
 <20150309170858.0e8bf357@holzheu>
 <20150312163822.7df1dee6@hananiah.suse.cz>
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
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec mailing list <kexec@lists.infradead.org>, Jan Willeke <willeke@de.ibm.com>

On Thu, 12 Mar 2015 16:38:22 +0100
Petr Tesarik <ptesarik@suse.cz> wrote:

> On Mon, 9 Mar 2015 17:08:58 +0100
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

[snip]

> > I counted the mmap and read system calls with "perf stat":
> > 
> >                      mmap   unmap   read =    sum
> >   ===============================================
> >   mmap -d0            482     443    165     1090          
> >   mmap -d31         13454   13414    165    27033 
> >   non-mmap -d0         34       3 458917   458954 
> >   non-mmap -d31        34       3  74273    74310
> 
> If your VM has 1.5 GiB of RAM, then the numbers for -d0 look
> reasonable. 

I have 1792 MiB RAM.

> For -d31, we should be able to do better than this
> by allocating more cache slots and improving the algorithm.
> I originally didn't deem it worth the effort, but seeing almost
> 30 times more mmaps than with -d0 may change my mind.

ok.

> 
> > Here the actual results I got with "perf record":
> > 
> > $ time ./makedumpfile  -d 31 /proc/vmcore  /dev/null -f
> > 
> >   Output of "perf report" for mmap case:
> > 
> >    /* Most time spent for unmap in kernel */
> >    29.75%  makedumpfile  [kernel.kallsyms]  [k] unmap_single_vma
> >     9.84%  makedumpfile  [kernel.kallsyms]  [k] remap_pfn_range
> >     8.49%  makedumpfile  [kernel.kallsyms]  [k] vm_normal_page
> > 
> >    /* Still some mmap overhead in makedumpfile readmem() */
> >    21.56%  makedumpfile  makedumpfile       [.] readmem
> 
> This number is interesting. Did you compile makedumpfile with
> optimizations? If yes, then this number probably includes some
> functions which were inlined.

Yes, I used the default Makefile (-O2) so most functions are inlined.

With -O0 I get the following:

 15.35%  makedumpfile  libc-2.15.so       [.] memcpy
  2.14%  makedumpfile  makedumpfile       [.] __exclude_unnecessary_pages
  1.82%  makedumpfile  makedumpfile       [.] test_bit
  1.82%  makedumpfile  makedumpfile       [.] set_bitmap_cyclic
  1.32%  makedumpfile  makedumpfile       [.] clear_bit_on_2nd_bitmap
  1.32%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
  1.01%  makedumpfile  makedumpfile       [.] is_on
  0.88%  makedumpfile  makedumpfile       [.] paddr_to_offset
  0.75%  makedumpfile  makedumpfile       [.] is_dumpable_cyclic
  0.69%  makedumpfile  makedumpfile       [.] exclude_range
  0.63%  makedumpfile  makedumpfile       [.] clear_bit_on_2nd_bitmap_for_kernel
  0.63%  makedumpfile  [vdso]             [.] __kernel_gettimeofday
  0.57%  makedumpfile  makedumpfile       [.] print_progress
  0.50%  makedumpfile  makedumpfile       [.] cache_search

> >     8.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
> > 
> >   Output of "perf report" for non-mmap case:
> > 
> >    /* Time spent for sys_read (that needs also two copy operations on s390 :() */
> >    25.32%  makedumpfile  [kernel.kallsyms]  [k] memcpy_real
> >    22.74%  makedumpfile  [kernel.kallsyms]  [k] __copy_to_user
> > 
> >    /* readmem() for read path is cheaper ? */
> >    13.49%  makedumpfile  makedumpfile       [.] write_kdump_pages_cyclic
> >     4.53%  makedumpfile  makedumpfile       [.] readmem
> 
> Yes, much lower overhead of readmem is strange. For a moment I
> suspected wrong accounting of the page fault handler, but then I
> realized that for /proc/vmcore, all page table entries are created
> with the present bit set already, so there are no page faults...

Right, as said below, perhaps it is the HW caching issue.
 
> I haven't had time yet to set up a system for reproduction, but I'll
> try to identify what's eating up the CPU time in readmem().
> 
> >[...]
> > I hope this analysis helps more than it confuses :-)
> > 
> > As a conclusion, we could think of mapping larger chunks
> > also for the fragmented case of -d 31 to reduce the amount
> > of mmap/munmap calls.
> 
> I agree in general. Memory mapped through /proc/vmcore does not
> increase run-time memory requirements, because it only adds a mapping
> to the old kernel's memory.

At least you need the page table memory for the /proc/vmcore
mapping, right?

> The only limiting factor is the virtual
> address space. On many architectures, this is no issue at all, and we
> could simply map the whole file at beginning. On some architectures,
> the virtual address space is smaller than possible physical RAM, so
> this approach would not work for them.
> 
> > Another open question was why the mmap case consumes more CPU
> > time in readmem() than the read case. Our theory is that the
> > first memory access is slower because it is not in the HW
> > cache. For the mmap case userspace issues the first access (copy
> > to makdumpfile cache) and for the read case the kernel issues
> > the first access (memcpy_real/copy_to_user). Therefore the
> > cache miss is accounted to userspace for mmap and to kernel for
> > read.
> 
> I have no idea how to measure this on s390. On x86_64 I would add some
> asm code to read TSC before and after the memory access instruction. I
> guess there is a similar counter on s390. Suggestions?

On s390 under LPAR we have hardware counters for cache misses:

# perf stat -e cpum_cf/L1D_PENALTY_CYCLES/,cpum_cf/PROBLEM_STATE_L1D_PENALTY_CYCLES/ ./makedumpfile -d31 /proc/vmcore /dev/null -f 

 Performance counter stats for './makedumpfile -d31 /proc/vmcore /dev/null -f':
        1180577929      L1D_PENALTY_CYCLES                                          
        1166005960      PROBLEM_STATE_L1D_PENALTY_CYCLES                                   

# perf stat -e cpum_cf/L1D_PENALTY_CYCLES/,cpum_cf/PROBLEM_STATE_L1D_PENALTY_CYCLES/ ./makedumpfile -d31 /proc/vmcore /dev/null -f  --non-mmap

 Performance counter stats for './makedumpfile -d31 /proc/vmcore /dev/null -f --non-mmap':

        1691463111      L1D_PENALTY_CYCLES                                          
         151987617      PROBLEM_STATE_L1D_PENALTY_CYCLES                                   

AFAIK:

- L1D_PENALTY_CYCLES: Cycles wasted due to L1 cache misses (kernel + userspace)
- PROBLEM_STATE_L1D_PENALTY_CYCLES: Cycles wasted due to L1 cache misses (userspace only)

So if I got it right, we see that for the mmap() case the cache
misses are almost all in userspace and for the read() case they
are in kernel.

Interestingly on that machine (4 GiB, LPAR and newer model) for
mmap() was faster also for -d 31:

$ time ./makedumpfile /proc/vmcore -d 31 /dev/null -f 
real    0m0.125s
user    0m0.120s
sys     0m0.004s

$ time ./makedumpfile /proc/vmcore -d 31 /dev/null -f --non-mmap
real    0m0.238s
user    0m0.065s
sys     0m0.171

...

> 
> > And last but not least, perhaps on s390 we could replace
> > the bounce buffer used for memcpy_real()/copy_to_user() by
> > some more inteligent solution.
> 
> Which would then improve the non-mmap times even more, right?

Correct.

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

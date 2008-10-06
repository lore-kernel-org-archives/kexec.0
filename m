Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KmrjP-00027V-I6
	for kexec@lists.infradead.org; Mon, 06 Oct 2008 15:10:44 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m96FAgaQ014402
	for <kexec@lists.infradead.org>; Mon, 6 Oct 2008 11:10:42 -0400
Date: Mon, 6 Oct 2008 11:10:39 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2100183.613951223305838657.JavaMail.root@zmail02.collab.prod.int.phx2.redhat.com>
In-Reply-To: <28113A0489833849A1CF9EC16F42154346498C2A63@GVW1097EXB.americas.hpqcorp.net>
Subject: Re: [Crash-utility] "cannot access vmalloc'd module memory" when
	loading kdump'ed vmcore in crash
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>


----- "Kevin Worth" <kevin.worth@hp.com> wrote:

OK, let's skip the user-space angle for now, because I keep
forgetting that you are running with /dev/mem as the memory
source.  And there is an inconsistency with your debug output
that I cannot explain.

As I mentioned before, the /dev/mem driver has this immediate 
restriction in "drivers/char/mem.c":

  static ssize_t read_mem(struct file * file, char __user * buf,
                          size_t count, loff_t *ppos)
  {
          unsigned long p = *ppos;
          ssize_t read, sz;
          char *ptr;
  
          if (!valid_phys_addr_range(p, count))
                  return -EFAULT;
          ...
  
where for x86, it looks like this:
  
  static inline int valid_phys_addr_range(unsigned long addr, size_t count)
  {
          if (addr + count > __pa(high_memory))
                  return 0;
  
          return 1;
  }

That restricts is from reading "highmem", which is the extent
of physical memory that can be unity-mapped, which means that
the kernel can directly access it by simply adding the PAGE_OFFSET 
value to the physical address.  In your case, your PAGE_OFFSET is 
0x40000000.  With your 1G/3G split, you've got 3GB of kernel virtual 
address space that you can directly access, minus 128MB at the top that
is used for the vmalloc() address range.  (3GB - 128MB) is 0xb8000000.
Therefore, your "high_memory" maximum unity-mapped kernel virtual 
address is (0xb8000000 + PAGE_OFFSET), or in your case is 0xf8000000,
your high_memory value is 0xf8000000.

In any case, on your live system, whenever a crash utility readmem()
is done that accesses a physical address beyond 0xb8000000, it *should* 
get back the EFAULT above and fail, and therefore the crash command
making the readmem() fails.

Accordingly, when you did this on your live system:

> crash> vm -p
> PID: 32227  TASK: 47bc8030  CPU: 0   COMMAND: "crash"
>    MM       PGD      RSS    TOTAL_VM
> f7e67040  5fddfe00  63336k   67412k
>   VMA       START      END    FLAGS  FILE
> f3ed61d4   8048000   83e5000   1875  /root/crash
> VIRTUAL   PHYSICAL
> vm: read error: physical address: 10b60b000  type: "page table"

It ended up translating the first user virtual address (8048000),
requiring a page-table translation, and ended up trying to access
a page table page at physical address 0x10b60b000, which /dev/mem
did not allow, because you got a "read error".

However -- and this is what I cannot explain -- the above can also
happen on a live system when accessing vmalloc() kernel virtual space 
as well *if* any PTE or page table read to make the translation, or 
*if* the ending physical page itself, are beyond the /dev/mem restriction
(again, which should be 0xb8000000 in your case).  

So when you did this on your live system, you referenced the vmalloc
address of your custom module at address 0xf9088280, and successfully
read and displayed its contents:
 
> 
> crash> p modules
> modules = $2 = {
>   next = 0xf9088284,
>   prev = 0xf8842104
> }
> crash> module 0xf9088280
> struct module {
>   state = MODULE_STATE_LIVE,
>   list = {
>     next = 0xf8ff9d84,
>     prev = 0x403c63a4
>   },
>   name = "custom_lkm\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00
> 0\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\00
> 0\000\000\000\000\000\000\000\000\000\000\000\000\000",
>   mkobj = {
>     kobj = {
>       k_name = 0xf90882cc "custom_lkm",
>       name = "custom_lkm\000\000\000\000\000\000\000\000",
>       kref = {
>         refcount = {
>           counter = 3
>         }
>       },
>       entry = {
>         next = 0x403c6068,
>         prev = 0xf8ff9de4
>       },
> ...
> 

But when you did vtop of 0xf9088280, it ended up translating
to 119b98000, which is well beyond 4GB (never mind 0xb8000000), so
/dev/mem should not have been able to read it:

> 
> crash> vtop 0xf9088280
> VIRTUAL   PHYSICAL
> f9088280  119b98280
> 
> PAGE DIRECTORY: 4044b000
>   PGD: 4044b018 => 6001
>   PMD:     6e40 => 1d515067
>   PTE: 1d515440 => 119b98163
>  PAGE: 119b98000
> 
>    PTE     PHYSICAL   FLAGS
> 119b98163  119b98000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)
> 

By any chance has the /dev/mem driver been modified on your kernel?

In any case, I can't explain why you are apprently able to access 
physical addresses beyond your "high_memory"?  an. 

Anyway, the ext3 translation is useless without the accompanying "vtop":

> 
> crash> mod | grep ext3
> f88c8000  ext3             132616  (not loaded)  [CONFIG_KALLSYMS]
> 
> ... [ snip ] ...
> 
> (Realized afterward that I forgot to vtop ext3. Let me know if it's needed and I can repeat this procedure)
> 

And the "bash" vm output only makes sense with respect to
its output on the live system:

> >From dump file:
> 
> crash> vm
> PID: 4323   TASK: 47be0a90  CPU: 0   COMMAND: "bash"
>    MM       PGD      RSS    TOTAL_VM
> 5d683580  5d500dc0  2616k    3968k
>   VMA       START      END    FLAGS  FILE
> 5fc2aac4   8048000   80ee000   1875  /bin/bash
> 5fe5f0cc   80ee000   80f3000 101877  /bin/bash
> ...
> 
> 
> crash> vm -p
> PID: 4323   TASK: 47be0a90  CPU: 0   COMMAND: "bash"
>    MM       PGD      RSS    TOTAL_VM
> 5d683580  5d500dc0  2616k    3968k
>   VMA       START      END    FLAGS  FILE
> 5fc2aac4   8048000   80ee000   1875  /bin/bash
> VIRTUAL   PHYSICAL
> 8048000   FILE: /bin/bash  OFFSET: 0
> 8049000   FILE: /bin/bash  OFFSET: 1000
> 804a000   FILE: /bin/bash  OFFSET: 2000
> ...no errors, lots of output
> 

But getting back to vmalloc'd module space, your access of the module
at vmalloc-address-f9088280/physical-address-119b98000 showed that 
it's getting back a page of zeroes, while accessing the same physical
address (0x119b98000) the you successfully read (but how?) on the live
system:

> 
> crash> modules
> modules = $2 = {
>   next = 0xf9088284,
>   prev = 0xf8842104
> }
> 
> crash> module 0xf9088280
> struct module {
>   state = MODULE_STATE_LIVE,
>   list = {
>     next = 0x0,
>     prev = 0x0
>   },
>   name = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
> 00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
> 00\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
> 00\000",
>   mkobj = {
>     kobj = {
>       k_name = 0x0,
>       name = "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\0
> 00\000\000",
>       kref = {
>         refcount = {
>           counter = 0
>         }
>       },
>       entry = {
>         next = 0x0,
>         prev = 0x0
> ...
> 
> crash> vtop 0xf9088280
> VIRTUAL   PHYSICAL
> f9088280  119b98280
> 
> PAGE DIRECTORY: 4044b000
>   PGD: 4044b018 => 6001
>   PMD:     6e40 => 1d515067
>   PTE: 1d515440 => 119b98163
>  PAGE: 119b98000
> 
>    PTE     PHYSICAL   FLAGS
> 119b98163  119b98000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)
> 
>   PAGE     PHYSICAL   MAPPING    INDEX CNT FLAGS
> 47337300  119b98000         0         0  1 80000000

And so even though I'd like to point out that analogous readmem()
on the dumpfile reads the same physical location -- and seems to
just return zeroes -- is not enough for me to simply state that
it's a problem with kexec/kdump.
 
Because, again, I cannot explain how you are able to access 
physical address 0x119b98000 from /dev/mem on your live 
system?

Can you check whether your kernel source has modified
the read_mem() or valid_phys_addr_range() functions?
If they unchanged from what I showed above (from 2.6.20),
then I'm stumped, because it makes no sense to me how you
can read from those physical addresses on your live system.

For verification, if you do this:

  crash> p high_memory

it should show 0xf8000000.  If you then do a vtop of 0xf8000000,
it will simply end up stripping off the PAGE_OFFSET of 0x40000000, 
resulting in the maximum-accessible physical address of 0xb8000000.
And if you can do this:

  crash> rd -p 0xb8000000

it should fail -- as should any address equal to or above it.
But your output above that translates the module vmalloc
addresses seemingly reads physical addresses well beyond the
4GB (0x100000000).  And that's what I cannot begin to explain.

So I'm running out of ideas here...

One thing I can suggest is to rebuild your kexec-tools package
that you're using, and correct the PAGE_OFFSET value to equal
your system's.  The version of "kexec/arch/i386/crashdump-x86.h"
that we (Red Hat) are using looks like this: 
  
  #ifndef CRASHDUMP_X86_H
  #define CRASHDUMP_X86_H
  
  struct kexec_info;
  int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
                                  unsigned long max_addr, unsigned long min_base);
  
  #define PAGE_OFFSET     0xc0000000
  #define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)
  
  #define __VMALLOC_RESERVE       (128 << 20)
  #define MAXMEM                  (-PAGE_OFFSET-__VMALLOC_RESERVE)
  
  #define CRASH_MAX_MEMMAP_NR     (KEXEC_MAX_SEGMENTS + 1)
  #define CRASH_MAX_MEMORY_RANGES (MAX_MEMORY_RANGES + 2)
  
  /* Backup Region, First 640K of System RAM. */
  #define BACKUP_SRC_START        0x00000000
  #define BACKUP_SRC_END          0x0009ffff
  #define BACKUP_SRC_SIZE (BACKUP_SRC_END - BACKUP_SRC_START + 1)
  
  #endif /* CRASHDUMP_X86_H */
  
Try rebuilding your package with PAGE_OFFSET defined as 0x40000000,
and then see what happens.
  
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

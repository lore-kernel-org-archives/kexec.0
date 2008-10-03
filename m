Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Klmon-0003Gz-Ne
	for kexec@lists.infradead.org; Fri, 03 Oct 2008 15:43:50 +0000
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id m93FhmOd000804
	for <kexec@lists.infradead.org>; Fri, 3 Oct 2008 11:43:48 -0400
Message-ID: <48E63DB1.7090609@redhat.com>
Date: Fri, 03 Oct 2008 11:43:45 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Crash-utility] "cannot access vmalloc'd module memory" when
	loading kdump'ed vmcore in crash
References: <28113A0489833849A1CF9EC16F4215434376E9C97F@GVW1097EXB.americas.hpqcorp.net>	<48E3D2EB.4030301@redhat.com>	<28113A0489833849A1CF9EC16F4215434376E9CC1A@GVW1097EXB.americas.hpqcorp.net>	<48E4DF65.30009@redhat.com>
	<28113A0489833849A1CF9EC16F4215434376E9D234@GVW1097EXB.americas.hpqcorp.net>
In-Reply-To: <28113A0489833849A1CF9EC16F4215434376E9D234@GVW1097EXB.americas.hpqcorp.net>
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
	maintenance and development" <crash-utility@redhat.com>, kexec@lists.infradead.org


NOTE: I've restored the kexec list to this discussion because
this 1G/3G issue does have ramifications w/respect to kexec-tools.
I'm first going to ramble on about crash utility debugging for a
bit here, but for the kexec/kdump masters in the audience, please
at least take a look at the end of this message (do a "find in this
message" for "KEXEC-KDUMP") where I discuss the kexec-tools
hardwiring of the x86 PAGE_OFFSET to c000000, and whether it
could screw up the dumpfile contents for Kevin's 1G/3G split
where his PAGE_OFFSET is 40000000.

First, the crash discussion...

Worth, Kevin wrote:
> Yep, I can run mod commands on a live system just fine.
> 
> Looks like "next" doesn't point to fffffffc...
> 

No, but it's 0x0, and therefore the "next" module in the
list gets calculated as 0 - offset-of-list-member, or
fffffffc.  And "MODULE_STATE_LIVE" is being shown by dumb
luck because its enumerator value is 0:

> crash> module f9088280
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
...
>
> ...and all the rest of the struct is zeros too...

Right, so we know bogus data is being read from the dumpfile.  The question is:

(1) whether the virtual-to-physical address translation is
     failing somehow, or
(2) the dumpfile is screwed up.

> Does the following mean that user virtual address translations are failing too?
> 
> crash> set
>     PID: 4304
> COMMAND: "bash"
>    TASK: 5d7e9030  [THREAD_INFO: f4b70000]
>     CPU: 0
>   STATE: TASK_RUNNING (SYSRQ)
> crash> vm
> PID: 4304   TASK: 5d7e9030  CPU: 0   COMMAND: "bash"
>    MM       PGD      RSS    TOTAL_VM
> f7e7f040  5d5002c0  2616k    3972k
>   VMA       START      END    FLAGS  FILE
> 5fe454ec   8048000   80ee000   1875  /bin/bash
> 5fe45e34   80ee000   80f3000 101877  /bin/bash
> ...
> 
> crash> rd 8048000
> rd: invalid kernel virtual address: 8048000  type: "32-bit KVADDR"
> crash> rd -u 8048000
> rd: invalid user virtual address: 8048000  type: "32-bit UVADDR"
> crash> rd 80ee000
> rd: invalid kernel virtual address: 80ee000  type: "32-bit KVADDR"
> crash> rd -u 80ee000
> rd: invalid user virtual address: 80ee000  type: "32-bit UVADDR"
>

The fact that crash initially presumes that 8048000 and 80ee000 are
kernel virtual addresses can be explained by this part of "help -v"
debug output:

flags: 515a
  (NODES_ONLINE|ZONES|PERCPU_KMALLOC_V2|COMMON_VADDR|KMEM_CACHE_INIT|FLATMEM|PERCPU_KMALLOC_V2_NODES)

The "COMMON_VADDR" flag should *only* be set in the case of
the Red Hat hugemem 4G/4G split kernel.  However, I believe that
crash should be able to continue even if the bit is set, as is
the case when you run live.  It is a crash issue having to
do with your 4000000 PAGE_OFFSET, but I think it's benign,
especially if user virtual address accesses run OK on your
live system.

That's one thing that needs verification.  The "invalid user
virtual address" messages above that you get *even* when you
use "-u" would typically be generated as a result of the user
virtual-to-physical address translation. However, they also
could be generated if the virtual page being accessed has been
swapped out.

A better test would be translate all virtual address in the
user address space in one fell swoop with "vm -p".  It's
a verbose command, but for each user virtual page in the
current context, it will translate it to:

(1) the current physical address location, or
(2) if it's not in memory, but is backed by a file, it will show
     what file it comes from, or
(3) if it's been swapped out, what swapfile location is has been
     swapped out to, or
(4) if it's an anonymous page (with no file backing) that hasn't
     been touched yet, it will show "(not mapped)"

Here's a truncated example:

   PID: 19839  TASK: f7b03000  CPU: 1   COMMAND: "bash"
      MM       PGD      RSS    TOTAL_VM
   f6dc5740  f745c9c0  1392k    4532k
     VMA       START      END    FLAGS  FILE
   f69019bc    6fa000    703000     75  /lib/libnss_files-2.5.so
   VIRTUAL   PHYSICAL
   6fa000    12fdba000
   6fb000    12fdbb000
   6fc000    FILE: /lib/libnss_files-2.5.so  OFFSET: 2000
   6fd000    FILE: /lib/libnss_files-2.5.so  OFFSET: 3000
   6fe000    12f660000
   6ff000    12f2cf000
   700000    FILE: /lib/libnss_files-2.5.so  OFFSET: 6000
   701000    FILE: /lib/libnss_files-2.5.so  OFFSET: 7000
   702000    12fc6f000
     VMA       START      END    FLAGS  FILE
   f69013e4    703000    704000 100071  /lib/libnss_files-2.5.so
   VIRTUAL   PHYSICAL
   703000     54791000
     VMA       START      END    FLAGS  FILE
   f6901d84    704000    705000 100073  /lib/libnss_files-2.5.so
   VIRTUAL   PHYSICAL
   704000    12450d000
     VMA       START      END    FLAGS  FILE
   f6901284    a7c000    a96000    875  /lib/ld-2.5.so
   VIRTUAL   PHYSICAL
   a7c000     6ea28000
   a7d000    101f62000
   a7e000     6e6f3000
   a7f000     6e07e000
   a80000     6e084000
   a81000    114c8e000
   ...

Run the command above on a "bash" context on *both* the live
system and the dumpfile -- they should behave in a similar manner,
but I'm guessing you may get some bizarre errors when you
run it on the dumpfile.

Getting back to the base problem with the bogus module read,
here'a suggestion for debugging this.  It requires that you
run the live system, gather some basic data with the crash
utility, and then enter "alt-sysrq-c".  What we want to see
is a virtual-to-physical translation of the first module in
the module list on the live system.  Then crash the system.
Then we want to do the same thing on the subsequent vmcore
to see if the same physical address references are made during
the translation.

So for example, on my live system, the "/dev/crash" kernel
module is the last module entered, and therefore is pointed
to by the base kernel's "modules" list_head:

   crash> p modules
   modules = $2 = {
     next = 0xf8bd0904,
     prev = 0xf882b104
   }

Subtract 4 from the "next" pointer, and display the module:

   crash> module 0xf8bd0900
   struct module {
     state = MODULE_STATE_LIVE,
     list = {
       next = 0xf8caf984,
       prev = 0xc06787b0
     },
     name =    "crash",
     mkobj = {
       kobj = {
         k_name = 0xf8bd094c "crash",
         name = "crash",
         kref = {
           refcount = {
             counter = 2
           }
         },
     ...

Then translate it:

   crash> vtop 0xf8bd0900
   VIRTUAL   PHYSICAL
   f8bd0900  48ba1900

   PAGE DIRECTORY: c0724000
     PGD: c0724018 => 4001
     PMD:     4e28 => 37ae067
     PTE:  37aee80 => 48ba1163
    PAGE: 48ba1000

     PTE     PHYSICAL  FLAGS
   48ba1163  48ba1000  (PRESENT|RW|ACCESSED|DIRTY|GLOBAL)

     PAGE     PHYSICAL   MAPPING    INDEX CNT FLAGS
   c1917420   48ba1000         0    785045  1 c0000000
   crash>

Do the same type of thing on your live system (where you'll
have a different module), and save the output in a file.

Then immediately enter "alt-sysrq-c".

With the resultant dumpfile, perform the same "p modules",
"module <next-address-4>", and "vtop <next-address-4> steps
as done above.  The output *should* be identical, although
we're primarily interested in the vtop output given that
the "module <next-address-4>" will probably show garbage.

(BTW, this presumes that the first module in the kernel list
will still return bogus data like your current dumpfile.  That
may not be the case, and if so, we'll need to do something
similar but different. For example, on the live system, capture
the address of the "ext3" module, vtop it, crash the system,
and then do the same thing in the dumpfile.  You might want to
do that anyway, just in case the default behavior is different.
Then again, maybe it will work both live and in the dumpfile
for the ext3 module address, in which case we'll need to go in a
different debug-direction...)

Show the outputs of the live system and the subsequent dumpfile.
If they both end up resolving to the same physical address,
then there's an issue with the dumpfile.

KEXEC-KDUMP:

I talked to Vivek Goyal, who originally wrote the kexec-tools
facility, and he pointed me to this in the kexec-tools package's
"kexec/arch/i386/crashdump-x86.h" file:

   #define PAGE_OFFSET     0xc0000000
   #define __pa(x)         ((unsigned long)(x)-PAGE_OFFSET)

   #define __VMALLOC_RESERVE       (128 << 20)
   #define MAXMEM                  (-PAGE_OFFSET-__VMALLOC_RESERVE)

where for x86, it hard-wires the x86 PAGE_OFFSET to c0000000,
and will certainly result in a bogus MAXMEM given that your
PAGE_OFFSET is 40000000.  I don't know if that is related to
the problem, but if you do a "readelf -a" of your vmcore file,
you'll see some funky virtual address values for each PT_LOAD
segment.  They were dumped in the crash.log you sent me.  Note
that the virtual address regions (p_vaddr) are c0000000,
c0100000, c5000000, ffffffffffffffff and ffffffffffffffff,
all of which are incorrect or nonsensical w/respect to your
1G/3G split:

Elf64_Phdr:
                  p_type: 1 (PT_LOAD)
                p_offset: 728 (2d8)
                 p_vaddr: c0000000
                 p_paddr: 0
                p_filesz: 655360 (a0000)
                 p_memsz: 655360 (a0000)
                 p_flags: 7 (PF_X|PF_W|PF_R)
                 p_align: 0
Elf64_Phdr:
                  p_type: 1 (PT_LOAD)
                p_offset: 656088 (a02d8)
                 p_vaddr: c0100000
                 p_paddr: 100000
                p_filesz: 15728640 (f00000)
                 p_memsz: 15728640 (f00000)
                 p_flags: 7 (PF_X|PF_W|PF_R)
                 p_align: 0
Elf64_Phdr:
                  p_type: 1 (PT_LOAD)
                p_offset: 16384728 (fa02d8)
                 p_vaddr: c5000000
                 p_paddr: 5000000
                p_filesz: 855638016 (33000000)
                 p_memsz: 855638016 (33000000)
                 p_flags: 7 (PF_X|PF_W|PF_R)
                 p_align: 0
Elf64_Phdr:
                  p_type: 1 (PT_LOAD)
                p_offset: 872022744 (33fa02d8)
                 p_vaddr: ffffffffffffffff
                 p_paddr: 38000000
                p_filesz: 2272854016 (87790000)
                 p_memsz: 2272854016 (87790000)
                 p_flags: 7 (PF_X|PF_W|PF_R)
                 p_align: 0
Elf64_Phdr:
                  p_type: 1 (PT_LOAD)
                p_offset: 3144876760 (bb7302d8)
                 p_vaddr: ffffffffffffffff
                 p_paddr: 100000000
                p_filesz: 1073741824 (40000000)
                 p_memsz: 1073741824 (40000000)
                 p_flags: 7 (PF_X|PF_W|PF_R)
                 p_align: 0

Now, the crash utility only uses the p_paddr physical address
fields for x86 dumpfiles, so that shouldn't be a problem.

But I wonder whether when the /proc/vmcore is put together
that there isn't some problem with the data that it accesses?

Thanks,
   Dave









_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

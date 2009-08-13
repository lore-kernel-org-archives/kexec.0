Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MbOIy-0007We-VJ
	for kexec@lists.infradead.org; Thu, 13 Aug 2009 00:36:37 +0000
Received: from yukiko.kent.sydney.vergenet.net
	(124-170-108-12.dyn.iinet.net.au [124.170.108.12])
	by kirsty.vergenet.net (Postfix) with ESMTP id 6489124009
	for <kexec@lists.infradead.org>; Thu, 13 Aug 2009 10:36:30 +1000 (EST)
Date: Thu, 13 Aug 2009 10:36:29 +1000
From: Simon Horman <horms@verge.net.au>
Subject: [ANNOUNCE] kexec-tools 2.0.1
Message-ID: <20090813003629.GA23310@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi all,

I'm happy to announce the 2.0.1 release of kexec-tools.
There are only a few minor changes since the 2.0.1-rc1 pre-release.

This release can be downloaded from kernel.org:

http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/kexec-tools-2.0.1.tar.gz
http://ftp.kernel.org/pub/linux/kernel/people/horms/kexec-tools/

I have also tagged it in git:
git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git
http://git.kernel.org/?p=linux/kernel/git/horms/kexec-tools.git


A summary of the changes since the previous release,
kexec-tools 2.0.0, is below.

commit 0de986976197056d0bf24456912778f1cbec05ef
Author: Simon Horman <horms@verge.net.au>
Date:   Thu Aug 13 09:28:08 2009 +1000

    kexec-tools 2.0.1
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit b45bdabadd1b81777abea001ea7363a430f9e652
Author: M. Mohan Kumar <mohan@in.ibm.com>
Date:   Mon Aug 10 19:44:42 2009 +0530

    Support R_PPC64_REL32 relocation type
    
    [PATCH 2/2] Support R_PPC64_REL32 relocation type
    
    gcc-4.4 compiler creates R_PPC64_REL32 relocation type in the ppc64
    purgatory code. Add support to handle R_PPC64_REL32 relocation type.
    
    Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 3e804a5792dbf3c237789de8d6a86ffffca8e084
Author: M. Mohan Kumar <mohan@in.ibm.com>
Date:   Mon Aug 10 19:43:51 2009 +0530

    Make dtstruct variable to be 8 byte aligned
    
    [PATCH 1/2] Make dtstruct variable to be 8 byte aligned
    
    kexec is creating a version 3 device tree to be backwards compatible. This
    version of the struct has 8-byte alignment for properties whose value is 8 or
    more bytes. As the code directly checks the pointer when deciding to add the
    alignment word, the struct memory must start on an 8 byte boundary. Force the
    dtstruct variable to be always 8 bytes aligned.
    
    Signed-off-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit c24c6f32bb6b9b07d13c5b5c2456cb8004adc96f
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue Jul 28 07:37:58 2009 +0900

    kexec: Handle datarootdir for newer autoconf versions.
    
    This fixes up the:
    
    config.status: WARNING:  'Makefile.in' seems to ignore the --datarootdir setting
    
    warning when producing the output Makefile.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit cc413b9512e7ac3b81e9ddea61f0ad1943b61e4b
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Jul 22 12:19:06 2009 +1000

    kexec-tools 2.0.1-rc1-git
    
    Add -git to version so it doesn't look like a release.
    This is just so when people build code from git it can
    be identified as such from the version string.
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 5273e798b25d78ed4e3f51879e8fb2093faa7422
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Jul 22 12:09:50 2009 +1000

    kexec-tools 2.0.1-rc1
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 3444dce25ba125ae6d9522bbd297f78cb31211fb
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Jul 22 12:09:13 2009 +1000

    Include kexec/arch/cris/kexec-cris.h in distribution tarball
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 346ed7a0c89e48f4bffceca8b4c4f50cc4932fc6
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Jul 22 12:08:21 2009 +1000

    Include kexec/arch/sh/crashdump-sh.h in distribution tarball
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 24e8417fff62b3f3d4fbee52d0dd383ba50178a5
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Mon Jun 22 15:08:49 2009 -0700

    kexec: Fix printed symbol value
    
    Move the print statement so that the variable
    value has been assigned before its value is
    printed.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 7ca0270ab3e2f1abcc520f59c6795f1b873bddcd
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Mar 18 20:22:51 2009 +0900

    sh: use physical address for zImage entry
    
    Use a physical address for the SuperH zImage entry point.
    This makes the zImage loader behave as the elf loader.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 09e2b3a3f9f6477875da1bfacdcf1f1bb1b4486a
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Mar 18 15:07:46 2009 +0900

    kexec jump: SuperH vmlinux support
    
    Create elf header and modify the kernel command line
    when loading a crash kernel or a kexec jump kernel.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 0cd674d83b07bd5fd1bbd09d40bea2825e44d3d1
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Mar 18 15:07:01 2009 +0900

    kexec jump: use add_segment_phys_virt()
    
    Since /proc/iomem contains physical addresses, use
    add_segment_phys_virt(xxx, 0) instead of add_segment()
    in add_backup_segments().
    
    This fix is needed for kexec jump on SuperH where
    add_segment() only takes virtual addresses.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 958704f7e56f5eefef2d6e13975258400d3fdbfd
Author: Bernhard Walle <bernhard.walle@gmx.de>
Date:   Mon Feb 9 23:53:53 2009 +0100

    Correct email addresses
    
    Since I don't work for SUSE any more and 'bwalle@suse.de' is invalid, correct
    it in the copyright so that people can still contact me.
    
    Signed-off-by: Bernhard Walle <bernhard.walle@gmx.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit ad28e87b60062cfcd423fcdecce56d651c38cc1e
Author: Chandru <chandru@in.ibm.com>
Date:   Wed Feb 4 22:02:03 2009 +0530

    x86_64 : exclude gart memory region in kexec tools
    
    The following patch was discussed sometime back on kexec-tools mailing list.
    http://lists.infradead.org/pipermail/kexec/2008-December/003096.html
    Sending it here again for inclusion into kexec-tools. thanks
    ====================================
    
    Exclude GART memory region and make kexec-tools to not create elf headers to
    it.  Currently it seems like the dump analysis tools do not need a copy of the
    GART memory region, hence ignoring it in kexec-tools. Symtoms of accessing
    this region in kdump kernel included hangs, spurious restarts, and MCE
    (Machine Check Exception) panics in some AMD Opteron systems
    
    Signed-off-by: Chandru S <chandru@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 0f15c4319a6f26d55ad0ddb58c1c43068091c570
Author: Chandru <chandru@in.ibm.com>
Date:   Fri Feb 6 12:07:17 2009 +0530

    powerpc: initialize drconf variables
    
    The initialization of lmb_size and num_of_lmbs got removed as part of the
    'kexec memory ranges dynamic allocation' patch to kexec-tools (which added
    realloc_memory_ranges() code to kexec-tools). These variables are pertinent
    to ppc64 systems with ibm,dynamic-reconfiguration-memory node in device-tree,
    i.e systems with /proc/device-tree/ibm,dynamic-reconfiguration-memory. The
    following patch adds code to initialize the variables back again in kexec-tools.
    Without this patch kexec-tools will think that it needs to save only the memory
    represented in memory@ nodes and will skip the memory in
    /proc/device-tree/ibm,dynamic-reconfiguration-memory node of the device-tree.
    
    Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
    Reviewed-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 988a8a9c29230233abf7772bc3dce00603f3011a
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jan 16 19:11:45 2009 +0100

    printf() consolidation
    
    Remove the fprintf(stderr,...) in get_memory_ranges() that adds unnecessary
    output in the normal kexec case that the user don't want to see.
    
    Use dbgprintf() in get_base_ranges() instead of
    
        #ifdef DEBUG
            fprintf(stderr,...)
        #endif
    
    to to make the code more readable.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
    index ad8a31c..8d4e42b 100644
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 95c74405638c786bc76fbca5e4e8427dfe26e907
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jan 16 19:11:34 2009 +0100

    Fix memory corruption when using realloc_memory_ranges()
    
    Because realloc_memory_ranges() makes the old memory invalid, and we return
    a pointer to memory_range in get_memory_ranges(), we need to copy the contents
    in get_memory_ranges().
    
    Some code that calls realloc_memory_ranges() may be triggered by
    get_base_ranges() which is called after get_memory_ranges().
    
    Yes, the memory needs to be deleted somewhere, but I don't know currently
    where it's the best, and since it's not in a loop and memory is deleted
    anyway after program termination I don't want to introduce unneccessary
    complexity. The problem is that get_base_ranges() gets called from
    architecture independent code and that allocation is PPC64-specific here.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>diff --git a/kexec/arch/ppc64/kexec-ppc64.c b/kexec/arch/ppc64/kexec-ppc64.c
    index b0d8acd..ad8a31c 100644
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 8afb534bf7c538eb3f57595054056289cda97b88
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jan 16 19:11:23 2009 +0100

    Fix typo in realloc_memory_ranges()
    
    The base_memory_range should not become memory_range. We need to realloc
    base_memory_range to not change the contents of memory. That was a copy & paste
    error.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 6d4cdf4f94bf7ad2d1752b553ea948385881ff79
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Jan 16 15:06:48 2009 +0100

    Fix missing FILE argument in fprintf()
    
    This fixes the following compiler warning
    
        kexec/arch/i386/crashdump-x86.c: In function 'get_crash_memory_ranges':
        kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 1 of \
            'fprintf' from incompatible pointer type
        kexec/arch/i386/crashdump-x86.c:144: warning: passing argument 2 of \
            'fprintf' makes pointer from integer without a cast
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16
Author: Milton Miller <miltonm@bga.com>
Date:   Fri Jan 2 15:04:48 2009 -0600

    ppc64: cleanups
    
    don't copy purgatory, as elf-load-rel does that for us (like x86_64).
    
    move function declarations from c to h files
    
    remove casts between void  * and various pointers
    
    change some pointers between char and unsigned char *
    
    change args to be vars of the right type instead of casting or
    copying between types
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Tested-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 969203ab173765b775e617391a2605c073f63410
Author: Milton Miller <miltonm@bga.com>
Date:   Fri Jan 2 15:04:51 2009 -0600

    entry wants to be void *
    
    The kexec info struct defines entry to be a void *, so pass around the
    user supplied value as one.
    
    This fixes the following warning:
    
    gcc -g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes -I./include -I./util_lib/include -Iinclude/ -I./kexec/arch/ppc64/include  -c -MD -o kexec/kexec.o kexec/kexec.c
    kexec/kexec.c: In function ‘my_load’:
    kexec/kexec.c:773: warning: assignment makes pointer from integer without a cast
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Tested-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 4fcb65c9089c2c9d203402d549c4e11e44021542
Author: Milton Miller <miltonm@bga.com>
Date:   Fri Jan 2 15:04:45 2009 -0600

    ppc64: segments may be reordered
    
    Instead of fetching data from the segment array, remember the address
    when added and find the kernel text from the parsed elf header.
    
    While add_segment (and hence add_buffer) always adds to the end of
    the list of segments, it sorts the previous segments before each
    allocation.  In some layouts, the device tree or initrd will fit
    in a hole below the the kernel.   When that happens, the previus
    code mis-patches purgatory and the kexec fails.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Tested-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 79c650e757561b03163da73dfc367f702248ef98
Author: Milton Miller <miltonm@bga.com>
Date:   Fri Jan 2 15:04:42 2009 -0600

    ppc64: update kdump for 2.6.28 relocatable kernel
    
    The kernel updated its ABI to tell the relocatable kernel to run
    where it was loaded.
    
    We now need to set a flag in the kernel image.  Since we only have
    the kernel image avialable as const data to kexec-tools c code, set
    the flag in the copy we put in purgatory, and have it set the flag
    in the kernel (after purgatory has run its checksum).  To simplfy
    the purgatory code we can always copy the flag word back to the
    kernel as the c code made a copy of the original flag value.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Tested-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit e8f2de09b52c3f4e23f907a6f6bf837b1f45af50
Author: Milton Miller <miltonm@bga.com>
Date:   Thu Jan 8 06:33:50 2009 -0600

    ppc64: always check number of ranges when adding them
    
    make the idom "always call realloc_memory_ranges when filling a range entry"
    
    kexec was core dumping after using 5 exclude_range pairs when only 3
    were allocated.
    
    also delcare realloc_memory_ranges to take void.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Tested-by: M. Mohan Kumar <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 14f69fc20bec03f7db1c4f4c0e45d9e73400e9a5
Author: Simon Horman <horms@verge.net.au>
Date:   Tue Nov 4 09:26:02 2008 +1100

    Make x86_setup_jump_back_entry() static with a void argument list
    
    gcc complains because x86_setup_jump_back_entry() has no arguments,
    making the argument list void resolves this.
    
    Also, make the function static as it isn't used in any other files.
    And move the function above where it is used, to eliminate the
    need for a forward-declaration.
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit df0878e64e92d403c4e2e5604cd81d6d1baff169
Author: Bernhard Walle <bwalle@suse.de>
Date:   Wed Nov 26 10:00:52 2008 +0100

    Fix compile warnings in get_memory_ranges()
    
    This patch fixes:
    
            kexec/arch/i386/kexec-x86-common.c: In function ‘get_memory_ranges’:
            kexec/arch/i386/kexec-x86-common.c:189: \
                    warning: passing argument 2 of ‘parse_iomem_single’ from incompatible pointer type
            kexec/arch/i386/kexec-x86-common.c:189: \
                    warning: passing argument 3 of ‘parse_iomem_single’ from incompatible pointer type
    
    Yes, that was my own code. :-(
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 73a97629eab98f06b2b1a707e9b310d5fd9f9520
Author: Bernhard Walle <bwalle@suse.de>
Date:   Wed Nov 26 10:00:39 2008 +0100

    Don't use /sys/firmware/memmap for Xen
    
    On Xen, we have to use /proc/iomem to retrieve the memory area for the kexec'd
    kernel, not /sys/firmware/memmap. Dom0 kernel gets a E820 map that contains
    only one region:
    
        0000000000000000-0000000018e5e000 (System RAM)
    
    Compared to the /proc/iomem:
    
        00000000-0009cbff : System RAM
        0009cc00-0009ffff : reserved
        000ce000-000d3fff : reserved
        000e0000-000fffff : reserved
        00100000-1fd6ffff : System RAM
          01000000-04ffffff : Crash kernel
          1ec00000-1fbfffff : Hypervisor code and data
            1f0b4680-1f0b4873 : Crash note
            1f0b4900-1f0b4a93 : Crash note
            1f0b4b80-1f0b4d13 : Crash note
            1f0b4e00-1f0b4f93 : Crash note
        ...
    
    Without that patch, /proc/vmcore is empty in the kexec'd kernel and I'm unable
    to copy the crashdump.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit fcd049da6ac36183e2dc69bd1f479d059e8dd9a7
Author: Huang Ying <ying.huang@intel.com>
Date:   Wed Nov 26 14:47:38 2008 +0800

    Fix kexec x86_64 load failed bug
    
    Fix a bug of kexec load on x86_64. Kexec fails to do load on x86_64, with
    error message:
    
      Symbol: cmdline_end not found cannot set
    
    Because kexec/arch/i386/kexec-bzImage.c accesses cmdline_end symbol in
    i386 purgatory, but there is no cmdline_end in x86_64 purgatory, and
    kexec-bzImage.c is used by x86_64 too.
    
    cmdline_end is added into x86_64 purgatory to solve the bug, because kexec
    jump support for x86_64 is planned.
    
    Reported-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Huang Ying <ying.huang@intel.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 9bf8dee9bab15d7f6de8a4cd332e77a1559083e3
Author: Bernhard Walle <bwalle@suse.de>
Date:   Fri Nov 14 10:48:04 2008 +0100

    Fix spell error in help output
    
    This patch just fixes a spell error. Found by Dave Plater.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 186a545ec38c028cadb948310dac4faba4589fd0
Author: Stefan Assmann <sassmann@suse.de>
Date:   Wed Nov 5 10:41:49 2008 +0100

    Add include for offsetof macro
    
    kexec/arch/i386/kexec-elf-x86.c and kexec/arch/x86_64/kexec-elf-x86_64.c
    both use the macro offsetof() which according to the man page requires
    #include <stddef.h>.
    The include is not present at the moment and this patch adds it. This is
    necessary for compatibility with i.e. uClibc.
    
    Signed-off-by: Stefan Assmann <sassmann@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit d182ce5434c7b66569118db0ccfe63e5d8a03687
Author: Maxim Uvarov <muvarov@gmail.com>
Date:   Wed Oct 15 12:46:24 2008 +0400

    ppc64: kexec memory ranges dynamic allocation
    
    Do not count  max_memory_range for allocation. Increase allocation buffers
    when it is needed. This actually allows us to avoid a lot of troubles with
    various device-tree files.
    
    Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 2b6a50a16a3de9716c8a34af43b8286e5b58b1f2
Author: Huang Ying <ying.huang@intel.com>
Date:   Wed Oct 29 11:24:30 2008 +0800

    core dump file support for ELF loader
    
    This patch adds core dump file support to ELF file loader. This can be
    used by kexec based hibernation to load hibernated image, which is
    from /proc/vmcore, a core dump file.
    
    Signed-off-by: Huang Ying <ying.huang@intel.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit ceb04ae1223ba5cdd40df744aa73a32b2cc7d879
Author: Huang Ying <ying.huang@intel.com>
Date:   Wed Oct 29 11:24:25 2008 +0800

    kexec jump support for kexec-tools
    
    To support memory backup/restore an option named
    --load-preserve-context is added to kexec. When it is specified
    toggether with --mem-max, most segments for crash dump support are
    loaded, and the memory range between mem_min to mem_max which has no
    segments loaded are loaded as backup segments. To support jump back
    from kexeced, options named --load-jump-back-helper and --entry are
    added to load a helper image with specified entry to jump back.
    
    Signed-off-by: Huang Ying <ying.huang@intel.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 802a8a5e396e06a514251c44454c982bff3c5073
Author: Chandru <chandru@in.ibm.com>
Date:   Fri Oct 17 23:25:54 2008 +0530

    kdump: check flags field from drconf memory
    
    On a powerpc machine when memory is dynamically removed/added from an lpar, the
    corresponding flags field in the drconf memory reflects the same with the bits
    unset/set accordingly. The kernel does a check on these flags while booting.
    Following are the similar changes brought in to kexec-tools.  This makes
    kexec-tools to skip those memory regions that do not belong or are not
    assigned to the current partition ( but are available to dynamically add them
    back ). Without this patch (and with memory remove operation) copying vmcore
    fails with error as
    
    Copying data                       : [ 84 %] readmem: Can't read the dump
    memory(/proc/vmcore). Bad address
    read_pfn: Can't get the page data.
    
    Signed-off-by : Chandru S <chandru@in.ibm.com>
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 39dd40d3e83acbe8ef2f1465e02e8d3e26e6a21d
Author: Jay Lan <jlan@sgi.com>
Date:   Fri Sep 19 19:17:05 2008 -0700

    IA64: better calculate PT_LOAD segment size
    
    This patch combines consecutive PL_LOAD segments into one.
    The end address of the last PL_LOAD segment, calculated by
    adding p_memsz to p_paddr & rounded up to ELF_PAGE_SIZE,
    will be the end address of this loaded_segments[] entry.
    
    This patch fixes the kdump kernel MCA problem caused by under-
    allocation of memory and a "kdump broken on ALtix 350" problem
    reported by Bernhard Walle.
    
    Simon, this patch replaces my previous patch I submitted on the
    underallocation issue.
    
    Signed-off-by: Jay Lan <jlan@sgi.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit a96b5c237919e6761260efa83cc6f9d455c25ac1
Author: Simon Horman <horms@verge.net.au>
Date:   Fri Oct 10 09:30:53 2008 +1100

    Fix declaration of get_dyn_reconf_crash_memory_ranges()
    
    powerpc64-unknown-linux-gnu-gcc (GCC) 4.1.1
    Copyright (C) 2006 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    
    kexec/arch/ppc64/crashdump-ppc64.c:125: warning: function declaration isn't a prototype
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 84aa7cf2468c2921d61d4cb97c1df670a470ea8b
Author: Bernhard Walle <bwalle@suse.de>
Date:   Thu Oct 9 19:01:25 2008 +0200

    Use return value of count_dyn_reconf_memory_ranges()
    
    This patch fixes the build error
    
        kexec/arch/ppc64/kexec-ppc64.c:140: \
            warning: control reaches end of non-void function
    
    The patch returns 0 on success, and checks when the function is called
    for a non-zero value.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 1d19ca0c4306c3c684cf4d277781975e4ad1c193
Author: Chandru <chandru@in.ibm.com>
Date:   Wed Sep 24 17:19:29 2008 +0530

    kexec/kdump : get details of ibm, dynamic-reconfiguration-memory node of device tree
    
    Get number of  lmb's (logical memory blocks) , size of each lmb from
    ibm,dynamic-memory property , get base memory ranges from
    ibm,dynamic-reconfiguration-memory node.
    
    Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit cd8497a9a9e487684679b6747f7ba3f0a557328b
Author: Chandru <chandru@in.ibm.com>
Date:   Wed Sep 24 17:19:18 2008 +0530

    kexec/kdump : add a new linux, usable-drconf-memory node to the device tree
    
    Add a new linux,usable-drconf-memory property to the device tree passed to the
    2nd kernel.  Each entry in the property is of the form: a count followed by so
    many  (base, size) pairs of usable memory regions.  The total number of such
    entries is equal to number of lmb's in ibm,dynamic-memory property.
    
    Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 726c130af8b1371aa32dc14f108a3fb1695860bb
Author: Chandru <chandru@in.ibm.com>
Date:   Wed Sep 24 17:19:07 2008 +0530

    kexec/kdump: read crash memory ranges from drconf memory
    
    Get the memory ranges of the 1st kernel excluding the memory reserved for
    kexec/kdump kernel in case of ibm,dynamic-reconfiguration-memory node of
    device tree
    
    Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit d9c5b2da1fad4ac9064db4c890e41066f873f6d3
Author: Mohan Kumar M <mohan@in.ibm.com>
Date:   Tue Sep 30 18:26:21 2008 +0530

    Relocatable kdump kernel support in kexec-tools
    
    Relocatable kdump kernel support in kexec-tools
    
    This patch adds relocatable kernel support for kdump in the kexec-tools
    code. A signature (0xfeed1234) is passed in r6 from panic code to the
    purgatory code through kexec_sequence function. The signature is used to
    differentiate between relocatable kdump kernel and non-kdump kernels.
    
    The purgatory code compares the signature and sets the __kdump_flag in
    head_64.S by using the offset with respect to next kernel load address.
    During the boot up, kernel code checks __kdump_flag and if it is set, the
    kernel will behave as relocatable kdump kernel.
    
    Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit fc071d2a74ae26d817276e82ab71046e6387cbd1
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Oct 8 15:52:19 2008 +1100

    cris: add cris architecture to configure
    
    # PATH=$PATH:/usr/local/cris/bin/ CC=crisv32-axis-linux-gnu-gcc \
    	./configure --host=crisv32-axis-linux-gnu
    configure: WARNING: If you wanted to set the --build type, don't use --host.
        If a cross compiler is detected then cross compile mode will be used.
    checking build system type... i686-pc-linux-gnu
    checking host system type... cris-axis-linux-gnu
    checking target system type... cris-axis-linux-gnu
    configure: error: unsupported architecture cris
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit b039510932e5b3d9691a5d423c34f7ebb14e5175
Author: Edgar E. Iglesias <edgar.iglesias@axis.com>
Date:   Thu Sep 4 16:08:50 2008 +0200

    cris: Add CRISv32 support
    
    Hello,
    
    I hope this is the correct list to which to send these patches.
    Comments are very welcome.
    
    Thanks,
    Edgar
    
    From: Edgar E. Iglesias <edgar.iglesias@axis.com>
    
    Add a CRISv32 port. Initially only the elf filetype is supported.
    
    Signed-off-by: Edgar E. Iglesias <edgar.iglesias@axis.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 800fe37b7931cb11c47c88bf1fd69aa096d3cebe
Author: Edgar E. Iglesias <edgar.iglesias@axis.com>
Date:   Fri Sep 5 11:25:58 2008 +0200

    cris: add kexc_load syscall
    
    The released toolchain had an old list of syscalls (kexec_load was missing)
    so I had to add a fallback definition:
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit edd13ae1c4965b6f1e8a8e07d8e01d31fef37d55
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Oct 8 15:53:02 2008 +1100

    Only use -fno-zero-initialized-in-bss if it is available
    
    As pointed out by Edgar E. Iglesias, the -fno-zero-initialized-in-bss
    option to gcc is not available in the cris 3.2.1 toolchain.
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 7210dc1f75575412b6c29b004614194b9d3ce956
Author: Simon Horman <horms@verge.net.au>
Date:   Wed Oct 8 17:08:51 2008 +1100

    ia64: use generic put_unaligned()
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 4bd67d530f92313fd66bb462d96e3995b8e08af3
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Mon Oct 6 09:24:03 2008 -0600

    ia64: make PA() work for both physical identity-mapped virtual addresses
    
    The EFI Runtime Services Table contains pointers to ia64 function
    descriptors.  On existing, pre-Tiano, firmware, SetVirtualAddressMap()
    converts *all* these pointers from physical to virtual.  On Tiano-based
    firmware, the pointer to the SetVirtualAddressMap() function descriptor
    is not converted, so it remains a physical pointer.
    
    The ia64 kexec purgatory patches the SetVirtualAddressMap() function
    descriptor so that when the new kernel calls SetVirtualAddressMap(), it
    never reaches firmware.  Instead, it calls a dummy function that just
    returns success.
    
    Purgatory runs in physical mode, so it must convert the pointer from the
    RuntimeServicesTable to a physical address.  This patch makes that
    conversion work both for old firmware (where the pointer is an identity-
    mapped virtual address) and new Tiano firmware (where the pointer is a
    physical address).
    
    Without this patch, kexec on Tiano firmware causes an MCA because
    ia64_env_setup() subtracts PAGE_OFFSET from a physical address and ends
    up with an invalid physical address.  Referencing that address causes
    the MCA.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit c466edd86b31a9d34cde3db24b093223108627d2
Author: Jay Lan <jlan@sgi.com>
Date:   Fri Sep 12 13:10:34 2008 -0700

    IA64: do not include uncached memory to vmcore
    
    Currently a memory segment in memory map with attribute of EFI_MEMORY_UC
    is denoted as "System RAM" in /proc/iomem, while memory of attribute
    (EFI_MEMORY_WB|EFI_MEMORY_UC) is also labeled the same.
    
    The kexec utility then includes uncached memory as part of vmcore.
    The kdump kernel may MCA when it tries to save the vmcore to a disk.
    A normal "cached" access can cause MCAs.
    
    Since kexec assembled memory ranges with memory tagged as "System RAM",
    the uncached memory will be excluded if it is labeled differently.
    
    Simon, since only IA64 will create "Uncached RAM" label, i do not
    make changes to other arch.
    
    Our HP machine in the lab is dead. I am sorry that i can not test
    against other IA64 systems (than SGI's). Feedback is very much
    appreciated.
    
    The corresponding kernel patch is needed to test this kexec patch:
    http://marc.info/?l=linux-ia64&m=122122791230130&w=2
    This patch without the kernel patch will have no effect and do no
    harm.
    
    The kernel patch has been commited as
    "[IA64] kexec fails on systems with blocks of uncached memory".
    
    Signed-off-by: Jay Lan <jlan@sgi.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit b422925d35151caa65471c0f0d774727bde4a347
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Wed Sep 10 18:40:46 2008 -0700

    Fix ppc64 build warnings
    
    Fix these ppc64 32 bit build warnings:
    
     kexec/arch/ppc64/kexec-zImage-ppc64.c: In function 'zImage_ppc64_load':
     kexec/arch/ppc64/kexec-zImage-ppc64.c:164: warning: cast to pointer from integer of different size
     kexec/arch/ppc64/kexec-elf-ppc64.c: In function 'elf_ppc64_load':
     kexec/arch/ppc64/kexec-elf-ppc64.c:121: warning: integer constant is too large for 'unsigned long' type
     kexec/arch/ppc64/kexec-elf-ppc64.c:237: warning: cast from pointer to integer of different size
     kexec/arch/ppc64/kexec-elf-ppc64.c:276: warning: cast from pointer to integer of different size
     kexec/arch/ppc64/kexec-elf-ppc64.c:283: warning: cast from pointer to integer of different size
     kexec/arch/ppc64/kexec-elf-ppc64.c:287: warning: cast from pointer to integer of different size
     kexec/arch/ppc64/kexec-elf-ppc64.c:341: warning: format '%lx' expects type 'long unsigned int', but argument 3 has type 'uint64_t'
     kexec/arch/ppc64/kexec-elf-ppc64.c:352: warning: format '%ld' expects type 'long int', but argument 5 has type 'size_t'
     kexec/arch/ppc64/crashdump-ppc64.c:45: warning: integer constant is too large for 'long' type
     kexec/arch/ppc64/crashdump-ppc64.c:46: warning: integer constant is too large for 'long' type
     kexec/arch/ppc64/crashdump-ppc64.c:56: warning: integer constant is too large for 'long' type
     kexec/arch/ppc64/crashdump-ppc64.c:57: warning: integer constant is too large for 'long' type
    
    Tested on PS3 (ppc64) with 32 and 64 bit builds.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit c1d13f4bd287f48c5fce02c3916b132f618c40fb
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Wed Sep 10 18:40:42 2008 -0700

    Fix build warnings
    
    Fix these 64 bit build warnings:
    
     kexec/firmware_memmap.c:241: warning: format '%d' expects type 'int', but argument 3 has type 'size_t'
     kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'Elf64_Off'
     kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 5 has type 'Elf64_Addr'
     kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 6 has type 'Elf64_Addr'
     kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 7 has type 'Elf64_Xword'
     kexec/crashdump-elf.c:160: warning: format '%llx' expects type 'long long unsigned int', but argument 8 has type 'Elf64_Xword'
    
    Tested on PS3 (ppc64) with 32 and 64 bit builds.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 011e3d8660ea44b934f6468b70b1411c97a123a8
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Fri Sep 5 11:13:48 2008 +0900

    sh: Add ELF relocation support for R_SH_DIR32/R_SH_REL32 relocs.
    
    Simple handler for the common SHcompact ELF relocations.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 0723defb5308ac7fce296f8b596bff4df6803f01
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Fri Sep 5 11:13:10 2008 +0900

    kexec/kexec.h: Bring put/get_unaligned() back from the dead.
    
    This re-enables the fairly generic put/get_unaligned() routines in
    kexec.h, while tidying up the variable shadowing clash that results
    when using it in places like machine_apply_elf_rel().
    
    Needed for SH ELF relocations.
    
    IA64 still does its own put_unaligned64(), which should likely also be
    converted over to using put_unaligned() directly.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit e534a0c9fed2066ed3636a082e67f6fafa779019
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Sep 3 20:38:11 2008 +0900

    sh: Add vmlinux crash dump support
    
    This patch adds SuperH crash dump support. The vmlinux loader is modified
    with crash dump hooks as on other architectures. SuperH does not need any
    backup region, so only the elf header is allocated from the top of the
    reserved memory window. The actual size of the memory window is passed
    to the secondary kernel on the command line using "mem=".
    
    The secondary kernel must be configured to match the reserved memory
    window, change kernel parameters CONFIG_MEMORY_START and CONFIG_MEMORY_SIZE.
    
    Linux-2.6.27 should be usable as primary kernel on SuperH, later kernel
    versions are needed to fully support secondary kernel /proc/vmcore.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit e956e4a66847606e133bcc4b97704aa09441a064
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Sep 3 20:36:42 2008 +0900

    sh: Fix help text spelling
    
    Fix SuperH help text spelling.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 93792363d3455459c7af7c646c0a1d1238c772fb
Author: Maxim Shchetynin <maxim@de.ibm.com>
Date:   Wed Aug 27 10:04:56 2008 +0200

    Let kexec work on IBM QS2x blade servers
    
    Hello,
    
    please have a look at the following patch. This patch allows kexec to work
    on IBM QS2x blades. Would it be possible to apply this patch to a next
    kexec version?
    
    Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 6eae8c1bc4d43d07c9799b2406ba42b995f2368d
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:33:20 2008 +1000

    sh: Add vmlinux support
    
    Add SuperH vmlinux support through a zero-page aware elf loader. Only for
    kexec at this point, in the future kdump support will be added.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 61d60261c616d75d6bd380744a78400972dd3e46
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:33:17 2008 +1000

    sh: Use dynamic zImage load address
    
    Dynamically calculate SuperH zImage load address instead of hardcoding.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit e64db1cf9213d0ef9ce3c3df0ce9e23b1c2d7604
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:32:31 2008 +1000

    sh: Autodetect zImage zero page address
    
    Autodetect the zero page base address for zImages on SuperH.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit ded6432c225a10c6390c83463471977c18492fff
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:32:29 2008 +1000

    sh: Add virtual addresses support
    
    Implement virtual-to-physical address conversion functions for SuperH.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 4c3af19e8a98a11effa56fe21d3f557e15017f02
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:32:26 2008 +1000

    sh: Get system memory ranges from /proc/iomem
    
    Parse contents of /proc/iomem instead of hardcoding RAM ranges.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 4b10f34bdc404f2c174fcb9b6a8638cb2ee96765
Author: Magnus Damm <damm@igel.co.jp>
Date:   Wed Aug 27 17:30:41 2008 +1000

    sh: Add support for sh4al-dsp processors
    
    Add support for sh4al-dsp processors such as sh7722.
    
    Signed-off-by: Magnus Damm <damm@igel.co.jp>
    Acked-by: Paul Mundt <lethal@linux-sh.org>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit cfa1ab96374d80f7c355cda30cd6922f96f20405
Author: Marc Kleine-Budde <mkl@pengutronix.de>
Date:   Sun Aug 24 21:21:36 2008 +0200

    arm: asm/page.h is no longer exported to userspace
    
    In recent kernels "asm/page.h" isn't exported to userspace anymore, thus
    the include is removed.
    
    Further this patch defines _XOPEN_SOURCE, in order to use getpagesize.
    
    Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 76e8efd603bf0134788634d2290490e7e346cca2
Author: Bernhard Walle <bwalle@suse.de>
Date:   Tue Aug 26 11:11:59 2008 +0200

    Update INSTALL
    
    That patch should merge my accidentally written INSTALL file with that
    already present in the git tree.
    
    It adds following items:
    
        - static compilation
        - cross compilation
    
    And updates the instructions to build the auto-generated files to use the
    "bootstrap" script already present.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit ffe7ad89763e21952b44872951fb915bf9e9ca85
Author: Bernhard Walle <bwalle@suse.de>
Date:   Tue Aug 26 11:03:43 2008 +0200

    Add INSTALL to tarball
    
    This patch just adds the installation file to the tarball.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 6abf3ba5dc63ef670010927d5572d38c3ce2a587
Author: Bernhard Walle <bwalle@suse.de>
Date:   Tue Aug 26 10:16:49 2008 +0200

    Move $(LIBS) on the end
    
    To make static compilation work with
    
        LDFLAGS=-static ./configure
        make
    
    we have to move $(LIBS) on the end of the compiler line. Static compilation has
    been requested by "Yinghai Lu" <yhlu.kernel@gmail.com>. Although I don't see the
    practical benefit in most cases, I don't think we should not support it. Since
    kexec does not use name resolution functions of libc, it's valid to use static
    linking.
    
    Tested on x86_64-suse-linux.
    
    Signed-off-by: Bernhard Walle <bwalle@suse.de>
    Signed-off-by: Simon Horman <horms@verge.net.au>

commit 8108aeeef14a2ab40756e90c980ac09687eff007
Author: Simon Horman <horms@verge.net.au>
Date:   Sat Jul 19 10:33:05 2008 +1000

    kexec-tools 2.0.0-git
    
    Add -git to version so it doesn't look like a release.
    This is just so when people build code from git it can
    be identified as such from the version string.
    
    Signed-off-by: Simon Horman <horms@verge.net.au>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

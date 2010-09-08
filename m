Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OtQgb-00086o-QE
	for kexec@lists.infradead.org; Wed, 08 Sep 2010 19:52:04 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <m1y6bcf2aq.fsf@fess.ebiederm.org>
Date: Wed, 08 Sep 2010 12:51:55 -0700
In-Reply-To: <m1y6bcf2aq.fsf@fess.ebiederm.org> (Eric W. Biederman's message
	of "Wed, 08 Sep 2010 12:44:29 -0700")
Message-ID: <m1mxrsf1yc.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [GIT PULL] Please pull x86 biarch crashdump support and misc devel
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
To: Simon Horman <horms@verge.net.au>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

ebiederm@xmission.com (Eric W. Biederman) writes:

> I thought I had x86 biarch crashdump working on x86 but it turns
> out was wrong.  So I have merged crashdump-x86.c and crashdump-x86_64.c
> to ensure that things will work fine.
>
> There are a few misc cleanups in here to support biarch crashdumps.
>
> There is a kexec bzImage load  optimization that allows me to use
> a 64bit crash kernel in 20M in my setup.  Perhaps less.  Earlier
> because of an alighment foulup I needed 32M and the kernel was
> loaded in the middle of the reserved crashdump region.
>
> There is also a new program vmcore-dmesg.  Functionally it is very
> similar to the makedumpfile's --dmesg mode but it handles all of the
> crazy multi-arch cases so I only need to keep one binary around to strip
> the kernel's dmesg out of a core file.  Additionally vmcore-dmesg is
> about half the size of makedumpfile and I can build it against uclibc,
> which makes it much more usable in my constrained initrd setup.
>
> I would post patches but I know I would fat finger that horribly.
>
> git pull git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/kexec-tools-devel.git
>

And the diffstat

eric@fess:~/projects/kexec/kexec-tools-devel$ git-diff-tree --stat master HEAD
 Makefile.in                          |    8 +-
 kexec/Makefile                       |    3 +-
 kexec/arch/i386/crashdump-x86.c      |  333 +++++++++++++----
 kexec/arch/i386/crashdump-x86.h      |   17 +-
 kexec/arch/i386/kexec-bzImage.c      |    4 +-
 kexec/arch/i386/kexec-elf-x86.c      |    2 +-
 kexec/arch/ia64/crashdump-ia64.c     |    6 +-
 kexec/arch/x86_64/Makefile           |    8 +-
 kexec/arch/x86_64/arch_init.c        |   83 ----
 kexec/arch/x86_64/crashdump-x86_64.c |  684 ----------------------------------
 kexec/arch/x86_64/crashdump-x86_64.h |   28 --
 kexec/arch/x86_64/kexec-elf-x86_64.c |    2 +-
 kexec/arch/x86_64/kexec-x86_64.c     |   11 +-
 kexec/arch_init.c                    |    4 -
 kexec/crashdump-elf.c                |   14 +-
 kexec/crashdump.h                    |    3 +
 kexec/kernel_version.c               |   58 +++
 kexec/kexec-elf.c                    |   14 +-
 kexec/kexec-elf.h                    |   44 ++--
 kexec/kexec.c                        |    2 -
 kexec/kexec.h                        |    9 +-
 vmcore-dmesg/Makefile                |   29 ++
 vmcore-dmesg/vmcore-dmesg.8          |   42 ++
 vmcore-dmesg/vmcore-dmesg.c          |  504 +++++++++++++++++++++++++
 24 files changed, 972 insertions(+), 940 deletions(-)

> ---
>
> commit 0320ba301f1e944fde3977df91180a538e99b9aa
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 23:19:35 2010 -0700
>
>     x86 bzImage: Optimize the panic kernel memory layout.
>     
>     Load the setup sectors above the kernel in the panic case,
>     to avoid wasting memory.
>     
>     Linux kernels frequently have a severe alignment requirment
>     that can be as much as 16M.  The start of the reserved
>     crash kernel region is 16M aligned.  The setup sectors
>     are tiny 20k? and when we are not running the real mode code
>     they can live anywhere.  Move the setup sectors from
>     lower address than the kernel to higher address than the kernel
>     avoids introducing a bad alignment.  Allowing the linux kernel
>     to load lower.  Loading the linux kernel lower in memory ensures
>     memory is used more efficiently.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 8bd3608a761cc7734f1599945f558cdfc8ee94b3
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 15:00:10 2010 -0700
>
>     kexec-tools: Add vmcore-dmesg
>     
>     vmcore-dmesg is a trivial utility to extract the dmesg from a vmcore.
>     This was written in reaction to problems I was having building
>     makedumpfile, and using makedumpfile for extracting dmesg.  makedumpfile
>     does a whole lot of things, uses a whole lot of libraries and which
>     make it hard to compile and a little bit clunky to remember the command
>     line switches.
>     
>     So I have written the trivial vmcore-dmesg program that reads a vmcore
>     either /proc/vmcore or a saved version vmcore and writes the dmesg to stdout.
>     
>     There is nothing to vmcore-dmesg and all of the arch dependencies are wrapped
>     up in generating the core file.  Which means a vmcore-dmesg should work with
>     core files of all architectures without needing a rebuild.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 6d4b8e90bc066e79dbc8a1387fb9e32c7d0f9435
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Wed Sep 8 10:52:01 2010 -0700
>
>     x86_64: Kill now unused crashdump-x86_64.[ch]
>     
>     Now we use the i386 crashdump-x86 instead we can kill
>     crashdump-x86_64.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit ff053cdb05c2d95dafbcbfd4ffc079cad3c56cc8
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Wed Sep 8 10:12:09 2010 -0700
>
>     x86_64: Use the x86 crashdump
>     
>     With proper biarch support in crashdump-x86, crashdump-x86_64
>     is now redudant and we can use crashdump-x86 everywhere.  Using
>     crashdump-x86 everywhere results in a little unnecessary i386
>     logic on x86_64 but is otherwise harmless.  Removing the
>     unnecessary duplication between i386 and x86_64 should make
>     the code much easier to maintain going forward.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit aa0418789d8e89478044511c16a32ed4c45fefb3
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 14:11:54 2010 -0700
>
>     x86_64: Use the i386 arch_options_t on x86_64
>     
>     In preparation for having a single crashdump implementation
>     on i386 and x86_64 start sharing arch_options_t between
>     i386 and x86_64, and don't make arch_options static on
>     x86_64.
>     
>     i386 and x86_64 have been using identitcal defitions of
>     arch_options for a while this change now reflects that
>     practical reality in the code.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 773ff64ab0ed27ca6b33c9866f89291226e86574
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 14:10:21 2010 -0700
>
>     i386 crashdump: Preserve credits of x86_64 version
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 9322014fbfa77b5c744d8fabd3e9adf30b751219
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 13:58:29 2010 -0700
>
>     i386 crashdump: Compute page_offset paddr vaddr and size like x86_64.
>     
>     Make certain we are using the same page_offset, paddr, and vaddr
>     and kernel size that the x86_64 crashdump code is using.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 53408ce05fc411a1a5d8aee902ed0172518fc5d8
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Wed Sep 8 12:01:14 2010 -0700
>
>     kexec elf: Handle 64bit elf executables on 32bit platforms.
>     
>     - Widen some types.  Why did I use unsigned long?  I guess this
>       code predates the decision to support biarch.
>     - Since I have made the types wider fix the statements that
>       print those types out.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit f79a61460fdb6fda47b3a1b01e1b4771374b7975
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 20:31:03 2010 -0700
>
>     kexec elf: Clean up error messages build_mem_phdrs
>     
>     Don't print uncondintionally print an error message about
>     KCORE_ELF_HEADERS_SIZE being wrong when the elf headers
>     are truncated when build_mem_phdrs fails because there
>     are other reasons we could be truncated (like an
>     actual damaged elf file).
>     
>     Instead only print an error message when either probe_debug
>     is true or we are skipping the total file size checks for
>     some reason.  When we do print an error message limit the
>     message to the fact that we are truncated and how many
>     bytes we have and how many bytes we need.  The context
>     of the failure should be able to provide the rest of
>     the information.
>     
>     For now add a comment in crashdump-x86_64.c to direct people
>     to KCORE_ELF_HEADERS_SIZE so that if someone finds the
>     code things can be adjusted.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 4c4ef6506eb29cfad16546f6b8435935432d3251
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 13:34:43 2010 -0700
>
>     i386 crashdump: pass acpi info, and generalize hack
>     
>     - Pass the acpi memap to the kernel.
>     - Port the fix from x86_64 to not truncate the elf
>       note segment to 16K, to keep large machines happy.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit d25f82619565f862e2a6104fac505b9c13c8fe4c
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 13:23:55 2010 -0700
>
>     i386 crashdump: move crashdump debugging code under #ifdef DEBUG
>     
>     o Put the debug code under #ifdef DEBUG instead of #if 0.
>     o Do this to match the x86_64 code.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 672991ea2208dd478e8c52982f39a87c64a4c8a5
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 13:12:18 2010 -0700
>
>     i386 crashdump: Unify get_crash_memory_ranges.
>     
>     Build a version of get_crash_memory_ranges that works the same
>     on both x86_64 and x86.  Reorder the calls in load_crashdump_segments
>     so we have the architectures low memory limit when we call
>     get_crash_memory_ranges.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit b73411718dbf452675fa903b2db7ab58c24ef1ba
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 12:53:11 2010 -0700
>
>     i386 crashdump: Rename and include the x86_64 constants.
>     
>     Unify the 32bit and the 64bit crashdump headers.  Rename
>     arch specific defintions to arch specific names to be clear.
>     Update users of the renamed constants.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 8f211c7519327124bb18d9e362ac9777bf400c67
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 12:43:40 2010 -0700
>
>     i386 crashdump: Keep elf_info on the stack.
>     
>     In preparation for merging crashdump-x86 and crashdump-x86_64
>     move elf_info onto the stack and start filling it out dynamically
>     as appropriate.
>     
>     Included in this change is only setting lowmem_limit and get_note_info
>     when we are generating a core file for a 32bit kernel.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit c8e346688c6358427213d9d6fdb83765e365cccd
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 12:05:40 2010 -0700
>
>     crashdump: Move kern_vaddr_start from kexec_info into crash_elf_info
>     
>     These fields as defined in kexec_info are not biarch safe and
>     beyond that crash_elf_info is the structure for passing this kind
>     of information not kexec_info.  So move them in prepartion for
>     properly cleaning up biarch x86 functionality.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit d9bf000b6260ee4558b2d2eb3af08e09cd1fe794
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 11:42:39 2010 -0700
>
>     kexec: Kill arch_init
>     
>     The function only had one user, the error checking was wrong,
>     and the functions it performed are best done elsewhere
>     so remove the tempation of a problemenatic hook.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 3578b1f1437f8d1b569d1e30f6d4e15edd1cce53
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 11:37:21 2010 -0700
>
>     x86_64 crashdump: Move calculation of the page offset into crashdump-x86_64.c
>     
>     Don't calculate page_offfset in arch_init.  Performing the work there
>     badly messes up biarch support, so move the work into crashdump_x86_64.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit 3cab31db10dd74aa148ad20aaa3455723bf45138
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 11:25:30 2010 -0700
>
>     kexec: Move kernel_version into the kexec core
>     
>     I'm not pleased with the hacks that we use kernel_version
>     for but kernel_version itself is reasonable code and might
>     be needed elsewhere, so move kernel_version into the kexec
>     core.
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> commit ebeb4da62f8b51c63a46349b219a5605ee8d79bd
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 7 10:41:56 2010 -0700
>
>     i386 elf: Correct the probe error string
>     
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

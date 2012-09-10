Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TArVl-0008Rb-4F
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 00:05:58 +0000
Date: Mon, 10 Sep 2012 09:05:50 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7] Add device-tree support to kexec-tools for ARM
Message-ID: <20120910000550.GI30480@verge.net.au>
References: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1347009086-16506-1-git-send-email-matthew.leach@arm.com>
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
To: Matthew Leach <matthew.leach@arm.com>
Cc: will.deacon@arm.com, kexec@lists.infradead.org

On Fri, Sep 07, 2012 at 10:11:19AM +0100, Matthew Leach wrote:
> Hi all,
> 
> Running a kexec() on ARM platforms has become an issue as information
> about the platform that is presented via device-tree is required to
> boot newer kernels.
> 
> The ATAGs kernel code is re-used, replacing the ATAGs with a
> device-tree blob so that only kexec-tools needs to be changed. There
> are two options for generating a dtb to be passed to the kernel from
> kexec-tools: 1) Read in the device-tree that is exposed in
> /proc/device-tree and flatten this out into a dtb.  2) Allow the user
> to specify a dtb file on the command line.  These blobs are then
> loaded into memory before the kernel image and the address passed
> through to r2, as stated in the ARM booting documentation.
> 
> These patches depend upon a kernel patch, namely:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-September/118275.html
> 
> Simon - you are welcome to add your signed-off-by to my final patch as
> I incorporated bits of your final patch into mine.

Sure, I'll add the sign-off as part of merging the changes.

What I have in mind is to to merge the non ppc64/powerpc patches,
that is 5 of the 7 patches. I'm a but unsure how the kernel-side of things
will pan out, but an incremental patch can be made to kexec-tools
if needed and this series shouldn't break any existing support
Does that work for you?

> Matt
> 
> Matthew Leach (1):
>   ARM: Add device tree support to the ARM platform
> 
> Simon Horman (6):
>   libfdt: Move from kexec/arch/ppc/libfdt/ to kexec/libfdt/
>   kexec-elf.h: Include headers for types used
>   fs2dt: Add a generic copy of fs2dt
>   ppc64: Move 64bit powerpc to use generic fs2dt code
>   powerpc: Move 32bit powerpc to use generic fs2dt code
>   arm: Make use of memory_ranges
> 
>  kexec/Makefile                                |   6 +
>  kexec/arch/arm/Makefile                       |  13 +
>  kexec/arch/arm/crashdump-arm.c                |  45 ++-
>  kexec/arch/arm/crashdump-arm.h                |   2 +
>  kexec/arch/arm/include/arch/options.h         |   6 +-
>  kexec/arch/arm/kexec-arm.h                    |   7 +
>  kexec/arch/arm/kexec-zImage-arm.c             |  87 ++++-
>  kexec/arch/ppc/Makefile                       |  17 +-
>  kexec/arch/ppc/crashdump-powerpc.c            |   2 +-
>  kexec/arch/ppc/crashdump-powerpc.h            |   2 +
>  kexec/arch/ppc/fs2dt.c                        | 450 --------------------------
>  kexec/arch/ppc/kexec-elf-ppc.c                |   2 -
>  kexec/arch/ppc/kexec-ppc.h                    |  26 +-
>  kexec/arch/ppc/kexec-uImage-ppc.c             |   3 -
>  kexec/arch/ppc64/Makefile                     |   7 +-
>  kexec/arch/ppc64/crashdump-ppc64.c            |   3 +-
>  kexec/arch/ppc64/crashdump-ppc64.h            |   4 +
>  kexec/arch/ppc64/kexec-elf-ppc64.c            |   4 +-
>  kexec/arch/ppc64/kexec-ppc64.c                |   1 +
>  kexec/arch/ppc64/kexec-ppc64.h                |  29 +-
>  kexec/arch_reuse_initrd.c                     |   2 +
>  kexec/{arch/ppc64 => }/fs2dt.c                | 277 +++++++++-------
>  kexec/fs2dt.h                                 |  38 +++
>  kexec/kexec-elf.h                             |   3 +
>  kexec/kexec.h                                 |   5 +
>  kexec/{arch/ppc => }/libfdt/Makefile.libfdt   |   8 +-
>  kexec/{arch/ppc => }/libfdt/TODO              |   0
>  kexec/{arch/ppc => }/libfdt/fdt.c             |   0
>  kexec/{arch/ppc => }/libfdt/fdt.h             |   0
>  kexec/{arch/ppc => }/libfdt/fdt_ro.c          |   0
>  kexec/{arch/ppc => }/libfdt/fdt_rw.c          |   0
>  kexec/{arch/ppc => }/libfdt/fdt_strerror.c    |   0
>  kexec/{arch/ppc => }/libfdt/fdt_sw.c          |   0
>  kexec/{arch/ppc => }/libfdt/fdt_wip.c         |   0
>  kexec/{arch/ppc => }/libfdt/libfdt.h          |   0
>  kexec/{arch/ppc => }/libfdt/libfdt_env.h      |   0
>  kexec/{arch/ppc => }/libfdt/libfdt_internal.h |   0
>  37 files changed, 392 insertions(+), 657 deletions(-)
>  delete mode 100644 kexec/arch/ppc/fs2dt.c
>  rename kexec/{arch/ppc64 => }/fs2dt.c (77%)
>  create mode 100644 kexec/fs2dt.h
>  rename kexec/{arch/ppc => }/libfdt/Makefile.libfdt (60%)
>  rename kexec/{arch/ppc => }/libfdt/TODO (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt.h (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt_ro.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt_rw.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt_strerror.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt_sw.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/fdt_wip.c (100%)
>  rename kexec/{arch/ppc => }/libfdt/libfdt.h (100%)
>  rename kexec/{arch/ppc => }/libfdt/libfdt_env.h (100%)
>  rename kexec/{arch/ppc => }/libfdt/libfdt_internal.h (100%)
> 
> -- 
> 1.7.12
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

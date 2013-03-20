Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIIxg-0003wG-Eg
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:21:49 +0000
Date: Wed, 20 Mar 2013 22:21:45 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] kexec: Use err() instead of fprintf()
Message-ID: <20130320132145.GK16436@verge.net.au>
References: <5149B68C.1080704@gmail.com>
 <5149B6FF.70908@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5149B6FF.70908@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Mar 20, 2013 at 09:17:51PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> Since we have the err() interface, so replace the error printing
> function with err().

This patch introduces a lot of code changes and I'm not entirely
sure that I see the benefit.

> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kexec/arch/arm/kexec-arm.c            |    3 +-
>  kexec/arch/arm/kexec-zImage-arm.c     |   18 ++++-----
>  kexec/arch/i386/crashdump-x86.c       |   37 ++++++++---------
>  kexec/arch/i386/kexec-bzImage.c       |   18 ++++----
>  kexec/arch/i386/kexec-elf-x86.c       |    4 +-
>  kexec/arch/i386/kexec-multiboot-x86.c |   11 ++---
>  kexec/arch/i386/kexec-nbi.c           |   14 +++---
>  kexec/arch/i386/kexec-x86-common.c    |   27 ++++++-------
>  kexec/arch/i386/kexec-x86.c           |    9 +---
>  kexec/arch/i386/x86-linux-setup.c     |   19 ++++-----
>  kexec/arch/ia64/crashdump-ia64.c      |    5 +-
>  kexec/arch/ia64/kexec-elf-ia64.c      |   12 +++---
>  kexec/arch/ia64/kexec-ia64.c          |    3 +-
>  kexec/arch/mips/crashdump-mips.c      |   11 ++---
>  kexec/arch/mips/kexec-elf-mips.c      |    2 +-
>  kexec/arch/mips/kexec-mips.c          |    4 +-
>  kexec/arch/ppc/crashdump-powerpc.c    |    5 +-
>  kexec/arch/ppc/fixup_dtb.c            |    3 +-
>  kexec/arch/ppc/kexec-dol-ppc.c        |   14 +++----
>  kexec/arch/ppc/kexec-elf-ppc.c        |    4 +-
>  kexec/arch/ppc/kexec-ppc.c            |   36 ++++++++--------
>  kexec/arch/ppc/kexec-uImage-ppc.c     |    2 +-
>  kexec/arch/ppc64/crashdump-ppc64.c    |   10 ++---
>  kexec/arch/ppc64/fs2dt.c              |    2 +-
>  kexec/arch/ppc64/kexec-elf-ppc64.c    |   17 ++++----
>  kexec/arch/ppc64/kexec-ppc64.c        |    6 +-
>  kexec/arch/ppc64/kexec-zImage-ppc64.c |   18 +++-----
>  kexec/arch/s390/kexec-image.c         |    4 +-
>  kexec/arch/s390/kexec-s390.c          |    2 +-
>  kexec/arch/sh/kexec-sh.c              |    2 +-
>  kexec/arch/x86_64/kexec-bzImage64.c   |   16 ++++----
>  kexec/arch/x86_64/kexec-elf-x86_64.c  |    6 +-
>  kexec/arch/x86_64/kexec-x86_64.c      |    5 +-
>  kexec/crashdump-xen.c                 |    8 ++--
>  kexec/firmware_memmap.c               |   12 ++---
>  kexec/fs2dt.c                         |    2 +-
>  kexec/kernel_version.c                |   17 +++-----
>  kexec/kexec-elf-exec.c                |    8 ++--
>  kexec/kexec-elf-rel.c                 |   10 ++--
>  kexec/kexec-elf.c                     |   70 ++++++++++++++++-----------------
>  kexec/kexec.c                         |   64 ++++++++++++------------------
>  kexec/phys_arch.c                     |    6 +--
>  kexec/zlib.c                          |    2 +-
>  43 files changed, 249 insertions(+), 299 deletions(-)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

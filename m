From: Baoquan He <bhe@redhat.com>
Date: Thu, 31 Mar 2022 19:25:33 +0800
Subject: [PATCH v4 0/4] Convert vmcore to use an iov_iter
In-Reply-To: <20220318093706.161534-1-bhe@redhat.com>
References: <20220318093706.161534-1-bhe@redhat.com>
Message-ID: <YkWPrWOe1hlfqGdy@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Andrew,

On 03/18/22 at 05:37pm, Baoquan He wrote:
> Copy the description of v3 cover letter from Willy:

Could you pick this series into your tree? I reviewed the patches 1~3
and tested the whole patchset, no issue found.

Thanks
Baoquan

> ===
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.
> 
> This series resends Willy's v3 patches which includes patch 1~3, and
> append one patch to clean up the open code pointed out by Al.
> 
> Al's concerns to v3 patches and my reply after investigation:
> https://lore.kernel.org/all/YhiTN0MORoQmFFkO at MiWiFi-R3L-srv/T/#u
> 
> Willy's v3 patchset:
> [PATCH v3 0/3] Convert vmcore to use an iov_iter
> https://lore.kernel.org/all/20211213143927.3069508-1-willy at infradead.org/T/#u
> 
> Changelog:
> ===
> v4:
>  - Append one patch to replace the open code with iov_iter_count().
>    This is suggested by Al.
>  - Fix a indentation error by replacing space with tab in
>    arch/sh/kernel/crash_dump.c of patch 1 reported by checkpatch. The
>    rest of patch 1~3 are untouched.
>  - Add Christopy's Reviewed-by and my Acked-by for patch 1~3.
> v3:
>  - Send the correct patches this time
> v2:
>  - Removed unnecessary kernel-doc
>  - Included uio.h to fix compilation problems
>  - Made read_from_oldmem_iter static to avoid compile warnings during the
>    conversion
>  - Use iov_iter_truncate() (Christoph)
> 
> 
> 
> Baoquan He (1):
>   fs/proc/vmcore: Use iov_iter_count()
> 
> Matthew Wilcox (Oracle) (3):
>   vmcore: Convert copy_oldmem_page() to take an iov_iter
>   vmcore: Convert __read_vmcore to use an iov_iter
>   vmcore: Convert read_from_oldmem() to take an iov_iter
> 
>  arch/arm/kernel/crash_dump.c     |  27 +------
>  arch/arm64/kernel/crash_dump.c   |  29 +------
>  arch/ia64/kernel/crash_dump.c    |  32 +-------
>  arch/mips/kernel/crash_dump.c    |  27 +------
>  arch/powerpc/kernel/crash_dump.c |  35 ++-------
>  arch/riscv/kernel/crash_dump.c   |  26 +------
>  arch/s390/kernel/crash_dump.c    |  13 ++--
>  arch/sh/kernel/crash_dump.c      |  29 ++-----
>  arch/x86/kernel/crash_dump_32.c  |  29 +------
>  arch/x86/kernel/crash_dump_64.c  |  48 ++++--------
>  fs/proc/vmcore.c                 | 130 +++++++++++++------------------
>  include/linux/crash_dump.h       |  19 ++---
>  12 files changed, 123 insertions(+), 321 deletions(-)
> 
> -- 
> 2.34.1
> 



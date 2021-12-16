Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxmMY-004AMA-A9
 for kexec@lists.infradead.org; Thu, 16 Dec 2021 08:43:43 +0000
Date: Thu, 16 Dec 2021 16:43:25 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 0/3] Convert vmcore to use an iov_iter
Message-ID: <20211216084325.GH3023@MiWiFi-R3L-srv>
References: <20211213143927.3069508-1-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213143927.3069508-1-willy@infradead.org>
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
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, prudo@redhat.com
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@arm.com>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org

On 12/13/21 at 02:39pm, Matthew Wilcox (Oracle) wrote:
> For some reason several people have been sending bad patches to fix
> compiler warnings in vmcore recently.  Here's how it should be done.
> Compile-tested only on x86.  As noted in the first patch, s390 should
> take this conversion a bit further, but I'm not inclined to do that
> work myself.

Add Philipp to the CC.

He used to work on s390 arch. Now he joins Redhat and will focus
on kexec/kdump. See if he has any thoughts on the s390 part of work, or
may reach out to s390 developer.

> 
> v3:
>  - Send the correct patches this time
> v2:
>  - Removed unnecessary kernel-doc
>  - Included uio.h to fix compilation problems
>  - Made read_from_oldmem_iter static to avoid compile warnings during the
>    conversion
>  - Use iov_iter_truncate() (Christoph)
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
>  fs/proc/vmcore.c                 | 129 +++++++++++++------------------
>  include/linux/crash_dump.h       |  19 ++---
>  12 files changed, 122 insertions(+), 321 deletions(-)
> 
> -- 
> 2.33.0
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

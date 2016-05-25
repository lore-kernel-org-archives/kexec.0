Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b5S7L-0001XX-Mg
 for kexec@lists.infradead.org; Wed, 25 May 2016 06:16:32 +0000
Received: by mail-oi0-f42.google.com with SMTP id k23so63065522oih.0
 for <kexec@lists.infradead.org>; Tue, 24 May 2016 23:16:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1axXS0-0004gz-5a@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXS0-0004gz-5a@e0050434b2927.dyn.arm.linux.org.uk>
Date: Wed, 25 May 2016 11:46:08 +0530
Message-ID: <CAHB_GupQcopOR7Qn5Nk0kNvYT_p0AWTzp+vJe87b+BsQTwr1CQ@mail.gmail.com>
Subject: Re: [PATCH kexec-tools 01/32] kdump: mmap() and munmap() only work on
 page-aligned quantites
From: Pratyush Anand <panand@redhat.com>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Tue, May 3, 2016 at 3:51 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> The man page for mmap() and munmap() says that mmap() and munmap()
> only works for page-aligned addresses, sizes and offsets.  Arrange
> to give these interfaces what they want.
>

If I read correctly, it talks only offsets to be page aligned.

> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Anyway, changes looks good to me.
Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kdump/kdump.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/kdump/kdump.c b/kdump/kdump.c
> index 821ee7c..3247a54 100644
> --- a/kdump/kdump.c
> +++ b/kdump/kdump.c
> @@ -25,22 +25,35 @@
>  #define MAP_WINDOW_SIZE (64*1024*1024)
>  #define DEV_MEM "/dev/mem"
>
> +#define ALIGN_MASK(x,y) (((x) + (y)) & ~(y))
> +#define ALIGN(x,y)     ALIGN_MASK(x, (y) - 1)
> +
>  static void *map_addr(int fd, unsigned long size, off_t offset)
>  {
> +       unsigned long page_size = getpagesize();
> +       unsigned long map_offset = offset & (page_size - 1);
> +       size_t len = ALIGN(size + map_offset, page_size);
>         void *result;
> -       result = mmap(0, size, PROT_READ, MAP_SHARED, fd, offset);
> +
> +       result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
>         if (result == MAP_FAILED) {
>                 fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
>                         (unsigned long long)offset, size, strerror(errno));
>                 exit(5);
>         }
> -       return result;
> +       return result + map_offset;
>  }
>
>  static void unmap_addr(void *addr, unsigned long size)
>  {
> +       unsigned long page_size = getpagesize();
> +       unsigned long map_offset = (uintptr_t)addr & (page_size - 1);
> +       size_t len = ALIGN(size + map_offset, page_size);
>         int ret;
> -       ret = munmap(addr, size);
> +
> +       addr -= map_offset;
> +
> +       ret = munmap(addr, len);
>         if (ret < 0) {
>                 fprintf(stderr, "munmap failed: %s\n",
>                         strerror(errno));
> --
> 1.9.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

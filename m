Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fLkfc-0001gw-6m
 for kexec@lists.infradead.org; Thu, 24 May 2018 07:28:22 +0000
Date: Thu, 24 May 2018 15:28:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] arm64: update PHYS_OFFSET to conform to kernel
Message-ID: <20180524072805.GA3717@MiWiFi-R3L-srv>
References: <1526018427-8710-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1526018427-8710-2-git-send-email-yanjiang.jin@hxt-semitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1526018427-8710-2-git-send-email-yanjiang.jin@hxt-semitech.com>
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
To: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
Cc: jinyanjiang@gmail.com, bhsharma@redhat.com, horms@verge.net.au, kexec@lists.infradead.org

On 05/11/18 at 02:00pm, Yanjiang Jin wrote:
> Now, according to the kernel's memory.h, converting a virtual address to
> a physical address should be done like below:
> 
>         phys_addr_t __x = (phys_addr_t)(x);
> \
>         __x & BIT(VA_BITS - 1) ? (__x & ~PAGE_OFFSET) + PHYS_OFFSET :
> \
>                                  (__x - kimage_voffset); })
> 
> We just set PHYS_OFFSET as the start address of the first usable memory
> block in SYSTEM RAM before, but it is defined in kernel as below:
> 
> define PHYS_OFFSET ({ VM_BUG_ON(memstart_addr & 1); memstart_addr; })
> 
> So we need to calculate PHYS_OFFSET based on some proc nodes.
> 
> Without this change, we would get a wrong vmcore.
> Assume that we have a system as below:
> 
> Virtual kernel memory layout:

Add Bhupesh to the CC list, he should has thougts for this issue since
he takes care of arm64 issues.

Thanks
Baoquan

> 
>  memory  : 0xffff800000200000 - 0xffff801800000000
> 
> The first iomem block:
> 
>  00200000-0021ffff : reserved
> 
> But in vmcore's elf header, the corresponding memory block as below,
> the last 2M bytes lost due to "iomem" starts from 0x200000.
> 
>   Type     VirtAddr
>   LOAD     0xffff80017fe00000
> 
> If an application, for example, vmcore-dmesg, wants to access the
> kernel symbol which is located in the last 2M address, it would
> fail with the below error:
> 
>   "No program header covering vaddr 0xffff8017ffe90000 found kexec bug?"
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@hxt-semitech.com>
> ---
>  kexec/arch/arm64/kexec-arm64.c | 100 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> index 62f3758..d9e65fb 100644
> --- a/kexec/arch/arm64/kexec-arm64.c
> +++ b/kexec/arch/arm64/kexec-arm64.c
> @@ -14,6 +14,8 @@
>  #include <sys/stat.h>
>  #include <linux/elf-em.h>
>  #include <elf.h>
> +#include <sys/mman.h>
> +#include <fcntl.h>
> 
>  #include "kexec.h"
>  #include "kexec-arm64.h"
> @@ -33,6 +35,12 @@
>  #define PROP_ELFCOREHDR "linux,elfcorehdr"
>  #define PROP_USABLE_MEM_RANGE "linux,usable-memory-range"
> 
> +#define DEV_MEM "/dev/mem"
> +
> +#define ALIGN_MASK(x, y) (((x) + (y)) & ~(y))
> +#define ALIGN(x, y)    ALIGN_MASK(x, (y) - 1)
> +#define BUFSIZE  (256)
> +
>  /* Global varables the core kexec routines expect. */
> 
>  unsigned char reuse_initrd;
> @@ -660,6 +668,96 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
>         return v;
>  }
> 
> +static uint64_t get_kernel_paddr(void)
> +{
> +       uint64_t start;
> +
> +       if (parse_iomem_single("Kernel code\n", &start, NULL) == 0) {
> +               dbgprintf("kernel load physical addr start = 0x%" PRIu64 "\n",
> +                       start);
> +               return start;
> +       }
> +
> +       fprintf(stderr, "Cannot determine kernel physical load addr\n");
> +       exit(3);
> +}
> +
> +static uint64_t get_kimage_voffset(void)
> +{
> +       uint64_t kern_vaddr_start;
> +       uint64_t kern_paddr_start;
> +
> +       kern_paddr_start = get_kernel_paddr();
> +       kern_vaddr_start = get_kernel_sym("_text");
> +
> +       return kern_vaddr_start - kern_paddr_start;
> +}
> +
> +static uint64_t kimg_to_phys(uint64_t vaddr)
> +{
> +       return vaddr - get_kimage_voffset();
> +}
> +
> +static void *map_addr(int fd, unsigned long size, off_t offset)
> +{
> +       unsigned long page_size = getpagesize();
> +       unsigned long map_offset = offset & (page_size - 1);
> +       size_t len = ALIGN(size + map_offset, page_size);
> +       void *result;
> +
> +       result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
> +       if (result == MAP_FAILED) {
> +               fprintf(stderr,
> +                       "Cannot mmap " DEV_MEM " offset: %#llx size: %lu: %s\n",
> +                       (unsigned long long)offset, size, strerror(errno));
> +               exit(5);
> +       }
> +       return result + map_offset;
> +}
> +
> +static void unmap_addr(void *addr, unsigned long size)
> +{
> +       unsigned long page_size = getpagesize();
> +       unsigned long map_offset = (uintptr_t)addr & (page_size - 1);
> +       size_t len = ALIGN(size + map_offset, page_size);
> +       int ret;
> +
> +       addr -= map_offset;
> +
> +       ret = munmap(addr, len);
> +       if (ret < 0) {
> +               fprintf(stderr, "munmap failed: %s\n",
> +                       strerror(errno));
> +               exit(6);
> +       }
> +}
> +
> +static void init_phys_offset(void)
> +{
> +       int fd;
> +       uint64_t phys_offset;
> +       uint64_t memstart_addr_paddr;
> +       void *memstart_addr_vaddr;
> +
> +       memstart_addr_paddr = kimg_to_phys(get_kernel_sym("memstart_addr"));
> +
> +       fd = open(DEV_MEM, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "Cannot open " DEV_MEM ": %s\n",
> +                       strerror(errno));
> +               exit(3);
> +       }
> +
> +       memstart_addr_vaddr = map_addr(fd,
> +                       sizeof(memstart_addr_paddr), memstart_addr_paddr);
> +
> +       phys_offset = *(uint64_t *)memstart_addr_vaddr;
> +       unmap_addr(memstart_addr_vaddr, sizeof(memstart_addr_paddr));
> +       close(fd);
> +
> +       set_phys_offset(phys_offset);
> +}
> +
>  /**
>   * add_segment - Use virt_to_phys when loading elf files.
>   */
> @@ -731,6 +829,8 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
>         unsigned int count;
>         int result;
> 
> +       init_phys_offset();
> +
>         result = get_memory_ranges_iomem(array, &count);
> 
>         *range = result ? NULL : array;
> --
> 1.8.3.1
> 
> 
> 
> 
> This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

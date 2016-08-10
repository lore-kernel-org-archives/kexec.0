Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yb0-f178.google.com ([209.85.213.178])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bXXkh-0003xX-1N
 for kexec@lists.infradead.org; Wed, 10 Aug 2016 17:57:16 +0000
Received: by mail-yb0-f178.google.com with SMTP id x196so16563766ybe.1
 for <kexec@lists.infradead.org>; Wed, 10 Aug 2016 10:56:54 -0700 (PDT)
Date: Wed, 10 Aug 2016 23:26:48 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v2 0/7] (kexec-tools) arm64: add kdump support
Message-ID: <20160810175648.GB24137@localhost.localdomain>
References: <20160809020032.28654-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160809020032.28654-1-takahiro.akashi@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: geoff@infradead.org, horms@verge.net.au, kexec@lists.infradead.org

Hi Geoff and Takahiro,

I am having some issues with kexec+kdump while working with Seattle platform. On
top level, kernel crashes in copy_oldmem_page(), because it gets wrong offset
for log_buf during vmcore-dmesg save.

Here is the detail:

(1) From /proc/iomem, these are the "System RAM" Components:

8000000000-8001e7ffff : System RAM
8001e80000-83ff17ffff : System RAM
        8002080000-8002b3ffff : Kernel code
        8002c40000-800348ffff : Kernel data
        807fe00000-80ffdfffff : Crash kernel
83ff180000-83ff1cffff : System RAM
83ff1d0000-83ff21ffff : System RAM
83ff220000-83ffe4ffff : System RAM
83ffe50000-83ffffffff : System RAM

(2) From kexec-tools debug print I see following:
elf_arm64_load: e_entry:       fffffc0008080000 -> 0000008000080000
elf_arm64_load: p_vaddr:       fffffc0008080000 -> 0000008000080000
elf_arm64_load: header_offset: 0000000000000000
elf_arm64_load: text_offset:   0000000000080000
elf_arm64_load: image_size:    0000000001410000
elf_arm64_load: phys_offset:   0000008000000000
elf_arm64_load: page_offset:   fffffc0008000000

I understand that "Kernel Code start physical address" 0x8002080000 should map
to e_entry vaddr which is 0xfffffc0008080000. However, kexec-tools debug print
shows that e_entry vaddr maps to PA 8000080000 which seems wrong.

(3) further page_offset (or vp_offset in your new code) is calculated
as:arm64_mem.page_offset = ehdr.e_entry - arm64_mem.text_offset;

Current calcualtion of page_offset leads to wrong configuration of VA of alls
PT_LOAD (see below). Ultimately, this is also leading to kernel crash during
vmcore-dmesg and vmcore save operations, because we pass an offset to pread()
system call which maps to wrong physical address.

Elf header: p_type = 1, p_offset = 0x8000000000 p_paddr = 0x8000000000
p_vaddr = 0xfffffc0008000000 p_filesz = 0x1e80000 p_memsz = 0x1e80000
[0xfffffc0008000000 should be mapping to 0x8002000000 and not 0x8000000000]
Elf header: p_type = 1, p_offset = 0x8001e80000 p_paddr = 0x8001e80000
p_vaddr = 0xfffffc0009e80000 p_filesz = 0x7df80000 p_memsz = 0x7df80000
Elf header: p_type = 1, p_offset = 0x80ffe00000 p_paddr = 0x80ffe00000
p_vaddr = 0xfffffc0107e00000 p_filesz = 0x2ff380000 p_memsz = 0x2ff380000
Elf header: p_type = 1, p_offset = 0x83ff180000 p_paddr = 0x83ff180000
p_vaddr = 0xfffffc0407180000 p_filesz = 0x50000 p_memsz = 0x50000
Elf header: p_type = 1, p_offset = 0x83ff1d0000 p_paddr = 0x83ff1d0000
p_vaddr = 0xfffffc04071d0000 p_filesz = 0x50000 p_memsz = 0x50000
Elf header: p_type = 1, p_offset = 0x83ff220000 p_paddr = 0x83ff220000
p_vaddr = 0xfffffc0407220000 p_filesz = 0xc30000 p_memsz = 0xc30000
Elf header: p_type = 1, p_offset = 0x83ffe50000 p_paddr = 0x83ffe50000
p_vaddr = 0xfffffc0407e50000 p_filesz = 0x1b0000 p_memsz = 0x1b0000

May be following should be better.
arm64_mem.page_offset = ehdr.e_entry - "kernel Code Start PA" + phys_offset.

(4) Further more,  vmcore must have first PT_LOAD segment as kernel text area.
In this platform we have first "System RAM" area as 8000000000-8001e7ffff which
is not matching to "Kernel code" area. Therefore, we should provide support of
"kern_size" so that first PT_LOAD is kernel text area.

~Pratyush
On 09/08/2016:11:00:25 AM, AKASHI Takahiro wrote:
> My kernel patches of kdump suport on arm64 are currently under reviews [1].
> 
> This patchset is synced with them (v24) and provides necessary changes for
> kexec-tools. It should be applied on top of Geoff's kexec-tools patches
> v3[2] along with a bugfix[3].
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447597.html
> [2] http://lists.infradead.org/pipermail/kexec/2016-August/016768.html
> [3] http://lists.infradead.org/pipermail/kexec/2016-July/016664.html
> 
> Changes for v2:
>  - Trim a temoprary buffer in setup_2nd_dtb()
>  - Add patch#6("kexec: generalize and rename get_kernel_stext_sym()")
>  - Update patch#7 from Pratyush
>    (re-worked by akashi)
> 
> AKASHI Takahiro (5):
>   arm64: kdump: identify memory regions
>   arm64: kdump: add elf core header segment
>   arm64: kdump: set up kernel image segment
>   arm64: kdump: set up other segments
>   arm64: kdump: add DT properties to crash dump kernel's dtb
> 
> Pratyush Anand (2):
>   kexec: generalize and rename get_kernel_stext_sym()
>   arm64: kdump: Add support for binary image files
> 
>  kexec/arch/arm/crashdump-arm.c          |  40 +------
>  kexec/arch/arm64/Makefile               |   2 +
>  kexec/arch/arm64/crashdump-arm64.c      | 188 +++++++++++++++++++++++++++++++-
>  kexec/arch/arm64/crashdump-arm64.h      |  18 ++-
>  kexec/arch/arm64/include/arch/options.h |   8 +-
>  kexec/arch/arm64/kexec-arm64.c          |  91 ++++++++++++++--
>  kexec/arch/arm64/kexec-elf-arm64.c      |  23 +++-
>  kexec/arch/arm64/kexec-image-arm64.c    |  60 +++++++++-
>  kexec/arch/i386/crashdump-x86.c         |  32 +-----
>  kexec/crashdump.c                       |  37 +++++++
>  kexec/crashdump.h                       |   1 +
>  11 files changed, 407 insertions(+), 93 deletions(-)
> 
> -- 
> 2.9.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

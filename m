Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNgAF-0002Ja-5V
 for kexec@lists.infradead.org; Tue, 29 May 2018 15:04:01 +0000
Received: by mail-wm0-x243.google.com with SMTP id f8-v6so41632754wmc.4
 for <kexec@lists.infradead.org>; Tue, 29 May 2018 08:03:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526018427-8710-2-git-send-email-yanjiang.jin@hxt-semitech.com>
References: <1526018427-8710-1-git-send-email-yanjiang.jin@hxt-semitech.com>
 <1526018427-8710-2-git-send-email-yanjiang.jin@hxt-semitech.com>
From: Pratyush Anand <pratyush.anand@gmail.com>
Date: Tue, 29 May 2018 20:33:42 +0530
Message-ID: <CAHM4w1=5eyi+fL0yyUF1ur4CMvjpCLrOpqSKzvtBt=Le5Kguxg@mail.gmail.com>
Subject: Re: [PATCH] arm64: update PHYS_OFFSET to conform to kernel
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
Cc: jinyanjiang@gmail.com, horms@verge.net.au, kexec@lists.infradead.org

Hi Yanjiang,

On Fri, May 11, 2018 at 11:30 AM, Yanjiang Jin
<yanjiang.jin@hxt-semitech.com> wrote:
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

I think, fix might not be correct.

Problem is in vmcore-dmesg and that should be fixed and not the kexec.
See here (https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/vmcore-dmesg/vmcore-dmesg.c?id=HEAD#n261).
How symbols are extracted from vmcore.

You do have "NUMBER(PHYS_OFFSET)=" information in vmcore.

You can probably see makedumpfile code, that how to extract
information from "NUMBER".

Once you know the real PHYS_OFFSET (which could have been random if
KASLR is enabled), you can fix the problem you are seeing.

Regards
Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

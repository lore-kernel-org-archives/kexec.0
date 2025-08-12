Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D670CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 01:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=akQgPLt0rU1NO/ECRY4EbvXlLiEYaE9L1zWyh6GJbjk=; b=Otz8cadU82LNF4JaUSRrxVbsMg
	1TvzMsSPX0QCAZaF6521BuGga385lKpj6kbo2c+dKDfiNzloUd4OAS1yL9KK9SccFcrMzfNKgnYGh
	BogucDOPkh3VZCPfxViPB4vyVc8GrzhwKkQg7HzOIPlmyj1Ux0edBF7mDeCxVwPeNnOR4V3/RHetK
	gwMSMNQ8CVEzasXPYInUGi+0/JhMP39JMl5Q2eimuBAmul16Jst31dHPEiqPuiqzEDNHuBQYSjvHp
	DhTVVyTUUkHmkAANRESRDJ1SK854nWH8y4AWVkwEBRIhMafU+Nwx+huesQ0DqYcD2Og6cXc8EyTuz
	Si/K+XIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uldiv-00000009VZv-2Cf3;
	Tue, 12 Aug 2025 01:22:45 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uldiq-00000009VZa-25Dd
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 01:22:42 +0000
Message-ID: <9760e574-3eb0-46b2-bccd-916f73b9c39e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754961757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akQgPLt0rU1NO/ECRY4EbvXlLiEYaE9L1zWyh6GJbjk=;
	b=lY4Akxb58vBAMONc1Hbrr3rh6wP5QmNCGXr0on3dGeUvXypsSmYM8GirF6e9U2Z0FADh7O
	XjOYnjiQkhNu9Nxr24ONAIYy1b5DzZ5Rwg33N+gtu1VAoan9cmwUKta3RX7ugUxkdQ57wN
	RyV1DZxd/hnt/W/Xjr7QT8BYo3XXN5A=
Date: Tue, 12 Aug 2025 09:21:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] LoongArch: Add kexec_file support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250811092659.14903-1-youling.tang@linux.dev>
 <20250811092659.14903-3-youling.tang@linux.dev>
 <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CAAhV-H55n=v+ztBc8UgK339kuhg3LKvcOQu+jhpVrbvO3zf3=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_182241_065871_F7AE3726 
X-CRM114-Status: GOOD (  35.80  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi, Huacai
On 2025/8/11 22:07, Huacai Chen wrote:
> Hi, Youling,
>
> On Mon, Aug 11, 2025 at 5:28 PM Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> This patch adds support for kexec_file on LoongArch.
>>
>> The image_load() as two parts:
>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>> - the second part loads other segments (eg: initrd, cmdline)
>>
>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
>> but ELF format is not supported.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/Kconfig                     |   8 ++
>>   arch/loongarch/include/asm/image.h         |  18 ++++
>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/kexec_image.c        | 112 +++++++++++++++++++++
>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>   arch/loongarch/kernel/machine_kexec_file.c |  46 +++++++++
>>   7 files changed, 219 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/loongarch/kernel/kexec_image.c
>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index f0abc38c40ac..fd50c83f7827 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -625,6 +625,14 @@ config CPU_HAS_PREFETCH
>>   config ARCH_SUPPORTS_KEXEC
>>          def_bool y
>>
>> +config ARCH_SUPPORTS_KEXEC_FILE
>> +       def_bool 64BIT
>> +
>> +config ARCH_SELECTS_KEXEC_FILE
>> +       def_bool y
>> +       depends on KEXEC_FILE
>> +       select HAVE_IMA_KEXEC if IMA
>> +
>>   config ARCH_SUPPORTS_CRASH_DUMP
>>          def_bool y
>>
>> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
>> index 1f090736e71d..829e1ecb1f5d 100644
>> --- a/arch/loongarch/include/asm/image.h
>> +++ b/arch/loongarch/include/asm/image.h
>> @@ -36,5 +36,23 @@ struct loongarch_image_header {
>>          uint32_t pe_header;
>>   };
>>
>> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
>> +static const uint8_t loongarch_pe_machtype[6] = {'P', 'E', 0x0, 0x0, 0x64, 0x62};
>> +
>> +/**
>> + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
>> + *
>> + * Returns non-zero if 'MZ' signature is found.
>> + */
>> +
>> +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
>> +{
>> +       if (!h)
>> +               return 0;
>> +
>> +       return (h->pe_sig[0] == loongarch_image_pe_sig[0]
>> +               && h->pe_sig[1] == loongarch_image_pe_sig[1]);
>> +}
>> +
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __ASM_IMAGE_H */
>> diff --git a/arch/loongarch/include/asm/kexec.h b/arch/loongarch/include/asm/kexec.h
>> index cf95cd3eb2de..3ef8517a3670 100644
>> --- a/arch/loongarch/include/asm/kexec.h
>> +++ b/arch/loongarch/include/asm/kexec.h
>> @@ -41,6 +41,18 @@ struct kimage_arch {
>>          unsigned long systable_ptr;
>>   };
>>
>> +#ifdef CONFIG_KEXEC_FILE
>> +extern const struct kexec_file_ops kexec_image_ops;
>> +
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>> +
>> +extern int load_other_segments(struct kimage *image,
>> +               unsigned long kernel_load_addr, unsigned long kernel_size,
>> +               char *initrd, unsigned long initrd_len,
>> +               char *cmdline, unsigned long cmdline_len);
> I think the RISC-V naming "load_extra_segments" is better.
This name is also fine, but I prefer it to be consistent with
that in kexec-tools.
>
>> +#endif
>> +
>>   typedef void (*do_kexec_t)(unsigned long efi_boot,
>>                             unsigned long cmdline_ptr,
>>                             unsigned long systable_ptr,
>> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
>> index 6f5a4574a911..bd9405ee3888 100644
>> --- a/arch/loongarch/kernel/Makefile
>> +++ b/arch/loongarch/kernel/Makefile
>> @@ -62,6 +62,7 @@ obj-$(CONFIG_MAGIC_SYSRQ)     += sysrq.o
>>   obj-$(CONFIG_RELOCATABLE)      += relocate.o
>>
>>   obj-$(CONFIG_KEXEC_CORE)       += machine_kexec.o relocate_kernel.o
>> +obj-$(CONFIG_KEXEC_FILE)       += machine_kexec_file.o kexec_image.o
> We only support the efi format, so we don't need to split a
> kexec_image.c like RISC-V, just put everything into
> machine_kexec_file.c is OK.
I hope it is separated and consistent with other architectures.
For instance, arm64 only supports one type.

Youling.
>
> Huacai
>
>>   obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
>>
>>   obj-$(CONFIG_UNWINDER_GUESS)   += unwind_guess.o
>> diff --git a/arch/loongarch/kernel/kexec_image.c b/arch/loongarch/kernel/kexec_image.c
>> new file mode 100644
>> index 000000000000..fdd1845b4e2e
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/kexec_image.c
>> @@ -0,0 +1,112 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Kexec image loader for LoongArch
>> +
>> + * Author: Youling Tang <tangyouling@kylinos.cn>
>> + * Copyright (C) 2025 KylinSoft Corporation.
>> + */
>> +
>> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/pe.h>
>> +#include <linux/string.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/cpufeature.h>
>> +#include <asm/image.h>
>> +
>> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>> +{
>> +       const struct loongarch_image_header *h =
>> +               (const struct loongarch_image_header *)(kernel_buf);
>> +
>> +       if (!h || (kernel_len < sizeof(*h))) {
>> +               pr_err("No loongarch image header.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!loongarch_header_check_pe_sig(h)) {
>> +               pr_err("Bad loongarch PE image header.\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void *image_load(struct kimage *image,
>> +                               char *kernel, unsigned long kernel_len,
>> +                               char *initrd, unsigned long initrd_len,
>> +                               char *cmdline, unsigned long cmdline_len)
>> +{
>> +       struct loongarch_image_header *h;
>> +       struct kexec_buf kbuf;
>> +       unsigned long text_offset, kernel_segment_number;
>> +       struct kexec_segment *kernel_segment;
>> +       int ret;
>> +
>> +       h = (struct loongarch_image_header *)kernel;
>> +       if (!h->image_size)
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       /* Load the kernel */
>> +       kbuf.image = image;
>> +       kbuf.buf_min = 0;
>> +       kbuf.buf_max = ULONG_MAX;
>> +       kbuf.top_down = false;
>> +
>> +       kbuf.buffer = kernel;
>> +       kbuf.bufsz = kernel_len;
>> +       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +       kbuf.memsz = le64_to_cpu(h->image_size);
>> +       text_offset = le64_to_cpu(h->text_offset);
>> +       kbuf.buf_align = SZ_2M;
>> +
>> +       kernel_segment_number = image->nr_segments;
>> +
>> +       /*
>> +        * The location of the kernel segment may make it impossible to satisfy
>> +        * the other segment requirements, so we try repeatedly to find a
>> +        * location that will work.
>> +        */
>> +       while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>> +               /* Try to load additional data */
>> +               kernel_segment = &image->segment[kernel_segment_number];
>> +               ret = load_other_segments(image, kernel_segment->mem,
>> +                                         kernel_segment->memsz, initrd,
>> +                                         initrd_len, cmdline, cmdline_len);
>> +               if (!ret)
>> +                       break;
>> +
>> +               /*
>> +                * We couldn't find space for the other segments; erase the
>> +                * kernel segment and try the next available hole.
>> +                */
>> +               image->nr_segments -= 1;
>> +               kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>> +               kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +       }
>> +
>> +       if (ret) {
>> +               pr_err("Could not find any suitable kernel location!");
>> +               return ERR_PTR(ret);
>> +       }
>> +
>> +       kernel_segment = &image->segment[kernel_segment_number];
>> +
>> +       /* Make sure the second kernel jumps to the correct "kernel_entry". */
>> +       image->start = kernel_segment->mem + h->kernel_entry - text_offset;
>> +
>> +       kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +                     kernel_segment->mem, kbuf.bufsz,
>> +                     kernel_segment->memsz);
>> +
>> +       return NULL;
>> +}
>> +
>> +const struct kexec_file_ops kexec_image_ops = {
>> +       .probe = image_probe,
>> +       .load = image_load,
>> +};
>> diff --git a/arch/loongarch/kernel/machine_kexec.c b/arch/loongarch/kernel/machine_kexec.c
>> index f9381800e291..008f43e26120 100644
>> --- a/arch/loongarch/kernel/machine_kexec.c
>> +++ b/arch/loongarch/kernel/machine_kexec.c
>> @@ -70,18 +70,28 @@ int machine_kexec_prepare(struct kimage *kimage)
>>          kimage->arch.efi_boot = fw_arg0;
>>          kimage->arch.systable_ptr = fw_arg2;
>>
>> -       /* Find the command line */
>> -       for (i = 0; i < kimage->nr_segments; i++) {
>> -               if (!strncmp(bootloader, (char __user *)kimage->segment[i].buf, strlen(bootloader))) {
>> -                       if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
>> -                               kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
>> -                       break;
>> +       if (kimage->file_mode == 1) {
>> +               /*
>> +                * kimage->cmdline_buf will be released in kexec_file_load, so copy to
>> +                * the KEXEC_CMDLINE_ADDR safe area.
>> +                */
>> +               memcpy((void *)KEXEC_CMDLINE_ADDR, (void *)kimage->arch.cmdline_ptr,
>> +                                       strlen((char *)kimage->arch.cmdline_ptr) + 1);
>> +               kimage->arch.cmdline_ptr = (unsigned long)KEXEC_CMDLINE_ADDR;
>> +       } else {
>> +               /* Find the command line */
>> +               for (i = 0; i < kimage->nr_segments; i++) {
>> +                       if (!strncmp(bootloader, (char __user *)kimage->segment[i].buf, strlen(bootloader))) {
>> +                               if (!copy_from_user(cmdline_ptr, kimage->segment[i].buf, COMMAND_LINE_SIZE))
>> +                                       kimage->arch.cmdline_ptr = (unsigned long)cmdline_ptr;
>> +                               break;
>> +                       }
>>                  }
>> -       }
>>
>> -       if (!kimage->arch.cmdline_ptr) {
>> -               pr_err("Command line not included in the provided image\n");
>> -               return -EINVAL;
>> +               if (!kimage->arch.cmdline_ptr) {
>> +                       pr_err("Command line not included in the provided image\n");
>> +                       return -EINVAL;
>> +               }
>>          }
>>
>>          /* kexec/kdump need a safe page to save reboot_code_buffer */
>> @@ -288,7 +298,8 @@ void machine_kexec(struct kimage *image)
>>          local_irq_disable();
>>
>>          pr_notice("EFI boot flag 0x%lx\n", efi_boot);
>> -       pr_notice("Command line at 0x%lx\n", cmdline_ptr);
>> +       pr_notice("Command line addr at 0x%lx\n", cmdline_ptr);
>> +       pr_notice("Command line at %s\n", (char *)cmdline_ptr);
>>          pr_notice("System table at 0x%lx\n", systable_ptr);
>>          pr_notice("We will call new kernel at 0x%lx\n", start_addr);
>>          pr_notice("Bye ...\n");
>> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
>> new file mode 100644
>> index 000000000000..bc91ae0afa4c
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/machine_kexec_file.c
>> @@ -0,0 +1,46 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * kexec_file for LoongArch
>> + *
>> + * Author: Youling Tang <tangyouling@kylinos.cn>
>> + * Copyright (C) 2025 KylinSoft Corporation.
>> + *
>> + * Most code is derived from LoongArch port of kexec-tools
>> + */
>> +
>> +#define pr_fmt(fmt) "kexec_file: " fmt
>> +
>> +#include <linux/ioport.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/memblock.h>
>> +#include <linux/slab.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +#include <linux/vmalloc.h>
>> +#include <asm/bootinfo.h>
>> +
>> +const struct kexec_file_ops * const kexec_file_loaders[] = {
>> +       &kexec_image_ops,
>> +       NULL
>> +};
>> +
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image)
>> +{
>> +       vfree(image->elf_headers);
>> +       image->elf_headers = NULL;
>> +       image->elf_headers_sz = 0;
>> +
>> +       return kexec_image_post_load_cleanup_default(image);
>> +}
>> +
>> +int load_other_segments(struct kimage *image,
>> +                       unsigned long kernel_load_addr,
>> +                       unsigned long kernel_size,
>> +                       char *initrd, unsigned long initrd_len,
>> +                       char *cmdline, unsigned long cmdline_len)
>> +{
>> +       image->arch.cmdline_ptr = (unsigned long)cmdline;
>> +
>> +       return 0;
>> +}
>> --
>> 2.34.1
>>


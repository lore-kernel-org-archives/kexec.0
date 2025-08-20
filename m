Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F56CA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 11:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qET9NVoC8Ivw6LjkGN1aM+rtYCdDUjxDAQ3QE6geFrw=; b=4zxROVA+SKSp2YVPlIAVAGdZ9b
	j6YY1EqwuJJVWxwwcJu7WsZ0kU8pIB7fpyMs8688F2Kuxd4UxPgDRPCtffcUoRFMnxYyGbYcV69yx
	iCizM/+d1/4mU+/gxB1oEEdheXe7CUhFU/2lFXM1EJ43/wRegeMHNqSDu5BY5DYZ2bBhG9+phlQhV
	dcGpJ4mID2vHR0kpbgRngStoo116X2v/UsgkAakT2wU1hPOxINA3CMNExXi+akp1cITW84AjvoAIM
	GBXbERxNKgcXnAKPqEiOKGmI2eidm0C0rx7ROgFnvanfwG0QEPsb/8kgyVfI9PsmEa9pWpwaXeze+
	6M4qL5bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uogbz-0000000DHlU-2wcK;
	Wed, 20 Aug 2025 11:04:11 +0000
Received: from out-182.mta1.migadu.com ([95.215.58.182])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoeti-0000000Cs9T-3kjC
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 09:14:25 +0000
Message-ID: <5f6eeefb-681a-424e-9a6b-2e91eaf87571@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755681259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qET9NVoC8Ivw6LjkGN1aM+rtYCdDUjxDAQ3QE6geFrw=;
	b=DXSH0R6iC5c75evVqUs/LLCUqop9cqZE6HCKgH5lrP+cdLg52YmjXCgr3xqGL9Ku4hSh9t
	gG2Gac0eQZnVfAWcxcTqRUfv46R2hxvo9b4NMVrCErMCg36motPm9mmy1tox2chEPAOXYo
	GJFzhapmcqr6zhoQZTWomq8INKUEquI=
Date: Wed, 20 Aug 2025 17:13:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/5] LoongArch: Add kexec_file support
To: Yao Zi <ziyao@disroot.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>
References: <20250820055700.24344-1-youling.tang@linux.dev>
 <20250820055700.24344-3-youling.tang@linux.dev> <aKVwHOM9KNEpUZF4@pie>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <aKVwHOM9KNEpUZF4@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_021423_146659_A23C075A 
X-CRM114-Status: GOOD (  36.85  )
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

Hi, Yao

On 2025/8/20 14:50, Yao Zi wrote:

> On Wed, Aug 20, 2025 at 01:56:57PM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> This patch adds support for kexec_file on LoongArch.
>>
>> The efi_kexec_load() as two parts:
>> - the first part loads the kernel image (vmlinuz.efi or vmlinux.efi)
>> - the second part loads other segments (eg: initrd, cmdline)
>>
>> This initrd will be passed to the second kernel via the command line
>> 'initrd=start,size'.
>>
>> Currently, pez(vmlinuz.efi) and pei(vmlinux.efi) format images are supported,
>> but ELF format is not supported.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   arch/loongarch/Kconfig                     |   9 ++
>>   arch/loongarch/include/asm/image.h         |  17 +++
>>   arch/loongarch/include/asm/kexec.h         |  12 +++
>>   arch/loongarch/kernel/Makefile             |   1 +
>>   arch/loongarch/kernel/kexec_efi.c          | 111 +++++++++++++++++++
>>   arch/loongarch/kernel/machine_kexec.c      |  33 ++++--
>>   arch/loongarch/kernel/machine_kexec_file.c | 117 +++++++++++++++++++++
>>   7 files changed, 289 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/loongarch/kernel/kexec_efi.c
>>   create mode 100644 arch/loongarch/kernel/machine_kexec_file.c
> ...
>
>> diff --git a/arch/loongarch/include/asm/image.h b/arch/loongarch/include/asm/image.h
>> index 1f090736e71d..655d5836c4e8 100644
>> --- a/arch/loongarch/include/asm/image.h
>> +++ b/arch/loongarch/include/asm/image.h
>> @@ -36,5 +36,22 @@ struct loongarch_image_header {
>>   	uint32_t pe_header;
>>   };
>>   
>> +static const uint8_t loongarch_image_pe_sig[2] = {'M', 'Z'};
>> +
>> +/**
>> + * loongarch_header_check_pe_sig - Helper to check the loongarch image header.
>> + *
>> + * Returns non-zero if 'MZ' signature is found.
>> + */
>> +
>> +static inline int loongarch_header_check_pe_sig(const struct loongarch_image_header *h)
>> +{
>> +	if (!h)
>> +		return 0;
>> +
>> +	return (h->pe_sig[0] == loongarch_image_pe_sig[0]
>> +		&& h->pe_sig[1] == loongarch_image_pe_sig[1]);
>> +}
> This check is still too weak and doesn't improve comparing to v1.
>
>> This could be simplified with a memcmp(). Also, this check isn't
>> strict enough: PE files for any architectures, and even legacy MS-DOS
>> COM executables all start with "MZ".
> I've pointed this out in my previous reply[1].
Previously, I had considered adding a specific LoongArch magic
number (such as "Loongson") in the loongarch_image_header, but
this is incompatible with older versions of the kernel, so it
remains the same without further checks.
>
>>   #endif /* __ASSEMBLY__ */
>>   #endif /* __ASM_IMAGE_H */
> ...
>
>> diff --git a/arch/loongarch/kernel/kexec_efi.c b/arch/loongarch/kernel/kexec_efi.c
>> new file mode 100644
>> index 000000000000..7741f1139a12
>> --- /dev/null
>> +++ b/arch/loongarch/kernel/kexec_efi.c
> ...
>
>> +static void *efi_kexec_load(struct kimage *image,
>> +				char *kernel, unsigned long kernel_len,
>> +				char *initrd, unsigned long initrd_len,
>> +				char *cmdline, unsigned long cmdline_len)
>> +{
>> +	struct loongarch_image_header *h;
>> +	struct kexec_buf kbuf;
>> +	unsigned long text_offset, kernel_segment_number;
>> +	struct kexec_segment *kernel_segment;
>> +	int ret;
>> +
>> +	h = (struct loongarch_image_header *)kernel;
>> +	if (!h->image_size)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/* Load the kernel */
>> +	kbuf.image = image;
>> +	kbuf.buf_max = ULONG_MAX;
>> +	kbuf.top_down = false;
>> +
>> +	kbuf.buffer = kernel;
>> +	kbuf.bufsz = kernel_len;
>> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	kbuf.memsz = le64_to_cpu(h->image_size);
>> +	text_offset = le64_to_cpu(h->text_offset);
>> +	kbuf.buf_min = text_offset;
>> +	kbuf.buf_align = SZ_2M;
>> +
>> +	kernel_segment_number = image->nr_segments;
>> +
>> +	/*
>> +	 * The location of the kernel segment may make it impossible to satisfy
>> +	 * the other segment requirements, so we try repeatedly to find a
>> +	 * location that will work.
>> +	 */
>> +	while ((ret = kexec_add_buffer(&kbuf)) == 0) {
>> +		/* Try to load additional data */
>> +		kernel_segment = &image->segment[kernel_segment_number];
>> +		ret = load_other_segments(image, kernel_segment->mem,
>> +					  kernel_segment->memsz, initrd,
>> +					  initrd_len, cmdline, cmdline_len);
>> +		if (!ret)
>> +			break;
>> +
>> +		/*
>> +		 * We couldn't find space for the other segments; erase the
>> +		 * kernel segment and try the next available hole.
>> +		 */
>> +		image->nr_segments -= 1;
>> +		kbuf.buf_min = kernel_segment->mem + kernel_segment->memsz;
>> +		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +	}
>> +
>> +	if (ret) {
>> +		pr_err("Could not find any suitable kernel location!");
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	kernel_segment = &image->segment[kernel_segment_number];
>> +
>> +	/* Make sure the second kernel jumps to the correct "kernel_entry". */
>> +	image->start = kernel_segment->mem + h->kernel_entry - text_offset;
> And this still assumes the loaded, secondary kernel is relocatable,
> with neither extra check nor comment explaining its limitation.
>
> Please see my previous reply[2] that explains why loading a
> non-relocatble kernel with kexec_file API is reasonable.
LoongArch is a non-position independent (non-PIE) kernel when
the RELOCATABLE option is not enabled, the kernel contains certain
instructions such as la.abs, which prevent it from being relocated to
arbitrary memory addresses for execution. As a result, limitations
exist that make features like kdump or kexec_file dependent on
the RELOCATABLE option.

Strictly speaking, we need to add additional checks: if the kernel is
non-relocatable, the loading operation should fail directly. For a
running kernel, we can easily determine this by calling
kallsyms_lookup_name("relocate_kernel"). However, for a kernel
that is being loaded but has not yet started execution, it is difficult
to easily determine whether the currently loaded kernel has the
RELOCATABLE configuration option enabled.

For ELF format images, we can determine whether the loaded image
contains the ".la_abs" section in the following way:
static struct mem_shdr *laabs_section(const struct mem_ehdr *ehdr)
{
         struct mem_shdr *shdr, *shdr_end;
         unsigned char *strtab;

         strtab = (unsigned char *)ehdr->e_shdr[ehdr->e_shstrndx].sh_data;
         shdr_end = &ehdr->e_shdr[ehdr->e_shnum];
         for (shdr = ehdr->e_shdr; shdr != shdr_end; shdr++) {
                 if (shdr->sh_size &&
                         strcmp((char *)&strtab[shdr->sh_name], 
".la_abs") == 0) {
                         return shdr;
                 }
         }

         return NULL;
}

Thanks,
Youling.
>
>> +	kexec_dprintk("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +		      kernel_segment->mem, kbuf.bufsz,
>> +		      kernel_segment->memsz);
>> +
>> +	return NULL;
>> +}
>> +
>> +const struct kexec_file_ops kexec_efi_ops = {
>> +	.probe = efi_kexec_probe,
>> +	.load = efi_kexec_load,
>> +};
> Thanks,
> Yao Zi
>
> [1]: https://lore.kernel.org/all/aJojDiHWi8cgvA2W@pie/
> [2]: https://lore.kernel.org/all/aJwFa8x5BQMouB1y@pie/


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89135ECAAD5
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 02:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kzw6B81T2giwmtaf7p8PdLCFMMu5HS5DZrY3y7wzR/I=; b=V0eZ+Ri8FRVuKY
	bZ5HUTUVjDi11Uf75UovpK93G7JvAnDmPKAIYJ3HyMRr7hecgqYc7fkzNHi7D3POOc2wu1QJCVY85
	6TDNfl4JlFmYZO0/KyXRMzjUMs63FnjhnCycc46Y5RsoBWjixyCWN0aBpNfZk7RYdkDq7EomyOn38
	9r7T3jB/AL185YhkBEVYDBVX2iaX7pa0hq4LxK4QwcMqsL8tU9UAo/ack+P4Uh1oYp+RgDS6bDvLv
	PhF/f6F8NuvmmyKTZaub5OYrTj/S2hA8hZWeZ3H9mhzLrywZbXdPHZvyI8xS8rCytkTp985q2JmQ8
	FKhqsuF6vBnAM8o/Ch8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTDok-003KKm-1F; Wed, 31 Aug 2022 02:51:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTDog-003KJU-0j
	for kexec@lists.infradead.org; Wed, 31 Aug 2022 02:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661914256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9I0C4e+VVn0o0q8ciL18IhupcMfqpgdsCo10tdjY7jU=;
	b=Ib+m+PNJTFTBBB5X6DzkniXV5WBejQU5F/XXm9244oWqjd13Mv92CE9QtELupZ7UazDhAn
	ZdKICacMBImZTKWSUYC51iy4W055PzTrrQbhE0SlkZZZu4suioZoKYao4rORa/4Q0azLmh
	6GO/z4d/PwKlCgWyduh0HsZ/0UjaO1g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-C2FAifgcMmqorM936gQpQw-1; Tue, 30 Aug 2022 22:50:50 -0400
X-MC-Unique: C2FAifgcMmqorM936gQpQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1536801231;
	Wed, 31 Aug 2022 02:50:49 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C57F141511A;
	Wed, 31 Aug 2022 02:50:48 +0000 (UTC)
Date: Wed, 31 Aug 2022 10:50:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v11 1/7] crash: move crash_prepare_elf64_headers
Message-ID: <Yw7MhU957+cPQ50/@MiWiFi-R3L-srv>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-2-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220826173704.1895-2-eric.devolder@oracle.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_195058_164394_A682A6C0 
X-CRM114-Status: GOOD (  27.19  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 08/26/22 at 01:36pm, Eric DeVolder wrote:
> At the outcome of this patch set, the crash_prepare_elf64_headers()
> is utilized on both the kexec_file_load and kexec_load paths. As
> such, need to move this function out of kexec_file.c and into a
> common location crash_core.c.
> 
> No functionality change.
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>

LGTM,

Baoquan He <bhe@redhat.com>

> ---
>  kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_file.c |  99 -------------------------------------------
>  2 files changed, 100 insertions(+), 99 deletions(-)
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 07b26df453a9..8c8c82386e8d 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sizes.h>
> +#include <linux/kexec.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>  }
>  early_param("crashkernel", parse_crashkernel_dummy);
>  
> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> +			  void **addr, unsigned long *sz)
> +{
> +	Elf64_Ehdr *ehdr;
> +	Elf64_Phdr *phdr;
> +	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> +	unsigned char *buf;
> +	unsigned int cpu, i;
> +	unsigned long long notes_addr;
> +	unsigned long mstart, mend;
> +
> +	/* extra phdr for vmcoreinfo ELF note */
> +	nr_phdr = nr_cpus + 1;
> +	nr_phdr += mem->nr_ranges;
> +
> +	/*
> +	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> +	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
> +	 * I think this is required by tools like gdb. So same physical
> +	 * memory will be mapped in two ELF headers. One will contain kernel
> +	 * text virtual addresses and other will have __va(physical) addresses.
> +	 */
> +
> +	nr_phdr++;
> +	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
> +	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
> +
> +	buf = vzalloc(elf_sz);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ehdr = (Elf64_Ehdr *)buf;
> +	phdr = (Elf64_Phdr *)(ehdr + 1);
> +	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> +	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
> +	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> +	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> +	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
> +	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
> +	ehdr->e_type = ET_CORE;
> +	ehdr->e_machine = ELF_ARCH;
> +	ehdr->e_version = EV_CURRENT;
> +	ehdr->e_phoff = sizeof(Elf64_Ehdr);
> +	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
> +	ehdr->e_phentsize = sizeof(Elf64_Phdr);
> +
> +	/* Prepare one phdr of type PT_NOTE for each present CPU */
> +	for_each_present_cpu(cpu) {
> +		phdr->p_type = PT_NOTE;
> +		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> +		phdr->p_offset = phdr->p_paddr = notes_addr;
> +		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
> +		(ehdr->e_phnum)++;
> +		phdr++;
> +	}
> +
> +	/* Prepare one PT_NOTE header for vmcoreinfo */
> +	phdr->p_type = PT_NOTE;
> +	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
> +	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> +	(ehdr->e_phnum)++;
> +	phdr++;
> +
> +	/* Prepare PT_LOAD type program header for kernel text region */
> +	if (need_kernel_map) {
> +		phdr->p_type = PT_LOAD;
> +		phdr->p_flags = PF_R|PF_W|PF_X;
> +		phdr->p_vaddr = (unsigned long) _text;
> +		phdr->p_filesz = phdr->p_memsz = _end - _text;
> +		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> +		ehdr->e_phnum++;
> +		phdr++;
> +	}
> +
> +	/* Go through all the ranges in mem->ranges[] and prepare phdr */
> +	for (i = 0; i < mem->nr_ranges; i++) {
> +		mstart = mem->ranges[i].start;
> +		mend = mem->ranges[i].end;
> +
> +		phdr->p_type = PT_LOAD;
> +		phdr->p_flags = PF_R|PF_W|PF_X;
> +		phdr->p_offset  = mstart;
> +
> +		phdr->p_paddr = mstart;
> +		phdr->p_vaddr = (unsigned long) __va(mstart);
> +		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> +		phdr->p_align = 0;
> +		ehdr->e_phnum++;
> +		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> +			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> +			ehdr->e_phnum, phdr->p_offset);
> +		phdr++;
> +	}
> +
> +	*addr = buf;
> +	*sz = elf_sz;
> +	return 0;
> +}
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 1d546dc97c50..8017eeb43036 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -1217,102 +1217,3 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  	mem->nr_ranges++;
>  	return 0;
>  }
> -
> -int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
> -			  void **addr, unsigned long *sz)
> -{
> -	Elf64_Ehdr *ehdr;
> -	Elf64_Phdr *phdr;
> -	unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
> -	unsigned char *buf;
> -	unsigned int cpu, i;
> -	unsigned long long notes_addr;
> -	unsigned long mstart, mend;
> -
> -	/* extra phdr for vmcoreinfo ELF note */
> -	nr_phdr = nr_cpus + 1;
> -	nr_phdr += mem->nr_ranges;
> -
> -	/*
> -	 * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
> -	 * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
> -	 * I think this is required by tools like gdb. So same physical
> -	 * memory will be mapped in two ELF headers. One will contain kernel
> -	 * text virtual addresses and other will have __va(physical) addresses.
> -	 */
> -
> -	nr_phdr++;
> -	elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
> -	elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
> -
> -	buf = vzalloc(elf_sz);
> -	if (!buf)
> -		return -ENOMEM;
> -
> -	ehdr = (Elf64_Ehdr *)buf;
> -	phdr = (Elf64_Phdr *)(ehdr + 1);
> -	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
> -	ehdr->e_ident[EI_CLASS] = ELFCLASS64;
> -	ehdr->e_ident[EI_DATA] = ELFDATA2LSB;
> -	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
> -	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
> -	memset(ehdr->e_ident + EI_PAD, 0, EI_NIDENT - EI_PAD);
> -	ehdr->e_type = ET_CORE;
> -	ehdr->e_machine = ELF_ARCH;
> -	ehdr->e_version = EV_CURRENT;
> -	ehdr->e_phoff = sizeof(Elf64_Ehdr);
> -	ehdr->e_ehsize = sizeof(Elf64_Ehdr);
> -	ehdr->e_phentsize = sizeof(Elf64_Phdr);
> -
> -	/* Prepare one phdr of type PT_NOTE for each present CPU */
> -	for_each_present_cpu(cpu) {
> -		phdr->p_type = PT_NOTE;
> -		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
> -		phdr->p_offset = phdr->p_paddr = notes_addr;
> -		phdr->p_filesz = phdr->p_memsz = sizeof(note_buf_t);
> -		(ehdr->e_phnum)++;
> -		phdr++;
> -	}
> -
> -	/* Prepare one PT_NOTE header for vmcoreinfo */
> -	phdr->p_type = PT_NOTE;
> -	phdr->p_offset = phdr->p_paddr = paddr_vmcoreinfo_note();
> -	phdr->p_filesz = phdr->p_memsz = VMCOREINFO_NOTE_SIZE;
> -	(ehdr->e_phnum)++;
> -	phdr++;
> -
> -	/* Prepare PT_LOAD type program header for kernel text region */
> -	if (need_kernel_map) {
> -		phdr->p_type = PT_LOAD;
> -		phdr->p_flags = PF_R|PF_W|PF_X;
> -		phdr->p_vaddr = (unsigned long) _text;
> -		phdr->p_filesz = phdr->p_memsz = _end - _text;
> -		phdr->p_offset = phdr->p_paddr = __pa_symbol(_text);
> -		ehdr->e_phnum++;
> -		phdr++;
> -	}
> -
> -	/* Go through all the ranges in mem->ranges[] and prepare phdr */
> -	for (i = 0; i < mem->nr_ranges; i++) {
> -		mstart = mem->ranges[i].start;
> -		mend = mem->ranges[i].end;
> -
> -		phdr->p_type = PT_LOAD;
> -		phdr->p_flags = PF_R|PF_W|PF_X;
> -		phdr->p_offset  = mstart;
> -
> -		phdr->p_paddr = mstart;
> -		phdr->p_vaddr = (unsigned long) __va(mstart);
> -		phdr->p_filesz = phdr->p_memsz = mend - mstart + 1;
> -		phdr->p_align = 0;
> -		ehdr->e_phnum++;
> -		pr_debug("Crash PT_LOAD ELF header. phdr=%p vaddr=0x%llx, paddr=0x%llx, sz=0x%llx e_phnum=%d p_offset=0x%llx\n",
> -			phdr, phdr->p_vaddr, phdr->p_paddr, phdr->p_filesz,
> -			ehdr->e_phnum, phdr->p_offset);
> -		phdr++;
> -	}
> -
> -	*addr = buf;
> -	*sz = elf_sz;
> -	return 0;
> -}
> -- 
> 2.31.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

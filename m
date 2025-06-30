Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73406C8302D
	for <kexec@archiver.kernel.org>; Mon, 30 Jun 2025 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSER/kKr09Fwp9Z6FAD98av39gXaDcNtylfht9QBtAY=; b=aMk/Zj4bSbS45/kG4VMCq4UqIZ
	mrswR1srO9jhwL4rN3rER0CRs3Xk4iEVmoanHxW/b21eAiZB9mrAV/G/C5o/j27fYufudP6kTFsUU
	zvmEDDhWCKmMJyb8xTOJ4LsEwjt1sE2j4T1GbGIb5/rx4wOEwhcLzYIHaauVyPbvPdKArNUo5rdEN
	0jV1W+jLENQ4e0RB9SgQvlpttWPaM7hu8sL3N3KAxNPKxWL36GhwMWc1mpDpjWQHImaPEr0eulmOB
	yiZf+BbQdmThoHnn6SLi2LdhxcWYV8KwZJOXBtRFWrTTad482Rq6tggFK/FRoIAl0VPDzT4UnXunD
	VDwH74nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWDrK-00000002E8e-1vsc;
	Mon, 30 Jun 2025 12:43:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWDoO-00000002DWp-2HhS
	for kexec@lists.infradead.org;
	Mon, 30 Jun 2025 12:40:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751287238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSER/kKr09Fwp9Z6FAD98av39gXaDcNtylfht9QBtAY=;
	b=I2As0GlwQTTJ62PAq5upml/P3KB/vYEq1lA5nUCZJL9611498Jr4MRY7jUeGuZbr7hAbb2
	lpkfFJ3V1uR+nOUN7xMZTB9TQEASqkvzTc/G6Q2kvfL3Z9GWcNijLcLsX+2OFzUTEuwV2T
	zFk9POCl8hkeiq2RoXiOQF+xF5p+gjs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-oTGT0iEhMlqriOp8T1-kGQ-1; Mon,
 30 Jun 2025 08:40:34 -0400
X-MC-Unique: oTGT0iEhMlqriOp8T1-kGQ-1
X-Mimecast-MFC-AGG-ID: oTGT0iEhMlqriOp8T1-kGQ_1751287232
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B0681809CBD;
	Mon, 30 Jun 2025 12:40:31 +0000 (UTC)
Received: from localhost (unknown [10.72.112.34])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71DC91956095;
	Mon, 30 Jun 2025 12:40:28 +0000 (UTC)
Date: Mon, 30 Jun 2025 20:40:25 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: kexec@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, bpf@vger.kernel.org
Subject: Re: [PATCHv3 8/9] kexec: Integrate bpf light skeleton to load zboot
 image
Message-ID: <aGKFuTAS-mBpYngE@fedora>
References: <20250529041744.16458-1-piliu@redhat.com>
 <20250529041744.16458-9-piliu@redhat.com>
 <20250625201011.1eab16a5@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625201011.1eab16a5@rotkaeppchen>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_054040_663185_9076F9BB 
X-CRM114-Status: GOOD (  36.35  )
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

On Wed, Jun 25, 2025 at 08:10:11PM +0200, Philipp Rudo wrote:
> Hi Pingfan,
> 
> On Thu, 29 May 2025 12:17:43 +0800
> Pingfan Liu <piliu@redhat.com> wrote:
> 
> > All kexec PE bpf prog should align with the interface exposed by the
> > light skeleton
> >     four maps:
> >                     struct bpf_map_desc ringbuf_1;
> >                     struct bpf_map_desc ringbuf_2;
> >                     struct bpf_map_desc ringbuf_3;
> >                     struct bpf_map_desc ringbuf_4;
> >     four sections:
> >                     struct bpf_map_desc rodata;
> >                     struct bpf_map_desc data;
> >                     struct bpf_map_desc bss;
> >                     struct bpf_map_desc rodata_str1_1;
> >     two progs:
> >             SEC("fentry.s/bpf_handle_pefile")
> >             SEC("fentry.s/bpf_post_handle_pefile")
> > 
> > With the above presumption, the integration consists of two parts:
> >   -1. Call API exposed by light skeleton from kexec
> >   -2. The opts_insn[] and opts_data[] are bpf-prog dependent and
> >       can be extracted and passed in from the user space. In the
> >       kexec_file_load design, a PE file has a .bpf section, which data
> >       content is a ELF, and the ELF contains opts_insn[] opts_data[].
> >       As a bonus, BPF bytecode can be placed under the protection of the
> >       entire PE signature.
> >       (Note, since opts_insn[] contains the information of the ringbuf
> >        size, the bpf-prog writer can change its proper size according to
> >        the kernel image size without modifying the kernel code)
> > 
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Philipp Rudo <prudo@redhat.com>
> > Cc: bpf@vger.kernel.org
> > To: kexec@lists.infradead.org
> > ---
> >  kernel/Makefile                              |   1 +
> >  kernel/kexec_bpf/Makefile                    |   8 +
> >  kernel/kexec_bpf/kexec_pe_parser_bpf.lskel.h | 292 +------------------
> >  kernel/kexec_pe_image.c                      |  70 +++++
> >  4 files changed, 83 insertions(+), 288 deletions(-)
> > 
> [...]
> 
> > diff --git a/kernel/kexec_pe_image.c b/kernel/kexec_pe_image.c
> > index e49d6db3c329d..f47c1e46dba97 100644
> > --- a/kernel/kexec_pe_image.c
> > +++ b/kernel/kexec_pe_image.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/kexec.h>
> > +#include <linux/elf.h>
> >  #include <linux/pe.h>
> >  #include <linux/string.h>
> >  #include <linux/bpf.h>
> > @@ -21,6 +22,7 @@
> >  #include <asm/image.h>
> >  #include <asm/memory.h>
> >  
> > +#include "kexec_bpf/kexec_pe_parser_bpf.lskel.h"
> >  
> >  static LIST_HEAD(phase_head);
> >  
> > @@ -163,14 +165,82 @@ static bool pe_has_bpf_section(char *file_buf, unsigned long pe_sz)
> >  	return true;
> >  }
> >  
> > +static struct kexec_pe_parser_bpf *pe_parser;
> > +
> > +static void *get_symbol_from_elf(const char *elf_data, size_t elf_size,
> > +		const char *symbol_name, unsigned int *symbol_size)
> > +{
> > +	Elf_Ehdr *ehdr = (Elf_Ehdr *)elf_data;
> > +	Elf_Shdr *shdr, *symtab_shdr, *strtab_shdr, *dst_shdr;
> > +	Elf64_Sym *sym, *symtab = NULL;
> > +	char *strtab = NULL;
> > +	void *symbol_data = NULL;
> > +	int i;
> > +
> > +	symtab_shdr = strtab_shdr = NULL;
> > +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) != 0) {
> > +		pr_err("Not a valid ELF file\n");
> > +		goto out;
> > +	}
> > +
> > +	shdr = (struct elf_shdr *)(elf_data + ehdr->e_shoff);
> > +	for (i = 0; i < ehdr->e_shnum; i++) {
> > +		if (shdr[i].sh_type == SHT_SYMTAB)
> > +			symtab_shdr = &shdr[i];
> > +		else if (shdr[i].sh_type == SHT_STRTAB && i != ehdr->e_shstrndx)
> > +			strtab_shdr = &shdr[i];
> > +	}
> > +
> > +	if (!symtab_shdr || !strtab_shdr) {
> > +		pr_err("Symbol table or string table not found\n");
> > +		goto out;
> > +	}
> > +	symtab = (Elf64_Sym *)(elf_data + symtab_shdr->sh_offset);
> > +	strtab = (char *)(elf_data + strtab_shdr->sh_offset);
> > +	for (i = 0; i < symtab_shdr->sh_size / sizeof(Elf64_Sym); i++) {
> > +		sym = &symtab[i];
> > +		if (strcmp(&strtab[sym->st_name], symbol_name) == 0) {
> > +			if (sym->st_shndx >= SHN_LORESERVE)
> > +				return NULL; // No section data for these
> > +			dst_shdr = &shdr[sym->st_shndx];
> > +			symbol_data = (void *)(elf_data + dst_shdr->sh_offset + sym->st_value);
> > +			*symbol_size = symtab[i].st_size;
> > +			break;
> > +		}
> > +	}
> > +
> > +out:
> > +	return symbol_data;
> > +}
> 
> In kernel/kexec_file.c there is kexec_purgatory_find_symbol which is
> basically identical to this function. With a little bit of refractoring
> it should work for both cases. I prefer using
> kexec_purgatory_find_symbol as your implementation cannot handle elf
> files with multiple symtab and strtab sections.
> 

Thanks for your suggestion. I will refractor the code in next version.

Regards,

Pingfan 

> Thanks
> Philipp
> 
> > +
> >  /* Load a ELF */
> >  static int arm_bpf_prog(char *bpf_elf, unsigned long sz)
> >  {
> > +	opts_data = get_symbol_from_elf(bpf_elf, sz, "opts_data", &opts_data_sz);
> > +	opts_insn = get_symbol_from_elf(bpf_elf, sz, "opts_insn", &opts_insn_sz);
> > +	if (!opts_data || !opts_insn)
> > +		return -1;
> > +	/*
> > +	 * When light skeleton generates opts_data[] and opts_insn[], it appends a
> > +	 * NULL terminator at the end of string
> > +	 */
> > +	opts_data_sz = opts_data_sz - 1;
> > +	opts_insn_sz = opts_insn_sz - 1;
> > +
> > +	pe_parser = kexec_pe_parser_bpf__open_and_load();
> > +	if (!pe_parser)
> > +		return -1;
> > +	kexec_pe_parser_bpf__attach(pe_parser);
> > +
> >  	return 0;
> >  }
> >  
> >  static void disarm_bpf_prog(void)
> >  {
> > +	kexec_pe_parser_bpf__destroy(pe_parser);
> > +	pe_parser = NULL;
> > +	opts_data = NULL;
> > +	opts_insn = NULL;
> >  }
> >  
> >  struct kexec_context {
> 



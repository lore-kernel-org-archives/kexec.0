Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81167C02184
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8dqgwESPx9R9DWrPKarf13obRDixoLP/xCqeJ+xU0U=; b=Le0KE7o0kGtnK1EwrLX4nVNKSA
	vQAtYgtEEJB/SiomUjDCdeWlKsIXS4T9eXKaamCBxrIybA/dyBh4vqc0qGEIGVbFLQCxYHbPPx3LB
	kafLPXOjziqi09Vj3RN6I8E3+C/ntG50uxDMf0MAyemGKzBlZGQSJaq3VXl2kbJ6nXib6jbTIt/5O
	KXvch83cw2AOAvzH+zSjwa5nSY8mfxzGqvjCOdHLG+byK5Tqw4taGpNDTXwY1macad9lf6E/YhXZL
	GecFKNQgiPwgub7p/kMeaoGlQqCF6cOgGdUuKPyPfycKq0pvyOPDVY84vq4r+mByoBE+HI9CLQr9W
	6h/x9CxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfxG-00000008Nme-18eu;
	Tue, 14 Jan 2025 12:23:34 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfxD-00000008NlD-3eE3
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:23:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDB2511FB;
	Tue, 14 Jan 2025 04:23:59 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0623F66E;
	Tue, 14 Jan 2025 04:23:28 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v4 5/6] s390/crash: Use note name macros
Message-ID: <Z4ZXPp76UiLtBCLA@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-5-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-5-b3841fa0dcd9@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_042331_994995_67D1651F 
X-CRM114-Status: GOOD (  18.15  )
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

Hi,

On Sat, Jan 11, 2025 at 02:48:48PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(I'm not in a position to test this, though.)

> ---
>  arch/s390/kernel/crash_dump.c | 62 ++++++++++++++++---------------------------
>  1 file changed, 23 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
> index cd0c93a8fb8b..022f4f198edf 100644
> --- a/arch/s390/kernel/crash_dump.c
> +++ b/arch/s390/kernel/crash_dump.c
> @@ -248,15 +248,6 @@ bool is_kdump_kernel(void)
>  }
>  EXPORT_SYMBOL_GPL(is_kdump_kernel);
>  
> -static const char *nt_name(Elf64_Word type)
> -{
> -	const char *name = "LINUX";
> -
> -	if (type == NT_PRPSINFO || type == NT_PRSTATUS || type == NT_PRFPREG)
> -		name = KEXEC_CORE_NOTE_NAME;
> -	return name;
> -}
> -
>  /*
>   * Initialize ELF note
>   */
> @@ -281,10 +272,8 @@ static void *nt_init_name(void *buf, Elf64_Word type, void *desc, int d_len,
>  	return PTR_ADD(buf, len);
>  }
>  
> -static inline void *nt_init(void *buf, Elf64_Word type, void *desc, int d_len)
> -{
> -	return nt_init_name(buf, type, desc, d_len, nt_name(type));
> -}
> +#define nt_init(buf, type, desc) \
> +	nt_init_name(buf, NT_ ## type, &(desc), sizeof(desc), NN_ ## type)
>  
>  /*
>   * Calculate the size of ELF note
> @@ -300,10 +289,7 @@ static size_t nt_size_name(int d_len, const char *name)
>  	return size;
>  }
>  
> -static inline size_t nt_size(Elf64_Word type, int d_len)
> -{
> -	return nt_size_name(d_len, nt_name(type));
> -}
> +#define nt_size(type, desc) nt_size_name(sizeof(desc), NN_ ## type)
>  
>  /*
>   * Fill ELF notes for one CPU with save area registers
> @@ -324,18 +310,16 @@ static void *fill_cpu_elf_notes(void *ptr, int cpu, struct save_area *sa)
>  	memcpy(&nt_fpregset.fpc, &sa->fpc, sizeof(sa->fpc));
>  	memcpy(&nt_fpregset.fprs, &sa->fprs, sizeof(sa->fprs));
>  	/* Create ELF notes for the CPU */
> -	ptr = nt_init(ptr, NT_PRSTATUS, &nt_prstatus, sizeof(nt_prstatus));
> -	ptr = nt_init(ptr, NT_PRFPREG, &nt_fpregset, sizeof(nt_fpregset));
> -	ptr = nt_init(ptr, NT_S390_TIMER, &sa->timer, sizeof(sa->timer));
> -	ptr = nt_init(ptr, NT_S390_TODCMP, &sa->todcmp, sizeof(sa->todcmp));
> -	ptr = nt_init(ptr, NT_S390_TODPREG, &sa->todpreg, sizeof(sa->todpreg));
> -	ptr = nt_init(ptr, NT_S390_CTRS, &sa->ctrs, sizeof(sa->ctrs));
> -	ptr = nt_init(ptr, NT_S390_PREFIX, &sa->prefix, sizeof(sa->prefix));
> +	ptr = nt_init(ptr, PRSTATUS, nt_prstatus);
> +	ptr = nt_init(ptr, PRFPREG, nt_fpregset);
> +	ptr = nt_init(ptr, S390_TIMER, sa->timer);
> +	ptr = nt_init(ptr, S390_TODCMP, sa->todcmp);
> +	ptr = nt_init(ptr, S390_TODPREG, sa->todpreg);
> +	ptr = nt_init(ptr, S390_CTRS, sa->ctrs);
> +	ptr = nt_init(ptr, S390_PREFIX, sa->prefix);
>  	if (cpu_has_vx()) {
> -		ptr = nt_init(ptr, NT_S390_VXRS_HIGH,
> -			      &sa->vxrs_high, sizeof(sa->vxrs_high));
> -		ptr = nt_init(ptr, NT_S390_VXRS_LOW,
> -			      &sa->vxrs_low, sizeof(sa->vxrs_low));
> +		ptr = nt_init(ptr, S390_VXRS_HIGH, sa->vxrs_high);
> +		ptr = nt_init(ptr, S390_VXRS_LOW, sa->vxrs_low);
>  	}
>  	return ptr;
>  }
> @@ -348,16 +332,16 @@ static size_t get_cpu_elf_notes_size(void)
>  	struct save_area *sa = NULL;
>  	size_t size;
>  
> -	size =	nt_size(NT_PRSTATUS, sizeof(struct elf_prstatus));
> -	size +=  nt_size(NT_PRFPREG, sizeof(elf_fpregset_t));
> -	size +=  nt_size(NT_S390_TIMER, sizeof(sa->timer));
> -	size +=  nt_size(NT_S390_TODCMP, sizeof(sa->todcmp));
> -	size +=  nt_size(NT_S390_TODPREG, sizeof(sa->todpreg));
> -	size +=  nt_size(NT_S390_CTRS, sizeof(sa->ctrs));
> -	size +=  nt_size(NT_S390_PREFIX, sizeof(sa->prefix));
> +	size =	nt_size(PRSTATUS, struct elf_prstatus);
> +	size += nt_size(PRFPREG, elf_fpregset_t);
> +	size += nt_size(S390_TIMER, sa->timer);
> +	size += nt_size(S390_TODCMP, sa->todcmp);
> +	size += nt_size(S390_TODPREG, sa->todpreg);
> +	size += nt_size(S390_CTRS, sa->ctrs);
> +	size += nt_size(S390_PREFIX, sa->prefix);
>  	if (cpu_has_vx()) {
> -		size += nt_size(NT_S390_VXRS_HIGH, sizeof(sa->vxrs_high));
> -		size += nt_size(NT_S390_VXRS_LOW, sizeof(sa->vxrs_low));
> +		size += nt_size(S390_VXRS_HIGH, sa->vxrs_high);
> +		size += nt_size(S390_VXRS_LOW, sa->vxrs_low);
>  	}
>  
>  	return size;
> @@ -373,7 +357,7 @@ static void *nt_prpsinfo(void *ptr)
>  	memset(&prpsinfo, 0, sizeof(prpsinfo));
>  	prpsinfo.pr_sname = 'R';
>  	strcpy(prpsinfo.pr_fname, "vmlinux");
> -	return nt_init(ptr, NT_PRPSINFO, &prpsinfo, sizeof(prpsinfo));
> +	return nt_init(ptr, PRPSINFO, prpsinfo);
>  }
>  
>  /*
> @@ -589,7 +573,7 @@ static size_t get_elfcorehdr_size(int phdr_count)
>  	/* PT_NOTES */
>  	size += sizeof(Elf64_Phdr);
>  	/* nt_prpsinfo */
> -	size += nt_size(NT_PRPSINFO, sizeof(struct elf_prpsinfo));
> +	size += nt_size(PRPSINFO, struct elf_prpsinfo);
>  	/* regsets */
>  	size += get_cpu_cnt() * get_cpu_elf_notes_size();
>  	/* nt_vmcoreinfo */
> 
> -- 
> 2.47.1
> 
> 


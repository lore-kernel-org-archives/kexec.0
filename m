Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02716C43334
	for <kexec@archiver.kernel.org>; Wed,  6 Jul 2022 01:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=syEPK/kSiJAdhU806gHiWKdNSpL9egzSEd6Im9SMMV0=; b=LnyeBdxLM+MrgaMHypVReHZJjL
	JxiJY9xXdQnIMqMpQwWJ9BGHbZ74IOH8QARy0JkUOFncR3FcWS0Zguc8XHWIdO8VdHuZrvihV9b6L
	mmtUFBf1WMReVWyqc0ZXmLWJofK++YnwOuBmDjDer5nEXBzjJdhGXjG+BpTbYgU5carakskMBMJBV
	0rP6l4T5Xa6O9m+ouB/burIvHJl+LsrsNcjLoCSYXSfSy87pf726eemZ9sbc1oqt8NlFVB6JJF7Yn
	uXav9eh5VddTPKrdAFCNmKDC/LtkDl4KdGVj/rofyOtu9Dx7x2uxSFxRfo0fZfJPAmav/frd6OmGE
	RALKD9Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8uGg-005HYl-Os; Wed, 06 Jul 2022 01:55:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8uGd-005HXa-OS
	for kexec@lists.infradead.org; Wed, 06 Jul 2022 01:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657072549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TUxC/Tkc/tS5Ejzg3vN8DgE3TpSu5V1M1qIpJrNhK3w=;
	b=L4SJNimfLiAQq6bg8hh/cKSYNksnfqSDnPe4UVnYMvclzmUpihfeCCwsbJ8BqK45PNm35d
	uoYmz1B7/Z6SuMpniBZiZWbLsKFsZ5WCtTZspq5ievKALtBxuvsTosVOfjQ19ofp9jS/R5
	ZvU0iT9yXUVf7m5eZjgXnVg0xLmw5KU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-VXzuWHyANTamygJC5rSu8A-1; Tue, 05 Jul 2022 21:55:42 -0400
X-MC-Unique: VXzuWHyANTamygJC5rSu8A-1
Received: by mail-pj1-f69.google.com with SMTP id f91-20020a17090a706400b001ef890a44e0so3789617pjk.9
        for <kexec@lists.infradead.org>; Tue, 05 Jul 2022 18:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TUxC/Tkc/tS5Ejzg3vN8DgE3TpSu5V1M1qIpJrNhK3w=;
        b=olr13JZgDL7pJ6ZK0On7toiZMhB67P4+13Mo/K7rGKWJqJZooL+upuh/wn1w3d7hqU
         CZ33ruEBsjyKXhZJtsr+SB6w31Lw28aj3ba4y1ulK74Y3iBrGYA7Zvhgr2xOGk90Gcf7
         y76+0hHssJalN7y6nKyHFaxJtrOxCH7wSz0vJ9UbTpLouVfhFyovdVr37VNunDo2wGSV
         Tl8QiZjMcnMKnrLnaNp32uKmce/H+MvR3sWQe/v3Yz8uk9q485k8sNkfQrj1s5E3Fy5d
         /YIV760QHh1rzJPnbpv7TLYyfy5Y27LIr6M4fZWI8wrYOm1ZU9gksEIF+bSPtYguDH05
         gf7A==
X-Gm-Message-State: AJIora97eWQUxxtFjF/rBCEF2XG73yzrw/S00LcpW7JONDqRw0prXlgc
	SsUuqNVdFA4gePAMbOxkL7sg2vVyslEvNWb5Gv31zOqAErFE5HdkFTqKel25Z7AbQGHadxCv+pV
	W9GXhK0zoCGx0D/0yzV5K
X-Received: by 2002:a17:90a:fa4f:b0:1ef:9203:afc3 with SMTP id dt15-20020a17090afa4f00b001ef9203afc3mr11150082pjb.141.1657072540523;
        Tue, 05 Jul 2022 18:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sOeTIHXFWdC6DJnwVAFSpJlFM1v3xGZvRPzcBsUnw9L4XTKx1wcPpJpMYWbJwI//00foC13A==
X-Received: by 2002:a17:90a:fa4f:b0:1ef:9203:afc3 with SMTP id dt15-20020a17090afa4f00b001ef9203afc3mr11150057pjb.141.1657072540185;
        Tue, 05 Jul 2022 18:55:40 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12-20020a621c0c000000b0050dc7628178sm23572853pfc.82.2022.07.05.18.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 18:55:39 -0700 (PDT)
Date: Wed, 6 Jul 2022 09:53:08 +0800
From: Coiby Xu <coxu@redhat.com>
To: Baoquan He <bhe@redhat.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] kexec_file: Drop weak attribute from functions
Message-ID: <20220706015308.heynqgictt47r3c5@Rk>
References: <cover.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
 <2cd7ca1fe4d6bb6ca38e3283c717878388ed6788.1656659357.git.naveen.n.rao@linux.vnet.ibm.com>
 <YsJoGKribMH77HBQ@MiWiFi-R3L-srv>
MIME-Version: 1.0
In-Reply-To: <YsJoGKribMH77HBQ@MiWiFi-R3L-srv>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=coxu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_185551_916659_DED5B7E1 
X-CRM114-Status: GOOD (  21.07  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Baoquan and Naveen,

On Mon, Jul 04, 2022 at 12:10:00PM +0800, Baoquan He wrote:
>On 07/01/22 at 01:04pm, Naveen N. Rao wrote:
>> Drop __weak attribute from functions in kexec_file.c:
>> - arch_kexec_kernel_image_probe()
>> - arch_kimage_file_post_load_cleanup()
>> - arch_kexec_kernel_image_load()
>> - arch_kexec_locate_mem_hole()
>> - arch_kexec_kernel_verify_sig()
>>
>> arch_kexec_kernel_image_load() calls into kexec_image_load_default(), so
>> drop the static attribute for the latter.
>>
>> arch_kexec_kernel_verify_sig() is not overridden by any architecture, so
>> drop the __weak attribute.
>
>The dropping of arch_kexec_kernel_verify_sig() conflicts with patch 1 of
>anotherpatchset, and the other patches in the patchset depends on the
>patch 1.
>
>[PATCH v9 0/4] unify the keyrings of arm64 and s390 with x86 to verify kexec'ed kernel signature
>
>Hi, Naveen, Coiby,
>
>Please negotiate how to solve the conflict.

Thanks Baoquan for letting me know of this conflict. Naveen, how about
resolving the conflict based on which patch is merged first? If your
patch set is going to be merged early, I will resolve the conflict in my
patch set, and vice versa.

>
>Thanks
>Baoquan
>
>>
>> Suggested-by: Eric Biederman <ebiederm@xmission.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/arm64/include/asm/kexec.h   |  4 ++-
>>  arch/powerpc/include/asm/kexec.h |  9 +++++++
>>  arch/s390/include/asm/kexec.h    |  3 +++
>>  arch/x86/include/asm/kexec.h     |  6 +++++
>>  include/linux/kexec.h            | 44 +++++++++++++++++++++++++++-----
>>  kernel/kexec_file.c              | 35 ++-----------------------
>>  6 files changed, 61 insertions(+), 40 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
>> index 9839bfc163d714..78d272b26ebd11 100644
>> --- a/arch/arm64/include/asm/kexec.h
>> +++ b/arch/arm64/include/asm/kexec.h
>> @@ -115,7 +115,9 @@ extern const struct kexec_file_ops kexec_image_ops;
>>
>>  struct kimage;
>>
>> -extern int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>> +
>>  extern int load_other_segments(struct kimage *image,
>>  		unsigned long kernel_load_addr, unsigned long kernel_size,
>>  		char *initrd, unsigned long initrd_len,
>> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
>> index 2aefe14e144229..1e5e9b6ec78d9d 100644
>> --- a/arch/powerpc/include/asm/kexec.h
>> +++ b/arch/powerpc/include/asm/kexec.h
>> @@ -120,6 +120,15 @@ int setup_purgatory(struct kimage *image, const void *slave_code,
>>  #ifdef CONFIG_PPC64
>>  struct kexec_buf;
>>
>> +int arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len);
>> +#define arch_kexec_kernel_image_probe arch_kexec_kernel_image_probe
>> +
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>> +
>> +int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>> +#define arch_kexec_locate_mem_hole arch_kexec_locate_mem_hole
>> +
>>  int load_crashdump_segments_ppc64(struct kimage *image,
>>  				  struct kexec_buf *kbuf);
>>  int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
>> index 649ecdcc873453..8886aadc11a3a6 100644
>> --- a/arch/s390/include/asm/kexec.h
>> +++ b/arch/s390/include/asm/kexec.h
>> @@ -92,5 +92,8 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>  				     const Elf_Shdr *relsec,
>>  				     const Elf_Shdr *symtab);
>>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> +
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>>  #endif
>>  #endif /*_S390_KEXEC_H */
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 6ad8d946cd3ebf..5ec359c1b50cb3 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -193,6 +193,12 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>  				     const Elf_Shdr *relsec,
>>  				     const Elf_Shdr *symtab);
>>  #define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> +
>> +void *arch_kexec_kernel_image_load(struct kimage *image);
>> +#define arch_kexec_kernel_image_load arch_kexec_kernel_image_load
>> +
>> +int arch_kimage_file_post_load_cleanup(struct kimage *image);
>> +#define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
>>  #endif
>>  #endif
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index ce6536f1d26997..5e0bc3f9eac3e9 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -188,21 +188,53 @@ int kexec_purgatory_get_set_symbol(struct kimage *image, const char *name,
>>  				   void *buf, unsigned int size,
>>  				   bool get_value);
>>  void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>> +void *kexec_image_load_default(struct kimage *image);
>> +
>> +#ifndef arch_kexec_kernel_image_probe
>> +static inline int
>> +arch_kexec_kernel_image_probe(struct kimage *image, void *buf, unsigned long buf_len)
>> +{
>> +	return kexec_image_probe_default(image, buf, buf_len);
>> +}
>> +#endif
>> +
>> +#ifndef arch_kimage_file_post_load_cleanup
>> +static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
>> +{
>> +	return kexec_image_post_load_cleanup_default(image);
>> +}
>> +#endif
>> +
>> +#ifndef arch_kexec_kernel_image_load
>> +static inline void *arch_kexec_kernel_image_load(struct kimage *image)
>> +{
>> +	return kexec_image_load_default(image);
>> +}
>> +#endif
>>
>> -/* Architectures may override the below functions */
>> -int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>> -				  unsigned long buf_len);
>> -void *arch_kexec_kernel_image_load(struct kimage *image);
>> -int arch_kimage_file_post_load_cleanup(struct kimage *image);
>>  #ifdef CONFIG_KEXEC_SIG
>>  int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>>  				 unsigned long buf_len);
>>  #endif
>> -int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>>  extern int kexec_add_buffer(struct kexec_buf *kbuf);
>>  int kexec_locate_mem_hole(struct kexec_buf *kbuf);
>>
>> +#ifndef arch_kexec_locate_mem_hole
>> +/**
>> + * arch_kexec_locate_mem_hole - Find free memory to place the segments.
>> + * @kbuf:                       Parameters for the memory search.
>> + *
>> + * On success, kbuf->mem will have the start address of the memory region found.
>> + *
>> + * Return: 0 on success, negative errno on error.
>> + */
>> +static inline int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>> +{
>> +	return kexec_locate_mem_hole(kbuf);
>> +}
>> +#endif
>> +
>>  /* Alignment required for elf header segment */
>>  #define ELF_CORE_HEADER_ALIGN   4096
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 9b2839775c837b..66e4ce29fc6961 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -56,14 +56,7 @@ int kexec_image_probe_default(struct kimage *image, void *buf,
>>  	return ret;
>>  }
>>
>> -/* Architectures can provide this probe function */
>> -int __weak arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>> -					 unsigned long buf_len)
>> -{
>> -	return kexec_image_probe_default(image, buf, buf_len);
>> -}
>> -
>> -static void *kexec_image_load_default(struct kimage *image)
>> +void *kexec_image_load_default(struct kimage *image)
>>  {
>>  	if (!image->fops || !image->fops->load)
>>  		return ERR_PTR(-ENOEXEC);
>> @@ -74,11 +67,6 @@ static void *kexec_image_load_default(struct kimage *image)
>>  				 image->cmdline_buf_len);
>>  }
>>
>> -void * __weak arch_kexec_kernel_image_load(struct kimage *image)
>> -{
>> -	return kexec_image_load_default(image);
>> -}
>> -
>>  int kexec_image_post_load_cleanup_default(struct kimage *image)
>>  {
>>  	if (!image->fops || !image->fops->cleanup)
>> @@ -87,11 +75,6 @@ int kexec_image_post_load_cleanup_default(struct kimage *image)
>>  	return image->fops->cleanup(image->image_loader_data);
>>  }
>>
>> -int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>> -{
>> -	return kexec_image_post_load_cleanup_default(image);
>> -}
>> -
>>  #ifdef CONFIG_KEXEC_SIG
>>  static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>>  					  unsigned long buf_len)
>> @@ -104,8 +87,7 @@ static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>>  	return image->fops->verify_sig(buf, buf_len);
>>  }
>>
>> -int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>> -					unsigned long buf_len)
>> +int arch_kexec_kernel_verify_sig(struct kimage *image, void *buf, unsigned long buf_len)
>>  {
>>  	return kexec_image_verify_sig_default(image, buf, buf_len);
>>  }
>> @@ -616,19 +598,6 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;
>>  }
>>
>> -/**
>> - * arch_kexec_locate_mem_hole - Find free memory to place the segments.
>> - * @kbuf:                       Parameters for the memory search.
>> - *
>> - * On success, kbuf->mem will have the start address of the memory region found.
>> - *
>> - * Return: 0 on success, negative errno on error.
>> - */
>> -int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>> -{
>> -	return kexec_locate_mem_hole(kbuf);
>> -}
>> -
>>  /**
>>   * kexec_add_buffer - place a buffer in a kexec segment
>>   * @kbuf:	Buffer contents and memory parameters.
>> --
>> 2.36.1
>>
>

-- 
Best regards,
Coiby


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

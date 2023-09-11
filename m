Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8827AEE57DF
	for <kexec@archiver.kernel.org>; Mon, 11 Sep 2023 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CVYAlsqcpPC2I/D/foSaZgeQlyVNr/1rOK/JF5HJJfo=; b=0u587ZVLix4szR
	cyUz9tiz/1tfGDMwgl7XsOpFF+03gqhd/Hag/Qqz//wuDtELC51IcmgNL+RAQzoMiSgvs/fhjONBC
	geIxEI4Fkdtr+v9ZIGQwKgRHYXy5qsWSOEzfRbAgDkjkOUnDBMrtZVzUzcZ5qVRVK7rOSt/qIXbxl
	D//Le4UaJeQGxxn5sEvuCQRp1ggsLGJywRE4F6MnSRNGLpDb9EQZ614FLeqk1Q9Vv/zNXT3Lt3Syt
	GR+Dk/jAodO8PUWQoKuxNAFT1qHAEafqbeNBRDbHm9Sb98/7kqIe09yI7yVmJrxcnprpJ0jsPEeW9
	F5mrI7J2bwo9SxOgEiGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfb6o-00HOAq-1s;
	Mon, 11 Sep 2023 07:13:22 +0000
Received: from gandalf.ozlabs.org ([150.107.74.76])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfb6k-00HO6g-16
	for kexec@lists.infradead.org;
	Mon, 11 Sep 2023 07:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1694416391;
	bh=x3DI2GOmDJf3VCeCLcNSuqidmRFWPmzeO7ZN5ro3wQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MjJH62QWRh2VQSSbKneqoRlIRvXqFkvpJavlxEypjGnB2nzGPtho60W8xhSKnqmG4
	 Ts4Ba6UX+Vnn9kc3aMY7D2eJ6xx+5LqYwqNcB1adFOpBO8xwGyuPX8zGt3eE2bR1uc
	 qiMMmr0z3GATVZbl+XH7RqFOrI+eq6Mc8uZD/mK9BV3lUjX3hXndpQGpKQZC2q3znN
	 8AdA7uSulHTaMIpElPecLEjyi0zlB59wOAZFKVXnAUGeGpkwTK53+gi/NlvOsQDBRd
	 B2Tel2+x0yx3vsGdmZc09eMDVr5s/kSOji9saNoTcU8BhFlSyfr85ESMHUwpdRKDyM
	 sKx7Yc6nd3ddA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RkdGb0fxzz4xFD;
	Mon, 11 Sep 2023 17:13:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>, lkml
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Kexec-ml <kexec@lists.infradead.org>
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain
 <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] vmcore: allow fadump to export vmcore even if
 is_kdump_kernel() is false
In-Reply-To: <20230905183604.568996-2-hbathini@linux.ibm.com>
References: <20230905183604.568996-1-hbathini@linux.ibm.com>
 <20230905183604.568996-2-hbathini@linux.ibm.com>
Date: Mon, 11 Sep 2023 17:13:08 +1000
Message-ID: <8734zltc6z.fsf@mail.lhotse>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_001319_709330_7BB98486 
X-CRM114-Status: GOOD (  22.60  )
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

Hari Bathini <hbathini@linux.ibm.com> writes:
> Currently, is_kdump_kernel() returns true when elfcorehdr_addr is set.
> While elfcorehdr_addr is set for kexec based kernel dump mechanism,
> alternate dump capturing methods like fadump [1] also set it to export
> the vmcore. Since, is_kdump_kernel() is used to restrict resources in
> crash dump capture kernel and such restrictions are not desirable for
> fadump, allow is_kdump_kernel() to be defined differently for fadump
> case. With that change, include is_fadump_active() check in functions
> is_vmcore_usable() & vmcore_unusable() to be able to export vmcore for
> fadump case too.
...
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index 0f3a656293b0..de8a9fabfb6f 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -50,6 +50,7 @@ void vmcore_cleanup(void);
>  #define vmcore_elf64_check_arch(x) (elf_check_arch(x) || vmcore_elf_check_arch_cross(x))
>  #endif
>  
> +#ifndef is_kdump_kernel
>  /*
>   * is_kdump_kernel() checks whether this kernel is booting after a panic of
>   * previous kernel or not. This is determined by checking if previous kernel
> @@ -64,6 +65,19 @@ static inline bool is_kdump_kernel(void)
>  {
>  	return elfcorehdr_addr != ELFCORE_ADDR_MAX;
>  }
> +#endif
> +
> +#ifndef is_fadump_active
> +/*
> + * If f/w assisted dump capturing mechanism (fadump), instead of kexec based
> + * dump capturing mechanism (kdump) is exporting the vmcore, then this function
> + * will be defined in arch specific code to return true, when appropriate.
> + */
> +static inline bool is_fadump_active(void)
> +{
> +	return false;
> +}
> +#endif
>  
>  /* is_vmcore_usable() checks if the kernel is booting after a panic and
>   * the vmcore region is usable.
> @@ -75,7 +89,8 @@ static inline bool is_kdump_kernel(void)
>  
>  static inline int is_vmcore_usable(void)
>  {
> -	return is_kdump_kernel() && elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
> +	return (is_kdump_kernel() || is_fadump_active())
> +		&& elfcorehdr_addr != ELFCORE_ADDR_ERR ? 1 : 0;
>  }
>  
>  /* vmcore_unusable() marks the vmcore as unusable,
> @@ -84,7 +99,7 @@ static inline int is_vmcore_usable(void)
>  
>  static inline void vmcore_unusable(void)
>  {
> -	if (is_kdump_kernel())
> +	if (is_kdump_kernel() || is_fadump_active())
>  		elfcorehdr_addr = ELFCORE_ADDR_ERR;
>  }

I think it would be cleaner to decouple is_vmcore_usable() and
vmcore_usable() from is_kdump_kernel().

ie, make them operate solely based on the value of elforehdr_addr:

static inline int is_vmcore_usable(void)
{
	elfcorehdr_addr != ELFCORE_ADDR_ERR && \
		elfcorehdr_addr != ELFCORE_ADDR_MAX;
}

static inline void vmcore_unusable(void)
{
	elfcorehdr_addr = ELFCORE_ADDR_ERR;
}


Then all we need on powerpc is a way to override is_kdump_kernel().

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

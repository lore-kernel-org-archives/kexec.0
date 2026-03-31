Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60138FF60CF
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 07:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=; b=rxz3kWu3gimthAWzsMJA29rfPJ
	kw+VV5FdcM4241LCWD0nJ0WGLJy/2KS3aFZQR+s03tlxOC8fibaMNRDJdtfuYW0LZo2hI7XA+myAw
	xuUgiiY7nYcRx4SaY/CRzOncIEfk0ElRwSdY5q5nbi50R+vBlPShDoaTodimqd+Ilr6ZEYqjfpTEI
	BO67AEx6CU3iMqqdpUNmkFPamYMKi36yeT0LMxEDasIjRGIscV5yemEPxfO79zuEg8+NxzZ6+NIcN
	/oLUr0kNmSqINX+hbdYbpp28zzz0hM+RUG23CTWTRnleC8znwGbdDbuQXP+TPGTbm+1N4yJ3wRZQ7
	/yr0uyDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7THu-0000000CRmo-19zE;
	Tue, 31 Mar 2026 07:13:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7THs-0000000CRmE-49ZB
	for kexec@bombadil.infradead.org;
	Tue, 31 Mar 2026 07:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=; b=SguKEQKdQ+qoRjf5LXGUzsMbhF
	949cEvKLI7GK7wzOO6hmDLXT+J6MhqZzU1zXMRn/fdvqbjyjxwRIINsbst6QdHsvV+pVNh5IO4ge7
	//6CXBdBWcna/2Qf4JbLcthuEsb5g6I/WN8FIhg9shv/zIlJgChGQQkf7TJyPLYfHfP3WZsaKQeJ6
	EZ3BbjTI+cxCNrpIRu7YdcbpXdZDKA2pIebxqW5Qo16Rzpk9orvnTjHLGWjGDIuQbiqK1A+VJgHVE
	hJl3FDClehDmbVwN1jPW8A9NsMj/Tm6I/l9AE38jnPEfzH6Yn7Aa85eC70lvq7PNAaD2+Oo+S96JF
	Ag/Sv4Mw==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7THo-0000000FFwm-0SbB
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 07:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=;
	b=HiLMb1uYqMUQ5trgMTxFarHM61DnE7M5nCEKIzCqndsM8/TPS/pX2Y/5b+q/jtulPXD9VP
	LNJZtidQYTOwXP3uvWI6HDBceZRE6PLk7n6dbT5ENDEHv9bQriY4nMCeLDRpCa+sq1lBj1
	lRa89sA2Q/gzOmPYHfmf9pD0St+4mR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774941192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=luFavRrVLyuYw5Pp7Hq4J37Yw0Jet8kP6askoheBw5k=;
	b=Ix0/mKi0lq/4A70gU6uYId1UMHAft9KUu9L7UwgcDbqvixY/1cKVt/G6MG4aN6+mU59GFw
	hr8dZ+kTzUN32cep8YbaP3QlBSjqkoBj1itknhOzjvbtX7b8dOQgS8TzscGTCpI4Hs/1KQ
	nCkw7xvrjFZtDUFZPuB2F+w4tKWB/dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-d6vwkgkuNLO4Lk1HCZw_4w-1; Tue,
 31 Mar 2026 03:13:02 -0400
X-MC-Unique: d6vwkgkuNLO4Lk1HCZw_4w-1
X-Mimecast-MFC-AGG-ID: d6vwkgkuNLO4Lk1HCZw_4w_1774941180
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 256BC180061A;
	Tue, 31 Mar 2026 07:13:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.177])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843321955F42;
	Tue, 31 Mar 2026 07:12:58 +0000 (UTC)
Date: Tue, 31 Mar 2026 15:12:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] crash: Align the declaration of
 crash_load_dm_crypt_keys with CONFIG_CRASH_DM_CRYPT
Message-ID: <actz9u1rBnvtuBUm@fedora>
References: <20260225060347.718905-1-coxu@redhat.com>
 <20260225060347.718905-3-coxu@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20260225060347.718905-3-coxu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: zj3XAvVjmgf1CejJFpMgXGxIGHeGl6N_H1G9Y9LytMo_1774941180
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_081317_021692_2938EFDE 
X-CRM114-Status: GOOD (  16.24  )
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

On 02/25/26 at 02:03pm, Coiby Xu wrote:
> This will prevent a compiling failure when CONFIG_CRASH_DUMP is enabled
> but CONFIG_CRASH_DM_CRYPT is disabled,
> 
>        arch/powerpc/kexec/elf_64.c: In function 'elf64_load':
>     >> arch/powerpc/kexec/elf_64.c:82:23: error: implicit declaration of function 'crash_load_dm_crypt_keys' [-Werror=implicit-function-declaration]
>           82 |                 ret = crash_load_dm_crypt_keys(image);
>              |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>        cc1: some warnings being treated as errors
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602120648.RgQALnnI-lkp@intel.com/
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>  include/linux/crash_core.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index d35726d6a415..c1dee3f971a9 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -34,13 +34,6 @@ static inline void arch_kexec_protect_crashkres(void) { }
>  static inline void arch_kexec_unprotect_crashkres(void) { }
>  #endif
>  
> -#ifdef CONFIG_CRASH_DM_CRYPT
> -int crash_load_dm_crypt_keys(struct kimage *image);
> -ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
> -#else
> -static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
> -#endif
> -
>  #ifndef arch_crash_handle_hotplug_event
>  static inline void arch_crash_handle_hotplug_event(struct kimage *image, void *arg) { }
>  #endif
> @@ -96,4 +89,11 @@ static inline void crash_save_cpu(struct pt_regs *regs, int cpu) {};
>  static inline int kimage_crash_copy_vmcoreinfo(struct kimage *image) { return 0; };
>  #endif /* CONFIG_CRASH_DUMP*/
>  
> +#ifdef CONFIG_CRASH_DM_CRYPT
> +int crash_load_dm_crypt_keys(struct kimage *image);
> +ssize_t dm_crypt_keys_read(char *buf, size_t count, u64 *ppos);
> +#else
> +static inline int crash_load_dm_crypt_keys(struct kimage *image) {return 0; }
> +#endif
> +
>  #endif /* LINUX_CRASH_CORE_H */
> -- 
> 2.53.0
> 



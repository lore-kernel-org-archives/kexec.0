Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F90CA0EEB
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 03:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wI3J5CQvGDPM9MDcFPBYlPpxyIDbUJTJvO8poXdYAMY=; b=SGyyRo3XXMIlLNPcUnYru9mTAv
	2rWOcV7vm6EhvrK58j9ZpiS2KA3HR/rQzD5PqRmNtXxWsivGcHBWjRwN5iNIdcYwYRytACCsRyBm9
	yi04MheCA72Up2Ze3hN2xvCQ6dJbrlNpDg6mU2jgGihBIQprvgjmxLVNP71IGNh3MnqFrIVt8mcKb
	kB0vo/W06ppUnJZcbhX8BZ247ftYrFmtdh0NwSFbv5UOrpg1jok6TchqKt9AsKx1aHo4LnYu2q7Oh
	vQXCr7royxyPK58ZZv2F3mXEtsFZoL7jQ24hM6jaUhIAuQwo5PuKf72PrQlZi7oDfSW1hzPTfHNzT
	oueT4Pyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoZCm-0000000CEvI-2wxB;
	Wed, 20 Aug 2025 03:09:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoZCj-0000000CEtM-1RZ6
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 03:09:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755659375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wI3J5CQvGDPM9MDcFPBYlPpxyIDbUJTJvO8poXdYAMY=;
	b=EUNJ9h05OYHW9OChFGj/0BltKXDWKef4Dr8iJfANE7oY2xJbXJHghettQ3b4FhSuONbVld
	+In4N/hhMrouAhkWtwTHy7kKQ3WcTUYu06hoWtpIhOzckSIT7IJTOoKE7VsKZvHPbh3cp/
	GnhFyJA+8Hbd8g3+NneoDsVOfpLXt7w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-0NjdYgtVO9a9N3OTmI1r_A-1; Tue,
 19 Aug 2025 23:09:30 -0400
X-MC-Unique: 0NjdYgtVO9a9N3OTmI1r_A-1
X-Mimecast-MFC-AGG-ID: 0NjdYgtVO9a9N3OTmI1r_A_1755659367
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 438F518004A7;
	Wed, 20 Aug 2025 03:09:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.115])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF05C19560B0;
	Wed, 20 Aug 2025 03:09:17 +0000 (UTC)
Date: Wed, 20 Aug 2025 11:09:15 +0800
From: Pingfan Liu <piliu@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	kexec@lists.infradead.org, bpf@vger.kernel.org,
	systemd-devel@lists.freedesktop.org
Subject: Re: [PATCHv5 10/12] arm64/kexec: Add PE image format support
Message-ID: <aKU8WwF77ZTixxPn@fedora>
References: <20250819012428.6217-1-piliu@redhat.com>
 <20250819012428.6217-11-piliu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819012428.6217-11-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_200937_448732_F069FEF8 
X-CRM114-Status: GOOD (  21.14  )
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

On Tue, Aug 19, 2025 at 09:24:26AM +0800, Pingfan Liu wrote:
> Now everything is ready for kexec PE image parser. Select it on arm64
> for zboot and UKI image support.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> To: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/Kconfig                     | 1 +
>  arch/arm64/include/asm/kexec.h         | 1 +
>  arch/arm64/kernel/machine_kexec_file.c | 3 +++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e9bbfacc35a64..97d9595a5ee86 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1608,6 +1608,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> +	select KEXEC_PE_IMAGE

According to the kernel test robot's report, this may fail due to a dependency issue. 
I will fix it in the next version as:
        select KEXEC_PE_IMAGE if DEBUG_INFO_BTF && BPF_SYSCALL
This dependency is introduced in patch [5/12].

Cc Catalin, since I'm making changes to address this issue, I'll drop your ack 
in the next version and would appreciate if you could review it again.

Thanks,

Pingfan
>  
>  config ARCH_SUPPORTS_KEXEC_SIG
>  	def_bool y
> diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> index 4d9cc7a76d9ca..d50796bd2f1e6 100644
> --- a/arch/arm64/include/asm/kexec.h
> +++ b/arch/arm64/include/asm/kexec.h
> @@ -120,6 +120,7 @@ struct kimage_arch {
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops kexec_image_ops;
> +extern const struct kexec_file_ops kexec_pe_image_ops;
>  
>  int arch_kimage_file_post_load_cleanup(struct kimage *image);
>  #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index af1ca875c52ce..7c544c385a9ab 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -24,6 +24,9 @@
>  
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&kexec_image_ops,
> +#ifdef CONFIG_KEXEC_PE_IMAGE
> +	&kexec_pe_image_ops,
> +#endif
>  	NULL
>  };
>  
> -- 
> 2.49.0
> 



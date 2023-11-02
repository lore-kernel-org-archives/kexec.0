Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E133FC4332F
	for <kexec@archiver.kernel.org>; Thu,  2 Nov 2023 08:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QIyoJAK+3i6JGm2gkMYdJ/XJ7okegeL38LGZfNH833c=; b=gs6/JDlMUlAGSx
	sh9gxq8KnYm1LuiPcKp5oK8jz/8CFLwBzgDJBc7ifqeZOVYTxEuqwYG6FUeq6vS5E2nmLu1wOed8a
	2FvMqmdodAlalJfsmWjE4cICI3scKwRK9faN+jNcH5r+An1krh6GhwIun6bXTQbjedZ5SF8Gv46Kt
	7+fMucfiVbgiCvAg/y97rs5x0q+TxmQG/D2u0GmZDNJzcFyGYHh5za4N+znuoKgcqRWKh0AkSiTv4
	LoAoCOPezEKPjBEL0oIhF8tpjpfboP0v3cUmbPB+YkgM53HlGnAPIFF22CoLzrCvamYFIbTvqy6kn
	fwM1HgkxWev+JPBVUIcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qySfx-008wRP-0I;
	Thu, 02 Nov 2023 08:03:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qySfq-008wQE-0T
	for kexec@lists.infradead.org;
	Thu, 02 Nov 2023 08:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698912207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WvS8MNTF0hgInyS69OR8wJBPNbNz7HePMphlox+7hLE=;
	b=btZpGk6x+JX+XtzDGZh5sohhWj5/OFUFa/0iiXnUIneVTzlvRyvxdLqbz3SWOM2oN4aVqo
	HYJgYrd/6I1wLSz8huauEQETRVsG748hW0gOE762jNVnuFplFEI1LHVPymw+pa9xf1eBQn
	hY/miwKvjJmm7rqHVxPzFYezF49QH5I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-ZXeI0wL_OGCPKuuv_BOOQg-1; Thu,
 02 Nov 2023 04:03:23 -0400
X-MC-Unique: ZXeI0wL_OGCPKuuv_BOOQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5121F3810D23;
	Thu,  2 Nov 2023 08:03:23 +0000 (UTC)
Received: from localhost (unknown [10.72.113.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F192492BE0;
	Thu,  2 Nov 2023 08:03:21 +0000 (UTC)
Date: Thu, 2 Nov 2023 16:03:18 +0800
From: Baoquan He <bhe@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vivek Goyal <vgoyal@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org, eric_devolder@yahoo.com
Subject: Re: [PATCH 1/2] kexec: fix KEXEC_FILE dependencies
Message-ID: <ZUNXxp9AIkjQkP9s@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
 <ZTe8NOgAjvKDA6z0@MiWiFi-R3L-srv>
 <b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b71034f4-5cdc-44e0-b72f-1a8ffae0593e@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231102_010330_284698_8D196F57 
X-CRM114-Status: GOOD (  38.77  )
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

Hi Arnd,

On 10/24/23 at 03:17pm, Arnd Bergmann wrote:
> On Tue, Oct 24, 2023, at 14:44, Baoquan He wrote:
> > Just add people and mailing list to CC since I didn't find this mail in
> > my box, just drag it via 'b4 am'.
> >
> > On 10/23/23 at 01:01pm, Arnd Bergmann wrote:
> > ......
> 
> >> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> >> index 7aff28ded2f48..bfc636d64ff2b 100644
> >> --- a/kernel/Kconfig.kexec
> >> +++ b/kernel/Kconfig.kexec
> >> @@ -36,6 +36,7 @@ config KEXEC
> >>  config KEXEC_FILE
> >>  	bool "Enable kexec file based system call"
> >>  	depends on ARCH_SUPPORTS_KEXEC_FILE
> >> +	depends on CRYPTO_SHA256=y || !ARCH_SUPPORTS_KEXEC_PURGATORY
> >
> > I am not sure if the logic is correct. In theory, kexec_file code
> > utilizes purgatory to verify the checksum digested during kernel loading
> > when try to jump to the kernel. That means kexec_file depends on
> > purgatory, but not contrary?
> 
> The expression I wrote is a bit confusing, but I think this just
> keeps the existing behavior:
> 
> - on architectures that select ARCH_SUPPORTS_KEXEC_PURGATORY
>   (powerpc, riscv, s390 and x86), we also require CRYPTO_SHA256
>   to be built-in.
> - on architectures that do not have ARCH_SUPPORTS_KEXEC_PURGATORY
>   (arm64 and parisc), CRYPTO_SHA256 is not used and can be disabled
>   or =m.
> 
> Since ARCH_SUPPORTS_KEXEC_PURGATORY is a 'bool' symbol, it could
> be written as
> 
> depends on (ARCH_SUPPORTS_KEXEC_PURGATORY && CRYPTO_SHA256=y) \
>            || !ARCH_SUPPORTS_KEXEC_PURGATORY
> 
> if you find that clearer. I see that the second patch
> actually gets this wrong, it should actually do
> 
> select CRYPTO if ARCH_SUPPORTS_KEXEC_PURGATORY
> select CRYPTO_SHA256 if ARCH_SUPPORTS_KEXEC_PURGATORY
> 
> > With these changes, we can achieve the goal to avoid building issue,
> > whereas the code logic becomes confusing. E.g people could disable
> > CONFIG_KEXEC_FILE, but still get purgatory code built in which is
> > totally useless.
> >
> > Not sure if I think too much over this.
> 
> I see your point here, and I would suggest changing the
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY symbol to just indicate
> the availability of the purgatory code for the arch, rather
> than actually controlling the code itself. I already mentioned
> this for s390, but riscv would need the same thing on top.
> 
> I think the change below should address your concern.

Since no new comment, do you mind spinning v2 to wrap all these up?

Thanks
Baoquan

> 
>      Arnd
> 
> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
> index e60fbd8660c4..3ac341d296db 100644
> --- a/arch/riscv/kernel/elf_kexec.c
> +++ b/arch/riscv/kernel/elf_kexec.c
> @@ -266,7 +266,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>                 cmdline = modified_cmdline;
>         }
>  
> -#ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
> +#ifdef CONFIG_KEXEC_FILE
>         /* Add purgatory to the image */
>         kbuf.top_down = true;
>         kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> @@ -280,7 +280,7 @@ static void *elf_kexec_load(struct kimage *image, char *kernel_buf,
>                                              sizeof(kernel_start), 0);
>         if (ret)
>                 pr_err("Error update purgatory ret=%d\n", ret);
> -#endif /* CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY */
> +#endif /* CONFIG_KEXEC_FILE */
>  
>         /* Add the initrd to the image */
>         if (initrd != NULL) {
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index d25ad1c19f88..ab181d187c23 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -5,7 +5,7 @@ obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
>  obj-y += errata/
>  obj-$(CONFIG_KVM) += kvm/
>  
> -obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
> +obj-$(CONFIG_KEXEC_FILE) += purgatory/
>  
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
> index a5d3503b353c..361aa01dbd49 100644
> --- a/arch/s390/Kbuild
> +++ b/arch/s390/Kbuild
> @@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS)        += hypfs/
>  obj-$(CONFIG_APPLDATA_BASE)    += appldata/
>  obj-y                          += net/
>  obj-$(CONFIG_PCI)              += pci/
> -obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
> +obj-$(CONFIG_KEXEC_FILE)       += purgatory/
>  
>  # for cleaning
>  subdir- += boot tools
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

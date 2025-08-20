Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41704CA0EF8
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dx/UlKEArBGyUs882+KWiBNpdfeER6qBdFtmV4pAR/A=; b=JaChe2TUH9IseZEoDDmRUJcCf9
	JL5vsF6ODMcaZwZlIZnzjD4SFPNuWuAanTWV1jLFuG6EjxCHCoHRMs8xHyn4Ba/5ri6s7iwueVJ+l
	ZbcfiQh6z+rx47ek4G/5ouQPwpkGnQfk6F87bPR6WxiA8RBA5i+QLA27w0lYD9X8Rwq3vlZ55DibG
	4hwpXuSjPPZXBalU2EtlRF0BFKLKB2qTuYe8oKClHcSkGZYKXFPv1ZkN+nfkwKFxzEWA6b4QiTYnt
	0f+8cmdJgAYixReVLm08N2lURzyE6NTTKv+65ubEmcw9G3sWv6gPVPiqgFVSyJ1Y+BEMbyHCnCR5x
	qUUt5nSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoev1-0000000CsQM-2MZ6;
	Wed, 20 Aug 2025 09:15:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoe7N-0000000Cj9H-1ldx
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 08:24:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D885D460DE;
	Wed, 20 Aug 2025 08:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F1EC4CEEB;
	Wed, 20 Aug 2025 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755678264;
	bh=/UL8r/IY6NvhVlFJ56nhpLYKbxUYOgISlF8+SOKUMgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbnMh56e8KeY51vJlnHAVZISzBdTJN0LpMnDGP01/N6PsJeiRuOBNdJEqqYBftNed
	 20t8gDewYmYyxKTsvLyzMfsjnofAq089lYNh6nQ3CR2ft1qPJ8g50tWqP1VlSpFaN8
	 hv208x2hK9MsoaUUDNxpuFCOtTSxBEZpRDl9IVRq6pqYaurwMixBNn2Dap3BCak86G
	 vpEYt8K90dH4mn3ZqO2q+XO3FMm5rrL3hNEPk5m6utPgeCIDPZJAVSSSHH/h38EM+M
	 FHsjOO+A9NXCwMNea9+PBpOZpICrX0MeAfBs9XeemKoTu+mXQefKikv7CjZW5vKpIZ
	 xiWbnB6p6lCCQ==
Date: Wed, 20 Aug 2025 11:24:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com
Subject: Re: [PATCH v2 1/2] kexec: introduce is_kho_boot()
Message-ID: <aKWGMbueQBaB5Wsi@kernel.org>
References: <cover.1755643201.git.epetron@amazon.de>
 <7043f4da31390c58bb7721a3774c30998997df44.1755643201.git.epetron@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7043f4da31390c58bb7721a3774c30998997df44.1755643201.git.epetron@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_012425_498726_30BF021D 
X-CRM114-Status: GOOD (  23.45  )
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

On Tue, Aug 19, 2025 at 11:22:45PM +0000, Evangelos Petrongonas wrote:
> During early initialisation, after a kexec, other components, like EFI
> need to know if a KHO enabled kexec is performed. The `kho_is_enabled`
> function is not enough as in the early stages, it only reflects
> whether the cmdline has KHO enabled, not if an actual KHO FDT exists.
> 
> Extend the KHO API with `is_kho_boot()` to provide a way for components
> to check if a KHO enabled kexec is performed.
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> ---
>  include/linux/kexec_handover.h |  6 ++++++
>  kernel/kexec_handover.c        | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 348844cffb13..559d13a3bc44 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -40,6 +40,7 @@ struct kho_serialization;
>  
>  #ifdef CONFIG_KEXEC_HANDOVER
>  bool kho_is_enabled(void);
> +bool is_kho_boot(void);
>  
>  int kho_preserve_folio(struct folio *folio);
>  int kho_preserve_phys(phys_addr_t phys, size_t size);
> @@ -60,6 +61,11 @@ static inline bool kho_is_enabled(void)
>  	return false;
>  }
>  
> +static inline bool is_kho_boot(void)
> +{
> +	return false;
> +}
> +
>  static inline int kho_preserve_folio(struct folio *folio)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index 69b953551677..a1a4e76e0ff1 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -925,6 +925,26 @@ static const void *kho_get_fdt(void)
>  	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
>  }
>  
> +/**
> + * is_kho_boot - check if current kernel was booted via KHO-enabled
> + * kexec
> + *
> + * This function checks if the current kernel was loaded through a kexec
> + * operation with KHO enabled, by verifying both that KHO is enabled via
> + * cmdline AND that a valid KHO FDT was passed.
> + *
> + * Note: This function returns reliable results only after
> + * kho_populate() has been called during early boot. Before that,
> + * it may return false even if KHO data is present.
> + *
> + * Return: true if booted via KHO-enabled kexec, false otherwise
> + */
> +bool is_kho_boot(void)
> +{
> +	return !!kho_get_fdt() && kho_enable;

Let's drop '&& kho_enable' and presume that a kernel that booted with KHO
FDT goes through KHO revival.

With that change feel free to add

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> +}
> +EXPORT_SYMBOL_GPL(is_kho_boot);
> +
>  /**
>   * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
>   * @name: the name of the sub FDT passed to kho_add_subtree().
> -- 
> 2.47.3

-- 
Sincerely yours,
Mike.


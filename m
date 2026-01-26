Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2BCD13C1E
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8zOxLLvY+Aal8JT5wI6fL2YE4FO4kialvpEhIAqwc0=; b=oPO8025spVYFrXQfhjxPH2oh9k
	+oZhyFoiBfKUJaOMtyx8laG+S9fpgEGAFODzpXsKI1dLhfqr/wHmTtynqNmpP3GAgXUjQpaM11ysf
	bS0KvpCGDYcLNIC9xaLEuVateEc3+vtVv/GnCnA4EiJk6LD+1kgX2I3nRw14v0sMGW0ZMyp0EsqkP
	BgmPsU8ND9A/Unx5BlkwfavoUcGqFmWXx3vptV2C1DaJULdtu9FsKrbuHDutBApDespXarDwjn0vG
	k3lJUo4EXYNsoA/Rp1J+SReanTFQbVDQefBbafVQVirkFkJYpLTPKuOB11fDy+bVrA2+hQ84bqWBh
	JJTpAWIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkNhR-0000000Chko-23zi;
	Mon, 26 Jan 2026 14:36:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkNhP-0000000ChkP-3m2S;
	Mon, 26 Jan 2026 14:36:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0751E60130;
	Mon, 26 Jan 2026 14:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73C0C116C6;
	Mon, 26 Jan 2026 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769438174;
	bh=dMO1MIhjP4aVHBALuscN5a9iA1kviHKn9sIWzBNa0Wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d19x1kCDYOnGx2Xo+GWKZ43qg670AhXoY+z9KwUBlxi+c469kki/9gZpuNlXlZiNa
	 rZv3iCrRfTEHJA5rC1gwkwhr5H0JOyrF+WuH4kMmHUTcr68c+SvH2IbV/Dy39kGQwq
	 svRwyM23nXqJ/x+vnjF0iIUwhrH5WCHqHP3G/PRUJoRhd/73wKtuLhnxaFr9h6XFsb
	 8d0PCPT3Fkp/jB2F5IQQtssYcq9rnL7dZB0zjOZvBWb1I7rzD2iYimD2+Sp0lm0acc
	 kyW1vLZ3VVuiM+CCdHmjO1YG+mExxT6Yebnlb6Z/t8Wzh+4ynDm6n1DlvTtmLEoIH+
	 1yFi7JsqmfQcQ==
Date: Mon, 26 Jan 2026 14:36:08 +0000
From: Will Deacon <will@kernel.org>
To: Coiby Xu <coxu@redhat.com>
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>,
	Baoquan he <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, Pingfan Liu <kernelfans@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3] arm64/kdump: pass dm-crypt keys to kdump kernel
Message-ID: <aXd72PcvvFsIFXO2@willie-the-truck>
References: <20260123081326.1362666-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123081326.1362666-1-coxu@redhat.com>
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

On Fri, Jan 23, 2026 at 04:13:25PM +0800, Coiby Xu wrote:
> CONFIG_CRASH_DM_CRYPT has been introduced to support LUKS-encrypted
> device dump target by addressing two challenges [1],
>  - Kdump kernel may not be able to decrypt the LUKS partition. For some
>    machines, a system administrator may not have a chance to enter the
>    password to decrypt the device in kdump initramfs after the 1st kernel
>    crashes
> 
>  - LUKS2 by default use the memory-hard Argon2 key derivation function
>    which is quite memory-consuming compared to the limited memory reserved
>    for kdump.
> 
> To also enable this feature for ARM64, we only need to add device tree
> property dmcryptkeys [2] as similar to elfcorehdr to pass the memory
> address of the stored info of dm-crypt keys to the kdump kernel. Since
> this property is only needed by the kdump kenrel, it won't be exposed to
> user space.
> 
> [1] https://lore.kernel.org/all/20250502011246.99238-1-coxu@redhat.com/
> [2] https://github.com/devicetree-org/dt-schema/pull/181
> 
> Cc: Arnaud Lefebvre <arnaud.lefebvre@clever-cloud.com>
> Cc: Baoquan he <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Pingfan Liu <kernelfans@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
> v3
> - Delete the property after reading it [Rob Herring]
> 
> v2
> - Krzysztof
>   - Use imperative mood for commit message
>   - Add dt-schema ABI Documentation 
>     https://github.com/devicetree-org/dt-schema/pull/181
> - Don't print dm-crypt keys address via pr_debug
> 
> 
>  arch/arm64/kernel/machine_kexec_file.c |  9 +++++++++
>  drivers/of/fdt.c                       | 21 +++++++++++++++++++++
>  drivers/of/kexec.c                     | 19 +++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 410060ebd86d..5f3bad8ca96d 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -134,6 +134,15 @@ int load_other_segments(struct kimage *image,
>  
>  		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>  			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
> +
> +		ret = crash_load_dm_crypt_keys(image);
> +
> +		if (ret == -ENOENT) {
> +			kexec_dprintk("No dm crypt key to load\n");
> +		} else if (ret) {
> +			pr_err("Failed to load dm crypt keys\n");
> +			goto out_err;
> +		}

This looks like an unusual mixture of kexec_dprintk() and pr_err().

Stepping back a second, why do we need to print anything from the arch
code at all? It looks like crash_load_dm_crypt_keys() already prints for
the -ENOENT case so I'd be inclined just to do:

	ret = crash_load_dm_crypt_keys(image);
	if (ret)
		goto out_err;

Will


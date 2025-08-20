Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D776CA0EE4
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 13:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpWXO5t8TRctE6PkvlEVZk1OrPpiYqLVKC87IJoSseI=; b=oYb01DN6b+k7RiRdGFXbQfePib
	uZU+gBNdFeyGWI6OuK9TbMRrEcpfXkZx2i/VgOule0/UgvVAtqGXXrP49VnSHpgft8yFln2KcJMlo
	quLe8ujkvlvCtpQPgllnJ1d2c4qPBbQudt5nEsJpjpk+/R9Sk/ovxTHDugMSo6nmV1OwF/nijGvOe
	h7JFDS5zJncsoonjSv7Y7pI3hV/rckcADsItiqMUFqjThM4ZQHdp9CkUsUlpMHwEQQG9nFHXxs6M2
	Kn3XG5aJ9cBg9jMQUP1ve04hShpVIjrUuo/fpP9UWlyqTNMj/r2NYUSDYmqeUHAVrKEmYCppY97nK
	+BXsbpkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoiyo-0000000DpOd-2DVp;
	Wed, 20 Aug 2025 13:35:54 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoiRf-0000000Dhc2-2DYZ
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 13:01:40 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb72d51dcso900962466b.0
        for <kexec@lists.infradead.org>; Wed, 20 Aug 2025 06:01:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755694898; x=1756299698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpWXO5t8TRctE6PkvlEVZk1OrPpiYqLVKC87IJoSseI=;
        b=NIPpxAJVFe0GJLefRMccdbzea6rZeIpvXmalRklQuc10fAJuLzhTXT6tXcqhdKFaem
         G/jIjMe6+eEjWEin/cyPWd8Em6HoMZAOCqVhynl5dhljOcvE08Crsh9NU8kn4z9Jm0Qs
         9kdTYxGuUtj2lG5U//ELVUejo/MFYMSlNdOY6o5zAA6w/Sx56wMdk15Uls6KmpSohbiZ
         kdHEfmkbeFx40FmrLHBHLs1YnC8RR6aXvjJBaN3a+/jkZbhhDQyFibiTeY0BOdmqFN0c
         CbmH+oLsi87LBGW84yA/yWN4xpZcsVMyoHBMc/C0Myy33uFPLJslCANTmkXBU1hbFMbx
         4Zmg==
X-Gm-Message-State: AOJu0YyoXTp6aGs4EKgsxVD4GAD410EnBK6jROXFOUeHg1FRwOAWfS4e
	qqW1cu3iYoDZyWvUIkgPYsLwMTInsgruPL8vm1oZ6FbgpFaSf2Uf5VjQ
X-Gm-Gg: ASbGncsi83eOBaN/SIucjsKgJgYahXJq1gvcSh2Un/bY8W+2Dkdojdo+Sl2acAjy8qk
	hh8wZCQM2JDJzqd4E2tHo6r3v04oJq2Tlcz+XXk9bJybCbZkEpThsZSC8ot+ZKLhr5uefUe8LDV
	wsAxv1yv1u3FFUtF8apY15X6O1iDopapL4wsahbqINg6iTNJZpGYsVSOQ2VfNREH2pjCOuf0OCi
	IaSCTSPJ5R746MdjasWQwFGM1zLjnLZ1HNpMMzK3kEoIpm0hyvD7ilgfFTOzhevza/hhwgK5t3j
	9FmrfOu34EOf8keQgnarFwFI8TaWxchAzeLLxmvOgEUoj0u3SuuusSXzpWf5UsSGvTrwcJ17+Gi
	eBV0Bu0I5If8f
X-Google-Smtp-Source: AGHT+IH4Tq+3tk8JR0PALP9p3ZgVebhtn30Eq0QEKaBQiNYoxxHsXYQA5Zh+9VYp93VhYO+ysWQiKg==
X-Received: by 2002:a17:907:c5c8:b0:afa:1be7:3136 with SMTP id a640c23a62f3a-afdf029eb24mr230692366b.51.1755694896852;
        Wed, 20 Aug 2025 06:01:36 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded47933dsm175723166b.65.2025.08.20.06.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 06:01:36 -0700 (PDT)
Date: Wed, 20 Aug 2025 06:01:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, paulmck@kernel.org, 
	kernel-team@meta.com
Subject: Re: [RFC] kexec: Add bootconfig support to get_command_line
Message-ID: <unnfym5chpdhprujg5bayallgoxdbrxf4huibccjxymgkw6xfj@4hokigung3uw>
References: <20250811153736.3865487-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153736.3865487-1-usamaarif642@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_060139_565080_52C0FDFA 
X-CRM114-Status: GOOD (  17.56  )
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

On Mon, Aug 11, 2025 at 04:37:36PM +0100, Usama Arif wrote:
> If the kernel is enabled with CONFIG_BOOT_CONFIG_FORCE, it will
> always append the bootconfig at the start of the kernel commandline.
> If reuse-cmdline option is used in kexec, the bootconfig will be
> repeatedly appended at the start of the commandline on every kexec.
> As there is a limit on the size of kernel commandline that can be
> used, --reuse-cmdline option will break kexec depending on the
> size of bootconfig on repeated kexec.
> 
> Bootconfig is embedded in the kernel, so it should not be considered
> when reusing kernel command line.
> Modify get_command_line() to first attempt reading kernel parameters
> from /proc/bootconfig before falling back to /proc/cmdline. This allows
> kexec to use the original boot parameters without bootconfig which
> is embedded in the kernel.
> 
> The function will fallback to /proc/cmdline behavior when:
> 
> - /proc/bootconfig doesn't exist
> - /proc/bootconfig is empty
> - /proc/bootconfig doesn't contain the expected marker format
> - The extracted parameter line is empty
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>


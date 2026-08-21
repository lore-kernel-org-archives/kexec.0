Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4D5C5DF89
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBpMKLMCpV2AxfNqRU5qSpbkRSV1+US95VjWx7rNRF8=; b=LjO3+k0UeJpi231r8To3T2nRyW
	TCHr2xXneusqAa6YxpKBHQ2Uig6PpIfFeNQV94KG2eu9pxiExQLYBJgR3YG3SkrxH5nAj4UnEQxuV
	Sstg0u7IO696MHxB2gjIZkhyWo5GqrHA519ljDpYjhOTZ/m9nqXosbrFW+4Enly189yEy3A/XoMeN
	kXRIQO3bLtB3FfsKiNqAWDQ197D/AemqqHdCv2sfxrDuHihlXxdTySvQD1N6DMUC6l7SBOwIyH7in
	BgeZy2Fgc1sp2UkGf5clWyFMQhB7TmvhpHdJufs2P/Y6qlWAWKNLz019iIkj85CALLpd6gdBdmUuY
	4lUiYyGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNmh-0000000DF1U-4BGD;
	Fri, 21 Aug 2026 11:51:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxNmf-0000000DF1I-1Bu3
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 11:51:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BF5E342DF7;
	Fri, 21 Aug 2026 11:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF6D1F00A3D;
	Fri, 21 Aug 2026 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787313100;
	bh=sBpMKLMCpV2AxfNqRU5qSpbkRSV1+US95VjWx7rNRF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqeLOlyR4+rgSoG3eVry3aEncsV6Y46NTXrIU+4B1Ewqc9OkFka8zAwrx6AxpmcMY
	 1/RgrhvVcCqjpoexzMc1ZTPySmd0VMgynpzMy2tA44sfXlHMtF7nqi2qo+sN3YVoMt
	 5gP4EbnTlC46kkBUEdhW00pSr+5ZChFtdUVZ7tnJSyfI8Uvz8Ko6qpnBBtxal3h0fJ
	 CdLYKOfwuCrB83yvhsF235Z9hJu/E+fsOLm77D00KgCcLbmSTko3B/TN8T7OaDoYS2
	 TCSWbCjz/mC4p2rF1VsVxo99rneRyVOzfxuYqVZ7ciN191NmPmbXjd5Y71eiuc5MlJ
	 WFs2vdm0DtBBQ==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.ams.internal (Postfix) with ESMTP id 72BA11980052;
	Fri, 21 Aug 2026 07:51:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 21 Aug 2026 07:51:38 -0400
X-ME-Sender: <xms:xzuIao-UNTuh7jdnMg-X77Z0xxMkKq3OlEUrkuxpz-IlLBBhol3buQ>
    <xme:xzuIauIA96Foe0bv9NGipTbBqiztVzEXtIvkcwRIlfYCafITkGIZ0qcrU34S41Uo9
    -S0_DsRhUonwIwz-4VLhWtrVZaZ_IS33LfGWXTsjxnQ8uQJ6jpZao0Q>
X-ME-Received: <xmr:xzuIat8nn8vxcLyjvU-PUwhAGkBqmf94OXOtZqUzKmXRBrPwhH3-GylGf1g>
X-ME-Proxy-Cause: dmFkZTGkobwOJDXfmDVQnTznTajLF1+gng1DwxP4wyWzTCBiX4TmWfUTIIyia2/B+dSgwA
    STm0VnjeA3gf6v/mcV6BalUqH8ECjST+EleofvJRKrsyN2NupbIpJquZovYUNNk0U6Eomu
    WhAtF5pnbt7hYJtbns0BYqJTie5NhdvuO1mhJgr4BELW3bCr1zqqvJcro1IQSF2ZKXB8DA
    0OQXpq/9SOu19gzyOKSjGFBwxEyH+DhBFMLo4iiWifqLV5zkS/ouYeekSqXQFPoPPchPlr
    CO74nMl7Eikd90vhEMTpNsEBcdkVE9IgK4oQEB2sJSIkY/Pecf0l2qm3eHkbY8CRnkxRdQ
    5JCqN3LVGR8BRgIFSZ3MsakQ5IXa7UU/uv4Y1/kU6PoC7jhSmdoDZOAxAWyiakOKUJ6UKu
    EcX3j/zjIM8WAmWhziX24j8dcoJUnn3l13AJ4oN1zKBwmBvCHWK2SoNIvxbme+VmL6x53X
    I7ONH4f25zJDU9t0KejOxyWwabWZGwjKWsi/BE+TY5HeArEUswR9Bu2dK4iei6/6AXhlIQ
    5SkNJohggZqlHZgpYtWTZxnvPK2oqQ5F8MvAn1xG8iraX6BbsKZltxe1gP/36QTzpJdAS1
    E1ApgNmjYzxh0z7R6fhuUKPP7EQmUhDqtbi+YsifOzYWAThUnXMcA52KK1sg
X-ME-Proxy: <xmx:xzuIaqHsbj7vVwwwNp5W5D_DmYi4s0cMkJC0VbwGkiydyrbzCFyoAg>
    <xmx:xzuIatO-Aystk8z6Aej9SnIgmw1uvm2drJdWm04g2LCTwBoQmuDE7g>
    <xmx:xzuIapQD7IO_EW7A8eUz_MZhoL7Hoe-6UI09xnUnZDyGBUtBzmxlEw>
    <xmx:xzuIakTn9SQe7ZjkAN0tZ4IiQMaplFTVPI_umTFY2LBN2VE9KiWOYA>
    <xmx:yDuIajbvORkshWti5lpU2jvUvh80MNtzsmL4ltiYN-8XSzWRFfDjgs3P>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Aug 2026 07:51:35 -0400 (EDT)
Date: Fri, 21 Aug 2026 12:51:34 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rmikey@meta.com, riel@surriel.com, kexec@lists.infradead.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] efi: add the LINUX_EFI_POISONED_MEMORY
 configuration table
Message-ID: <aog7bwfMVpSy9LcY@thinkstation>
References: <20260821-hwpoison-kho-v2-0-5743791e48e6@debian.org>
 <20260821-hwpoison-kho-v2-2-5743791e48e6@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-hwpoison-kho-v2-2-5743791e48e6@debian.org>
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

On Fri, Aug 21, 2026 at 03:06:02AM -0700, Breno Leitao wrote:
> diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
> index 29e0729299f5b..69c0dc02bc112 100644
> --- a/drivers/firmware/efi/Kconfig
> +++ b/drivers/firmware/efi/Kconfig
> @@ -263,6 +263,16 @@ config EFI_COCO_SECRET
>  	  virt/coco/efi_secret module to access the secrets, which in turn
>  	  allows userspace programs to access the injected secrets.
>  
> +config EFI_POISONED_MEMORY
> +	bool "Carry hardware-poisoned pages across kexec"
> +	depends on EFI_STUB && MEMORY_FAILURE && 64BIT
> +	help
> +	  Record page frames that are hardware-poisoned while this kernel runs
> +	  into an EFI configuration table, and honor that table early on the
> +	  next kernel so a kexec does not hand known-bad RAM back out.
> +
> +	  If unsure, say N.
> +

Do we want to make it conditional? Maybe just for everyone with EFI_STUB
&& MEMORY_FAILURE?

Where 64BIT limitation comes from?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov


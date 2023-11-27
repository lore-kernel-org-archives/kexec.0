Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98327C07CB1
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 13:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rwTQlXP29TlbYl0MK7QQ4W71XyXN9o3AbqEDDtJqR3Y=; b=u0aszRRmRJwk6M
	YfyH3JSuq2LIeaITtEq47REkwdo4KtO1zeKZZ+DXO77vBk9r4fVRy6DlgI0/eMWkoNnNuYvv0yJOm
	wtXmOSJxsUyBxcizdscfEWH9LqOM+Zas/JtcGrH+zVijG3rQYbQwwhZ581z1tVv/LgOeT88ynCJKb
	/v8j3IIhogYQu1F6sgfLa15c+o7U09wjwB8VkwtWghvDHlNeHGIVVbJgbkdYObYcQ+BIKySorwpyk
	TVPjHqk7FPGwE/PeIEFBAfiQepRo4uqH+L7SFAx/YlNXtIJc+na2g/OQtHziAncBv5vWQLXpUdO/G
	kTESUaPN/1/CbJEKrWdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bxl-002biQ-2w;
	Mon, 27 Nov 2023 13:47:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bxj-002bhq-0C
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 13:47:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E49CACE1251;
	Mon, 27 Nov 2023 13:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491CAC433C8;
	Mon, 27 Nov 2023 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701092857;
	bh=NrT20HtgPAKNAcpYSWPxVxIFFx+s+6QyE4ixRpcbfgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adfF7phyCKlAoqXsk68Z6tDLgNljlzQNuUMuQNSM8pc5OiaLsqUBIHDnPuNgGkc8a
	 2k5ASmOEITQgDYAnvkcL/clY/6N41uPGQmncg+PUEanWYA0iKJEE/UVUwMDvQUz5Tz
	 6g2865tL3ObdhLTu8AO6ZdjyhqYe3bnF22q2O9neYAugKnpfeFdKJ4MdHOKRwULT5J
	 9gGX8IVi4CTf5s+aSBLsA4BvoJ/Heyo+cul7H5GJY4+U7d/XwoRK8Ojq/EL71vYdlm
	 UBOYJYMEcEIb//QktXwy8ojcl5EH+s1eaQV4BPQa+So2UDok2cYWwW0l/fnfhcXMPf
	 62POfmB0w3MBg==
Date: Mon, 27 Nov 2023 13:47:34 +0000
From: Simon Horman <horms@kernel.org>
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Varad Gautam <vrd@amazon.de>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] LoongArch: Fix an issue with relocatable vmlinux
Message-ID: <20231127134734.GE3354982@kernel.org>
References: <20231124085410.107080-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124085410.107080-1-wangrui@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_054747_282269_99CE8572 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

On Fri, Nov 24, 2023 at 04:54:10PM +0800, WANG Rui wrote:
> Normally vmlinux for LoongArch is of ET_EXEC type, while if built with
> CONFIG_RELOCATABLE (this is PIE) and Clang, it will be of ET_DYN type.
> Meanwhile, physical address field of segments in vmlinux has actually
> the same value as virtual address field.
> 
> Similar to arm64, this patch allows to unconditionally skip the check
> on LoongArch.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1963
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

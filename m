Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0D5C001B0
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 07:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2S/neoU3HN4pofD9JCD1cz7Q23geEhoBRrPzOlLCF0Y=; b=auDGJtFVsfu7/P
	Q8qcbCtDiBVEoRgprkWs+9tBMbALig4NNvMTIOl1gGruRLoow9AZKWuE8XIJ5gwisRH9KzVDr/hBH
	2kE24W0znPUYCD+n2FsIRwXVrFcS06cWQVAEcA4sP+XtZaLkAYs6f2vWDxpj+VrI6Q5DOsxzohetx
	BDlOfrpVMhsGATzDTBtd2Du/bLyRICuOpf2D1ZRFY3mMuDqwdgw06lgomd2lHcJ+xB7v2YJq4d1H9
	bLEG1bQlYWs7lBbUAjKBxGIdq6frunuWi0VntsuaetZjV+P/17EyAlvNyi3BcqKrJodpabXVGqK9f
	KoFdjUjfNuKlJQ7T+Fjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUMaM-009kVN-1p;
	Fri, 11 Aug 2023 07:29:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUMaJ-009kUk-25
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 07:29:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 23FEE63354;
	Fri, 11 Aug 2023 07:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B90C433C8;
	Fri, 11 Aug 2023 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691738962;
	bh=XJU+LlVLWapnhz/8gPxmFI6uCVjVGrIUpoTjrOxlv8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WCtxHZ+id3y01wWtXXyJ6ABkrEA07D4v/raYyCTeQYZ7Q2W50CDxDDmbXOoZuM/Xl
	 /k+m1pRpVvCOpWirEWERTzBPtJ4xOhEcdZU+jqYkS+HnndpZX2kfx4RZe1uIwY/lO7
	 jACQ3lzQQ3NgOcqyQbOtyJBsYaaNS2Oxh3ETWrO/llj4eLQIdkC9391bF/yDSek57R
	 7bwyo0n/j358jJQbd/63x51Vtpx2HVK3KrZpZccP28QaccDwQWMi0LK54Orf40x+z5
	 XQ5zncJvAuhNwS4JbmulGhgSJxrPbiA2Uf7+I/rd3575TO1JfnmcRDl/obOdkKJ1IG
	 EsfAvfmALVa3A==
Date: Fri, 11 Aug 2023 09:29:19 +0200
From: Simon Horman <horms@kernel.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, root <root@piliu.users.ipa.redhat.com>,
	Dave Young <dyoung@redhat.com>, ardb@kernel.org,
	jeremy.linton@arm.com
Subject: Re: [PATCHv7 0/5] arm64: zboot support
Message-ID: <ZNXjT8J2UCktknRa@vergenet.net>
References: <20230803024152.11663-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230803024152.11663-1-piliu@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_002923_746169_226FB161 
X-CRM114-Status: GOOD (  13.00  )
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

On Thu, Aug 03, 2023 at 10:41:47AM +0800, Pingfan Liu wrote:
> From: root <root@piliu.users.ipa.redhat.com>
> 
> As more complicated capsule kernel format occurs like zboot, where the
> compressed kernel is stored as a payload. The straight forward
> decompression can not meet the demand.
>   
> As the first step, on aarch64, reading in the kernel file in a probe
> method and decide how to unfold the content by the method itself.
> 
> This series consists of two parts
> [1/5], simplify the current aarch64 image probe
> [2-5/5], return the kernel fd by the image load interface, and let the
> handling of zboot image built on it. (Thanks for Dave Young, who
> contributes the original idea and the code)
>  
>  
> To ease the review, a branch is also available at https://github.com/pfliu/kexec-tools.git
> branch zbootV7
>  
> To: kexec@lists.infradead.org
> Cc: Dave Young <dyoung@redhat.com>
> Cc: horms@verge.net.au
> Cc: ardb@kernel.org
> Cc: jeremy.linton@arm.com

Thanks everyone,

applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

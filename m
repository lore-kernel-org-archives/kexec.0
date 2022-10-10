Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3A9C433FE
	for <kexec@archiver.kernel.org>; Mon, 10 Oct 2022 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bQnudYTq2MMGrmgY7HJRgEsw4Vl/quZM/HuiL/eU3mM=; b=uQVRZoJbsQw1pi
	EG6LCque5aLyDybif8eWerzuEUFef5TjQ/7NTZ1dlxJwFJQwMnDJXAgvipdxOOz/8FzTJaOgf2k4q
	NQpYMTxvbRxhLOWUqcWXZGr4NlPCQsBy0S2VspD5K266pv1KmFwtJW3ASSmUMQywkBMjowLZ00RaW
	ehCu1pyLzs+e6CnYXrWUCOOPMNWIU+2sEskMgXSlqd9Ne/o9v8SWkj187G1fXfODBUiIIWKSmxxKD
	JInDTdbuRLTG8EGG0IHLgo5VQ4EZ9dBcqNxWCLG6Rlf4WkZ0upwwXKOasmk82koOnnV3Pp2FHbWb/
	utHt2FViUv16dJwISk+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohr9H-000eyg-PE; Mon, 10 Oct 2022 11:40:43 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohr9F-000exd-Q6
	for kexec@lists.infradead.org; Mon, 10 Oct 2022 11:40:43 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 2E575201F5;
	Mon, 10 Oct 2022 11:40:40 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id CC524940241; Mon, 10 Oct 2022 13:40:39 +0200 (CEST)
Date: Mon, 10 Oct 2022 13:40:39 +0200
From: Simon Horman <horms@kernel.org>
To: Youling Tang <tangyouling@loongson.cn>
Cc: horms@kernel.org, kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/5] Add LoongArch port support
Message-ID: <Y0QEt+I83ZaauIXK@vergenet.net>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_044042_014026_63A8DBBE 
X-CRM114-Status: GOOD (  10.19  )
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

On Wed, Sep 28, 2022 at 10:28:21AM +0800, Youling Tang wrote:
> This patch series to support kexec/kdump (only 64bit).
> 
> Note: Kernel kexec/kdump support patch see link [1]:
> Link [1]: https://lore.kernel.org/loongarch/711d53ae-197f-3c55-d09d-2f40e6886ad1@loongson.cn/T/#t

Thanks,

applied for inclusion in the next kexec-tools release.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

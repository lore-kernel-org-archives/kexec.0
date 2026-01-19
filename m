Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE24D29C5F
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:Cc:To:From:Subject:
	References:In-Reply-To:Message-Id:MIME-Version:Content-Type:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xd19iBrzMdVGEeafBzO56LEMolluLa+EOtluiswiFOE=; b=eMTCHD6Ou+vghPMMeFNjQmZ82h
	xLndg2Wy65/UKqUNkhaQQGF98NzdW3N+9GRynPD7g2wIzb4HIe106T7XhT42h6gT8z8a2hx/K+EA8
	vdtTvNLOC55pQLrUn2Ey/py5oU4dn0FINswooOp/AKM17n6+awUJz0jP3wmjLCD9zwcm61Q5S8Ujf
	95Elg7Oe6f2mkxlAfzIqpRGCnkyc/PhAg3Ze05jkUGKFiM/wHqUaApP4UrJ1sCBhbA6I7VDNsJcqh
	VCbfgGbrSwesCbfQLWZa6jXte+mmcWfoby8v2QLamTmofRarAd9gmJfsOlxgt/EwAjxeIZYuNfi//
	Xxu16HBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFz-00000002jXC-0ZdZ;
	Mon, 19 Jan 2026 18:45:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhuFr-00000002jUp-3YKz;
	Mon, 19 Jan 2026 18:45:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D33A4350C;
	Mon, 19 Jan 2026 18:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93C6C116C6;
	Mon, 19 Jan 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848335;
	bh=jxu3eTAwyA2NAtvN2VNWTO4OGoQkK4jbDsTaUMknlus=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=aLjDWbAZdWltMpcE4zLG1u/iOOMI+ZSMLlNhrJjHget/74Dcqrt8yJ5KfW8SQ2/C/
	 gknsRai814YABrFEGJZPKfyOZ6DB9si2gCySknq4CVl72xp1H6ahTlQ4bptnZNU2xT
	 3XdxO1gkcPr+o/qrL9SNoiYTRID6RKtVlv+nbjbA6v/7VjcItwNT61BdZQclR1+6/O
	 jO41R6ZZSRxD1pHF0tC8RkXrA5i+GEBhMNbpXQuntauAeKK+KSI/Ko58LfWrB60G+e
	 AA3pWRlH+UJ3a3wCNPzPfHkY367j2Dlst7rZ2Qil4kQBF9bAorBk8gZYCZBJFQ1mQx
	 ZQ3eDNygL4EWA==
Content-Type: multipart/mixed; boundary="===============7696574795954163466=="
MIME-Version: 1.0
Message-Id: <2d40ab992df9466e9d09c1132deda3b362de58b3b22f938cf4beae7d6398bf18@mail.kernel.org>
In-Reply-To: <20260119032424.10781-12-piliu@redhat.com>
References: <20260119032424.10781-12-piliu@redhat.com>
Subject: Re: [PATCHv6 11/13] arm64/kexec: Select KEXEC_BPF to support UEFI-style kernel image
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,linux-arm-kernel@lists.infradead.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,bpf@vger.kernel.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:34 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_104538_221520_9B1FE342 
X-CRM114-Status: UNSURE (   9.42  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

--===============7696574795954163466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 93173f0a09c7..922d58abbbd6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1587,6 +1587,7 @@ config ARCH_SELECTS_KEXEC_FILE
>  	def_bool y
>  	depends on KEXEC_FILE
>  	select HAVE_IMA_KEXEC if IMA
> +	select KEXEC_BPF if DEBUG_INFO_BTF && BPF_SYSCALL
                          ^^^

Should this condition also include KEEP_DECOMPRESSOR?

In kernel/Kconfig.kexec, KEXEC_BPF has:

    depends on DEBUG_INFO_BTF && BPF_SYSCALL && KEEP_DECOMPRESSOR

Since Kconfig's select statement forces a symbol's value without visiting
the dependencies, this select will enable KEXEC_BPF even when
KEEP_DECOMPRESSOR is not set, creating an inconsistent configuration.

KEEP_DECOMPRESSOR defaults to n and nothing selects it, so this appears
to be a missing condition in the select statement.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============7696574795954163466==--


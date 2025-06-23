Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD9AC7115B
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 21:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5RLs7vhCp2JvAQcNPNpdFeFKd25Vxn0BijXRvnGznU0=; b=Rr9e4+hZxbBy0IZLQ4ea3DIPth
	WYKpk1P1ThMU0oLrE0hv+X5n78JfpZ+qC/iaDTQ3DWcYHY7vta4bbIZX8LL/hYsgoLnZeNkXjzbs9
	8jRvv2QHegF44U8idCECmpQA5mnDSB1N6z0jbGWYKgjzCpk0N3G65qCgpHfH40HkYuJJUqc6Pg1Ws
	kg58T6VBpsn1sXHVrzi1IcMBc+vIJl7frlENdhD6RVCoudgtR2pTTJe6+Sb++2TUn2fTgtaOL7pou
	RHw8G+ovIEmiBFL1MQiEg/l+9tsZyB+/kwa35psEA5RAl/3Gys0wyX/4/zyxhxa9aJex9U0Iwr5RV
	XKoZbjjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uToRH-00000003z3t-0WIC;
	Mon, 23 Jun 2025 21:10:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjoj-00000003NdI-1hgT
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 16:14:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8077E441AF;
	Mon, 23 Jun 2025 16:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965E5C4CEEA;
	Mon, 23 Jun 2025 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750695284;
	bh=xgAu/9gItDnhFNgg/CNV1ENvMfxw64xm1sGOq39KEkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVpLnlnui800XYRqn3TdXVFfl1Ra00MRvmDyXzXPaC/RSwt/xNz84OS+mEd5mnA72
	 WjtfWKEAdTs8fPiM9Ymfs88e0MNwuPCwwb5rKLWd6eVXSqvB1usiyMkiQNC8uWTqA8
	 rkgbPeypnQRxPoBkX5DPFG1D8CpAX8j8t0Vtt7Wfv7a/mpul9JHW0HgO6thyGGbmy+
	 rNV5nNRqdGsdsyfhx+44eMyy+soedzYTv1Kczy94RX3S+6i8sKEgQYpEFggekuNv7c
	 xKRpdtPIHPpt3M8Dp0woHeq91+raWGF4bH+uk178g8TeE7DbxS2TwquI07u3E2rL18
	 30LeNDPjQepcw==
Date: Mon, 23 Jun 2025 17:14:41 +0100
From: Simon Horman <horms@kernel.org>
To: Nicholas Sielicki <opensource@nslick.com>
Cc: kexec@lists.infradead.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [PATCH] kexec/zstd: fix static zstd build
Message-ID: <20250623161441.GA506049@horms.kernel.org>
References: <20250622131253.34886-1-opensource@nslick.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622131253.34886-1-opensource@nslick.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_091445_471713_451029E2 
X-CRM114-Status: UNSURE (   9.57  )
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

On Sun, Jun 22, 2025 at 06:12:53AM -0700, Nicholas Sielicki wrote:
> 60ce9bdf introduced a local reimplementation of ZSTD_isFrame to this
> tree, as the definition in libzstd is only available for static linking.
> When a static build of libzstd is in-fact available to kexec-tools, this
> was previously causing multiple-definition errors at link time.
> 
> prefer the ZSTD_isFrame from libzstd, if it's available, by adding
> __attribute__((weak)) on the local definition.
> 
> Signed-off-by: Nicholas Sielicki <opensource@nslick.com>

Thanks, applied.


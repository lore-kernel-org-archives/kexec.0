Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674DA60A2626
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=el/LWvcr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTWwkw3l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=b02zfFPf9b0XDVaMrH0fAXR+m13g3Y0ms3cq/hmMcX8=; b=el/LWvcr4tFN1zwzJxPCkP2yDo
	EL16zGAeJFkrzmKXzCc0ZszK0rnfc8E5AS9Z8e+uLvNjHQJfcDzM0I+6PRfHqmrIHSaMZSEYHM1HX
	3r1GJwnAPUlPpgUtR4nlushnSyAg/WmTKVDq2Ht08nbn31C5KyK276oAzpovWuku1vJ/1FMYkm1e2
	TlipUGBd0XSgD4fpnodq8BZOFGWaK78jezghUNbB+hy3qg6Q6/m0OSGJMZVF/Kki4xiZagezwrkIb
	m6BSXXfgTSNlpROV9T6hsp1pJwK3vVP09RDEM9p4xM3IcHt+mD2O4rVdaWSu0AmCLiAwZ62RTZKaY
	IztYJDMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlNZ-00000003vdM-3tEz;
	Tue, 10 Nov 2026 12:55:13 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQlNY-00000003vd8-3ICP
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 12:55:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E2DD06392E;
	Tue, 10 Nov 2026 12:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2DA1F0089F;
	Tue, 10 Nov 2026 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794315311;
	bh=b02zfFPf9b0XDVaMrH0fAXR+m13g3Y0ms3cq/hmMcX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QTWwkw3ly+ABT69OfZRrlkOpFN19qi/y9ZgZgTSy1XxCZceUllPPUhWRaCI4rHL4l
	 dVQiDuh+i0XVTl15ft+R0WdulNNiMkioPhjKxhtHkOVibwW11CYvR3YRM+CZmRp/zq
	 8jZiapCU1jn5G/p7W0Tc6ohbptll7UdBRGN/WfgVgrVaj4qSL8IPq//KRrt3zjqimd
	 Rq/nXOFIE+WaNK2WBDleOa+DqV6umwLItLJwQPMbuyLyB4DaJbkbPdhbNSBbERORcF
	 L716THqHiQt7xddUdlYvl9k7lSrHoSrz4bNZUaV/+aH4zNMqLcFsaWe1qZNSzGYABm
	 8qBjGpNdsezqQ==
Date: Tue, 10 Nov 2026 12:55:08 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?5byg5a2Q5bq3?= <zhangzikang1992@126.com>
Cc: kexec@lists.infradead.org, zhangzikang <zhangzikang@kylinos.cn>
Subject: Re: [PATCH] kexec: fix stack buffer overflow in update_purgatory()
Message-ID: <20261110125508.GA369680@horms.kernel.org>
References: <20261030030917.103293-1-zhangzikang1992@126.com>
 <20261110105841.GA1320297@horms.kernel.org>
 <20261110112151.GA330449@horms.kernel.org>
 <61359f90.7bfb.1a1c57577b6.Coremail.zhangzikang1992@126.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61359f90.7bfb.1a1c57577b6.Coremail.zhangzikang1992@126.com>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 08:36:12PM +0800, 张子康  wrote:
> 
> Hi Simon,
> 
> Thanks for your review and for taking the time to share your suggestion — I really appreciate the detailed feedback.
> 
> I did consider adding a die when the 16-segment limit is reached in add_segment_phys_virt, but after looking at the overall design I think the current approach of printing a warning without terminating may be the reasonable one, for two reasons:
> 
> 1. KEXEC_MAX_SEGMENTS in kexec-tools is only an expectation on the userspace tool side. Printing a warning and then letting the kernel perform the final validation and return an error keeps the flow complete. If we changed this to die, kexec-tools would exit before even issuing the system call. Although the outcome is failure either way, what the user sees would be the tool giving up on its own, rather than the kernel explicitly reporting "invalid argument" (EINVAL).
> 
> 2. The value of KEXEC_MAX_SEGMENTS has historically been increased from 8 to 16 in kexec-tools, with KEXEC_SEGMENT_MAX on the kernel side adjusted in tandem. This limit is inherently arbitrary, so in update_purgatory merely avoiding out-of-bounds writes and emitting a warning that the region limit has been reached — and then deferring final validation to the kernel — is more flexible than a hard termination, and can accommodate the actual limits of different kernel versions.
> 
> Please let me know what you think.

Hi Zikang,

Thanks for the response, likewise much appreciated.

I understand what you are saying about the desirability of the Kernel
enforcing the kernel limit. But to my mind we the kexec-tools limit is also
a limit, even if it has the same value as the kernel limit.  And it is
appropriate for kexec-tools to enforce the limit it has.

I think that if kexec-tools used dynamic buffers, and thus had no limit,
then we could happily leave it up to the kernel to enforce what would then
be the only limit. But I also don't think it's worth moving kexec-tools to
use dynamic buffers to achieve this.

So I do think, given the implementation of kexec-tools, that the approach I
suggested is a good way to go.


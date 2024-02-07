Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDC9C4828F
	for <kexec@archiver.kernel.org>; Wed,  7 Feb 2024 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ChTzD+keU08uKgQWnIchvou3DXOvsWvFAbxKPzmJyGU=; b=oZwp9CC20vRePv
	D6VAF+2pKXaW7b3O+dg/WH32rq2KOB8dKjuwAQcKuxENorap27121unQFYcyZ9VZKDX1NIstqzl1/
	48I2WFCIP2KmfKpD1dWoehAZDHNRG2TKZ4TXtZWREoWvBA2bJHRxJ0YEZ/yBerVNVqSYwm9GKqiee
	8+2Nd5CnTu2OZoUnt36PDkc3IohaETkIwH40qOz9c3m/U5HNIOtgH24AK12KE23HIxy6ISVjmOR0R
	1qtuDRM+7MpMdrsfU/bpuqZwxeIj8P3B39hOsDZYZ84xUR7z4e2cXQ8mFvvsPdyTmJ5bFOpe1DA/t
	60CjPRxuFP60KqYqUmcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXegN-0000000AH92-17f9;
	Wed, 07 Feb 2024 09:57:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXegK-0000000AH7k-36Ya
	for kexec@lists.infradead.org;
	Wed, 07 Feb 2024 09:57:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3976A6178A
	for <kexec@lists.infradead.org>; Wed,  7 Feb 2024 09:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E98C433C7
	for <kexec@lists.infradead.org>; Wed,  7 Feb 2024 09:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707299848;
	bh=PyDTpUKdhgJeTlQoSwz37m2SyCMImAhHELENtU8whAY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=SIlIZvSYqsUn9g6TDsjreGKqm1r+IJkh24/5nVlhPHb8r1Rzxn1gm1bjvPbdVLiuC
	 +1bDdyEYV8ojuvoOOzWUoqkUahv1jaSl4XZHTFHiq1kYLyTXHl57Ku1VO/fNu7VHez
	 zxmitg5h3Hy9vi+kj/WOaL3kuUZ3HhYEvV4uTGvOl5hR4fcCAvuXK6HDzVWMILntnW
	 T6drg2uHvNZS54HwXRTLsB+Jt/8zfowuRoGCCggvZ4Rr+Q/PPWrAF5pIQSN2aa7iZC
	 pT+Gg65fbAxyBKVkvxpI4THPFxp7NXiuujjgJ+9oTzcHd+XlHDI/opys6S51Wp8Pa9
	 12Sr4Ubs67Akg==
Date: Wed, 7 Feb 2024 09:55:55 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: Re: [PATCH kexec-tools] workflow: update to use checkout@v4
Message-ID: <20240207095555.GP1104779@kernel.org>
References: <20240202-checkout-v4-v1-1-43e56cab30c8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240202-checkout-v4-v1-1-43e56cab30c8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_015728_840896_37C4009E 
X-CRM114-Status: UNSURE (   9.89  )
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

On Fri, Feb 02, 2024 at 09:55:41AM +0100, Simon Horman wrote:
> Update to use checkout@v4.
> 
> This addresses the following warning that appears in GitHub runs:
> 
> "Node.js 16 actions are deprecated. Please update the following actions
>  to use Node.js 20: actions/checkout@v3. For more information
>  see: https://github.blog/changelog/2023-09-22-github-actions-transitioning-from-node-16-to-node-20/.
> 
> Link: https://github.com/horms/kexec-tools/actions/runs/7753454923
> Signed-off-by: Simon Horman <horms@kernel.org>

Applied.

- workflow: update to use checkout@v4
  https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/commit/?id=6ee2ac1bf739


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

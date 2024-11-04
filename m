Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB84D1BDE7
	for <kexec@archiver.kernel.org>; Mon,  4 Nov 2024 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MUgN7GiKrXwhVA+SsktbRGXRgvN6sfpekrn+Q36VmPw=; b=uchmF2kuzkdx6L
	3bwc68CDlYchTjpovzJ7YUMeVZckpQw5nluZjbtO5lpOM5np2pxQowz6pqpWP5SCvwCxEmlFP7Ec2
	eV4c4Eqy1JanpoWxopVhXjWQDS/hFSoOsLznkP6PntyUXhZvn8YlWS61Rj8wpMGkH+6lM2YEx3zPp
	oB7AvU8swjApwZ7dMbMHQlKr/+d3bd+uAV92WU27eA6eji2W64pwzu6mkz11t7Av8/7BcwOERGt2e
	ujownqOzNosg7QxNWRRBRwz+sSDFu49Isq+mr78LfLdvtXuJG9IRRE0Y1F32ZMX2j4G/s7/OnH5KN
	WZkdnd4xK3F3IbYrGYYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t82qS-0000000Euch-3w3L;
	Mon, 04 Nov 2024 19:34:36 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t82lH-0000000Etk8-2zVC
	for kexec@lists.infradead.org;
	Mon, 04 Nov 2024 19:29:17 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B99CA42C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1730748553; bh=/10lBdbCWP9c3Me7/mu9OI01ETDGMCC5hQMI8xKD5pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rPCgB/qlsGJ8NYn2P3Xu3eYnNHSDIz71O2zjl+/TLaJYiB8cb1gv6fLhBCYFvZL2T
	 k16tSJCFfOxT0OaBukHDepE0Z//EVth1mIXdZY/KpYfPVPQ8TUIHtEVyMXv1MTCGUz
	 Anv5+DJa751ezbTghlnHwmM4Umhp3zmiBayhls5ih4jGm4Wy5fY/U94e4QJofLDHY4
	 CoqsILds69cZAvUR/2Os1vbf6wdq30E9LBAbrFMTIYHCCEStNH43ovd6IzXyGmHFHo
	 8Rb9TiHvVE31b1deKd6yY3tGNAJHmp6nKaOoaI/KqkVWxcqmIuRFjkpG2Gx47B6phq
	 r0tShdfrs251A==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B99CA42C30;
	Mon,  4 Nov 2024 19:29:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH V4] Documentation: Improve crash_kexec_post_notifiers
 description
In-Reply-To: <20241027204159.985163-1-gpiccoli@igalia.com>
References: <20241027204159.985163-1-gpiccoli@igalia.com>
Date: Mon, 04 Nov 2024 12:29:12 -0700
Message-ID: <87ed3q94s7.fsf@trenco.lwn.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_112915_775931_4490ED98 
X-CRM114-Status: UNSURE (   8.11  )
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
Cc: kernel-dev@igalia.com, bhe@redhat.com, mhklinux@outlook.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, stephen.s.brennan@oracle.com, horms@kernel.org, dyoung@redhat.com, vgoyal@redhat.com, linux-debuggers@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

"Guilherme G. Piccoli" <gpiccoli@igalia.com> writes:

> The crash_kexec_post_notifiers description could be improved a bit,
> by clarifying its upsides (yes, there are some!) and be more descriptive
> about the downsides, specially mentioning code that enables the option
> unconditionally, like Hyper-V[0], PowerPC (fadump)[1] and more recently,
> AMD SEV-SNP[2].
>
> [0] Commit a11589563e96 ("x86/Hyper-V: Report crash register data or kmsg before running crash kernel").
> [1] Commit 06e629c25daa ("powerpc/fadump: Fix inaccurate CPU state info in vmcore generated with panic").
> [2] Commit 8ef979584ea8 ("crypto: ccp: Add panic notifier for SEV/SNP firmware shutdown on kdump").
>
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---

Applied, thanks.

jon

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B760A2607
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 22:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lfhlM3gB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cbSPmiLQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=akEMPsJB9+AibNGEOvtl6pJKQU1yi8jmiVK983AjHS4=; b=lfhlM3gBsSNndw
	EunW1E33bS2UkzJWl462PlCkDH6jz7vPAib0I2zHHA1uh0ihoAYJDoX83oNW3bd7XI3z3pJUNKC30
	jn0yXIFW7SN3yufcYb8iZiKWED3hTmZEwOQA0lruTZpgGMFgQijVP8O/NLoxaozqLKvjt+wRl2moo
	GaXwCPbxaASnYzfCxw6S3EMj1m52Mjxx//Nr13hzUKHWEW3bkPlMT7Kjefd8ZsTCGEwnGZJsCXjIy
	Dr3MJaA3FOKhWle2dtHWXOlff4efFLEfmVGaYGTPtV4JT9YWHub/IXuwSw/nUQ54/uuRnDOA0gq8g
	q3xIeRpJ+46Ts57I/3LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQuaM-00000005BPs-08no;
	Tue, 10 Nov 2026 22:45:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQuaK-00000005BPJ-2cJo
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 22:45:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 98324631EA;
	Tue, 10 Nov 2026 22:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2631C1F008A2;
	Tue, 10 Nov 2026 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350699;
	bh=akEMPsJB9+AibNGEOvtl6pJKQU1yi8jmiVK983AjHS4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cbSPmiLQR1y7hmFwvYRp1W+dD3VaFO8QTfcQMgkv0p3ZWt8AgWT8w8k+CI3Oqla+z
	 uNBZbqy9sBEymrcc3n2DziPV3QOWfUfbZ72eoC6SKN9nVK3lGwy5RjvBhmAlOqs9Sh
	 VTA++Kpf3gXVekGoTdui5HO1a1zuD7eyZRpobCC7HkXmA+KGFPBmlE8q41ICXzZ5Qz
	 t9QOrxv8KwkJp7CDewvgtz2NyppoEdueGF98bpVUOHUIghSTP+bDGrFKK7T6Mr1A7C
	 e1DYeOvqHejASBWfLBAZ0tQnOhgmy5gowH/LqhmhqM8+sc9h6zbVI3Y2ZEV2cyWbTc
	 csfxvMOutWKyQ==
From: Mike Rapoport <rppt@kernel.org>
To: akpm@linux-foundation.org, baoquan.he@linux.dev, 
 Dave Young <ruirui.yang@linux.dev>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <avFSU0f0aE-amdls@darkstar>
References: <avFSU0f0aE-amdls@darkstar>
Subject: Re: [PATCH] Remove myself as a kdump reviewer
Message-Id: <179435069079.425130.11540887283084366426.b4-ty@b4>
Date: Wed, 11 Nov 2026 00:44:50 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.1-dev
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 12:55:47 +0800, Dave Young wrote:
> Remove myself as a kdump reviewer

Applied to kexec-fixes branch of liveupdate/linux.git tree, thanks!

[1/1] Remove myself as a kdump reviewer
      commit: ab75132e99eb0b7dcd3a1882e35519f8229a669e

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-fixes

--
Sincerely yours,
Mike.




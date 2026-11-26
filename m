Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390D606A688
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 11:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=REEWOEdt;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVTmWd+T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SuAWMmZdzveERe5wGAvKIhuET3HUUjSDoRGpZWpoiN4=; b=REEWOEdtt21WjT
	rkG0gInLIj5/XndeTOKvJkfFqWJX1RkDbEpzYA+lUCF6suJqJAZhobtouX3e7q93lWO2hzuF3qCzf
	qDN+AM1gY4PhuxfrepSqWNXyJgmD930fe+y5lzq2I9BYntAiEdlsG4O7zCwASMJGNDi1hjEAriuHY
	HezIlH89mKvwpk37FGNkkW5JyEZf5yo7x6NG7pe4pBmmhl6KWWdHHmejsAvLP4pTPsonFoD62BuwZ
	CoaaiJYXIHI42KtNf1xNBFFJ6xdpktQvrUx2nRhy4sQ8LoikLFDkkfnYFH5fZq1RdGNWm/+65w9LN
	gn13JDDdrWBfd1nMklaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXvS-0000000D3Oh-3rGT;
	Thu, 26 Nov 2026 11:46:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWXvR-0000000D3Nk-22Ht
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 11:46:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8824C6284D;
	Thu, 26 Nov 2026 11:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241731F000D4;
	Thu, 26 Nov 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693564;
	bh=SuAWMmZdzveERe5wGAvKIhuET3HUUjSDoRGpZWpoiN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVTmWd+TjuqmNcuaD+3/boezFDT3Nb6MZaU90+QdbhN/8bMRCxpwD+LvHpSYkK3u0
	 rmkBKsswjbVOYtPNYUmksxY/x1xDKhTP0DjoX0YTId+v15cdlErKYzgnD9fhSac0A8
	 K2jBDxZeemK7Cic3hbqSyJc95cJwounTOi3gdv1xJoxCWZQKlk62WSE+KHafJAEL1E
	 VLlUIW688QTgH8HF1U7gcJzZLZZ1VUOpK0Nrh7gzSdrT2n9OpvedTGq8dyxovrusa8
	 UXxbPxgaFRq7jydsOcqX2Qw7z8M2Ro8Dx4TJvbPdGcVc4bQjoUGdTa69xUp7EMnRi6
	 s7ahSM5UYJCkg==
From: Mike Rapoport <rppt@kernel.org>
To: pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	Xiaotao Zeng <zengxiaotao@kylinos.cn>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	duanchenghao@kylinos.cn
Subject: Re: [PATCH] liveupdate: drop redundant lower-bound check in luo_session_ioctl
Date: Thu, 26 Nov 2026 13:45:57 +0200
Message-ID: <179569355390.4110848.12568494599034735951.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120075252.684604-1-zengxiaotao@kylinos.cn>
References: <20261120075252.684604-1-zengxiaotao@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Fri, 20 Nov 2026 15:52:52 +0800, Xiaotao Zeng wrote:
> nr is unsigned, so for cmd values below LIVEUPDATE_CMD_SESSION_BASE the
> subtraction nr - LIVEUPDATE_CMD_SESSION_BASE wraps to a large value that
> is already rejected by the ARRAY_SIZE() upper-bound check. The lower
> bound test is therefore redundant.
> 
> Drop it so the check matches the one in luo_ioctl().
> 
> [...]

Applied to liveupdate-7.5 branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: drop redundant lower-bound check in luo_session_ioctl
      commit: cba589505b0ec93075c6b17abf502a777f034133

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.



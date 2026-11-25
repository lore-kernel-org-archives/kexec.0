Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371A606A681
	for <kexec@archiver.kernel.org>; Wed, 25 Nov 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HnNj70FN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/u5PWkt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bUA/rTYvpBA7QiSm2QIxyI9jS2aZK3LguZKch6uReEA=; b=HnNj70FNW071Xj
	CVm1MKLJkdlxljKbF4vLgg3WQzHJRfr4VDcsAs2Uf3u0IkSQY2PjvJc7ASjz1PY5gyLyd2s6dd4mI
	OAfrI7Urqk8VuZZjcX9237Dbj6T7wJ1P6rWFVZSXMUrvKTxo35QLGxJhqBN0v6B9LUgmrFS5uzGhi
	py1O1EVmJXX98Jo8AXLqL8bAVgzRmMqkyTbL3c/I27JsogFs0BhBZU86JcoJBrzlFZD0XZvLkVnxx
	iRytBgcRAy+a5V4BrVa+5wW+ExkWej9uyQ/9lOqtIQ4MSB2RxPxz/theXY69OvWo6o/kLZYHSGlPH
	RBqRJqX0G5hGiyqi5lWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAna-00000009XUk-2AcP;
	Wed, 25 Nov 2026 11:04:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAnX-00000009XUJ-3zjJ
	for kexec@lists.infradead.org;
	Wed, 25 Nov 2026 11:04:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 35F886283D;
	Wed, 25 Nov 2026 11:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0131F000D0;
	Wed, 25 Nov 2026 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795604661;
	bh=bUA/rTYvpBA7QiSm2QIxyI9jS2aZK3LguZKch6uReEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/u5PWktp5kUyRuHcHkzj7sus+CpW2DeTbpNjtCetpIBLPYILSCpknyVhQtRr/DQt
	 aR38ubzw67fB+4RezvtuWdE/zgzAATh1emQrSrjFGeo3cinGGBMUPHaQs/DR01O2/o
	 C65jl9qlrrOcqGL02Tml+K/yS1E9kS3r/qDFRsQ6yx3aECBA5KFA+eeeXte2XXXT8P
	 RcI+5bK3PCFM5k4gig/bFtgdcnCCTTCUVrYzBCyr+DKoNvTnyjsTf/T36oT54BPSue
	 37usOl3yRSyKlP3ho4RxisxiECRsr4ydlSMegvN5j4y64D4aD+/lhzEa/b9yijPxFy
	 QhlOAO6sLV34A==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v4] mm/memfd_luo: don't use memfd_pin_folios()
Date: Wed, 25 Nov 2026 13:04:15 +0200
Message-ID: <179560454433.2878567.12692470017046498393.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124184042.1823277-1-pratyush@kernel.org>
References: <20261124184042.1823277-1-pratyush@kernel.org>
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Tue, 24 Nov 2026 18:40:41 +0000, Pratyush Yadav wrote:
> memfd_luo takes a snapshot of the folios in the file's mapping. To make
> sure the snapshot does not go out of sync, it pins the folios in the
> file via memfd_pin_folios(). The pinning also migrates the folios out of
> MIGRATE_MOVABLE to make sure doesn't land in KHO boot memory or in a CMA
> region.
> 
> memfd_pin_folios() does not lock the folios. So it can race with
> shmem_writeout(). A folio returned by memfd_pin_folios() might already
> be in swap cache. This happens to work but is fragile. memfd_luo looks
> at folio flags and index on a folio that isn't in the memfd's page
> cache.
> 
> [...]

Applied to liveupdate-7.5 branch of liveupdate/linux.git tree, thanks!

[1/1] mm/memfd_luo: don't use memfd_pin_folios()
      commit: da08a6d97880dcda906bce04539ab25c98b0fb73

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: liveupdate-7.5

--
Sincerely yours,
Mike.



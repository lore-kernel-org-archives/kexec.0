Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2FC79FA1
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHx3R7Rt9XHGk2xg3nZrHN0CgPQeIe8aRMMQ3cvQVWU=; b=P9Lmgvn0sg91B4sw4FRmZW7wFK
	jenHvKEUvJFEEnWE2SgPFg3iijL3OC5pClAnxpqsirHi0ZiFsm9IpNWyjhJJryCQxm3ga4ylNjJJ7
	KLIYlWhjktB7D5sw4rUgF7Bn+XIn1LHD/phzwWv8XPtxNFcdRNd6PnzP2xxVrtCUxcJ1KrlO9TfJh
	S+NY9HrAiiX1lqyXFWFssoILcj6XxrzYHQRp+YG5tejlCaYTf72fXgceaRs4yvpNselaANwpzxkZl
	MIltQ4FTQcmMVcwzQNsvEQrSPTSIx54eluu/upiC12dD+s8KP8Ghr3UmjqlnBpD3c2h3Z4mcnYmPS
	12HHmshg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46TG-0000000AXL8-3P6q;
	Wed, 09 Sep 2026 00:47:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x46TE-0000000AXJq-43RU;
	Wed, 09 Sep 2026 00:47:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41888601FE;
	Wed,  9 Sep 2026 00:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED531F00A3D;
	Wed,  9 Sep 2026 00:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914844;
	bh=dHx3R7Rt9XHGk2xg3nZrHN0CgPQeIe8aRMMQ3cvQVWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G8rtxluIO2w4CzoYHSSOKL3edTpbvQUpDVKnMZmAcFCphujLLnTe8UG148v5xKHS7
	 8zED6TooSXQ9Dl/R7H1U1eeaZ8bDxVd8PpojXc2oMjDjYgGuL2wdCQFeGGwFT2ysqG
	 4i1X3eIgVaHGtpHv7UaNdirJL9yA4xIizZE9AYnj1UiMTEM0wOnl4vAOfGTh1zL5ZX
	 yYmUvbnYxQUO8gkpApWJtT1O7PDZERgUKqhDtm5IOcj8aISNQm94eDR+D668TeIbXL
	 UvzUwcppEBgeoTCley4IWoU2pZtzFlx18RMWgCJmyrZS+hoEHinI7q5dMrvh6LBkqr
	 UW9bMPoDk/KBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/9] crash_dump: Only use kexec_dprintk during the
 kexec_file_load syscall
To: "Coiby Xu" <coiby.xu@gmail.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Jinjie Ruan" <ruanjinjie@huawei.com>, "open
 list" <linux-kernel@vger.kernel.org>, "Sourabh Jain" <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org, "Dave
 Young" <ruirui.yang@linux.dev>, "Baoquan He" <baoquan.he@linux.dev>, linux-arm-kernel@lists.infradead.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Will
 Deacon" <will@kernel.org>, "Pasha Tatashin" <pasha.tatashin@soleen.com>
In-Reply-To: <20260909003657.1570544-6-coiby.xu@gmail.com>
References: <20260909003657.1570544-1-coiby.xu@gmail.com>
 <20260909003657.1570544-6-coiby.xu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 00:47:23 +0000
Message-Id: <20260909004723.7ED531F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> kexec_dprintk will only be activated by "kexec -d" during
> kexec_file_load syscall. So use pr_* outside of this syscall.
>=20
> Fixes: 9ebfa8dcaea7 ("crash_dump: reuse saved dm crypt keys for CPU/memor=
y hot-plugging")
> Fixes: 62f17d9df692 ("crash_dump: retrieve dm crypt keys in kdump kernel")
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909003657.1570=
544-1-coiby.xu@gmail.com?part=3D5



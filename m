Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760D606A326
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mxFWGNrg;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KR3A9L0V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e3Vrgu8a6DhnD5x0zdlXCxiwJd6p3spzYZMPi3rDJIo=; b=mxFWGNrgp4VuqM
	wK8QMKx0qzA8NpmtnHhCvhfJT6k6WyR/fDn/MJQlOHrKEggqzTJJPffOqwDQ4R92YI/pAZIgKYVxg
	XInArEeU057IZIpVsgJtfx3kfo+mfnju6eMSLI/4miH/uUzrgxbn3BGxzb9myQNlzIifQfmYHceRy
	uiURn8nHVRS7SnxbO6n/UuAxFaZldTN3nnBfYjYzACorpl2j8PbFtGnmy7BE0zKW5bHEHFhhIfqQr
	6x6uuaK8zSZfiWtjMI7k4qfKh76usdnrDA2TnRIgOtmwLrv9N3FeLfwA6KX+lUCJVtjGa1HzrSCv7
	//euVDbUXD1KGPEMZppg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYlV-0000000DAkB-3FWd;
	Thu, 26 Nov 2026 12:39:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWYlV-0000000DAjv-02xp
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 12:39:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5693E41878;
	Thu, 26 Nov 2026 12:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37BB1F000C0;
	Thu, 26 Nov 2026 12:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795696791;
	bh=e3Vrgu8a6DhnD5x0zdlXCxiwJd6p3spzYZMPi3rDJIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KR3A9L0VZpKALooXFfJGBXBBHfYTm+/7kiZ8wlFcFuRXBWdBSbnZOIZVH5T6CHoa1
	 9io65Zms5anLjDPNI76lA/eFbZj5ZGRqdJdpqC9TyvMzMB/fNJBbFapBfnofiJnIq5
	 e82/+f61DkNp9WkroWudGo633awrt70wUvlcYtrrJrUDJcEVVNcrtwoSnnJJYMRGDq
	 8d4zS0k+WKA333Hr5nZmKhucdABm68ygQr1qNDIJ/D3bCD5ztXi7vnOGIU3bgnIcjq
	 idFd3omvBztPAhx5ho29H3sQ5Hs9PFSXYLejD40KvsxrHJ/TRjG2i2AOUwuYP4l2sR
	 ABJLoA2w3siAQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	Chris Down <chris@chrisdown.name>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3 0/2] memfd_luo: keep memfd frozen until finish
Date: Thu, 26 Nov 2026 14:39:44 +0200
Message-ID: <179569676808.4123145.16669613485216005083.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123130509.4032642-1-pratyush@kernel.org>
References: <20261123130509.4032642-1-pratyush@kernel.org>
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

On Mon, 23 Nov 2026 13:05:06 +0000, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Hi,
> 
> This series keeps a retrieved memfd frozen until finish. The main
> motivation is to let dependents like iommufd have a chance to acquire a
> reference. It also fits conceptually: finish is the point when the file
> should be back to "normal".
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/2] liveupdate: luo_file: allow keeping private_data from retrieve until finish
      commit: 407c72e5a9c329e169c5132557c905913116f04d
[2/2] mm/memfd_luo: keep memfd frozen until finish
      commit: a89b83c7a9571dacb10e757d9a7400a886b11bc8

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.



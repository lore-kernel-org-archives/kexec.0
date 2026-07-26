Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F02C531F9
	for <kexec@archiver.kernel.org>; Sun, 26 Jul 2026 08:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PyTNe/wP4dK9zJvFPt1+xa2X0L9wsLyFKMsBt48c8o8=; b=xAvyt4iSzam3SoW9wMZocwytE3
	ethoA/8Q+UYjtr/Ru8vqs2aknEPKsZavwnaqqzCst0lOxpVtjAtXqH6FsABbKrp991k58ygTltomq
	aaSXyXQ5on08uUleKy8cayDR3qrpapXnE5UrQoI9cBRRtjGE3sMlVvUo91jkkEyutOzatK7ksoO3W
	5wttGz4N6BerRz31SjA+8xIPp4qg3K4plllLGm5SVlus70lewVDefQ+H3Yrp4O0GhCc7ybhjV7L4m
	Uh2AbYW5CTa7M6gtjN1685DkmOVZNayjRdARWkfP0QtVM5LhlLLrUxp1dPjhedGWdAVe64FBSDfgU
	/Y4Vvq1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnuOC-000000011WV-19aa;
	Sun, 26 Jul 2026 08:39:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnuOA-000000011WN-1dHV
	for kexec@lists.infradead.org;
	Sun, 26 Jul 2026 08:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A36B7417BF;
	Sun, 26 Jul 2026 08:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8720C1F000E9;
	Sun, 26 Jul 2026 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785055153;
	bh=PyTNe/wP4dK9zJvFPt1+xa2X0L9wsLyFKMsBt48c8o8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fFDSuwxRDAIJWYcA+wC8tfxnYXF2mdc6VRujjn1cMx8aD0Ru+jnC1V/AjcZ0J3VPd
	 ofjhazwjA4wIayWEvEXSjDrLNqeiXmYzDt8MlbrBHPNpJLF1pqR70QMRPtCnV4LSA/
	 FxyWFva9hR14qQRzI8bbnjvOfXZL8dTsxoGAgwj8TWNsBgdBgJb+uoLPSKcKl4Jbey
	 vujtQkurmvXVg++L6lPs8gyTfudR58UOo7grnP6llchBWhtqssK1/Hbjm4PPiIlejq
	 0GN3TL5C8rm7OdSOZm5HnFkQeXaFJoJswXNclh29vT6glD6zl4n3jXg8TDfC9ZviAv
	 Ewu0STnRSOpVQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
 "open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
In-Reply-To: <20260723202912.1467112-1-skhawaja@google.com>
References: <20260723202912.1467112-1-skhawaja@google.com>
Subject: Re: [PATCH v2 0/1] liveupdate: Add internal APIs for file
 preservation
Message-Id: <178505509460.1083364.11626390494173240451.b4-ty@b4>
Date: Sun, 26 Jul 2026 11:38:14 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

On Thu, 23 Jul 2026 20:29:11 +0000, Samiullah Khawaja wrote:
> liveupdate: Add internal APIs for file preservation
> 
> Live update orchestrator file handlers depend on the preservation of
> other files. To make sure that the dependency is preserved, the file
> handlers needs to fetch the preservation token of the preserved
> dependency. Similarly during restore, a file handler wants to fetch the
> restored file of the dependency.
> 
> [...]

Applied to luo-internal-api branch of liveupdate/linux.git tree, thanks!

[1/1] liveupdate: luo_file: Add internal APIs for file preservation
      commit: f4d2e4f0d12d88155cd1128ed3294f7827bf4c5d

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: luo-internal-api

--
Sincerely yours,
Mike.




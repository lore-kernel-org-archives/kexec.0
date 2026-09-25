Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9562C9830D
	for <kexec@archiver.kernel.org>; Fri, 25 Sep 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JGrB5YYFveIwZSzWD+7LH6wodZl8bTW0nco8xHfgyM4=; b=CIlqZ0OtPGIAPi/4gHl0VYr5J6
	x9gOtN2Wdj8MYQsYANOzI7pFXmZSe2KWoXhTx1A9XINK5ngRKlfNnGfZ8GJrQZ73bFetWRbxktYYV
	ZyJtBr3tPU73j3JKST6TyKVcg9w7WMv3gYDHk8+0bGKg32llkr5G7tL4Zxu+J4u+Z4QAjbegH12e8
	R4rQFO5S/WbZCJx4absb96jdoTpGiYCUDM0xBZlIDixCevoj+W/vK0tK3Mz/SjoLjhca8sUX57mTk
	5UJDO1/QYOaGoweATdfKFLHyK70vsftKlo3TIRfCqew4xyM7z3i37HBpcQukntrqlHIpSDKTpRVFF
	afAn4nBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA7KD-0000000Df4V-1or5;
	Fri, 25 Sep 2026 14:54:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA7KB-0000000Df4P-3ll5
	for kexec@lists.infradead.org;
	Fri, 25 Sep 2026 14:54:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 497DE43F2B;
	Fri, 25 Sep 2026 14:54:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB201F000FF;
	Fri, 25 Sep 2026 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348095;
	bh=JGrB5YYFveIwZSzWD+7LH6wodZl8bTW0nco8xHfgyM4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QOESLnPmLuTQ7cdOc57AH46fsAY50EQ77MsLUxkgKnJyWYsA1CTQb9Ka6hBzSobn5
	 +RaDOGcelCVIE/1lAOY5o5ufvWy34WDudrgeJ2vYlYXA2lQZy6bIlmo3QZc95wSLXH
	 fX8sXQE7TKC2/uIfUVZVfjBUrEBjQ0Lz22Umc3gOxon2zWvqo32cXEQMHmboDdCMZV
	 tuCoJGEmSXIB4VjGIqKZE2Gq2V48nGM5/ClqoTQXR/T7J8AYeWYi0tZaL4i/K9k4jE
	 EEUwYF5Oq97Gux/BxaxFfDyeStYLsvSLwMSOuY7YfTQ+qHAskaWjd9UkWGi9b8sHMS
	 qF74AV0fTDj3Q==
From: Christian Brauner <brauner@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>, 
 Breno Leitao <leitao@debian.org>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
In-Reply-To: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
References: <20260921-kdump_print-v1-1-e445fec3177c@debian.org>
Subject: Re: [PATCH] vmcore: report the release of the crashed kernel
Message-Id: <20260925-wachen-handhaben-mixen-431c4a7a196d@brauner>
Date: Fri, 25 Sep 2026 16:54:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=881; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DSElJr8+eqnncUV1+QmO3mNU5DAG4Xkcag5Qg0INYEg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRt67YSFX6fWhzrmPw15FtycOBPpVX/NJ+fmmj1Lfv8h
 c21tf0/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyW4Hhn0XeoosOFlcvc8wK
 uDpt765TJxlSDqzZ4R4+932ETy/n8bOMDHui05dZOTSU9mq6OkxNma7G4y6hKPVh4/zbXmlHahS
 OMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

On Mon, 21 Sep 2026 03:45:42 -0700, Breno Leitao wrote:
> vmcore: report the release of the crashed kernel

Applied to the vfs-7.4.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.4.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.4.misc

[1/1] vmcore: report the release of the crashed kernel
      https://git.kernel.org/vfs/vfs/c/9a82c64e133f



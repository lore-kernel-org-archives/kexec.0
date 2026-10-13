Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FD2CC6B03
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veCpztZVQ0/cgy+OxvseE+wNCflm5n0ceWAT1R4Yum0=; b=vRAm7qse7XHOyIjJDfuj9kJgTC
	8W6Z71WDWrrWyyMM+be/p4fQn7+R4NmZSd5EfzW/HDTCyNQiFR6WaG/XI31VAatEvyyBrlsT66C9+
	2vwSY3iMyzesllwXBVqS62Ddk1qsyIoX4PDwto9Vf4+MvHw9jL5MDhcVn9Dc7Iqm45bdR+w1WXJwV
	tlZ7mQQQHr4VkIJW8inQlmXdpjJH1vPFaCun5mjb/yGUTt3PKFWR3C/uD/ugTvoGHEQoLfcx3mEiw
	TWCG9A+wUCBFWUtFLvKSARggM8HQ8lBkPNwhl4yM3pGhgP/5vNKHtKxdyqDugv5hRhxVl4dY8U3re
	nOj7A7Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZG7-0000000CUIY-0SYP;
	Tue, 13 Oct 2026 09:57:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZG5-0000000CUIO-3hZm
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 09:57:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4212943FBE;
	Tue, 13 Oct 2026 09:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FBD1F000FF;
	Tue, 13 Oct 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885441;
	bh=veCpztZVQ0/cgy+OxvseE+wNCflm5n0ceWAT1R4Yum0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVmjV3TCF6PyZGIxzC3hOmgxGjwEOr9DY+UYRT3mFLXIkgFwMVepBE2eytkPVczlv
	 Lifc6k0g+ZxPgi7YH4j7ZXspcPPnr06K5IDXqChhPZ4HNgXOaawufKHBnhTNcFVSql
	 rAU0PpMlHy9VJuI6CEEMTMOTupR6Y3VdUwTUAoHmxYyULnBJ0UMJeq5rQrfBAgTeyD
	 VMBx2RRXqDvLbzoSQWV6CxO8mGXDyui8nH5/r/TmTaR+Rm/k/EI3O5gV6vbiCdp1iJ
	 2iUQHBVPbE5IEoSh1/QfstI22OkftOw877p0qxMv41ZPi+jITo2zrO0a8T2qgHJ7wE
	 UIZ4rTM3VwE7w==
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	David Matlack <dmatlack@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Jordan Richards <jordanrichards@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests/liveupdate: Prefer KVM and HVF over TCG in vmtest.sh
Date: Tue, 13 Oct 2026 12:57:13 +0300
Message-ID: <179188542242.4186121.17333029282373982813.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008132813.1966023-1-dmatlack@google.com>
References: <20261008132813.1966023-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 08 Oct 2026 13:28:13 +0000, David Matlack wrote:
> Pass the -accel options to QEMU in the order KVM, HVF, TCG, so that
> vmtest.sh prefers to use KVM and HVF over TCG when they are available.
> 
> QEMU uses the first accelerator in the list that initializes, and TCG
> always initializes, so the tests currently always run under TCG, even
> though the commit that added vmtest.sh describes "automatic accelerator
> detection (KVM, HVF, or TCG)".
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] selftests/liveupdate: Prefer KVM and HVF over TCG in vmtest.sh
      commit: 48e6e4202e12af36671c6479b9ebcb8212d37cbb

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.



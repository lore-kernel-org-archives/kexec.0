Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E37FCD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 06:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xz6Wac4dFBhlZu9nlXxNnHAnl4msktquKY/eR4n6NfM=; b=4tZaz2yB6Ta54relVulY7P6PMg
	Y96WrnKbFE7pF44Gqn4EyCc3xi7/ANCNPPMrcZlVvDy4ysf7hyGSDNrEH5j3qM6VjzhPrlXVv7uxG
	zoqN3Mke3lo0JTwiq39vuqytoKaAnlBDOqWrEsO735nTC+VNaGtKcgI8/pZoVXI/sit4i39Nzu0V9
	Uza/ja6gF+ZM2o89buPMj9eZm77v55Kt4mR72/74ir620hZFtqRrtF5eCi991ir7M4l2ZaZ4cpcny
	Rzj2ZdgMfy5q6cHxQTKR77G0sO+6vIqbjcgFmn0PGKav2aH+kXrP6bd8v8opFeNJATTkg6KKsYgGF
	M42+yYjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfSU-0000000EPjP-3VkF;
	Wed, 03 Jun 2026 06:52:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfST-0000000EPjB-3VZM
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 06:52:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4A5C56008A;
	Wed,  3 Jun 2026 06:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F3C1F00893;
	Wed,  3 Jun 2026 06:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469529;
	bh=Xz6Wac4dFBhlZu9nlXxNnHAnl4msktquKY/eR4n6NfM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=J5OZ0l4ipDVsuhKD3zeAA3+kRDn3mJrhMzJ8bMuR/1HJU7Wvw8qy+Hr1TgSzT63Pj
	 hjdKNCqH1cgOXPvOiyWxQ+I33Z3qdEJiLFBnKvC48d6K2k083loJKmGhvgPX01XQpw
	 ECyf0L1tqscWRK3PfRZEYJqnebKN6cTT9P+YjaIbLGYZt6qp6hC2MFdh+VT7A396A8
	 +4kWhrv9hBq8Y6BZI3xYqit9B+uclK6AyOe1YMJpbRooF71wSo1ASk84/keYiTVPvx
	 DEqrX4IWvBMcZB+79jPqrAci9MAdQWc6r9/xoMtqFzoGNtPCZ9SjU4hIK9PrI9G9X9
	 Rh+uAzD4eHEMQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/13] liveupdate: avoid mixing cleanup guards with
 goto in luo_session_retrieve_fd
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260603032905.344462-3-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-3-pasha.tatashin@soleen.com>
Date: Wed, 03 Jun 2026 09:52:02 +0300
Message-Id: <178046952227.468621.16091000479096712016.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Wed, 03 Jun 2026 03:28:53 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Refactoring luo_session_retrieve_fd() to avoid mixing automated
> cleanup-style guards with goto-based resource release, which is not
> recommended under the Linux kernel coding style.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.



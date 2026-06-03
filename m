Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65972CD6E69
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3CPe9L+Xkc56uXDetG+lvovbz0JWP1jQopKoFbSJqc=; b=FJbIBJPA5CHTx9AL/+8qOFOj+u
	dJcXUDb9CUi2lM2pY9HM5x82auvzA1aZ6Qz2FRyAuxXe8gYTYguIJoMpjmvP3e/tp4Sb8ApXH1SA4
	aghvCcuDGTTJzJpPdQXyFlI6EZ/5UI5wInPtwyu2q6wc+rJmeE3p7rc0giVtyn1SHWUIQIgCBZ77O
	3cKKHxLOnLUMjNNgnv1EJ3R6w89NFD0Q2ok8B4hBgBf28nw7SI9j9bh6+c/1O381pcu77PraNkzk2
	O3M5TC1BYapgZKM1xOACQMEzc7t5rQjvbHL2JIprLq8/WHHTDNCQ+bw/rJGlB7xj9/mZRQfYa6Bfh
	0gNEJsfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUhyG-0000000EiPW-2lgO;
	Wed, 03 Jun 2026 09:33:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUhyE-0000000EiPN-3d76
	for kexec@bombadil.infradead.org;
	Wed, 03 Jun 2026 09:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R3CPe9L+Xkc56uXDetG+lvovbz0JWP1jQopKoFbSJqc=; b=rVH1RMh0DA1MWTuwTD7fb+u1RK
	4GvE40pWdbEKOMfl7htiAfXUQ20VTRS3MZJkSqZQu2ugRV2PCElToPyyNhv1gVhPcLHMUDwUQDRuE
	k2s/k/wpBQxyYAqqMSoB9HMscCTkJ3JNHgi9HBTHEfIT9XauuF3eHdwJbbGC0k2pJcZlPejeLsw4+
	Exu1clAJiQH0iRXNEfC12qtl0UzTvurgUkxkxLpQJ9fJUfWlgLFFkzp38SZ9NLxF+ttBBjMZVyTYz
	7rLnEpzcqRG2duuu06DOlh2dN0f609Yxxq1Rku/5k212OhI2mrkmVEQ1UmasgSsC8PAHn3NMkMmrM
	EwIISYlg==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUhyC-0000000Bj0l-0EHo
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 09:33:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BE1B241AAF;
	Wed,  3 Jun 2026 09:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FAF1F00893;
	Wed,  3 Jun 2026 09:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479182;
	bh=R3CPe9L+Xkc56uXDetG+lvovbz0JWP1jQopKoFbSJqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rx1cSpJlGAM0YKvGloDx4NCqR14Zez0e6wNchackcfyp3UWVdcBZSI9zTWDzbxJ9K
	 0bxYsTiuDHtW/iHnjIsxs7z7YmLa/cvEP67GMnbC5TqLxuuYjSd9o2npCUDV6PIt54
	 kYFUq53Ow4olqnLx+dT8XKv53t10rlH8/YbanQ4smjEdtkzz+MkZIos8WgrWvz8Hgv
	 GdrOWQQWdzDSFzD42zxtkp5aHFnN/hw/tz7d4s5PJ4OE4yrRKkGRclDGlKGRnYIs+2
	 4M9Mq4C9Ui6I3VnVRfzjhRHXZlFvXiHaWX4z0hcmznIOTu5avK9NWnL1AmPAJAPNMh
	 H47PAq9cno9jA==
Date: Wed, 3 Jun 2026 12:32:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v6 04/13] liveupdate: register luo_ser as KHO subtree
Message-ID: <ah_0xsPC_oNPewVk@kernel.org>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-5-pasha.tatashin@soleen.com>
 <178046942429.468621.9591914636403075487.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178046942429.468621.9591914636403075487.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_103304_309625_E3E14573 
X-CRM114-Status: UNSURE (   9.61  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Jun 03, 2026 at 09:50:24AM +0300, Mike Rapoport wrote:
> # Add your code comments below. There is no need to trim or delete
> # any existing content -- just insert your comments under the relevant
> # lines of code. Lines starting with "> " are quoted diff context and
> # lines starting with "| " are comments from other reviewers.
> # The final email will be reformatted automatically to include only
> # the sections that have your comments.
> #

looks like b4 review bug or misuse from my side :)

-- 
Sincerely yours,
Mike.


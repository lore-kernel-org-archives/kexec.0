Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD23C7115B
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 06:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=amTgSERN3utDvqCGxTJd0cMQf/6LQr4T4DXQKPu/7OE=; b=BX97YQ6QGR/K1wfR3KtDt7UKI3
	9p2LD1NM1cQNxobJRp172UKLcQ5LOhlsUDALDdCmhWpOEN2EvFquNGAHkcdAjw4eqdFp46mfiO97u
	XEK1ZMb9+RKs3hT+/CX1MnKssfS3WUMqsc+5u3Eo2yQuDBiO78/9iHIEvWMXxWTFeIi9PhDmdO0LP
	1CjZDuE2bpnvX7S9IbLgrNAe4h913Z0E5zN5J3GezRY4UNQzQMD571sSnM310As5gyrQaULzJcMVZ
	IEyGwTBdcu/UA3Ps5I7ggUxAxqH0Npbg48XRwWV3PHMTDWXvPKFoTzhFkJBZPoQFtfA4NvRpPVAyK
	5y2FCLRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTaqE-00000001kaA-2CxS;
	Mon, 23 Jun 2025 06:39:42 +0000
Received: from gnome.eu.org ([95.216.32.17] helo=lalande.gnome.eu.org)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTacj-00000001jG2-2sA8
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 06:25:49 +0000
ARC-Seal: i=1; d=gnome.eu.org; s=myselector; a=rsa-sha256; cv=none;
	t=1750659937;
	b=laZklOtGP/l2nhKfW4eZG6Fc0fJGYsQEFKDWKHPAZep0wzBcbE07QaQ5b2xt7Gg6mfch
	 PqUap797j+KgzlCdz0q6MNhvMp+7vNF5HegvYXizCvG7OzbZtttdXda5OltHM18oq/d+O
	 D6bhSnsxzIKGz/gBuW+RKkfRjYbsu2IfG8=
ARC-Message-Signature: i=1; d=gnome.eu.org; s=myselector; a=rsa-sha256;
	c=relaxed/simple; t=1750659937;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=3i2Uv1Y3z2papHvCGhrL9ZVJnsIV+y1RWJFgcWMXDSA=;
	b=wIAo7W20GpTREiHQS0WZTW4qMamZf2zlkwhBDem9RVtxn3nMSrVEl2SnR56XwulwHEjN
	 y7PaoZn0Q5WntnazsvwHjFBqVtfK7vai/+iJETJwsquoV7sEarbgigYwBlzQ+ZOBl1m60
	 tknxlibJRnocxsIE/Ci0BEzYTs3EZd6n+E=
ARC-Authentication-Results: i=1; gnome.eu.org; arc=none smtp.remote-ip=82.65.226.101
Received: from leto.ms.local (val50.gnome.eu.org [82.65.226.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lalande.gnome.eu.org (Postfix) with ESMTPSA id 50D007B2565F;
	Mon, 23 Jun 2025 08:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=7pot.org; s=mail;
	t=1750659937; bh=amTgSERN3utDvqCGxTJd0cMQf/6LQr4T4DXQKPu/7OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=utSAW2vtalgYTldcp+4+rJEGp3n0SaHJAHpZzIh6pHZZVvV4VKRl0C9XlL3aBq/ga
	 zv4uyJYMTlpfw1k4O76P/VfE3DHphMpHieOz0BeumQx3hsnvAtan3H/LSg/hPmB4w2
	 DTZzovfMYa06QuIK6t8V6WL1s8dXq7l6wwM4PQr2p3jhDNU6y4ohJV/U238dKF6lkO
	 cvTgydSRQudOOU+75KYM2ceKGVKbhskJj/Ww5HNaW5IPcDYJma3y9ElQjqfXbl/tfi
	 cI7IS+I5+LMRC46+CIJi6Jl4zmqjEhmetUp7mr1U4qATcobLK4nIIWQa5Z5EHF9bxa
	 myQRu+5ayU6rA==
Date: Mon, 23 Jun 2025 08:25:23 +0200
From: Lucian Langa <lucilanga@7pot.org>
To: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com, 
	rafael@kernel.org, len.brown@intel.com, pavel@kernel.org, 
	gregkh@linuxfoundation.org, dakr@kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	bhe@redhat.com
Cc: christian.koenig@amd.com, linux-pm@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH] PM: Restrict swap use to later in the suspend sequence
Message-ID: <dn6yc4swdyek4gz3bv7g4y5e6xzmo6vm5gkqqhmhbdhomnglbt@nsepw42i6hwz>
References: <20250613214413.4127087-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613214413.4127087-1-superm1@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_232546_192426_2D155398 
X-CRM114-Status: GOOD (  11.35  )
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

On 13.06.2025 16:43, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Currently swap is restricted before drivers have had a chance to do their
> prepare() PM callbacks. Restricting swap this early means that if a driver
> needs to evict some content from memory into sawp in it's prepare callback
> it won't be able to.
> 
> On AMD dGPUs this can lead to failed suspends under memory pressure
> situations as all VRAM must be evicted to system memory or swap.
> 
> Move the swap restriction to right after all devices have had a chance to
> do the prepare() callback.  If there is any problem with the sequence,
> restore swap in the appropriate dpm resume callbacks or error handling
> paths.
> 
> Closes: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Tested this against 6.15.3 and 6.16-rc3.
Adding my tag.

Tested-by: Lucian Langa <lucilanga@7pot.org>



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D64CD3427
	for <kexec@archiver.kernel.org>; Sun, 10 May 2026 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2DJ0+VZuFITv07ba56ktOXeWYmXZHzHSGYUcYS/+gQ=; b=VW7AdyzEOiT1CFNOEsLd9/2ML4
	kz5FzJE/VXZgzQO99DHFRbEiQHtSOotsSBXP92uAnM/SNEbpwffPprL/drZHOe4SmfUBOGtmYS6Sw
	d+8WotgqcGrFjKkdMBoU+wAv+XfYYMFc8SZytDZSp1IR803MYgpzvbqRp7B3dyO/3WzrD7z6cMn1o
	Pttksbbgmbh5/ECWBHL4xqVo4BRa4Ffwa8nNDJuACUL9rbETobthQW2Y0gsQA3o0eP8sL8GShwVCH
	9gKX8Uhw6p55prFDqo0Ch7Kl6IKq39b6IavNW1SGJdb0UfV5JfPLYBcjA7/L82i0WN8frxSHY89S5
	ieIPEceA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wM63P-0000000B3Zz-1iSO;
	Sun, 10 May 2026 15:26:51 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wM63J-0000000B3ZH-1uBa
	for kexec@lists.infradead.org;
	Sun, 10 May 2026 15:26:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 635464393D;
	Sun, 10 May 2026 15:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2899CC2BCB8;
	Sun, 10 May 2026 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778426804;
	bh=Mc2Qe7ArI+7McctHiVxQHX2r5/hJPhKxbCJROVGr6FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQBzndG/7p70Syz1+pOI3qJXIibMuK0p+00ZZsF1ApjIBiiGd/ro/xZQ/VVMZxwT+
	 g5OfaMDFcKzAyfq5u8NwzC6y2jsbsjGL6Vo0L5Hc95IRGX0PKKgxuu6ZBNe7dRlXGh
	 YPHmlwXPm6cL9fL7uRxd6OvRooiPfT3zOxNKnyGSqGky+azWpRA+ExH9Abgj/tPfsZ
	 IEsU8DumL1Y6wvuYVHF4EDyjsK+wQjTJvAzkLCF9YqllVuQF/5phYzbfTIAOZXkGRl
	 3Zq4PjOnfk7ktYCYjijJI4Tz3GV8rZHWtMZiiMJ0ZOxC4eR89ep4Pw3kyYaY+xmcJ2
	 Wloorhvo6iChg==
From: Mike Rapoport <rppt@kernel.org>
To: pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	George Guo <dongtai.guo@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>,
	graf@amazon.com,
	jasonmiu@google.com,
	ran.xiaokai@zte.com.cn,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: Re: [PATCH 1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
Date: Sun, 10 May 2026 18:26:26 +0300
Message-ID: <177842678313.259088.8928737921907121858.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509024415.33190-1-dongtai.guo@linux.dev>
References: <20260509024415.33190-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_082645_546858_D1961345 
X-CRM114-Status: UNSURE (   7.27  )
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Sat, 09 May 2026 10:44:15 +0800, George Guo wrote:
> KHO_TREE_MAX_DEPTH is calculated as:
> 
>   DIV_ROUND_UP(KHO_ORDER_0_LOG2 - KHO_BITMAP_SIZE_LOG2,
>                KHO_TABLE_SIZE_LOG2) + 1
> 
> For systems with 16KB pages (e.g. LoongArch), this gives a depth of 4,
> with the top-level shift at bit 39.  The order-0 bit sits at bit 50
> (KHO_ORDER_0_LOG2 = 64 - PAGE_SHIFT = 50).  When inserting or reading
> a key, the index extracted at the top level is:
> 
> [...]

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: fix KHO_TREE_MAX_DEPTH for non-4KB page sizes
      commit: eaf3933ec58da601cf0008afbcca7cf5433321e8

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.



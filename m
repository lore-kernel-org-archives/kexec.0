Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF05C982D1
	for <kexec@archiver.kernel.org>; Fri, 16 Jan 2026 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=arJvcCvN4ztGJLd7hUCd1IXFDv2P3lxC+j2W3w2tICE=; b=JPxeUZ3lNR70kxIYP2IQ4AHy0k
	rVtITxn5BTt+/AhuA3whZojMVsdOjAs9kKj2onSqa+7fYb1jGDs1rhiU4UvsEIDgP+dW6l7XBNHwK
	w8mvCK4J/PNt7f+u9V5evWFr2hQfcC76JB7BvHL2zldshrOdOWmsLuB95i3EsuEqxdQrqYqoTjtlZ
	BLWa3ltpvfhTPQOs4a9AJ2p5VWSQHLwO4QXPCWXPiy92OqxtODXjzLo94qaL9jugHvyooJukVSvId
	ZT2WefGA7YUjgDtbGxsvp2UF+w6qVleAKubnE0rg7yEcVTgU2kgWWTkCOIgbSZ/2uPLESLohIy8lp
	U4Nrxukw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgnPH-0000000EYeC-1mGC;
	Fri, 16 Jan 2026 17:14:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgnPG-0000000EYe4-0TyR
	for kexec@lists.infradead.org;
	Fri, 16 Jan 2026 17:14:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EF2AD60150;
	Fri, 16 Jan 2026 17:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25132C116C6;
	Fri, 16 Jan 2026 17:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768583680;
	bh=d4CxCBV64cuXzGjuk2uWj4LPcoHD1d0/Q4IvI0bWIQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rZkslwi1YB3MS82MWfrwr91m8ny+VcHQ9zx1fV+m11nPiXOIlxOrDB/3qRKxF+3Ya
	 lJ6NR5Lo7R/QYTpVw5hVM5WxiUe5ytTY42GKkTOGzeriYbHLL/1l3ZKIMgpop0l97d
	 K/vWGnYE4k5FWbLO5qdZ/QlzcDTFhV7O75SxKkUMDG8XpAHNiLCOGUAgJGQQlKd/1A
	 aSrhQRWgaThcB5aA7mc86eaSvrqtNi+tIqCMWxJIZhLO/7CaaL8lhNiZ/TiTFW9R5f
	 +g1uB6VjXsuotecCbO8L5DN4UvuvaHcc0YfFdx6Q+aSjK2BY8Vv3PYle+XeSRaQM4j
	 q0X13GuhF/OjQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: l00580197 <longwei27@huawei.com>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  <kexec@lists.infradead.org>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>,
  <hewenliang4@huawei.com>
Subject: Re: [PATCH] kho: test: clean up residual memory upon test_kho
 module unload
In-Reply-To: <20260107022427.4114424-1-longwei27@huawei.com>
	(longwei27@huawei.com's message of "Wed, 7 Jan 2026 10:24:27 +0800")
References: <20260107022427.4114424-1-longwei27@huawei.com>
Date: Fri, 16 Jan 2026 17:14:37 +0000
Message-ID: <2vxzjyxh7a4i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Wed, Jan 07 2026, l00580197 wrote:

> From: Long Wei <longwei27@huawei.com>
>
> During the initialization phase, the test_kho module invokes the
> kho_preserve_folio function, which internally configures bitmaps
> within kho_mem_track and establishes chunk linked lists in KHO.
> Upon unloading the test_kho module, it is necessary to clean up
> these states.
>
> Signed-off-by: Long Wei <longwei27@huawei.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


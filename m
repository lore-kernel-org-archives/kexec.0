Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35433CC6B34
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XlhcTFporOc45iUrAemRtzHNltY+ILuEWa7USZu1uRM=; b=gngyYbmIu0YuaWCbXEOjhtUYaI
	8t/TtTCuNvmhBVZ74vm8DseQ98fe0nMftdBHXxhZbPQI0WEG7mljJ7WSNL3/4qbI4LCN7XdPVDLgN
	wxUeon2XrYCbQ5cipFYoUNetKcWO9+rvCqm9Ve78Tc8rJyUiRqikYeskApDDARvdBH+tIP+ycWBd7
	oQnDLNgQOQS79zh0PqGQmt9ls9am+7IoiTYmLbyZxVQ67S4gD1tcpjRIWlBfe+5ZLGoGAMFzri7Gz
	xz0M/8biAPbQ0LDPdClOftZWg6sncdsfg6/fOQRaemH2IELJYxKNuq1pLYG5ZhFn8jb2RIN+4vMmQ
	o3OH1ekw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHH02-0000000HAdf-1Rk7;
	Thu, 15 Oct 2026 08:39:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHH01-0000000HAdN-0LYt
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 08:39:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A267543F1D;
	Thu, 15 Oct 2026 08:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD61F000C4;
	Thu, 15 Oct 2026 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053580;
	bh=XlhcTFporOc45iUrAemRtzHNltY+ILuEWa7USZu1uRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jafa1uvAXgtotQ6UZxgmVOGkG+VUznT6x8G8rUCDCMeXx+KdgOuxhOmICwpqoO5El
	 mTVIiwBgu8+0iIDrG5wjhm97OypiLtmvEus1cAWOnciBhe4KFVzPVQ9ofC1CLbmRRW
	 Jn5RqUXekw2ZkmZcT1iiIdUSxzYWT5u//7fRYRCglAEQOjlPaWn+JoBKdtSUoekEWV
	 mTPFikrKavr1ojc4cvJT31b/buQAXZDzri4IivxyfOcQ5turT89PCTD1BFUPZJXZkp
	 esWvg6jXBjQ4Xd0rnuveFCtBC+/h0pv2MCIB9faffBxkVG93ZjwFLZZSG62ivudTej
	 i0g3/bstxPxGQ==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Bing Jiao <bingjiao@google.com>
Subject: Re: [PATCH] kho: do not reserve empty per-node bootmem areas
Date: Thu, 15 Oct 2026 11:39:34 +0300
Message-ID: <179205357104.207844.7161126108043305989.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014131547.259138-1-pratyush@kernel.org>
References: <20261014131547.259138-1-pratyush@kernel.org>
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

On Wed, 14 Oct 2026 15:15:44 +0200, Pratyush Yadav wrote:
> Some nodes do not allocate any early boot memory. An example is
> hotpluggable nodes with movable_node enabled. So the scratch size for
> them ends up being zero. Zero size allocations normally don't play well
> with memblock. Memblock returns an address, but then doesn't actually
> reserve anything. This address ends up being recorded in kho_bootmem
> with a size of 0. In case of hotpluggable nodes with movable_nodes, the
> allocation on the node actually fails because memblock refuses to
> allocate there, and so KHO fails to initialize.
> 
> [...]

Applied to next branch of liveupdate/linux.git tree, thanks!

[1/1] kho: do not reserve empty per-node bootmem areas
      commit: 9a6a70aefe77f6fb9ff2b3037dcf87f6dff65c8c

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: next

--
Sincerely yours,
Mike.



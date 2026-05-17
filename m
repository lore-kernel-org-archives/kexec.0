Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE91CD4F4A
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MW+H3V8e0LDnsKJwU4Yin0CQyrhuOE/niANZI/vpt50=; b=MPymitQXT8QGPMCAY+SYVsa/AR
	XJVHjTnDoiMcfzESM5gHwJNYEtUkzZNfG8PikvcDydA+ujOyM3bDrSv8HdRyFvNP/8mZhRlX3FLjg
	iS6iFvitxKnrjLNZnx/vHTEYBSSHhLyqmp8WsKfAPR+tHUqoizM0Bk0QnpJor45U08fv1egPeU3Zn
	Mbs8R1zRgcjp/KgwR7azhfS6hArJcigTwrztLgGedmxQbsEBdM2q6esiEQhyx5Xw0JUcMz7G5ytLK
	wQGuuz2ka6Jrxu03w+DgeZ+Ux+A7X7dmFu61zvEiKSNh5Lp6AMxXwwHYmmfdtoO5HZilphuyx72IR
	0vaA5PhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfMZ-0000000D7i5-2huh;
	Sun, 17 May 2026 17:33:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOfMY-0000000D7hp-1GkO
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 17:33:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C02F060125;
	Sun, 17 May 2026 17:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1C9C2BCB0;
	Sun, 17 May 2026 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779039193;
	bh=MfKwn2SskewqeDZpjMen9el97DJDPcfqGZU8duSRb4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s2dxYeVoaZOazfHyFr5HmEW7yEF2kyENZxJLO/bkIVU+4YswTAsFte42VtYXPpwAp
	 MtiXJVjzK3d+sKMWBdG2ylnIFkyg2p3nCbnuoHEAd+Hl9tLlsD1bnHV8FWqBp6OPoV
	 9WDfFCEaxEkER7apciERu/epb8TpNRMc5JU8Pp7i33WFUAClkZpW54tXiz4HDyFsC0
	 CpaESd73RCAGj4mgv0psl0EnT+vo+NZWn/bsnaQS9hAvuI+kqkCC7QTWGMJrIrozan
	 brMnso4HosoEQucy47O1jFex/dzPDgzd0Zg/QeTqyxC3z3lL89e0+EYCIsqIiF9LIi
	 VlOFgH3C1ubzg==
Date: Sun, 17 May 2026 20:33:05 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net, dmatlack@google.com,
	kexec@lists.infradead.org, pratyush@kernel.org, skhawaja@google.com,
	graf@amazon.com
Subject: Re: [PATCH v2 06/10] liveupdate: Remove limit on the number of
 sessions
Message-ID: <agn70Rol6l0Okp9B@kernel.org>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-7-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514222628.931312-7-pasha.tatashin@soleen.com>
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

On Thu, May 14, 2026 at 10:26:24PM +0000, Pasha Tatashin wrote:
> Currently, the number of LUO sessions is limited by a fixed number of
> pre-allocated pages for serialization (16 pages, allowing for ~819
> sessions).
> 
> This limitation is problematic if LUO is used to support things such as
> systemd file descriptor store, and would be used not just as VM memory
> but to save other states on the machine.
> 
> Remove this limit by transitioning to a linked-block approach for
> session metadata serialization. Instead of a single contiguous block,
> session metadata is now stored in a chain of 16-page blocks. Each block
> starts with a header containing the physical address of the next block
> and the number of session entries in the current block.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/kho/abi/luo.h     |  24 +-------
>  kernel/liveupdate/luo_session.c | 105 +++++++++++++++-----------------
>  2 files changed, 50 insertions(+), 79 deletions(-)

-- 
Sincerely yours,
Mike.


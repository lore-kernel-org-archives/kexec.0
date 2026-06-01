Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94085CD6E56
	for <kexec@archiver.kernel.org>; Mon,  1 Jun 2026 12:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c8I85J2qCWw8kSCV48bS5iJLpYyx/iyAZY3UbobiVKQ=; b=0IjCrjEE0AR7AhcyFkEB1/7qC+
	P37AXWRLernWZrHbHxtTFZ8GUCnRvR39F0WhztnPk615eMOW8UnbZSdkD8SmKP+8DPI7bfaKwrRrd
	/yx7H3utVrGS7naHPmYv38atGQyBsQAR9wDRBRIXrR+qqZ7e3y1dUrLOdTRUi/9z7s+F0729Smdzk
	eLvWc1w2/WMZ/zdbYnQW7lo9N97d3W0UiM3yE4y9Y8OYIp/4XB+6J+DKZCZ7rgsAI9KMaHTyknM7o
	IDVwkifZrQX7oNnnEEykrq4Nk2mI+bp1iUv+7haKL8+37JYQMXsRDjf3E0EwESnMgbIbOcLBzUPmL
	1jx7o1FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1c7-0000000B6XM-2k7u;
	Mon, 01 Jun 2026 12:19:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU1c6-0000000B6Wy-1Evj
	for kexec@lists.infradead.org;
	Mon, 01 Jun 2026 12:19:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A63896001A;
	Mon,  1 Jun 2026 12:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06C51F00893;
	Mon,  1 Jun 2026 12:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780316365;
	bh=c8I85J2qCWw8kSCV48bS5iJLpYyx/iyAZY3UbobiVKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iCT7BbADvyqY/N7ktQa9CCgQuLuxBi4bueukJYyNbHF0PfF8EjQwNrugrMCvzsqX9
	 9q3Bkh/2GSly5eAntX/fzTq/U3DYapYK0Af0v7fUEHdvK69OpMZqTpu3fIXD8Vtpsv
	 3kK64hONFu2Wyfiyk9SPhNn6LZCQ9nVjSQN1bCuf+1u908hDrJF3Cde/BuZPgKlfU2
	 B0wruFmyHvuzw8sv6UNygpdeq5JxWI0RLZusmFxpbMV/X8dKD55Gq+5l/2tZWNdQ09
	 CzI+TVBnBl8eH6W3yE0yHeox9lngm+77wRXMczG9PzhvJ3IGej4bCsIKsNxalLU60s
	 rocow+5OAKF5Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v4 03/13] liveupdate: centralize state management into
 struct luo_ser
In-Reply-To: <20260530221938.115978-4-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Sat, 30 May 2026 22:19:28 +0000")
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
	<20260530221938.115978-4-pasha.tatashin@soleen.com>
Date: Mon, 01 Jun 2026 14:19:21 +0200
Message-ID: <2vxzzf1efo6u.fsf@kernel.org>
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

On Sat, May 30 2026, Pasha Tatashin wrote:

> Transition the LUO to ABI v2, which centralizes state management into a
> single struct luo_ser header.
>
> Previously, LUO state was spread across multiple FDT properties and
> subnodes. ABI v2 simplifies this by placing all core state, including
> the liveupdate number and physical addresses for sessions and FLB
> headers into a centralized struct luo_ser.
>
> Note that this change introduces a semantic difference: the sessions
> and FLB serialization formats are no longer completely independent of
> the core LUO. Their metadata (such as physical addresses for sessions
> and FLB headers) is now coupled to and managed via the centralized
> struct luo_ser.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1510CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QmR72pv0JwZwlXfpmXou2svlXcH18CS10GD95f37blg=; b=gqKsHxKcj4DwMKDiVu5+pgRSRl
	aORw6497TI9DCDWmSxO1hGPExB3hWAhsnqrtaQpgVb36OkuXTg5jKhg3EZ7KcFjgAJOp97oTDqo64
	l8PD+Lx0MWjYhLwgv1d3gxaoCQOgrJ3bz5oURLj3cdGlWgqyRCllHLIBo8YO5UvVOw969NQI7sZ+S
	o3Tl6Pf4cC0/2Ck0pXLJOD8wJcoiYMgCX5TYbPvNS6IomgryucBkK12oHwN5G1ezrxP7MKRiyu/Gr
	87BsY0+sGm+8WXrBaVcVrkAfntOuEi3YF6ptfHQkiIrEPnJcbfq75RLzOsDRmkTYzBBW63yt1n5Ww
	UfdcjZZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfSa-0000000EPl0-006D;
	Wed, 03 Jun 2026 06:52:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUfSX-0000000EPk3-2RD9
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 06:52:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DD22943E4D;
	Wed,  3 Jun 2026 06:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1921F00898;
	Wed,  3 Jun 2026 06:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780469532;
	bh=QmR72pv0JwZwlXfpmXou2svlXcH18CS10GD95f37blg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GiRBMgVXBSYgeTevLYva+/l8q+IIkbd8tlCWMESYx3M+lpYhlTsV/YFhmgyIeJmBv
	 aSjS2E2FrVsyR7LerMnXedSvoQUQYDpRMuwqXSWxYXeaf1uwfvCkybxOZ3Fgmhi3sR
	 FmtcC9rbPfxKV/XQOad3sLgErg6alckvnSGr4fX8AAnrQBt0dfFYuKCas8Nfq+MKWI
	 2pP3whGsj78x4ObF026jDMh3ewLDz4dDUR9POyKPjSiJrZFW7QpaHianGLth+gpj8P
	 rP+6NRi2pQpwr0trxX0Mzk20NatXXQ3xr6yZ7lGOdcJ3lnhARBb0X2wy2qG8pD0Jwo
	 zqCBoEsbhOKOQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 03/13] liveupdate: centralize state management into
 struct luo_ser
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260603032905.344462-4-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-4-pasha.tatashin@soleen.com>
Date: Wed, 03 Jun 2026 09:52:02 +0300
Message-Id: <178046952228.468621.17532660334285388424.b4-review@b4>
X-Mailer: b4 0.15.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_235213_646638_D1F565A7 
X-CRM114-Status: UNSURE (   5.83  )
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

On Wed, 03 Jun 2026 03:28:54 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Transition the LUO to ABI v2, which centralizes state management into a
> single struct luo_ser header.
> 
> Previously, LUO state was spread across multiple FDT properties and
> subnodes. ABI v2 simplifies this by placing all core state, including
> the liveupdate number and physical addresses for sessions and FLB
> headers into a centralized struct luo_ser.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.



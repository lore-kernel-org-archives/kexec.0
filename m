Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AF2C43458
	for <kexec@archiver.kernel.org>; Mon, 29 Jun 2026 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmkyM0gKnkXc7iOZ4KWexJ+DOScGYYrexahA8IDf0Eo=; b=zj5OhIN+sE3sYa5ceurf4MrFlI
	Aq8FwBVoB47IdsdfJZYAnCYyp4b4sT0wWJkLiuujcZ1YsCQSs/LKgMgEnho6HLfVX+zV+SB5iznNo
	oW6//fth2bc60pHaQccgFCNzEOABQs08lecBpavBiOXZrtEuDkY/UEV4LAVHeJ20CesoZW3BqDmGB
	LIK8DhIn0s1GnW9FHVpj2AlO4YeM9Kp5MFkILdKCZ9pdWA/1nTfssEL52fRTKdzf/zbFCqSEVn/xn
	mIMngTadWdQES5LjMK1Is1s1pKWluX233KEy3H/AjHjDZmfu6JoGikQzAC1BeamyQvdVMhw6BX0E4
	sd4JVKwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weERg-0000000F9pv-0BWo;
	Mon, 29 Jun 2026 16:02:52 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weERd-0000000F9ny-14pz
	for kexec@lists.infradead.org;
	Mon, 29 Jun 2026 16:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=CmkyM0gKnkXc7iOZ4KWexJ+DOScGYYrexahA8IDf0Eo=; b=emMkk9rTbhnNhghgE55MfwVz3a
	r0n4XukSrz5gDKUzziYlr1RfQA2R2dAn7mnImS/buUGFiUCN4qn4QfbxvGrVO+o3jP2thPY66Eb6C
	fvINpG7/9AURgL5pREtz09JyNaEEG+8roTTsviLeilkdUsiSrOxsNwLX6rrR+zwdoP5Wlw+zJ5Lwc
	WcUte29QZmowNvkZ0ZS0LyY1bRmeSH/agZmXCqDm+ff9UyozEamDw3Zq+bkTi2meMF+CEJli5ZAQ+
	+hYQi2OnG7ynaoJoLLawpinKqgXUhpSTo2ADampGAKV97aHrEfNe9qBg/F6rLoJgAVo6/J4uVz8/F
	DLO7uaQA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weER2-006P44-1N;
	Mon, 29 Jun 2026 16:02:12 +0000
Date: Mon, 29 Jun 2026 09:02:06 -0700
From: Breno Leitao <leitao@debian.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	riel@surriel.com, caggio@meta.com, kexec@lists.infradead.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] vmcoreinfo: GHES: track fatal hardware errors
Message-ID: <akKWJQNiX5MGJLl6@gmail.com>
References: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260617-hwerr-v1-0-ff131cd6203c@debian.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_090249_295886_DA0B0473 
X-CRM114-Status: UNSURE (   7.44  )
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

On Wed, Jun 17, 2026 at 06:32:46AM -0700, Breno Leitao wrote:
> Hardware errors reported through APEI/GHES are recorded in the kernel's
> hwerr_data array so that crash tooling can tell from the vmcore whether a
> hardware error preceded a crash.

This Hardware error tracking "thing" is currently in an awkward
location—it doesn't belong in RAS and has minimal connection to vmcore
info.

Following Baoquan's earlier suggestion, I'll refactor this as a standalone
driver, which should make the code organization clearer and more maintainable.

https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/


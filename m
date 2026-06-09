Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69AFCD8CAA
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fmac61i2dwLocCOx7qcTqnbQ43RtfTqLMELLfckgZ38=; b=kWVxAslBKrPqhjPdiudqnYfeom
	poq3zvgtgwWigbP0g92Uzzo47Tl8hh9utyO9P1mWrxd3ych3914uVJ4E2yACTMDcqhObZ2owy294W
	WFra55lj/XB6VKZIEys9TV0J2esmeuaDCShSb8+Jt+quv2ZjUccsUGOPYzH1u1Vn301HOpJMzhH9u
	yWnZL8ZxMPgJ3Om+XYKJjFxhN9IFb/1HA2RUMY/9iNQLgcMRzJZKiQMiIHmJXTJ57CqXU5v27Kj8i
	4jPrIY0ZCzP8wNLv5ZgS+Z4zEzxqNkRvzDiU/pTRCfq6xgXXEkF8XKDmFg+YubkQmeg73b5xwa/74
	F1sEm+fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxdG-00000005o5L-0SdX;
	Tue, 09 Jun 2026 14:40:46 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxdB-00000005o2A-3eQI
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 14:40:43 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781016011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fmac61i2dwLocCOx7qcTqnbQ43RtfTqLMELLfckgZ38=;
	b=NWYFODOC/z8fN1av0PD2atwJekgdJSlGgtsB7NkKlRnF+0qjL4q6Mu8Wxh0l/VpAyWI8Zt
	Wy6iYczj3eNFCiaIiYg086C5pcDhiihOM+vqBWNagn7Xutgpmko9Ki/FPS+q/j6qsFd4B0
	5nvk5YbJG7OOEMyRaZiGQYmTY2xkTNs=
From: George Guo <dongtai.guo@linux.dev>
To: Mike Rapoport <rppt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Alexander Graf <graf@amazon.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH v3 0/3] LoongArch: add KHO support and selftests
Date: Tue,  9 Jun 2026 22:39:45 +0800
Message-Id: <20260609143945.512688-1-dongtai.guo@linux.dev>
In-Reply-To: <20260601092823.110362-1-dongtai.guo@linux.dev>
References: <20260601092823.110362-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_074042_502713_AF3B8FA2 
X-CRM114-Status: UNSURE (   5.12  )
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

Hi Mike, Huacai,

Gentle ping on this v3. In the v2 review you mentioned you'd wait for
v3 for a more detailed look -- v3 addresses both points (folded the two
selftest patches into one, and replaced the LoongArch-specific kill
loop with timeout(1), with the timeout value set per-arch in the conf).

No rush, just making sure it didn't slip through the cracks. Happy to
spin a rebase if it's gone stale.

Thanks!

--
George


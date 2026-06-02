Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B9FC5DF71
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z1/GsCfRVNHOJEA6izSI1fELICv3oclmjsMXfZuvbdI=; b=Cu+byZyijexs4AM0Nv6u4GIKQB
	W+Et4J5PidN3zWGoV3Z6zmmyVy4WKgMzf0h0+SUCR3hA671FXk35Qs1T/7uzVBtRc/6O1TK+fshAE
	HPz9+PvwNjrEn+hFMO4Oj3RKtuKqXhQurEgHuXr7WcIbarI8Ru1moytK21bf6YA3nTHtdUOLP5tqt
	ZhAJz1DcU04lajut0U05j1wKatY2sgq3GY/oAdCivnCXkiIpfa1SnPg3YdO4ZRKST6jb24xqDonqT
	vehGBrqy6I1Qs3dhKPIBHVT8E+WXCSi4ZXTLARKkpDrYPBCFyyq3yiX8eNwkiUNYVH6hkyUGEuHoF
	qTmuQ4TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKG6-0000000CXww-3rfF;
	Tue, 02 Jun 2026 08:13:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUKG5-0000000CXvq-3oky
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 08:13:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5AC4360120;
	Tue,  2 Jun 2026 08:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7D81F00898;
	Tue,  2 Jun 2026 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780388037;
	bh=z1/GsCfRVNHOJEA6izSI1fELICv3oclmjsMXfZuvbdI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HiiL4MDooxKbk4zL5IfetQScDfo9p+gaoxWVoalB3YTSTvLSYN7i626/UbbekXXz+
	 t0CPy29ulPj5SHa9SSWcoHy3KRVHek7ttrSGlVQhbSDZsfpnvfYdZGNHqJmyPYmFuv
	 EjbtgI+Lt6k40LdPaxhhru9eNB39BwwsNGt6uWEQ/6p6HeS67ap5fUoPMMqbn+G4/0
	 gnNXw8m+1fKE9Y+4FPP5wS7Z4owmJf0rg3tO3/8Snd/vs3ahJDsCwmLPFAB+95nsGm
	 CVRVXZxC0SybfZCW6X4YUbOeGhse+KV5Ms7rm+TICefsrH9iXdF0p6Rk9Jqj6c0yPW
	 Tt2SjBEuPJbZQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 08/13] liveupdate: defer session block allocation
 and PA setting
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
 akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
 dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, 
 skhawaja@google.com, graf@amazon.com
In-Reply-To: <20260530221938.115978-9-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-9-pasha.tatashin@soleen.com>
Date: Tue, 02 Jun 2026 11:13:34 +0300
Message-Id: <178038801492.119771.3419366349068848854.b4-review@b4>
X-Mailer: b4 0.15.2
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

On Sat, 30 May 2026 22:19:33 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> Currently, luo_session_setup_outgoing() allocates the session block and

"liveupdate: defer session block allocation and PA setting"

PA as "Public Assistance"? ;-)

Let's spell it out.

-- 
Sincerely yours,
Mike.



Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C22DCD5BB1
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KEioWnHBFrSVOzWNfEkI+OE/2Sc6ORJaNzdndpa/bQE=; b=NOJdRB1Q2UKah4QyMkOSH6N02s
	GYOC2tzJl1TxeMkt3/w36JD0MzlLDYWjzzQ8poauG2eH8vp8g/AhjdklgjDH3ulCLaEwB7DdTpeJc
	puv4OChVaHKLp56a2wVQ2Y7aTKcwYt3K4y1Mbn5VBChxs14n3kkH0B+SIm8gumS83+YzuTlB28Vbn
	+DTpZu6LhFjF990ccl0esoEQ2LE61W5dQRskrnU4/GrRBvn7aCvfnnyU6GfPYa1VEIihJfYuduF7O
	XNSVEENd4SPvRGu7W5J/zgdCGlAJ3lhNacNaKBybo+zJX4j6SmP5IFm33dHn/SC9Gslp9rCWQSgMH
	AY4fDioA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXCi-0000000HWCV-2Z2E;
	Mon, 25 May 2026 15:26:56 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRXCh-0000000HWCJ-3ZFN
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 15:26:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E97E600BB;
	Mon, 25 May 2026 15:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C0E1F000E9;
	Mon, 25 May 2026 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722814;
	bh=KEioWnHBFrSVOzWNfEkI+OE/2Sc6ORJaNzdndpa/bQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=RABhSdjt5u0xspCBftMJSAFcLnZnPAxEHcgKblhAtxk2MraxplpKc7uBljDlCqvPp
	 zVTmMAHY2/KZRj0OAGoDXPHwZ+Nz/QC/QyXVkUoI3+bv01bgaAmOBagGDm/e+3tbEP
	 jLCLsdybfirYpTfIb9IwBkU4e8p6QlLTxhuA+21yf/lM9yB9+6Xp9rflfRKcdut2K+
	 lGcvKjYnZgffXWdfk55VUWJGpgDn6MHoKiIEuplqxepYfj8mGRLipvfmd+VoUHNXbg
	 7lVlEA2UGcrQYxZpwhnGXh8LcxvUOIk8TDsf9KruXsGr8chSDyJ6nePwJzrUXnlhNJ
	 bZcj708UaTX5w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Yifei Chu <yifeichu24@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  linux-kernel@vger.kernel.org,  Pratyush Yadav
 <pratyush@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Alexander Graf <graf@amazon.com>,  linux-mm@kvack.org,
  kexec@lists.infradead.org
Subject: Re: [BUG] liveupdate: incoming/outgoing session ioctls accepted in
 wrong phase can panic
In-Reply-To: <CAPJnbgLtEUQ4Kv1ENM4ku0S0JFS8T49MEHFa4MpoT3WRuuVfFA@mail.gmail.com>
	(Yifei Chu's message of "Sun, 24 May 2026 10:44:31 -0400")
References: <CAPJnbgLtEUQ4Kv1ENM4ku0S0JFS8T49MEHFa4MpoT3WRuuVfFA@mail.gmail.com>
Date: Mon, 25 May 2026 17:26:51 +0200
Message-ID: <2vxzjysr7bno.fsf@kernel.org>
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

On Sun, May 24 2026, Yifei Chu wrote:

> Hello,
>
> Short version: I found that liveupdate session ioctls can be accepted on the wrong kind of session. In my tests, that
> lets userspace drive memfd LUO into KHO restore paths for current-kernel preserved memory, which hits kho_restore_page()
> warnings and panics with panic_on_warn=1.

I already sent a fix for this:
https://lore.kernel.org/kexec/20260519122428.2378446-1-pratyush@kernel.org/

I need to do a refresh of this patch with some tests.

-- 
Regards,
Pratyush Yadav


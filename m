Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DDBCA0EE6
	for <kexec@archiver.kernel.org>; Tue, 19 Aug 2025 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Ci2i0eqcA639jCpxqJsUg05UIkOIeBNNLc9CI7Lxc0=; b=MWoaDrvS0DD3+u8OiZZASpIq91
	alErk+4niUaXoilEep98MLNrs5AogQJJnkmM6sgYzibWmgN4rQ4IJynKZ/pbyvGhP5URYn/EOLrxQ
	mUzycqSXMABZoZfFN05k8zupLaSuPaQZKpDmuI8nJwVtut6NDxItd5oU7dzn625FwHByJzBkYU2X6
	dkzHAhgFssfE1de9D09C5oqH4BJabV2GQqEy3mNhHH2e6Zg156CD0/ubtwkp80KBUXF4T6ftZM4D6
	20WS8XBIDLgqqaxf2sT2Rw5/Ew3JLEQR17XFjyqt12PNhB7MUv2GxGXJ3jBUjFOImffrDM8wh7Cf7
	8GCpmruw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoVMi-0000000BoQT-2uJa;
	Tue, 19 Aug 2025 23:03:40 +0000
Received: from sender4-pp-o94.zoho.com ([136.143.188.94])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoU2f-0000000BeYe-30h5
	for kexec@lists.infradead.org;
	Tue, 19 Aug 2025 21:38:55 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1755639532; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N0D5dGd9EDAtqJQOqd4yofGu0O2rTDD2A6nsIupz0BhXJtfIFfU2SwBOvvgo2/sjhEkX8gp83HjpTzexqb6YvsynY5eexrid0sI1m5f275atSy4KIvnQQyX+ojtOwy8WhCJQNTQC2G0tvodlHVgMgqMUcB0ugY+QRrKjMhye22A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755639532; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0Ci2i0eqcA639jCpxqJsUg05UIkOIeBNNLc9CI7Lxc0=; 
	b=k/x3EhStUfx+X37ENSugBrbPC8DX8cZOU04+w8ANb0FcR6EVFRiM5CudaR5k4Krmd4vieh0e++qSOfq1kWbGZd4sfT5DOd5hrvF64bd7GzzzUivGxMGRDbaKXqyQhjubCD8UuEHvWs72j5ybE7WarVKFh0LtKEKDYLVMoHWaQHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755639532;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=0Ci2i0eqcA639jCpxqJsUg05UIkOIeBNNLc9CI7Lxc0=;
	b=DvSQjlhbim639BYmfCBQzC5/hdDcA6no0dgLD5cqOP5nap/18WSTE5y6sJCVYgJt
	X1Ku6pAjDlOqJkoDqCSdBkBx9awUg3hEowjXuEGJLBBMqT0xyhCuyJyUfa2r6vDl90s
	vLN6sycDqV0ql4lewngLLbDL+mjqV9NqBH3mutLU=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1755639528790646.4573818551755; Tue, 19 Aug 2025 14:38:48 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Tue, 19 Aug 2025 14:38:48 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:38:48 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc: "Simon Horman" <horms@kernel.org>,
	"Jeremy Linton" <jeremy.linton@arm.com>,
	"kexec" <kexec@lists.infradead.org>
Message-ID: <198c4453d48.d8db0bc668814.5123977046275098050@zohomail.com>
In-Reply-To: <CAHp75VdY6YtaVER6QZ9K=iJfMEYvQ4=63KfEWEnthA1QQVFQ2Q@mail.gmail.com>
References: <20250819090505.647690-1-safinaskar@zohomail.com> <CAHp75VdY6YtaVER6QZ9K=iJfMEYvQ4=63KfEWEnthA1QQVFQ2Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix printf string specifiers, otherwise kexec
 doesn't work on my laptop
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227cd6502a789ff31afe78b1d6800007e0c4be241cbc97fc554c379e3cfe70257ab7666a34960470d:zu080112277a1f173bff8bf59746e9983a0000ee19642b0413a5b3f071c51e78c38f0ed3c93d925cb161ad43:rf0801122c77d385dce0c5745d32d6e31d0000597a78021eb3fcc05958e617fe78f433483cd8357ab54fb8051ab5bf6ab0:ZohoMail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_143853_821120_94E47990 
X-CRM114-Status: UNSURE (   8.30  )
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

 ---- On Tue, 19 Aug 2025 22:49:56 +0400  Andy Shevchenko <andy.shevchenko@gmail.com> wrote --- 
 > After addressing them, feel free to add
Thank you!

I again ask you to look into another my report:
https://lore.kernel.org/regressions/197ae95ffd8.dc819e60457077.7692120488609091556@zohomail.com/T/#u
(Ideally, read whole thread, please)

We wait for you since 30 Jun.
We merely want to know what command I should type on my laptop to proceed, i. e. to debug
futher this problem with weird wake ups. Because we want to understand how final upstreamable patch
should look like.

--
Askar Safin
https://types.pl/@safinaskar



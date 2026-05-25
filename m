Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F2BCD5BC9
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 16:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BukyjJ4n0b1AMw2DENX11/eFZaQYpsl8U4gKYqCB1I4=; b=v3DhcaiHL9cZHwZWQrqlhHN0mK
	dKF9kQjLp25GJb6QLrE13U/1Mg9Ef8EbZAiGd22v8ZY3E1BVhdAbYsX2KzcGW+EDWqFHJzwxRLKEl
	0VIeRKPZ/6J2+TsY6A5KPlF03CpvQ4XRDZ/PhTlR3+7j2Nb/zBQP8H75pHMZRYQyriOp25xwRg7vi
	lY+vtlVz4NzB0OYFjonmF/CwZVEr333kFGAABRTSFA6tkbuqu4KEzgtsGFtZUN6Vh+ODvupaM5OXJ
	mKUoK3aiQw5D2RXqjoaRDEHWKQMQOCeIVHbVoKkQV6cKUrzcO5mtPwmjTv1nheKUdK7tl7f39Xm4W
	4l8T+Qnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY89-000000000t8-29kP;
	Mon, 25 May 2026 16:26:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRY87-000000000sp-2kur
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 16:26:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C471A6008A;
	Mon, 25 May 2026 16:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4A81F000E9;
	Mon, 25 May 2026 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779726374;
	bh=BukyjJ4n0b1AMw2DENX11/eFZaQYpsl8U4gKYqCB1I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mjko0xfl53oi4XNYCKyMqV0lC7OCOPRG43ZpXvFlmbb2GmQu1zBeQ3vvxrEkDHRx+
	 /DzBIbN4OZP4tqdPfpytw0kVz30WHHlK/zLwudEJf/6KzUPMbTuER54DKBiXs4IJHF
	 NLjTPsyHuQyZOsnvbbf72IvYe15m2t32gREaXodAq/PMbvbSOxdR4jRG67EvLFg3LK
	 uCfAmoKHT3v4n3sPCkbNlVHBof0XAPnuRwVATI02X3is7RlSrnA5xUP6XJPnw+tnNi
	 khTSaV/4iGbuge5+xYy0CBtpT4wIOlu6wcMOqT3rOdL4vQTOso4lcX3V7Ew1HX2iRQ
	 9XloEc9VWjomQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kselftest@vger.kernel.org,  rppt@kernel.org,  shuah@kernel.org,
  akpm@linux-foundation.org,  linux-mm@kvack.org,
  skhan@linuxfoundation.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  corbet@lwn.net,  dmatlack@google.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  skhawaja@google.com,
  graf@amazon.com
Subject: Re: [PATCH v2 02/10] liveupdate: Extract luo_file_deserialize_one
 helper
In-Reply-To: <20260514222628.931312-3-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Thu, 14 May 2026 22:26:20 +0000")
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
	<20260514222628.931312-3-pasha.tatashin@soleen.com>
Date: Mon, 25 May 2026 18:26:10 +0200
Message-ID: <2vxz33zf78wt.fsf@kernel.org>
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

On Thu, May 14 2026, Pasha Tatashin wrote:

> Extract the logic for deserializing single entries for files into
> separate helper functions. In preparation to a linked-block
> serialization for files.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav


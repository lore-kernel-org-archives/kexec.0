Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB33AC55184
	for <kexec@archiver.kernel.org>; Mon,  3 Aug 2026 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JhfNGyoj6gWauQ3L4lUW323UQobqUhOK0WUh6mOtMxg=; b=k5862LckKTfau/RhyoB1LaM9mB
	f4CTrwOO+SL5eMDvcYOWRTetOKy7wpcJyy2paXDtg5eplLdg7IUqYkUWUNwFu1XFGSl0kAjgFpaR/
	ZS6fm1PJ9T6hHVAYQq++KIluwX9nJmd5Xn8k8Y5zWRHOGtiLPtpQURKTk9kzyZ9/EsEawSO3ILAsw
	diEwC9v3ia3h9nqq2KvKJneL5SMdma9v6Jrsrf5V6Ky6WEgBw/fvlInJx9Bq9TEAd5zxFpvkrF0PG
	srTecEjTr3oZXDrHAVg0aXSxmyLhnY5qrEAze7VyfS0iDhxfz5EXWKyVqXSfwrzN4KQMo5HXml8FO
	GAkGbA0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqpgo-0000000GooX-2v9o;
	Mon, 03 Aug 2026 10:14:34 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqpgm-0000000Goo0-3b87
	for kexec@lists.infradead.org;
	Mon, 03 Aug 2026 10:14:34 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so15767a12.0
        for <kexec@lists.infradead.org>; Mon, 03 Aug 2026 03:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785752070; cv=none;
        d=google.com; s=arc-20260327;
        b=DHElJD6SC7HDNdS2WkXSbqp4mV1iJjKAlFE+N05GQ6brx8WsEtwzmR9F7SjViPIRo8
         uU3jRJhXX2a6ZH+mTD8gpPwaBIQqdIq8HiEwF6OSQnzXbzNmJiK6xMw6hLaU8XoVYj2d
         RpO3G+aqMHC7xMOFjy1Khz61sUtHLe3TzetV3AP+K7gchsLhSJ87NS41h32DDaS/0fhZ
         g/z4ctHsOBuonsjB8pZEGgn9xAiVkLUYayLul3jGxZJ+O0ixdZPONDoEKkl8/c6YiMs1
         ZsXhDYAt7Fmcd8IRKNjSPSJCL15vkCZcxcKnnxtUbIwZGpSn7aLcKHjRWJNKmgbf56Sl
         KcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JhfNGyoj6gWauQ3L4lUW323UQobqUhOK0WUh6mOtMxg=;
        fh=4sTUkNBgzD9yf2L31mkvc7C274LIjqXpRSOWQcw29Pk=;
        b=Gwvrpg6UZiZdE3YSOvATj98pXxjSwCHTyhjxIJFr7HDKicDwtdVuTcKx4br4ieH3Ua
         8B47BKaMbKN4Bvw7YukBWSoFrcubmePqlm3xlJ+IB4JX/nU9b5klOQYoLESOjO9e42Ih
         CAenmHOSKSpcFT5bBYb3kW0A0nw+W48kv0qya6vTIEqvpNKpMuR2rCpTqm/9TgcaJ5SU
         rUdsDk755d0LLwD/aG+BfjkKusKKVprbtxKFgR73nVPdtkXC3IgQOlfJQjbCURsitMRI
         lnO6huNMgGL+WcJqeOHGOZia34Bg7d0I4RqTEAOgq+SmBS/TEA8WkIvj/3EeR4e80AXg
         +NZQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785752070; x=1786356870; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JhfNGyoj6gWauQ3L4lUW323UQobqUhOK0WUh6mOtMxg=;
        b=k4NQsHtY6WlgqzaLiiZrORgOv6/5wNPrwESJC0Zd1HxyNhHNCFmT/MlrpPux9H+hV5
         IT2fSAb2t1F8Pre21E5lATo6WbJBSGCGlONDTp729YFt7X4w4IAMm9stkn5e7HBpyO0/
         ZXR7D2qhr7lTvzGTfrI2jgjpBQopZtf6t5b4RgT9MFhew18V5UKYAjFS9D6Wmw1kHd5v
         LPSwXsBLI+iomR10i192ovMwCYwC+mxtx3On1GISzozw9D2m2jUt3ho/EucDcCcs6rV2
         vnPuUMavGcFsN8skKfZJYivElsf1se0kUlQE0uqbViyObsaZjbbdYgqRWbYlQSUx1sm6
         085Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752070; x=1786356870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhfNGyoj6gWauQ3L4lUW323UQobqUhOK0WUh6mOtMxg=;
        b=e+gPZkxA/bNQ/vpEfE3VeXzHBMqy5zHPwZ36r9CYJ9xwd62yUj2lHiDmyl8xqnlSEP
         0LNjLa4HiRYDiN9juo8UBmYL+auH5xYW5ksBxtHHNsVD8686+PBeFbQ0zvEVtX0Gwsiq
         xF3o7v1WHdFaAWyIfmgsCh3uW7a6fNYgyHumRT9Rke1a/Yh1u/BOeIvY735jF60IMFWi
         KOHKH/fzJXvHkX2ygXsBKMZhNAO3Ev6PDS71OvyL7Xjaf94KIFi98/haXwWcS/AzMXdC
         vldsxd0ll0Xs8pYt17JmXzDrXEJcA5dTQJ+V6NcRMMG2u0+5uLETN3VbrvJl8K/GLiz5
         Vy1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrh11w6rvzyEsex+o7J3X2X3lAfkYu2DyuAyXMkRHNAuTb7D0URBUkt9B7iQAepBcOqPLjRug==@lists.infradead.org
X-Gm-Message-State: AOJu0YzuxoTAfnIoPOH0QeavthP7XsQzkIu2S8p7GUE6o1HkSCUMWWZh
	DJ40rrz949IWwQHrVCxKGXmsiID7PfGlIH3xsLsDH6hpxsRWSbBQFjOCXE6LjeJyrYUqsEJ3nOm
	liibK8XOAxHrxmwjeWRShcQUc9cXbGebfU1UvZXZgGxwlaRx40Vdi81IC
X-Gm-Gg: AR+sD10WKa2jRUp21EYkw1QzL8WMFKbjRk1+DFlaR1ve1HZtxN/+zlVpA00G2s571gk
	QyCPyH4lb1xn7HWLSNNWW/0XDHg5AypMdIcW1Zmu4jk5hPOqNmkMsf6KsoKci9fPZdyFxsaB0wp
	3KtNHs7nR+Pt2ksdroP1bjc/BOSvl8Ww3H23cEhrYl2drrNZTX5VlY/dA1b4tkWk9M4wYEetuBE
	bTdRNH67MKiPLpv6uvrlgKqFSpL151NkAV5soYoQV/TyOiLDhtr9+gNeDmV3GZ9OtrefWyKzr7U
	ka0PR6J8wRltSWNWsSYep+pZHteHRqYsvxxrJt5JoRjOf57HU9v5uip4K+cIlmLDkGI4nw8fFPD
	5phvCv6Qo
X-Received: by 2002:aa7:ce14:0:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-6a0a84fb3b5mr117552a12.8.1785752069382; Mon, 03 Aug 2026
 03:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260717134028.2880508-1-mclapinski@google.com> <178453346331.1178000.18393988680596713513.b4-ty@b4>
In-Reply-To: <178453346331.1178000.18393988680596713513.b4-ty@b4>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Mon, 3 Aug 2026 12:14:18 +0200
X-Gm-Features: AUfX_mxV17yZnjq8GhJvKqca064Dy4Pslz3w1Zu1qT_JOmfoWenIfP3JTE0c8GI
Message-ID: <CAAi7L5dE=oROWR0mTknPyjnL-XRXuCUsfHSiGh7yUqWCSzE5PQ@mail.gmail.com>
Subject: Re: [PATCH v2] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Alexander Graf <graf@amazon.com>, Evangelos Petrongonas <epetron@amazon.de>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_031432_911992_C34B862F 
X-CRM114-Status: UNSURE (   8.47  )
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

On Mon, Jul 20, 2026 at 9:45=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Fri, 17 Jul 2026 15:40:28 +0200, Michal Clapinski wrote:
> > kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
>
> Applied to fixes branch of liveupdate/linux.git tree, thanks!
>
> [1/1] kho: align kho_scratch to MAX_ORDER_NR_PAGES pages
>       commit: c553c774c9715e1c92c48b342f30d60601693fb4
>
> tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
> branch: fixes

Hey,
I see that this change (merged 2 weeks ago) didn't make it into linux
rc6. Do we need to do something manually to get it into the nearest
release?

Thanks.


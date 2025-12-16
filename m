Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB754D5E130
	for <kexec@archiver.kernel.org>; Tue, 16 Dec 2025 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwnbHUt8FwPMGR5zEBs02t3SwzZTk4LvLl9pDB4t8Yg=; b=naWR1S7/g7bYVpT22avEGsE3Pm
	x86h2l3nj10mgnv7VpOCffPXCUCXofcuWMOeEo/PcjLpE2v/PuYU/IxkgamreF5NgN+Q5ICFVGrl1
	xdCVI7948gAR0UZ4PqnRzcTA/XlBdPqQHtEASxBLRB3v6HY3ZQpRXiG0Q9Ign1R2HjVEWrobrCrbM
	qlalGwxfAW5p4qTmcASkwFT37cOx4gSpVjPMMfTGbhTVP0uWcsljUxESK4MV3jGW+o/144XwzVa4N
	r6GwxBfXgx/QEkrJkS17MU6p5I/gCvXk4G4KDjLFnbFZ31H2fbAXldkjoZvPyuesMEXZxfGGgL5Y/
	M0Y/U9TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSn3-000000054xq-3ohm;
	Tue, 16 Dec 2025 11:00:25 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVSn1-000000054wm-1FAE
	for kexec@lists.infradead.org;
	Tue, 16 Dec 2025 11:00:24 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-649822b4b64so7006008a12.3
        for <kexec@lists.infradead.org>; Tue, 16 Dec 2025 03:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1765882821; x=1766487621; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwnbHUt8FwPMGR5zEBs02t3SwzZTk4LvLl9pDB4t8Yg=;
        b=fXe2pk7iV1jKlVPQYp990eMBlhJf3kzZOgNXuKRIURAW46U2vr3nxJyScacRydgUdb
         XwwiIzlwEWP0Rkot5hXB2+6pVUTaf794tA2fICbU7KKcqSrAh1qk2++SW1d/CnNBdLA9
         b+ZJKdwagDF33ngfcnFRIY8UijTqT/mCta7l7xjrm9eG561TsL2DxttJMEYfEUnd4S04
         ToFkhndX5P6BEhXmCOSo0/Cl+qqO8UcRkm+0ZDMao5R/+sLUKBi8Ym9o+R8c4n82ygxt
         e9ZI27H5MUGX1vyWG/Hj82tTJ1lXC+C1kiDf3mSrDC6quZNZa78ZOa7jqMR4lKT9Hg0T
         RVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882821; x=1766487621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwnbHUt8FwPMGR5zEBs02t3SwzZTk4LvLl9pDB4t8Yg=;
        b=au5A5AX7Xuh9DXbfOZ8YIel216vfLDg41b3Y6N8rVJCI7HoVhryx0Sf+hNU1ThAWPq
         I48RKlfvEmmOKdU2VY3fm+6Vwgm+xnG1G8vF6rPZtADmv3pOpnpAuk3W3Ghu9kQcGZve
         pB50I3VYvQCvASdBEM1D5jjsDdvrIhz7YTymqYtPMG/yFliXqM7Cik5IMRt6OTGVn21F
         UCxXrKIOKpyup1S+uB6vIJ6y539PybQuTFEpy5bsYM39mRGsy2l2RDrpKoEeJM2py2jf
         iUgdIzhX7Ji2i/W26XIz3CbY8H6W8O0kUcxs+X5UFiP+CJA514inwziKn/IOyuaL6Syw
         TSIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXHZWWishipfrI0/bpyV3OsJsUscH/s2tqmeERTpCPlpLwJQeeABcDhgi/4xwybxU9/c/Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw06zG/LwvLcZsOrsYG6fmfEVoD3PamwIzFC1uS6i9MNCO5KcVD
	H13tM5SSd+2w/F8kRu0bIZTtRrM8mDHEOV5ZkP9td/nPwSgjpVr4BaefuysvjKOKrpwF9HTdSNQ
	Vm/YcqGrkuPtpSqiDUKFodQXWWFs8yAZCuqsJiVNgjw==
X-Gm-Gg: AY/fxX4V+dCBw+zGzWWMbjhYqcGdQaGtvk88b2M8kgqkCWY0OytNZACD7+QxfnGMCfp
	lFNpKMqs106/RbNZ+BNFoHxnPieMkqG7YVtzLmTPW8FTV8AVHRpW25t0pEh30Eej7sC8fpYFyhh
	8S857UVbHra6kvpt7xylwCM6qF/BpnxQjEVwHEQSf2hRxN2x6U7zsBdCreIJ7u6o+ZVxLzOZMoL
	wmTbw+UlxdP9Bui2zMf2vylrhQ2SDXcUrvw1dc2Iw3qYlXdFrBKJm+L4Q+nkIfA+z9dyYcMSqjO
	ZdQxOovxpOquYBvagb/NC03e
X-Google-Smtp-Source: AGHT+IHe9jgtfFM7Qc6zeEO8dBHCnRGVv9zMmqW1J4ecojexXOkQ0I+gWFpbhh/0kCc8H5IhTix8cpujcdlgDux9le0=
X-Received: by 2002:a05:6402:5108:b0:643:129f:9d74 with SMTP id
 4fb4d7f45d1cf-6499b110064mr13972297a12.7.1765882821364; Tue, 16 Dec 2025
 03:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20251212071204.398788-1-pratyush@kernel.org>
In-Reply-To: <20251212071204.398788-1-pratyush@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 16 Dec 2025 05:59:44 -0500
X-Gm-Features: AQt7F2ov2UA3P0tt9OB3YzI2ABkvyFk5SEu8vsN3nea8eX6SWcu2ncLggHlZ12M
Message-ID: <CA+CK2bCSknk-r+nhue70Fn5gb=u=Xdnvpb7ORksrmpVgCC6j_A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add ABI headers to KHO and LIVE UPDATE
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251216_030023_342357_5763CDD9 
X-CRM114-Status: UNSURE (   9.56  )
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

On Fri, Dec 12, 2025 at 2:12=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> include/linux/kho is supposed to hold KHO headers. Add it to KHO's
> MAINTAINERS entry so the right people can get patches to it.
>
> include/linux/kho/abi contains the live update ABI headers for LUO core
> and memfd. It will also hold ABI headers for other upcoming file types
> as well. Add it to live update entry so live update maintainers can get
> changes for it (currently they happen to be the same people).
>
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha


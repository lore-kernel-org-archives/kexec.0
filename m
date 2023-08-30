Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20881C83F01
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 15:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=skd7vmJdK3LB+buW2uG/N/9WTGw+Yg3sKS1LK0KvmGc=; b=qz6rVtnsBFpPUx
	Moqx566K89tKhvWJLEvLxRa1OVYSa6NCET4c5jZMNZgkGMMbnOf8panE/fFoVtlxpnHCPZhZ8FZ2v
	mPLRovvNk01P7yTQHAehFJOHMj2hVUJTPt/yVkDME4Q3Ai6ixxj7uTfew6sYTs8ScLxBgfticcL/r
	RId6G3HCXtco94XOdXn6FZs0O12kvSgn5/G3YOFOpfAkU1bxpPSnnoGxmHFZX0Zdyt9IBzyXvwGP7
	HP3tJbC3pvE/Gkr32GFt8xZIwuYsaLn3dpRHLBwoJGvnPIgEQ9erytmLGj3tLbhNAJ7BLbentsgex
	5OXAStUYEpmMeH7C3FHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbN9T-00DlUE-2e;
	Wed, 30 Aug 2023 15:30:39 +0000
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbLyt-00Delk-1H
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 14:15:40 +0000
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5733d431209so3436002eaf.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693404938; x=1694009738; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCpeAPS/CibFq665kaK2mvNCIQFGx1fXEcmTzAPISWc=;
        b=J7HvIUrILXxwvzHga9bHvd/gIUoX60hb6i1N3PtxHQauVIhwRIlJWC3Uy9x9FUVzNA
         NxJcMJ/v5Kl2CiEXuJvDfWrO2PNmdKg940lpY6au9i/PzrdJWDO6FX6CiN2GVAkTXRe5
         Z1/osOrzz3tfsBSx7Z4MS8SW7lMdLBvCwEBygQRkO1Utefuh4Z7B1gqgwsfcSsVleCv7
         kKw8O4+PWKtFUds44lZsYid3lIPTchnAC1TzeIygEEMdcZbGaEk3pY6+2zZ1oa1GCqiN
         lyCz2Mg7fDP1K7HLbWTxnd/kTumczO1NsHWnQKETUxbzEDgGFfMNQdWoufJNJaPL3WFY
         lS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693404938; x=1694009738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCpeAPS/CibFq665kaK2mvNCIQFGx1fXEcmTzAPISWc=;
        b=WFlCPsB7o/UrSuvKBMa3nhuHTYykV5Y5hf6nrhdEp6AwZkiqLxdRprgK+2aHZFpRwt
         d7hAzyLxRcufacYSk6FzPds/zbOwk6Dhr5in2tn8VHbXXJCPKxpMTilVzwnaeiGm0NIB
         eIbI7oSpSglbq5fXHm/Aa8mYcU2alZ0lNBiz8medbj/jIkb/wEB6btupPcJqYxSJ03dD
         1zarWhfHcybC8nIOHKfi7vfVSLhSXd14IlTUaAQxrS/e+2vhFQ0E+ZwWArI8iR847k6R
         zTNL8RgKJMsFGBnvjqWz7+YELreXqwQ1pRpzgZ5omrtSzerxck15CxOGhYYpQ1rYw7DE
         Jogw==
X-Gm-Message-State: AOJu0YycBgn4N1WIIRq+0Uy7/AkWoC8Hcxy8IAHbBQMz7YBdr9V5VEnA
	+dPYHGekaVwafS5p39BVcL/A9Fj1HMYr1NMzTBQ=
X-Google-Smtp-Source: AGHT+IFFDnRR2uY0HMprngD3qnR0QCHLsvwLy0H6o8N6F5irKWos3ZRHDcMLDSu3VnmsJJtI9HCVvtNsuy0h6t1SXXo=
X-Received: by 2002:a4a:9196:0:b0:571:28d5:2c77 with SMTP id
 d22-20020a4a9196000000b0057128d52c77mr2188112ooh.5.1693404938283; Wed, 30 Aug
 2023 07:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
In-Reply-To: <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 30 Aug 2023 17:15:02 +0300
Message-ID: <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To: Philipp Stanner <pstanner@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Christian Brauner <brauner@kernel.org>, 
	David Disseldorp <ddiss@suse.de>, Luis Chamberlain <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, 
	Nick Alcock <nick.alcock@oracle.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Zack Rusin <zackr@vmware.com>, 
	VMware Graphics Reviewers <linux-graphics-maintainer@vmware.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, David Airlie <airlied@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_071539_456937_49960B8B 
X-CRM114-Status: UNSURE (   7.96  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0YW5u
ZXJAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+ICsgICAgICAgaWYgKHVubGlrZWx5KGNoZWNrX211bF9v
dmVyZmxvdyhuLCBzaXplLCAmbmJ5dGVzKSkpCj4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJf
UFRSKC1FSU5WQUwpOwoKPiArICAgICAgIGlmICh1bmxpa2VseShjaGVja19tdWxfb3ZlcmZsb3co
biwgc2l6ZSwgJm5ieXRlcykpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlO
VkFMKTsKCkJ0dywgd2h5IG5vdCAtRU9WRVJGTE9XID8KCi0tIApXaXRoIEJlc3QgUmVnYXJkcywK
QW5keSBTaGV2Y2hlbmtvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

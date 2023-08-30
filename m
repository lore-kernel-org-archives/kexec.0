Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC0C6FA8F
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2o4FaaxE0tEAMKhHviLN9GSgO2Uop7sjE04OpleVuiU=; b=Jz5KFYxhKytMmV
	KQYgXtFR0ibqAEOPHZYLpdmls3f34efbmK4fva6avnCurqaoB3gTP3a2Hc6MpdW8vhp5fEm8KWcCO
	DofwgqxAqJjvOlC5ePt4GEEAuYlPpBR8jE1Upfswuw8gE2m6kz4tgyQVMKdH03DRmovWOxj5FbvcE
	a6Zk+Hsz4ZiU4zZNYLDG/V4AB33jgup9ex9piau999LGEsP9Dtc09GV/eHiWq1Xap40K9RmqKoRbY
	9G86U1okkBUgNhh/kx2pfebmKVdBRwyROpkPkS6BdMiW+P30QTOnVKyTQTPT0L/qQVwXAi1ED5WqF
	4cGNr0nrAYnMaMZbhY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbM6I-00DfMd-2Z;
	Wed, 30 Aug 2023 14:23:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbM6F-00DfM3-30
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 14:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693405394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
	b=Akvmh1yAb35F5xpAl/Lm+uXDZo+cFqsKdiy2StQEZmcccAC70cJXdAnVjUuk5LeaplByHJ
	wa4DSAAzvLYUHpkYfInM0lyNXTbGFPeecYT72loaFmLKFg7VJtXv6dr8F2FUfqVoaMhUkn
	Rzs/QTBGrzfX6EKAxmZe4w8CMYjOx+4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-otiLxWeVPqOKGlliT1Jt3w-1; Wed, 30 Aug 2023 10:23:13 -0400
X-MC-Unique: otiLxWeVPqOKGlliT1Jt3w-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e535b143fso366088a12.1
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 07:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405392; x=1694010192;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDWeZz8lwtK2Vw963Pp4K5umQAhzGapmgVnLNgStcjo=;
        b=Pk0gOmRfId0pDH3S1aMzcceoJFvrsblKnjH+vNvTtmrQtgzTXdqQWVg9liwi5gxP5j
         NBrFRiE/f1gqkFrd6YQCybVeEkeLqZ8/3+eHZ1/QPAHzbJNcXDH2Jdlboz1sDVEAaWqn
         5uHjqu+pclSA77BZmfv/ioP50MNov3m0ZRpb0jNlNG2/OaXqIzRnHgBOVGUfmZtNAJeJ
         xhuHgGPH0sNlHR1wbKcjBCxdrU9fhEMeALoWFx23qPaY8wR6nNjUeHJsOH/R+sU17hM0
         Gm0yDRM0idF9yRrXjfn3YhRmjU32+b99pP/PsIOiznPQRPA6ZS4GXJTYMi7jOMlY3r2v
         Hc4Q==
X-Gm-Message-State: AOJu0YwrKGfuhXSFg3toPjrTLPvpiXqXIIBtqdfCfYQwKYeco/kX77O4
	gfhMp4xOUuEd7kDSmSOEVZVaTp0Oiu1ttFq3KfG4kHg7LBb28Ei6nJSO1LHRK/nWqJvGenBqAq5
	9x/a31vPQLPZ1ZuFh6Icbp6wtEWKM5mQ=
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019172eda.2.1693405392373;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEETjNW9wp/fQvTrgjMQpXcwVHdHwUrjVBdjXk8jizCaYvhqq5Q/jtzkYzdJEKBqJ9axaU5/A==
X-Received: by 2002:a05:6402:4404:b0:51e:34d8:f4c7 with SMTP id y4-20020a056402440400b0051e34d8f4c7mr2019152eda.2.1693405392119;
        Wed, 30 Aug 2023 07:23:12 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0052574ef0da1sm6830091edt.28.2023.08.30.07.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:23:11 -0700 (PDT)
Message-ID: <a79b3c34a12abc51bc5e840ae3a87ab9a47f7742.camel@redhat.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
From: pstanner@redhat.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, 
 Eric Biederman <ebiederm@xmission.com>, Christian Brauner
 <brauner@kernel.org>, David Disseldorp <ddiss@suse.de>,  Luis Chamberlain
 <mcgrof@kernel.org>, Siddh Raman Pant <code@siddh.me>, Nick Alcock
 <nick.alcock@oracle.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>, VMware
 Graphics Reviewers <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org,  linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,  linux-hardening@vger.kernel.org, David Airlie
 <airlied@redhat.com>
Date: Wed, 30 Aug 2023 16:23:10 +0200
In-Reply-To: <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
	 <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
	 <CAHp75Vc72uuNvFxq4TGO=nXoGhbqVxyqvQ67ioL8ajtZwMUBgA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_072316_062753_AEA61E19 
X-CRM114-Status: GOOD (  10.53  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjE1ICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0
YW5uZXJAcmVkaGF0LmNvbT4KPiB3cm90ZToKPiAKPiA+ICvCoMKgwqDCoMKgwqAgaWYgKHVubGlr
ZWx5KGNoZWNrX211bF9vdmVyZmxvdyhuLCBzaXplLCAmbmJ5dGVzKSkpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKPiAKPiA+ICvCoMKg
wqDCoMKgwqAgaWYgKHVubGlrZWx5KGNoZWNrX211bF9vdmVyZmxvdyhuLCBzaXplLCAmbmJ5dGVz
KSkpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gRVJSX1BUUigtRUlO
VkFMKTsKPiAKPiBCdHcsIHdoeSBub3QgLUVPVkVSRkxPVyA/Cj4gCgpHb29kIHF1ZXN0aW9uLCBh
Y3R1YWxseS4KVG8gYmUgaG9uZXN0IEkgd2Fzbid0IHF1aXRlIHN1cmUgd2hpY2ggY29kZSB0byBw
aWNrICgtRTJCSUcgd2FzIGFsc28Kb25jZSBJIGNhbmRpZGF0ZSkuCgotRUlOVkFMIHdhcyBwaWNr
ZWQgYmVjYXVzZSB0aGUgaWRlYSB3YXMgdGhhdCBhIHJlcXVlc3Qgb3ZlcmZsb3dpbmcgYQpzaXpl
X3QgY291bGQgc3VyZWx5IGJlIGV4cGVjdGVkIHRvIGNvbnRhaW4gYW4gaW52YWxpZCBwYXJhbWV0
ZXIsCmJlY2F1c2Ugbm8gb25lIHdvdWxkIGV2ZXIgcmVxdWVzdCBhbiBhcnJheSBfdGhhdF8gbGFy
Z2UKCj8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

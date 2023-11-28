Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A49AC07CA9
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 11:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L6NHCOev4lQ4Zf+YwVpJYXPYs8RqyBcQsph5alCSfhk=; b=LtXjAhGmVk5thS
	QUTiaFpw/veNqdg4b0/CQiaRgkAp6EiD+GP0tcQUIJn7c1ufJhFor6kFdHAVcoPaMiv9nDBmfr0MI
	toKchazfpHwCAz737RKijcSFuFi5qLRnP56H326GFyyLpRkpwp5LZE+zHeMoWPi9J51bv63f/Dody
	aC+lz2rf9EvXd0jx6wmx0Im5I04UisEQjpSU2DB8mavsV08dyjtg85qQZ/iVNkfX+AUwWTJx2koOq
	/kLpxoZGhOnwIDvmqD1rpkJgUYOdTJEz6p4wLOzGN8o7gklulvtKAVTmMvyDAiLRKqqKyd1/ZZsF0
	p9mKxVWnKbEXDe/zdYQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wco-005FCk-1F;
	Tue, 28 Nov 2023 11:51:34 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7wcl-005FBy-0I
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 11:51:32 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2859551886cso3049274a91.2
        for <kexec@lists.infradead.org>; Tue, 28 Nov 2023 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1701172290; x=1701777090; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86YcOJ2RQyi48TWuQ5HdsvkloxVpkC018HUuY5xlNz4=;
        b=QBP3MOFEYmzB6Gp1TGvAKNg6L3sqZzw+XaYsb95Ij7CLuICh4UU22GG+/9cPjZVFNM
         M786gAJtqmmlBoPszC2LhM5VTeANhB8nlw9Y5JcMpWImKQaRHTvDPazXEqkyvcOYs1gf
         tdafLwO95vSz6RUxlsNXfKboW+YEKBGLh43jFTvtieB4tDRas1S8t0LCIa2IKd8/Rwkr
         qAAjv22I3yRqmyiY+KQ3txrIXj/7uVZ3He/XG9S/Ox1sOy/CgSLB3eG51xqy/bs1gOII
         XFMOLIgaJzVzzzHYCOQDIGaeZ9ieu4vtAYnjlwyztBUmf/sX/Ev5YQou++zANnzYOgLj
         Qypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172290; x=1701777090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86YcOJ2RQyi48TWuQ5HdsvkloxVpkC018HUuY5xlNz4=;
        b=T4IWjNSjR7IeFM6/qqrcRoW32o+5NQTuCRt4yYhvQbbHwxtqKM5uYnrW44jNOKKBLr
         npzdabX1/jzYLA2elMrJ8OmxnAD+yLXAITgMFUeOnUcj/JIJGTbkR+Mpb3Rm0Exb+Pfd
         XKMI52f6trcOdz54t21Aa5WmPf+jvR7Un3WGYxLmc6qFNKXZ1IJakyx+WHlFsBcn3nx4
         mQB93SL95DKeKKoI3HFkzk0yHhGlfHBUPhdFxvwX1G9Z7NHxe4qQuAuq+/tE1fbr8PMF
         htZnrIJev5NELOGzn+UGKHzYhQwuHQT4SbH4EmaHMwQO80DBgMk/s4DFeHmFiChFS1xn
         tbTw==
X-Gm-Message-State: AOJu0YwL+wo9X9xHbIcpH4xyMSX62lDlEobejxt1OmbLQJAQdsE0pRvF
	rO5UzNZ3G/cS3okLkE59quylS5YAr5ibJfioO6t0TgvkhNNSLg83PW0=
X-Google-Smtp-Source: AGHT+IGmJKRteYV5UGlTJ7ecqKXrP9sLP7hWcJqjHvzwcLS3pfOQtgmuZNcPIe9Ge6NrNkjpEKxoTtQ2N7C4b8WjL7g=
X-Received: by 2002:a17:90b:3804:b0:285:d6a2:3bf9 with SMTP id
 mq4-20020a17090b380400b00285d6a23bf9mr6643833pjb.11.1701172290035; Tue, 28
 Nov 2023 03:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20231128055248.659808-1-bhe@redhat.com>
In-Reply-To: <20231128055248.659808-1-bhe@redhat.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Tue, 28 Nov 2023 11:51:19 +0000
Message-ID: <CALrw=nG0AhxEmx39bnvM+CKh8bFijvsAPGU3CFY5Top0prS3yw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/base/cpu: crash data showing should depends on KEXEC_CORE
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org, 
	akpm@linux-foundation.org, eric_devolder@yahoo.com, agordeev@linux.ibm.com, 
	kernel-team <kernel-team@cloudflare.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_035131_129129_E7F7312D 
X-CRM114-Status: GOOD (  19.12  )
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

T24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgNTo1M+KAr0FNIEJhb3F1YW4gSGUgPGJoZUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEFmdGVyIGNvbW1pdCA4OGE2Zjg5OTQ0MjEgKCJjcmFzaDogbWVtb3J5
IGFuZCBDUFUgaG90cGx1ZyBzeXNmcwo+IGF0dHJpYnV0ZXMiKSwgb24geDg2XzY0LCBpZiBvbmx5
IGJlbG93IGtlcm5lbCBjb25maWdzIHJlbGF0ZWQgdG8ga2R1bXAKPiBhcmUgc2V0LCBjb21waWxp
bmcgZXJyb3IgYXJlIHRyaWdnZXJlZC4KPgo+IC0tLS0KPiBDT05GSUdfQ1JBU0hfQ09SRT15Cj4g
Q09ORklHX0tFWEVDX0NPUkU9eQo+IENPTkZJR19DUkFTSF9EVU1QPXkKPiBDT05GSUdfQ1JBU0hf
SE9UUExVRz15Cj4gLS0tLS0tCj4KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBkcml2ZXJzL2Jhc2UvY3B1LmM6IEluIGZ1bmN0aW9uIOKA
mGNyYXNoX2hvdHBsdWdfc2hvd+KAmToKPiBkcml2ZXJzL2Jhc2UvY3B1LmM6MzA5OjQwOiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYY3Jhc2hfaG90cGx1Z19jcHVf
c3VwcG9ydOKAmTsgZGlkIHlvdSBtZWFuIOKAmGNyYXNoX2hvdHBsdWdfc2hvd+KAmT8gWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICAzMDkgfCAgICAgICAgIHJldHVy
biBzeXNmc19lbWl0KGJ1ZiwgIiVkXG4iLCBjcmFzaF9ob3RwbHVnX2NwdV9zdXBwb3J0KCkpOwo+
ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fgo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgY3Jhc2hfaG90cGx1Z19zaG93Cj4gY2MxOiBzb21lIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4KPiBDT05GSUdfS0VYRUMgaXMgdXNlZCB0byBlbmFibGUga2V4ZWNf
bG9hZCBpbnRlcmZhY2UsIHRoZQo+IGNyYXNoX25vdGVzL2NyYXNoX25vdGVzX3NpemUvY3Jhc2hf
aG90cGx1ZyBzaG93aW5nIGRlcGVuZHMgb24KPiBDT05GSUdfS0VYRUMgaXMgaW5jb3JyZWN0LiBJ
dCBzaG91bGQgZGVwZW5kIG9uIEtFWEVDX0NPUkUgaW5zdGVhZC4KPgo+IEZpeCBpdCBub3cuCj4K
PiBGaXhlczogY29tbWl0IDg4YTZmODk5NDQyMSAoImNyYXNoOiBtZW1vcnkgYW5kIENQVSBob3Rw
bHVnIHN5c2ZzIGF0dHJpYnV0ZXMiKQo+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUBy
ZWRoYXQuY29tPgoKVGVzdGVkLWJ5OiBJZ25hdCBLb3JjaGFnaW4gPGlnbmF0QGNsb3VkZmxhcmUu
Y29tPiAjIGNvbXBpbGUtdGltZSBvbmx5CmZvciB4ODYgYW5kIGFybQoKPiAtLS0KPiAgZHJpdmVy
cy9iYXNlL2NwdS5jIHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvY3B1LmMgYi9k
cml2ZXJzL2Jhc2UvY3B1LmMKPiBpbmRleCA5ZWEyMmUxNjVhY2QuLjU0ODQ5MWRlODE4ZSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2Jhc2UvY3B1LmMKPiArKysgYi9kcml2ZXJzL2Jhc2UvY3B1LmMK
PiBAQCAtMTQ0LDcgKzE0NCw3IEBAIHN0YXRpYyBERVZJQ0VfQVRUUihyZWxlYXNlLCBTX0lXVVNS
LCBOVUxMLCBjcHVfcmVsZWFzZV9zdG9yZSk7Cj4gICNlbmRpZiAvKiBDT05GSUdfQVJDSF9DUFVf
UFJPQkVfUkVMRUFTRSAqLwo+ICAjZW5kaWYgLyogQ09ORklHX0hPVFBMVUdfQ1BVICovCj4KPiAt
I2lmZGVmIENPTkZJR19LRVhFQwo+ICsjaWZkZWYgQ09ORklHX0tFWEVDX0NPUkUKPiAgI2luY2x1
ZGUgPGxpbnV4L2tleGVjLmg+Cj4KPiAgc3RhdGljIHNzaXplX3QgY3Jhc2hfbm90ZXNfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsCj4gQEAgLTE4OSwxNCArMTg5LDE0IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgYXR0cmlidXRlX2dyb3VwIGNyYXNoX25vdGVfY3B1X2F0dHJfZ3JvdXAgPSB7Cj4gICNl
bmRpZgo+Cj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwICpjb21tb25fY3B1
X2F0dHJfZ3JvdXBzW10gPSB7Cj4gLSNpZmRlZiBDT05GSUdfS0VYRUMKPiArI2lmZGVmIENPTkZJ
R19LRVhFQ19DT1JFCj4gICAgICAgICAmY3Jhc2hfbm90ZV9jcHVfYXR0cl9ncm91cCwKPiAgI2Vu
ZGlmCj4gICAgICAgICBOVUxMCj4gIH07Cj4KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1
dGVfZ3JvdXAgKmhvdHBsdWdhYmxlX2NwdV9hdHRyX2dyb3Vwc1tdID0gewo+IC0jaWZkZWYgQ09O
RklHX0tFWEVDCj4gKyNpZmRlZiBDT05GSUdfS0VYRUNfQ09SRQo+ICAgICAgICAgJmNyYXNoX25v
dGVfY3B1X2F0dHJfZ3JvdXAsCj4gICNlbmRpZgo+ICAgICAgICAgTlVMTAo+IC0tCj4gMi40MS4w
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

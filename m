Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC9AC46CA1
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 09:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KhCyKGagIGY1crSkU9MpNCZsEs9pOiGsMtm9lVN9W9A=; b=TCUtUEKQgCchWz
	3GlsbRTKGjd6RQ30/jGNyUjd+h1oh/X0h9gTzf+BgeHuKEVANM7tSkRodevWTXf0EIQF0jWOW0jTC
	LWGNj/OSnbybwktNh31uAMG61CwgKszf6R8kKww/P4+Ai2e7oL8nWIcB9+aZ/vojHd1KGKadVb2aR
	cmbziUDOVGK7tMVXLXtzvMqsMtr+uxmJIas+kDD5FACccMm3ZwAq/1ALRuNwVmBnOksb2407QYljg
	1gcIowWkwl8AHT3wdVGkEmraks9J6vfCpM3URSTvkD6pdXrY++9VmoX8apupZe5kpJ1OBZuQj0ibc
	3mmiLTSWjtQd1/iLQ5eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiAKP-00EvIr-14;
	Mon, 18 Sep 2023 09:14:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiAKM-00EvFX-1c
	for kexec@lists.infradead.org;
	Mon, 18 Sep 2023 09:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695028434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
	b=cd42VR+RzlMdxl2zq5h68JxAWA8yz9ZBAJOKiUVT3dhi3Lh3XLe7PsYjrzdRkGYwBOj9Zg
	RQ5B9x9uDHJvs+J7Ose05SKJ2WJjpmWVxfvQlBQ2QwXTknFhm9r27dysILszFa1kVglnSs
	Lg2Q1OKi5RFTi1boQdgEFkBDB2qbXMY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-9fUxIgRmN1GtHHUbtnbwjQ-1; Mon, 18 Sep 2023 05:13:51 -0400
X-MC-Unique: 9fUxIgRmN1GtHHUbtnbwjQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-404fc59b8acso5768535e9.0
        for <kexec@lists.infradead.org>; Mon, 18 Sep 2023 02:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695028430; x=1695633230;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySETEWMBBYemMdp3jyvFHrMDlDasjAvK3U0xoCA3NQU=;
        b=utEsvoqJbJIxZQWm9UZ6mmePgYCqPJp3ESUgSXSAWk8QXeIH3CWVZNAKQOJfjl9wHS
         CDHVU9T6RGi8F5ufvTjKHRZXpbQEcRAJJ35IPuYi4OQfGwFj1Zm78wXMzTXUI+wUBq4u
         4Sjobtye33Xe9saczgcjQl+7xY+KZbkXeIsnQ5psFJWyG/4NhyQNIp/YGQsF3o7ui5Nz
         WYg7F8jEuMD3ySYgGMxkE7sU7CzSOhY4fxsjQ/uw8wNioAsyxbqjtqcrmAAR73e7fXux
         WEWuyIQtoNr5n2OakzvdJCChVjet5rrUBnAXtREA/MYNUJPe4hLSAmcAADQmE3d2XizQ
         WlFA==
X-Gm-Message-State: AOJu0YwPsXk21KVwSwKoxNDbX6P7mPDWv/DXMXat5jyzze4+joxykVvK
	A7gsiNZ0jHPiLUiS2fQQbVksnalO65p84LqvBRj4SmTMyZ1XHgCdewjowQ6FiDk+aski1xPkFO4
	T+U8z5eLgV5rkfZhgqbDc
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416385wrt.1.1695028430601;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB8VnbhuBBqYU4diZ/ky5juLhWgDDI8ddqsgXauCCvjjTxBkK6OXa7bUUeWyDSF9cThUqM3g==
X-Received: by 2002:a5d:508e:0:b0:317:73e3:cf41 with SMTP id a14-20020a5d508e000000b0031773e3cf41mr6416363wrt.1.1695028430263;
        Mon, 18 Sep 2023 02:13:50 -0700 (PDT)
Received: from [10.32.64.2] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id b16-20020a05600010d000b0031aef72a021sm11830334wrx.86.2023.09.18.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:13:49 -0700 (PDT)
Message-ID: <72a444cd42629f5bdd56647e7aa24588d6964bec.camel@redhat.com>
Subject: Re: [PATCH v2 1/5] string.h: add array-wrappers for (v)memdup_user()
From: Philipp Stanner <pstanner@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
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
Date: Mon, 18 Sep 2023 11:13:48 +0200
In-Reply-To: <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
References: <cover.1694202430.git.pstanner@redhat.com>
	 <93001a9f3f101be0f374080090f9c32df73ca773.1694202430.git.pstanner@redhat.com>
	 <b219788a-69e6-44cf-a609-91f9640967f5@moroto.mountain>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_021358_623544_22FB0391 
X-CRM114-Status: GOOD (  13.02  )
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

T24gU2F0LCAyMDIzLTA5LTE2IGF0IDE3OjMyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+
IE9uIEZyaSwgU2VwIDA4LCAyMDIzIGF0IDA5OjU5OjQwUE0gKzAyMDAsIFBoaWxpcHAgU3Rhbm5l
ciB3cm90ZToKPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgKm1lbWR1cF9hcnJheV91c2VyKGNvbnN0
IHZvaWQgX191c2VyICpzcmMsCj4gPiBzaXplX3Qgbiwgc2l6ZV90IHNpemUpCj4gPiArewo+ID4g
K8KgwqDCoMKgwqDCoMKgc2l6ZV90IG5ieXRlczsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGlm
ICh1bmxpa2VseShjaGVja19tdWxfb3ZlcmZsb3cobiwgc2l6ZSwgJm5ieXRlcykpKQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFUlJfUFRSKC1FT1ZFUkZMT1cpOwo+
IAo+IE5vIG5lZWQgZm9yIGFuIHVubGlrZWx5KCkgYmVjYXVzZSBjaGVja19tdWxfb3ZlcmZsb3co
KSBhbHJlYWR5IGhhcwo+IG9uZQo+IGluc2lkZS4KCkFDSy4gSSBvdmVybG9va2VkIHRoYXQgYXMg
aXQgd2FzIGhpZGRlbiBpbiB0aGUgY2FsbHN0YWNrLgoKCj4gwqAgSSBmZWVsIGxpa2UgLUVOT01F
TSBpcyBtb3JlIHRyYWRpdGlvbmFsIGJ1dCBJIGRvdWJ0Cj4gYW55b25lL3VzZXJzcGFjZQo+IGNh
cmVzLgoKSSBhZ3JlZSB3aXRoIEFuZHkgaGVyZS4gV2UncmUgbm90IGFsbG9jYXRpbmcsIHNvIC1F
Tk9NRU0gbWFrZXMgbm8gc2Vuc2UKSU1PLgoKClAuCgo+IAo+ID4gKwo+ID4gK8KgwqDCoMKgwqDC
oMKgcmV0dXJuIG1lbWR1cF91c2VyKHNyYywgbmJ5dGVzKTsKPiA+ICt9Cj4gCj4gcmVnYXJkcywK
PiBkYW4gY2FycGVudGVyCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

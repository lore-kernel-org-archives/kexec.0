Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BBC83F15
	for <kexec@archiver.kernel.org>; Wed, 30 Aug 2023 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AI3DjCNAWm7qiRqJQoXzVKIA2+f2RNVnGdzs36iQom4=; b=TNgQHLNPl6ue9O
	RYpZTi//SNsroyMGK4xw433KgswRykwCQ/xIhJunR/67DgfcUdVeGZlxdqvRiXvhUcN/UrsecNSu2
	tVFFr60hOjvGNOPNcA7YALyPfj7vJdB7LP0oRELnFDHo76HRVpr/yQBX2bWamI1eSEBEBuZ7tYRIO
	I2bp+z0iEG5j+UnNg8OWkW05PlWOiHv3QfNolMEkjFSYij1Wmbmu7oSmI8fAqV9xABQTz21yG4RvX
	HShDoYZHMCEEUvc8vKFy7t4EVLw63gG478cD8FX/DE835g3soMySDSBlW2G377jsb0W73lbjzIOk/
	fz/pN5HMavqzvtwLO5JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbM2n-00Df49-1a;
	Wed, 30 Aug 2023 14:19:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbM2k-00Df3U-2X
	for kexec@lists.infradead.org;
	Wed, 30 Aug 2023 14:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693405177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
	b=AyfRwzl4eqyrAn5LjelSlfDE3RNHCWN5ocd/Shffz+9spTmRNnJTivg+0aUNQDPzzYNi1z
	qs3Al4Va+S70UUBPN5FNdmiL2eKN/Z7jVkpbC+XRwZB78K/yylYINfgdkHSR2lyoixJLsO
	Xj8oYgM+F4e/MSn9YNh2MU3SnY3xcOs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-6-M7NjlpP-ecUNYwXScADg-1; Wed, 30 Aug 2023 10:19:35 -0400
X-MC-Unique: 6-M7NjlpP-ecUNYwXScADg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a21e030751so61810666b.0
        for <kexec@lists.infradead.org>; Wed, 30 Aug 2023 07:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693405174; x=1694009974;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GV/8QzaCRMszcMvgwKB+jPm2RB1o5GXV7tIF+sEGovU=;
        b=dtK0tUXeimO+DF7I98GWMkqoEcHkZZmOBj1C0JypXkCDY7aztBnwKVryKO6x+vw4d0
         L06ZIzIuXwteVOohK/wkhFBHOs+rDmWJIa3eHF79ZE7ijdoDw0U6nKJfKp5lfRilpicP
         tbSypCDI4knUTz/WyGvatxW3hNIhTx8AvI4MIaDsTdNOzBfEAIvm/TUdkR0d6yWtLzeo
         JKlYrDnLL/8zZh9vmKiv13Xk5rVzDHp8HfVF0sU0oPtqRF5GSGEAzHHJmECItfSpNWJG
         Sxfwu1CVw7vMnY+lGtgc0lkd4JJBFJ9eaUj+nEvWO9VN+bB1Av1bDCHI30RAUnjVxpuT
         0cYQ==
X-Gm-Message-State: AOJu0Yx+FYCplDKaamIh59+3UQLGkzzcF4muz2sQQEp6JTrdDq7qwylQ
	RrhL4wq/B8fM244P2HhKNwDybqSG/F/pyhEpwNwcJNqKyJDYcKOxJVLX9DKNiXNwqHkB/fqh/4L
	LUrAUeq3oF0ItK3BqyW47
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414675ejl.0.1693405174419;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzgX4N7o6LrqPe58Ba+4el88eUYu7+fOIk9nSYCp19l8FNrUVkg7t2XIL0g9pv34yH61rp8Q==
X-Received: by 2002:a17:906:739c:b0:9a1:c951:19f3 with SMTP id f28-20020a170906739c00b009a1c95119f3mr1414658ejl.0.1693405174044;
        Wed, 30 Aug 2023 07:19:34 -0700 (PDT)
Received: from ?IPv6:2001:9e8:32e4:1500:aa40:e745:b6c9:7081? ([2001:9e8:32e4:1500:aa40:e745:b6c9:7081])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b009a1a5a7ebacsm7182791ejb.201.2023.08.30.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 07:19:33 -0700 (PDT)
Message-ID: <721a70c347d82931d12e5b75b19d132f82ee5ed2.camel@redhat.com>
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
Date: Wed, 30 Aug 2023 16:19:32 +0200
In-Reply-To: <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
References: <cover.1693386602.git.pstanner@redhat.com>
	 <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
	 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_071938_896070_9FA7CAF6 
X-CRM114-Status: GOOD (  26.28  )
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

T24gV2VkLCAyMDIzLTA4LTMwIGF0IDE3OjExICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMzAsIDIwMjMgYXQgNDo0NuKAr1BNIFBoaWxpcHAgU3Rhbm5lciA8cHN0
YW5uZXJAcmVkaGF0LmNvbT4KPiB3cm90ZToKPiA+IAo+ID4gQ3VycmVudGx5LCB1c2VyIGFycmF5
IGR1cGxpY2F0aW9ucyBhcmUgc29tZXRpbWVzIGRvbmUgd2l0aG91dCBhbgo+ID4gb3ZlcmZsb3cg
Y2hlY2suIFNvbWV0aW1lcyB0aGUgY2hlY2tzIGFyZSBkb25lIG1hbnVhbGx5OyBzb21ldGltZXMK
PiA+IHRoZQo+ID4gYXJyYXkgc2l6ZSBpcyBjYWxjdWxhdGVkIHdpdGggYXJyYXlfc2l6ZSgpIGFu
ZCBzb21ldGltZXMgYnkKPiA+IGNhbGN1bGF0aW5nCj4gPiBuICogc2l6ZSBkaXJlY3RseSBpbiBj
b2RlLgo+ID4gCj4gPiBJbnRyb2R1Y2Ugd3JhcHBlcnMgZm9yIGFycmF5cyBmb3IgbWVtZHVwX3Vz
ZXIoKSBhbmQgdm1lbWR1cF91c2VyKCkKPiA+IHRvCj4gPiBwcm92aWRlIGEgc3RhbmRhcmRpemVk
IGFuZCBzYWZlIHdheSBmb3IgZHVwbGljYXRpbmcgdXNlciBhcnJheXMuCj4gPiAKPiA+IFRoaXMg
aXMgYm90aCBmb3IgbmV3IGNvZGUgYXMgd2VsbCBhcyByZXBsYWNpbmcgdXNhZ2Ugb2YKPiA+ICh2
KW1lbWR1cF91c2VyKCkKPiA+IGluIGV4aXN0aW5nIGNvZGUgdGhhdCB1c2VzLCBlLmcuLCBuICog
c2l6ZSB0byBjYWxjdWxhdGUgYXJyYXkKPiA+IHNpemVzLgo+IAo+IC4uLgo+IAo+ID4gLS0tIGEv
aW5jbHVkZS9saW51eC9zdHJpbmcuaAo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zdHJpbmcuaAo+
IAo+IEknbSB3b25kZXJpbmcgaWYgdGhpcyBoYXMgbm8gc2lkZS1lZmZlY3RzIGFzIHN0cmluZy5o
L3N0cmluZy5jIElJUkMKPiBpcwo+IHVzZWQgYWxzbyBmb3IgZWFybHkgc3RhZ2VzIHdoZXJlIHNv
bWUgb2YgdGhlIEFQSXMgYXJlIG5vdCBhdmFpbGFibGUuCj4gCj4gPiBAQCAtNiw2ICs2LDggQEAK
PiA+IMKgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+wqDCoMKgwqDCoMKgIC8qIGZvciBzaXplX3Qg
Ki8KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L3N0ZGRlZi5oPsKgwqDCoMKgwqAgLyogZm9yIE5VTEwg
Ki8KPiA+IMKgI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+wqDCoMKgwqDCoMKgIC8qIGZvciBFMkJJ
RyAqLwo+ID4gKyNpbmNsdWRlIDxsaW51eC9vdmVyZmxvdy5oPsKgwqDCoCAvKiBmb3IgY2hlY2tf
bXVsX292ZXJmbG93KCkgKi8KPiA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+wqDCoMKgwqDCoMKg
wqDCoCAvKiBmb3IgRVJSX1BUUigpICovCj4gCj4gQ2FuIHdlIHByZXNlcnZlIG9yZGVyICh0byBz
b21lIGV4dGVudCk/CgpTdXJlLiBJIGp1c3QgcHV0IGl0IHRoZXJlIHNvIHRoZSBjb21tZW50cyBi
dWlsZCBhIGNvbmdydWVudCBibG9jay4KV2hpY2ggb3JkZXIgd291bGQgeW91IHByZWZlcj8KCj4g
Cj4gPiDCoCNpbmNsdWRlIDxsaW51eC9zdGRhcmcuaD4KPiA+IMKgI2luY2x1ZGUgPHVhcGkvbGlu
dXgvc3RyaW5nLmg+Cj4gCj4gLi4uCj4gCj4gPiArLyoqCj4gPiArICogbWVtZHVwX2FycmF5X3Vz
ZXIgLSBkdXBsaWNhdGUgYXJyYXkgZnJvbSB1c2VyIHNwYWNlCj4gCj4gPiArICoKPiAKPiBEbyB3
ZSBuZWVkIHRoaXMgYmxhbmsgbGluZT8KCkkgbW9yZSBvciBsZXNzIGRpcmVjdGx5IGNvcGllZCB0
aGUgZG9jc3RyaW5nIGZvcm1hdCBmcm9tIHRoZSBvcmlnaW5hbApmdW5jdGlvbnMgKHYpbWVtZHVw
X3VzZXIoKSBpbiBtbS91dGlsLmMKSSBndWVzcyB0aGlzIGlzIGNvbW1vbiBzdHlsZT8KCj4gCj4g
PiArICogQHNyYzogc291cmNlIGFkZHJlc3MgaW4gdXNlciBzcGFjZQo+ID4gKyAqIEBuOiBudW1i
ZXIgb2YgYXJyYXkgbWVtYmVycyB0byBjb3B5Cj4gPiArICogQHNpemU6IHNpemUgb2Ygb25lIGFy
cmF5IG1lbWJlcgo+ID4gKyAqCj4gPiArICogUmV0dXJuOiBhbiBFUlJfUFRSKCkgb24gZmFpbHVy
ZS7CoCBSZXN1bHQgaXMgcGh5c2ljYWxseQo+ID4gKyAqIGNvbnRpZ3VvdXMsIHRvIGJlIGZyZWVk
IGJ5IGtmcmVlKCkuCj4gPiArICovCj4gCj4gLi4uCj4gCj4gPiArLyoqCj4gPiArICogdm1lbWR1
cF9hcnJheV91c2VyIC0gZHVwbGljYXRlIGFycmF5IGZyb20gdXNlciBzcGFjZQo+IAo+ID4gKyAq
Cj4gCj4gUmVkdW5kYW50PwoKTm8sIHRoZXJlIGFyZSB0d28gZnVuY3Rpb25zOgogKiBtZW1kdXBf
YXJyYXlfdXNlcigpCiAqIHZtZW1kdXBfYXJyYXlfdXNlcigpCgpPbiB0aGUgZGVlcGVyIGxheWVy
cyB0aGV5IHV0aWxpemUga21hbGxvYygpIG9yIGt2bWFsbG9jKCksCnJlc3BlY3RpdmVseS4KCgpH
cmVldGluZ3MsClAuCgo+IAo+ID4gKyAqIEBzcmM6IHNvdXJjZSBhZGRyZXNzIGluIHVzZXIgc3Bh
Y2UKPiA+ICsgKiBAbjogbnVtYmVyIG9mIGFycmF5IG1lbWJlcnMgdG8gY29weQo+ID4gKyAqIEBz
aXplOiBzaXplIG9mIG9uZSBhcnJheSBtZW1iZXIKPiA+ICsgKgo+ID4gKyAqIFJldHVybjogYW4g
RVJSX1BUUigpIG9uIGZhaWx1cmUuwqAgUmVzdWx0IG1heSBiZSBub3QKPiA+ICsgKiBwaHlzaWNh
bGx5IGNvbnRpZ3VvdXMuwqAgVXNlIGt2ZnJlZSgpIHRvIGZyZWUuCj4gPiArICovCj4gCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

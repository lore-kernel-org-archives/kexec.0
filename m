Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C578EC3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 14:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m9inlmW4UguD0DSp8kfob0cIdFu89+JjAWaKLBugr2E=; b=ZghWtlHQZtNZ/a
	0xT1chHj08BALkMUN3473i05R+ZS/bydT/287NEPNbYoiqUFFVIgtjf+XX4h50TuiRdkWlLN56pPc
	BrtCsRH6uAkGbLX+6pZk1UPT0uBNhCyXBobXUbcf+JJ18F+jRTtj3Ecb4Gin9Oe5OJ5U7VTUcCnYG
	rBFh4Yg3rwmvqEnyE3vq0jfL1zMjepCWaT6MGkv0HoaORnB0jK5Tz0CFQnAtOief6KoIA6iMAw28j
	Rgca9Mx17556AdBwAd/NnpmxMjkRXh5rdZ8g22+8jveSqh7xEtiUa0e37qq7iDb6D3GLqb43PingP
	ofzhSl8vM6w3GSwQUjjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH2uE-0081r5-28;
	Sat, 23 Dec 2023 14:23:10 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH2uB-0081pv-1n
	for kexec@lists.infradead.org;
	Sat, 23 Dec 2023 14:23:09 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5542ac8b982so2522039a12.3
        for <kexec@lists.infradead.org>; Sat, 23 Dec 2023 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703341386; x=1703946186; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUtubScy5GgYH48lqXbABEThZ+ymAXfmCY1RXmy3kE8=;
        b=E6zSMp7TlR5cECL0fw+lV9/YSdZQFlYjGUJl0307PjEZIAqYJD/5029YzyqVZPbyz1
         UwChmAdSLdl78k9JpP0lyZlfIPhsYLv5JcstxmCutSERad9kgs4NFXxVi0EtE/BPjrCB
         u1TWl+n+c5wfCkJurVfi004EzGeCZ0luRXnh3TQsXtDsj5E8a/jtgnIqylma5ehvw7xS
         MRqSwg/WLTIbRdnQzvWcWdRzj6Krz4OG6dO93lpLr/Ut7kS/Qq3Q4GkP+awKUO2Bt3/L
         /Gu0zcc0oGSwfvhYDxuJtgXcoBexbXovlAVnLfpu270ZdWtt+ByYA7Xdl04fxzR1g0gP
         cBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703341386; x=1703946186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUtubScy5GgYH48lqXbABEThZ+ymAXfmCY1RXmy3kE8=;
        b=m679oydhqd/LA/2V8CoQVv/UCQEjAS1Io6oDiS7uEIgEN+Cy7PEkrLfagh1tiXPiKy
         rHnPQXYtLmxrSo3mPix4bPfFSy2aKdxuaVNdctClub+EkfQtaj0OD2Q/Dz3RpgsAUvcC
         e06m0W3dxGM1LebEs2K+ep54vtzMcQIKfBB/Z7+/1zXiJWFFmzUOJVDAFrtklNBKd2N/
         fUVaRJDJSV+jPw5+8Zys3wOm/Rbrfh6fI38dvVLKP7zvVBiS8CbjN9M6uSksqVEp6HA7
         WQOn+ypZU/9gAm1rTnOjVZDOO46e6rjblNGGHMFVgPYTI9yJqfDKxYOtKAFBW1AtIsZg
         fmnw==
X-Gm-Message-State: AOJu0YwjDYvcsMHWkfz72LrfNER3uQR48DfLD6+5tI6ZyRT9VFUVo3BV
	eyRhOyuk0HI/JY3qZ9RTHSfKnS/zsWfimQ==
X-Google-Smtp-Source: AGHT+IEzM0CTjziLqsSniZ3DXJLzZDp5cBCF9G7iaOVNTOSRkVUYP5cOZY+sKs3ps5HrES1fj+smkg==
X-Received: by 2002:a50:8e13:0:b0:54c:4837:9a99 with SMTP id 19-20020a508e13000000b0054c48379a99mr1998071edw.64.1703341385765;
        Sat, 23 Dec 2023 06:23:05 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7d28e000000b0055306f10c28sm3949225edq.28.2023.12.23.06.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:23:05 -0800 (PST)
Message-ID: <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
Date: Sat, 23 Dec 2023 15:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump
 module
Content-Language: en-US
To: ruipeng qi <ruipengqi7@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org,
 mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org,
 arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org,
 maninder1.s@samsung.com, michael.christie@oracle.com,
 samitolvanen@google.com, linux-arm-kernel@lists.infradead.org,
 qiruipeng@lixiang.com
References: <20231221130930.32634-1-ruipengqi7@gmail.com>
 <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_062307_652323_53448E92 
X-CRM114-Status: GOOD (  22.43  )
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

T24gMjMvMTIvMjAyMyAxNToxMiwgcnVpcGVuZyBxaSB3cm90ZToKPiBPbiBGcmksIERlYyAyMiwg
MjAyMyBhdCAxMjoyNeKAr0FNIEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2kKPiBAbGluYXJvLm9yZz4gd3JvdGU6Cj4+PiBPc2R1bXAgaXMgYSBuZXcgY3Jhc2ggZHVtcGlu
ZyBzb2x1dGlvbiBhaW1pbmcgYXQgc3BlY2lmaWMgZW1iZWRkZWQKPj4+IGRldmljZXMgd2l0aGlu
IGF1dG9tb3RpdmUgb3IgSW5kdXN0cmlhbC4KPj4+ICAtIGxpbWl0ZWQgbWVtb3J5Lgo+Pj4gIC0g
cmVib290IGFzIHNvb24gYXMgcG9zc2libGUgd2hlbiBzeXN0ZW0gZmF1bHQuCj4+Cj4+IE5BSywg
c29ycnksIHdvcmsgd2l0aCBRdWFsY29tbSBtaW5pZHVtcCBzZXJpZXMgdG8gaW5jb3Jwb3JhdGUg
YWxsIHlvdXIKPj4gbmVlZHMgdGhlcmUuCj4gCj4gU29ycnksIEkgZGlkbid0IGV4cGxhaW4gaXQg
cHJvcGVybHkuIFdpbGwgYWRkIG1vcmUgZGVzY3JpcHRpb25zIGluIHRoZQo+IG5leHQgdmVyc2lv
bi4gT3NkdW1wIGlzIGEgdG90YWxseSBkaWZmZXJlbnQgbWluZHVtcCwgd2hpY2ggYWltcyBhdAo+
IGhlbHBpbmcgdG8gc29sdmUga2VybmVsIGlzc3VlcyBhcyBlYXN5IGFzIGtkdW1wL2tleGVjL2Ny
YXNoLCBidXQKPiB3aXRoIGxpdHRsZSBjb3N0cy4KPiAKPiBGb3Igc29tZXRoaW5nIGxpa2UgUHN0
b3JlLCB5b3UgY2FuIGdldCB3aGVyZSB0aGUgaXNzdWUgb2NjdXJzLiBZb3UgY2FuCj4gZmlndXJl
IG91dCB0aGUgcHJvYmxlbSBpZiBpdCBpcyBlYXN5LCBidXQgc29tZXRpbWVzIHlvdSBjYW4ndC4g
Rm9yIGV4YW1wbGU6Cj4gCj4gPDQ+WyAgICA1LjMxMTQzMV0gIHRhc2tfYmxvY2tzX29uX3J0X211
dGV4KzB4MjM0LzB4MzgwCj4gPDQ+WyAgICA1LjMxNjE2Nl0gIHJ0X3NwaW5fbG9ja19zbG93bG9j
a19sb2NrZWQrMHhjYy8weDJiMAo+IDw0PlsgICAgNS4zMjEyNTddICBydF9zcGluX2xvY2tfc2xv
d2xvY2srMHg1Yy8weDkwCj4gPDQ+WyAgICA1LjMyNTYzM10gIHJ0X3NwaW5fbG9jaysweDYwLzB4
NzQKPiA8ND5bICAgIDUuMzI5MjA3XSAgcmVmaWxsX3N0b2NrKzB4NTgvMHgyMzAKPiAKPiBZb3Ug
Y2FuIGZpbmQgd2hlcmUgdGhlIGlzc3VlIG9jY3Vycy4KPiBzdGF0aWMgaW5saW5lIHN0cnVjdCBy
dF9tdXRleF93YWl0ZXIgKnJ0X211dGV4X3RvcF93YWl0ZXIoc3RydWN0IHJ0X211dGV4ICpsb2Nr
KQo+ICB7Cj4gICBzdHJ1Y3QgcmJfbm9kZSAqbGVmdG1vc3QgPSByYl9maXJzdF9jYWNoZWQoJmxv
Y2stPndhaXRlcnMpOwo+ICAgc3RydWN0IHJ0X211dGV4X3dhaXRlciAqdyA9IE5VTEw7Cj4gICBp
ZiAobGVmdG1vc3QpIHsKPiAgICAgdyA9IHJiX2VudHJ5KGxlZnRtb3N0LCBzdHJ1Y3QgcnRfbXV0
ZXhfd2FpdGVyLCB0cmVlX2VudHJ5KTsKPiAgICAgQlVHX09OKHctPmxvY2sgIT0gbG9jayk7Cj4g
Cj4gQnV0IHlvdSBkb24ndCBrbm93IHdoeSB3LT5sb2NrIGFuZCBsb2NrIGFyZSBkaWZmZXJlbnQs
IGFuZCB3aG8gaXMgd3JvbmcuCj4gCj4gUWNvbSBtaW5pZHVtcCBjYW4gZHVtcCBzb21lIGxvZ3Mg
bGlrZSBkbXNnLCBzb21lIHN0YXR1cyBsaWtlIElSUSBvcgo+IFJ1biBxdWV1ZS4gVGhpcyBjYW4g
aGVscCB0byBsZWFybiBzb21lIGluZm9ybWF0aW9uIHdoZW4gdGhlIGlzc3VlIG9jY3VycywKPiB3
aGljaCB3aWxsIGhlbHAgdG8gZmluZCBvdXQgdGhlIHJvb3QgY2F1c2UuIEJ1dCB3aGF0IGl0IGR1
bXBzIGFyZSBsaW1pdGVkLCBpdAo+IGRvZXNuJ3QgZHVtcCB3IGFuZCBsb2NrIGlmIHRoZXkgYXJl
IG5vdCBsb2NhbCBkYXRhLgoKU28gYWRkIG1pc3NpbmcgZmVhdHVyZXMgdG8gaXQuIEkgZG9uJ3Qg
dGhpbmsgeW91IGdvdCBteSBjb21tZW50IGFuZCBrZWVwCmFyZ3Vpbmcgb24gdGhlIHNhbWUgdGhp
bmcgcmVwZWF0ZWQgZm9yIHVwc3RyZWFtIHN1Ym1pc3Npb25zIG1hbnkgdGltZXMuCldlIGRvIG5v
dCB3YW50IG11bHRpcGxlIHZlbmRvciBzb2x1dGlvbnMuIEV2ZXJ5IHZlbmRvciB3YW50cyBoaXMg
d29yawphbmQgZG9lcyBub3QgY2FyZSBhYm91dCBpbnRlZ3JhdGluZyBvciByZXVzaW5nIG90aGVy
IHBpZWNlcy4KCj4gCj4gRm9yIG9zZHVtcCwgaXQgZHVtcHMgb2JqZWN0cyBzdG9yZWQgaW4gc2xh
YiwgZGF0YXMgaW4gYnNzLCBkYXRhIHNlZ21lbnRzLAo+IHNvbWUgZGF0YSBhbGxvY2VkIHdpdGgg
bWVtYmxvY2ssIGRhdGEgc3RvcmVkIGluIGxvY2FsIHN0YWNrLCBhbmQgc28gb24uCj4gSW4gYSB3
b3JkLCBpdCBkdW1wcyBhbG1vc3QgYWxsIG9mIHRoZSBrZXkgZGF0YSBpbiB0aGUga2VybmVsLiBC
ZXNpZGVzLCB5b3UKPiBjYW4gdXNlIHRoZSBjcmFzaCB0b29sIHRvIGFuYWx5emUgdGhlIGR1bXAg
ZmlsZS4KCkkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSB3aHkgbWluaWR1bXAgY2Fubm90IGRvIGl0LgoK
PiAKPiBJbiBhIHdvcmQsIEkgdGhpbmsgdGhpcyB0b2FsIGRpZmZlcmVudCBtaW5pZHVtcCBzaG91
bGQgaGF2ZSBpdHMgb3duIHBsYWNlIGluCj4gdGhlIGtlcm5lbCB3b3JsZC4gTG9va2luZyBmb3J3
YXJkIHRvIHlvdXIgc3VnZ2VzdGlvbnMhCgpObywgd29yayB3aXRoIG1pbmlkdW1wLgoKRm9yIGFu
eSBmdXJ0aGVyIHN1Ym1pc3Npb25zIHdoaWNoIGRvIG5vdCBtZXJnZSB0aGlzIHdvcmsgaW50byBt
aW5pZHVtcCwKcGxlYXNlIGNhcnJ5OgoKTmFja2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxr
cnprQGtlcm5lbC5vcmc+CgpCZXN0IHJlZ2FyZHMsCktyenlzenRvZgoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK

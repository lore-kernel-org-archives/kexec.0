Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A51AEB64DD
	for <kexec@archiver.kernel.org>; Sat,  1 Jul 2023 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ADjYfRIv6399oXB33GdZj/6ScHlPt1PfjKiMfOwGMM0=; b=R9bltZ8F1saOS6
	8Vt+zoHB4dkjVzsDEJ2r2FVwctC5WfhGBgeOyPJEZPTpR7kDlC7KJgwI/xPf6KiglQ715zK8gcR2w
	86y6B+ntdCwpUttVoqtf2vy6MfvjCngKUcjeBBSF/sQGQobL2riy+6QDcwRyAUWPUtmttPZ8iuYpu
	Z2gp3RXV6AnG053GVp9qSzFlWYWQvb896UKvaXW1qR/Xn9rJh7TmocmRTEDoADI1t21CW5IpLPUYK
	Hpz4A3ACAVxdfpGHEbNhciuxGddnMJ8jxWTHqvqAUohTSZ0CMVZmvUQZ2eqtT+79iR/nk5UKDUYL0
	hdtzX82Dj4U46zQtiZow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFaub-0066NM-31;
	Sat, 01 Jul 2023 13:45:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFauZ-0066Mv-2L;
	Sat, 01 Jul 2023 13:45:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6D42D60B63;
	Sat,  1 Jul 2023 13:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CD7C433C7;
	Sat,  1 Jul 2023 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688219113;
	bh=9d3MqgbfoEXm4e71z+ezPjR3vvvbKSQpSCaz34l0gmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HY/MT8TTTmyX5U4gLQ76p8o425YEZd6RYWIcUTUeUeWU4EJf+LK5eK+8X0SQGMlD6
	 wNE9P5rRXkI8rvhF+fZicOHaz8wdK7RgbiBsqSaGtAq9w6DG7XD1T1qBamlWwEJv7M
	 llBkBQWHxtDe7D/wigrc+UbxAliF1a+asydNOMzcrGY1XfC3UTHgA/ZHdpGHEGbkkp
	 Fn/yGSmG7WJpuacEL2IP7XbS8i7Ycy1ZOShjdwkrKhHCOZzkq9LcxY+jJ0gtLWBum/
	 Imnu5RIjLNuAOEMkkTe2TmMfpSYPCTO6/4p7eyVzqAJ8H3hNukGGWzyfITkXNMn+MS
	 Amx8VOXX2Wn/g==
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso1486395e9.0;
        Sat, 01 Jul 2023 06:45:13 -0700 (PDT)
X-Gm-Message-State: AC+VfDzlix39AIbAQkInlMwqhEhqsjm4oQaWaLizrW5FrpMOfzdJWVwc
	gSuxHV+DSJmUffLqnoJ5BWVsDqq+NwkvgWlgj+Q=
X-Google-Smtp-Source: ACHHUZ5jZ82bm0qs/ibxPu0bevyKpfVXZ3uXr+bClu/6I2hRHm6zTWY5Kvnn2GemGtWi06F74RvrdWqbX20KWztL/ak=
X-Received: by 2002:a05:600c:20a:b0:3fb:9b7e:c5b1 with SMTP id
 10-20020a05600c020a00b003fb9b7ec5b1mr4265426wmi.19.1688219112057; Sat, 01 Jul
 2023 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230701171138.1491206-1-chenjiahao16@huawei.com>
In-Reply-To: <20230701171138.1491206-1-chenjiahao16@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 1 Jul 2023 21:45:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
Message-ID: <CAJF2gTSPaBvB_CsmN5m91AVXwXB37j2qvyCP3VqALxHwNcGeTg@mail.gmail.com>
Subject: Re: [PATCH -next v6 0/2] support allocating crashkernel above 4G
 explicitly on riscv
To: Chen Jiahao <chenjiahao16@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, conor.dooley@microchip.com, 
	heiko@sntech.de, bjorn@rivosinc.com, alex@ghiti.fr, akpm@linux-foundation.org, 
	atishp@rivosinc.com, bhe@redhat.com, thunder.leizhen@huawei.com, 
	horms@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230701_064515_876764_CF22AE32 
X-CRM114-Status: GOOD (  22.62  )
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

T24gU2F0LCBKdWwgMSwgMjAyMyBhdCA1OjEy4oCvUE0gQ2hlbiBKaWFoYW8gPGNoZW5qaWFoYW8x
NkBodWF3ZWkuY29tPiB3cm90ZToKPgo+IE9uIHJpc2N2LCB0aGUgY3VycmVudCBjcmFzaCBrZXJu
ZWwgYWxsb2NhdGlvbiBsb2dpYyBpcyB0cnlpbmcgdG8KPiBhbGxvY2F0ZSB3aXRoaW4gMzJiaXQg
YWRkcmVzc2libGUgbWVtb3J5IHJlZ2lvbiBieSBkZWZhdWx0LCBpZgo+IGZhaWxlZCwgdHJ5IHRv
IGFsbG9jYXRlIHdpdGhvdXQgNEcgcmVzdHJpY3Rpb24uCj4KPiBJbiBuZWVkIG9mIHNhdmluZyBE
TUEgem9uZSBtZW1vcnkgd2hpbGUgYWxsb2NhdGluZyBhIHJlbGF0aXZlbHkgbGFyZ2UKPiBjcmFz
aCBrZXJuZWwgcmVnaW9uLCBhbGxvY2F0aW5nIHRoZSByZXNlcnZlZCBtZW1vcnkgdG9wIGRvd24g
aW4KPiBoaWdoIG1lbW9yeSwgd2l0aG91dCBvdmVybGFwcGluZyB0aGUgRE1BIHpvbmUsIGlzIGEg
bWF0dXJlIHNvbHV0aW9uLgo+IEhlbmNlIHRoaXMgcGF0Y2hzZXQgaW50cm9kdWNlcyB0aGUgcGFy
YW1ldGVyIG9wdGlvbiBjcmFzaGtlcm5lbD1YLFtoaWdoLGxvd10uCj4KPiBPbmUgY2FuIHJlc2Vy
dmUgdGhlIGNyYXNoIGtlcm5lbCBmcm9tIGhpZ2ggbWVtb3J5IGFib3ZlIERNQSB6b25lIHJhbmdl
Cj4gYnkgZXhwbGljaXRseSBwYXNzaW5nICJjcmFzaGtlcm5lbD1YLGhpZ2giOyBvciByZXNlcnZl
IGEgbWVtb3J5IHJhbmdlCj4gYmVsb3cgNEcgd2l0aCAiY3Jhc2hrZXJuZWw9WCxsb3ciLiBCZXNp
ZGVzLCB0aGVyZSBhcmUgZmV3IHJ1bGVzIG5lZWQKPiB0byB0YWtlIG5vdGljZToKPiAxLiAiY3Jh
c2hrZXJuZWw9WCxbaGlnaCxsb3ddIiB3aWxsIGJlIGlnbm9yZWQgaWYgImNyYXNoa2VybmVsPXNp
emUiCj4gICAgaXMgc3BlY2lmaWVkLgo+IDIuICJjcmFzaGtlcm5lbD1YLGxvdyIgaXMgdmFsaWQg
b25seSB3aGVuICJjcmFzaGtlcm5lbD1YLGhpZ2giIGlzIHBhc3NlZAo+ICAgIGFuZCB0aGVyZSBp
cyBlbm91Z2ggbWVtb3J5IHRvIGJlIGFsbG9jYXRlZCB1bmRlciA0Ry4KPiAzLiBXaGVuIGFsbG9j
YXRpbmcgY3Jhc2hrZXJuZWwgYWJvdmUgNEcgYW5kIG5vICJjcmFzaGtlcm5lbD1YLGxvdyIgaXMK
PiAgICBzcGVjaWZpZWQsIGEgMTI4TSBsb3cgbWVtb3J5IHdpbGwgYmUgYWxsb2NhdGVkIGF1dG9t
YXRpY2FsbHkgZm9yCj4gICAgc3dpb3RsYiBib3VuY2UgYnVmZmVyLgo+IFNlZSBEb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBmb3IgbW9yZSBpbmZvcm1hdGlv
bi4KPgo+IFRvIHZlcmlmeSBsb2FkaW5nIHRoZSBjcmFzaGtlcm5lbCwgYWRhcHRlZCBrZXhlYy10
b29scyBpcyBhdHRhY2hlZCBiZWxvdzoKPiBodHRwczovL2dpdGh1Yi5jb20vY2hlbmpoMDA1L2tl
eGVjLXRvb2xzL3RyZWUvYnVpbGQtdGVzdC1yaXNjdi12Mgo+Cj4gRm9sbG93aW5nIHRlc3QgY2Fz
ZXMgaGF2ZSBiZWVuIHBlcmZvcm1lZCBhcyBleHBlY3RlZDoKPiAxKSBjcmFzaGtlcm5lbD0yNTZN
ICAgICAgICAgICAgICAgICAgICAgICAgICAvL2xvdz0yNTZNCj4gMikgY3Jhc2hrZXJuZWw9MUcg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLy9sb3c9MUcKSGF2ZSB5b3UgdHJpZWQgMUdCIG1l
bW9yeT8gd2UgZm91bmQgYSBwdWQgbWFwcGluZyBwcm9ibGVtIG9uIFN2Mzkgb2Yga2V4ZWMsIFNl
ZToKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMzA2MjkwODIwMzIuMzQ4
MTIzNy0xLWd1b3JlbkBrZXJuZWwub3JnLwoKPiAzKSBjcmFzaGtlcm5lbD00RyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAvL2hpZ2g9NEcsIGxvdz0xMjhNKGRlZmF1bHQpCj4gNCkgY3Jhc2hr
ZXJuZWw9NEcgY3Jhc2hrZXJuZWw9MjU2TSxoaWdoICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShk
ZWZhdWx0KSwgaGlnaCBpcyBpZ25vcmVkCj4gNSkgY3Jhc2hrZXJuZWw9NEcgY3Jhc2hrZXJuZWw9
MjU2TSxsb3cgICAgICAgLy9oaWdoPTRHLCBsb3c9MTI4TShkZWZhdWx0KSwgbG93IGlzIGlnbm9y
ZWQKPiA2KSBjcmFzaGtlcm5lbD00RyxoaWdoICAgICAgICAgICAgICAgICAgICAgICAvL2hpZ2g9
NEcsIGxvdz0xMjhNKGRlZmF1bHQpCj4gNykgY3Jhc2hrZXJuZWw9MjU2TSxsb3cgICAgICAgICAg
ICAgICAgICAgICAgLy9sb3c9ME0sIGludmFsaWQKPiA4KSBjcmFzaGtlcm5lbD00RyxoaWdoIGNy
YXNoa2VybmVsPTI1Nk0sbG93ICAvL2hpZ2g9NEcsIGxvdz0yNTZNCj4gOSkgY3Jhc2hrZXJuZWw9
NEcsaGlnaCBjcmFzaGtlcm5lbD00Ryxsb3cgICAgLy9oaWdoPTBNLCBsb3c9ME0sIGludmFsaWQK
PiAxMCkgY3Jhc2hrZXJuZWw9NTEyTUAweGQwMDAwMDAwICAgICAgICAgICAgICAvL2xvdz01MTJN
Cj4KPiBDaGFuZ2VzIHNpbmNlIFt2Nl06Cj4gMS4gSW50cm9kdWNlIHRoZSAiaGlnaCIgZmxhZyB0
byBtYXJrIHdoZXRoZXIgImNyYXNoa2VybmVsPVgsaGlnaCIKPiAgICBpcyBwYXNzZWQuIEZpeCB0
aGUgcmV0cnlpbmcgbG9naWMgYmV0d2VlbiAiY3Jhc2hrZXJuZWw9WCxoaWdoIgo+ICAgIGNhc2Ug
YW5kIG90aGVycyB3aGVuIHRoZSBmaXJzdCBhbGxvY2F0aW9uIGF0dGVtcHQgZmFpbHMuCj4KPiBD
aGFuZ2VzIHNpbmNlIFt2NV06Cj4gMS4gVXBkYXRlIHRoZSBjcmFzaGtlcm5lbCBhbGxvY2F0aW9u
IGxvZ2ljIHdoZW4gY3Jhc2hrZXJuZWw9WCxoaWdoCj4gICAgaXMgc3BlY2lmaWVkLiBJbiB0aGlz
IGNhc2UsIHJlZ2lvbiBhYm92ZSA0RyB3aWxsIGRpcmVjdGx5IGdldAo+ICAgIHJlc2VydmVkIGFz
IGNyYXNoa2VybmVsLCByYXRoZXIgdGhhbiB0cnlpbmcgbG93ZXIgMzJiaXQgYWxsb2NhdGlvbgo+
ICAgIGZpcnN0Lgo+Cj4gQ2hhbmdlcyBzaW5jZSBbdjRdOgo+IDEuIFVwZGF0ZSBzb21lIGltcHJl
Y2lzZSBjb2RlIGNvbW1lbnRzIGZvciBjbWRsaW5lIHBhcnNpbmcuCj4KPiBDaGFuZ2VzIHNpbmNl
IFt2M106Cj4gMS4gVXBkYXRlIHRvIHByaW50IHdhcm5pbmcgYW5kIHJldHVybiBleHBsaWNpdGx5
IG9uIGZhaWx1cmUgd2hlbgo+ICAgIGNyYXNoa2VybmVsPXNpemVAb2Zmc2V0IGlzIHNwZWNpZmll
ZC4gTm90IGNoYW5naW5nIHRoZSByZXN1bHQKPiAgICBpbiB0aGlzIGNhc2UgYnV0IG1ha2luZyB0
aGUgbG9naWMgbW9yZSBzdHJhaWdodGZvcndhcmQuCj4gMi4gU29tZSBtaW5vciBjbGVhbnVwLgo+
Cj4gQ2hhbmdlcyBzaW5jZSBbdjJdOgo+IDEuIFVwZGF0ZSB0aGUgYWxsb2NhdGlvbiBsb2dpYyB0
byBlbnN1cmUgdGhlIGhpZ2ggY3Jhc2hrZXJuZWwKPiAgICByZWdpb24gaXMgcmVzZXJ2ZWQgc3Ry
aWN0bHkgYWJvdmUgZG1hMzJfcGh5c19saW1pdC4KPiAyLiBDbGVhbiB1cCBzb21lIG1pbm9yIGZv
cm1hdCBwcm9ibGVtcy4KPgo+IENoZW4gSmlhaGFvICgyKToKPiAgIHJpc2N2OiBrZHVtcDogSW1w
bGVtZW50IGNyYXNoa2VybmVsPVgsW2hpZ2gsbG93XQo+ICAgZG9jczoga2R1bXA6IFVwZGF0ZSB0
aGUgY3Jhc2hrZXJuZWwgZGVzY3JpcHRpb24gZm9yIHJpc2N2Cj4KPiAgLi4uL2FkbWluLWd1aWRl
L2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgMTUgKystLQo+ICBhcmNoL3Jpc2N2L2tl
cm5lbC9zZXR1cC5jICAgICAgICAgICAgICAgICAgICAgfCAgNSArKwo+ICBhcmNoL3Jpc2N2L21t
L2luaXQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCA4NCArKysrKysrKysrKysrKysrKy0t
Cj4gIDMgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pCj4K
PiAtLQo+IDIuMzQuMQo+CgoKLS0gCkJlc3QgUmVnYXJkcwogR3VvIFJlbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

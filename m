Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D6C3DA6E
	for <kexec@archiver.kernel.org>; Sat, 23 Dec 2023 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NWIlWENpVwLf+3g9hvEdn0I4Auk1h6EJyn3Pbv5525g=; b=kxntUGSZQ9P8UH
	12po4Lv7Huuzds89kkMHBrkHPbL1X/mI7gnUMQG1nLCOMcdOH1VaSn+1xhFQ8Te91YK0oSx/qapHY
	MoBBYHz+wX/aGZt3dcNZzsIxTbuduykQbG7+qsBxjUJiaIw9/kVopElITGAVGfEHMfcYwxXOuAUPM
	pHKoBHFw8Tdm62Ou3drn9dmAwGExdGcTDANV+gZHAasBhyecRWrl471QeQ6bJG6oxiIhtiWFaAw/F
	Tmj/fWU/26VItJG3x2EWMMvhcNZHsXTfUr2WTdX+Q+BVPe+idfwbYgYcZzbLeoKVQLm5vcs3oQHxQ
	mHLm9FcD/oZczeLlBk2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rH3h4-00854r-1S;
	Sat, 23 Dec 2023 15:13:38 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rH3h2-00854O-1N;
	Sat, 23 Dec 2023 15:13:37 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40d4dcc838eso8310495e9.0;
        Sat, 23 Dec 2023 07:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703344414; x=1703949214; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7RZjFb+nij+zY4Pr94c1OS3SH59BuL/+qyNrJdQ5ag=;
        b=YID+aByjTPjCJTtYQtdLpGGXAjYyVUxSesvKJInWlValDVAJcfy/JEzI4vT4p2DnnB
         hwCZ7SIOCSq+UivaXwp2szMd5QuLQGveJfsnJ0ryfFIr+MDC+vGErUAEXezn3e2OnV9K
         Q1HS5WJRbZ6Q97X9zWfsFFhskEBOi8pu8lbcWJRWHTQ0VuJr4Qt7HoXJJqSv42tN8TB/
         rD4LBep2p2dAZKs9l2s7bNr28pEZaa2cVGB6SfX/57OAZwW+Z0TZLR6Vawb6bD76QC7B
         yF8BS3dVoHB99K+Su9kRDhLgpRnYyQepM0t3IG9hA398jBW2bfAZtogSh7J/yDUQAGMu
         6CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703344414; x=1703949214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7RZjFb+nij+zY4Pr94c1OS3SH59BuL/+qyNrJdQ5ag=;
        b=qjc/lC/d2eyZSAfHBmvDXJyozlFWyLdADGGL+p2gIAFdsCOtgl0bqFyVdGOulmkKwK
         hvbnqrh4Ftv9eI3fJ+jPQ5BLVke6Z+Eer2ZfILiog6cOHrJMz+A0m+/Cq1+HyGObXiH9
         JUut7wUrYi/xgtiJSVi990Gh4ZpLqJeFGODNb1snBpeEvzMpj6eNqSUta309iuupjMFB
         SXegKBcWYWw6+nzEc19kPB+qqwZ6HOYgNl7eFgk/MoQ626pM0/Q/S8VisRn2asqqoVbN
         tEwxFjD1Vruur8rPA+EXTqF2dRjeIdOOb0kWqqSQcAU6XhR939YeKH6/81eQYuUuKiPz
         ZCGw==
X-Gm-Message-State: AOJu0YwxHi85r6kuy5z5K47HYCqjNlMOMh1bs6kqciva87nMD3XT89ga
	Urb9PMir3ZqRGeppr30tlsozfnr3E6fJnnb4IeY=
X-Google-Smtp-Source: AGHT+IEFK/Y1UR42XOxBItq4BK6z+twGv8PfA7HsXO8dlqD2hfT5pSad5X0+YLw+5gEHRgHpU0GJOlkE8+oxSUcZdMk=
X-Received: by 2002:a05:600c:a47:b0:40d:1257:36fd with SMTP id
 c7-20020a05600c0a4700b0040d125736fdmr1711349wmq.93.1703344413892; Sat, 23 Dec
 2023 07:13:33 -0800 (PST)
MIME-Version: 1.0
References: <20231221130930.32634-1-ruipengqi7@gmail.com> <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com> <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
In-Reply-To: <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
From: ruipeng qi <ruipengqi7@gmail.com>
Date: Sat, 23 Dec 2023 23:13:22 +0800
Message-ID: <CADHLONE2YnBJGJUp2-vn_XEpc7+quTMWF7y1zpV0ygeL2VpQxA@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org, 
	mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org, 
	arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org, 
	maninder1.s@samsung.com, michael.christie@oracle.com, samitolvanen@google.com, 
	linux-arm-kernel@lists.infradead.org, qiruipeng@lixiang.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_071336_467828_D662A81A 
X-CRM114-Status: GOOD (  18.11  )
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

T24gU2F0LCBEZWMgMjMsIDIwMjMgYXQgMTA6MjPigK9QTSBLcnp5c3p0b2YgS296bG93c2tpCjxr
cnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOgoKPiA+IFFjb20gbWluaWR1bXAg
Y2FuIGR1bXAgc29tZSBsb2dzIGxpa2UgZG1zZywgc29tZSBzdGF0dXMgbGlrZSBJUlEgb3IKPiA+
IFJ1biBxdWV1ZS4gVGhpcyBjYW4gaGVscCB0byBsZWFybiBzb21lIGluZm9ybWF0aW9uIHdoZW4g
dGhlIGlzc3VlIG9jY3VycywKPiA+IHdoaWNoIHdpbGwgaGVscCB0byBmaW5kIG91dCB0aGUgcm9v
dCBjYXVzZS4gQnV0IHdoYXQgaXQgZHVtcHMgYXJlIGxpbWl0ZWQsIGl0Cj4gPiBkb2Vzbid0IGR1
bXAgdyBhbmQgbG9jayBpZiB0aGV5IGFyZSBub3QgbG9jYWwgZGF0YS4KPgo+IFNvIGFkZCBtaXNz
aW5nIGZlYXR1cmVzIHRvIGl0LiBJIGRvbid0IHRoaW5rIHlvdSBnb3QgbXkgY29tbWVudCBhbmQg
a2VlcAo+IGFyZ3Vpbmcgb24gdGhlIHNhbWUgdGhpbmcgcmVwZWF0ZWQgZm9yIHVwc3RyZWFtIHN1
Ym1pc3Npb25zIG1hbnkgdGltZXMuCj4gV2UgZG8gbm90IHdhbnQgbXVsdGlwbGUgdmVuZG9yIHNv
bHV0aW9ucy4gRXZlcnkgdmVuZG9yIHdhbnRzIGhpcyB3b3JrCj4gYW5kIGRvZXMgbm90IGNhcmUg
YWJvdXQgaW50ZWdyYXRpbmcgb3IgcmV1c2luZyBvdGhlciBwaWVjZXMuCj4KPiA+Cj4gPiBGb3Ig
b3NkdW1wLCBpdCBkdW1wcyBvYmplY3RzIHN0b3JlZCBpbiBzbGFiLCBkYXRhcyBpbiBic3MsIGRh
dGEgc2VnbWVudHMsCj4gPiBzb21lIGRhdGEgYWxsb2NlZCB3aXRoIG1lbWJsb2NrLCBkYXRhIHN0
b3JlZCBpbiBsb2NhbCBzdGFjaywgYW5kIHNvIG9uLgo+ID4gSW4gYSB3b3JkLCBpdCBkdW1wcyBh
bG1vc3QgYWxsIG9mIHRoZSBrZXkgZGF0YSBpbiB0aGUga2VybmVsLiBCZXNpZGVzLCB5b3UKPiA+
IGNhbiB1c2UgdGhlIGNyYXNoIHRvb2wgdG8gYW5hbHl6ZSB0aGUgZHVtcCBmaWxlLgo+Cj4gSSBk
b24ndCBzZWUgYSBwcm9ibGVtIHdoeSBtaW5pZHVtcCBjYW5ub3QgZG8gaXQuClFjb20gbWluaWR1
bXAgYWxsb3dzIG9uZSBrZXJuZWwgY2xpZW50IHRvIHJlZ2lzdGVyIGl0cyByZWdpb24gdG8gZHVt
cCwgYW5kIHRoZW4KZHJpdmVyIHdpbGwgY3JlYXRlIGFuZCBtYWludGFpbiBvbmUgZWxmIGhlYWQg
Zm9yIGl0LgpCdXQgb3NkdW1wIHdpbGwgZHVtcCB0aG91c2FuZHMgb2Ygbm9uLWNvbnRpbnVvdXMg
cmVnaW9ucy4gSWYgeW91IHJlZ2lzdGVyIG9uZQpieSBvbmUsIGFuZCBhZGQgYW4gZWxmIGhlYWQg
Zm9yIGVhY2gsIGl0IHdpbGwgY2F1c2UgaGVhdnkgb3ZlcmhlYWQuIFNvIGl0IHN0b3JlCmRhdGEg
aW4gYmluYXJ5LCBhbmQgcmVhc3NlbWJsZSBhIHN0YW5kYXJkIGVsZiBmb3JtYXQgZmlsZSBvZmZs
aW5lIGZvciBkZWJ1Zy4KClNpciwgSSBhbSBub3QgcmVhbGx5IGZhbWlsaWFyIHdpdGggUWNvbSBt
aW5pZHVtcCwgYW5kIHNvbWUgb3B0aW9ucyBtYXkgYmUgd3JvbmcuCkJ1dCBkbyB5b3UgdGhpbmsg
aXQgaXMgb2sgdG8gaW50ZWdyYXRlIG9zZHVtcCB0byBRY29tPyBMb29raW5nIGZvcndhcmQgdG8g
eW91cgpzdWdnZXN0aW9ucyEKCkJlc3QgUmVnYXJkcwpSdWlwZW5nCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==

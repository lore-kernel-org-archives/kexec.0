Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E5C531DC
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 13:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UhcHKSKSJ62W8qm/hhgY6E7QD42VkZcqfiBpA1bhTiU=; b=gNyn2iRrR/xDvB
	MA+3KsM6zuczP/RgraMoVomL7JUZ7Md+OaYHtcBXr9mXrUHtRaROwRiAdc59uuqPVyr9dsCCu2gru
	V4x80LTf7rfyMgn7RlUV73OOSqKr+S40Ls5BcYqdnWVQ2lHOgnUu++FPo60zmGY/ZIwUXT3QRqEr2
	KkQxqBeoku4oQ9FkcfH0281HD5IS9jf05exxFPCWsNlns9sYZ3o0I10QdJmsjhicGR2717fYH/KpL
	nTF1Ek5a1+QdUmv+yonvYO7BwUPisJ0QdcxG86L4J1txvFBY2IBxgX766Ek9jZezOODpWCqdS2u+2
	nCdOZl5FSuoKN5SvOyBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shU7T-0000000GpYJ-25Vo;
	Fri, 23 Aug 2024 13:14:23 +0000
Received: from mail-yb1-f170.google.com ([209.85.219.170])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shU72-0000000GpPO-02Gx
	for kexec@lists.infradead.org;
	Fri, 23 Aug 2024 13:13:57 +0000
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e11693fbebaso2083567276.3
        for <kexec@lists.infradead.org>; Fri, 23 Aug 2024 06:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724418834; x=1725023634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRXshE5FXx/w57L6jYhRTv5oTpv9rEAiuwveGGFv1n8=;
        b=a/ZIPl628LIXokTPv7gBbgyhwBQYDwx8T5YqVs+OzObK/5T17TXdbxVy3VNpbOZo+L
         w2zPWXjCJkX/q6BTxvDxwXab+pWINjOMXtonUsJsNmpOl8lgddeaSbCNm+xK82jnjCFy
         PBM0VnjheHfEfDtvKtuDdocG8cSDr1DqhOefpZHPr6mn5BVVQENqjfj5f3bijVxLtIvn
         nkm9BZ8LlgesWx7/ggxl4fp5bRBhT5Y9iN2ELIpDi/bHPh/64gMamWvxnkyAoBnxxFqV
         T5DEDr6kw0XDSW/PrSJlRY2sfwlAjOGaIVo9xXkzTx11BrhBI9ceEvjp/dQOLfDkQ/3o
         icig==
X-Forwarded-Encrypted: i=1; AJvYcCUfNPm3D3p2S5jHHLnYraHLtK90hG/bZKka1n+Db6taPy+8RVc1hpaD7KcU36eYjjb+kMtS4g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3CQ3QLXCwUr4KCba1T7qKQEpMNW1KBfBcg7WJCLIZm8/i6A0G
	WPmqQa/QH/t+WwZht5WDoOI8k3NbkN2BN+ZJuujpWjM7em4RN4gtssnsTr+H
X-Google-Smtp-Source: AGHT+IHSkv6fj5T1FVcPcQtDEPcqKtUJAsk17XBgdhHY1CDZsFyLW7W1xQETkOjMzRGgC2/P6o9JBA==
X-Received: by 2002:a05:6902:1a41:b0:e11:785f:db0c with SMTP id 3f1490d57ef6-e17a86455b1mr2346685276.36.1724418834320;
        Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4637bfsm674726276.23.2024.08.23.06.13.54
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-691c85525ebso17871187b3.0
        for <kexec@lists.infradead.org>; Fri, 23 Aug 2024 06:13:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuRVcPTx23k2CX5Bm68MBszDRpqSPf+apDS8akJi8mXisq8aKpNAV1aHVOtpUMj+UrUqxvVw==@lists.infradead.org
X-Received: by 2002:a05:690c:4d04:b0:6b1:3bf8:c161 with SMTP id
 00721157ae682-6c62538d076mr24871437b3.13.1724418833900; Fri, 23 Aug 2024
 06:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240823125156.104775-1-dave@vasilevsky.ca>
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Aug 2024 15:13:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Message-ID: <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is unlikely
To: Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, bhe@redhat.com, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_061356_075326_050B0DAC 
X-CRM114-Status: GOOD (  25.45  )
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

SGkgRGF2ZSwKCk9uIEZyaSwgQXVnIDIzLCAyMDI0IGF0IDI6NTTigK9QTSBEYXZlIFZhc2lsZXZz
a3kgPGRhdmVAdmFzaWxldnNreS5jYT4gd3JvdGU6Cj4gRml4ZXMgYm9vdCBmYWlsdXJlcyBvbiA2
Ljkgb24gUFBDX0JPT0szU18zMiBtYWNoaW5lcyB1c2luZwo+IE9wZW4gRmlybXdhcmUuIE9uIHRo
ZXNlIG1hY2hpbmVzLCB0aGUga2VybmVsIHJlZnVzZXMgdG8gYm9vdAo+IGZyb20gbm9uLXplcm8g
UEhZU0lDQUxfU1RBUlQsIHdoaWNoIG9jY3VycyB3aGVuIENSQVNIX0RVTVAgaXMgb24uCj4KPiBT
aW5jZSBtb3N0IFBQQ19CT09LM1NfMzIgbWFjaGluZXMgYm9vdCB2aWEgT3BlbiBGaXJtd2FyZSwg
aXQgc2hvdWxkCj4gZGVmYXVsdCB0byBvZmYgZm9yIHRoZW0uIFVzZXJzIGJvb3RpbmcgdmlhIHNv
bWUgb3RoZXIgbWVjaGFuaXNtCj4gY2FuIHN0aWxsIHR1cm4gaXQgb24gZXhwbGljaXRseS4KPgo+
IEFsc28gZGVmYXVsdHMgdG8gQ1JBU0hfRFVNUD1uIG9uIHNoLgo+Cj4gU2lnbmVkLW9mZi1ieTog
RGF2ZSBWYXNpbGV2c2t5IDxkYXZlQHZhc2lsZXZza3kuY2E+Cj4gUmVwb3J0ZWQtYnk6IFJlaW1h
ciBEw7ZmZmluZ2VyIDxSZWltYXIuRG9lZmZpbmdlckBnbXguZGU+Cj4gQ2xvc2VzOiBodHRwczov
L2xpc3RzLmRlYmlhbi5vcmcvZGViaWFuLXBvd2VycGMvMjAyNC8wNy9tc2cwMDAwMS5odG1sCj4g
Rml4ZXM6IDc1YmMyNTVhNzQ0NCAoImNyYXNoOiBjbGVhbiB1cCBrZHVtcCByZWxhdGVkIGNvbmZp
ZyBpdGVtcyIpCgpUaGFua3MgZm9yIHlvdXIgcGF0Y2ghCgo+IC0tLSBhL2tlcm5lbC9LY29uZmln
LmtleGVjCj4gKysrIGIva2VybmVsL0tjb25maWcua2V4ZWMKPiBAQCAtOTcsNyArOTcsNyBAQCBj
b25maWcgS0VYRUNfSlVNUAo+Cj4gIGNvbmZpZyBDUkFTSF9EVU1QCj4gICAgICAgICBib29sICJr
ZXJuZWwgY3Jhc2ggZHVtcHMiCj4gLSAgICAgICBkZWZhdWx0IHkKPiArICAgICAgIGRlZmF1bHQg
QVJDSF9ERUZBVUxUX0NSQVNIX0RVTVAKPiAgICAgICAgIGRlcGVuZHMgb24gQVJDSF9TVVBQT1JU
U19DUkFTSF9EVU1QCj4gICAgICAgICBkZXBlbmRzIG9uIEtFWEVDX0NPUkUKPiAgICAgICAgIHNl
bGVjdCBWTUNPUkVfSU5GTwoKSU1ITyBDUkFTSF9EVU1QIHNob3VsZCBqdXN0IGRlZmF1bHQgdG8g
biwgbGlrZSBtb3N0IGtlcm5lbCBvcHRpb25zLCBhcwppdCBlbmFibGVzIG5vbi10cml2aWFsIGV4
dHJhIGZ1bmN0aW9uYWxpdHk6IHRoZSBrZXJuZWwgc291cmNlIHRyZWUgaGFzCm1vcmUgdGhhbiAx
MDAgbG9jYXRpb25zIHRoYXQgY2hlY2sgaWYgQ09ORklHX0NSQVNIX0RVTVAgaXMgZW5hYmxlZC4K
CkxldHRpbmcgaXQgZGVmYXVsdCB0byBlbmFibGVkIGFsc28gY29uZmxpY3RzIHdpdGggdGhlIHNw
aXJpdCBvZiB0aGUKaGVscCB0ZXh0IGZvciB0aGUgc3ltYm9sOgoKICAgICAgICAgIEdlbmVyYXRl
IGNyYXNoIGR1bXAgYWZ0ZXIgYmVpbmcgc3RhcnRlZCBieSBrZXhlYy4KICAgICAgICAgIFRoaXMg
c2hvdWxkIGJlIG5vcm1hbGx5IG9ubHkgc2V0IGluIHNwZWNpYWwgY3Jhc2ggZHVtcCBrZXJuZWxz
CiAgICAgICAgICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXgogICAgICAgICAgd2hpY2ggYXJlIGxvYWRlZCBpbiB0aGUgbWFpbiBr
ZXJuZWwgd2l0aCBrZXhlYy10b29scyBpbnRvCiAgICAgICAgICBhIHNwZWNpYWxseSByZXNlcnZl
ZCByZWdpb24gYW5kIHRoZW4gbGF0ZXIgZXhlY3V0ZWQgYWZ0ZXIKICAgICAgICAgIGEgY3Jhc2gg
Ynkga2R1bXAva2V4ZWMuIFRoZSBjcmFzaCBkdW1wIGtlcm5lbCBtdXN0IGJlIGNvbXBpbGVkCiAg
ICAgICAgICB0byBhIG1lbW9yeSBhZGRyZXNzIG5vdCB1c2VkIGJ5IHRoZSBtYWluIGtlcm5lbCBv
ciBCSU9TIHVzaW5nCiAgICAgICAgICBQSFlTSUNBTF9TVEFSVCwgb3IgaXQgbXVzdCBiZSBidWls
dCBhcyBhIHJlbG9jYXRhYmxlIGltYWdlCiAgICAgICAgICAoQ09ORklHX1JFTE9DQVRBQkxFPXkp
LgogICAgICAgICAgRm9yIG1vcmUgZGV0YWlscyBzZWUgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlk
ZS9rZHVtcC9rZHVtcC5yc3QKCiAgICAgICAgICBGb3IgczM5MCwgdGhpcyBvcHRpb24gYWxzbyBl
bmFibGVzIHpmY3BkdW1wLgogICAgICAgICAgU2VlIGFsc28gPGZpbGU6RG9jdW1lbnRhdGlvbi9h
cmNoL3MzOTAvemZjcGR1bXAucnN0PgoKV2hhdCBpcyBzbyBzcGVjaWFsIGFib3V0IENSQVNIX0RV
TVAsIHRoYXQgaXQgc2hvdWxkIGJlIGVuYWJsZWQgYnkKZGVmYXVsdD8KCkdye29ldGplLGVldGlu
Z31zLAoKICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02
OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwg
SSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlz
dHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

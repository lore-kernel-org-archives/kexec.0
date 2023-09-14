Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D254DEEAA59
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kwsmt8DFg7sMBhq42z7q+fvPkzfRVdug6+SPWdpHoWQ=; b=c7EKTAcu5cd4nj
	wP2WXXrkIZwWZvlaIhiBLUSEy90CN3qMsHSDOoEn4ODnHaDBmOge53Qrx+TUvXylnR5QGWlyig54i
	ZxYZ2KNBhB5yRGN8zJArG+0eA1H3hJLwj+leZk8YCrXTg85/B90T1n/4GeN/LR4m1+wzYIX0oaqlk
	jlASGWrgDrbEVTtVlzdOiqlS0RJ5+4VG7pjF4LJ8100sAf/tjwafv1Dqd+VHNePgZphb4TBYjdgvi
	IKVfm8ff02AP4lstdt6fuyIuIhPsNrsTihOnEnOv1pn8l55FcStP8OxpORTpU3We3/s8lcPwAqpcJ
	bAJh44e/fWhXpTEA5RwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgq2y-008z1Z-0A;
	Thu, 14 Sep 2023 17:22:32 +0000
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgq2u-008z0S-2d
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 17:22:30 +0000
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-649c6ea6e72so7029556d6.2
        for <kexec@lists.infradead.org>; Thu, 14 Sep 2023 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694712146; x=1695316946; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8eQORumJtaroUI8JT9bu5D1IY7lPGvpUmpxNHPhsvg=;
        b=zrKz4ovVV5RPfLvPR8icG3bYkXqv/dZMiHs5ALYPXhsajvjqL8IScBVRi3mGVthtaK
         5xPdg1BPf3pr0bzH0htK4XYDGJrIlU7OU0jxYvaFnExhkeuyldNKu0HY/R2TXc7tmWl8
         pSBOQhu528LYVHR5qOxd4JKq+voERqlx5/DEX/xtbI+L9yvsi8n8BhLQ0HAX+JruHwra
         Kp/4ec9/BPT0xf4dYj9jl33qicvonQ9zfEiDO3yIBZEcTO4xYfnsONNsjC4AIShxQ46T
         PzfMspOgb4OJgKrEj11jNnYoxSBI/brFUQ6YW+/4NNbty8jxuEMURR+EhkbvgujFCgRB
         x2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694712146; x=1695316946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8eQORumJtaroUI8JT9bu5D1IY7lPGvpUmpxNHPhsvg=;
        b=ZXjBzkKhyslW3cJ7lGZ2yL+pltW5fEn7C+hYV6UZvP4wH6EvgmEjrOJXMyqOgo3S9k
         eeEyZ6xvi7cfDPYCBA9zRk3iFKv9cuHZge5xremghvoA2PkgzhAp3wfic/HfOTdiFyjE
         Fe9yGHC+04etcMYtMkGFTnWCCg8FHnW062+gwu51RwrZi878RbQyKNMSVEEp+g9FQZEj
         zLMAYa0IF0ew2nvGoht13GqdJHsuZwcWk35w6X1rdBpASUgIuwAbMd4cT6/yhzh+CKWH
         icNVlTy4W+BaDl9R0CO9ENxg/kuxRoK/Nhf7SIBeZry04mORiZHhhw/0/m55136nZLfT
         MlUQ==
X-Gm-Message-State: AOJu0YwhpfJ1vTGCAVot6sqoNva6z6zOlQXotOE1z+/RBLgmjFyWxexP
	vba50I8B+57ztRUh8LGO2L+mO3lVMMete4l+JiKBpg==
X-Google-Smtp-Source: AGHT+IFA5G/u9fTxemIh7ppyemUF4heb6N+w5pTJ0x1vdhIE9rGnXqUnizt0BXWM/DV2ecQatLz805H4QnF5kKUSyAs=
X-Received: by 2002:ad4:5851:0:b0:63d:7214:638e with SMTP id
 de17-20020ad45851000000b0063d7214638emr7042473qvb.56.1694712146470; Thu, 14
 Sep 2023 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230914170138.995606-1-song@kernel.org>
In-Reply-To: <20230914170138.995606-1-song@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 14 Sep 2023 10:22:12 -0700
Message-ID: <CAKwvOdnisbzAx3eQD_U8gQU05WzuOr48VRJfySu5WRTWZVDiPw@mail.gmail.com>
Subject: Re: [PATCH v3] x86/purgatory: Remove LTO flags
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, kexec@lists.infradead.org, x86@kernel.org, 
	llvm@lists.linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_102228_852618_3D05F032 
X-CRM114-Status: GOOD (  20.31  )
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

T24gVGh1LCBTZXAgMTQsIDIwMjMgYXQgMTA6MDLigK9BTSBTb25nIExpdSA8c29uZ0BrZXJuZWwu
b3JnPiB3cm90ZToKPgo+IC1mbHRvKiBpbXBsaWVzIC1mZnVuY3Rpb24tc2VjdGlvbnMuIFdpdGgg
TFRPIGVuYWJsZWQsIGxkLmxsZCBnZW5lcmF0ZXMKPiBtdWx0aXBsZSAudGV4dCBzZWN0aW9ucyBm
b3IgcHVyZ2F0b3J5LnJvOgo+Cj4gJCByZWFkZWxmIC1TIHB1cmdhdG9yeS5ybyAgfCBncmVwICIg
LnRleHQiCj4gICBbIDFdIC50ZXh0ICAgICAgICAgICAgIFBST0dCSVRTICAgICAgICAgMDAwMDAw
MDAwMDAwMDAwMCAgMDAwMDAwNDAKPiAgIFsgN10gLnRleHQucHVyZ2F0b3J5ICAgUFJPR0JJVFMg
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMjBlMAo+ICAgWyA5XSAudGV4dC53YXJuICAg
ICAgICBQUk9HQklUUyAgICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyMWMwCj4gICBbMTNd
IC50ZXh0LnNoYTI1Nl91cGRhIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAw
MDIyZjAKPiAgIFsxNV0gLnRleHQuc2hhMjI0X3VwZGEgUFJPR0JJVFMgICAgICAgICAwMDAwMDAw
MDAwMDAwMDAwICAwMDAwMmJlMAo+ICAgWzE3XSAudGV4dC5zaGEyNTZfZmluYSBQUk9HQklUUyAg
ICAgICAgIDAwMDAwMDAwMDAwMDAwMDAgIDAwMDAyYmYwCj4gICBbMTldIC50ZXh0LnNoYTIyNF9m
aW5hIFBST0dCSVRTICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAgMDAwMDJjYzAKPgo+IFRoaXMg
Y2F1c2UgV0FSTklORyBmcm9tIGtleGVjX3B1cmdhdG9yeV9zZXR1cF9zZWNoZHJzKCk6Cj4KPiBX
QVJOSU5HOiBDUFU6IDI2IFBJRDogMTEwODk0IGF0IGtlcm5lbC9rZXhlY19maWxlLmM6OTE5Cj4g
a2V4ZWNfbG9hZF9wdXJnYXRvcnkrMHgzN2YvMHgzOTAKPgo+IEZpeCB0aGlzIGJ5IGRpc2FibGlu
ZyBMVE8gZm9yIHB1cmdhdG9yeS4KPgo+IFdlIGNvdWxkIGFsc28gZml4IHRoaXMgd2l0aCBhbiBl
eHBsaWNpdCBsaW5rZXIgc2NyaXB0IHRvIHJlam9pbiAudGV4dC4qCj4gc2VjdGlvbnMgYmFjayBp
bnRvIC50ZXh0LiBIb3dldmVyLCBnaXZlbiB0aGUgYmVuZWZpdCBvZiBMVE9pbmcgcHVnYXRvcnkK
CnMvcHVnYXRvcnkvcHVyZ2F0b3J5LwoKKG1heWJlIHRoZSB4ODYgbWFpbnRhaW5lcnMgY2FuIGFw
cGx5IHRoYXQgZml4dXAgaWYvd2hlbiBwaWNrZWQgdXApCgo+IGlzIHNtYWxsLCBzaW1wbHkgZGlz
YWJsZSB0aGUgcHJvZHVjdGlvbiBvZiBtb3JlIC50ZXh0Liogc2VjdGlvbnMgZm9yIG5vdy4KPgo+
IEZpeGVzOiBiMzNmZmYwN2UzZTMgKCJ4ODYsIGJ1aWxkOiBhbGxvdyBMVE8gdG8gYmUgc2VsZWN0
ZWQiKQo+IENjOiBSaWNhcmRvIFJpYmFsZGEgPHJpYmFsZGFAY2hyb21pdW0ub3JnPgo+IENjOiBT
YW1pIFRvbHZhbmVuIDxzYW1pdG9sdmFuZW5AZ29vZ2xlLmNvbT4KPiBDYzoga2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4gQ2M6IHg4
NkBrZXJuZWwub3JnCj4gQ2M6IGxsdm1AbGlzdHMubGludXguZGV2Cj4gU2lnbmVkLW9mZi1ieTog
U29uZyBMaXUgPHNvbmdAa2VybmVsLm9yZz4KClRoYW5rcyBmb3IgdGhlIHBhdGNoIQpSZXZpZXdl
ZC1ieTogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+Cgo+Cj4gLS0t
Cj4gQUZBSUNULCB4ODYgaXMgdGhlIG9ubHkgYXJjaCB0aGF0IHN1cHBvcnRzIExUTyBhbmQgcHVy
Z2F0b3J5Lgo+Cj4gQ2hhbmdlcyBpbiB2MzoKPiAxLiBGaXggIkZpeGVzIiB0YWcuIChOaWNrIERl
c2F1bG5pZXJzKQo+IDIuIEFkZCBkZXNjcmlwdGlvbiBvZiBhbiBhbHRlcm5hdGl2ZSBmaXgsIHdp
dGggbGlua2VyIHNjcmlwdC4KPiAgICAoTmljayBEZXNhdWxuaWVycykKPgo+IENoYW5nZXMgaW4g
djI6Cj4gMS4gVXNlIENDX0ZMQUdTX0xUTyBpbnN0ZWFkIG9mIGhhcmRjb2RlIC1mbHRvLiAoTmlj
ayBEZXNhdWxuaWVycykKPiAtLS0KPiAgYXJjaC94ODYvcHVyZ2F0b3J5L01ha2VmaWxlIHwgNCAr
KysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9h
cmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUgYi9hcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUK
PiBpbmRleCBjMmEyOWJlMzVjMDEuLjA4YWEwZjI1ZjEyYSAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4
Ni9wdXJnYXRvcnkvTWFrZWZpbGUKPiArKysgYi9hcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUK
PiBAQCAtMTksNiArMTksMTAgQEAgQ0ZMQUdTX3NoYTI1Ni5vIDo9IC1EX19ESVNBQkxFX0VYUE9S
VFMgLURfX05PX0ZPUlRJRlkKPiAgIyBvcHRpbWl6YXRpb24gZmxhZ3MuCj4gIEtCVUlMRF9DRkxB
R1MgOj0gJChmaWx0ZXItb3V0IC1mcHJvZmlsZS1zYW1wbGUtdXNlPSUgLWZwcm9maWxlLXVzZT0l
LCQoS0JVSUxEX0NGTEFHUykpCj4KPiArIyBXaGVuIExUTyBpcyBlbmFibGVkLCBsbHZtIGVtaXRz
IG1hbnkgdGV4dCBzZWN0aW9ucywgd2hpY2ggaXMgbm90IHN1cHBvcnRlZAo+ICsjIGJ5IGtleGVj
LiBSZW1vdmUgLWZsdG89KiBmbGFncy4KPiArS0JVSUxEX0NGTEFHUyA6PSAkKGZpbHRlci1vdXQg
JChDQ19GTEFHU19MVE8pLCQoS0JVSUxEX0NGTEFHUykpCj4gKwo+ICAjIFdoZW4gbGlua2luZyBw
dXJnYXRvcnkucm8gd2l0aCAtciB1bnJlc29sdmVkIHN5bWJvbHMgYXJlIG5vdCBjaGVja2VkLAo+
ICAjIGFsc28gbGluayBhIHB1cmdhdG9yeS5jaGsgYmluYXJ5IHdpdGhvdXQgLXIgdG8gY2hlY2sg
Zm9yIHVucmVzb2x2ZWQgc3ltYm9scy4KPiAgUFVSR0FUT1JZX0xERkxBR1MgOj0gLWUgcHVyZ2F0
b3J5X3N0YXJ0IC16IG5vZGVmYXVsdGxpYgo+IC0tCj4gMi4zNC4xCj4KCgotLSAKVGhhbmtzLAp+
TmljayBEZXNhdWxuaWVycwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

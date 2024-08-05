Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05102C3DA4A
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 07:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NE0cqccMEC+3a0eHCxHW5xtH+txDOvus+kcbdmCtJNo=; b=1UW8NWen3c826t
	bfYCvF8eMgyu26dks6M60IRIFepTI1xlnIBGycMW+jkO0CUuOk9++XNe4fds8NqC9WGtHFpAfwA8W
	7Ohk9X3xsivTcIrURTrmEjVgwlgc9HjAH6HzKzlef5D3Rn+dq952jKJlNz5jqOBTl0NAE0cZtvsZy
	41cSuS6Orb6h9bWRST6R86QfEqVH7NG8JlSArT51CM5bG3r/FfZJeZzW6Y96hcY927rkMG5pdUFn8
	fLdq8RH/gzyV1WJqDCYBgi4POJvsi4ZlBXq0rY9D7rMhMDeMaYpEhKj2O5YuwEqkv+fmKZRt978k1
	CsEgkWfHgb4w0HbMMgQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sarxR-0000000EtoB-2Qvn;
	Mon, 05 Aug 2024 07:16:41 +0000
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sarwv-0000000Eti4-3DiK
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 07:16:11 +0000
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2f025b94e07so127835561fa.0
        for <kexec@lists.infradead.org>; Mon, 05 Aug 2024 00:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722842167; x=1723446967; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1HgahZErKvyf0fnLV2ZxSZ9HrSzv9jqWuvKKwc1ntU=;
        b=eJhUNGm56m6v9XEzLKV7fI6R9jHC479RsYi7NB4OVFQpp0PS6CRzUJni+VNXj34blE
         +G0L7nomW6hKSOjYHItW7Ob60rYt4ax0mprxIPFO7xOk/B+87ESg9/UtrROPsxqKCjJN
         fcoUyfMMGly4ZDkAu+kYj72hZp+yqIwK/zCeD+RIcwkwEZnJJMVvxs0D2D9iFVesKzAM
         J6TBSNRtPmk86Wyp46MgIiqFsrtK54pzgbGyzhsve7ER0wM20O9vD6l0Y2Pax1xCRx40
         35/Y6Gu6ZbXT6l+bxU/rfeXD5SPEC/U7PfihtoVCjrkusNeys+9+0DkMd/rfccSl9SaN
         gr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722842167; x=1723446967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1HgahZErKvyf0fnLV2ZxSZ9HrSzv9jqWuvKKwc1ntU=;
        b=SFczcIcldIhpREyxDw84EVol/la6/LdV6DUHfDTWJM3eMIW8krY0dDQxJ7bZy3aJwA
         HHHdkZMeEp70e38tLY8Sd5pxIy2DaRpqoZmO+GsiHIAcNIRpjP7JXJ0hrO3dA/1rmLyc
         jyPmFtK8MoQ0rD6SULmvzFqTOX/w3asNlrEQNT13SJ1NtWvBJ8hlBDeuElIZijaKUiX3
         8Y8j9ATiZi1vESbI6WdO1htmd1bh8K+UU+Byo/nYWdMgd0mZAPM01q+NiXhgHT+g5LHN
         RC9vXjoE0hWF4BkUDuexwQwDJEbv7WJ9Icc1RhZpYyXfSyr31zYRThiCzvj4HKbpeVDh
         7jqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTW5Q/S0RZDQzkpgR23Fopv4HqCd/uXtv9BZGtdmEX7+N8djeMXYhGqCFkASebbIaV/La2vOExg4em0mv42BVZJXHJKCHBqzhE
X-Gm-Message-State: AOJu0YwrzrJxrltUHPEuSSbmXI5x2Gb7eBued0Da7szoq4nDHw+QjJT6
	8ksPa+BsQKjXh/MgpyFhbtvrZj7iFj6Ladl2rEDr/QRfdnnmCW7tpA2v/eCzhtrdFZIIGSR7/9X
	zt0MbWTfaVwUV6z2lLnruNfOhA9M97ggYSFqmIQ==
X-Google-Smtp-Source: AGHT+IGqDa7Mip4T5Ze4gJNuIM7yryOJ7VNW9gtRF+kE/YxZtKeRspxCkSMK2y9gAbawEf0T16gIsNMCKgatq/4Jndw=
X-Received: by 2002:a05:6512:1253:b0:52c:dd3d:85af with SMTP id
 2adb3069b0e04-530bb379522mr7294063e87.25.1722842167351; Mon, 05 Aug 2024
 00:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240708133348.3592667-1-ruanjinjie@huawei.com> <20240708133348.3592667-2-ruanjinjie@huawei.com>
In-Reply-To: <20240708133348.3592667-2-ruanjinjie@huawei.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 5 Aug 2024 09:15:56 +0200
Message-ID: <CACRpkdbY-Lp7_AyqvLnQCFYkaazsmMGSHY5K85oJRNmPgM_yVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] crash: Fix memory reserve dead loop bug in reserve_crashkernel_generic()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: linux@armlinux.org.uk, bhe@redhat.com, vgoyal@redhat.com, 
	dyoung@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org, 
	rmk+kernel@armlinux.org.uk, eric.devolder@oracle.com, 
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com, 
	robh@kernel.org, thunder.leizhen@huawei.com, austindh.kim@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_001609_843482_3CFD05A5 
X-CRM114-Status: GOOD (  10.82  )
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

T24gTW9uLCBKdWwgOCwgMjAyNCBhdCAzOjMw4oCvUE0gSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVA
aHVhd2VpLmNvbT4gd3JvdGU6Cgo+IElmIHRoZSBwbGF0Zm9ybSBkbyBub3Qgc3VwcG9ydCBtZW1v
cnkgYWJvdmUgNEcsIHN1Y2ggYXMgMzIgYml0IGFyY2gsCj4gYW5kIENSQVNIX0FERFJfTE9XX01B
WCBpcyBlcXVhbCB0byBDUkFTSF9BRERSX0hJR0hfTUFYLCB0aGUgaGlnaAo+IGNyYXNoIGtlcm5l
bCBtZW1vcnkgcmVzZXJ2YXRpb24gaXMgbWVhbmluZ2xlc3MgYW5kIGl0IHdpbGwgY2F1c2UKPiBk
ZWFkIGxvb3AgYW5kIHN5c3RlbSBzdGFsbDoKPgo+IC0+IHJlc2VydmVfY3Jhc2hrZXJuZWxfZ2Vu
ZXJpYygpIGFuZCBoaWdoIGlzIHRydWUKPiAgLT4gbWVtYmxvY2tfcGh5c19hbGxvY19yYW5nZSgp
IGZhaWwgYW5kIHJldHVybiAwCj4gICAgIC0+IHNlYXJjaF9lbmQgPSBDUkFTSF9BRERSX0xPV19N
QVgoc2FtZSBhcyBDUkFTSF9BRERSX0hJR0hfTUFYKQo+ICAgICAgICAtPiBjYWxsIG1lbWJsb2Nr
X3BoeXNfYWxsb2NfcmFuZ2UoKSBhZ2FpbiBhbmQgZmFpbCBhZ2luLgo+ICAgICAgICAgICAtPiBz
ZWFyY2hfZW5kID09IENSQVNIX0FERFJfSElHSF9NQVggc2F0aXNmeSBhZ2Fpbgo+ICAgICAgICAg
Li4uLi4uCj4KPiBIb3dldmVyLCB0aGUgY3VycmVudCBjaGVjayBvbmx5IGNvbnNpZGVycyB0aGUg
Y2FzZSB3aGVyZQo+IENSQVNIX0FERFJfSElHSF9NQVggaXMgZ3JlYXRlciB0aGFuIENSQVNIX0FE
RFJfTE9XX01BWC4gRml4IGl0Lgo+Cj4gRml4ZXM6IDBhYjk3MTY5YWEwNSAoImNyYXNoX2NvcmU6
IGFkZCBnZW5lcmljIGZ1bmN0aW9uIHRvIGRvIHJlc2VydmF0aW9uIikKPiBTaWduZWQtb2ZmLWJ5
OiBKaW5qaWUgUnVhbiA8cnVhbmppbmppZUBodWF3ZWkuY29tPgoKTG9va3MgZ29vZCB0byBtZToK
UmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4KCllv
dXJzLApMaW51cyBXYWxsZWlqCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

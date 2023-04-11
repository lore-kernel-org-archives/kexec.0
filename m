Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9F7C77B61
	for <kexec@archiver.kernel.org>; Tue, 11 Apr 2023 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4w386l3JG/aIciYACJrJJl9+kRDQfy0GBGSf0oE1Niw=; b=B8/O2Ejfql2LRc
	HwybcOtBidFSH7YHPHu4aOlivbu7OLT47bE5eJtsucG/+7K8c9WGOhkXDeprbPSZ+uQyAZm5RVP69
	Ws14OdHbb/B8OTrnb7lChFncA/E06lzQaPoQ/TS3hJs0GZXVMXc4B2hWsOX8bpC7zYiupaBPGyvIn
	EilgIo0lEtQoq6X3rfebCOKpYMZtW9ZIUrhjVseb0EkzLjs4XUTAbW1eaVu9yyaE82hDUubgPhYhY
	Ox0pN99hFH2vYl1S+RR5Ul0BXTuSJMB4tTT+X8+LTP9UFm7kSIdkEPl27VCY4hq4pt+LTAgxAyvJY
	mbHwnaV/p9a8lNq7FyBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2xw-00GDQV-1h;
	Tue, 11 Apr 2023 01:38:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm2xt-00GDPN-2L;
	Tue, 11 Apr 2023 01:38:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C817A61F78;
	Tue, 11 Apr 2023 01:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5BAC433AC;
	Tue, 11 Apr 2023 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681177112;
	bh=obRgOLwa24A34Xw+WVQ19IPmX3EOzcjF/yQQr8z4UxI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FKStRVCjUmppxwt5KJw0FZfvdJ/8tuaWaSbaVLEVv2cE6MpmWCsmO8+7sCx+XZ4IF
	 9+NJMoao6weabC/ZmfeOYfLEjT0e85GudexqiTnEC/5/diwWjipbaJki7WumRcNBUu
	 VuNsRnT50tdB9rjByw17MxtMI7iW1AEfUj2svXy1UCmXaP/3KKqY3/9N0n0awuuwcY
	 3VLYUKNYeBziDU7+m7WPC39YS6jJ2lDXke/HbwkqvB1RvxKOxSo+1mVZwttk6j0Wil
	 2XWBrz8udkLTFSknPAxszivKNGhBrIz3tOARFevJTofK1iDyGNNO4NA8stv74SKi7l
	 xdBzLt4l3EJdQ==
Received: by mail-ej1-f46.google.com with SMTP id qa44so16256142ejc.4;
        Mon, 10 Apr 2023 18:38:32 -0700 (PDT)
X-Gm-Message-State: AAQBX9cFbEkdnbG1pn/7ao2n+wkvWVx85aqLC2FfoZUjax2OCAUCUa6n
	vvP6ZBPtN8EBEt9GfmGKPjIg8muu9k1o70M/TZ8=
X-Google-Smtp-Source: AKy350ZO+m+Hzk+9BOc3QNXnpM7mFBOw3Rv1kMdU8w6yRrlUuQ2PjmsI8eAiAOl1kaVTrOjH9JGyYIqBp0l//S6K+AA=
X-Received: by 2002:a17:906:c78a:b0:947:eafc:a738 with SMTP id
 cw10-20020a170906c78a00b00947eafca738mr802756ejb.60.1681177110240; Mon, 10
 Apr 2023 18:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230406220206.3067006-1-chenjiahao16@huawei.com>
 <20230406220206.3067006-2-chenjiahao16@huawei.com> <CAJF2gTRtj=-XONv3cMZFd+qCtqUQqYZo5Lv7cgQbkGKTB0j7yg@mail.gmail.com>
 <ZDAGqL6CZGrL499u@kernel.org>
In-Reply-To: <ZDAGqL6CZGrL499u@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 11 Apr 2023 09:38:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ-aRfpK_Ct7pbTcgBEU9qkTAr9VG8B66G0NDBmchSYtA@mail.gmail.com>
Message-ID: <CAJF2gTQ-aRfpK_Ct7pbTcgBEU9qkTAr9VG8B66G0NDBmchSYtA@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/2] riscv: kdump: Implement crashkernel=X,[high,low]
To: Simon Horman <horms@kernel.org>
Cc: Chen Jiahao <chenjiahao16@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	conor.dooley@microchip.com, heiko@sntech.de, bjorn@rivosinc.com, 
	alex@ghiti.fr, akpm@linux-foundation.org, atishp@rivosinc.com, bhe@redhat.com, 
	thunder.leizhen@huawei.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_183833_825615_9CC9959A 
X-CRM114-Status: GOOD (  14.30  )
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

T24gRnJpLCBBcHIgNywgMjAyMyBhdCA4OjAz4oCvUE0gU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgQXByIDA3LCAyMDIzIGF0IDA1OjA2OjI0UE0gKzA4
MDAsIEd1byBSZW4gd3JvdGU6Cj4gPiBPbiBUaHUsIEFwciA2LCAyMDIzIGF0IDEwOjA24oCvUE0g
Q2hlbiBKaWFoYW8gPGNoZW5qaWFoYW8xNkBodWF3ZWkuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4g
T24gcmlzY3YsIHRoZSBjdXJyZW50IGNyYXNoIGtlcm5lbCBhbGxvY2F0aW9uIGxvZ2ljIGlzIHRy
eWluZyB0bwo+ID4gPiBhbGxvY2F0ZSB3aXRoaW4gMzJiaXQgYWRkcmVzc2libGUgbWVtb3J5IHJl
Z2lvbiBieSBkZWZhdWx0LCBpZgo+ID4gPiBmYWlsZWQsIHRyeSB0byBhbGxvY2F0ZSB3aXRob3V0
IDRHIHJlc3RyaWN0aW9uLgo+ID4gPgo+ID4gPiBJbiBuZWVkIG9mIHNhdmluZyBETUEgem9uZSBt
ZW1vcnkgd2hpbGUgYWxsb2NhdGluZyBhIHJlbGF0aXZlbHkgbGFyZ2UKPiA+ID4gY3Jhc2gga2Vy
bmVsIHJlZ2lvbiwgYWxsb2NhdGluZyB0aGUgcmVzZXJ2ZWQgbWVtb3J5IHRvcCBkb3duIGluCj4g
PiA+IGhpZ2ggbWVtb3J5LCB3aXRob3V0IG92ZXJsYXBwaW5nIHRoZSBETUEgem9uZSwgaXMgYSBt
YXR1cmUgc29sdXRpb24uCj4gPiA+IEhlcmUgaW50cm9kdWNlIHRoZSBwYXJhbWV0ZXIgb3B0aW9u
IGNyYXNoa2VybmVsPVgsW2hpZ2gsbG93XS4KPiA+ID4KPiA+ID4gT25lIGNhbiByZXNlcnZlIHRo
ZSBjcmFzaCBrZXJuZWwgZnJvbSBoaWdoIG1lbW9yeSBhYm92ZSBETUEgem9uZSByYW5nZQo+ID4g
PiBieSBleHBsaWNpdGx5IHBhc3NpbmcgImNyYXNoa2VybmVsPVgsaGlnaCI7IG9yIHJlc2VydmUg
YSBtZW1vcnkgcmFuZ2UKPiA+ID4gYmVsb3cgNEcgd2l0aCAiY3Jhc2hrZXJuZWw9WCxsb3ciLgo+
ID4gQXNrZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJuZWwub3JnPgo+Cj4gUGVyaGFwcyAnQWNr
ZWQtYnknIDopClNvcnJ5LCBteSB0eXBvLgoKQWNrZWQtYnk6IEd1byBSZW4gPGd1b3JlbkBrZXJu
ZWwub3JnPgoKCgotLSAKQmVzdCBSZWdhcmRzCiBHdW8gUmVuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==

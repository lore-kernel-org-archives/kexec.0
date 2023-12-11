Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7E0C4167B
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 08:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bteveyAjcuDqMxBOPx/ZBUhJ2GYaP4LKEkbE497HLXA=; b=ECB7eqrjNjbvP6
	nG6E3QLkVZQA7U4uUSWsG+qpnj8pKtijmHFlquRWs+eXj7UUau3bylCnTfJkZGjF7c/mduYM+2Z3U
	dVQAVhQh9NSQPYOMR7YPVDPEIpmP07kVWyAX9Eg2G/o2mcKF+NRH2qlk64TprM5GOWIN0cvPhQI7x
	V2cU5JWhbXejdH6dxbxxFArOArYjPozTN0jfWReSYRNKonzmkvJ35gJEkOB8qKzF88hni/cLFR+aY
	aZg7KDpxIi5QnmdXjQ4+aXc743tIpiAeYVa9Ln7yPwyAKahi3Fa9RXG7XXtghL3ek5eBVwPduVcVj
	E5QqyFhWeNYFLPb/U/Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbbj-004Kfw-2S;
	Mon, 11 Dec 2023 08:25:43 +0000
Received: from mail-yw1-f176.google.com ([209.85.128.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCbbe-004Kb9-0H
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 08:25:40 +0000
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5de93b677f4so23139737b3.2
        for <kexec@lists.infradead.org>; Mon, 11 Dec 2023 00:25:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702283136; x=1702887936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2eWe2oiRzSTkXAZdruL7FMLjSewImdzh7HyKdRxUqI=;
        b=QUUGV197B0+Medfh9gXdcyochQRxsQzCdygnUQ2/psJtTHl2V76+7L+jmWtHD6mySz
         PCWSKtPKy86LxAMQYRZigOblj7b5qhALWkJFsUtlQ5r8/DBnv4T1a1jCFyR2RyXTP0je
         1+lfPww5h8ZQwSfAN5q6htRWt/j1UrMONGqpNQYOQz4GPpQsk+ldZdIZoeulhX+r2cnL
         VWeVf1nCykV+D9UXItNcbCMwdQU2IEN73hMFLxySUGruBwp0EOtmBqIgcPCNIxwbS5e9
         Pke4oUJ9cUBr0MFsienCKtkVWtdH8akjj1nmdx7QLlafwToKQ0Mmw3SrTn1MKAckkxRF
         +vSQ==
X-Gm-Message-State: AOJu0YzBSBPaQBBCk4/lYf4orlI7R+0Ko+HZvL1GmG4IYJr6cYHFhQw9
	D+KTA4J2iLyKrDppiOoLHBYxbttEhfQ6dw==
X-Google-Smtp-Source: AGHT+IGkp2hQZvcsWofcGz3KgEdl6w0E+510a18QZ/rYHHuiUttJ1lLiqhOX3+LpIjstu6SVHKOWQw==
X-Received: by 2002:a81:8384:0:b0:5d3:5391:e10e with SMTP id t126-20020a818384000000b005d35391e10emr3037946ywf.9.1702283136555;
        Mon, 11 Dec 2023 00:25:36 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm2839826ywf.42.2023.12.11.00.25.35
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 00:25:36 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5d74186170fso35540077b3.3
        for <kexec@lists.infradead.org>; Mon, 11 Dec 2023 00:25:35 -0800 (PST)
X-Received: by 2002:a81:7285:0:b0:5d8:74e6:e4c5 with SMTP id
 n127-20020a817285000000b005d874e6e4c5mr2853116ywc.98.1702283135734; Mon, 11
 Dec 2023 00:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20231208073036.7884-1-bhe@redhat.com> <ZXLI748b85be459B@fedora>
In-Reply-To: <ZXLI748b85be459B@fedora>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Dec 2023 09:25:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
Message-ID: <CAMuHMdWAaM+eJtiVbXXBO0xOmpqhrOiCO5itNsNdTiOxRXVtVw@mail.gmail.com>
Subject: Re: [PATCH 0/5] kexec: fix the incorrect ifdeffery and dependency of CONFIG_KEXEC
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	loongarch@lists.linux.dev, kexec@lists.infradead.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-sh@vger.kernel.org, x86@kernel.org, akpm@linux-foundation.org, 
	eric_devolder@yahoo.com, sfr@canb.auug.org.au, ignat@cloudflare.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_002538_132621_F51E64CC 
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

SGkgQmFvcXVhbiwKCk9uIEZyaSwgRGVjIDgsIDIwMjMgYXQgODo0M+KAr0FNIEJhb3F1YW4gSGUg
PGJoZUByZWRoYXQuY29tPiB3cm90ZToKPiBGb3Jnb3QgYWRkaW5nIGtleGVjIHRvIENDLCBhZGQg
aXQgbm93Lgo+Cj4gT24gMTIvMDgvMjMgYXQgMDM6MzBwbSwgQmFvcXVhbiBIZSB3cm90ZToKPiA+
IFRoZSBzZWxlY3Qgb2YgS0VYRUMgZm9yIENSQVNIX0RVTVAgaW4ga2VybmVsL0tjb25maWcua2V4
ZWMgd2lsbCBiZQo+ID4gZHJvcHBlZCwgdGhlbiBjb21waWxpbmcgZXJyb3JzIHdpbGwgYmUgdHJp
Z2dlcmVkIGlmIGJlbG93IGNvbmZpZwo+ID4gaXRlbXMgYXJlIHNldDoKPiA+Cj4gPiA9PT0KPiA+
IENPTkZJR19DUkFTSF9DT1JFPXkKPiA+IENPTkZJR19LRVhFQ19DT1JFPXkKPiA+IENPTkZJR19D
UkFTSF9EVU1QPXkKPiA+ID09PQo+ID4KPiA+IEUuZyBvbiBtaXBzLCBiZWxvdyBsaW5rIGVycm9y
IGFyZSBzZWVuOgo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+IG1pcHNlbC1saW51eC1sZDoga2VybmVsL2tl
eGVjX2NvcmUubzogaW4gZnVuY3Rpb24gYGtpbWFnZV9mcmVlJzoKPiA+IGtlcm5lbC9rZXhlY19j
b3JlLmM6KC50ZXh0KzB4MjIwMCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYG1hY2hpbmVfa2V4
ZWNfY2xlYW51cCcKPiA+IG1pcHNlbC1saW51eC1sZDoga2VybmVsL2tleGVjX2NvcmUubzogaW4g
ZnVuY3Rpb24gYF9fY3Jhc2hfa2V4ZWMnOgo+ID4ga2VybmVsL2tleGVjX2NvcmUuYzooLnRleHQr
MHgyNDgwKTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFjaGluZV9jcmFzaF9zaHV0ZG93bicK
PiA+IG1pcHNlbC1saW51eC1sZDoga2VybmVsL2tleGVjX2NvcmUuYzooLnRleHQrMHgyNDg4KTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgbWFjaGluZV9rZXhlYycKPiA+IG1pcHNlbC1saW51eC1s
ZDoga2VybmVsL2tleGVjX2NvcmUubzogaW4gZnVuY3Rpb24gYGtlcm5lbF9rZXhlYyc6Cj4gPiBr
ZXJuZWwva2V4ZWNfY29yZS5jOigudGV4dCsweDI5YjgpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBtYWNoaW5lX3NodXRkb3duJwo+ID4gbWlwc2VsLWxpbnV4LWxkOiBrZXJuZWwva2V4ZWNfY29y
ZS5jOigudGV4dCsweDI5YzApOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBtYWNoaW5lX2tleGVj
Jwo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KPiA+Cj4gPiBIZXJlLCBjaGFuZ2UgdGhlIGluY29ycmVjdCBkZXBl
bmRlbmN5IG9mIGJ1aWxkaW5nIGtleGVjX2NvcmUgcmVsYXRlZCBvYmplY3QKPiA+IGZpbGVzLCBh
bmQgdGhlIGlmZGVmZmVyeSBvbiBhcmNoaXRlY3R1cmVzIGZyb20gQ09ORklHX0tFWEVDIHRvCj4g
PiBDT05GSUdfS0VYRUNfQ09SRS4KPiA+Cj4gPiBUZXN0aW5nOgo+ID4gPT09PT09PT0KPiA+IFBh
c3NlZCBvbiBtaXBzIGFuZCBsb29nbmFyY2ggd2l0aCB0aGUgTEtQIHJlcHJvZHVjZXIuCj4gPgo+
ID4gQmFvcXVhbiBIZSAoNSk6Cj4gPiAgIGxvb25nYXJjaCwga2V4ZWM6IGNoYW5nZSBkZXBlbmRl
bmN5IG9mIG9iamVjdCBmaWxlcwo+ID4gICBtNjhrLCBrZXhlYzogZml4IHRoZSBpbmNvcnJlY3Qg
aWZkZWZmZXJ5IGFuZCBidWlsZCBkZXBlbmRlbmN5IG9mCj4gPiAgICAgQ09ORklHX0tFWEVDCj4g
PiAgIG1pcHMsIGtleGVjOiBmaXggdGhlIGluY29ycmVjdCBpZmRlZmZlcnkgYW5kIGRlcGVuZGVu
Y3kgb2YKPiA+ICAgICBDT05GSUdfS0VYRUMKPiA+ICAgc2gsIGtleGVjOiBmaXggdGhlIGluY29y
cmVjdCBpZmRlZmZlcnkgYW5kIGRlcGVuZGVuY3kgb2YgQ09ORklHX0tFWEVDCj4gPiAgIHg4Niwg
a2V4ZWM6IGZpeCB0aGUgd3JvbmcgaWZkZWZmZXJ5IENPTkZJR19LRVhFQwoKSSB1bmRlcnN0YW5k
IHRoaXMgc2VyaWVzIGlzIHYzIG9mICJbUEFUQ0ggdjJdIGtleGVjX2NvcmU6IGNoYW5nZQpkZXBl
bmRlbmN5IG9mIG9iamVjdCBmaWxlcyI/IEFzIHRoaXMgc2VyaWVzIGRvZXMgbm90IGNvbnRhaW4g
YQpjaGFuZ2Vsb2csIGNhbiB5b3UgcGxlYXNlIHN1bW1hcml6ZSB3aGF0IHdhcyBjaGFuZ2VkPwpU
aGFua3MhCgpHcntvZXRqZSxlZXRpbmd9cywKCiAgICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0
CgotLQpHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBp
YTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdp
dGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdt
IHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRo
aW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBU
b3J2YWxkcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E78C76196
	for <kexec@archiver.kernel.org>; Tue, 11 Apr 2023 21:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DI4Ph+ZgDyrsoAgomZMC68yFCHeJgjpxbV8qpbo1U/4=; b=yR743ULztA+1jM
	GlylSL5iHt/pmv8wQPCNW+tl3svTlLw/SkcGj96I/47lGs2g5Ilm3gYzOQrREQJ7+xY38I5ODqyLL
	81h2zLOUjt12eYwJNWt3lDPhBfaAu2Elh9PQp0mirhSj8Vcpr90DVpdz/NKqYbnOk+0X1sfgaHJyv
	LcOXtJw9bAL6pK/40Lk5Bjn6T56A8EAmIfgudwDrfpjQFGEddjUWae8PWQQlxTQn4z0Zx2az6cjf0
	ORnJjh4Kg3cHBZs+PHcZkmVQZqDpMI9M+iIiqb2AyJC9fhuKYsz8TXXlVBbJZyYc0e3suqrCtDhxU
	WAtcwSmMfSHRnYOA0NWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmLod-001DFi-2q;
	Tue, 11 Apr 2023 21:46:15 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmLob-001DF4-0L
	for kexec@lists.infradead.org;
	Tue, 11 Apr 2023 21:46:14 +0000
Received: by mail-pl1-x635.google.com with SMTP id ik20so9112500plb.3
        for <kexec@lists.infradead.org>; Tue, 11 Apr 2023 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681249569; x=1683841569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zejEY/r4Tfq5XbhV7cIEeG2i14mVKUoGXnXZCvl+x7Q=;
        b=JR7AbifGvum1/spLQ4gbBxoXTDJFbeqZS0i/NcRbMfRXymryrRUwE2AlNViLCIL0yk
         TK5vobsACwctOi92h20ARZXoHbc9lntb5ojtDAA86UVgkQ2aAAzs4yI2Ppqut09EX+jI
         rPkYLg6i19ex9xi5unVGzXuKv5tnXxZpZuFr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681249569; x=1683841569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zejEY/r4Tfq5XbhV7cIEeG2i14mVKUoGXnXZCvl+x7Q=;
        b=kbGjRdnI993M6701ZqO908Fk8a0++104Kcul/W+C0aXYu9IG7AbEL4/Giv5NbeSHNw
         O68V+nJbpx6es2STwvyCEkIxM6Pq2HfLy0DGaz1/YdajPw+ZI5jWjRTmUd732ehRiNGb
         HgscmsKngDqd1BfxZ0RPJ6TAuTm6Fkxb5ku5+Y9n+sRufurV2340PQCk5snyKtLtqWWs
         ydiGCLXNbk2kVcb0FGbZLDwpAIeD+sB2sRiCU1VV9as4EPkoaDZZEg9MEKvCOQBbJJd1
         1se/tuGa4KPCwHBpwv5Ge6mjnTX8z9Lojssyfy0o1F0ozP3dbtNQKuQhkFrPSvPlDMeL
         u6iQ==
X-Gm-Message-State: AAQBX9cV3rnA9hZ4gpBu6F/NexNV1lfi5MCDAiN/kgumhRd1e7LXbuhj
	9sFj2C8vhv0IuAFX4grGfUeKK+TywIx7qbQe0qs=
X-Google-Smtp-Source: AKy350ZSSgDe4HULRXFEqIPNK2+ZrwFuSMfbQrmhMS+9fBXE3yREAAeRWxxKsovqCIpJQQHTuM43PQ==
X-Received: by 2002:a17:903:11c8:b0:19c:fc41:2dfd with SMTP id q8-20020a17090311c800b0019cfc412dfdmr15634193plh.29.1681249569654;
        Tue, 11 Apr 2023 14:46:09 -0700 (PDT)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com. [209.85.214.175])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902b11400b0019f2328bef8sm10184634plr.34.2023.04.11.14.46.08
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 14:46:08 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id ke16so9166583plb.6
        for <kexec@lists.infradead.org>; Tue, 11 Apr 2023 14:46:08 -0700 (PDT)
X-Received: by 2002:a17:90b:384f:b0:23f:9d83:ad76 with SMTP id
 nl15-20020a17090b384f00b0023f9d83ad76mr15506588pjb.23.1681249567905; Tue, 11
 Apr 2023 14:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
 <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org> <20230330111523.4b98c8ce@gandalf.local.home>
 <20230330151826.GDZCWoQkQBj4BYbwWw@fat_crate.local> <20230330113127.3011e021@gandalf.local.home>
 <20230330160017.GEZCWyEXQVQZRBbYif@fat_crate.local> <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
In-Reply-To: <CAKwvOdkULKxoifiVO4H4yomt1DHQxw0ntdO6QgMXk2BpM-urRg@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Apr 2023 23:45:56 +0200
X-Gmail-Original-Message-ID: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
Message-ID: <CANiDSCvSDcQi2Qbwu8ddpPDAYehu2VoOB6x-v_PaMkWnwAGxYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, 
	Simon Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>, linux-toolchains@vger.kernel.org, 
	clang-built-linux <llvm@lists.linux.dev>, Borislav Petkov <bp@alien8.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_144613_175671_1AC5C1C3 
X-CRM114-Status: GOOD (  31.49  )
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

SGkgTmljawoKT24gU2F0LCA4IEFwciAyMDIzIGF0IDAxOjIyLCBOaWNrIERlc2F1bG5pZXJzIDxu
ZGVzYXVsbmllcnNAZ29vZ2xlLmNvbT4gd3JvdGU6Cj4KPiBIaSBSaWNhcmRvLAo+IFRoYW5rcyBm
b3IgdGhlIHBhdGNoISAgUGxlYXNlIG1ha2Ugc3VyZSB0byBjYyBvdXIgbWFpbGluZyBsaXN0Cj4g
PGxsdm1AbGlzdHMubGludXguZGV2PiBmb3IgbGx2bSBzcGVjaWZpYyBpc3N1ZXMuCj4gc2NyaXB0
cy9nZXRfbWFpbnRhaW5lci5wbCBzaG91bGQgcmVjb21tZW5kIGl0LCBvciB5b3UgY2FuIGZpbmQg
aXQgZnJvbQo+IGNsYW5nYnVpbHRsaW51eC5naXRodWIuaW8uICBZb3UgY2FuIGFsc28gcGluZyBt
ZSBpbnRlcm5hbGx5IGZvcgo+IHRvb2xjaGFpbiByZWxhdGVkIGlzc3Vlcy4KPgo+IFN0YXJ0IG9m
IHRocmVhZC4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwMzIxLWtleGVjX2Ns
YW5nMTYtdjUtMC01NTYzYmY3YzQxNzNAY2hyb21pdW0ub3JnLwo+Cj4gT24gVGh1LCBNYXIgMzAs
IDIwMjMgYXQgOTowMOKAr0FNIEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToK
PiA+Cj4gPiBPbiBUaHUsIE1hciAzMCwgMjAyMyBhdCAxMTozMToyN0FNIC0wNDAwLCBTdGV2ZW4g
Um9zdGVkdCB3cm90ZToKPiA+ID4gT24gVGh1LCAzMCBNYXIgMjAyMyAxNzoxODoyNiArMDIwMAo+
ID4gPiBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFsaWVuOC5kZT4gd3JvdGU6Cj4gPiA+Cj4gPiA+ID4g
T24gVGh1LCBNYXIgMzAsIDIwMjMgYXQgMTE6MTU6MjNBTSAtMDQwMCwgU3RldmVuIFJvc3RlZHQg
d3JvdGU6Cj4gPiA+ID4gPiA+IE1ha2Ugc3VyZSB0aGF0IHRoZSAudGV4dCBzZWN0aW9uIGlzIG5v
dCBkaXZpZGVkIGluIG11bHRpcGxlIG92ZXJsYXBwaW5nCj4gPiA+ID4gPiA+IHNlY3Rpb25zLiBU
aGlzIGlzIG5vdCBzdXBwb3J0ZWQgYnkga2V4ZWNfZmlsZS4KPgo+IFBlcmhhcHMgdGhpcyBpcyBy
ZWxhdGVkIHRvIENyT1MnIHVzZSBvZiBBdXRvRkRPIGNyZWF0aW5nIC50ZXh0LmhvdD8KPiBJZiBz
bywgaXQncyBwcm9iYWJseSBtb3JlIHN0cmFpZ2h0Zm9yd2FyZCB0byBzdHJhaWdodCB1cCBkaXNh
YmxlIFBHTwo+IGZvciBrZXhlYy4gU2VlIGFsc286Cj4KPiBjb21taXQgYmRlOTcxYTgzYmJmICgi
S1ZNOiBhcm02NDogbnZoZTogRml4IGJ1aWxkIHdpdGggcHJvZmlsZSBvcHRpbWl6YXRpb24iKQoK
SXQgd2FzIGluZGVlZCBkdWUgdG8gdGhlIEF1dG9GRE8sIGFkZGluZwoKS0JVSUxEX0NGTEFHUyA6
PSAkKGZpbHRlci1vdXQgLWZwcm9maWxlLXNhbXBsZS11c2U9JSAtZnByb2ZpbGUtdXNlPSUsCiQo
S0JVSUxEX0NGTEFHUykpCgp0byBhcmNoL3g4Ni9wdXJnYXRvcnkvTWFrZWZpbGUKCkl0IGlzIGRl
ZmluaXRlbHkgc2ltcGxlciB0aGFuIGFkZGluZyBhIGxpbmtlciBzY3JpcHQsIGJ1dCBJIGFtIG5v
dApzdXJlIGlmIGl0IGlzIHRoZSBjb3JyZWN0IHdheSB0byBmaXggdGhpcy4uLiBTZWVtcyBsaWtl
IHNwbGl0dGluZwoudGV4dCBpbiBtdWx0aXBsZSBzZWN0aW9ucyBpcyBhbiBpbXBsZW1lbnRhdGlv
biBkZXRhaWwgb2YgdGhlIGNvbXBpbGVyCmFuZCB0aGUgb25seSB3YXkgdG8gZm9yY2UgaXQgaXMg
d2l0aCBhIGxpbmtlciBzY3JpcHQuLi4gT3IgYW0gSQptaXNzaW5nIHNvbWV0aGluZz8KClNoYWxs
IEkgc2VuZCBhIG5ldyB2ZXJzaW9uIHdpdGggdGhlIEtCVUlMRF9DRkxBR1MgPwoKVGhhbmtzIQoK
Pgo+ID4gPiA+Cj4gPiA+ID4gQW5kPwo+ID4gPiA+Cj4gPiA+ID4gV2hhdCBpcyB0aGUgZmFpbHVy
ZSBzY2VuYXJpbz8gV2h5IGFyZSB5b3UgZml4aW5nIGl0PyBXaHkgZG8gd2UgY2FyZT8KPiA+ID4g
Pgo+ID4gPiA+IFRoaXMgaXMgd2F5IHRvbyBsYWNvbmljLgo+ID4gPiA+Cj4gPiA+Cj4gPiA+IFll
YWgsIEkgdGhpbmsgdGhlIGNoYW5nZSBsb2cgaW4gcGF0Y2ggMSBuZWVkcyB0byBiZSBpbiB0aGlz
IHBhdGNoIHRvbywKPiA+ID4gd2hpY2ggZ2l2ZXMgYmV0dGVyIGNvbnRleHQuCj4gPgo+ID4gSnVz
dCByZWFkIGl0Lgo+ID4KPiA+IFdoeSBkaWQgaXQgd29yayB3aXRoIGNsYW5nIHZlcnNpb24gPCAx
Nj8KPgo+IEknbGwgYmV0IGlmIHdlIGJpc2VjdCBsbHZtLCB3ZSBjYW4gc3BvdCB3aGF0IG1pZ2h0
IGhhdmUgY2hhbmdlZCwgd2hpY2gKPiBtYXkgZ2l2ZSB1cyBhIGNsdWUgb24gaG93IHRvIGdldCB0
aGUgb2xkIGJlaGF2aW9yIGJhY2s7IG1heWJlIHdpdGhvdXQKPiB0aGUgbmVlZCBmb3IgYSBsaW5r
ZXIgc2NyaXB0Lgo+Cj4gUmljYXJkbywgaG93IGRpZCB5b3UgdmVyaWZ5IHRoYXQgeW91ciBmaXgg
d2FzIGNvcnJlY3Q/IFN1cmVseSB3ZSBjYW4KPiBjaGVjayB1c2luZyBjb21tYW5kIGxpbmUgdXRp
bGl0aWVzIHdpdGhvdXQgbmVlZGluZyBhIGZ1bGwgYmxvd24ga2V4ZWMKPiBzZXR1cD8gSWYgeW91
IGNhbiBzaGFyZSBtb3JlIGluZm8sIEkgY2FuIGJpc2VjdCBsbHZtIHF1aWNrbHkuICBJZiBpdAo+
IHJlcXVpcmVzIHByb2ZpbGUgZGF0YSwgeW91J2xsIG5lZWQgdG8gc2hhcmUgaXQsIHNpbmNlIENy
T1MgZW5naW5lZXJzCj4gc3RpbGwgaGF2ZSBub3QgcG9zdGVkIHB1YmxpYyBkb2N1bWVudGF0aW9u
IG9uIEF1dG9GRE8gYXMgSSBoYXZlCj4gcmVwZWF0ZWRseSBhc2tlZCBmb3IuCgpUaGUgc2ltcGxl
c3QgdGVzdCBpcyB0byBydW46CgokcmVhZGVsZiAtUyBhcmNoL3g4Ni9wdXJnYXRvcnkvcHVyZ2F0
b3J5LnJvIHwgZ3JlcCAiXSBcLnRleHQiClsgM10gLnRleHQgICAgICAgICAgICAgUFJPR0JJVFMg
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwICAwMDAwMDJhMAoKSWYgdGhlcmUgaXMgb25seSBvbmUg
LnRleHQgc2VjdGlvbiB0aGVuIHRoYXQga2VybmVsIHdpbGwgYmUgbG9hZApwcm9wZXJseSB2aWEg
a2V4ZWNfZmlsZSgpLgoKCgo+Cj4gPgo+ID4gKyB0b29sY2hhaW5zIE1MLgo+ID4KPiA+IC0tCj4g
PiBSZWdhcmRzL0dydXNzLAo+ID4gICAgIEJvcmlzLgo+ID4KPiA+IGh0dHBzOi8vcGVvcGxlLmtl
cm5lbC5vcmcvdGdseC9ub3Rlcy1hYm91dC1uZXRpcXVldHRlCj4KPgo+Cj4gLS0KPiBUaGFua3Ms
Cj4gfk5pY2sgRGVzYXVsbmllcnMKCgoKLS0KUmljYXJkbyBSaWJhbGRhCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==

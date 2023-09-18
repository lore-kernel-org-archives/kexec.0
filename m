Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6954C46CA1
	for <kexec@archiver.kernel.org>; Mon, 18 Sep 2023 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8343IutUQaZax1nRPDkP1rPTG0ajZJF6qsl3kLyTA20=; b=nuACZZ6mueSCOa
	YqVkN1C+c53+RJLGlrEAh6PcvLwBa1NoWSaTp3V+YAJWzVZ8eIKLhidCs6b0RUL0RHkMtfE6I5YXM
	BbKV8jqPY8nmbJU5pVHwYob9TtOUxdut9T0DYYzwhAeBQc18e51fzC/hvjZRA8PQqp5QihkN0EaSJ
	wxdx2Bfab2acOoxVT6yZq9/PiktqWHpwK4hyAbI9FB66DfNSh+VJqx6uGuRngk0NLoezrNCDely3h
	yB7yHhbiLTeSxJisl78P27oDb9Pp3+LYUU7Iv0Xv+7tQLpDKMp9rXqvlkpkb+nBS2RKGtZwuuzzLU
	3dQ9yKZxeuovg7ujUvaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiGNu-00FmM9-1K;
	Mon, 18 Sep 2023 15:42:02 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiGNr-00FmLY-1Q
	for kexec@lists.infradead.org;
	Mon, 18 Sep 2023 15:42:01 +0000
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C9D103F67B
	for <kexec@lists.infradead.org>; Mon, 18 Sep 2023 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1695051710;
	bh=y+XPAVKGm/EwbYadfbcJ41BWcgF5THbmIe2v8KFzKkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=VQK/gHPLYQheiNg+DzuPkXBozREKwfOdFmftt7i4z1/5vT3N1aF4W/RnENQAHhfpV
	 lSsK2ezAEHNzC/cc4DrKtKJUuWS5VWrOMCBnew3bhisGbqeNyp+sZABvALvIah6XVr
	 fQWFkmZ5z2OqLAGRyhtlk7JMlI9dYI2g7TPDGMO2yyCeCWe138xv8BUbE1AdQVlMfc
	 e33b3j1qGIgRJcb0Bg+mNWGPN70bsSN1ae/ttetlNkCZa5IspUHMarnnuR+v/tLodt
	 oqbA/gUUtfOrujtVq9F36+xhzOGz6I/8SBUgixsjXuT02moYEb3A4SolIs7yfjErzk
	 HF8DgwGF3ZCXg==
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31dc8f0733dso3015244f8f.3
        for <kexec@lists.infradead.org>; Mon, 18 Sep 2023 08:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051710; x=1695656510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+XPAVKGm/EwbYadfbcJ41BWcgF5THbmIe2v8KFzKkU=;
        b=cQosw7yftuUTEtapu3hsa1ae+NkXOzZNqww5tvNac1tIFCZCa/z9uX6CEbgygpUrNV
         9vWKY2mbf1ExZaGcabOGaSL16h0CzXmTlNmoQ/UUje0Heu30GN6l9xCJ2cABILCLeksI
         m/SEWFpKJPwIP2l2pvIPhxBXZGEYey5rcFUbdGht1F509hcHOXxByCN+cvvPHYJDSs/R
         iU9sARy1B7cMDnWIyC8stxkmvP2WiOm/GNt6a7qyFoRhVx5GLjg+ZiDn+yT7DFDMBcOz
         1yVx8F29tPALqGR4rLOFIn2W9evhbCqo3k1M37XKQgtCppfuXSrY035QVx8/IThSdBPS
         rY+A==
X-Gm-Message-State: AOJu0YxNlvAzSez0BxalsBvMGk/9XC+azD2XHAbGz9eHJwDk1DPuBLzP
	aqaWMj6wR58VfyFVyxGIgzBSDIYWoWVpYwry4ufz1j1g3mazuu5njqv9VWahvtU1prP6fCvyJa+
	+jnUAPfNsS6AlLpTeY5bmgFAdf7kd4T4CF0/cKEshEGDLhRe1eoBvJg==
X-Received: by 2002:a05:6000:1704:b0:320:bb1:5a76 with SMTP id n4-20020a056000170400b003200bb15a76mr4585917wrc.56.1695051710173;
        Mon, 18 Sep 2023 08:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVJclT5l6JKHYSqhCL8Kigvic3R79GQqfIjbGeGq5mErkfPpOMV0tORq18sC+8oRLK+d1kBjJLTWEX8mt+XM=
X-Received: by 2002:a05:6000:1704:b0:320:bb1:5a76 with SMTP id
 n4-20020a056000170400b003200bb15a76mr4585897wrc.56.1695051709855; Mon, 18 Sep
 2023 08:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230909161851.223627-1-kernel@jfarr.cc> <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com> <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
In-Reply-To: <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date: Mon, 18 Sep 2023 16:41:13 +0100
Message-ID: <CADWks+bRm9LnujBo1SiATDfC1sCNU0vvCy_r=YBpYLXcQrbQeA@mail.gmail.com>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Neal Gompa <ngompa13@gmail.com>, systemd-devel@lists.freedesktop.org, x86@kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, 
	keyrings@vger.kernel.org, bhelgaas@google.com, 
	Jan Hendrik Farr <kernel@jfarr.cc>, tglx@linutronix.de, akpm@linux-foundation.org, 
	bluca@debian.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230918_084159_842667_B0B7EB5B 
X-CRM114-Status: GOOD (  33.31  )
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

T24gVHVlLCAxMiBTZXB0IDIwMjMgYXQgMTE6MzgsIEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtl
cm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gVHVlIFNlcCAxMiwgMjAyMyBhdCAyOjIwIEFNIEVFU1Qs
IE5lYWwgR29tcGEgd3JvdGU6ID4gT24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNzoxNeKAr1BNIEph
cmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gPiBPbiBTYXQgU2Vw
IDksIDIwMjMgYXQgNzoxOCBQTSBFRVNULCBKYW4gSGVuZHJpayBGYXJyIHdyb3RlOgo+ID4gPiA+
IEhlbGxvLAo+ID4gPiA+Cj4gPiA+ID4gdGhpcyBwYXRjaCBpbXBsZW1lbnRzIFVLSSBzdXBwb3J0
IGZvciBrZXhlY19maWxlX2xvYWQuIEl0IHdpbGwgcmVxdWlyZSBzdXBwb3J0Cj4gPiA+ID4gaW4g
dGhlIGtleGVjLXRvb2xzIHVzZXJzcGFjZSB1dGlsaXR5LiBGb3IgdGVzdGluZyBwdXJwb3NlcyB0
aGUgZm9sbG93aW5nIGNhbiBiZSB1c2VkOgo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9DeWRv
eC9rZXhlYy10ZXN0Lwo+ID4gPiA+Cj4gPiA+ID4gVGhlcmUgaGFzIGJlZW4gZGlzY3Vzc2lvbiBv
biB0aGlzIHRvcGljIGluIGFuIGlzc3VlIG9uIEdpdEh1YiB0aGF0IGlzIGxpbmtlZCBiZWxvdwo+
ID4gPiA+IGZvciByZWZlcmVuY2UuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFNvbWUgbGlua3M6
Cj4gPiA+ID4gLSBSZWxhdGVkIGRpc2N1c3Npb246IGh0dHBzOi8vZ2l0aHViLmNvbS9zeXN0ZW1k
L3N5c3RlbWQvaXNzdWVzLzI4NTM4Cj4gPiA+ID4gLSBEb2N1bWVudGF0aW9uIG9mIFVLSXM6IGh0
dHBzOi8vdWFwaS1ncm91cC5vcmcvc3BlY2lmaWNhdGlvbnMvc3BlY3MvdW5pZmllZF9rZXJuZWxf
aW1hZ2UvCj4gPiA+ID4KPiA+ID4gPiBKYW4gSGVuZHJpayBGYXJyICgxKToKPiA+ID4gPiAgIHg4
Ni9rZXhlYzogVUtJIHN1cHBvcnQKPiA+ID4gPgo+ID4gPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9rZXhlYy11a2kuaCAgICAgICB8ICAgNyArKwo+ID4gPiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9wYXJzZV9wZWZpbGUuaCAgICB8ICAzMiArKysrKysrCj4gPiA+ID4gIGFyY2gveDg2L2tlcm5l
bC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAyICsKPiA+ID4gPiAgYXJjaC94ODYva2VybmVs
L2tleGVjLXVraS5jICAgICAgICAgICAgfCAxMTMgKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ID4gPiA+ICBhcmNoL3g4Ni9rZXJuZWwvbWFjaGluZV9rZXhlY182NC5jICAgICB8ICAgMiArCj4g
PiA+ID4gIGFyY2gveDg2L2tlcm5lbC9wYXJzZV9wZWZpbGUuYyAgICAgICAgIHwgMTEwICsrKysr
KysrKysrKysrKysrKysrKysrKwo+ID4gPiA+ICBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL21zY29k
ZV9wYXJzZXIuYyB8ICAgMiArLQo+ID4gPiA+ICBjcnlwdG8vYXN5bW1ldHJpY19rZXlzL3Zlcmlm
eV9wZWZpbGUuYyB8IDExMCArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiA+ID4gPiAgY3J5cHRv
L2FzeW1tZXRyaWNfa2V5cy92ZXJpZnlfcGVmaWxlLmggfCAgMTYgLS0tLQo+ID4gPiA+ICA5IGZp
bGVzIGNoYW5nZWQsIDI3OCBpbnNlcnRpb25zKCspLCAxMTYgZGVsZXRpb25zKC0pCj4gPiA+ID4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9rZXhlYy11a2kuaAo+ID4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYvaW5jbHVkZS9hc20vcGFyc2VfcGVmaWxl
LmgKPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gveDg2L2tlcm5lbC9rZXhlYy11a2ku
Ywo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC94ODYva2VybmVsL3BhcnNlX3BlZmls
ZS5jCj4gPiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IDIuNDAuMQo+ID4gPgo+ID4gPiBXaGF0IHRo
ZSBoZWNrIGlzIFVLST8KPiA+Cj4gPiBVbmlmaWVkIEtlcm5lbCBJbWFnZXMuIE1vcmUgZGV0YWls
cyBhdmFpbGFibGUgaGVyZToKPiA+IGh0dHBzOi8vdWFwaS1ncm91cC5vcmcvc3BlY2lmaWNhdGlv
bnMvc3BlY3MvdW5pZmllZF9rZXJuZWxfaW1hZ2UvCj4gPgo+ID4gSXQncyBhIHdheSBvZiBjcmVh
dGluZyBpbml0cmFtZnMtc3R5bGUgaW1hZ2VzIGFzIGZ1bGx5IGdlbmVyaWMsCj4gPiByZXByb2R1
Y2libGUgaW1hZ2VzIHRoYXQgY2FuIGJlIGJ1aWx0IHNlcnZlci1zaWRlLgo+Cj4gWW91IGNhbiBi
dWlsZCB0b2RheSBhIGtlcm5lbCB3aXRoIHRoZXNlIGNvbXBpbGVkIGluOgo+Cj4gMS4gRUZJIHN0
dWIKPiAyLiBpbml0ZXJhbWZzCj4gMy4gY21kbGluZQo+Cj4gV2h5IGFub3RoZXIgd2F5IChhbmQg
bGFiZWwgJ1VLSScpIGZvciBhIHByZS1leGlzdGluZyBmZWF0dXJlPwo+CgpJbiBVYnVudHUsIHdl
IGhhdmUgY29uc2lkZXJlZCB0byB1c2UgdGhlIGV4aXN0aW5nIGtlcm5lbCBmZWF0dXJlcwpiZWZv
cmUgZ29pbmcgb2ZmIHRvIHVzZSBVS0kuIEhlcmUgYXJlIHNvbWUgb2YgdGhlIHJlYXNvbnMgd2h5
IHdlCmRpZG4ndCBvcHQgdG8gdXNlIHRoZSBrZXJuZWwgYnVpbHRpbiB0aGluZ3M6CjEpIHdlIHdh
bnRlZCB0byBoYXZlIGFiaWxpdHkgdG8gaGF2ZSBUUE0gbWVhc3VyZWQga2VybmVsIGNvbW1hbmRs
aW5lCnBlcmZvcm1lZCBiZWZvcmUga2VybmVsIGlzIGJlaW5nIGV4ZWN1dGVkLCB3aGljaCBpcyB3
aGF0IHNkLXN0dWIKcHJvdmlkZXMgdXMKMikgd2Ugd2FudGVkIHRvIGhhdmUgYWJpbGl0eSB0byB1
cGRhdGUgLyByZWdlbmVyYXRlIGluaXRyZCwgd2l0aG91dApyZWJ1aWxkaW5nIGtlcm5lbC4gVGh1
cyB3aGVuZXZlciB1c2Vyc3BhY2UgaW4gdGhlIGluaXRyZCBuZWVkcwp1cGRhdGluZywgd2UgY2Fu
IGdlbmVyYXRlIG5ldyBpbml0cmQgZm9yIGV4aXN0aW5nIGtlcm5lbCBidWlsZCwgY3JlYXRlCm5l
dyBrZXJuZWwuZWZpLCB3aGlsc3QgdXNpbmcgZXhpc3RpbmcgLmxpbnV4IC8gdm1saW51eiBidWls
ZC4gSSBkb24ndApiZWxpZXZlIGl0IGlzIGN1cnJlbnRseSB0cml2aWFsIHRvIHJlbGluayB2bWxp
bnV6IHdpdGggYnVpbHRpbiBpbml0cmQuCjMpIGxpY2Vuc2luZyB3aXNlIGl0IHdhcyBub3QgY2xl
YXIgaWYgaW5pdHJkIGhhcyB0byBiZSBHUEx2Mgpjb21wYXRpYmxlIHdoZW4gbGlua2VkIGluc2lk
ZSB2bWxpbnV6LCBvciBpZiBpdCBjYW4gY29udGFpbiBHUEx2MyAvCkxHUEx2MyB1c2Vyc3BhY2Ug
Y29kZSAtIHdpdGggVUtJIGl0IGlzIGJlbGlldmVkIHVuYW1iaWdpb3VzbHkgdHJ1ZSwKYmVjYXVz
ZSB2bWxpbnV6IGJvb3RzIGJ5IGl0c2VsZiBzdGFuZGFsb25lIGFuZCBpcyBjb21waWxlZCBzZXBh
cmF0ZWx5Cm9mIHRoZSBVS0kuCjQpIHdlIHdhbnRlZCB0byBoYXZlIGFiaWxpdHkgdG8gb3ZlcnJp
ZGUgY21kbGluZSB2aWEga2VybmVsIGFyZ3MKd2l0aG91dCBzZWN1cmVib290LCBhbmQgdXNlIHN0
b2NrIGNtZGxpbmUgYXJncyB1bmRlciBzZWN1cmVib290LCB0bwphbGxvdyBkZWJ1Z2dpbmcgJiBw
cm9kdWN0aW9uIGJlaGF2aW91ciBmcm9tIGEgc2luZ2xlIHNpZ25lZCBrZXJuZWwuZWZpCih0aGF0
IHdhcyBjdXN0b20gZGV2ZWxvcG1lbnQsIGFuZCBjb3VsZCBiZSBkb25lIGluIHRoZSBzdG9jayB2
bWxpbnV6CnRvbykuCjUpIG9idmlvdXMgbWVudGlvbiwgdGhlIGludGVudGlvbiBoZXJlIGlzIHRv
IGhhdmUgVFBNIFBDUiBtZWFzdXJlbWVudHMKYW5kIFNlY3VyZWJvb3Qgc2lnbmF0dXJlIGZvciB2
bWxpbnV6IGFuZCBpbml0cmQgYW5kIGNtZGxpbmUgYW5kIGR0Yi4KVGhlcmUgaXMgb3RoZXJ3aXNl
IG5vIHN1cHBvcnQgZm9yIHN0YW5kYWxvbmUgc2lnbmVkIGluaXRyZCwgY21kbGluZSwKZHRiIHRv
ZGF5LiBOb3IgZG9lcyB2ZW5kb3JpbmcgaXQgaW50byB2bWxpbnV6IGFjaGlldmVzIHRoaXMgdG8g
dGhlCnNhbWUgZXh0ZW50IChhbmQgZWFzZSBvZiBwcmVkaWN0aW5nIGZvciBzZWFsaW5nIC8gcmVz
ZWFsaW5nIHB1cnBvc2VzKS4KNikgaW4gVWJ1bnR1IGtlcm5lbC5lZmkgYWxzbyBoYXMgc2JhdCBz
ZWN0aW9uIGZvciB0YXJnZXRlZCByZXZvY2F0aW9ucwooZGlzY3Vzc2VkIHNlcGFyYXRlbHkgZWxz
ZXdoZXJlKQoKT3ZlcmFsbCwgaXQgaXMgbW9zdGx5IGFib3V0IGZsZXhpYmlsaXR5IHRvIGJlIGFi
bGUgdG8gcmV1c2UgdGhlIHNhbWUKaW5pdHJkIGFnYWluc3QgbXVsdGlwbGUga2VybmVsIGJ1aWxk
cywgb3IgdXBkYXRlIHVzZSBtdWx0aXBsZSBpbml0cmQKYWdhaW5zdCB0aGUgc2FtZSBrZXJuZWwg
YnVpbGQuIFRoaXMgaXMgaW1obyB0aGUgYmlnZ2VzdCBpc3N1ZSB3aXRoCnVzaW5nIGluaXRyZCBi
dWlsdC1pbnRvIHRoZSB2bWxpbnV6IGl0c2VsZi4KUmVzb3VyY2Ugd2lzZSwgdGhlIGluaXRyZCBw
YXNzZWQgaW4gdmlhIGtlcm5lbC5lZmkgY2FuIGJlIGZyZWVkLCBhcwpmYXIgYXMgSSB1bmRlcnN0
YW5kLiBJIGRvbid0IGtub3cgaWYgdGhlIG9uZSBidWlsdC1pbnRvIHRoZSB2bWxpbnV6IGlzCmZy
ZWVhYmxlLgoKSW1wcm92aW5nIGRlc2lnbiB0byBkbyBzb21ldGhpbmcgZWxzZSBpbnN0ZWFkIG9m
IFVLSSB3b3VsZCBiZQp3ZWxjb21lZC4gT3IgZm9yIGV4YW1wbGUgaW1wcm92aW5nIHRoZSB6aW1n
IGxpbnVzIHVwc3RyZWFtIGZvcm1hdCB0bwpiZSBhIHBhcnRpYWwgb3IgYSB2YWxpZCBVS0kgd291
bGQgaGVscCBhcyB3ZWxsLiBGb3IgZXhhbXBsZSwgYnVpbGRpbmcKdGhlIGtlcm5lbCBidWlsdC1p
biBpbml0cmQgYXMgYSAuaW5pdHJkIHNlY3Rpb24gdGhhdCBpcyByZXBsYWNhYmxlCndvdWxkIGJl
IG5pY2UsIG9yIGFsbG93aW5nIHRvIHByZWxvYWQgemltZyB3aXRoIC5kdGIgb3IgLmNtZGxpbmUK
c2VjdGlvbnMgd291bGQgaGVscCwgYW5kIGFwcHJvcHJpYXRlbHkgaW1wcm92ZSB0aGUgbGludXgg
ZWZpIHN0YWIgdG8KZG8gbWVhc3VyZW1lbnRzIGFuZCBsb2FkaW5nIG9mIC5kdGIgLyAuaW5pdHJk
IGZyb20gaXRzZWxmIHdvdWxkIGJlCm5pY2UuIEJlY2F1c2UgdGhlbiBhbGwgdGhlIGJlbmVmaXRz
IC8gcmVxdWlyZW1lbnRzIGRlc2NyaWJlZCBhYm92ZQpjb3VsZCBiZSBtYWRlIGF2YWlsYWJsZSBv
dXQgb2YgdGhlIGJveCBhbmQgYmUgdHJpdmlhbGx5IHVwZGF0YWJsZS4gVGhlCmJpZ2dlc3Qgb25l
IGJlaW5nIHNwbGl0dGluZyBvdXQgdGhpbmdzIGludG8gc2VjdGlvbnMgdGhhdCBjYW4gYmUKdXBk
YXRlZCB3aXRoIG9iamNvcHkuCgo+IEJSLCBKYXJra28KCi0tIApva3VycnIsCgpEaW1pdHJpCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

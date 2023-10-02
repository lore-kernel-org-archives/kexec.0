Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1333CE74902
	for <kexec@archiver.kernel.org>; Mon,  2 Oct 2023 18:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fT1Sbb89piu7uxd9J2ElQ2XAcwWeL4FISYx1oX6LkT4=; b=XRlVMoaeegcbzx
	hah3pNuSfJiah/605vXVmzP+EAZzCXMLowXiHEuHeU+QPsT6DMi5a+3XEGhIKLMEb3+cvNjkvfgwu
	09UopLNd+Dd8bYfkMOym5lDr8LjPnXV/88LgTBpwYAUYJtt/E+1VC90gZyqVswrHBg2y0jDSHiCSu
	9Omlra72gVY6X1cMnDvTJOZ1UlyE921RH6Fn2lsEXGR7z8pXiCx2GcEP4pdKiP8WwixLpWneTWHT2
	lkwEhgqJuvi0dWQRKDF+7KJWxyAO1+ZZ69LYscoY1DGkEzvYdbzGY0obhy9hy9qX+a+9WRAwZAX+5
	5l1liteB2DaCNaaoGHrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qnNVl-00DCj0-1V;
	Mon, 02 Oct 2023 18:19:17 +0000
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qnNVg-00DCiG-2S
	for kexec@lists.infradead.org;
	Mon, 02 Oct 2023 18:19:14 +0000
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so16426668e87.1
        for <kexec@lists.infradead.org>; Mon, 02 Oct 2023 11:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1696270750; x=1696875550; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmYFxSTwzJ+srWcIfoZo1SLlX6AH34QQsRUSP7AjE6E=;
        b=KlTFhYjafjYvh8aARs4ofIu6+rJwibD9+J85px3UjoYwdtip0XNwvtYmlmJeoEQD63
         4dukZYC3EHhkSDpjsIDbBrOTo5QVJPSKPDMM0l5eiBULUwmKjuACWAyfhFi7YOcz76G6
         SJ3eNm0cejxgTwbPCt4hxjA+6Xz6AX0f5VYqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696270750; x=1696875550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmYFxSTwzJ+srWcIfoZo1SLlX6AH34QQsRUSP7AjE6E=;
        b=gJGsH6TitnmuM2SGzv5IDkJ7JgG+PfgD/+ToEvNiBJGOXlc1RwM9ONVH4qJJKCTSzA
         B3RK4J9+sH7UPuFk/+MbEICAEq9ePEQW4ANYpwZyWbeYmxdt7eMY9I1uynEqkqclu1Ha
         GHxbcmDWrDKqAMwkHd6a/2wn+2v9/I/kXiBi3DVsFtPfQUFxDl2+tcZ9kNvLKKbB2bqK
         1yWt8VkGmRdCiTEdSSfvQLhWNaL7x7qSslEUUfGuBy0toV0WAmsKcd2fH0FzIhCra7Ow
         A+9Qi1S1I+aOP3PpC0rHc2c/FCHVO7LrPY7k6ikhFatUE7IZzvrlC3m1eH1FnThUhu1h
         ZB4g==
X-Gm-Message-State: AOJu0YxsGxzIzfTU529Ri8f0X67AIRwSFTTx14/KuEZF9WVQuHwEj/OX
	V0TVYOpMbkqEyVuIkyoHc29VMD0FEwYeirCUKIuFhg==
X-Google-Smtp-Source: AGHT+IHbOd875gpdjPofvtrlgTr+wHiCla5vNQdnG5xXttbr+WjmmnUwdNy/rHwCgl58Mckl03RBmsvfu12qFYDSn08=
X-Received: by 2002:a05:6512:3c87:b0:4fd:fabf:b6ee with SMTP id
 h7-20020a0565123c8700b004fdfabfb6eemr12141694lfv.9.1696270749716; Mon, 02 Oct
 2023 11:19:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230929021213.2364883-1-joel@joelfernandes.org> <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87bkdl55qm.fsf@email.froward.int.ebiederm.org>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Mon, 2 Oct 2023 14:18:58 -0400
Message-ID: <CAEXW_YQ=HGok600ARtCKBNDs1OHSc=UM4hWmBdQ=sXZvif0Z5g@mail.gmail.com>
Subject: Re: [PATCH] kexec: Fix reboot race during device_shutdown()
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Ricardo Ribalda <ribalda@google.com>, Ross Zwisler <zwisler@google.com>, Rob Clark <robdclark@gmail.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231002_111912_805566_B11288D1 
X-CRM114-Status: GOOD (  29.26  )
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

SGkgRXJpYywKCk9uIEZyaSwgU2VwIDI5LCAyMDIzIGF0IDEyOjAx4oCvUE0gRXJpYyBXLiBCaWVk
ZXJtYW4KPGViaWVkZXJtQHhtaXNzaW9uLmNvbT4gd3JvdGU6Cj4KPiAiSm9lbCBGZXJuYW5kZXMg
KEdvb2dsZSkiIDxqb2VsQGpvZWxmZXJuYW5kZXMub3JnPiB3cml0ZXM6Cj4KPiA+IER1cmluZyBr
ZXhlYyByZWJvb3QsIGl0IGlzIHBvc3NpYmxlIGZvciBhIHJhY2UgdG8gb2NjdXIgYmV0d2Vlbgo+
ID4gZGV2aWNlX3NodXRkb3duKCkgYW5kIHVzZXJzcGFjZS4gIFRoaXMgY2F1c2VzIGFjY2Vzc2Vz
IHRvIEdQVSBhZnRlciBwbV9ydW50aW1lCj4gPiBzdXNwZW5kIGhhcyBhbHJlYWR5IGhhcHBlbmVk
LiBGaXggdGhpcyBieSBjYWxsaW5nIGZyZWV6ZV9wcm9jZXNzZXMoKSBiZWZvcmUKPiA+IGRldmlj
ZV9zaHV0ZG93bigpLgo+Cj4gSXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgdGhpcyBzYW1lIHJhY2Ug
d2l0aCBiZXR3ZWVuIHN5c19rZXhlYyBhbmQgdGhlCj4gYWRyZW5vX2lvY3RsIGNhbiBub3QgaGFw
cGVuIGR1cmluZyBhIG5vcm1hbCByZWJvb3Q/CgpUaGFua3MgZm9yIHRoZSByZXNwb25zZS4gSXQg
Y2FuIGhhcHBlbiBkdXJpbmcgYSBub3JtYWwgcmVib290LiBJIHRoaW5rCnRoZSByZWFzb24gaXQg
ZG9lcyBub3Qgc2hvdyB1cCBpbiB0aGUgd2lsZCBpcyBiZWNhdXNlIHRoZSAicmVib290Igpjb21t
YW5kIGltcGxlbWVudGF0aW9uIHR5cGljYWxseSBzZW5kcyBvbmUgb2YgU0lHU1RPUCBvciBTSUdL
SUxMIHRvCmFsbCBwcm9jZXNzZXMgd2hpY2ggZWZmZWN0aXZlbHkgcHJldmVudHMgdGhlIHJhY2Uu
CgpJbiBhbnkgY2FzZSwgdGhlcmUgaXMgYWxzbyBhIHNjaG9vbCBvZiB0aG91Z2h0IHRoYXQgc2F5
cyB0aGUga2VybmVsCnNob3VsZCBiZSByZXNpbGllbnQgdG8gY3Jhc2hlcyBhbmQgYSB1c2Vyc3Bh
Y2Ugd29ya2Fyb3VuZCBpbnZvbHZpbmcKc2VuZGluZyBzaWduYWxzIGNvdWxkIGJlIGxvb2tlZCBh
dCBhcyBwYXBlcmluZyBvdmVyIHRoZSByZWFsIGlzc3VlLiBJCmRvIHN5bXBhdGhpemUvYWdyZWUg
d2l0aCB0aGF0IHNjaG9vbCBvZiB0aG91Z2h0IGFzIHdlbGwuCgo+IElzIHRoZXJlIGFueSByZWFz
b24gd2h5IHRoZXJlIGlzIG5vdCBhIC5zaHV0ZG93biBtZXRob2QgdG8gcHJldmVudCB0aGUKPiBy
YWNlPwo+IEkgd291bGQgdGhpbmsgdGhlIHRoaW5nIHRvIGRvIGlzIHRvIHByZXZlbnQgdGhpcyBy
YWNlIGluCj4ga2VybmVsX3Jlc3RhcnRfcHJlcGFyZSBvciBpbiB0aGUgR1BVcyAuc2h1dGRvd24g
bWV0aG9kLiAgQXMgSSBkb24ndCBzZWUKPiBhbnl0aGluZyB0aGF0IHdvdWxkIHByZXZlbnQgdGhp
cyBkdXJpbmcgYSBub3JtYWwgcmVib290LgoKV2hhdCB5b3UncmUgc2F5aW5nIGlzIGVzc2VudGlh
bGx5IHdoYXQgSSByZW1lbWJlciB0cnlpbmcsIHRoZSBpc3N1ZSBpcwpub3QgaW4gdGhlIEdQVSBk
cml2ZXIgYnV0IHJhdGhlciB0aGVyZSB0aGUgaW50ZXJjb25uZWN0IGluIHRoZSBTb0MKc2h1dGRv
d24gYW5kIGNhdXNlcyBhbiAiU0Vycm9yIiBleGNlcHRpb24gaWYgdGhlIENQVSB0cmllcyB0byBh
Y2Nlc3MKdGhlIG1lbW9yeSBsb2NhdGlvbnMsIGFzIGFsc28gc2VlbiBpbiB0aGUgc3RhY2suIEkg
d2FzIG5vdCBhYmxlIHRvCnRyYWNlIGV4YWN0bHkgd2hlbiB0aGUgaW50ZXJjb25uZWN0IGJlY29t
ZXMgdW5hdmFpbGFibGUgYW5kIHBlcmhhcHMKdGhlcmUgaXMgYSBwb3NzaWJpbGl0eSBvZiBhIG1v
cmUgaW50cmljYXRlIGZpeCB3aGVyZSB3ZSBjYW4gc2lnbmFsIHRoZQpHUFUgZHJpdmVyIHRvIG5v
dCBhY2Nlc3MgdGhlIGJ1cyBhbnltb3JlLCBidXQgbXkgc3VzcGljaW9uIGlzIHRoYXQKd2lsbCBh
ZGQgYSBsb3Qgb2YgY29tcGxleGl0eSBhbmQgcGVyaGFwcyBsZWF2ZSB0aGUgZG9vciBvcGVuIHRv
CnNpbWlsYXIgaXNzdWVzLgoKPiA+IFN1Y2ggZnJlZXppbmcgaXMgYWxyZWFkeSBiZWluZyBkb25l
IGlmIGtlcm5lbCBzdXBwb3J0cyBLRVhFQ19KVU1QIGFuZAo+ID4ga2V4ZWNfaW1hZ2UtPnByZXNl
cnZlX2NvbnRleHQgaXMgdHJ1ZS4gSG93ZXZlciwgZG9pbmcgaXQgaWYgZWl0aGVyIG9mIHRoZXNl
IGFyZQo+ID4gbm90IHRydWUgcHJldmVudHMgY3Jhc2hlcy9yYWNlcy4KPgo+IFRoZSBLRVhFQ19K
VU1QIGNhc2UgaXMgc29tZXRoaW5nIGVsc2UgZW50aXJlbHkuICBJdCBpcyBzdXBwb3NlZCB0byB3
b3JrCj4gbGlrZSBzdXNwZW5kIHRvIFJBTS4gIE1heWJlIHJlYm9vdCBzaG91bGQgYXMgd2VsbCwg
YnV0IEkgYW0KPiB1bmNvbWZvcnRhYmxlIG1ha2luZyBhIGdlbmVyaWMgZGV2aWNlIGZpeCBrZXhl
YyBzcGVjaWZpYy4KCkkgc2VlIHlvdXIgcG9pbnQgb2Ygdmlldy4gSSB0aGluayByZWd1bGFyIHJl
Ym9vdCBzaG91bGQgYWxzbyBiZSBmaXhlZAp0byBhdm9pZCBzaW1pbGFyIGNyYXNoIHBvc3NpYmls
aXRpZXMuIEkgYW0gaGFwcHkgdG8gbWFrZSBhIGNoYW5nZSBmb3IKdGhhdCBzaW1pbGFyIHRvIHRo
aXMgcGF0Y2ggaWYgd2Ugd2FudCB0byBwcm9jZWVkIHRoYXQgd2F5LgoKVGhvdWdodHM/Cgp0aGFu
a3MsCgogLSBKb2VsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

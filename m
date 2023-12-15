Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7ADC4332F
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 02:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bg75/O4pxtZxQXUGqCPAS3i8H/SAHcBQIuub4wlcTJE=; b=4I736vQyWpZ+eH
	agYs/yoZAGNWyqR9+fNJ2+pYdxpeJXOL+rbP1Y692DPbucLKDZUJ1QEd59Q6rIYTGl0Wdb9SLn3/b
	bTyw3lGecp4fvGxdI0XwbrUuQXxZy/1IL3r2FfcxssSL7bHsmjpis72u3wDuHxvF8uOZOXdb+Zxy6
	nRZRn+paDLqfjB774bUVpaasTRWY0J76JlT4YkoGNOaUIDcAKzk17Lwr2RZYIoscF4cjRMexdZqeC
	xyUVZ7QFkVw33vxe1iuVsP30wLThqLlJ/3+w+v+LBoT3z1qKe6m8DlySn+ZAaQA+cBe/SeqAJrvb/
	5FJHFpz2hceEeXl3GwiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDyBs-001pvn-1K;
	Fri, 15 Dec 2023 02:44:40 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDyBp-001pto-16
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 02:44:39 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-336417c565eso125317f8f.3
        for <kexec@lists.infradead.org>; Thu, 14 Dec 2023 18:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702608273; x=1703213073; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9XDBQt8NyASWBhHRtYhXwFukuH9acGC67RiibDyL7E=;
        b=imC1VhoEv2o6octwdP08zTWC6zFp5ScPl1S2jIggMHLgXgFtUF5WzVRfipbFQiJ0H8
         Nh4MJowgem1Q9Omp0m7S2YX6honeWY32O1ZkagsgZn26smz5VCgGi2xiW8McPeP2RI2Q
         TRROWqRzaVNxzNZx5gLV7nmRZzp/WqtIvg7Nf5WaHyBC15bJ5oLHAbnPRoYPDgvctACH
         tx1Dunf7w/LlmRj8Hye496bZO9lIb+D3HZhJZ8EWde8ZNLXJxhgMjEojjGd+FBdpoq4G
         ik8kor2zLxOn/66EuFkFMRpSjDR0VGIrPpavHDm4pqwxLLBTvBd5ThlqAI68EfOTAHfv
         6+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702608273; x=1703213073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9XDBQt8NyASWBhHRtYhXwFukuH9acGC67RiibDyL7E=;
        b=cvfVxQn6cBHk1lB2fUfhy1tD4Wsr+r+wpPvk17bk6kauydpXpHm7lExmKmY22Xt7Qn
         A0E5ybgQZdt0OjtOCaw/oaqz8ZfAIJ9VJqnmj6cYE1yStl8KvcUcnbrWBuntqTS0Pn8G
         6uFseYSYVVqZveCiPSYmO5voWyEwU9JLdzvYzS/DvmAtvrTk8uxmwT1TxThZa5DuXw+v
         /gXdWTuRHPD4n3om269ADacbN9izG8wGDf6dxikCJaIDGJvsDIqso13v7m6xg+U37LUR
         vFXg1+KPCZNq7kecJNYBYmOtRhMLifQE4g6G85mMuN/DXKKBTCNEest1MBdZbqLwhEOE
         sHow==
X-Gm-Message-State: AOJu0Yzv3uEycGfkpJt9qTMBD4Ug9ddBqX0SYJXDDf0/Un1u0e8Udc/h
	pGdefbeUPBrBfyAtdolB8iL2Fd/M5ges5LZlpc8SmQ==
X-Google-Smtp-Source: AGHT+IEHYFogUObtxR5bOjWEUZN9INgCImPWqK70oIiDi+VdLrk3rRhfc+3EQJvaALO54EkeT7OruMofARK/eN/0O5A=
X-Received: by 2002:a05:6000:1d97:b0:336:26d3:8819 with SMTP id
 bk23-20020a0560001d9700b0033626d38819mr2973326wrb.41.1702608273373; Thu, 14
 Dec 2023 18:44:33 -0800 (PST)
MIME-Version: 1.0
References: <CAA0N8zYyGKraVW8v3roMNakuJxQJOo3ddsB=e0D_KaD+Ji=81A@mail.gmail.com>
In-Reply-To: <CAA0N8zYyGKraVW8v3roMNakuJxQJOo3ddsB=e0D_KaD+Ji=81A@mail.gmail.com>
From: Chris Koch <chrisko@google.com>
Date: Thu, 14 Dec 2023 18:44:15 -0800
Message-ID: <CAA0N8zaYjfxJ7eTWU-t0qGRN7rsU9_O8+7XPNW5iejtmr57s3A@mail.gmail.com>
Subject: Re: The conflict between PHYSICAL_START and MIN_KERNEL_LOAD_ADDR
To: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Cloud Hsu <cloudhsu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231214_184437_379632_257DC655 
X-CRM114-Status: GOOD (  25.86  )
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

TXkgYXBvbG9naWVzLCBJIGRpZG4ndCByZWFsaXplIHg4NkAgd2Fzbid0IGEgbWFpbGluZyBsaXN0
IGVhcmxpZXIuCkFkZGluZyB0aGUgbGlzdC4KCk9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDY6Mzfi
gK9QTSBDaHJpcyBLb2NoIDxjaHJpc2tvQGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4gSGkgYWxsLAo+
Cj4gd2UgcmFuIGludG8gc29tZSBtZW1vcnkgY2xvYmJlcmluZyBvbiBrZXJuZWwgYm9vdCwgYW5k
IHRoZXJlIHNlZW1zIHRvCj4gYmUgYSBiaXQgb2YgYSBjb25mbGljdCBiZXR3ZWVuIHRoZSBkb2N1
bWVudGF0aW9uIGFuZCByZWFsaXR5LCBhbmQKPiBDT05GSUdfUEhZU0lDQUxfU1RBUlQgKGRlZmF1
bHQgMHgxIDAwMCAwMDApIGFuZCBNSU5fS0VSTkVMX0xPQURfQUREUgo+IChkZWZhdWx0IDB4MTAw
IDAwMCkuCj4KPiBGaXJzdCBvYnNlcnZhdGlvbjogYnppbWFnZSdzIHByZWZfYWRkcmVzcyBpcyBs
aXN0ZWQgYXMgInByZWZlcnJlZCIgaW4KPiB0aGUgYm9vdCBkb2N1bWVudGF0aW9uIGZvciByZWxv
Y2F0YWJsZSBrZXJuZWxzLCBidXQgd2hhdCBpcyBub3QKPiBtZW50aW9uZWQgaXMgdGhhdCBpZiB0
aGUga2VybmVsIGlzIGxvYWRlZCBiZWxvdyBwcmVmX2FkZHJlc3MsIGl0IHdpbGwKPiByZWxvY2F0
ZSBpdHNlbGYgdGhlcmUgWzFdLiBUaGUgZGVmYXVsdCBDT05GSUdfUEhZU0lDQUxfU1RBUlQgc2Vl
bXMgdG8KPiBiZSAweDEwMDAwMDAsIGFuZCBhIHJldmlldyBvZiBib290bG9hZGVycyBzaG93cyB0
aGF0IGluIGV2ZXJ5IGNhc2UgYnV0Cj4gR1JVQiBhIGtlcm5lbCB3aWxsIGdldCBsb2FkZWQgYmVs
b3cgdGhhdCwgYW5kIHRoZW4gcmVsb2NhdGUgaXRzZWxmCj4gdGhlcmUuIChpcHhlIDB4MTAwMDAg
b3IgMHgxMDAwMDAgZGVwZW5kaW5nIG9uIGNvbmZpZywga2V4ZWMtdG9vbHMKPiAweDEwMDAwMCwg
a2V4ZWNfZmlsZSAweDEwMDAwMCkKPgo+IFRoaXMgbWVhbnMgaW4gYWxsIGRlZmF1bHQgY2FzZXMg
ZXhjZXB0IEdSVUIsIHRoZSBrZXJuZWwgd2lsbCByZWxvY2F0ZQo+IGl0c2VsZiBhbmQgZGVjb21w
cmVzcyBpbiBhbiBhcmVhIG9mIG1lbW9yeSBpdCB3YXMgbm90IGludGVuZGVkIGZvciwKPiBhbmQg
d2hpY2ggbWF5IGhvbGQgcmVzZXJ2ZWQgZGF0YSBpbiB0aGUgbWVtb3J5IG1hcC4gKFRoaXMgaXMg
d2hhdAo+IGhhcHBlbmVkIGluIG91ciBjYXNlLiBJdCB3YXMgY2xvYmJlcmluZyByZXNlcnZlZCBz
dHVmZi4pCj4KPiBUaGlzIHN1Z2dlc3RzIHRoZSBmb2xsb3dpbmc6Cj4gMSkgVGhpcyBwcmVmX2Fk
ZHJlc3MgYmVoYXZpb3Igc2hvdWxkIGJlIGRvY3VtZW50ZWQgaW4gYm9vdC5yc3QuCj4gU29tZXRo
aW5nIGxpa2UgIkEgcmVsb2NhdGFibGUga2VybmVsIHdpbGwgcmVsb2NhdGUgaXRzZWxmIHRvCj4g
cHJlZl9hZGRyZXNzICh3aGljaCBpcyBlcXVhbCB0byBDT05GSUdfUEhZU0lDQUxfU1RBUlQpIGlm
IGl0IHdhcwo+IGxvYWRlZCBiZWxvdyB0aGF0IGFkZHJlc3MuIgo+Cj4gMikgRG9jdW1lbnRhdGlv
biBmb3IgUEhZU0lDQUxfU1RBUlQgc2hvdWxkIGJlIHVwZGF0ZWQuIEl0IHN0YXRlcwo+Cj4gPiBJ
ZiBrZXJuZWwgaXMgYSBub3QgcmVsb2NhdGFibGUgKENPTkZJR19SRUxPQ0FUQUJMRT1uKSB0aGVu
Cj4gPiBiekltYWdlIHdpbGwgZGVjb21wcmVzcyBpdHNlbGYgdG8gYWJvdmUgcGh5c2ljYWwgYWRk
cmVzcyBhbmQKPiA+IHJ1biBmcm9tIHRoZXJlLiBPdGhlcndpc2UsIGJ6SW1hZ2Ugd2lsbCBydW4g
ZnJvbSB0aGUgYWRkcmVzcyB3aGVyZQo+ID4gaXQgaGFzIGJlZW4gbG9hZGVkIGJ5IHRoZSBib290
IGxvYWRlciBhbmQgd2lsbCBpZ25vcmUgYWJvdmUgcGh5c2ljYWwKPiA+IGFkZHJlc3MuCj4KPiAz
KSBTb21lIHBhdGNoZXMgc2hvdWxkIGJlIHNlbnQgdG8gaXB4ZSwga2V4ZWMtdG9vbHMgYW5kIGtl
eGVjX2ZpbGUgdG8KPiByZXNwZWN0IHByZWZfYWRkcmVzcyBhcyBhIG1pbmltdW0gYWRkcmVzcywg
bm90IGp1c3QgYSBwcmVmZXJyZWQKPiBhZGRyZXNzLgo+Cj4gNCkgVGhlIGRlZmF1bHQgdmFsdWVz
IG9mIE1JTl9LRVhFQ19MT0FEX0FERFIgYW5kIENPTkZJR19QSFlTSUNBTF9TVEFSVAo+IHNob3Vs
ZCBhbGlnbiB0byByZWR1Y2UgdGhlIGNoYW5jZXMgb2YgdGhpcyBoYXBwZW5pbmcgZm9yIHVzZXJz
IHdobwo+IGFyZW4ndCBtZXNzaW5nIHdpdGggdGhlc2UgdmFsdWVzLiBHaXZlbiB3aGF0IGN1cnJl
bnQgYm9vdCBsb2FkZXJzIGRvLAo+IHNob3VsZCBDT05GSUdfUEhZU0lDQUxfU1RBUlQgYmUgbG93
ZXJlZCB0byAweDEwMDAwMCwgYXQgbGVhc3QgZm9yCj4gcmVsb2NhdGFibGUga2VybmVscz8gVGhp
cyBtaWdodCBiZSB0aGUgbW9zdCBjb250cm92ZXJzaWFsIG9mIHRoZQo+IGNoYW5nZXMuCj4KPiA1
KSBTaG91bGQgUEhZU0lDQUxfU1RBUlQgYmUgaWdub3JlZCBpbiByZWxvY2F0YWJsZSBrZXJuZWxz
IGxpa2UgaXRzCj4gZG9jdW1lbnRhdGlvbiBzdWdnZXN0cz8gSXMgdGhlIHJlbG9jYXRpb24gYWJv
dmUgdGhhdCB1bm5lY2Vzc2FyeT8KPgo+IFJlZ2FyZGxlc3Mgb2Ygd2hpY2ggY2hhbmdlIHdlIG1h
a2UgZm9yIHRoZSBmdXR1cmUsIGV4aXN0aW5nIGJvb3QKPiBsb2FkZXJzICYga2VybmVscyBjb25m
bGljdCBpbiB0aGVpciBiZWhhdmlvciBmb3IgcmVsb2NhdGFibGUga2VybmVscy4KPiBXaGF0IGlz
IG1vc3QgbGlrZWx5IHRvIGZpeCB0aGlzIGlzc3VlIGZvciB1c2VycyAmIHByZXZlbnQgYnJlYWth
Z2Ugb2YKPiBleGlzdGluZyB3b3JrZmxvd3M/Cj4KPiBJZiBJIHNlZSBhZ3JlZW1lbnQgb24gMSB0
byAzLCBJIHdpbGwgc3RhcnQgc2VuZGluZyBwYXRjaGVzLiBXb3VsZCBsb3ZlCj4gdG8gaGVhciBv
cGluaW9ucyBvbiA0ICYgNS4KPgo+IFRoYW5rcywKPiBDaHJpcwo+Cj4gWzFdIGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvdHJl
ZS9hcmNoL3g4Ni9ib290L2NvbXByZXNzZWQvaGVhZF82NC5TP2g9bGludXgtNi42LnkjbjMzMwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFp
bGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

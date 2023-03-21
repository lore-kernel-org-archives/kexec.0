Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F142AC6FD1D
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5cHz5bwQswHCYDeX3mkq8JMVNDqR1xMHy6EVDP41XQw=; b=TJuwc0tmRwccNJ
	c89O4gYQpHmS6IagaHPlCPBU0V43mkmm+UtwSvPIMl5IzmyVfxzqVtHvA2t/2r39uvOodh00lPg/T
	GxMMyQQGXhe5KHhIDAUEppFCruhh1fPxHBPKSAtJZGt5ZSiYe2/vB8CKGew1GJDamaff9xoxd30eS
	6O4oPNTPQ4v3ZRgatr6gDvIRSKWss4QLvRLKWUuUZLIDvl2LrxgOcVwBe6VFKFeoin2fUnHDGxvQu
	oU0WE2gx9DAKFrKP+oLqAOWdz12bYtwGgzBeGNcJKstWPtGxxz9gn0EtEPCYh6KPMwroDXx2PtCAh
	xqb5BS7d+FWi/kg/gcvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peh2P-00DO2R-04;
	Tue, 21 Mar 2023 18:48:49 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peh2L-00DO18-19
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 18:48:47 +0000
Received: by mail-ed1-x52e.google.com with SMTP id w9so63618182edc.3
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=QrW8QLlhXRLLsjP3F+4fhjZ2IV7VEOnnPtdH2kcuNjaRfDJSfySxSopa0Z7evi2/vh
         KzYZQ0l0gdztGMIZz+L+NfeD8ytvURoY+K8KAMU6h0FCLYrEP/O7bEinnhzm8wsuJV9V
         9+n5ef7AaK2xYbe1rb2jSLzCj4TgJ/mN5USyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0ckUw7dWkverm2igg++8Ynt0yEw3mz/3PbETIyN2lM=;
        b=0uKBrPH+FSNQwHhalfXOIRdjoqZ6cDvfIjls5tfcbM5EJnFOB/6lSIZ/26/oNNRtUk
         dcYgyD5OFa+kZbZnTkajyKMT2hrH+FKnDdQBByKtOD4NtPI5QS9U7QbKSaPdTwOacK6R
         yB/Mh7t7ARWhL0P+CjBffEDbum2nvPLpO2MkydHU6FRv8G8nWxllFBAfHWVXNA6GArHs
         YfFqkqXGvjsuQpxWozamak5j9F3v8vrsgYRLtdZA5PYdxVhPoza5UT+sWYk4o+p2G3O/
         EJxhzHylO4rOLYUreOEN/2O19DBp8h3Wd9RJ/f0sFEG8TF3TTnjUv3pPN/oyz8lewcX8
         kkhA==
X-Gm-Message-State: AO0yUKUSRtLIb5Ho3WjnptbI1VETx735OnpcsRu++R8218uu4c0DFPwb
	vWnrHDFAUErJuGtXixDAehvWCbrrDNkGfhMZ/aBY/4rH
X-Google-Smtp-Source: AK7set+t0yVuu8JJm8LWQ1qzdB85Pal4Yk64l3QPYdftduxbVBfQFzRpRomI5t+dKTXtqetdElxnhw==
X-Received: by 2002:a05:6402:7c8:b0:4af:69b8:52af with SMTP id u8-20020a05640207c800b004af69b852afmr4124533edy.24.1679424516257;
        Tue, 21 Mar 2023 11:48:36 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090608cb00b008d0dbf15b8bsm6195659eje.212.2023.03.21.11.48.34
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:48:35 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id eg48so63466360edb.13
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 11:48:34 -0700 (PDT)
X-Received: by 2002:a17:907:9b03:b0:932:da0d:9375 with SMTP id
 kn3-20020a1709079b0300b00932da0d9375mr2409395ejc.4.1679424514115; Tue, 21 Mar
 2023 11:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <2851036.1679417029@warthog.procyon.org.uk>
In-Reply-To: <2851036.1679417029@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Mar 2023 11:48:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Message-ID: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
To: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Bharath SM <bharathsm@microsoft.com>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Steve French <smfrench@gmail.com>, 
	Robbie Harwood <rharwood@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_114845_954177_AC72E0F6 
X-CRM114-Status: GOOD (  11.69  )
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

T24gVHVlLCBNYXIgMjEsIDIwMjMgYXQgOTo0M+KAr0FNIERhdmlkIEhvd2VsbHMgPGRob3dlbGxz
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gICgxKSBGaXggcmVxdWVzdF9rZXkoKSBzbyB0aGF0IGl0
IGRvZXNuJ3QgY2FjaGUgYSBsb29rZWQgdXAga2V5IG9uIHRoZQo+ICAgICAgY3VycmVudCB0aHJl
YWQgaWYgdGhhdCB0aHJlYWQgaXMgYSBrZXJuZWwgdGhyZWFkLiAgVGhlIGNhY2hlIGlzCj4gICAg
ICBjbGVhcmVkIGR1cmluZyBub3RpZnlfcmVzdW1lIC0gYnV0IHRoYXQgZG9lc24ndCBoYXBwZW4g
aW4ga2VybmVsCj4gICAgICB0aHJlYWRzLiAgVGhpcyBpcyBjYXVzaW5nIGNpZnMgRE5TIGtleXMg
dG8gYmUgdW4taW52YWxpZGF0ZWFibGUuCgpJJ3ZlIHB1bGxlZCB0aGlzLCBidXQgSSdkIGxpa2Ug
cGVvcGxlIHRvIGxvb2sgYSBiaXQgbW9yZSBhdCB0aGlzLgoKVGhlIGlzc3VlIHdpdGggVElGX05P
VElGWV9SRVNVTUUgaXMgdGhhdCBpdCBpcyBvbmx5IGRvbmUgb24gcmV0dXJuIHRvCnVzZXIgc3Bh
Y2UuCgpBbmQgdGhlc2UgZGF5cywgUEZfS1RIUkVBRCBpc24ndCB0aGUgb25seSBjYXNlIHRoYXQg
bmV2ZXIgcmV0dXJucyB0bwp1c2VyIHNwYWNlLiBQRl9JT19XT1JLRVIgaGFzIHRoZSBleGFjdCBz
YW1lIGJlaGF2aW91ci4KCk5vdywgdG8gY291bnRlcmFjdCB0aGlzLCBhcyBvZiB0aGlzIG1lcmdl
IHdpbmRvdyAoYW5kIG1hcmtlZCBmb3IKc3RhYmxlKSBJTyB0aHJlYWRzIGRvIGEgZmFrZSAicmV0
dXJuIHRvIHVzZXIgbW9kZSIgaGFuZGxpbmcgaW4KaW9fcnVuX3Rhc2tfd29yaygpLCBhbmQgc28g
SSB0aGluayB3ZSdyZSBhbGwgZ29vZCwgYnV0IEknZCBsaWtlIHBlb3BsZQp0byBhdCBsZWFzdCB0
aGluayBhYm91dCB0aGlzLgoKICAgICAgICAgICAgICBMaW51cwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

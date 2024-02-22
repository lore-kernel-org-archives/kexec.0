Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1ADC48BF6
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 03:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/3EhSOXVNcNX2Vv/2bHYVt0gyiNrhjZ05gKmUZd2sbE=; b=pCcIsx05kPISH2
	gTBcQijj+BaZ+2aZgwoe2xa8EIQykiapzT+PRZB8rlVDhhyPLrRYIpsiqFBAYiDQgqAqTVm3/w8QC
	zKVAR6tZgmn+/ThT/Gz6w7G8VuikxohJkqE8pnAkyTTlZAwrSkyR8n60S1gTSJPlYgdvH6hrTm52D
	JlOwcdg+BXpcx40cFjLeUB3wqAXOZyZSXZTvMQoKj5eCpZDx0w3sVHUrX8dynWCzc9v7EOW76mcU2
	u21r4Ws+lL2A3J4idqaiidOU4UmQLWL5zYThCjmCDMQGOVWy5HnGqqu21dDYHL3DNiwRrhZlIxgCB
	fvz64MB8oAlceuatBrIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rczOV-00000003K2i-0HKB;
	Thu, 22 Feb 2024 03:05:07 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rczON-00000003Jv7-0ahS
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 03:05:00 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33d7b8f563eso1109528f8f.0
        for <kexec@lists.infradead.org>; Wed, 21 Feb 2024 19:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708571097; x=1709175897; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMwUqFBmwZni3nYHGsNufQX82jUOTPamTsIFOmXTch4=;
        b=gr2gZxAbPd2DrXSTEtb5rfwm39N6z1FF0QJh0y92vd/LnJ6FDH+CQ+lQyWfsBgerPA
         r9LTt1AUMdFkMENDDcWcDEZ8mZbn3hpifl4INIXVWeccEGE76Y/1qlWRlzZo6jdgWoH1
         bcbzZ0+uKNO0cAzmOxO7MOc4N/xR2PvkrCYUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571097; x=1709175897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMwUqFBmwZni3nYHGsNufQX82jUOTPamTsIFOmXTch4=;
        b=J17+0fhoP/0JAmqyAf9RdnnDu3xEl/0iWoYF149xpVoTB8dD4o+K27w5CFgHPfHU5L
         xR0rfGrzwO17Ugc7XN8KLdtmkv0VPNcUDHo2ugucWNXBpJMGDUQJTNvFs1uySjuPF5Tt
         gYmsyNZUr5pvz7HS+mxDQvo0lNvhNLls8ZRe5YFipWPJc4vWqi+1qzhUvIeNS7l3pUqg
         Bu70CU4Yt03O2EWeA14MXlXBHhGrWfmmb/R51M6Su6Up6R6dS5WxVYUh8hqIxH/pgWfF
         Q0Z4Cz/Y6c+WIPUkKawCKruXzxvw6Wq7/I/kqjz92R+CGbV4Ei2selFQiq3DGmqIDWAM
         NdSw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYrRW6SK7mDUXily04AnczduwbDm8yh/8QYGB9OwmuCXoqaxDEKvt7qG63mtgwCUU9Q8BoN4fEmakMCXwOzv8IsTOomi/qXaI
X-Gm-Message-State: AOJu0Ywz2C5KXiIWo13r8PPH18NBWNk1GZfTn2+mQejEqJc77FeBaH7t
	F7M7QfjZkBB8nzLRqJpeGxevCYZYrAnVcoJr4VhHincEwDL/SpkvUkxYU/DDTRI=
X-Google-Smtp-Source: AGHT+IEz8G6fU4K+3yNmLXt/7u9L6x1bnOwXtDSfi1M9hATKx/IGbEkXRTuSr1VDr3aYclkncYlvnQ==
X-Received: by 2002:a05:6000:1f0f:b0:33d:5e19:e1f1 with SMTP id bv15-20020a0560001f0f00b0033d5e19e1f1mr7547885wrb.12.1708571097017;
        Wed, 21 Feb 2024 19:04:57 -0800 (PST)
Received: from [192.168.1.10] (host-92-3-248-192.as13285.net. [92.3.248.192])
        by smtp.gmail.com with ESMTPSA id h7-20020a056000000700b0033ce214a97csm18626037wrx.17.2024.02.21.19.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 19:04:56 -0800 (PST)
Message-ID: <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
Date: Thu, 22 Feb 2024 03:04:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com,
 Eric Biggers <ebiggers@kernel.org>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_190459_601280_862B8C26 
X-CRM114-Status: GOOD (  20.72  )
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

T24gMTUvMDIvMjAyNCA4OjE3IGFtLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBXZWQsIDE0
IEZlYiAyMDI0IGF0IDIzOjMxLCBSb3NzIFBoaWxpcHNvbiA8cm9zcy5waGlsaXBzb25Ab3JhY2xl
LmNvbT4gd3JvdGU6Cj4+IEZyb206ICJEYW5pZWwgUC4gU21pdGgiIDxkcHNtaXRoQGFwZXJ0dXNz
b2x1dGlvbnMuY29tPgo+Pgo+PiBUaGUgU0hBIGFsZ29yaXRobXMgYXJlIG5lY2Vzc2FyeSB0byBt
ZWFzdXJlIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24gaW50bwo+PiB0aGUgVFBNIGFzIGVhcmx5
IGFzIHBvc3NpYmxlIGJlZm9yZSB1c2luZyB0aGUgdmFsdWVzLiBUaGlzIGltcGxlbWVudGF0aW9u
Cj4+IHVzZXMgdGhlIGVzdGFibGlzaGVkIGFwcHJvYWNoIG9mICNpbmNsdWRpbmcgdGhlIFNIQSBs
aWJyYXJpZXMgZGlyZWN0bHkgaW4KPj4gdGhlIGNvZGUgc2luY2UgdGhlIGNvbXByZXNzZWQga2Vy
bmVsIGlzIG5vdCB1bmNvbXByZXNzZWQgYXQgdGhpcyBwb2ludC4KPj4KPj4gVGhlIFNIQSBjb2Rl
IGhlcmUgaGFzIGl0cyBvcmlnaW5zIGluIHRoZSBjb2RlIGZyb20gdGhlIG1haW4ga2VybmVsOgo+
Pgo+PiBjb21taXQgYzRkNWI5ZmZhMzFmICgiY3J5cHRvOiBzaGExIC0gaW1wbGVtZW50IGJhc2Ug
bGF5ZXIgZm9yIFNIQS0xIikKPj4KPj4gQSBtb2RpZmllZCB2ZXJzaW9uIG9mIHRoaXMgY29kZSB3
YXMgaW50cm9kdWNlZCB0byB0aGUgbGliL2NyeXB0by9zaGExLmMKPj4gdG8gYnJpbmcgaXQgaW4g
bGluZSB3aXRoIHRoZSBzaGEyNTYgY29kZSBhbmQgYWxsb3cgaXQgdG8gYmUgcHVsbGVkIGludG8g
dGhlCj4+IHNldHVwIGtlcm5lbCBpbiB0aGUgc2FtZSBtYW5uZXIgYXMgc2hhMjU2IGlzLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgUC4gU21pdGggPGRwc21pdGhAYXBlcnR1c3NvbHV0aW9u
cy5jb20+Cj4+IFNpZ25lZC1vZmYtYnk6IFJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBv
cmFjbGUuY29tPgo+IFdlIGhhdmUgaGFkIHNvbWUgZGlzY3Vzc2lvbnMgYWJvdXQgdGhpcywgYW5k
IHlvdSByZWFsbHkgbmVlZCB0bwo+IGNhcHR1cmUgdGhlIGp1c3RpZmljYXRpb24gaW4gdGhlIGNv
bW1pdCBsb2cgZm9yIGludHJvZHVjaW5nIG5ldyBjb2RlCj4gdGhhdCBpbXBsZW1lbnRzIGFuIG9i
c29sZXRlIGFuZCBicm9rZW4gaGFzaGluZyBhbGdvcml0aG0uCj4KPiBTSEEtMSBpcyBicm9rZW4g
YW5kIHNob3VsZCBubyBsb25nZXIgYmUgdXNlZCBmb3IgYW55dGhpbmcuIEludHJvZHVjaW5nCj4g
bmV3IHN1cHBvcnQgZm9yIGEgaGlnaGx5IGNvbXBsZXggYm9vdCBzZWN1cml0eSBmZWF0dXJlLCBh
bmQgdGhlbgo+IHJlbHlpbmcgb24gU0hBLTEgaW4gdGhlIGltcGxlbWVudGF0aW9uIG1ha2VzIHRo
aXMgd2hvbGUgZWZmb3J0IHNlZW0KPiBhbG1vc3QgZnV0aWxlLCAqdW5sZXNzKiB5b3UgcHJvdmlk
ZSBzb21lIHJvY2sgc29saWQgcmVhc29ucyBoZXJlIHdoeQo+IHRoaXMgaXMgc3RpbGwgc2FmZS4K
Pgo+IElmIHRoZSB1cHNob3Qgd291bGQgYmUgdGhhdCBzb21lIHBlb3BsZSBhcmUgc3R1Y2sgd2l0
aCBTSEEtMSBzbyB0aGV5Cj4gd29uJ3QgYmUgYWJsZSB0byB1c2UgdGhpcyBmZWF0dXJlLCB0aGVu
IEknbSBub3QgY29udmluY2VkIHdlIHNob3VsZAo+IG9ic2VzcyBvdmVyIHRoYXQuCgpUbyBiZSBh
YnNvbHV0ZWx5IGNyeXN0YWwgY2xlYXIgaGVyZS4KClRoZSBjaG9pY2Ugb2YgaGFzaCBhbGdvcml0
aG0ocykgYXJlIGRldGVybWluZWQgYnkgdGhlIE9FTSBhbmQgdGhlCnBsYXRmb3JtLCBub3QgYnkg
TGludXguCgpGYWlsaW5nIHRvIChhdCBsZWFzdCkgY2FwIGEgUENSIGluIGEgYmFuayB3aGljaCB0
aGUgT0VNL3BsYXRmb3JtIGxlZnQKYWN0aXZlIGlzIGEgc2VjdXJpdHkgdnVsbmVyYWJpbGl0eS7C
oCBJdCBwZXJtaXRzIHRoZSB1bnNlYWxpbmcgb2Ygc2VjcmV0cwppZiBhbiBhdHRhY2tlciBjYW4g
cmVwbGF5IGEgZ29vZCBzZXQgb2YgbWVhc3VyZW1lbnRzIGludG8gYW4gdW51c2VkIGJhbmsuCgpU
aGUgb25seSB3YXkgdG8gZ2V0IHJpZCBvZiB0aGUgcmVxdWlyZW1lbnQgZm9yIFNIQS0xIGhlcmUg
aXMgdG8gbG9iYnkKdGhlIElIVnMvT0VNcywgb3IgcGVyaGFwcyB0aGUgVENHLCB0byBwcm9kdWNl
L3NwZWMgYSBwbGF0Zm9ybSB3aGVyZSB0aGUKU0hBLTEgYmFua3MgY2FuIGJlIGRpc2FibGVkLsKg
IFRoZXJlIGFyZSBubyBrbm93biBzdWNoIHBsYXRmb3JtcyBpbiB0aGUKbWFya2V0IHRvZGF5LCB0
byB0aGUgYmVzdCBvZiBvdXIga25vd2xlZGdlLgoKfkFuZHJldwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

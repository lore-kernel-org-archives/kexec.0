Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EAEC48BF8
	for <kexec@archiver.kernel.org>; Thu, 22 Feb 2024 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=C+9E1dutxzzC6NJhCQe+zSJmsmD+qO9jy3pyl4/uL1Q=; b=w418hVXD6y3pYi
	Nc3yMmy5kcu6dmdYZX2K6nbTTmiMJtTgT7rxqffsgRUkibAwlENYlKCUtpNxeJIQQlHu6JgOWJW8/
	nIw759WXK5Ye7MOU1ulQ3CwXIBfpee3GEAyN9AB5imwL/FK/npCruYyzSk58Hr9LLx9DwxGSMtH9G
	4SIbpyC257kHZ7DG08b7O9L5pLyGlZHzmCxyov64/vrvuv2UpirjCRUyNLs9BxS+Gi1/o4yvEWwit
	m0LC07jTPXKD61ecU2ednIcosCi9GCZJyRsDiw8IXN/uDdLmU24g816sw5xdGIRUgkSw+SxRLN5hc
	s3Ka/gAK6KEXRK1oE1Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd8E6-00000004qBf-1T3C;
	Thu, 22 Feb 2024 12:30:58 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd8E2-00000004q9w-3Lo6
	for kexec@lists.infradead.org;
	Thu, 22 Feb 2024 12:30:56 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5645efb2942so1348104a12.1
        for <kexec@lists.infradead.org>; Thu, 22 Feb 2024 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1708605052; x=1709209852; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rtMJTU0KaK69D2gKtHaxXyryfBE+awWVy+sf0VRiX1M=;
        b=jVn6zrcBCD0Z5s7Te5PP8n5nF2rJp1yGIVNYuWu9nUeWXqWwFHFJxdJD6e8UaYVUHj
         +63ur9Ap8THcC6+fMZ6WoAszFE8mIdd4TR1p7gG/QU+jKJ5f2Fd33fKw8n9Pfvuq87JO
         JjA5m/w9zyL5reEewPrSGJ5J5d0lSIh2vCAi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708605052; x=1709209852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtMJTU0KaK69D2gKtHaxXyryfBE+awWVy+sf0VRiX1M=;
        b=fkiuZm6gIAl2LfivJxZL+m3e7TOD9+QUYm/PHwgyJt4lXU5Ez619J9KpWFiIsAKmGn
         aWU71BqkT+5+P8N3E5B7iuCw/DQnGGKBFzPJQEkDeEIYfIrOK/qc+fhQwqiL9wEcgGfz
         XBbaxct8Hu958lCRzBT3oHXBAClhB+a88d3xx4fvjyoezMBG8J+ia7m3XO2/qAQ6R4Mq
         vUML3uk1E27SnPGxegUgWAL0TrN6F//LOsQJu0px7T8oAxpBOM4FAy6cZJAjO4mMk4hr
         9fNJkLe3+ClXV58Pa1qegJrG21N8lYMTE7iXhYL4q/yN0r1R9NWKmxWDu0rRuAlfaAtJ
         AEGw==
X-Forwarded-Encrypted: i=1; AJvYcCUj0nLr/lpJ9i9YVYvIIQDwpDWAIpUdGOadCoCtsFI1KBW1EgZrMvyJ9LS7IBhkIn5OmglNZ8pKQYy51DDptVicsAqGVQVpROia
X-Gm-Message-State: AOJu0YwO8npVNzpWnqKg8HpbT4QDiweK+/MlCsufHtcpe0sQLtUGdr2i
	GfldjAuNnqfcn4RPToreO3Cj46wuJocUJbrOFeTKfmCAJbZFIh7fpZ/Fxrsl0q8=
X-Google-Smtp-Source: AGHT+IFPuQzpowOl3k/GPdUR9TfMIP5AhN9fSjb+vcvG0GakAp/U3UXOgAHES4kjT6cIQFre3AyF/w==
X-Received: by 2002:a17:906:2b0e:b0:a3e:8bd8:b711 with SMTP id a14-20020a1709062b0e00b00a3e8bd8b711mr1842289ejg.37.1708605052106;
        Thu, 22 Feb 2024 04:30:52 -0800 (PST)
Received: from [10.80.67.149] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id cw4-20020a170907160400b00a3e45fa1c77sm5071178ejd.55.2024.02.22.04.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 04:30:51 -0800 (PST)
Message-ID: <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
Date: Thu, 22 Feb 2024 12:30:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
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
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240222_043055_205975_B5BE8F32 
X-CRM114-Status: GOOD (  30.56  )
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

T24gMjIvMDIvMjAyNCA5OjM0IGFtLCBBcmQgQmllc2hldXZlbCB3cm90ZToKPiBPbiBUaHUsIDIy
IEZlYiAyMDI0IGF0IDA0OjA1LCBBbmRyZXcgQ29vcGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXgu
Y29tPiB3cm90ZToKPj4gT24gMTUvMDIvMjAyNCA4OjE3IGFtLCBBcmQgQmllc2hldXZlbCB3cm90
ZToKPj4+IE9uIFdlZCwgMTQgRmViIDIwMjQgYXQgMjM6MzEsIFJvc3MgUGhpbGlwc29uIDxyb3Nz
LnBoaWxpcHNvbkBvcmFjbGUuY29tPiB3cm90ZToKPj4+PiBGcm9tOiAiRGFuaWVsIFAuIFNtaXRo
IiA8ZHBzbWl0aEBhcGVydHVzc29sdXRpb25zLmNvbT4KPj4+Pgo+Pj4+IFRoZSBTSEEgYWxnb3Jp
dGhtcyBhcmUgbmVjZXNzYXJ5IHRvIG1lYXN1cmUgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbiBp
bnRvCj4+Pj4gdGhlIFRQTSBhcyBlYXJseSBhcyBwb3NzaWJsZSBiZWZvcmUgdXNpbmcgdGhlIHZh
bHVlcy4gVGhpcyBpbXBsZW1lbnRhdGlvbgo+Pj4+IHVzZXMgdGhlIGVzdGFibGlzaGVkIGFwcHJv
YWNoIG9mICNpbmNsdWRpbmcgdGhlIFNIQSBsaWJyYXJpZXMgZGlyZWN0bHkgaW4KPj4+PiB0aGUg
Y29kZSBzaW5jZSB0aGUgY29tcHJlc3NlZCBrZXJuZWwgaXMgbm90IHVuY29tcHJlc3NlZCBhdCB0
aGlzIHBvaW50Lgo+Pj4+Cj4+Pj4gVGhlIFNIQSBjb2RlIGhlcmUgaGFzIGl0cyBvcmlnaW5zIGlu
IHRoZSBjb2RlIGZyb20gdGhlIG1haW4ga2VybmVsOgo+Pj4+Cj4+Pj4gY29tbWl0IGM0ZDViOWZm
YTMxZiAoImNyeXB0bzogc2hhMSAtIGltcGxlbWVudCBiYXNlIGxheWVyIGZvciBTSEEtMSIpCj4+
Pj4KPj4+PiBBIG1vZGlmaWVkIHZlcnNpb24gb2YgdGhpcyBjb2RlIHdhcyBpbnRyb2R1Y2VkIHRv
IHRoZSBsaWIvY3J5cHRvL3NoYTEuYwo+Pj4+IHRvIGJyaW5nIGl0IGluIGxpbmUgd2l0aCB0aGUg
c2hhMjU2IGNvZGUgYW5kIGFsbG93IGl0IHRvIGJlIHB1bGxlZCBpbnRvIHRoZQo+Pj4+IHNldHVw
IGtlcm5lbCBpbiB0aGUgc2FtZSBtYW5uZXIgYXMgc2hhMjU2IGlzLgo+Pj4+Cj4+Pj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIFAuIFNtaXRoIDxkcHNtaXRoQGFwZXJ0dXNzb2x1dGlvbnMuY29tPgo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFJvc3MgUGhpbGlwc29uIDxyb3NzLnBoaWxpcHNvbkBvcmFjbGUu
Y29tPgo+Pj4gV2UgaGF2ZSBoYWQgc29tZSBkaXNjdXNzaW9ucyBhYm91dCB0aGlzLCBhbmQgeW91
IHJlYWxseSBuZWVkIHRvCj4+PiBjYXB0dXJlIHRoZSBqdXN0aWZpY2F0aW9uIGluIHRoZSBjb21t
aXQgbG9nIGZvciBpbnRyb2R1Y2luZyBuZXcgY29kZQo+Pj4gdGhhdCBpbXBsZW1lbnRzIGFuIG9i
c29sZXRlIGFuZCBicm9rZW4gaGFzaGluZyBhbGdvcml0aG0uCj4+Pgo+Pj4gU0hBLTEgaXMgYnJv
a2VuIGFuZCBzaG91bGQgbm8gbG9uZ2VyIGJlIHVzZWQgZm9yIGFueXRoaW5nLiBJbnRyb2R1Y2lu
Zwo+Pj4gbmV3IHN1cHBvcnQgZm9yIGEgaGlnaGx5IGNvbXBsZXggYm9vdCBzZWN1cml0eSBmZWF0
dXJlLCBhbmQgdGhlbgo+Pj4gcmVseWluZyBvbiBTSEEtMSBpbiB0aGUgaW1wbGVtZW50YXRpb24g
bWFrZXMgdGhpcyB3aG9sZSBlZmZvcnQgc2VlbQo+Pj4gYWxtb3N0IGZ1dGlsZSwgKnVubGVzcyog
eW91IHByb3ZpZGUgc29tZSByb2NrIHNvbGlkIHJlYXNvbnMgaGVyZSB3aHkKPj4+IHRoaXMgaXMg
c3RpbGwgc2FmZS4KPj4+Cj4+PiBJZiB0aGUgdXBzaG90IHdvdWxkIGJlIHRoYXQgc29tZSBwZW9w
bGUgYXJlIHN0dWNrIHdpdGggU0hBLTEgc28gdGhleQo+Pj4gd29uJ3QgYmUgYWJsZSB0byB1c2Ug
dGhpcyBmZWF0dXJlLCB0aGVuIEknbSBub3QgY29udmluY2VkIHdlIHNob3VsZAo+Pj4gb2JzZXNz
IG92ZXIgdGhhdC4KPj4gVG8gYmUgYWJzb2x1dGVseSBjcnlzdGFsIGNsZWFyIGhlcmUuCj4+Cj4+
IFRoZSBjaG9pY2Ugb2YgaGFzaCBhbGdvcml0aG0ocykgYXJlIGRldGVybWluZWQgYnkgdGhlIE9F
TSBhbmQgdGhlCj4+IHBsYXRmb3JtLCBub3QgYnkgTGludXguCj4+Cj4+IEZhaWxpbmcgdG8gKGF0
IGxlYXN0KSBjYXAgYSBQQ1IgaW4gYSBiYW5rIHdoaWNoIHRoZSBPRU0vcGxhdGZvcm0gbGVmdAo+
PiBhY3RpdmUgaXMgYSBzZWN1cml0eSB2dWxuZXJhYmlsaXR5LiAgSXQgcGVybWl0cyB0aGUgdW5z
ZWFsaW5nIG9mIHNlY3JldHMKPj4gaWYgYW4gYXR0YWNrZXIgY2FuIHJlcGxheSBhIGdvb2Qgc2V0
IG9mIG1lYXN1cmVtZW50cyBpbnRvIGFuIHVudXNlZCBiYW5rLgo+Pgo+PiBUaGUgb25seSB3YXkg
dG8gZ2V0IHJpZCBvZiB0aGUgcmVxdWlyZW1lbnQgZm9yIFNIQS0xIGhlcmUgaXMgdG8gbG9iYnkK
Pj4gdGhlIElIVnMvT0VNcywgb3IgcGVyaGFwcyB0aGUgVENHLCB0byBwcm9kdWNlL3NwZWMgYSBw
bGF0Zm9ybSB3aGVyZSB0aGUKPj4gU0hBLTEgYmFua3MgY2FuIGJlIGRpc2FibGVkLiAgVGhlcmUg
YXJlIG5vIGtub3duIHN1Y2ggcGxhdGZvcm1zIGluIHRoZQo+PiBtYXJrZXQgdG9kYXksIHRvIHRo
ZSBiZXN0IG9mIG91ciBrbm93bGVkZ2UuCj4+Cj4gT0ssIHNvIG1haW5saW5lIExpbnV4IGRvZXMg
bm90IHN1cHBvcnQgc2VjdXJlIGxhdW5jaCBhdCBhbGwgdG9kYXkuIEF0Cj4gdGhpcyBwb2ludCwg
d2UgbmVlZCB0byBkZWNpZGUgd2hldGhlciBvciBub3QgdG9tb3Jyb3cncyBtYWlubGluZSBMaW51
eAo+IHdpbGwgc3VwcG9ydCBzZWN1cmUgbGF1bmNoIHdpdGggU0hBMSBvciB3aXRob3V0LCByaWdo
dD8KCkknZCBhcmd1ZSB0aGF0J3MgYSBzbGlnaHRseSB1bmZhaXIgY2hhcmFjdGVyaXNhdGlvbi4K
CldlIHdhbnQgdG9tb3Jyb3cncyBtYWlubGluZSB0byBzdXBwb3J0IFNlY3VyZSBMYXVuY2guwqAg
V2hhdCB0aGF0IGVudGFpbHMKdW5kZXIgdGhlIGhvb2QgaXMgbGFyZ2VseSBvdXRzaWRlIG9mIHRo
ZSBjb250cm9sIG9mIHRoZSBlbmQgdXNlci4KCj4gQW5kIHRoZSBwb2ludCB5b3UgYXJlIG1ha2lu
ZyBoZXJlIGlzIHRoYXQgd2UgbmVlZCBTSEEtMSBub3Qgb25seSB0byBhKQo+IHN1cHBvcnQgc3lz
dGVtcyB0aGF0IGFyZSBvbiBUUE0gMS4yIGFuZCBzdXBwb3J0IG5vdGhpbmcgZWxzZSwgYnV0IGFs
c28KPiB0byBiKSBlbnN1cmUgdGhhdCBjcnlwdG8gYWdpbGUgVFBNIDIuMCB3aXRoIGJvdGggU0hB
LTEgYW5kIFNIQS0yNTYKPiBlbmFibGVkIGNhbiBiZSBzdXBwb3J0ZWQgaW4gYSBzYWZlIG1hbm5l
ciwgd2hpY2ggd291bGQgaW52b2x2ZQo+IG1lYXN1cmluZyBzb21lIHRlcm1pbmF0aW5nIGV2ZW50
IGludG8gdGhlIFNIQS0xIFBDUnMgdG8gZW5zdXJlIHRoZXkKPiBhcmUgbm90IGxlZnQgaW4gYSBk
YW5nbGluZyBzdGF0ZSB0aGF0IG1pZ2h0IGFsbG93IGFuIGFkdmVyc2FyeSB0bwo+IHRyaWNrIHRo
ZSBUUE0gaW50byB1bnNlYWxpbmcgYSBzZWNyZXQgdGhhdCBpdCBzaG91bGRuJ3QuCgpZZXMuwqAg
QWxzbyBjKSBiZWNhdXNlIGlmIHRoZSBlbmQgdXNlciB3YW50cyB0byB1c2UgU0hBLTEsIHRoZXkg
c2hvdWxkIGJlCmFibGUgdG8uCgo+IFNvIGNhbiB3ZSBzdXBwb3J0IGIpIHdpdGhvdXQgYSksIGFu
ZCBpZiBzbywgZG9lcyBtZWFzdXJpbmcgYW4KPiBhcmJpdHJhcnkgZHVtbXkgZXZlbnQgaW50byBh
IFBDUiB0aGF0IGlzIG9ubHkgbWVhbnQgdG8ga2VlcCBzZWFsZWQKPiBmb3JldmVyIHJlYWxseSBy
ZXF1aXJlIGEgU0hBLTEgaW1wbGVtZW50YXRpb24sIG9yIGNvdWxkIHdlIGp1c3QgdXNlIGFuCj4g
YXJiaXRyYXJ5IChub3QgZXZlbiByYW5kb20pIHNlcXVlbmNlIG9mIDE2MCBiaXRzIGFuZCB1c2Ug
dGhhdCBpbnN0ZWFkPwoKYSkgYW5kIGIpIGFyZSBpbiBwcmluY2lwbGUgaW5kZXBlbmRlbnQsIGJ1
dCB3ZSBjYW5ub3Qgc3VwcG9ydCBiKSB3aXRob3V0ClNIQS0xLgoKVG8gY2FwIGEgUENSLCB0aGUg
ZXZlbnQgbG9nIHN0aWxsIG5lZWRzIHRvIGJlIGtlcHQgYWNjdXJhdGUsIGFuZCB0aGF0J3MKYXQg
bGVhc3Qgb25lIFNIQS0xIGNhbGN1bGF0aW9uLsKgIElmIHlvdSB3ZXJlIHRvIHNpbXBseSBleHRl
bmQgYSBkdW1teQp2YWx1ZSwgdGhlIHN5c3RlbSBob3BlZnVsbHkgZmFpbHMgc2FmZSwgYnV0IHRo
ZSB1c2VyIGdldHMgInNvbWV0aGluZwp3ZW50IHdyb25nLCB5b3UncmUgb24geW91ciBvd24iLCBy
YXRoZXIgdGhhbiAid2UgaW50ZW50aW9uYWxseSBibG9ja2VkCnRoZSB1c2Ugb2YgU0hBLTEsIGV2
ZXJ5dGhpbmcgaXMgZ29vZCIuCgpBbmQgZnJhbmtseSwgeW91IG5lZWQgU0hBLTEganVzdCB0byBy
ZWFkIHRoZSBldmVudCBsb2csIGlmIGFueSBjb21wb25lbnQKKGluY2x1ZGluZyBUWFQgaXRzZWxm
KSB3cm90ZSBhIFNIQS0xIGVudHJ5IGludG8gaXQuCgoKVG8gYmUgYmx1bnQuwqAgU0hBLTEgc3Vw
cG9ydCBpcyBub3QgdmlhYmx5IG9wdGlvbmFsIHRvZGF5IGFzIGZhciBhcwpTZWN1cmUgTGF1bmNo
IGlzIGNvbmNlcm5lZC7CoCBJZiB0aGVyZSdzIGEgc3VpdGFibGUgS2NvbmZpZyBzeW1ib2wgdG8g
dXNlCmZvciBwZW9wbGUgd2hvIHdhbnQgYSBjb21wbGV0ZWx5IFNIQS0xLWxlc3Mga2VybmVsLCB0
aGVuIHdlIGNhbiBtYWtlClNlY3VyZSBMYXVuY2ggZGVwZW5kIG9uIHRoYXQgdW50aWwgc3VjaCB0
aW1lIGFzIHRoZSBoYXJkd2FyZSBlY29zeXN0ZW0KaGFzIGNhdWdodCB1cC4KCn5BbmRyZXcKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxp
bmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

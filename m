Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6DAC072A2
	for <kexec@archiver.kernel.org>; Wed, 22 Nov 2023 04:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=arGM4gN2sX0BpZhB8krXDVSujoOd2HOuT4BJVIDikx8=; b=hgr2lp4PTubc5+
	ZJK+sZdLUyBkJ+H26Lz7dbGpmUPsG03fai4cZ22B5K91yYHr25sjOdJKq0T+/mh2J5/5N4UDG8YS+
	mkEZ9PMD6bLUqZMOkADz2jfSAr17XmtZjXHs+UPovQhvLm/U1Y0nVSWmacblX1kt3TxgVBpaTaWCk
	DwOOE3NA1PgaVzh96dIV94z+guWi8eR0IQZWFp+UUVZQHp3Sge8uLnsA0e/tZhtqr61XOlrkKw/Ce
	tSReN5WGDrguqQnywUIL2IqQ10clk++9x9SJ6hhH6S9sUj4czOQ3EcQH7y1VsbIqDGwWwL/U9JOFj
	Ddyt3hveuxDw8k0ocCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5eqC-000czd-39;
	Wed, 22 Nov 2023 04:27:56 +0000
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5eq9-000cyu-27
	for kexec@lists.infradead.org;
	Wed, 22 Nov 2023 04:27:54 +0000
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so5956197276.0
        for <kexec@lists.infradead.org>; Tue, 21 Nov 2023 20:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700627270; x=1701232070; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3GXc1MR1qci8KFPpbyRpmDJsF9XkUr/64nzsBhBKQE=;
        b=YbF8NfcT9Mydf8ibyVpWWy1LlIjjvVdmZp30M0xWJpwWN+vn15fBgmMk0BOycGiPuO
         UjJg6CaQUk4ltP64SRNNzeLyUkBTt1wy0SlApTcmtmCZ2ypdPoRqAj1BADFPPlzTiZof
         eWmHlFezHCYCLhIbecND4d8DMjTt5Jb7a2V7Tbl8RrB5Kh4WOIlqmKR5KtzhDS0gO7Ia
         CAkZmboDukUBJEz8JptQ6ezQPzYzJfLkTXgONWGixBiO9MpjDSgf0oHQPQJKsJOJP9e8
         iBKKmHL5yI6P0MmIJf78dOny2AXQxO18q8uDq1+25skWZJ/1+rx0ts6oq6nu/R5OJOE8
         DKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700627270; x=1701232070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3GXc1MR1qci8KFPpbyRpmDJsF9XkUr/64nzsBhBKQE=;
        b=REQ/gWT2eH4xY9Bv7cfgFw6ZjKC23xSpKZxZdo/3+c9++BOB4rSM1MbCYa9trnEwnY
         dwiNFKGdOHS7xnaRqJpcyvUwnl/adrXmz0PZmvMm0UToq9GPuC/dsZQKMvg+hjnZqvsJ
         N2y1c8PSBWttk5RWCUSsDvpTQJ4LAxuEKLtFz7Xe17e9e1FRT+AqpMenkM1ZNxCMAPMv
         UvXPngr2b7B9TPvietTeaxtYa5rCoy4R7wqxPg6jI99yLSswNXhCJzodz4Nm0VS/zU9W
         11NqEXrUjcwSanN+rPegixok/vhM3zoCnmYmDE0kWgYVxuXv0wi8E3SMxXZiwLH1eDh2
         rH/Q==
X-Gm-Message-State: AOJu0Yx3zwWGKjuwk9n3dViqUmNmCYCTMqnWxSe0+uC7gIoTFVrtFdSF
	xOGi8Ct8scJCVtxZP1Rv+j1up3WW/8YI3u5CBFOE
X-Google-Smtp-Source: AGHT+IHbPWhzmoLy5jBVhS69edGTEagGOf5fM/J56JWvF6UM7o6MptsbEEhZw/TOqOjK/u0Zb59RF3IgUo8M8Pa4T3U=
X-Received: by 2002:a25:186:0:b0:db3:5c00:ac28 with SMTP id
 128-20020a250186000000b00db35c00ac28mr1066663ybb.40.1700627270241; Tue, 21
 Nov 2023 20:27:50 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com> <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 23:27:39 -0500
Message-ID: <CAHC9VhSJ7MKNM7nMXR3xE-cNMrYB4AT+B76wzF1cKy2JM9tBrA@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, 
	Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com, 
	Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, 
	serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Sush Shringarputale <sushring@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_202753_714443_FD071B95 
X-CRM114-Status: GOOD (  23.25  )
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

T24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgNToyOOKAr1BNIFBhdWwgTW9vcmUgPHBhdWxAcGF1bC1t
b29yZS5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgT2N0IDMxLCAyMDIzIGF0IDM6MTXigK9QTSBNaW1p
IFpvaGFyIDx6b2hhckBsaW51eC5pYm0uY29tPiB3cm90ZToKCi4uLgoKPiA+IFVzZXJzcGFjZSBj
YW4gYWxyZWFkeSBleHBvcnQgdGhlIElNQSBtZWFzdXJlbWVudCBsaXN0KHMpIHZpYSB0aGUKPiA+
IHNlY3VyaXR5ZnMge2FzY2lpLGJpbmFyeX1fcnVudGltZV9tZWFzdXJlbWVudHMgZmlsZShzKSBh
bmQgZG8gd2hhdGV2ZXIKPiA+IGl0IHdhbnRzIHdpdGggaXQuICBBbGwgdGhhdCBpcyBtaXNzaW5n
IGluIHRoZSBrZXJuZWwgaXMgdGhlIGFiaWxpdHkgdG8KPiA+IHRyaW0gdGhlIG1lYXN1cmVtZW50
IGxpc3QsIHdoaWNoIGRvZXNuJ3Qgc2VlbSBhbGwgdGhhdCBjb21wbGljYXRlZC4KPgo+IEZyb20g
bXkgcGVyc3BlY3RpdmUgd2hhdCBoYXMgYmVlbiBwcmVzZW50ZWQgaXMgYmFzaWNhbGx5IGp1c3Qg
dHJpbW1pbmcKPiB0aGUgaW4tbWVtb3J5IG1lYXN1cmVtZW50IGxvZywgdGhlIGFkZGl0aW9uYWwg
Y29tcGxleGl0eSAod2hpY2ggcmVhbGx5Cj4gZG9lc24ndCBsb29rIHRoYXQgYmFkIElNTykgaXMg
dGhlcmUgdG8gZW5zdXJlIHJvYnVzdG5lc3MgaW4gdGhlIGZhY2UKPiBvZiBhbiB1bnJlbGlhYmxl
IHVzZXJzcGFjZSAocHJvY2Vzc2VzIGRpZSwgZ2V0IGtpbGxlZCwgZXRjLikgYW5kIHRvCj4gZXN0
YWJsaXNoIGEgbmV3LCB0cmFuc2l0aXZlIHJvb3Qgb2YgdHJ1c3QgaW4gdGhlIG5ld2x5IHRyaW1t
ZWQKPiBpbi1tZW1vcnkgbG9nLgo+Cj4gSSBzdXBwb3NlIG9uZSBjb3VsZCBzaW1wbGlmeSB0aGlu
Z3MgZ3JlYXRseSBieSBoYXZpbmcgYSBkZXNpZ24gd2hlcmUKPiB1c2Vyc3BhY2UgIGNhcHR1cmVz
IHRoZSBtZWFzdXJlbWVudCBsb2cgYW5kIHRoZW4gd3JpdGVzIHRoZSBudW1iZXIgb2YKPiBtZWFz
dXJlbWVudCByZWNvcmRzIHRvIHRyaW0gZnJvbSB0aGUgc3RhcnQgb2YgdGhlIG1lYXN1cmVtZW50
IGxvZyB0byBhCj4gc3lzZnMgZmlsZSBhbmQgdGhlIGtlcm5lbCBhY3RzIG9uIHRoYXQuICBZb3Ug
Y291bGQgZG8gdGhpcyB3aXRoLCBvcgo+IHdpdGhvdXQsIHRoZSBzbmFwc2hvdF9hZ2dyZWdhdGUg
ZW50cnkgY29uY2VwdDsgaW4gZmFjdCB0aGF0IGNvdWxkIGJlCj4gc29tZXRoaW5nIHRoYXQgd2Fz
IGNvbnRyb2xsZWQgYnkgdXNlcnNwYWNlLCBlLmcuIHdyaXRlIHRoZSBudW1iZXIgb2YKPiBsaW5l
cyBhbmQgYSBmbGFnIHRvIGluZGljYXRlIGlmIGEgc25hcHNob3RfYWdncmVnYXRlIHdhcyBkZXNp
cmVkIHRvCj4gdGhlIHN5c2ZzIGZpbGUuICBJIGNhbid0IHNheSBJJ3ZlIHRob3VnaHQgaXQgYWxs
IHRoZSB3YXkgdGhyb3VnaCB0bwo+IG1ha2Ugc3VyZSB0aGVyZSBhcmUgbm8gZ290Y2hhcywgYnV0
IEknbSBndWVzc2luZyB0aGF0IGlzIGFib3V0IGFzCj4gc2ltcGxlIGFzIG9uZSBjYW4gZ2V0Lgo+
Cj4gSWYgdGhlcmUgaXMgc29tZXRoaW5nIGVsc2UgeW91IGhhZCBpbiBtaW5kLCBNaW1pLCBwbGVh
c2Ugc2hhcmUgdGhlCj4gZGV0YWlscy4gIFRoaXMgaXMgYSB2ZXJ5IHJlYWwgcHJvYmxlbSB3ZSBh
cmUgZmFjaW5nIGFuZCB3ZSB3YW50IHRvCj4gd29yayB0byBnZXQgYSBzb2x1dGlvbiB1cHN0cmVh
bS4KCkFueSB0aG91Z2h0cyBvbiB0aGlzIE1pbWk/ICBXZSBoYXZlIGEgcmVhbCBpbnRlcmVzdCBp
biB3b3JraW5nIHdpdGgKeW91IHRvIHNvbHZlIHRoaXMgcHJvYmxlbSB1cHN0cmVhbSwgYnV0IHdl
IG5lZWQgbW9yZSBkZXRhaWxlZCBmZWVkYmFjawp0aGFuICJ0b28gY29tcGxpY2F0ZWQiLiAgSWYg
eW91IGRvbid0IGxpa2UgdGhlIHNvbHV0aW9ucyBwcmVzZW50ZWQKdGh1cyBmYXIsIHdoYXQgdHlw
ZSBvZiBzb2x1dGlvbiB3b3VsZCB5b3UgbGlrZSB0byBzZWU/CgotLSAKcGF1bC1tb29yZS5jb20K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

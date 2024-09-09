Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94147ECE579
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/QVLpvH1mCHZqCBwQ3K9G5ufuubvIgyrq9RTSo0Y63o=; b=u24tVQVfswP2v/
	/KxY71hvrlNjM+b3uvuOFzNy6bLh1IV1RBxYGgGQl9v1AWlC0yv8xzhaYd2qmUHQ4YeGKeX+rz1A+
	b01pBpI3sQnIIxjJGZfDLiqUQqF4czH1LQCVIUpGtbO7Ht6txIjn2dd/MPJIZd2MA8D4UrPRlPuwN
	UsNS26bPEm5D3fgMlGif+RkiJa6C78vRpsmuL3g10hUYJ5sNO1vnO14DK4u/teZlivGpUu0E7R5SC
	wRRBCrQp2GiUmmZyT6W5KSXc+PdlqieXbt4b3U22KqMvelrirddh3ZC4JY97VFIo9Bb9fFU3kD9KG
	FrQOKMsUiUFultKfE3Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sneb6-000000025uw-1xbe;
	Mon, 09 Sep 2024 13:38:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sneb3-000000025sh-3bX6
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 13:38:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725889103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
	b=On0SN7u2tx2zWWMPJ2kjlkYUyFopqaHZ5M+6ZRBIUSVgcSNfX5U0HqNf/TR7WuJ6PPsiWA
	HGkFvQwqQWfXu+6S+pcvk9JEBKfd0vIT5OhXEbZ/8bPT2j7khlMmIGS1u655YPiS081w/c
	4AX5HCrTQzV/mlJ/u6+lpJmkxEIGtTM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576--307rlaMO7ibTSlURUiiQQ-1; Mon, 09 Sep 2024 09:38:22 -0400
X-MC-Unique: -307rlaMO7ibTSlURUiiQQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c359012445so51669786d6.3
        for <kexec@lists.infradead.org>; Mon, 09 Sep 2024 06:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889102; x=1726493902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
        b=pg/jnq/fax1s7cGfLP4+ibrSx7xo1XijCX+dqF9vF6FfgS1XPKiUArKmUrYJo8zO5g
         YIe9WokoZmxQVPsP893v4x4BKBkO4sBbZSjCtFNOOQTdcDfawxDFtfH3eoghxJ2HD6WD
         mJN1235A3m4NN5lRZjK0CWOZ06sZVSa9pkrD7kKzw4wLOlnXyhgGrVNpu269/eGEUnyZ
         oidn1fK9b8KVB1RzUHb88cc2r68PEInVdjE2TIu0WksB109kRmaCfvDB7DFCPLkMtbN3
         HzUr3CLvgU7h8ui4GPh//ujKwKgIe1nzU3dnpz3EqtAMnSfHyw0QSqO/70xGQ5ETZYnn
         ZkNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOKmUph2npO16iY/JPWC0Pb1dwSj8zXbS93NRSdL35+MsuvvBHLxfy8v2jX7vNJKxGmGiMXg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwNVTZ/8oAhbWkY2D80Bmywjtx4/JFhWj9nVDfzyTa8aDpxJsWM
	5sevWqHIAmbNRGnh0kxOdmrFE57IT8EezL1adM6W1JiC1z+bTbEhVHPTKn5dwqEv5gKJQ40ctF+
	QUIke4pl7lFbY3xTyzmdb+VpAfsEPFwqAZ6+KE69t+gCAMyxIOo9H7QuIqg33G4AtLCvovf0OmA
	UAXQyBtDDhzyYh5co4kuNsWqp3KXKS29tH
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id 6a1803df08f44-6c52851da6cmr150547476d6.36.1725889101989;
        Mon, 09 Sep 2024 06:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2sPvjJoZOa9K6fNLHKcOOKgCsR4l1Mq7upihYX1Ngchdx0HTX3QgXPqTS7y1mP0sxXTpLxuUz61lxQFp0FfI=
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id
 6a1803df08f44-6c52851da6cmr150547116d6.36.1725889101648; Mon, 09 Sep 2024
 06:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login> <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
 <ZsyFr8V6yizMiBTw@gardel-login>
In-Reply-To: <ZsyFr8V6yizMiBTw@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 9 Sep 2024 21:38:10 +0800
Message-ID: <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_063825_997029_CB6468C1 
X-CRM114-Status: GOOD (  20.83  )
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

SGkgTGVubmFydCwKCkkgc3BlbnQgc29tZSB0aW1lIHVuZGVyc3RhbmRpbmcgdGhlIHN5c3RlbWQt
cGNybG9jayBhbmQgVFBNIHN0dWZmLCBhbmQKZ290IHNvbWUgaWRlYSBhYm91dCBpdC4gQ291bGQg
eW91IGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nPyBQbGVhc2Ugc2VlCnRoZSBmb2xsb3dpbmcgY29t
bWVudHMgaW5saW5lZC4KCk9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDk6NDDigK9QTSBMZW5uYXJ0
IFBvZXR0ZXJpbmcgPG16eHJlYXJ5QDBwb2ludGVyLmRlPiB3cm90ZToKPgo+IE9uIERvLCAyMi4w
OC4yNCAyMjoyOSwgUGluZ2ZhbiBMaXUgKHBpbGl1QHJlZGhhdC5jb20pIHdyb3RlOgo+Cj4gPiA+
IEhtbSwgSSdkIHJlYWxseSB0aGluayBhYm91dCB0aGlzIHdpdGggc29tZSBwcmlvcml0eS4gVGhl
IG1lYXN1cmVtZW50Cj4gPiA+IHN0dWZmIHNob3VsZCBub3QgYmUgYW4gYWZ0ZXJ0aG91Z2h0LCBp
dCB0eXBpY2FsbHkgaGFzIG1ham9yCj4gPiA+IGltcGxpY2F0aW9ucyBvbiBob3cgeW91IGRlc2ln
biB5b3VyIHRyYW5zaXRpb25zLCBiZWNhdXNlIG1lYXN1cmVtZW50cwo+ID4gPiBvZiBzb21lIGNv
bXBvbmVudCBhbHdheXMgbmVlZCB0byBoYXBwZW4gKmJlZm9yZSogeW91IHBhc3MgY29udHJvbCB0
bwo+ID4gPiBpdCwgb3RoZXJ3aXNlIHRoZXkgYXJlIHBvaW50bGVzcy4KPiA+ID4KPiA+Cj4gPiBB
dCBwcmVzZW50LCBteSBlbXVsYXRvciByZXR1cm5zIGZhbHNlIHRvIGlzX2VmaV9zZWN1cmVfYm9v
dCgpLCBzbwo+ID4gc3lzdGVtZC1zdHViIGRvZXMgbm90IGNhcmUgYWJvdXQgdGhlIG1lYXN1cmVt
ZW50LCBhbmQgbW92ZXMgb24uCj4gPgo+ID4gQ291bGQgeW91IGVubGlnaHRlbiBtZSBhYm91dCBo
b3cgc3lzdGVtZCB1dGlsaXplcyB0aGUgbWVhc3VyZW1lbnQ/IEkKPiA+IGdyZXBwZWQgJ1RQTTJf
UENSX0tFUk5FTF9DT05GSUcnLCBhbmQgc2F3IHRoZSBzeXN0ZW1kLXN0dWIgYXNrcyB0bwo+ID4g
ZXh0ZW5kIFBDUi4gQnV0IHdoZXJlIGlzIHRoZSB2YWx1ZSBjaGVja2VkPyBJIGd1ZXNzIHRoZSBz
eXN0ZW1kIHdpbGwKPiA+IGhhbmcgaWYgdGhlIGNoZWNrIGZhaWxzLgo+Cj4gc3lzdGVtZCdzICJz
eXN0ZW1kLXBjcmxvY2siIHRvb2wgd2lsbCBsb29rIGZvciBtZWFzdXJlbWVudHMgbGlrZSB0aGF0
Cj4gYW5kIGdlbmVyYXRlIGRpc2sgZW5jcnlwdGlvbiBUUE0gcG9saWNpZXMgZnJvbSB0aGF0Lgo+
CgpCZWZvcmUga2V4ZWMgcmVib290cyB0byB0aGUgbmV3IGtlcm5lbApzeXN0ZW1kLXBjcmxvY2sg
Y2FuIHByZWRpY3QgdGhlIGV4cGVjdGVkIFBDUiB2YWx1ZSBhbmQgc3RvcmUgaXQgaW4gdGhlCmZp
bGUgc3lzdGVtLgpPbmUgdGhpbmcgc2hvdWxkIGJlIG5vdGljZWQgaXMgdGhhdCBQQ1IgdmFsdWUg
Y2FuIG5vdCBiZSBhZmZlY3RlZC4KCkFuZCBrZXhlYyByZWJvb3RpbmcgaGFwcGVucy4gc3lzdGVt
ZC1zdHViIGV4dGVuZHMgdGhlIFBDUiB2YWx1ZS4gV2hlbgp0aGUgc3lzdGVtIGlzIHVwLCBzeXN0
ZW1kIGNoZWNrcyB0aGUgcmVhbCBQQ1IgdmFsdWUgYWdhaW5zdCB0aGUKZXhwZWN0ZWQgdmFsdWUg
cmVuZGVyZWQgYnkgc3lzdGVtZC1wY3Jsb2NrPyBJZiBtYXRjaGluZywgYWxsIHJlbGF0ZWQKcG9s
aWNpZXMgc3VjY2VlZC4KCkRvIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHk/CgpUaGFua3MsCgpQaW5n
ZmFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

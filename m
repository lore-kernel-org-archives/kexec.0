Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75723C531DF
	for <kexec@archiver.kernel.org>; Thu, 22 Aug 2024 06:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RVIAzqbK8L+jSGPxZoMYcfp5gSxnGLssz2pJW+hy9Cw=; b=Q81OMTXXMdOExI
	jcI9t2VDoWHrW6NVEe8gGFcYmwaDtF7G49UVT1441X7NnsewogakjrWBSX05hy31Q7nWfHaE2jIlJ
	L1gySkR57V8Ln+TxDj2S07d759QT/+USHmjNWyM+N+DbHjHdyMQe9eRiQx7qyPNBH0ZN3OCDbIKHo
	zHyCH7mOoJ6miCS6hcRXKzviXW3LhERyW8Owl/JDRkiljAytmraF3qPqsoIcxYdKSYnR2qRGZ2827
	oUzdeXKxLPZ2qeX7ss7+VbL4B4qo8toSnGjkkJghjPR4CkIzqeFtkRFVYFMsMjSsmG10vnlLW5h3X
	YIiD7QAs5JIQMGoi07MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh189-0000000BYvD-1Yyb;
	Thu, 22 Aug 2024 06:17:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh187-0000000BYul-0xpX
	for kexec@bombadil.infradead.org;
	Thu, 22 Aug 2024 06:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=; b=mYiA0IxXSmYt3OhqSJ8WYDknwg
	633IDQlzZ8o9gCk+NfkG91p+frTfZ7j0Z4R7/Bv1X5+z5KMrSZcVeiyGLwoAxzLk6JgiRA4ce+Sua
	FaaKwoW4xAyOIPzUnak35yWnKDqVGwjvOrgn0bC0IwMcK8G0uUROtgMnbZvBIwanj4F/UdxoRA08J
	5drSg9XcI/GRqAeWLptryp2IFT2JgZe/RfVRGp+uNxkbJvYxUJcfU5ctFUHuTSBGw/m1o+KqjWNmA
	4nVIoQG2GmVJgk5I7rWDmOG0N7v6tU270otmGFs4fN+HeZhrzumv8iVdjWTKXLVcMCPf0jL9qRkzm
	50q59gzQ==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh17v-00000009rfH-431b
	for kexec@lists.infradead.org;
	Thu, 22 Aug 2024 06:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724307404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
	b=DTVFDdgTjkEfCiZLmpEsAYMptM2fVaqLfTTB2+JXEhRJfnzB4cVORF3GRAjRPA1y+WHHUm
	6jq6G945SbpBoVDxIi9SC5g0PhytJjiNYR4PzI802Om9XVYeBqZJm6oglHoWdBO8Dt4XDx
	zhkwXU+B7Q9njHeaFKA6LqcWfU4wdiw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724307411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
	b=TfeQ2Y2mbX6z119BXCvMqJvy7XMp486lBJiBcpSjKEPZcSv//TUhEm3l4+V1RtCqGLcvcd
	slm6gD4NzAmhwEexdaTVQ3gYroYiiWb37YDmaMZMqrHON8KOAuiThwcHSH2sJPO8TO1MJM
	wrxbzmU3a9WTJjmXxJEJg72wxxlM5ho=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-Hi7Jg-d8NtijbU3VgmTlGw-1; Thu, 22 Aug 2024 02:16:42 -0400
X-MC-Unique: Hi7Jg-d8NtijbU3VgmTlGw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d465cd6ccso4945605ab.1
        for <kexec@lists.infradead.org>; Wed, 21 Aug 2024 23:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307401; x=1724912201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSahsupX5qbmfW5OFxsv4IPaJH74ypJqJsCg65c2Ydw=;
        b=nnq39W09+Yg9B/IaYpbLFhxED3mqKg9tfjL7T6ItnM2rqOKRnnGu+yiRnY5Ww4YEak
         T8dL5BW1b9tFLtlXyuKOIeadZleFfsoz+FyiRjjR3LeKhZIdjiZaTam3bbTW/TFucsVb
         BH0UmVV1UyVbB2DDP8Bmpv+OKt7x5H7CmXs/nNAYs4g7AW/6t+iIs2O4fs/ciw37LsI4
         l6U3jHao0ioOXp2xoct22nflxV4JgzkBSQ2u3oWHDyc/WDqyS9si8VKfMOypy7Ad65Go
         S1AxstvUUXghJwFf3GQKlsp1rf3pZkbjIVxu9tB/fwaX7xuLV7xpdI8hf6HFpIaPN1RB
         ZdyA==
X-Forwarded-Encrypted: i=1; AJvYcCX4QuQ0L8Pzp/zXZvmwtd32JXnWxZkarneun3ae8WmOsD5oJp8iwwtSQb9sXLu39T8RDq+awg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0Z5Vi1U47s1nNxD7kJlfAAaXuvgrimZiJeugULvaZ2gy+IMis
	+6f92AcP14QTsXN+PgMyrXqkke0IRdPIEGARhy54kvYq5Xt6MyMthoB9C1DiL5XGsC3xRTpcLZQ
	evO0Vj7UcwhZuUSh+VXsv3I1X8s9qLqGvKiQveW/BduoMKeUjD41EOkLuF7lCzioPZbUQx/2maH
	L/tHUTxqpRUEQlbyBsm8z5myL+NxqDxzsD
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id e9e14a558f8ab-39d6c38a977mr47438585ab.16.1724307401345;
        Wed, 21 Aug 2024 23:16:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH45XUtslNPtqySBkEnjHv7Gr46zrLG1FE2KFfoX7jWbSc0uq7wXAjET+a9wR5jjhVYDVE5eNfqaZtKRehaTE8=
X-Received: by 2002:a92:b745:0:b0:39b:3b8f:d181 with SMTP id
 e9e14a558f8ab-39d6c38a977mr47438355ab.16.1724307400980; Wed, 21 Aug 2024
 23:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
In-Reply-To: <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 14:16:52 +0800
Message-ID: <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Pingfan Liu <piliu@redhat.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_071656_792386_796055FE 
X-CRM114-Status: GOOD (  23.61  )
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

T24gVGh1LCAyMiBBdWcgMjAyNCBhdCAxMzo0MiwgUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gV2VkLCBBdWcgMjEsIDIwMjQgYXQgMTA6MjfigK9QTSBMZW5uYXJ0
IFBvZXR0ZXJpbmcKPiA8bXp4cmVhcnlAMHBvaW50ZXIuZGU+IHdyb3RlOgo+ID4KPiA+IE9uIE1v
LCAxOS4wOC4yNCAyMjo1MywgUGluZ2ZhbiBMaXUgKHBpbGl1QHJlZGhhdC5jb20pIHdyb3RlOgo+
ID4KPiA+ID4gKioqIEJhY2tncm91bmQgKioqCj4gPiA+Cj4gPiA+IEFzIG1vcmUgUEUgZm9ybWF0
IGtlcm5lbCBpbWFnZXMgYXJlIGludHJvZHVjZWQsIGl0IHBvc3QgY2hhbGxlbmdlIHRvIGtleGVj
IHRvCj4gPiA+IGNvcGUgd2l0aCB0aGUgbmV3IGZvcm1hdC4KPiA+ID4KPiA+ID4gSW4gbXkgYXR0
ZW1wdCB0byBhZGQgc3VwcG9ydCBmb3IgYXJtNjQgemJvb3QgaW1hZ2UgaW4gdGhlIGtlcm5lbCBb
MV0sCj4gPiA+IEFyZCBzdWdnZXN0ZWQgdXNpbmcgYW4gZW11bGF0b3IgdG8gdGFja2xlIHRoaXMg
aXNzdWUuICBMYXN0IHllYXIsIHdoZW4KPiA+ID4gSmFuIHRyaWVkIHRvIGludHJvZHVjZSBVS0kg
c3VwcG9ydCBpbiB0aGUga2VybmVsIFsyXSwgQXJkIG1lbnRpb25lZCB0aGUKPiA+ID4gZW11bGF0
b3IgYXBwcm9hY2ggYWdhaW4gWzNdCj4gPgo+ID4gSG1tLCBzeXN0ZW1kJ3Mgc3lzdGVtZC1zdHVi
IGNvZGUgdHJpZXMgdG8gbG9hZCBjZXJ0YWluICJzaWRlLWNhciIKPiA+IGZpbGVzIHBsYWNlZCBu
ZXh0IHRvIHRoZSBVS0ksIHZpYSB0aGUgVUVGSSBmaWxlIHN5c3RlbSBBUElzLiBXaGF0J3MKPiA+
IHlvdXIgaW50ZW50aW9uIHdpdGggdGhlIFVFRkkgZW11bGF0b3IgcmVnYXJkaW5nIHRoYXQ/IFRo
ZSBzaWRlY2FycyBhcmUKPiA+IHNvbWV3aGF0IGltcG9ydGFudCwgYmVjYXVzZSB0aGF0J3MgaG93
IHdlIHBhcmFtZXRlcml6ZSBvdGhlcndpc2UKPiA+IHN0cmljdGx5IHNlYWxlZCwgaW1tdXRhYmxl
IFVLSXMuCj4gPgo+IElJVUMsIHlvdSBhcmUgcmVmZXJyaW5nIHRvIFVLSSBhZGRvbnMuCj4KPiA+
IEhlbmNlLCB3aGF0J3MgdGhlIHN0b3J5IHRoZXJlPyBpbXBsZW1lbnQgc29tZSBmb3JtIG9mIGZz
IGRyaXZlciAoZm9yCj4gPiB3aGF0IGZzIHByZWNpc2VseT8pIGluIHRoZSBlbXVsYXRvciB0b28/
Cj4gPgo+IEFzIGZvciBhZGRvbiwgdGhhdCBpcyBhIG1pc3NpbmcgcGFydCBpbiB0aGlzIHNlcmll
cy4gSSBoYXZlIG92ZXJsb29rZWQKPiB0aGlzIGlzc3VlLiBPcmlnaW5hbGx5LCBJIHRob3VnaHQg
dGhhdCB0aGVyZSB3YXMgbm8gbmVlZCB0byBpbXBsZW1lbnQKPiBhIGRpc2sgZHJpdmVyIGFuZCB2
ZmF0IGZpbGUgc3lzdGVtLCBqdXN0IHByZWxvYWQgdGhlbSBpbnRvIG1lbW9yeSwgYW5kCj4gZmlu
YWxseSBwcmVzZW50IHRoZW0gdGhyb3VnaCB0aGUgdWVmaSBBUEkuIEkgd2lsbCB0YWtlIGEgY2xv
c2VyIGxvb2sKPiBhdCBpdCBhbmQgY2hldyBvbiBpdC4KPgoKSGkgUGluZ2ZhbiwKCklmIG1vcmUg
YW5kIG1vcmUgc3R1ZmYgbmVlZHMgY29taW5nIGluLCAgbm90IG9ubHkgdGhlIGxpbWl0ZWQgYm9v
dApzZXJ2aWNlcyB0aGVuIGl0IHdpbGwgYmUgd2F5IHRvbyBjb21wbGljYXRlZCBhbmQgaGFyZCB0
byBtYWludGFpbiBhbmQKZGVidWcsICBhbHNvIHRoZSB0d28ga2V4ZWMgY29kZSBwYXRocyBhcmUg
ZHVwbGljYXRlZCBzb21laG93LiBJdCBpcwpyZWFsbHkgYmFkLi4KCkkgZm9yZ290IHdoeSB3ZSBj
YW4gbm90IGp1c3QgZXh0cmFjdCB0aGUga2VybmVsIGZyb20gVUtJIGFuZCB0aGVuIGxvYWQKaXQg
ZGlyZWN0bHksICBpZiB0aGUgZW1iZWRkZWQga2VybmVsIGlzIGFsc28gc2lnbmVkIGl0IHNob3Vs
ZCBiZSBnb29kPwoKVGhhbmtzCkRhdmUKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

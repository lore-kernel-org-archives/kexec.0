Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6AEC4167B
	for <kexec@archiver.kernel.org>; Tue, 28 Nov 2023 01:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zKo0ifuTTWpEtR+wjfZ5+gkGJEOqXEKO0lsW3n+jmXQ=; b=0R7gspmQbm0IOK
	97tvZ46ml87xf4bzLeNBUHAlQ0YtLyxb/hqG5uDbubtme94wHQvot5roAJegLTVO7GR9d2gMX6QIC
	+jr70RHZ4uhHyXXxKO87i9k6I+xrSOvrZXapvRi8kuTwp3AeJMOQV9y8hNPtt5HSlfUdIWJ/qwc+L
	VqmRhIal/kyIZK6tWnVbAQ1AeaAEmlv6jfm02pTNO617Cu3Co8N5jThzqyTkBb+RSGy6lOnqzMfDV
	8Ceeb5DCItCjWw0sfaHv0tDrWK5tIyqANViw7BP1aVVsvM3aywdv46Hk9smeUrRN5gnf33yDjPhLm
	DY7dx5N3y3PK+0K5KE6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7mf5-003nfu-0d;
	Tue, 28 Nov 2023 01:13:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7mf2-003nfV-0j
	for kexec@lists.infradead.org;
	Tue, 28 Nov 2023 01:13:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701133989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0GYsTvHILUE5bHf9jrteKEji3a+vWsZWsBd4N08Nob8=;
	b=BOYm5SXDFAn1r4ksOkm9xkgsC0AaY/238eX4FtxuRFLlIpVooXnyhYcZwbEiUvfzLEcb7j
	rCFGomWy/hQ5mKMevDu0O+9BzvROQTiW+wqq2R4Ktvm0Riy86YH+kfA1WY1aeCBnJ5n4dk
	wl5K3pxq0Ri5cVD4uejaSiZZa4R+1BM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-Av3jyc44M6aDe2UZ0_7Gbw-1; Mon, 27 Nov 2023 20:13:05 -0500
X-MC-Unique: Av3jyc44M6aDe2UZ0_7Gbw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54b17cf3dcfso1644510a12.1
        for <kexec@lists.infradead.org>; Mon, 27 Nov 2023 17:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701133984; x=1701738784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GYsTvHILUE5bHf9jrteKEji3a+vWsZWsBd4N08Nob8=;
        b=nnX4KomU5HxJsyd+2i+3IZLX5zzh1GvZSvdsASlNcB6TWaYdogkg/nAbC1blOIF504
         co26kjtaOwaIoJ4yiVrUCYOPKJ0cYQwW4ZIEPhNEWn/FijoIsNNu8nc07eRFyH32DSM9
         x7N7ooo9yitmcgJsMhjkHW8oPNaxXK5kdP3Pi0WuUBaFCG8osNWvseN54Z54V9feFMoA
         kRgraCHUrkxF1TMIuXALOWcXRxQJNzLe2Awx2M5xOAxjS4XP23wHgNZ3K0ZnlwZWcTsh
         vtSAkXHFQ+6SDdneav0/Tb9nLEe81cjFp7aDKBRFn7QhRhRjO4ER8FZ3PtHGKGg/UZZP
         cuwA==
X-Gm-Message-State: AOJu0YyMRrx7HN9q719OWKvZliOV1cQ911BN9NdhBnhnGH+J6Msam6ab
	ghH6pC5bwJiLX/NUxvJ4hvgiB0jINh30xSyElDuiVHnzfrU+iFP7lUqIRI7c4kSxDRM80oH7NNP
	r/s3jR6TI5tK67FkxYIdTHRZyqrwoQ7LayqBR
X-Received: by 2002:a05:6402:2207:b0:54b:25e8:c009 with SMTP id cq7-20020a056402220700b0054b25e8c009mr5995540edb.0.1701133984408;
        Mon, 27 Nov 2023 17:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUqnXKYGGxsFvT8AZxKn2jiFS3BNX4VIv1K+twolV2C+MWmInyK2s0g5oqXOtZg/+VjKhtXpumHBxcw6dCMtQ=
X-Received: by 2002:a05:6402:2207:b0:54b:25e8:c009 with SMTP id
 cq7-20020a056402220700b0054b25e8c009mr5995533edb.0.1701133984173; Mon, 27 Nov
 2023 17:13:04 -0800 (PST)
MIME-Version: 1.0
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz> <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
In-Reply-To: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 28 Nov 2023 09:12:28 +0800
Message-ID: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
To: Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mhocko@suse.cz
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_171312_365564_CD4BBC0F 
X-CRM114-Status: GOOD (  22.40  )
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

SGkgSmlyaSwKCk9uIFN1biwgTm92IDI2LCAyMDIzIGF0IDU6MjLigK9BTSBKaXJpIEJvaGFjIDxq
Ym9oYWNAc3VzZS5jej4gd3JvdGU6Cj4KPiBIaSBUYW8sCj4KPiBPbiBTYXQsIE5vdiAyNSwgMjAy
MyBhdCAwOTo1MTo1NEFNICswODAwLCBUYW8gTGl1IHdyb3RlOgo+ID4gVGhhbmtzIGZvciB0aGUg
aWRlYSBvZiB1c2luZyBDTUEgYXMgcGFydCBvZiBtZW1vcnkgZm9yIHRoZSAybmQga2VybmVsLgo+
ID4gSG93ZXZlciBJIGhhdmUgYSBxdWVzdGlvbjoKPiA+Cj4gPiBXaGF0IGlmIHRoZXJlIGlzIG9u
LWdvaW5nIERNQS9SRE1BIGFjY2VzcyBvbiB0aGUgQ01BIHJhbmdlIHdoZW4gMXN0Cj4gPiBrZXJu
ZWwgY3Jhc2g/IFRoZXJlIG1pZ2h0IGJlIGRhdGEgY29ycnVwdGlvbiB3aGVuIDJuZCBrZXJuZWwg
YW5kCj4gPiBETUEvUkRNQSB3cml0ZSB0byB0aGUgc2FtZSBwbGFjZSwgaG93IHRvIGFkZHJlc3Mg
c3VjaCBhbiBpc3N1ZT8KPgo+IFRoZSBjcmFzaCBrZXJuZWwgQ01BIGFyZWEocykgcmVnaXN0ZXJl
ZCB2aWEKPiBjbWFfZGVjbGFyZV9jb250aWd1b3VzKCkgYXJlIGRpc3RpbmN0IGZyb20gdGhlCj4g
ZG1hX2NvbnRpZ3VvdXNfZGVmYXVsdF9hcmVhIG9yIGRldmljZS1zcGVjaWZpYyBDTUEgYXJlYXMg
dGhhdAo+IGRtYV9hbGxvY19jb250aWd1b3VzKCkgd291bGQgdXNlIHRvIHJlc2VydmUgbWVtb3J5
IGZvciBETUEuCj4KPiBLZXJuZWwgcGFnZXMgd2lsbCBub3QgYmUgYWxsb2NhdGVkIGZyb20gdGhl
IGNyYXNoIGtlcm5lbCBDTUEKPiBhcmVhKHMpLCBiZWNhdXNlIHRoZXkgYXJlIG5vdCBHRlBfTU9W
QUJMRS4gVGhlIENNQSBhcmVhIHdpbGwgb25seQo+IGJlIHVzZWQgZm9yIHVzZXIgcGFnZXMuCj4K
PiBVc2VyIHBhZ2VzIGZvciBSRE1BLCBzaG91bGQgYmUgcGlubmVkIHdpdGggRk9MTF9MT05HVEVS
TSBhbmQgdGhhdAo+IHdvdWxkIG1pZ3JhdGUgdGhlbSBhd2F5IGZyb20gdGhlIENNQSBhcmVhLgo+
Cj4gQnV0IHlvdSdyZSByaWdodCB0aGF0IERNQSB0byB1c2VyIHBhZ2VzIHBpbm5lZCB3aXRob3V0
Cj4gRk9MTF9MT05HVEVSTSB3b3VsZCBzdGlsbCBiZSBwb3NzaWJsZS4gV291bGQgdGhpcyBiZSBh
IHByb2JsZW0gaW4KPiBwcmFjdGljZT8gRG8geW91IHNlZSBhbnkgd2F5IGFyb3VuZCBpdD8KPgoK
VGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24hIFNvcnJ5IEkgZG9uJ3QgaGF2ZSBhbnkgaWRlYXMg
c28gZmFyLi4uCgpAUGluZ2ZhbiBMaXUgQEJhb3F1YW4gSGUgSGksIGRvIHlvdSBoYXZlIGFueSBz
dWdnZXN0aW9ucyBmb3IgaXQ/CgpUaGFua3MsClRhbyBMaXUKCj4gVGhhbmtzLAo+Cj4gLS0KPiBK
aXJpIEJvaGFjIDxqYm9oYWNAc3VzZS5jej4KPiBTVVNFIExhYnMsIFByYWd1ZSwgQ3plY2hpYQo+
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

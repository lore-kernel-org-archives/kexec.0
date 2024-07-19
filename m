Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E024C3DA5D
	for <kexec@archiver.kernel.org>; Fri, 19 Jul 2024 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fj+Use7U7S1MXy630S8cb7AZCp3pAxg0gMizrqm2hyE=; b=CFAb18+JQix4pY
	jE64P4MVx8UXVQOE0qGMOYMj/9dtQxfS6dOPXhRcKscU/2CM6WEbS3+S/aard9M+9VdIf83SBqV5+
	BR238K+op4YkRfqa+0Ze7NQ6fDmGbHUUAZpvcUsAXvfl4H4Jn1rS86aQNHSP0JkBMz2/bXCXRm2TC
	1ZQuHk8lSayRLY4EQBbex463GrLpqz9QGzWZ6TDM4jN5YstLNmFy2uPZgsk2f5Z2Qo5Rudu97n/Ya
	p4Sd928He8JPMzSXVIROA6axbKV6gDWfdAhp/Xzc8UzTuOcBWlDNsJP0V4MGXQrfe3rByT5IEhI1V
	8CoHauytZzhBa5sNDjeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUntY-00000002oTw-0xJB;
	Fri, 19 Jul 2024 13:43:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUntA-00000002oPS-21o6
	for kexec@lists.infradead.org;
	Fri, 19 Jul 2024 13:43:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721396590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IakiRcZ7C7l0Ak0AGxFsoFeCcbQD2eaZffNe6UfOOc=;
	b=DHFQ8UtTmp5ZiXbqBHcT7VowYwgEKyw4UcoxWIbIj6xWg82bj6uDY2V7n+hCxs01zVBGEt
	Tq+sBM1rc/KR7larJbYkrcKZR1luM3PzI5n8c3NyAz3YeBz14dKURNwizINlGtPtrZR+J8
	oakM/iTgwvQ03nWicY2hTyiJ5ZGI3vQ=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-1HwVAQDpOiaAUo888TZNmA-1; Fri, 19 Jul 2024 09:43:07 -0400
X-MC-Unique: 1HwVAQDpOiaAUo888TZNmA-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5c41e975e5aso1435919eaf.0
        for <kexec@lists.infradead.org>; Fri, 19 Jul 2024 06:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721396586; x=1722001386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IakiRcZ7C7l0Ak0AGxFsoFeCcbQD2eaZffNe6UfOOc=;
        b=YJZfvRMsmhVdRdV2A2oMPJdqxPRsgZVnToVPuQADoozQFnwqofrjmYlZ6cqxkY1L26
         jkmxU1NwOdEbeiKbFAz74lAcMKPkT/b0Iae45m+f6pLwbPIY1QV5RP0mUVPHSfolcBjG
         HNRcBh/bC0FTelcw2c2ofXjwRjCB7nInZOoLeEq40D34FVuKQO2enQT/LxqnsEWNqVoG
         a8FedK53h9LFb6HT9luWzC0uhGKahnj35e50qmzx7rIz2BFRqqxSiPn2kKeOxn37Fzzz
         ajRLKSsV75prkF6m0qe3gupZ1q7BkcrlXZn71GqYH1n4sGF7v3oX89IMVdQOPjjDHKhC
         O9+g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZxA3tkhFJeNCzyxkkYlNBN931yfDzTLVeCNMmKbFIrob8l3lO5zW+p6rVzc9+ocTb4wxDDkkumxnPedLYUfPvMRAFUWmOave
X-Gm-Message-State: AOJu0Yx+jkXDWEjKcmKNAqaC96l+lFgF1JS09u2YW5L9RKv82Pqq4s32
	L0h5tc0h/YvmR59kahE7Fj+ocmKWiKyqZtZWVu971c2gIuItpPw9ypqum+lAreKdDW7vSSFJFTs
	BLTdzuU5HnYINsxExOJ3uUEr19AxWreYWG4A08+DGTtj9fP0ZFGdlNKWcfIW5KW5DoB8Qi4/Loj
	WR9dQUJU34gwGHljD4gK5dEarpLjW/Y0YA
X-Received: by 2002:a4a:ee87:0:b0:5cc:a794:9ea7 with SMTP id 006d021491bc7-5d41cfc7af8mr9563035eaf.7.1721396586267;
        Fri, 19 Jul 2024 06:43:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CqkuClfsIUT1cL15pknD6fqtWtDqVDGYIscNJYbIpCqatUxM/gflq7La1BcA7ccVV1q/Y6Yj31pzH0VYK40=
X-Received: by 2002:a4a:ee87:0:b0:5cc:a794:9ea7 with SMTP id
 006d021491bc7-5d41cfc7af8mr9563016eaf.7.1721396585951; Fri, 19 Jul 2024
 06:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240718085759.13247-1-piliu@redhat.com> <20240718085759.13247-2-piliu@redhat.com>
 <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
In-Reply-To: <8c82c558556750751780a9d2b3a50ca548f565e8.camel@kernel.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 19 Jul 2024 21:42:55 +0800
Message-ID: <CAF+s44Sbkbv9ivB0h+1_Xmd5O0bL3Hmsk1s4-PinELurNFb5Yw@mail.gmail.com>
Subject: Re: [RFC 1/7] efi/libstub: Ask efi_random_alloc() to skip unusable memory
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_064312_623726_3F3ECA8D 
X-CRM114-Status: GOOD (  21.35  )
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

T24gRnJpLCBKdWwgMTksIDIwMjQgYXQgMToyMOKAr0FNIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4gT24gVGh1LCAyMDI0LTA3LTE4IGF0IDE2OjU3ICswODAw
LCBQaW5nZmFuIExpdSB3cm90ZToKPiA+IGVmaV9yYW5kb21fYWxsb2MoKSBkZW1hbmRzIEVGSV9B
TExPQ0FURV9BRERSRVNTIHdoZW4gYWxsb2NhdGVfcGFnZXMoKSwKPiA+IGJ1dCB0aGUgY3VycmVu
dCBpbXBsZW1lbnQgY2FuIG5vdCBlbnN1cmUgdGhlIHNlbGVjdGVkIHRhcmdldCBsb2NhdGVzCj4g
PiBpbnNpZGUgZnJlZSBhcmVhLCB0aGF0IGlzIHRvIGV4Y2x1ZGUgRUZJX0JPT1RfU0VSVklDRVNf
KiwKPiA+IEVGSV9SVU5USU1FX1NFUlZJQ0VTXyogZXRjLgo+ID4KPiA+IEZpeCB0aGUgaXNzdWUg
YnkgY2hlY2tpbmcgbWQtPnR5cGUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogUGluZ2ZhbiBMaXUg
PHBpbGl1QHJlZGhhdC5jb20+Cj4gPiBDYzogQXJkIEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9y
Zz4KPiA+IENjOiBKYW4gSGVuZHJpayBGYXJyIDxrZXJuZWxAamZhcnIuY2M+Cj4gPiBDYzogUGhp
bGlwcCBSdWRvIDxwcnVkb0ByZWRoYXQuY29tPgo+ID4gQ2M6IExlbm5hcnQgUG9ldHRlcmluZyA8
bXp4cmVhcnlAMHBvaW50ZXIuZGU+Cj4gPiBDYzogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2Vy
bmVsLm9yZz4KPiA+IENjOiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiA+IENjOiBEYXZl
IFlvdW5nIDxkeW91bmdAcmVkaGF0LmNvbT4KPiA+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0
bGFuZEBhcm0uY29tPgo+ID4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Cj4gPiBD
YzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4KPiA+IFRvOiBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKPiA+IFRvOiBrZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCj4gPiBUbzogbGludXgtZWZpQHZnZXIua2VybmVsLm9yZwo+Cj4gSSdtIG9uIGhv
bGlkYXkgdXAgdW50aWwgZW5kIG9mIG5leHQgd2VlayBzbyBub3QgZ29pbmcgdG8gZ28gdGhpcyB0
cm91Z2gKPiByaWdodCBub3cgYnV0IEkgaGF2ZSBtaW5vciBjb21wbGFpbiA7LSkKPgo+IFBsZWFz
ZSB1c2U6Cj4KPiAgICAgICAgLS1bbm8tXWNjLWNvdmVyCj4gICAgICAgICAgICBJZiB0aGlzIGlz
IHNldCwgZW1haWxzIGZvdW5kIGluIENjOiBoZWFkZXJzIGluIHRoZSBmaXJzdCBwYXRjaCBvZiB0
aGUgc2VyaWVzICh0eXBpY2FsbHkKPiAgICAgICAgICAgIHRoZSBjb3ZlciBsZXR0ZXIpIGFyZSBh
ZGRlZCB0byB0aGUgY2MgbGlzdCBmb3IgZWFjaCBlbWFpbCBzZXQuIERlZmF1bHQgaXMgdGhlIHZh
bHVlIG9mCj4gICAgICAgICAgICBzZW5kZW1haWwuY2NDb3ZlciBjb25maWd1cmF0aW9uIHZhbHVl
OyBpZiB0aGF0IGlzIHVuc3BlY2lmaWVkLCBkZWZhdWx0IHRvIC0tbm8tY2MtY292ZXIuCj4gICAg
ICAgIFtmcm9tICJtYW4gZ2l0LXNlbmQtZW1haWwiXQo+Cj4gVGhpcyB3aWxsIG1ha2UgdGhlIGNv
bW1pdHMgbGVzcyBibG9hdGVkIGFuZCBtYWtlcyBzdXJlIHRoYXQgZXZlcnlvbmUgeW91Cj4gbWln
aHQgd2FudCB0byBDQyB3aWxsIGdldCBhbHdheXMgdGhlIHNhbWUgc2V0IG9mIHBhdGNoZXMuCj4K
PiBJJ2QgYWxzbyByZWNvbW1lbmQgdG8gcGljayBvbmx5IG9uZSBsaXN0IGZvciB0by1maWVsZCBi
ZWNhdXNlIHRoZXJlIGNhbgo+IGJlIG9ubHkgb25lIG1haW50YWluZXIgdGhhdCBpbiB0aGUgZW5k
IHdvdWxkIHRha2UgdGhlc2UgcGF0Y2hlcy4gQ2hhbmdlCj4gcmVzdCB0byBjYydzLiBOb3cgdGhl
IHByb2Nlc3Mgb2YgbWFuYWdpbmcgdGhlc2UgcGF0Y2hlcyBpcyBhbWJpZ3VvdXMgYnkKPiBkZWZp
bml0aW9uLgo+CgpTb3JyeSBmb3IgdGhlIHVubmVjZXNzYXJ5IG5vaXNlLCBJIHdpbGwgZm9sbG93
IHlvdXIgc3VnZ2VzdGlvbiBpbiB0aGUKbmV4dCByb3VuZC4KClRoYW5rcywKClBpbmdmYW4KCj4g
QlIsIEphcmtrbwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo+CgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

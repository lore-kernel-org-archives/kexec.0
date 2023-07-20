Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A09EB64DA
	for <kexec@archiver.kernel.org>; Thu, 20 Jul 2023 07:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=imvkgqrvl7EZGi+eAG4Pv1WSxSOWATwNQBPAzsQYNF8=; b=Spxw66ifO7cdjg
	aTar57lealsF9CFahrChKVRe2q8t7wcRXCifkNhIqiOa/uEWqYTi12XVhcs/Rogeo5Pq1PfmcltgH
	bYEb3fmqQ+DQSEw/rjbE5HPB78mzAIEAd5qqPCqFNsH19F4QhUh+CMrfHwyFeKaLVcjj60oxJAYMH
	QNMEVDWrAOnauNyuxhfGh/XJwXAKGA6LjBTGXKm2jPhj0uNsUuHzT2MkO9AmyZSvhWz2jzi7/LGB+
	Cn5Me82Bno+62OxJHSI0TEBF5jAeN40kDJrNcU5OMZqSXPcCqtObr36bUAw2GS+a7qdu7yxXu2HmH
	y2GgGTRy0NIsfTPIwDMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMO4c-00A7bc-0Y;
	Thu, 20 Jul 2023 07:27:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMO4Y-00A7al-28
	for kexec@lists.infradead.org;
	Thu, 20 Jul 2023 07:27:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689838056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2q4i5AxlnZUC5InUDRXJ2+far/fkcnU3lYGYV6ayEZo=;
	b=HjW7Y7hZTY8r9KV1k7fcb5mBhBptzR4BKT8RnahpDMYVu46JI0lErlylie1/VinwEIIuPo
	/J8IjKrRqJ3xkhbFxJig1zzioY42yS0UqIDFihuXnXFUgcnjpNByspcYcXcMfPs43JmJZY
	9Cp2WKPA/YvtGUyNQ0410KvnC3J8R5s=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-o4N3OB9kNH2ulnzz0H47Gw-1; Thu, 20 Jul 2023 03:27:35 -0400
X-MC-Unique: o4N3OB9kNH2ulnzz0H47Gw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3488956e9cfso464605ab.0
        for <kexec@lists.infradead.org>; Thu, 20 Jul 2023 00:27:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689838054; x=1690442854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q4i5AxlnZUC5InUDRXJ2+far/fkcnU3lYGYV6ayEZo=;
        b=Y2sYsUhaDQVB1hgtWljVmFI3eZWmbblgYm+Reob1obvP5ImLhzW2sOOfB4l8t3X/f5
         38h4oYfWiKfcuad5YvKfX+mHXsEIvY/J3WLEqbuZwB4HoiHUkDWE+zOzjOlIZr9MvNpP
         aPnSC9ne7WiL4FHIEm5nrbJ78hqCeENxhgTtIqDEaIaiI4fzLZsLJdDzfPNixLhdAKRQ
         cnysaTbIrYUyQyF4XEdO6w7ze/pZ8YEPtaJLnKLmasf+9oqk/HxjYF8r1gBNZ4W9g/DA
         DswDerpivjcqgP+0k7CIp47mLfcdi57dHcGJL0h2ADmwWS7huztZkVnLxQHoInEPv1fN
         ktbg==
X-Gm-Message-State: ABy/qLZI1b3vGdq4/1n45a1QV814bZYIjuJz6Jw9v1m2GDcJhMv1eKFc
	A9gajumTbmLsCW96N8zEvG7pKSrI83ZK6gbKom5wW61EVEtMfhQOmxILlRMd6PqO+UNNWl/JT1F
	iFIoLta8YU1GrZ2tHHMtuqXOS/k/35K84gCZu
X-Received: by 2002:a92:d18b:0:b0:345:e438:7381 with SMTP id z11-20020a92d18b000000b00345e4387381mr1908580ilz.2.1689838054560;
        Thu, 20 Jul 2023 00:27:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGotR/OdT9gQYv9Y75oIndolsAdtPRjUHZedKFcpKySXVICTV7PQsw2PnxsZbJ17qjVEqUomp9zkun4D/1QHl0=
X-Received: by 2002:a92:d18b:0:b0:345:e438:7381 with SMTP id
 z11-20020a92d18b000000b00345e4387381mr1908530ilz.2.1689838053333; Thu, 20 Jul
 2023 00:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230717130732.22710-1-piliu@redhat.com> <ZLdSMPJ9LxxFHCrO@darkstar.users.ipa.redhat.com>
 <CAF+s44SZSX5H_UkTjauHkxZwWRBTJ0vD6a_AqEfTxBioJ6ioTQ@mail.gmail.com>
In-Reply-To: <CAF+s44SZSX5H_UkTjauHkxZwWRBTJ0vD6a_AqEfTxBioJ6ioTQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 20 Jul 2023 15:29:11 +0800
Message-ID: <CALu+AoQMib-=w3mEoaz97Yb-nG=NfgLJswifUh834duu3rnj+A@mail.gmail.com>
Subject: Re: [PATCHv5 0/8] arm64: zboot support
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_002738_776169_9DA7836D 
X-CRM114-Status: GOOD (  31.88  )
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

SGkgUGluZ2ZhbiwKCk9uIFRodSwgMjAgSnVsIDIwMjMgYXQgMTA6MDUsIFBpbmdmYW4gTGl1IDxw
aWxpdUByZWRoYXQuY29tPiB3cm90ZToKPgo+IEhpIERhdmUsCj4KPiBUaGFua3MgZm9yIHlvdXIg
aW5zaWdodC4gUGxlYXNlIHNlZSB0aGUgY29tbWVudHMgaW5saW5lIGJlbG93Lgo+Cj4gT24gV2Vk
LCBKdWwgMTksIDIwMjMgYXQgMTE6MDDigK9BTSBEYXZlIFlvdW5nIDxkeW91bmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPgo+ID4gSGkgUGluZ2ZhbiwgU2ltb24sCj4gPgo+ID4gT24gMDcvMTcvMjMg
YXQgMDk6MDdwbSwgUGluZ2ZhbiBMaXUgd3JvdGU6Cj4gPiA+IEFzIG1vcmUgY29tcGxpY2F0ZWQg
Y2Fwc3VsZSBrZXJuZWwgZm9ybWF0IG9jY3VycyBsaWtlIHpib290LCB3aGVyZSB0aGUKPiA+ID4g
Y29tcHJlc3NlZCBrZXJuZWwgaXMgc3RvcmVkIGFzIGEgcGF5bG9hZC4gVGhlIHN0cmFpZ2h0IGZv
cndhcmQKPiA+ID4gZGVjb21wcmVzc2lvbiBjYW4gbm90IG1lZXQgdGhlIGRlbWFuZC4KPiA+ID4K
PiA+ID4gQXMgdGhlIGZpcnN0IHN0ZXAsIG9uIGFhcmNoNjQsIHJlYWRpbmcgaW4gdGhlIGtlcm5l
bCBmaWxlIGluIGEgcHJvYmUKPiA+ID4gbWV0aG9kIGFuZCBkZWNpZGUgaG93IHRvIHVuZm9sZCB0
aGUgY29udGVudCBieSB0aGUgbWV0aG9kIGl0c2VsZi4KPiA+ID4KPiA+ID4gVGhpcyBzZXJpZXMg
aW50cm9kdWNlIGEgbmV3IGltYWdlIHByb2JlIGludGVyZmFjZSBwcm9iZTIoKSwgd2hpY2gKPiA+
ID4gcmV0dXJucyB0aHJlZSBmYWN0b3JzOiBrZXJuZWwgYnVmZmVyLCBrZXJuZWwgc2l6ZSBhbmQg
a2VybmVsIGZkIHRocm91Z2gKPiA+ID4gYSBzdHJ1Y3QgcGFyc2VkX2luZm8uCj4gPiA+IC0xLiB0
aGUgcGFyc2VkIGtlcm5lbF9idWYgc2hvdWxkIGJlIHJldHVybmVkIHNvIHRoYXQgaXQgY2FuIGJl
IHVzZWQgYnkKPiA+ID4gdGhlIGltYWdlIGxvYWQgbWV0aG9kIGxhdGVyLgo+ID4gPiAtMi4gdGhl
IGZpbmFsIGZkIHBhc3NlZCB0byBzeXNfa2V4ZWNfZmlsZV9sb2FkLCBzaW5jZSBhYXJjaDY0IGtl
cm5lbCBjYW4KPiA+ID4gb25seSB3b3JrIHdpdGggSW1hZ2UgZm9ybWF0LCB0aGUgb3V0ZXIgcGF5
bG9hZCBzaG91bGQgYmUgc3RyaXBwZWQgYW5kIGEKPiA+ID4gdGVtcG9yYXJ5IGZpbGUgb2YgSW1h
Z2Ugc2hvdWxkIGJlIGNyZWF0ZWQuCj4gPgo+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgSW1hZ2Uu
Z3ogZmlsZSBsb2FkIGNvZGUsIHRoZSBjdXJyZW50IGNvZGUgY2FuIGJlCj4gPiBzaW1wbGlmaWVk
IHdpdGggcGFzc2luZyBhIGZkIGRpcmVjdGx5IGluc3RlYWQgb2YgY3JlYXRpbmcgdGVtcCBmaWxl
cyB2aWEKPiA+IG1lbWZkX2NyZWF0ZSB3aXRoIHRoZSBhbHJlYWR5IGRlY29tcHJlc3NlZCBrZXJu
ZWxfYnVmLgo+ID4KPiA+IFRoZSBjdXJyZW50IGZpbGUgbG9hZCBpcyBsaWtlIGJlbG93Ogo+ID4K
PiA+IGRvX2tleGVjX2ZpbGVfbG9hZCgpOgo+ID4gICAxLnNsdXJwX2RlY29tcHJlc3NfZmlsZQo+
ID4gICAgIDIuIHByb2JlCj4gPiAgICAgICAzLiBsb2FkCj4gPiAgICAgICAgIDQuIGtleGVjX2Zp
bGVfbG9hZAo+ID4KPiA+IEluIHN0ZXAgMSwgdGhlIEltYWdlLmd6IGhhcyBiZWVuIGRlY29tcHJl
c3NlZCB0byBrZXJuZWxfYnVmLCBzbyBqdXN0Cj4gPiBjcmVhdGUgYSB2aXJ0dWFsIG1lbWZkIGNv
cHkgdG8gaXQsIHRoZW4gc2F2ZSB0aGUgdmlydHVhbCBmZCBmb3Igc3RlcCA0Cj4gPiB1c2UuCj4g
Pgo+ID4gT3RoZXJ3aXNlIGluIHN0ZXAgMiBpdCBpcyBzb21lIHNhbml0eSBjaGVja2luZywgc3Rl
cCAzIGlzIHNldHRpbmcKPiA+IHNvbWV0aGluZyBlbHNlIGVnLiBpbml0cmRfZmQsIGNtZGxpbmUu
IFdpdGggdGhlIGNoYW5nZXMgYmVsb3cgSW1hZ2UgYW5kCj4gPiBJbWFnZS5neiB3aWxsIHNoYXJl
IHNhbWUgY29kZS4gSSB0aGluayB5b3UgY2FuIGFkZCB0aGUgemJvb3QKPiA+IGRldGVjdGlvbi9j
aGVja2luZyBjb2RlIGluIHRoZSBJbWFnZSBwcm9iZSwgbG9hZCBmdW5jdGlvbnMsIHdpdGggYSBu
ZXcKPiA+IGluZm8tPmtlcm5lbF9mZCwgeW91IGNhbiBkZWNvbXByZXNzIHRoZSB6Ym9vdCBrZXJu
ZWxfYnVmIGFuZCBzYXZlIHRvCj4gPiBhbm90aGVyIHZpcnR1YWwgbWVtZmQsIGFuZCBzZXQgdG8g
dGhlIGluZm8tPmtlcm5lbF9mZC4gIFRoZW4gaW4gc3RlcCA0Cj4gPiB0aGUga2V4ZWNfZmlsZV9s
b2FkIGNhbiBqdXN0IHVzZSBpdC4KPiA+Cj4KPiBUaGlzIG9ubHkgcmVzdWx0cyBpbiBhIG1pbm9y
IGNoYW5nZSBpbiB0aGUgaW50ZXJmYWNlLCBub3QgbGlrZSBtaW5lLiBJCj4gcHJlZmVyIHRoaXMg
bWV0aG9kLgo+Cj4gPiBUaGUga2VybmVsX2J1ZiBpdHNlbGYgaXMgb25seSB1c2VkIGZvciBzYW5p
dHkgY2hlY2tpbmcgb2YgdGhlIGZvcm1hdHMsCj4gPiBrZXJuZWwgb25seSBuZWVkcyBhIGZpbGUg
ZmQsIHNvIEkgdGhpbmsgaXQgc2hvdWxkIGJlIGZpbmUgYW5kIGVhc2llcgo+ID4gdGhhbiB0aGUg
b3JpZ2luYWwgd2F5cy4KPiA+Cj4KPiBPdmVyYWxsLCB0aGlzIG5ldyBtZXRob2QgbWluaW1hbGx5
IGFmZmVjdHMgdGhlIGZ1bmN0aW9uIGludGVyZmFjZSwgaW4KPiBhZGRpdGlvbiB0byB0aGUgY29k
ZSBzaW1wbGlmaWNhdGlvbi4KPiBJIHdpbGwgdHJ5IHRvIHRha2UgaXQgaW4gdGhlIG5leHQgdmVy
c2lvbi4KPgpPaywgZ3JlYXQuICBCdHcsIGl0IHdvdWxkIGJlIGlkZWFsIGlmIHNvbWUgb2YgdGhl
IHBlel9wcmVwYXJlIHdvcmsgY2FuCmJlIGRvbmUgZWFybHkgYmVmb3JlIHRoZSBzbHVycF9kZWNv
bXByZXNzX2ZpbGUgaW4KZG9fa2V4ZWNfZmlsZV9sb2FkKCksIHRoZW4gaXQgY291bGQgYmUganVz
dCBhcmNoIGluZGVwZW5kZW50IDopCgpUaGFua3MKRGF2ZQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK

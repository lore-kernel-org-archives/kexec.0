Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04377EB64DA
	for <kexec@archiver.kernel.org>; Thu, 20 Jul 2023 10:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iZ92+ZsaUPA5y8RwVNob3aNyYOSUJPNLjD0fpRuO6qw=; b=E/655ZJWnHRv2d
	Bd3gPdzwcyAD8zzEhoGEprECXbXRhJPzFJhUwlGgweTyQFKD4UQs7bS62WMfUTrfoffKwKIlTjN+9
	m61yI177sLs1tL9vjamCzDxo/rG6shEoCg6r3BDoXkkgXbuU3PBZJD4Pe79wRiLi6NXLc6/06y145
	UUUvcukuh8c+zUzb1hn0tIoU0WzC6CRAtfVv9APPZwa868CuX6wGnmdeIowiZmn0nzVwXhjRQUNKN
	o5QrGSKtZ/9dB2jn8oZzea6b29Pq2+2G5CcnoVQVj3Cd5d/z0s0+iMW1ojnedTa8NnwgtsuFas4Lo
	AwEQmACBEeOOB+azixhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMQYO-00AgcY-02;
	Thu, 20 Jul 2023 10:06:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMQYL-00Agai-0K
	for kexec@lists.infradead.org;
	Thu, 20 Jul 2023 10:06:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689847592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1h1dcZ03xzw5vJZ0lA97LiaZHD+3xdzq4Vq2JpolgU=;
	b=HTaK4U3ZcB8gcmio9bzLkD5nkpmQS+Z4a20NdZWJzy0q6nSW0x/tGNclQoqS3CnbNPrPnA
	w65Ga7dycJgstFCzFXWiSvCU+OOdDSz95ntrkVGFmoK93KW0I7/Z+hCAu1f+NzZEI9FQ3E
	mKjSBWDbuFcx8B2dgEl5UUS1lctakUc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-HyLjpzqlNyyBQIDAcLFk3Q-1; Thu, 20 Jul 2023 06:06:30 -0400
X-MC-Unique: HyLjpzqlNyyBQIDAcLFk3Q-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3488bac88a2so1169095ab.1
        for <kexec@lists.infradead.org>; Thu, 20 Jul 2023 03:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689847590; x=1690452390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1h1dcZ03xzw5vJZ0lA97LiaZHD+3xdzq4Vq2JpolgU=;
        b=ixu+Uu8YKAauaxSzfRHkj0Xe9GG0bKAbrtaEI3kOm3ClKjaHmYdU2rCZHagzgVRfFN
         hG0bIv/C1KPK3Q9aU8hbblAODvPqwNrPs4eJC3CZmoicKW4ESHAimhLfYKGNRWi2SkTh
         LgJyzfFuvsf0PNzKENj1A7RMMN0eK/lCgga94jEOdNEdhrcMmiIDoj0KBO/BSc3W5dNx
         pe7vL9RjcvZGgB9Xv8YLOl9LTiERigUfq5RiSWwKRSJRckEjAdaB21ZpKzkg+LClYHu/
         JlSyMzP/dZvN8BN/Rihtgs8Pnseetz8A3+/TKIkopB6NVfCBSsYz/SHhdmuemc4BWnM7
         6Eug==
X-Gm-Message-State: ABy/qLYkMipAe/n8nBbdW9Ynhz1r6UuDUsuDy9Fd97Jh6B20COFJrCFo
	jDzrFI1tzOLWbhtJpRPSKHp6f9j9Ougs6xK/ExOwyJMCJBzs9k/yd7pZ79+Tj//3SDW0ixfVXoV
	Zu01+ErY/kasZnBBOqP+Yk+gcqGXHdgpSHuHa
X-Received: by 2002:a92:d086:0:b0:345:e55a:615f with SMTP id h6-20020a92d086000000b00345e55a615fmr2127199ilh.2.1689847590055;
        Thu, 20 Jul 2023 03:06:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGknZgzk4Cdlz06Y6Kz5Gr9SwbXyQzMvcGujYIxBo2WCwGCtFEjDHD9gW8zcJOeDGniOJgJ7QusX8Hyofk/qw0=
X-Received: by 2002:a92:d086:0:b0:345:e55a:615f with SMTP id
 h6-20020a92d086000000b00345e55a615fmr2127181ilh.2.1689847589767; Thu, 20 Jul
 2023 03:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230717130732.22710-1-piliu@redhat.com> <ZLdSMPJ9LxxFHCrO@darkstar.users.ipa.redhat.com>
 <CAF+s44SZSX5H_UkTjauHkxZwWRBTJ0vD6a_AqEfTxBioJ6ioTQ@mail.gmail.com>
 <CALu+AoQMib-=w3mEoaz97Yb-nG=NfgLJswifUh834duu3rnj+A@mail.gmail.com> <CAF+s44QVbpb=upCqY6n_FSo6QAhv6=eLNCXwz1Jng6wW75KLXQ@mail.gmail.com>
In-Reply-To: <CAF+s44QVbpb=upCqY6n_FSo6QAhv6=eLNCXwz1Jng6wW75KLXQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 20 Jul 2023 18:08:07 +0800
Message-ID: <CALu+AoThG6kFEQ1-x=uv1_f8PYGNLD=hgg3vk2avDUk=K_BdOg@mail.gmail.com>
Subject: Re: [PATCHv5 0/8] arm64: zboot support
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_030633_233540_C31C39E3 
X-CRM114-Status: GOOD (  37.58  )
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

T24gVGh1LCAyMCBKdWwgMjAyMyBhdCAxNjo1OSwgUGluZ2ZhbiBMaXUgPHBpbGl1QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgMjAsIDIwMjMgYXQgMzoyN+KAr1BNIERhdmUgWW91
bmcgPGR5b3VuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBIaSBQaW5nZmFuLAo+ID4KPiA+
IE9uIFRodSwgMjAgSnVsIDIwMjMgYXQgMTA6MDUsIFBpbmdmYW4gTGl1IDxwaWxpdUByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4gSGkgRGF2ZSwKPiA+ID4KPiA+ID4gVGhhbmtzIGZvciB5
b3VyIGluc2lnaHQuIFBsZWFzZSBzZWUgdGhlIGNvbW1lbnRzIGlubGluZSBiZWxvdy4KPiA+ID4K
PiA+ID4gT24gV2VkLCBKdWwgMTksIDIwMjMgYXQgMTE6MDDigK9BTSBEYXZlIFlvdW5nIDxkeW91
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBIaSBQaW5nZmFuLCBTaW1vbiwK
PiA+ID4gPgo+ID4gPiA+IE9uIDA3LzE3LzIzIGF0IDA5OjA3cG0sIFBpbmdmYW4gTGl1IHdyb3Rl
Ogo+ID4gPiA+ID4gQXMgbW9yZSBjb21wbGljYXRlZCBjYXBzdWxlIGtlcm5lbCBmb3JtYXQgb2Nj
dXJzIGxpa2UgemJvb3QsIHdoZXJlIHRoZQo+ID4gPiA+ID4gY29tcHJlc3NlZCBrZXJuZWwgaXMg
c3RvcmVkIGFzIGEgcGF5bG9hZC4gVGhlIHN0cmFpZ2h0IGZvcndhcmQKPiA+ID4gPiA+IGRlY29t
cHJlc3Npb24gY2FuIG5vdCBtZWV0IHRoZSBkZW1hbmQuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQXMg
dGhlIGZpcnN0IHN0ZXAsIG9uIGFhcmNoNjQsIHJlYWRpbmcgaW4gdGhlIGtlcm5lbCBmaWxlIGlu
IGEgcHJvYmUKPiA+ID4gPiA+IG1ldGhvZCBhbmQgZGVjaWRlIGhvdyB0byB1bmZvbGQgdGhlIGNv
bnRlbnQgYnkgdGhlIG1ldGhvZCBpdHNlbGYuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBzZXJp
ZXMgaW50cm9kdWNlIGEgbmV3IGltYWdlIHByb2JlIGludGVyZmFjZSBwcm9iZTIoKSwgd2hpY2gK
PiA+ID4gPiA+IHJldHVybnMgdGhyZWUgZmFjdG9yczoga2VybmVsIGJ1ZmZlciwga2VybmVsIHNp
emUgYW5kIGtlcm5lbCBmZCB0aHJvdWdoCj4gPiA+ID4gPiBhIHN0cnVjdCBwYXJzZWRfaW5mby4K
PiA+ID4gPiA+IC0xLiB0aGUgcGFyc2VkIGtlcm5lbF9idWYgc2hvdWxkIGJlIHJldHVybmVkIHNv
IHRoYXQgaXQgY2FuIGJlIHVzZWQgYnkKPiA+ID4gPiA+IHRoZSBpbWFnZSBsb2FkIG1ldGhvZCBs
YXRlci4KPiA+ID4gPiA+IC0yLiB0aGUgZmluYWwgZmQgcGFzc2VkIHRvIHN5c19rZXhlY19maWxl
X2xvYWQsIHNpbmNlIGFhcmNoNjQga2VybmVsIGNhbgo+ID4gPiA+ID4gb25seSB3b3JrIHdpdGgg
SW1hZ2UgZm9ybWF0LCB0aGUgb3V0ZXIgcGF5bG9hZCBzaG91bGQgYmUgc3RyaXBwZWQgYW5kIGEK
PiA+ID4gPiA+IHRlbXBvcmFyeSBmaWxlIG9mIEltYWdlIHNob3VsZCBiZSBjcmVhdGVkLgo+ID4g
PiA+Cj4gPiA+ID4gSSB0b29rIGEgbG9vayBhdCB0aGUgSW1hZ2UuZ3ogZmlsZSBsb2FkIGNvZGUs
IHRoZSBjdXJyZW50IGNvZGUgY2FuIGJlCj4gPiA+ID4gc2ltcGxpZmllZCB3aXRoIHBhc3Npbmcg
YSBmZCBkaXJlY3RseSBpbnN0ZWFkIG9mIGNyZWF0aW5nIHRlbXAgZmlsZXMgdmlhCj4gPiA+ID4g
bWVtZmRfY3JlYXRlIHdpdGggdGhlIGFscmVhZHkgZGVjb21wcmVzc2VkIGtlcm5lbF9idWYuCj4g
PiA+ID4KPiA+ID4gPiBUaGUgY3VycmVudCBmaWxlIGxvYWQgaXMgbGlrZSBiZWxvdzoKPiA+ID4g
Pgo+ID4gPiA+IGRvX2tleGVjX2ZpbGVfbG9hZCgpOgo+ID4gPiA+ICAgMS5zbHVycF9kZWNvbXBy
ZXNzX2ZpbGUKPiA+ID4gPiAgICAgMi4gcHJvYmUKPiA+ID4gPiAgICAgICAzLiBsb2FkCj4gPiA+
ID4gICAgICAgICA0LiBrZXhlY19maWxlX2xvYWQKPiA+ID4gPgo+ID4gPiA+IEluIHN0ZXAgMSwg
dGhlIEltYWdlLmd6IGhhcyBiZWVuIGRlY29tcHJlc3NlZCB0byBrZXJuZWxfYnVmLCBzbyBqdXN0
Cj4gPiA+ID4gY3JlYXRlIGEgdmlydHVhbCBtZW1mZCBjb3B5IHRvIGl0LCB0aGVuIHNhdmUgdGhl
IHZpcnR1YWwgZmQgZm9yIHN0ZXAgNAo+ID4gPiA+IHVzZS4KPiA+ID4gPgo+ID4gPiA+IE90aGVy
d2lzZSBpbiBzdGVwIDIgaXQgaXMgc29tZSBzYW5pdHkgY2hlY2tpbmcsIHN0ZXAgMyBpcyBzZXR0
aW5nCj4gPiA+ID4gc29tZXRoaW5nIGVsc2UgZWcuIGluaXRyZF9mZCwgY21kbGluZS4gV2l0aCB0
aGUgY2hhbmdlcyBiZWxvdyBJbWFnZSBhbmQKPiA+ID4gPiBJbWFnZS5neiB3aWxsIHNoYXJlIHNh
bWUgY29kZS4gSSB0aGluayB5b3UgY2FuIGFkZCB0aGUgemJvb3QKPiA+ID4gPiBkZXRlY3Rpb24v
Y2hlY2tpbmcgY29kZSBpbiB0aGUgSW1hZ2UgcHJvYmUsIGxvYWQgZnVuY3Rpb25zLCB3aXRoIGEg
bmV3Cj4gPiA+ID4gaW5mby0+a2VybmVsX2ZkLCB5b3UgY2FuIGRlY29tcHJlc3MgdGhlIHpib290
IGtlcm5lbF9idWYgYW5kIHNhdmUgdG8KPiA+ID4gPiBhbm90aGVyIHZpcnR1YWwgbWVtZmQsIGFu
ZCBzZXQgdG8gdGhlIGluZm8tPmtlcm5lbF9mZC4gIFRoZW4gaW4gc3RlcCA0Cj4gPiA+ID4gdGhl
IGtleGVjX2ZpbGVfbG9hZCBjYW4ganVzdCB1c2UgaXQuCj4gPiA+ID4KPiA+ID4KPiA+ID4gVGhp
cyBvbmx5IHJlc3VsdHMgaW4gYSBtaW5vciBjaGFuZ2UgaW4gdGhlIGludGVyZmFjZSwgbm90IGxp
a2UgbWluZS4gSQo+ID4gPiBwcmVmZXIgdGhpcyBtZXRob2QuCj4gPiA+Cj4gPiA+ID4gVGhlIGtl
cm5lbF9idWYgaXRzZWxmIGlzIG9ubHkgdXNlZCBmb3Igc2FuaXR5IGNoZWNraW5nIG9mIHRoZSBm
b3JtYXRzLAo+ID4gPiA+IGtlcm5lbCBvbmx5IG5lZWRzIGEgZmlsZSBmZCwgc28gSSB0aGluayBp
dCBzaG91bGQgYmUgZmluZSBhbmQgZWFzaWVyCj4gPiA+ID4gdGhhbiB0aGUgb3JpZ2luYWwgd2F5
cy4KPiA+ID4gPgo+ID4gPgo+ID4gPiBPdmVyYWxsLCB0aGlzIG5ldyBtZXRob2QgbWluaW1hbGx5
IGFmZmVjdHMgdGhlIGZ1bmN0aW9uIGludGVyZmFjZSwgaW4KPiA+ID4gYWRkaXRpb24gdG8gdGhl
IGNvZGUgc2ltcGxpZmljYXRpb24uCj4gPiA+IEkgd2lsbCB0cnkgdG8gdGFrZSBpdCBpbiB0aGUg
bmV4dCB2ZXJzaW9uLgo+ID4gPgo+ID4gT2ssIGdyZWF0LiAgQnR3LCBpdCB3b3VsZCBiZSBpZGVh
bCBpZiBzb21lIG9mIHRoZSBwZXpfcHJlcGFyZSB3b3JrIGNhbgo+ID4gYmUgZG9uZSBlYXJseSBi
ZWZvcmUgdGhlIHNsdXJwX2RlY29tcHJlc3NfZmlsZSBpbgo+ID4gZG9fa2V4ZWNfZmlsZV9sb2Fk
KCksIHRoZW4gaXQgY291bGQgYmUganVzdCBhcmNoIGluZGVwZW5kZW50IDopCj4gPgo+Cj4gSSBh
c3N1bWUgdGhhdCB5b3Ugc3VnZ2VzdCB0aGUgZm9sbG93aW5nIGJpZyBwaWN0dXJlOgo+ICAgICBp
ZiB0cnlpbmcgc2x1cnBfZGVjb21wcmVzc19maWxlKCkKPiAgICAgZWxzZSB0cnlpbmcgcGV6X3By
ZXBhcmUoKQo+ICAgICBmb3IgKGkgPSAwOyBpIDwgZmlsZV90eXBlczsgaSsrKSB7Cj4gICAgICAg
aWYgKGZpbGVfdHlwZVtpXS5wcm9iZShrZXJuZWxfYnVmLCBrZXJuZWxfc2l6ZSkgPj0gMCkKPiAg
ICB9Cj4KPiBCdXQgdGhlcmUgaXMgc29tZSBjaGVjayBiZWZvcmUgcGV6X3ByZXBhcmUoKSBpbiBw
ZXpfYXJtNjRfcHJvYmUoKSwgSQo+IGFtIG5vdCBzdXJlIHdoZXRoZXIgdGhleSBjYW4gYmUgc2tp
cHBlZCBvciBub3QuCgpPaywgZ290IGl0LCBpZiB0aGUgemltYWdlIGhlYWRlciBvZiBhcm02NCBp
cyBhcmNoIHNwZWNpZmljICwgaXQgc2hvdWxkCnN0aWxsIGdvIHRvIHRoZSBhcmNoIHBhcnQuCgpU
aGFua3MKRGF2ZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

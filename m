Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D958EC54E76
	for <kexec@archiver.kernel.org>; Thu, 16 Nov 2023 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jLAWa3fwoEPgXs48vf6LLABxjjjJ9xI2SPRx/sSSr0k=; b=qJNTw98SlJEFxg
	UhZONZ6eIMS9+U6p/PVsYNlb+hbAGWSBknJVpCzTB14M6tEdCfwdKV6zjFcZP4A7PQXQ8UlOwVYFc
	R3q29TUrfL7/ajaG+45+K3u4/KHJUB7K2Di31cIhU4RGCrpVXmLNOCgMqRb00+kfZMaoMEscNcFEX
	iCPpQZ5/UzqfRpYJVYNu6f8UmEVMegDB/Cc28Gyz8DG8EEdwCu0bwc3ZWTBPG4y7i+Q4JqcrPj3Q9
	aJia9mptlQ84NfnVgj+R12TBxcEnB1Mpwz0akjaJ84YUm/DTmrgH981HcAEilSNvNQQP4KoOCIQQF
	aAr8uP2MIdkQyKREiGpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3lHt-0058tY-1H;
	Thu, 16 Nov 2023 22:56:41 +0000
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3lHq-0058sG-15
	for kexec@lists.infradead.org;
	Thu, 16 Nov 2023 22:56:40 +0000
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so1374994276.1
        for <kexec@lists.infradead.org>; Thu, 16 Nov 2023 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700175394; x=1700780194; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=EpDzJrxeQCLQIwiWuR5NLH6Rv2AsQjm9HFXXdcr/rCv+Ifm401J1nQb09CDGyxxd6i
         EUWzhMSsY6+E9B7OuJ46aoq5g2QhXK731G0kx6IAvLoPf2zZcOtH6MMz7SnvnPZ3IxBs
         /GW+5Y4KxEspIQ0Oyoy7PFKyuVQ8IQIZQP8MKIMfcHSftxaEhESmMK/5dIxIugToC586
         mL+ilBSn5Tj9f3vR76+dEkaKbhsNRMpMfRTHgHSA7+Exy+dbWzhREZHAfKUjAy6xFTJ1
         b+VFM1B8/t2vQwY6ydt7B4B5f7P0BAsenaVVIeykJ2+C3em1ymux91zdJLofipFL+jaT
         yGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700175394; x=1700780194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsOeDCVHbRtCHMfzzq1TAv9cQgSIrowc6ucZqtobrEU=;
        b=A/IwkJwUND15n6Z9ANWgT7ngiIQCA7EU1i5AXhkPimRTfKvshFgs/x2me1fbDpnuan
         0Gwp3y0DqlIiMw9LCMl+iHO8hQfO3LJu98TKyhuTWBpgmR+kKoEprRkj4H2xmya/xlcw
         22tFs6BAi1an5qMRVBWwwYhAuIv5sDYCgzl5o5PvSGFRL7Zh4xspYJWKqZuGrXqJ4XDA
         juWdFliE+W7L2y/Jl91xk3KflQq2ZSogyr5RVMc8qCHPWIu/TT9cJ89YSfLBrSyQWBBt
         PCo0g28aGR61PXG2etHilIAPxULdfkFf+r6NRQ9F7OO+fv4NTrBzi+Fu0zmr4yavmADP
         BF8Q==
X-Gm-Message-State: AOJu0Yx4h3B01du9pyeLmFTx0Upbic5BDWB8Jey+MobR9oK9U+3sjjJS
	hzJBqvZs9J3FUvLwQ5FvymjuDPSEOZRACuelLmEj
X-Google-Smtp-Source: AGHT+IE2+AcN0WJvi0/kso4DZanSDDx6lgfXDUrfRsZwb16RGMyBmQlC1nbV8aw1RFcW/pXSAxD2p1WHO1Zi2XhSD08=
X-Received: by 2002:a25:d087:0:b0:d9b:6264:b79e with SMTP id
 h129-20020a25d087000000b00d9b6264b79emr15509359ybg.53.1700175394153; Thu, 16
 Nov 2023 14:56:34 -0800 (PST)
MIME-Version: 1.0
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com> <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com> <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
 <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
In-Reply-To: <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 16 Nov 2023 17:56:23 -0500
Message-ID: <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>, 
	Tushar Sugandhi <tusharsu@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, 
	vgoyal@redhat.com, Dave Young <dyoung@redhat.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org, serge@hallyn.com, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, 
	Tyler Hicks <tyhicks@linux.microsoft.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231116_145638_534374_7E03396D 
X-CRM114-Status: GOOD (  32.68  )
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

T24gVGh1LCBOb3YgMTYsIDIwMjMgYXQgNTo0MeKAr1BNIFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJA
bGludXguaWJtLmNvbT4gd3JvdGU6Cj4gT24gMTEvMTYvMjMgMTc6MDcsIFBhdWwgTW9vcmUgd3Jv
dGU6Cj4gPiBPbiBUdWUsIE5vdiAxNCwgMjAyMyBhdCAxOjU44oCvUE0gU3RlZmFuIEJlcmdlciA8
c3RlZmFuYkBsaW51eC5pYm0uY29tPiB3cm90ZToKPiA+PiBPbiAxMS8xNC8yMyAxMzozNiwgU3Vz
aCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPiA+Pj4gT24gMTEvMTMvMjAyMyAxMDo1OSBBTSwgU3Rl
ZmFuIEJlcmdlciB3cm90ZToKPiA+Pj4+IE9uIDEwLzE5LzIzIDE0OjQ5LCBUdXNoYXIgU3VnYW5k
aGkgd3JvdGU6Cj4gPj4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pj4+PiB8IEludHJvZHVjdGlvbiB8
Cj4gPj4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pj4+PiBUaGlzIGRvY3VtZW50IHByb3ZpZGVzIGEg
ZGV0YWlsZWQgb3ZlcnZpZXcgb2YgdGhlIHByb3Bvc2VkIEtlcm5lbAo+ID4+Pj4+IGZlYXR1cmUg
SU1BIGxvZyBzbmFwc2hvdHRpbmcuICBJdCBkZXNjcmliZXMgdGhlIG1vdGl2YXRpb24gYmVoaW5k
IHRoZQo+ID4+Pj4+IHByb3Bvc2FsLCB0aGUgcHJvYmxlbSB0byBiZSBzb2x2ZWQsIGEgZGV0YWls
ZWQgc29sdXRpb24gZGVzaWduIHdpdGgKPiA+Pj4+PiBleGFtcGxlcywgYW5kIGRlc2NyaWJlcyB0
aGUgY2hhbmdlcyB0byBiZSBtYWRlIGluIHRoZSBjbGllbnRzL3NlcnZpY2VzCj4gPj4+Pj4gd2hp
Y2ggYXJlIHBhcnQgb2YgcmVtb3RlLWF0dGVzdGF0aW9uIHN5c3RlbS4gIFRoaXMgaXMgdGhlIDJu
ZCB2ZXJzaW9uCj4gPj4+Pj4gb2YgdGhlIHByb3Bvc2FsLiAgVGhlIGZpcnN0IHZlcnNpb24gaXMg
cHJlc2VudCBoZXJlWzFdLgo+ID4+Pj4+Cj4gPj4+Pj4gVGFibGUgb2YgQ29udGVudHM6Cj4gPj4+
Pj4gLS0tLS0tLS0tLS0tLS0tLS0tCj4gPj4+Pj4gQS4gTW90aXZhdGlvbiBhbmQgQmFja2dyb3Vu
ZAo+ID4+Pj4+IEIuIEdvYWxzIGFuZCBOb24tR29hbHMKPiA+Pj4+PiAgICAgICBCLjEgR29hbHMK
PiA+Pj4+PiAgICAgICBCLjIgTm9uLUdvYWxzCj4gPj4+Pj4gQy4gUHJvcG9zZWQgU29sdXRpb24K
PiA+Pj4+PiAgICAgICBDLjEgU29sdXRpb24gU3VtbWFyeQo+ID4+Pj4+ICAgICAgIEMuMiBIaWdo
LWxldmVsIFdvcmstZmxvdwo+ID4+Pj4+IEQuIERldGFpbGVkIERlc2lnbgo+ID4+Pj4+ICAgICAg
IEQuMSBTbmFwc2hvdCBBZ2dyZWdhdGUgRXZlbnQKPiA+Pj4+PiAgICAgICBELjIgU25hcHNob3Qg
VHJpZ2dlcmluZyBNZWNoYW5pc20KPiA+Pj4+PiAgICAgICBELjMgQ2hvb3NpbmcgQSBQZXJzaXN0
ZW50IFN0b3JhZ2UgTG9jYXRpb24gRm9yIFNuYXBzaG90cwo+ID4+Pj4+ICAgICAgIEQuNCBSZW1v
dGUtQXR0ZXN0YXRpb24gQ2xpZW50L1NlcnZpY2Utc2lkZSBDaGFuZ2VzCj4gPj4+Pj4gICAgICAg
ICAgIEQuNC5hIENsaWVudC1zaWRlIENoYW5nZXMKPiA+Pj4+PiAgICAgICAgICAgRC40LmIgU2Vy
dmljZS1zaWRlIENoYW5nZXMKPiA+Pj4+PiBFLiBFeGFtcGxlIFdhbGstdGhyb3VnaAo+ID4+Pj4+
IEYuIE90aGVyIERlc2lnbiBDb25zaWRlcmF0aW9ucwo+ID4+Pj4+IEcuIFJlZmVyZW5jZXMKPiA+
Pj4+Pgo+ID4+Pj4KPiA+Pj4+IFVzZXJzcGFjZSBhcHBsaWNhdGlvbnMgd2lsbCBoYXZlIHRvIGtu
b3cKPiA+Pj4+IGEpIHdoZXJlIGFyZSB0aGUgc2hhcmQgZmlsZXM/Cj4gPj4+IFdlIGRlc2NyaWJl
IHRoZSBmaWxlIHN0b3JhZ2UgbG9jYXRpb24gY2hvaWNlcyBpbiBzZWN0aW9uIEQuMywgYnV0IHVz
ZXIKPiA+Pj4gYXBwbGljYXRpb25zIHdpbGwgaGF2ZSB0byBxdWVyeSB0aGUgd2VsbC1rbm93biBs
b2NhdGlvbiBkZXNjcmliZWQgdGhlcmUuCj4gPj4+PiBiKSBob3cgZG8gSSByZWFkIHRoZSBzaGFy
ZCBmaWxlcyB3aGlsZSBsb2NraW5nIG91dCB0aGUgcHJvZHVjZXIgb2YgdGhlCj4gPj4+PiBzaGFy
ZCBmaWxlcz8KPiA+Pj4+Cj4gPj4+PiBJTU8sIHRoaXMgd2lsbCByZXF1aXJlIGEgd2VsbCBrbm93
biBjb25maWcgZmlsZSBhbmQgYSBsb2NraW5nIG1ldGhvZAo+ID4+Pj4gKGZsb2NrKSBzbyB0aGF0
IHVzZXIgc3BhY2UgYXBwbGljYXRpb25zIGNhbiB3b3JrIHRvZ2V0aGVyIGluIHRoaXMgbmV3Cj4g
Pj4+PiBlbnZpcm9ubWVudC4gVGhlIGxvY2sgY291bGQgYmUgZGVmaW5lZCBpbiB0aGUgY29uZmln
IGZpbGUgb3IganVzdCBiZQo+ID4+Pj4gdGhlIGNvbmZpZyBmaWxlIGl0c2VsZi4KPiA+Pj4gVGhl
IGZsb2NrIGlzIGEgZ29vZCBpZGVhIGZvciBjby1vcmRpbmF0aW9uIGJldHdlZW4gVU0gY2xpZW50
cy4gV2hpbGUKPiA+Pj4gdGhlIEtlcm5lbCBjYW5ub3QgZW5mb3JjZSBhbnkgYWNjZXNzIGluIHRo
aXMgd2F5LCBhbnkgVU0gcHJvY2VzcyB0aGF0Cj4gPj4+IGlzIHBsYW5uaW5nIG9uIHRyaWdnZXJp
bmcgdGhlIHNuYXBzaG90IG1lY2hhbmlzbSBzaG91bGQgZm9sbG93IHRoYXQKPiA+Pj4gcHJvdG9j
b2wuICBXZSB3aWxsIGVuc3VyZSB3ZSBkb2N1bWVudCB0aGF0IGFzIHRoZSBiZXN0LXByYWN0aWNl
cyBpbgo+ID4+PiB0aGUgcGF0Y2ggc2VyaWVzLgo+ID4+Cj4gPj4gSXQncyBtb3JlIHRoYW4gJ2Jl
c3QgcHJhY3RpY2VzJy4gWW91IG5lZWQgYSB3ZWxsLWtub3duIGNvbmZpZyBmaWxlIHdpdGgKPiA+
PiB3ZWxsLWtub3duIGNvbmZpZyBvcHRpb25zIGluIGl0Lgo+ID4+Cj4gPj4gQWxsIGNsaWVudHMg
dGhhdCB3ZXJlIHByZXZpb3VzbHkganVzdCB0cnlpbmcgdG8gcmVhZCBuZXcgYnl0ZXMgZnJvbSB0
aGUKPiA+PiBJTUEgbG9nIGNhbm5vdCBkbyB0aGlzIGFueW1vcmUgaW4gdGhlIHByZXNlbmNlIG9m
IGEgbG9nIHNoYXJkIHByb2R1Y2VyCj4gPj4gYnV0IGhhdmUgdG8gYWxzbyBsZWFybiB0aGF0IGEg
bmV3IGxvZyBzaGFyZCBoYXMgYmVlbiBwcm9kdWNlZCBzbyB0aGV5Cj4gPj4gbmVlZCB0byBmaWd1
cmUgb3V0IHRoZSBuZXcgcG9zaXRpb24gaW4gdGhlIGxvZyB3aGVyZSB0byByZWFkIGZyb20uIFNv
Cj4gPj4gbWF5YmUgYSBjb3VudGVyIGluIGEgY29uZmlnIGZpbGUgc2hvdWxkIGluZGljYXRlIHRv
IHRoZSBsb2cgcmVhZGVycyB0aGF0Cj4gPj4gYSBuZXcgbG9nIGhhcyBiZWVuIHByb2R1Y2VkIC0t
IG90aGVyd2lzZSB0aGV5IHdvdWxkIGhhdmUgdG8gbW9uaXRvciBhbGwKPiA+PiB0aGUgbG9nIHNo
YXJkIGZpbGVzIG9yIHRoZSBsb2cgc2hhcmQgZmlsZSdzIHNpemUuCj4gPgo+ID4gSWYgYSBjb3Vu
dGVyIGlzIG5lZWRlZCwgSSB3b3VsZCBzdWdnZXN0IHBsYWNpbmcgaXQgc29tZXdoZXJlIG90aGVy
Cj4gPiB0aGFuIHRoZSBjb25maWcgZmlsZSBzbyB0aGF0IHdlIGNhbiBlbmZvcmNlIGxpbWl0ZWQg
d3JpdGUgYWNjZXNzIHRvCj4gPiB0aGUgY29uZmlnIGZpbGUuCj4gPgo+ID4gUmVnYXJkbGVzcywg
SSBpbWFnaW5lIHRoZXJlIGFyZSBhIGZldyB3YXlzIG9uZSBjb3VsZCBzeW5jaHJvbml6ZQo+ID4g
dmFyaW91cyB1c2Vyc3BhY2UgYXBwbGljYXRpb25zIHN1Y2ggdGhhdCB0aGV5IHNlZSBhIGNvbnNp
c3RlbnQgdmlldyBvZgo+ID4gdGhlIGRlY29tcG9zZWQgbG9nIHN0YXRlLCBhbmQgdGhlIGdvb2Qg
bmV3cyBpcyB0aGF0IHRoZSBhcHByb2FjaAo+ID4gZGVzY3JpYmVkIGhlcmUgaXMgb3B0LWluIGZy
b20gYSB1c2Vyc3BhY2UgcGVyc3BlY3RpdmUuICBJZiB0aGUKPgo+IEEgRlVTRSBmaWxlc3lzdGVt
IHRoYXQgc3RpdGNoZXMgdG9nZXRoZXIgdGhlIGxvZyBzaGFyZHMgZnJvbSBvbmUgb3IKPiBtdWx0
aXBsZSBmaWxlcyArIElNQSBsb2cgZmlsZShzKSBjb3VsZCBtYWtlIHRoaXMgYXBwcm9hY2ggdHJh
bnNwYXJlbnQKPiBmb3IgYXMgbG9uZyBhcyBsb2cgc2hhcmRzIGFyZSBub3QgdGhyb3duIGF3YXku
IFByZXN1bWFibHkgaXQgKG9yIHJvb3QpCj4gY291bGQgYmluZC1tb3VudCBpdHMgZmlsZXMgb3Zl
ciB0aGUgdHdvIElNQSBsb2cgZmlsZXMuCj4KPiA+IHVzZXJzcGFjZSBkb2VzIG5vdCBmdWxseSBz
dXBwb3J0IElNQSBsb2cgc25hcHNob3R0aW5nIHRoZW4gaXQgbmV2ZXIKPiA+IG5lZWRzIHRvIHRy
aWdnZXIgaXQgYW5kIHRoZSBzeXN0ZW0gYmVoYXZlcyBhcyBpdCBkb2VzIHRvZGF5OyBvbiB0aGUK
Pgo+IEkgZG9uJ3QgdGhpbmsgaW5kaXZpZHVhbCBhcHBsaWNhdGlvbnMgc2hvdWxkIHRyaWdnZXIg
aXQgLCBpbnN0ZWFkIHNvbWUKPiBkZWRpY2F0ZWQgYmFja2dyb3VuZCBwcm9jZXNzIHJ1bm5pbmcg
b24gYSBtYWNoaW5lIHdvdWxkIGRvIHRoYXQgZXZlcnkgbgo+IGxvZyBlbnRyaWVzIG9yIHNvIGFu
ZCBwb3NzaWJseSBvZmZlciB0aGUgRlVTRSBmaWxlc3lzdGVtIGF0IHRoZSBzYW1lCj4gdGltZS4g
SW4gZWl0aGVyIGNhc2UsIG9uY2UgYW55IGFwcGxpY2F0aW9uIHRyaWdnZXJzIGl0LCBhbGwgZWl0
aGVyIGhhdmUKPiB0byBrbm93IGhvdyB0byBkZWFsIHdpdGggdGhlIHNoYXJkcyBvciBGVVNFIHdv
dWxkIG1ha2UgaXQgY29tcGxldGVseQo+IHRyYW5zcGFyZW50LgoKWWVzLCBwZXJmb3JtaW5nIGEg
c25hcHNob3QgaXMgYSBwcml2aWxlZ2VkIG9wZXJhdGlvbiB3aGljaCBJIGV4cGVjdAp3b3VsZCBi
ZSBkb25lIGFuZCBtYW5hZ2VkIGJ5IGEgZGVkaWNhdGVkIGRhZW1vbiBydW5uaW5nIG9uIHRoZSBz
eXN0ZW0uCgotLSAKcGF1bC1tb29yZS5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

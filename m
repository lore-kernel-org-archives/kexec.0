Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CF8C76195
	for <kexec@archiver.kernel.org>; Mon, 27 Mar 2023 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nt60BXdcFqqRBb5GHxyDW5DjZYTsjBaxSEcMyas24QY=; b=Ie/EPtJgeoyYo8
	PgHiai6gHnR4JKm7IpWbIqRStCjebbt9PCwZif4GHiz7uA+7vHbJCvVcOF7hw3q4TSZX17I14AdCR
	SK1hPhzdqZc82crzPfWnqpA0Te04lg598WeDvbIn6gEtcNr2UHt13hdoZJ5slRCSaqX9EMeL7Ti4q
	YmDwMLh69zxfi37vyYfTNQZqoLC9wdxemtcrmBfSPC82Zl6BRF8pT5dog8wS3HczBWku/tKvdCxic
	3lSwbett5lE3l3Td1AnpEnNR6/IL0NauaLZQ4DAShKOzmR6EQk3+zyvMLfw2HPf3nqiz3v7N6wuUI
	vFSkqDDHDrj4fi//H4HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgiDK-00AFSN-1f;
	Mon, 27 Mar 2023 08:28:26 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgiD7-00AFNK-0x
	for kexec@lists.infradead.org;
	Mon, 27 Mar 2023 08:28:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 46B88B80EC0
	for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 08:28:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E1DC433A7
	for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 08:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679905690;
	bh=Y8JTOKdxeH7icOS7byWYQFkU56Eh6A9KNr/xZH2yGvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oPXIuPATnqmS6XkCie8OtwQbCvDFddB1ajjlJjKhfmji7PgjVu+tZ3mEKFuY/k+Jc
	 h4AclEq81F50pBjqut2RqGcb0IcsagvTdJFrV5mINAH4CebK+ERtIQzvmxwGThfvC8
	 +jEZq0PlpcSok1gVx/HV+4ifivZBgrFPVe5IbWfCmKRDin8Xujd6G3XkZYN4PUHkvl
	 wSUhmdlUMP2/d/M3IS0YKSD09ZOkyT/1G/sVUKEL9BYZdVLeHeUWB0dwL5p5sUIKM5
	 CCDv7FT719rOVpzzCpNwB3ULx7Gp2ZqyfeXaGDJo6QSh1+s0RY9x5XJlb4lQy3Py6R
	 jsU6qd1+OLhkg==
Received: by mail-ed1-f48.google.com with SMTP id x3so32395403edb.10
        for <kexec@lists.infradead.org>; Mon, 27 Mar 2023 01:28:09 -0700 (PDT)
X-Gm-Message-State: AO0yUKXTSFtw2va6kSblTlK9rleHu3Zkw4oL2sw0ie+e5pSVr27pJrcw
	lOl7zuQLjppSPx15UDJPCgayZBbOnYnInsmMJCc=
X-Google-Smtp-Source: AK7set8eQPhVIihp6kWmI7Z0Yti48QvMdeoo36W8n/BL+TlyZs0ZjhVT2QxVBD/wrJkzDxcs0dIHYyWba8naxh7FMtk=
X-Received: by 2002:a05:6402:540c:b0:4fb:e069:77ac with SMTP id
 ev12-20020a056402540c00b004fbe06977acmr12462537edb.0.1679905688080; Mon, 27
 Mar 2023 01:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221020031548.47587-1-xianting.tian@linux.alibaba.com>
 <Y1K6TsGGC3KnFlf8@vergenet.net> <44c6ec02-ab91-a9ba-a0b8-fed6b93b82d4@linux.alibaba.com>
 <c87af556-1996-bc22-52da-1da23761d591@linux.alibaba.com> <ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
In-Reply-To: <ZCD2wkLCIAztKb/C@MiWiFi-R3L-srv>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 27 Mar 2023 16:27:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
Message-ID: <CAJF2gTQgZZDgh384E_a1AavzQwt04F46G=EPAWMprqDgkNua0A@mail.gmail.com>
Subject: Re: [PATCH V2] RISC-V: Add support for riscv kexec/kdump on kexec-tools
To: "xianting_100@126.com" <xianting_100@126.com>
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>, Simon Horman <horms@kernel.org>, 
	kexec@lists.infradead.org, wefu@redhat.com, yixun.lan@gmail.com, 
	Baoquan He <bhe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_012813_630691_967D0A77 
X-CRM114-Status: GOOD (  38.87  )
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

Ri5ZLkkKCnhpYW50aW5nXzEwMEAxMjYuY29tCgpPbiBNb24sIE1hciAyNywgMjAyMyBhdCA5OjUy
4oCvQU0gQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gSGkgWGlhbnRpbmcs
Cj4KPiBPbiAxMC8yNi8yMiBhdCAxMDo1OWFtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+ID4KPiA+
IOWcqCAyMDIyLzEwLzI2IOS4iuWNiDEwOjEzLCBYaWFudGluZyBUaWFuIOWGmemBkzoKPiA+ID4g
SGkgU2ltb24KPiA+ID4KPiA+ID4gdGhhbmtzIGZvciB0aGUgY29tbWVudHMKPiA+ID4KPiA+ID4g
5ZyoIDIwMjIvMTAvMjEg5LiL5Y2IMTE6MjcsIFNpbW9uIEhvcm1hbiDlhpnpgZM6Cj4gPiA+ID4g
T24gVGh1LCBPY3QgMjAsIDIwMjIgYXQgMTE6MTU6NDhBTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3
cm90ZToKPiA+ID4gPiA+IEZyb206IE5pY2sgS29zc2lmaWRpcyA8bWlja0BpY3MuZm9ydGguZ3I+
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIGxvYWRpbmcg
dGhlIEVMRiBrZXJuZWwgaW1hZ2UuIEl0IHBhcnNlcwo+ID4gPiA+ID4gdGhlIGN1cnJlbnQvcHJv
dmlkZWQgZGV2aWNlIHRyZWUgdG8gZGV0ZXJtaW5lIHRoZSBzeXN0ZW0ncyBtZW1vcnkKPiA+ID4g
PiA+IGxheW91dCwgYW5kIC9wcm9jL2lvbWVtIGZvciB0aGUgdmFyaW91cyBrZXJuZWwgc2VnbWVu
dHMuCj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhpcyBwYXRjaCB3YXMgZmlyc3RseSBkZXZlbG9wZWQg
YnkgTmljayBLb3NzaWZpZGlzLCBhbmQgdHdvIGZpeGVzICgKPiA+ID4gPiA+ICAgICAxOiBmYWls
IHRvIGZpbmQgZnJlZSBtZW1vcnkgYXJlYSBmb3IgZHRiIGxvYWQgd2hlbiB1c2luZwo+ID4gPiA+
ID4gaW5pdHJkIGltYWdlLAo+ID4gPiA+ID4gbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtcmlzY3YvMjAyMi1BdWd1c3QvMDE4Mzk4Lmh0bWw7Cj4gPiA+ID4gPiAgICAgMjogZml4
IG1lbW9yeSByYW5nZSBzaXplIGNhbGN1bGF0aW9uLAo+ID4gPiA+ID4gICAgICAgICBrZXhlYy9h
cmNoL3Jpc2N2L2NyYXNoZHVtcC1yaXNjdi5jOmxpbmUgODUKPiA+ID4gPiA+ICkgYXJlIGNvbnRy
aWJ1dGVkIGJ5IFlpeHVuIExhbiwgWGlhbnRpbmcgVGlhbi4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBU
ZXN0ZWQgb24gUWVtdSdzIHJ2NjQgdmlydCBtYWNoaW5lIGFuZCBTb0Mgb2YgVC1IZWFkIFJJU0Mt
Vgo+ID4gPiA+ID4gWHVhbnRpZSA5MTAgQ1BVLgo+ID4gPiA+IEhpLAo+ID4gPiA+Cj4gPiA+ID4g
dGhhbmtzIGZvciBzb21lIHBhdGNoLgo+ID4gPiA+Cj4gPiA+ID4gU29tZSBtaW5vciBmZWVkYmFj
ayBmb2xsb3dzLgo+ID4gPiA+Cj4gPiA+ID4gU2VwYXJhdGVseSwgSSdsbCBwb3N0IGEgcGF0Y2gg
dG8gYWRkIFJJU0MtViBidWlsZHMgdG8gdGhlIGdpdGh1Ygo+ID4gPiA+IHdvcmtmbG93LiBJZiB5
b3UgY291bGQgaW5jbHVkZSB0aGF0IGluIFYzIEknZCBiZSBtb3N0IGdyYXRlZnVsLgo+ID4gPiA+
Cj4gPiA+ID4gPiBUZXN0ZWQtYnk6IFlpeHVuIExhbiA8eWl4dW4ubGFuQGdtYWlsLmNvbT4KPiA+
ID4gPiA+IENvLWRldmVsb3BlZC1ieTogWGlhbnRpbmcgVGlhbiA8eGlhbnRpbmcudGlhbkBsaW51
eC5hbGliYWJhLmNvbT4KPiA+ID4gPiA+IENvLWRldmVsb3BlZC1ieTogWWl4dW4gTGFuIDx5aXh1
bi5sYW5AZ21haWwuY29tPgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTmljayBLb3NzaWZpZGlz
IDxtaWNrQGljcy5mb3J0aC5ncj4KPiA+ID4gPiAuLi4KPiA+ID4gPgo+ID4gPiA+ID4gKyAgICBy
ZXQgPSBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkKG1lbV9yYW5nZXMsIHN0YXJ0LAo+ID4gPiA+
ID4gKyAgICAgICAgICAgICAgICAgICAgZW5kIC0gc3RhcnQsIHR5cGUpOwo+ID4gPiA+IG1lbV9y
ZWdpb25zX2FsbG9jX2FuZF9hZGQgaXNuJ3QgYWx3YXlzIGF2YWlsYWJsZS4KPiA+ID4gPiBmLmUu
IG9uIG1pcHMgdGhpcyBjYXVzZXMgYSBidWlsZCBmYWlsdXJlLgo+ID4gPiA+Cj4gPiA+ID4gUmVm
OiBodHRwczovL2dpdGh1Yi5jb20vaG9ybXMva2V4ZWMtdG9vbHMvYWN0aW9ucy9ydW5zLzMyOTg0
OTExNDMvam9icy81NDQwNjc3NTk1Cj4gPiA+Cj4gPiA+IEFzIHlvdSBrbm93LCBtZW1fcmVnaW9u
c19zb3J0LCBtZW1fcmVnaW9uc19hbGxvY19hbmRfYWRkIGFyZSB0aGUgY29tbW9uCj4gPiA+IGZ1
bnRpb25zLAo+ID4gPgo+ID4gPiBUaGUgYnVpbGQgZXJyb3Igb2YgbWlwcyBpcyBjYXVzZWQgYnkg
dGhpcyByaXNjdiBwYXRjaD8KPiA+ID4KPiA+ID4ga2V4ZWMvbWVtX3JlZ2lvbnMuYzp2b2lkIG1l
bV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9yYW5nZXMgKnJhbmdlcykKPiA+ID4ga2V4ZWMv
bWVtX3JlZ2lvbnMuaDp2b2lkIG1lbV9yZWdpb25zX3NvcnQoc3RydWN0IG1lbW9yeV9yYW5nZXMg
KnJhbmdlcyk7Cj4gPiA+Cj4gPiA+Cj4gPiA+IGtleGVjL21lbV9yZWdpb25zLmM6aW50IG1lbV9y
ZWdpb25zX2FsbG9jX2FuZF9hZGQoc3RydWN0IG1lbW9yeV9yYW5nZXMKPiA+ID4gKnJhbmdlcywK
PiA+ID4ga2V4ZWMvbWVtX3JlZ2lvbnMuaDppbnQgbWVtX3JlZ2lvbnNfYWxsb2NfYW5kX2FkZChz
dHJ1Y3QgbWVtb3J5X3Jhbmdlcwo+ID4gPiAqcmFuZ2VzLAo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4g
Li4uCj4gPiA+ID4KPiA+ID4gPiA+ICtpbnQgZHRiX2dldF9tZW1vcnlfcmFuZ2VzKGNoYXIgKmR0
Yiwgc3RydWN0IG1lbW9yeV9yYW5nZXMKPiA+ID4gPiA+ICptZW1fcmFuZ2VzLCBzdHJ1Y3QgbWVt
b3J5X3JhbmdlcyAqZXh0cmFfcmFuZ2VzKQo+ID4gPiA+ID4gK3sKPiA+ID4gPiAuLi4KPiA+ID4g
Pgo+ID4gPiA+ID4gKyAgICBtZW1fcmVnaW9uc19zb3J0KG1lbV9yYW5nZXMpOwo+ID4gPiA+IExp
a2V3aXNlLCBtZW1fcmVnaW9uc19zb3J0IGlzbid0IGFsd2F5cyBhdmFpbGFibGUuCj4gPiA+ID4g
Zi5lLiBvbiBtaXBzIHRoaXMgY2F1c2VzIGEgYnVpbGQgZmFpbHVyZS4KPiA+ID4gPgo+ID4gPiA+
IC4uLgo+ID4gPiA+Cj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvcHVyZ2F0b3J5L2FyY2gvcmlzY3Yv
TWFrZWZpbGUKPiA+ID4gPiA+IGIvcHVyZ2F0b3J5L2FyY2gvcmlzY3YvTWFrZWZpbGUKPiA+ID4g
PiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiA+ID4gPiBpbmRleCAwMDAwMDAwLi44YmRlZDcx
Cj4gPiA+ID4gPiAtLS0gL2Rldi9udWxsCj4gPiA+ID4gPiArKysgYi9wdXJnYXRvcnkvYXJjaC9y
aXNjdi9NYWtlZmlsZQo+ID4gPiA+ID4gQEAgLTAsMCArMSw3IEBACj4gPiA+ID4gPiArIwo+ID4g
PiA+ID4gKyMgUHVyZ2F0b3J5IHJpc2N2Cj4gPiA+ID4gPiArIwo+ID4gPiA+ID4gKwo+ID4gPiA+
ID4gK3Jpc2N2X1BVUkdBVE9SWV9TUkNTID0KPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICtkaXN0ICs9
IHB1cmdhdG9yeS9hcmNoL3NoL01ha2VmaWxlICQocmlzY3ZfUFVSR0FUT1JZX1NSQ1MpCj4gPiA+
ID4gcy9zaC9yaXNjdi8KPiA+ID4gPgo+ID4gPiA+IEVsc2UgdGhlIGRpc3RyaWJ1dGlvbiB0YXJi
YWxsIHdvbid0IGluY2x1ZGUgdGhpcyBNYWtlZmlsZQo+ID4gPiA+Cj4gPiA+ID4gWW91IGNhbiBl
eGVyY2lzZSB0aGlzIHVzaW5nOgo+ID4gPiA+ICAgIG1ha2UgZGlzdGNoZWNrIERJU1RDSEVDS19D
T05GSUdVUkVfRkxBR1M9Ii0taG9zdD1yaXNjdjY0LWxpbnV4LWdudSIKPiA+ID4gdGhhbmtzLCBJ
IHdpbGwgZml4IHRoaXMuCj4gPgo+ID4gdGhlIGZpeCBpcyBpbiBteSBwZXJzb25hbCBnaXRlZQo+
ID4KPiA+IGh0dHBzOi8vZ2l0ZWUuY29tL3hpYW50aW5nLXRpYW4va2V4ZWMtdG9vbHMvY29tbWl0
cy9tYXN0ZXIKPgo+IElzIHRoaXMgcGF0Y2hzZXQgcmVwb3N0aW5nIHN0aWxsIGluIHlvdXIgd29y
a2luZyBwbGFuPyBJIGRvbid0IHNlZSB0aGUKPiBjb2RlIGluIGtleGUtdG9vbHMsIHNvIHBpbmcg
dG8gYXNrLgo+Cj4gSWYgdGhpcyBpcyBub3QgeW91ciB3b3JrIHRhc2tzIGFueSBtb3JlLCBwZW9w
bGUgaW50ZXJlc3RlZCBjYW4gcGljayB0aGlzCj4gcGF0Y2hzZXQgYW5kIHBvc3QgYWZ0ZXIgcG9s
aXNoaW5nLgo+Cj4gVGhhbmtzCj4gQmFvcXVhbgo+CgoKLS0gCkJlc3QgUmVnYXJkcwogR3VvIFJl
bgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

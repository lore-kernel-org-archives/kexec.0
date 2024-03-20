Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875F4C54E58
	for <kexec@archiver.kernel.org>; Wed, 20 Mar 2024 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sBiuBcsaaKDQSsOb9pZg/xhgdxtplUszd+4yxoE5HY0=; b=3ZrSx9EG9Zlcvl
	RBksvC28LpPgYV6K2OUHmwPJ/HKTHKzuO/VAf80xPoP59pRsGbHikXS7FN7/vXEW6Ww3/YkSGvMZ2
	AnrOCUQjPnDW1Omh/XA649FQn9ocmk4lPNZO02M3WPcdvxM6swn03RILzCTaUEfn4b97oQ/CG/xDA
	TjIGFj235vRwjRBEkPpu/CA6deGZGYQ0rNGNroeqzDI2usscLMpwMSCsumdVni2pyk1modXrXr0G3
	Dz1xp3qP9VQrTCrYTAeCkKDOMPQ+L5ygZ9PLPV0BXSKNNPSA7MvtZOyDSxwtUq6tD+QpF/vpqcSRi
	jvqHKSE60qhkm9Wac+ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmvnt-0000000HEbu-0ALO;
	Wed, 20 Mar 2024 13:16:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmvnn-0000000HEaJ-2tgm
	for kexec@lists.infradead.org;
	Wed, 20 Mar 2024 13:16:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710940573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xedtlwQKGSj2FZUSBGp+gGQ1nyxBUFvCh/rAUoEHjUU=;
	b=WIm/Dp05WBrlaOBBpNhkoxk1QsvXoWbjoJMwPXCShvn65LY3wDWkp0P4kFcv/67pv4gOTA
	jXT+43FCxWer8sAW4xsgYRLzAb+jEcHAy7EBCsYo/9PjQvyPsCrF+Tret11ubO5EwG1SuB
	psZicJ6tir2f8cuCin/TxBQWFodPEbU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-55BhU2ZKPseUT4F3QBbX2A-1; Wed,
 20 Mar 2024 09:16:09 -0400
X-MC-Unique: 55BhU2ZKPseUT4F3QBbX2A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 710C23815EE2;
	Wed, 20 Mar 2024 13:16:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F02DB492BD4;
	Wed, 20 Mar 2024 13:16:06 +0000 (UTC)
Date: Wed, 20 Mar 2024 21:15:59 +0800
From: Baoquan He <bhe@redhat.com>
To: Changhui Zhong <czhong@redhat.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, kexec@lists.infradead.org,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	chenhuacai@kernel.org, x86@kernel.org
Subject: Re: [bug report] WARNING: CPU: 0 PID: 1 at kernel/resource.c:834
 __insert_resource+0x84/0x110
Message-ID: <Zfrhj3rJpZKRSDWn@MiWiFi-R3L-srv>
References: <CAGVVp+U+s692sC8-ioGQ7aP2shhQ6qyGOThVk=L6P4_XovDo5Q@mail.gmail.com>
 <73a510c8-51a0-4a4a-1aa8-7bdcd4cdde22@linux.intel.com>
 <ZfmkXw6pEBP73Txt@MiWiFi-R3L-srv>
 <CAGVVp+W2eHM5znGhMFb6xWWWUF4FYJ9FrEGVqKm0jWW+YO1cjg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGVVp+W2eHM5znGhMFb6xWWWUF4FYJ9FrEGVqKm0jWW+YO1cjg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_061622_656502_2204A3FE 
X-CRM114-Status: GOOD (  28.23  )
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

T24gMDMvMjAvMjQgYXQgMDU6MDZwbSwgQ2hhbmdodWkgWmhvbmcgd3JvdGU6Cj4gT24gVHVlLCBN
YXIgMTksIDIwMjQgYXQgMTA6NDPigK9QTSBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4gPgo+ID4gT24gMDMvMTkvMjQgYXQgMDE6NTlwbSwgSWxwbyBKw6RydmluZW4gd3JvdGU6
Cj4gPiA+IE9uIFR1ZSwgMTkgTWFyIDIwMjQsIENoYW5naHVpIFpob25nIHdyb3RlOgo+ID4gPgo+
ID4gPiA+IEhlbGxvLAo+ID4gPiA+Cj4gPiA+ID4gZm91bmQgYSBrZXJuZWwgd2FybmluZyBpc3N1
ZSBhdCAia2VybmVsL3Jlc291cmNlLmM6ODM0Cj4gPiA+ID4gX19pbnNlcnRfcmVzb3VyY2UrMHg4
NC8weDExMCIgLHBsZWFzZSBoZWxwIGNoZWNrLAo+ID4gPiA+Cj4gPiA+ID4gcmVwbzpodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5n
aXQKPiA+ID4gPiBicmFuY2g6IG1hc3Rlcgo+ID4gPiA+IGNvbW1pdCBIRUFEOmY2Y2VmNWY4YzM3
ZjU4YTNiYzk1YjM3NTRjM2FlOThlMDg2NjMxY2EKPiA+ID4gPgo+ID4gPiA+ICBbICAgIDAuMTMw
MTY0XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPiA+ID4gPiBbICAgIDAu
MTMwMzcwXSBXQVJOSU5HOiBDUFU6IDAgUElEOiAxIGF0IGtlcm5lbC9yZXNvdXJjZS5jOjgzNAo+
ID4gPiA+IF9faW5zZXJ0X3Jlc291cmNlKzB4ODQvMHgxMTAKPiA+ID4gPiBbICAgIDAuMTMxMzY0
XSBNb2R1bGVzIGxpbmtlZCBpbjoKPiA+ID4gPiBbICAgIDAuMTMyMzY0XSBDUFU6IDAgUElEOiAx
IENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjguMCsgIzEKPiA+ID4gPiBbICAgIDAuMTMz
MzY1XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJFZGdlIFI2NDAvMDZES1k1LCBCSU9T
Cj4gPiA+ID4gMi4xNS4xIDA2LzE1LzIwMjIKPiA+ID4gPiBbICAgIDAuMTM0MzY0XSBSSVA6IDAw
MTA6X19pbnNlcnRfcmVzb3VyY2UrMHg4NC8weDExMAo+ID4gPiA+IFsgICAgMC4xMzUzNjRdIENv
ZGU6IGQwIDRjIDM5IGMxIDc2IGIxIGMzIGNjIGNjIGNjIGNjIDRjIDhkIDRhIDMwIDQ4Cj4gPiA+
ID4gOGIgNTIgMzAgNDggODUgZDIgNzUgYjcgNDggODkgNTYgMzAgNDkgODkgMzEgNDggODkgNDYg
MjggMzEgYzAgYzMgY2MKPiA+ID4gPiBjYyBjYyBjYyA8MGY+IDBiIDQ4IDg5IGQwIGMzIGNjIGNj
IGNjIGNjIDQ5IDg5IGQyIGViIDFhIDRkIDM5IDQyIDA4IDc3Cj4gPiA+ID4gMTkgNGQKPiA+ID4g
PiBbICAgIDAuMTM2MzYzXSBSU1A6IDAwMDA6ZmZmZmIyNTc0MDBkZmUwOCBFRkxBR1M6IDAwMDEw
MjQ2Cj4gPiA+ID4gWyAgICAwLjEzNzM2M10gUkFYOiBmZmZmOWUxNDdmZmNhNjQwIFJCWDogMDAw
MDAwMDAwMDAwMDAwMCBSQ1g6IDAwMDAwMDAwMjYwMDAwMDAKPiA+ID4gPiBbICAgIDAuMTM4MzYz
XSBSRFg6IGZmZmZmZmZmODZjNDVlZTAgUlNJOiBmZmZmZmZmZjg2YzQ1ZWUwIFJESTogMDAwMDAw
MDAyNjAwMDAwMAo+ID4gPiA+IFsgICAgMC4xMzkzNjNdIFJCUDogZmZmZmZmZmY4Njg0ZDEyMCBS
MDg6IDAwMDAwMDAwMzVmZmZmZmYgUjA5OiAwMDAwMDAwMDM1ZmZmZmZmCj4gPiA+ID4gWyAgICAw
LjE0MDM2M10gUjEwOiAwMDAwMDAwMDJmMzE2NDZmIFIxMTogMDAwMDAwMDA1OWE3ZmZlZSBSMTI6
IGZmZmZmZmZmODZjNDVlZTAKPiA+ID4gPiBbICAgIDAuMTQxMzYzXSBSMTM6IDAwMDAwMDAwMDAw
MDAwMDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+
IFsgICAgMC4xNDIzNjNdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOWUxMjc3
ODAwMDAwKDAwMDApCj4gPiA+ID4ga25sR1M6MDAwMDAwMDAwMDAwMDAwMAo+ID4gPiA+IFsgICAg
MC4xNDMzNjNdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMKPiA+ID4gPiBbICAgIDAuMTQ0MzYzXSBDUjI6IGZmZmY5ZTEzMzM2MDEwMDAgQ1IzOiAwMDAw
MDAwMzMyMjIwMDAxIENSNDogMDAwMDAwMDAwMDc3MDZmMAo+ID4gPiA+IFsgICAgMC4xNDUzNjNd
IERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAw
MDAwMDAwMDAwCj4gPiA+ID4gWyAgICAwLjE0NjM2M10gRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERS
NjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKPiA+ID4gPiBbICAgIDAu
MTQ3MzYzXSBQS1JVOiA1NTU1NTU1NAo+ID4gPiA+IFsgICAgMC4xNDgzNjNdIENhbGwgVHJhY2U6
Cj4gPiA+ID4gWyAgICAwLjE0OTM2NF0gIDxUQVNLPgo+ID4gPiA+IFsgICAgMC4xNTAzNjVdICA/
IF9fd2FybisweDdmLzB4MTMwCj4gPiA+ID4gWyAgICAwLjE1MTM2M10gID8gX19pbnNlcnRfcmVz
b3VyY2UrMHg4NC8weDExMAo+ID4gPiA+IFsgICAgMC4xNTIzNjRdICA/IHJlcG9ydF9idWcrMHgx
OGEvMHgxYTAKPiA+ID4gPiBbICAgIDAuMTUzMzY0XSAgPyBoYW5kbGVfYnVnKzB4M2MvMHg3MAo+
ID4gPiA+IFsgICAgMC4xNTQzNjNdICA/IGV4Y19pbnZhbGlkX29wKzB4MTQvMHg3MAo+ID4gPiA+
IFsgICAgMC4xNTUzNjNdICA/IGFzbV9leGNfaW52YWxpZF9vcCsweDE2LzB4MjAKPiA+ID4gPiBb
ICAgIDAuMTU2MzY0XSAgPyBfX2luc2VydF9yZXNvdXJjZSsweDg0LzB4MTEwCj4gPiA+ID4gWyAg
ICAwLjE1NzM2NF0gID8gYWRkX2RldmljZV9yYW5kb21uZXNzKzB4NzUvMHhhMAo+ID4gPiA+IFsg
ICAgMC4xNTgzNjNdICBpbnNlcnRfcmVzb3VyY2UrMHgyNi8weDUwCj4gPiA+ID4gWyAgICAwLjE1
OTM2NF0gID8gX19wZnhfaW5zZXJ0X2NyYXNoa2VybmVsX3Jlc291cmNlcysweDEwLzB4MTAKPiA+
ID4gPiBbICAgIDAuMTYwMzYzXSAgaW5zZXJ0X2NyYXNoa2VybmVsX3Jlc291cmNlcysweDYyLzB4
NzAKPiA+ID4KPiA+ID4gSGksCj4gPiA+Cj4gPiA+IFRoaXMgc2VlbXMgcmVsYXRlZCB0byBjcmFz
aGtlcm5lbCBzdHVmZiwgSSBhZGRlZCBhIGZldyBDY3MgcmVsYXRlZCB0bwo+ID4gPiBpdC4KPiA+
ID4KPiA+ID4gSSBkb24ndCBrbm93IHdoeSB5b3Ugc2VudCB0aGlzIG9ubHkgdG8gbGludXgtcGNp
IGxpc3QgYXMgaXQgc2VlbXMgbGlrZWx5Cj4gPiA+IHRvIGJlIGVudGlyZWx5IHVucmVsYXRlZCB0
byBQQ0kuCj4gPgo+ID4gVG9vIGZldyBpbmZvIGlzIHByb3ZpZGVkLiBJIGd1ZXNzIHRoaXMgaXMg
aGFwcGVuaW5nIG9uIHg4Nl82NC4gRG8geW91Cj4gPiBoYXZlIHRoZSBrZXJuZWwgY29uZmlnLCBh
bmQgd2hhdCBrZXJuZWwgeW91IGFyZSB0ZXN0aW5nPyBXaGF0IG9wZXJhdGlvbgo+ID4gYXJlIHlv
dSB0YWtpbmcgdG8gdHJpZ2dlciB0aGlzPwo+IAo+IHllc++8jG15IHNlcnZlciBpcyB4ODZfNjQg
cGxhdGZvcm3vvIxiYXNlIE9TIGlzIFJIRUw5LjXvvIx0aGUgZGVmYXVsdCBrZXJuZWwKPiBpcyAg
NS4xNC4wLTQyOC5lbDkueDg2XzY077yMCj4gYW5kIHRoaXMgaXNzdWUgaXMgdHJpZ2dlcmVkIGFm
dGVyIGNvbXBpbGUgYW5kIGluc3RhbGxlZCB0aGUgdXBzdHJlYW0KPiBrZXJuZWzvvIg2LjguMCvv
vIl0aGVuIHJlYm9vdCB0aGUgbWFjaGluZS4KPiBJIGRvbid0IGhhdmUgdGhlIGtlcm5lbCBjb25m
aWcgZmlsZSBub3csIGlmIG5lZWRlZCBJIGNhbiByZWluc3RhbGwgYW5kCj4gY29sbGVjdCBpdO+8
jAo+IAo+ID4KPiA+IEJlbG93IGNvbW1pdCBjb3VsZCBiZSBzdXNwZWN0LCBidXQgbm90IHN1cmUg
aWYgaXQncyB0aGUgcmVhbCBjcmltaW5hbC4KPiA+Cj4gPiBjb21taXQgNGE2OTNjZTY1YjE4NmZk
ZGMxYTczNjIxYmQ2Zjk0MWU2ZTNlY2EyMQo+ID4gQXV0aG9yOiBIdWFjYWkgQ2hlbiA8Y2hlbmh1
YWNhaUBrZXJuZWwub3JnPgo+ID4gRGF0ZTogICBGcmkgRGVjIDI5IDE2OjAyOjEzIDIwMjMgKzA4
MDAKPiA+Cj4gPiAgICAga2R1bXA6IGRlZmVyIHRoZSBpbnNlcnRpb24gb2YgY3Jhc2hrZXJuZWwg
cmVzb3VyY2VzCj4gPgo+ID4gRGF2ZSByZXBvcnRlZCBhIHNpbWlsYXIgb25lLCBoZSBkaWQga2V4
ZWMgcmVib290IGZpcnN0bHksIHRoZW4gaW4gMm5kCj4gPiBrZXJuZWwgY3Jhc2hrZXJuZWwgcmVz
ZXJ2YXRpb24gd2lsbCB0cmlnZ2VyIHRoZSBpb21lbSBpbnNlcnRpbmcgZXJyb3IuCj4gPgo+ID4g
W1BBVENIXSB4ODYva2V4ZWM6IGRvIG5vdCB1cGRhdGUgRTgyMCBrZXhlYyB0YWJsZSBmb3Igc2V0
dXBfZGF0YQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1plWjJLb3MtT09aTlNybU9A
ZGFya3N0YXIudXNlcnMuaXBhLnJlZGhhdC5jb20vVC8jdQo+ID4KPiA+IENhbiB5b3UgdHJ5IERh
dmUncyBwYXRjaCBmaXJzdGx5PyBJZiBpdCBkb2Vzbid0IHdvcmssIHRyeSByZXZlcnRpbmcKPiA+
IGFib3ZlIEh1YWNhaSdzIHBhdGNoPyBpdCBtYXkgbmVlZCBtYW51YWwgZWRpdGluZy4KPiA+Cj4g
Cj4gSSBkb24ndCBrbm93IGhvdyB0byByZXZlcnQgSHVhY2FpJ3MgcGF0Y2gsIEkgZG9uJ3Qga25v
dyBtdWNoIGFib3V0IGl0LAo+IHNv77yMSSB0cnkgdG8gYXBwbHkgRGF2ZeKAmHMgcGF0Y2jvvIxi
dXQgaXQgZmFpbGVk77yaCj4gYGBgCj4gcGF0Y2hpbmcgZmlsZSBhcmNoL3g4Ni9rZXJuZWwvZTgy
MC5jCj4gSHVuayAjMSBGQUlMRUQgYXQgMTAxNS4KPiBIdW5rICMyIHN1Y2NlZWRlZCBhdCAxMDM4
IChvZmZzZXQgMiBsaW5lcykuCj4gSHVuayAjMyBzdWNjZWVkZWQgYXQgMTA0OCAob2Zmc2V0IDIg
bGluZXMpLgo+IDEgb3V0IG9mIDMgaHVua3MgRkFJTEVEIC0tIHNhdmluZyByZWplY3RzIHRvIGZp
bGUgYXJjaC94ODYva2VybmVsL2U4MjAuYy5yZWoKPiBgYGAKPiBtYXliZSBEYXZlIG5lZWQgdG8g
d3JpdGUgYSBuZXcgdmVyc2lvbiB0byBmaXggaXQsCgpObywgcGxlYXNlIGdvIGdldCB5b3VyIGNv
bGxlYWd1ZXMnIGhlbHAuIFRoZXJlIG11c3QgYmUgcGVvcGxlIGFyb3VuZCB5b3UKa25vd2luZyBo
b3cgdG8gaGFuZGxlIHRoaXMuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

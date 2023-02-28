Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E33C64ED6
	for <kexec@archiver.kernel.org>; Tue, 28 Feb 2023 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QWHTcvoQ5sRDMaO36fo1kW//rVSlDZwhyIruVsQHEZ4=; b=svCSnop0vOOgHP
	YVFXouAsCtJsnHqgOFvBtYQGpDekADBY48p0wBKfPXWKpVvpzsduoZXsvbmNjssQS0mvH/LdnbtZe
	ws2mLV333NGM3en/ST6G6bl/PZN4o9+hieQvQAUsvjpS+yIAA89uwwwL8C/sDyVxb5FpHjXN86hly
	p5qamsln6LsFTAKPFiWziCn0y3x69KkWAUzsbqmNC858d4yy7632/8uqczgjU7d+Pj7OUNPYkZePw
	LaFgyI5zYe7/PtGinpBCVDLj2sh4k+8351EO8jrrHhVkweHAsRmewJX0zD5caIwQczFtNU99RULae
	LmORlybqSzmv8Xv70PNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX0af-00DOYy-Ce; Tue, 28 Feb 2023 14:04:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pX0ab-00DOVs-3n
	for kexec@lists.infradead.org; Tue, 28 Feb 2023 14:04:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1677593051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ESrld006RWsyPkhdVerW4JO9w3LuFA1DAtayIv7Uao=;
	b=IGKNQhbH+Jsqio4Fsbym7/ciassEdJQzjXm9uf9C2m5Cz9uY2f6GFw/Nn3dhEeQWzhapb/
	uB1Ekqd9PWgAdeCSHQr+Eg7SY7eqxmFBRbcaloZr9nRNh9/3v7sy8NbT0ddCCEtRuaonQM
	gqNBcfQx+U4GvjZR/IaS+LOvQtFmrHk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-ee3cnWmIMkS4QAFkSqBm9Q-1; Tue, 28 Feb 2023 09:04:05 -0500
X-MC-Unique: ee3cnWmIMkS4QAFkSqBm9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C74C61871D9A;
	Tue, 28 Feb 2023 14:03:56 +0000 (UTC)
Received: from localhost (ovpn-13-194.pek2.redhat.com [10.72.13.194])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4401418EC6;
	Tue, 28 Feb 2023 14:03:54 +0000 (UTC)
Date: Tue, 28 Feb 2023 22:03:49 +0800
From: Baoquan He <bhe@redhat.com>
To: "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"vgoyal@redhat.com" <vgoyal@redhat.com>,
	"dyoung@redhat.com" <dyoung@redhat.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"horms@verge.net.au" <horms@verge.net.au>,
	"k-hagio-ab@nec.com" <k-hagio-ab@nec.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
	"ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC][nvdimm][crash] pmem memmap dump support
Message-ID: <Y/4JxQtnmYrZgVwF@MiWiFi-R3L-srv>
References: <3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com>
MIME-Version: 1.0
In-Reply-To: <3c752fc2-b6a0-2975-ffec-dba3edcf4155@fujitsu.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_060422_867897_5A2690D1 
X-CRM114-Status: GOOD (  32.96  )
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

T24gMDIvMjMvMjMgYXQgMDY6MjRhbSwgbGl6aGlqaWFuQGZ1aml0c3UuY29tIHdyb3RlOgo+IEhl
bGxvIGZvbGtzLAo+IAo+IFRoaXMgbWFpbCByYWlzZXMgYSBwbWVtIG1lbW1hcCBkdW1wIHJlcXVp
cmVtZW50IGFuZCBwb3NzaWJsZSBzb2x1dGlvbnMsIGJ1dCB0aGV5IGFyZSBhbGwgc3RpbGwgcHJl
bWF0dXJlLgo+IEkgcmVhbGx5IGhvcGUgeW91IGNhbiBwcm92aWRlIHNvbWUgZmVlZGJhY2suCj4g
Cj4gcG1lbSBtZW1tYXAgY2FuIGFsc28gYmUgY2FsbGVkIHBtZW0gbWV0YWRhdGEgaGVyZS4KPiAK
PiAjIyMgQmFja2dyb3VuZCBhbmQgbW90aXZhdGUgb3ZlcnZpZXcgIyMjCj4gLS0tCj4gQ3Jhc2gg
ZHVtcCBpcyBhbiBpbXBvcnRhbnQgZmVhdHVyZSBmb3IgdHJvdWJsZSBzaG9vdGluZyBvZiBrZXJu
ZWwuIEl0IGlzIHRoZSBmaW5hbCB3YXkgdG8gY2hhc2Ugd2hhdAo+IGhhcHBlbmVkIGF0IHRoZSBr
ZXJuZWwgcGFuaWMsIHNsb3dkb3duLCBhbmQgc28gb24uIEl0IGlzIHRoZSBtb3N0IGltcG9ydGFu
dCB0b29sIGZvciBjdXN0b21lciBzdXBwb3J0Lgo+IEhvd2V2ZXIsIGEgcGFydCBvZiBkYXRhIG9u
IHBtZW0gaXMgbm90IGluY2x1ZGVkIGluIGNyYXNoIGR1bXAsIGl0IG1heSBjYXVzZSBkaWZmaWN1
bHR5IHRvIGFuYWx5emUKPiB0cm91YmxlIGFyb3VuZCBwbWVtIChlc3BlY2lhbGx5IEZpbGVzeXN0
ZW0tREFYKS4KPiAKPiAKPiBBIHBtZW0gbmFtZXNwYWNlIGluICJmc2RheCIgb3IgImRldmRheCIg
bW9kZSByZXF1aXJlcyBhbGxvY2F0aW9uIG9mIHBlci1wYWdlIG1ldGFkYXRhWzFdLiBUaGUgYWxs
b2NhdGlvbgo+IGNhbiBiZSBkcmF3biBmcm9tIGVpdGhlciBtZW0oc3lzdGVtIG1lbW9yeSkgb3Ig
ZGV2KHBtZW0gZGV2aWNlKSwgc2VlIGBuZGN0bCBoZWxwIGNyZWF0ZS1uYW1lc3BhY2VgIGZvcgo+
IG1vcmUgZGV0YWlscy4gSW4gZnNkYXgsIHN0cnVjdCBwYWdlIGFycmF5IGJlY29tZXMgdmVyeSBp
bXBvcnRhbnQsIGl0IGlzIG9uZSBvZiB0aGUga2V5IGRhdGEgdG8gZmluZAo+IHN0YXR1cyBvZiBy
ZXZlcnNlIG1hcC4KPiAKPiBTbywgd2hlbiBtZXRhZGF0YSB3YXMgc3RvcmVkIGluIHBtZW0sIGV2
ZW4gcG1lbSdzIHBlci1wYWdlIG1ldGFkYXRhIHdpbGwgbm90IGJlIGR1bXBlZC4gVGhhdCBtZWFu
cwo+IHRyb3VibGVzaG9vdGVycyBhcmUgdW5hYmxlIHRvIGNoZWNrIG1vcmUgZGV0YWlscyBhYm91
dCBwbWVtIGZyb20gdGhlIGR1bXBmaWxlLgo+IAo+ICMjIyBNYWtlIHBtZW0gbWVtbWFwIGR1bXAg
c3VwcG9ydCAjIyMKPiAtLS0KPiBPdXIgZ29hbCBpcyB0aGF0IHdoZXRoZXIgbWV0YWRhdGEgaXMg
c3RvcmVkIG9uIG1lbSBvciBwbWVtLCBpdHMgbWV0YWRhdGEgY2FuIGJlIGR1bXBlZCBhbmQgdGhl
biB0aGUKPiBjcmFzaC11dGlsaXRpZXMgY2FuIHJlYWQgbW9yZSBkZXRhaWxzIGFib3V0IHRoZSBw
bWVtLiBPZiBjb3Vyc2UsIHRoaXMgZmVhdHVyZSBjYW4gYmUgZW5hYmxlZC9kaXNhYmxlZC4KPiAK
PiBGaXJzdCwgYmFzZWQgb24gb3VyIHByZXZpb3VzIGludmVzdGlnYXRpb24sIGFjY29yZGluZyB0
byB0aGUgbG9jYXRpb24gb2YgbWV0YWRhdGEgYW5kIHRoZSBzY29wZSBvZgo+IGR1bXAsIHdlIGNh
biBkaXZpZGUgaXQgaW50byB0aGUgZm9sbG93aW5nIGZvdXIgY2FzZXM6IEEsIEIsIEMsIEQuCj4g
SXQgc2hvdWxkIGJlIG5vdGVkIHRoYXQgYWx0aG91Z2ggd2UgbWVudGlvbmVkIGNhc2UgQSZCIGJl
bG93LCB3ZSBkbyBub3Qgd2FudCB0aGVzZSB0d28gY2FzZXMgdG8gYmUKPiBwYXJ0IG9mIHRoaXMg
ZmVhdHVyZSwgYmVjYXVzZSBkdW1waW5nIHRoZSBlbnRpcmUgcG1lbSB3aWxsIGNvbnN1bWUgYSBs
b3Qgb2Ygc3BhY2UsIGFuZCBtb3JlIGltcG9ydGFudGx5LAo+IGl0IG1heSBjb250YWluIHVzZXIg
c2Vuc2l0aXZlIGRhdGEuCj4gCj4gKy0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0rCj4gfFwrLS0tLS0tLS0rXCAgICAgbWV0YWRhdGEgbG9jYXRpb24gICB8Cj4gfCAgICAgICAg
ICAgICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4gfCBkdW1wIHNjb3BlICB8ICBtZW0gICAg
IHwgICBQTUVNICAgICB8Cj4gKy0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0r
Cj4gfCBlbnRpcmUgcG1lbSB8ICAgICBBICAgIHwgICAgIEIgICAgICB8Cj4gKy0tLS0tLS0tLS0t
LS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rCj4gfCBtZXRhZGF0YSAgICB8ICAgICBDICAgIHwg
ICAgIEQgICAgICB8Cj4gKy0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0rCj4g
Cj4gQ2FzZSBBJkI6IHVuc3VwcG9ydGVkCj4gLSBPbmx5IHRoZSByZWdpb25zIGxpc3RlZCBpbiBQ
VF9MT0FEIGluIHZtY29yZSBhcmUgZHVtcGFibGUuIFRoaXMgY2FuIGJlIHJlc29sdmVkIGJ5IGFk
ZGluZyB0aGUgcG1lbQo+IHJlZ2lvbiBpbnRvIHZtY29yZSdzIFBUX0xPQURzIGluIGtleGVjLXRv
b2xzLgo+IC0gRm9yIG1ha2VkdW1wZmlsZSB3aGljaCB3aWxsIGFzc3VtZSB0aGF0IGFsbCBwYWdl
IG9iamVjdHMgb2YgdGhlIGVudGlyZSByZWdpb24gZGVzY3JpYmVkIGluIFBUX0xPQURzCj4gYXJl
IHJlYWRhYmxlLCBhbmQgdGhlbiBza2lwcy9leGNsdWRlcyB0aGUgc3BlY2lmaWMgcGFnZSBhY2Nv
cmRpbmcgdG8gaXRzIGF0dHJpYnV0ZXMuIEJ1dCBpbiB0aGUgY2FzZQo+IG9mIHBtZW0sIDFzdCBr
ZXJuZWwgb25seSBhbGxvY2F0ZXMgcGFnZSBvYmplY3RzIGZvciB0aGUgbmFtZXNwYWNlcyBvZiBw
bWVtLCBzbyBtYWtlZHVtcGZpbGUgd2lsbCB0aHJvdwo+IGVycm9yc1syXSB3aGVuIHNwZWNpZmlj
IC1kIG9wdGlvbnMgYXJlIHNwZWNpZmllZC4KPiBBY2NvcmRpbmdseSwgd2Ugc2hvdWxkIG1ha2Ug
bWFrZWR1bXBmaWxlIHRvIGlnbm9yZSB0aGVzZSBlcnJvcnMgaWYgaXQncyBwbWVtIHJlZ2lvbi4K
PiAKPiBCZWNhdXNlIHRoZXNlIGFib3ZlIGNhc2VzIGFyZSBub3QgaW4gb3VyIGdvYWwsIHdlIG11
c3QgY29uc2lkZXIgaG93IHRvIHByZXZlbnQgdGhlIGRhdGEgcGFydCBvZiBwbWVtCj4gZnJvbSBy
ZWFkaW5nIGJ5IHRoZSBkdW1wIGFwcGxpY2F0aW9uKG1ha2VkdW1wZmlsZSkuCj4gCj4gQ2FzZSBD
OiBuYXRpdmUgc3VwcG9ydGVkCj4gbWV0YWRhdGEgaXMgc3RvcmVkIGluIG1lbSwgYW5kIHRoZSBl
bnRpcmUgbWVtL3JhbSBpcyBkdW1wYWJsZS4KPiAKPiBDYXNlIEQ6IHVuc3VwcG9ydGVkICYmIG5l
ZWQgeW91ciBpbnB1dAo+IFRvIHN1cHBvcnQgdGhpcyBzaXR1YXRpb24sIHRoZSBtYWtlZHVtcGZp
bGUgbmVlZHMgdG8ga25vdyB0aGUgbG9jYXRpb24gb2YgbWV0YWRhdGEgZm9yIGVhY2ggcG1lbQo+
IG5hbWVzcGFjZSBhbmQgdGhlIGFkZHJlc3MgYW5kIHNpemUgb2YgbWV0YWRhdGEgaW4gdGhlIHBt
ZW0gW3N0YXJ0LCBlbmQpCj4gCj4gV2UgaGF2ZSB0aG91Z2h0IG9mIGEgZmV3IHBvc3NpYmxlIG9w
dGlvbnM6Cj4gCj4gMSkgSW4gdGhlIDJuZCBrZXJuZWwsIHdpdGggdGhlIGhlbHAgb2YgdGhlIGlu
Zm9ybWF0aW9uIGZyb20gL3N5cy9idXMvbmQvZGV2aWNlcy97bmFtZXNwYWNlWC5ZLCBkYXhYLlks
IHBmblguWX0KPiBleHBvcnRlZCBieSBwbWVtIGRyaXZlcnMsIG1ha2VkdW1wZmlsZSBpcyBhYmxl
IHRvIGNhbGN1bGF0ZSB0aGUgYWRkcmVzcyBhbmQgc2l6ZSBvZiBtZXRhZGF0YQo+IDIpIEluIHRo
ZSAxc3Qga2VybmVsLCBhZGQgYSBuZXcgc3ltYm9sIHRvIHRoZSB2bWNvcmUuIFRoZSBzeW1ib2wg
aXMgYXNzb2NpYXRlZCB3aXRoIHRoZSBsYXlvdXQgb2YKPiBlYWNoIG5hbWVzcGFjZS4gVGhlIG1h
a2VkdW1wZmlsZSByZWFkcyB0aGUgc3ltYm9sIGFuZCBmaWd1cmVzIG91dCB0aGUgYWRkcmVzcyBh
bmQgc2l6ZSBvZiB0aGUgbWV0YWRhdGEuCj4gMykgb3RoZXJzID8KPiAKPiBCdXQgdGhlbiB3ZSBm
b3VuZCB0aGF0IHdlIGhhdmUgYWx3YXlzIGlnbm9yZWQgYSB1c2VyIGNhc2UsIHRoYXQgaXMsIHRo
ZSB1c2VyIGNvdWxkIHNhdmUgdGhlIGR1bXBmaWxlCj4gdG8gdGhlIHBtZW0uIE5laXRoZXIgb2Yg
dGhlc2UgdHdvIG9wdGlvbnMgY2FuIHNvbHZlIHRoaXMgcHJvYmxlbSwgYmVjYXVzZSB0aGUgcG1l
bSBkcml2ZXJzIHdpbGwKPiByZS1pbml0aWFsaXplIHRoZSBtZXRhZGF0YSBkdXJpbmcgdGhlIHBt
ZW0gZHJpdmVycyBsb2FkaW5nIHByb2Nlc3MsIHdoaWNoIGxlYWRzIHRvIHRoZSBtZXRhZGF0YQo+
IHdlIGR1bXBlZCBpcyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgbWV0YWRhdGEgYXQgdGhlIG1vbWVu
dCBvZiB0aGUgY3Jhc2ggaGFwcGVuaW5nLgo+IFNpbXBseSwgY2FuIHdlIGp1c3QgZGlzYWJsZSB0
aGUgcG1lbSBkaXJlY3RseSBpbiAybmQga2VybmVsIHNvIHRoYXQgcHJldmlvdXMgbWV0YWRhdGEg
d2lsbCBub3QgYmUKPiBkZXN0cm95ZWQ/IEJ1dCB0aGlzIG9wZXJhdGlvbiB3aWxsIGJyaW5nIHVz
IGluY29udmVuaWVuY2UgdGhhdCAybmQga2VybmVsIGRvZXNu4oCZdCBhbGxvdyB1c2VyIHN0b3Jp
bmcKPiBkdW1wZmlsZSBvbiB0aGUgZmlsZXN5c3RlbS9wYXJ0aXRpb24gYmFzZWQgb24gcG1lbS4K
CjEpIEluIGtlcm5lbCBzaWRlLCBleHBvcnQgaW5mbyBvZiBwbWVtIG1ldGEgZGF0YTsKMikgaW4g
bWFrZWR1bXBmaWxlIHNpemUsIGFkZCBhbiBvcHRpb24gdG8gc3BlY2lmeSBpZiB3ZSB3YW50IHRv
IGR1bXAKICAgcG1lbSBtZXRhIGRhdGE7IEFuIG9wdGlvbiBvciBpbiBkdW1wIGxldmVsPwozKSBJ
biBnbHVlIHNjcmlwdCwgZGV0ZWN0IGFuZCB3YXJuIGlmIHBtZW0gZGF0YSBpcyBpbiBwbWVtIGFu
ZCB3YW50ZWQsCiAgIGFuZCBkdW1wIHRhcmdldCBpcyB0aGUgc2FtZSBwbWVtLgoKRG9lcyB0aGlz
IHdvcmsgZm9yIHlvdT8KCk5vdCBzdXJlIGlmIGFib3ZlIGl0ZW1zIGFyZSBhbGwgZG8tYWJsZS4g
QXMgZm9yIHBhcmtpbmcgcG1lbSBkZXZpY2UKdGlsbCBpbiBrZHVtcCBrZXJuZWwsIEkgYmVsaWV2
ZSBpbnRlbCBwbWVtIGV4cGVydCBrbm93IGhvdyB0byBhY2hpZXZlCnRoYXQuIElmIHRoZXJlJ3Mg
bm8gd2F5IHRvIHBhcmsgcG1lbSBkdXJpbmcga2R1bXAganVtcGluZywgY2FzZSBEKSBpcwpkYXlk
cmVhbS4KClRoYW5rcwpCYW9xdWFuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

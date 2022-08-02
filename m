Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0343C00140
	for <kexec@archiver.kernel.org>; Tue,  2 Aug 2022 07:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O/ulDFW68vP0G7yfzWsiutJDgkZj3N2qiuOJ/6D2+ws=; b=FwlHvVVpjorBdg
	1FPZo0+2gPGsEo8qJ6/CfV1wN+rdYDMHSurMoaO0n4ucFDlmVSRaht4hRzFWAF9bX7//8g2YVB9MA
	vEOcRXRo6fqHe+ZvCtsP3CoyRKHg0rD6Wyxi3hUd0zKHkXmINfv7ukOR5GXJ1r3hE4Iky9MYxgvkz
	vMvxta9UBIX3l03+XKpbX8UQ+GCC412UkzNRR+sI7rzZxAVyGQmVwWM+8bH6MchBs0j4ol7R8HLNg
	HvQQ3zgEDk++uT032xuSpNjEyOz0uWNyGeB1BT7jcglr0uDXjfmdDxnbGW455ShGRbXGkiu3+lj3B
	PW4mr4Tw+I/mSPkXodfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oImOl-00BNHM-BA; Tue, 02 Aug 2022 07:33:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oImOd-00BNBg-Iq
	for kexec@lists.infradead.org; Tue, 02 Aug 2022 07:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659425574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvz5t+oZNlSf7bcC71XjFFahU1M2khcyplx7wbP8UW0=;
	b=YYxyb6SfLIukGNUIlV77i9S8QqjV5rCLoZ68AhKAYPUEDiltqG3W/I8p03OuazMvPXqnmA
	fzIwNcoDVqSc1G2eNg/grFlvW43DDJTmb0TaoQBgdHgKpiQAZnHU4rDwIBbiaAwuY1/5oB
	veuu2naH3AEtZHgVc8713KvdiM1TJnk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-8CSRVKvEMFanEt-e__OItg-1; Tue, 02 Aug 2022 03:32:51 -0400
X-MC-Unique: 8CSRVKvEMFanEt-e__OItg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3228811766;
	Tue,  2 Aug 2022 07:32:50 +0000 (UTC)
Received: from localhost (ovpn-13-104.pek2.redhat.com [10.72.13.104])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C7E0FC04482;
	Tue,  2 Aug 2022 07:32:49 +0000 (UTC)
Date: Tue, 2 Aug 2022 15:32:46 +0800
From: Baoquan He <bhe@redhat.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YujTHv0xVG8DirkW@MiWiFi-R3L-srv>
References: <20220707231550.1484-1-fmdefrancesco@gmail.com>
 <YuiUzodsyv3hZAgs@MiWiFi-R3L-srv>
 <1923146.PYKUYFuaPT@opensuse>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1923146.PYKUYFuaPT@opensuse>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220802_003255_854732_4592607B 
X-CRM114-Status: GOOD (  43.21  )
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

T24gMDgvMDIvMjIgYXQgMDg6MjBhbSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdyb3RlOgo+IE9u
IG1hcnRlZMOsIDIgYWdvc3RvIDIwMjIgMDU6MDY6NTQgQ0VTVCBCYW9xdWFuIEhlIHdyb3RlOgo+
ID4gT24gMDcvMDgvMjIgYXQgMDE6MTVhbSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdyb3RlOgo+
ID4gPiBUaGUgdXNlIG9mIGttYXAoKSBhbmQga21hcF9hdG9taWMoKSBhcmUgYmVpbmcgZGVwcmVj
YXRlZCBpbiBmYXZvciBvZgo+ID4gPiBrbWFwX2xvY2FsX3BhZ2UoKS4KPiA+ID4gCj4gPiA+IFdp
dGgga21hcF9sb2NhbF9wYWdlKCksIHRoZSBtYXBwaW5ncyBhcmUgcGVyIHRocmVhZCwgQ1BVIGxv
Y2FsIGFuZCBub3QKPiA+ID4gZ2xvYmFsbHkgdmlzaWJsZS4gRnVydGhlcm1vcmUsIHRoZSBtYXBw
aW5ncyBjYW4gYmUgYWNxdWlyZWQgZnJvbSBhbnkKPiA+ID4gY29udGV4dCAoaW5jbHVkaW5nIGlu
dGVycnVwdHMpLgo+ID4gPiAKPiA+ID4gVGhlcmVmb3JlLCB1c2Uga21hcF9sb2NhbF9wYWdlKCkg
aW4ga2V4ZWNfY29yZS5jIGJlY2F1c2UgdGhlc2UgbWFwcGluZ3MgCj4gYXJlCj4gPiA+IHBlciB0
aHJlYWQsIENQVSBsb2NhbCwgYW5kIG5vdCBnbG9iYWxseSB2aXNpYmxlLgo+ID4gPiAKPiA+ID4g
VGVzdGVkIG9uIGEgUUVNVSArIEtWTSAzMi1iaXRzIFZNIGJvb3RpbmcgYSBrZXJuZWwgd2l0aCBI
SUdITUVNNjRHQgo+ID4gPiBlbmFibGVkLgo+ID4gCj4gPiBXb25kZXJpbmcgd2hhdCBhcmNoIHlv
dSB0ZXN0ZWQgd2l0aC4KPiAKPiBJJ20gc29ycnksIEkgZm9yZ290IHRvIHNheSB0aGF0IEkgdXNl
IHg4Nl8zMiB3aXRoIDRHQiB0byA2R0IgUkFNLgo+IFRoaXMgaXMgdXN1YWxseSBhbiBpbmZvcm1h
dGlvbiB0aGF0IEkgYWRkIGluIHRoZSBjb21taXQgbWVzc2FnZXMgb2YgYWxsIHRoZSAKPiByZWNl
bnQgY29udmVyc2lvbnMgSSdtIHdvcmtpbmcgb24gYWNyb3NzIHRoZSBlbnRpcmUga2VybmVsLgo+
IAo+IEFub3RoZXIgaW1wb3J0YW50IGluZm9ybWF0aW9uIChvdmVybG9va2VkIGFnYWluIHRoaXMg
dGltZSkgaXMgdGhhdCAoMSkgCj4ga21hcCgpIGNvbWVzIHdpdGggYW4gb3ZlcmhlYWQgYXMgbWFw
cGluZyBzcGFjZSBpcyByZXN0cmljdGVkIGFuZCBwcm90ZWN0ZWQgCj4gYnkgYSBnbG9iYWwgbG9j
ayBmb3Igc3luY2hyb25pemF0aW9uIGFuZCAoMikgaXQgYWxzbyByZXF1aXJlcyBnbG9iYWwgVExC
IAo+IGludmFsaWRhdGlvbiB3aGVuIHRoZSBrbWFw4oCZcyBwb29sIHdyYXBzIGFuZCBpdCBtaWdo
dCBibG9jayB3aGVuIHRoZSBtYXBwaW5nIAo+IHNwYWNlIGlzIGZ1bGx5IHV0aWxpemVkIHVudGls
IGEgc2xvdCBiZWNvbWVzIGF2YWlsYWJsZS4KClRoYW5rcyBhIGxvdCBmb3IgdXBkYXRlIHdpdGgg
bW9yZSBkZXRhaWxzLCBGYWJpby4gTWF5YmUgdGhlc2UgY2FuIGJlCmFkZGVkIGludG8gbG9nIHdp
dGggdjMgaWYgeW91IHRoaW5rIHRoZXkgYXJlIHdvcnRoIGFkZGluZywgYW5kIHdpdGggbXkKQWNr
IHNpbmNlIG5vIGNvZGUgY2hhbmdlIHJlbGF0ZWQuIFlvdSBkZWNpZGUuCgpUaGFua3MgYWdhaW4g
Zm9yIHRoZSBlZmZvcnQuCgo+IAo+IE1vcmUgaW5mb3JtYXRpb24gYWJvdXQgd2h5IHRoZXNlIGtt
YXAoKSB0byBrbWFwX2xvY2FsX3BhZ2UoKSBjb252ZXJzaW9ucyAKPiBhcmUgbmVlZGVkIC8gcHJl
ZmVycmVkIGNhbiBiZSBmb3VuZCBpbiB0aGUgcmVjZW50IGNoYW5nZXMgSSBtYWRlIHRvIAo+IGhp
Z2htZW0ucnN0LiBUaGV5IGFyZSBhbHJlYWR5IGluIG1haW5saW5lIHNpbmNlIGFib3V0IHR3byBt
b250aHMuCj4gCj4gQSBzZWNvbmQgcm91bmQgb2YgYWRkaXRpb25hbCBjaGFuZ2VzIGhhcyBiZWVu
IHRha2VuIGJ5IEFuZHJldyBNLiBqdXN0IGZldyAKPiBkYXlzIGFnby4KPiAKPiBNeSBnb2FsIGlz
IHRvIGNvbnZlcnQgdGhlIG1vc3Qgb2YgdGhlIGttYXAoKSBjYWxsIHNpdGVzIHRoYXQgYXJlIHN0
aWxsIGxlZnQgCj4gYWNyb3NzIHRoZSB3aG9sZSBrZXJuZWwuIEknbSBub3QgeWV0IHN1cmUgdGhh
dCB0aGVzZSBraW5kcyBvZiBjb252ZXJzaW9ucyAKPiBjYW4gYmUgZG9uZSBldmVyeXdoZXJlLCBl
c3BlY2lhbGx5IGlmIHRoZSBrZXJuZWwgdmlydHVhbCBhZGRyZXNzIG9mIHRoZSAKPiBtYXBwaW5n
IGlzIGhhbmRlZCB0byBvdGhlciBjb250ZXh0cywgYmVjYXVzZSB0aGlzIHdvdWxkIGludmFsaWRh
dGUgdGhlIAo+IHBvaW50ZXIgcmV0dXJuZWQgYnkga21hcF9sb2NhbF9wYWdlKCkuICAKPiAKPiA+
IFRoaXMgbG9va3MgZ29vZCwgYnV0IG1heSBub3QgYmVuZWZpdCBtdWNoLiBTYXkgc28gYmVjYXVz
ZSBJIGRvdWJ0Cj4gPiBob3cgbWFueSAzMmJpdCBzeXN0ZW1zIGFyZSB1c2luZyBrZXhlYy9rZHVt
cCBtZWNoYW5pc20uCj4gCj4gSSByZWFsbHkgY2Fubm90IHNheSBub3RoaW5nIGFib3V0IGhvdyBt
YW55IDMyIGJpdHMgc3lzdGVtcyBhcmUgdXNpbmcga2V4ZWMvCj4ga2R1bXAgbWVjaGFuaXNtLCBo
b3dldmVyIEkgc3RpbGwgdGhpbmsgdGhhdCB0aGUgY29udmVyc2lvbnMgYXJlIHdvcnRoIAo+IGV2
ZXJ5d2hlcmUuIAoKWWVzLCBhZ3JlZS4KCj4gCj4gPiBBbnl3YXksIAo+ID4gCj4gPiBBY2tlZC1i
eTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+Cj4gPiAKPiAKPiBUaGFuayB5b3Ugc28gbXVj
aCEKPiAKPiBGYWJpbwo+IAo+ID4gPiAKPiA+ID4gU3VnZ2VzdGVkLWJ5OiBJcmEgV2VpbnkgPGly
YS53ZWlueUBpbnRlbC5jb20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIE0uIERlIEZyYW5j
ZXNjbyA8Zm1kZWZyYW5jZXNjb0BnbWFpbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAKPiA+ID4gdjEt
PnYyOiBBIHNlbnRlbmNlIG9mIHRoZSBjb21taXQgbWVzc2FnZSBjb250YWluZWQgYW4gZXJyb3Ig
ZHVlIHRvIGEKPiA+ID4gbWlzdGFrZSBpbiBjb3B5LXBhc3RpbmcgZnJvbSBhIHByZXZpb3VzIHBh
dGNoLiBSZXBsYWNlICJhaW8uYyIgd2l0aAo+ID4gPiAia2V4ZWNfY29yZS5jIi4KPiA+ID4gCj4g
PiA+ICBrZXJuZWwva2V4ZWNfY29yZS5jIHwgOCArKysrLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1n
aXQgYS9rZXJuZWwva2V4ZWNfY29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYwo+ID4gPiBpbmRl
eCA0ZDM0Yzc4MzM0Y2UuLjZmOTgyNzQ3NjVkNCAxMDA2NDQKPiA+ID4gLS0tIGEva2VybmVsL2tl
eGVjX2NvcmUuYwo+ID4gPiArKysgYi9rZXJuZWwva2V4ZWNfY29yZS5jCj4gPiA+IEBAIC04MTQs
NyArODE0LDcgQEAgc3RhdGljIGludCBraW1hZ2VfbG9hZF9ub3JtYWxfc2VnbWVudChzdHJ1Y3Qg
a2ltYWdlIAo+ICppbWFnZSwKPiA+ID4gIAkJaWYgKHJlc3VsdCA8IDApCj4gPiA+ICAJCQlnb3Rv
IG91dDsKPiA+ID4gIAo+ID4gPiAtCQlwdHIgPSBrbWFwKHBhZ2UpOwo+ID4gPiArCQlwdHIgPSBr
bWFwX2xvY2FsX3BhZ2UocGFnZSk7Cj4gPiA+ICAJCS8qIFN0YXJ0IHdpdGggYSBjbGVhciBwYWdl
ICovCj4gPiA+ICAJCWNsZWFyX3BhZ2UocHRyKTsKPiA+ID4gIAkJcHRyICs9IG1hZGRyICYgflBB
R0VfTUFTSzsKPiA+ID4gQEAgLTgyNyw3ICs4MjcsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2Fk
X25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgCj4gKmltYWdlLAo+ID4gPiAgCQkJbWVtY3B5
KHB0ciwga2J1ZiwgdWNodW5rKTsKPiA+ID4gIAkJZWxzZQo+ID4gPiAgCQkJcmVzdWx0ID0gY29w
eV9mcm9tX3VzZXIocHRyLCBidWYsIHVjaHVuayk7Cj4gPiA+IC0JCWt1bm1hcChwYWdlKTsKPiA+
ID4gKwkJa3VubWFwX2xvY2FsKHB0cik7Cj4gPiA+ICAJCWlmIChyZXN1bHQpIHsKPiA+ID4gIAkJ
CXJlc3VsdCA9IC1FRkFVTFQ7Cj4gPiA+ICAJCQlnb3RvIG91dDsKPiA+ID4gQEAgLTg3OCw3ICs4
NzgsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2FkX2NyYXNoX3NlZ21lbnQoc3RydWN0IGtpbWFn
ZSAKPiAqaW1hZ2UsCj4gPiA+ICAJCQlnb3RvIG91dDsKPiA+ID4gIAkJfQo+ID4gPiAgCQlhcmNo
X2tleGVjX3Bvc3RfYWxsb2NfcGFnZXMocGFnZV9hZGRyZXNzKHBhZ2UpLCAxLCAwKTsKPiA+ID4g
LQkJcHRyID0ga21hcChwYWdlKTsKPiA+ID4gKwkJcHRyID0ga21hcF9sb2NhbF9wYWdlKHBhZ2Up
Owo+ID4gPiAgCQlwdHIgKz0gbWFkZHIgJiB+UEFHRV9NQVNLOwo+ID4gPiAgCQltY2h1bmsgPSBt
aW5fdChzaXplX3QsIG1ieXRlcywKPiA+ID4gIAkJCQlQQUdFX1NJWkUgLSAobWFkZHIgJiB+UEFH
RV9NQVNLKSk7Cj4gPiA+IEBAIC04OTQsNyArODk0LDcgQEAgc3RhdGljIGludCBraW1hZ2VfbG9h
ZF9jcmFzaF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgCj4gKmltYWdlLAo+ID4gPiAgCQllbHNlCj4g
PiA+ICAJCQlyZXN1bHQgPSBjb3B5X2Zyb21fdXNlcihwdHIsIGJ1ZiwgdWNodW5rKTsKPiA+ID4g
IAkJa2V4ZWNfZmx1c2hfaWNhY2hlX3BhZ2UocGFnZSk7Cj4gPiA+IC0JCWt1bm1hcChwYWdlKTsK
PiA+ID4gKwkJa3VubWFwX2xvY2FsKHB0cik7Cj4gPiA+ICAJCWFyY2hfa2V4ZWNfcHJlX2ZyZWVf
cGFnZXMocGFnZV9hZGRyZXNzKHBhZ2UpLCAxKTsKPiA+ID4gIAkJaWYgKHJlc3VsdCkgewo+ID4g
PiAgCQkJcmVzdWx0ID0gLUVGQVVMVDsKPiA+ID4gLS0gCj4gPiA+IDIuMzYuMQo+ID4gPiAKPiA+
ID4gCj4gPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gPiA+IGtleGVjIG1haWxpbmcgbGlzdAo+ID4gPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cj4gPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
PiA+ID4gCj4gPiAKPiA+IAo+IAo+IAo+IAo+IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK

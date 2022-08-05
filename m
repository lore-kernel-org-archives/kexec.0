Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F4C00140
	for <kexec@archiver.kernel.org>; Fri,  5 Aug 2022 03:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2DNB7/4/AwEweOy5SVVpdZ5/NTFhivcW2oi5LTWO1J8=; b=tLmJS+XvEJ2TYw
	j19WNc6BT+dpdDHVZ0VzX4meTeH21YFzGj4gpnWSr8021CMXmNbTdxnNlRSxhBTcGEJIYQWswYCFm
	t4r1uMQMMp1i5oLHSAXRriZYOS5WQ42JnIo3xJy0AOQw6oydXszPZNuTs/vNvGE2ZdxnThjnilYMY
	MD8sFg6aDzOtwEqjw0NajLBvYgOYw90rYCs3AaikqWdmhcvT7YiIEJcxee0DwxT01u0QcqMt6m94B
	7CABgZqudnSFarDofZWIvc0g1nDMrKVbd3GyUJiS2Vt0wGOTUeYFWQ3YRFaU1bEfyZFx9UZZmFOCM
	DNivIRtZZ8k0hEipyhKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJoBu-00BTJ3-Jh; Fri, 05 Aug 2022 03:40:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJoBr-00BTDI-44
	for kexec@lists.infradead.org; Fri, 05 Aug 2022 03:40:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1659670791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwqZIdkCCeZTZaiYZNxUCbYKyvxUe9kIL3vFtHSIkGU=;
	b=clkMB802nAT2qVl22ES/DqaM3gOowDCZDdXrNaUjc95On0F6efdFBuGv2s3ZJ8G95eWIkZ
	QB8ufPXgAQID2jt0INvGoMGgHswEprNmEHPfrF+0ucc/9kgGO5OBIZlF8PdKMW+auNDxJc
	TDV/hzuLW80VC5rrQUaNEmStDiFhvyU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-Hvwz2pLZO-SKHCb32aI0qw-1; Thu, 04 Aug 2022 23:39:49 -0400
X-MC-Unique: Hvwz2pLZO-SKHCb32aI0qw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5F978032F1;
	Fri,  5 Aug 2022 03:39:48 +0000 (UTC)
Received: from localhost (ovpn-12-174.pek2.redhat.com [10.72.12.174])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 88749492C3B;
	Fri,  5 Aug 2022 03:39:47 +0000 (UTC)
Date: Fri, 5 Aug 2022 11:39:41 +0800
From: Baoquan He <bhe@redhat.com>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	akpm@linux-foundation.org
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v3] kexec: Replace kmap() with kmap_local_page()
Message-ID: <YuyQ/cUBPGa9A1Jo@MiWiFi-R3L-srv>
References: <20220803160038.22322-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220803160038.22322-1-fmdefrancesco@gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220804_203959_434837_E4DA5140 
X-CRM114-Status: GOOD (  26.86  )
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

T24gMDgvMDMvMjIgYXQgMDY6MDBwbSwgRmFiaW8gTS4gRGUgRnJhbmNlc2NvIHdyb3RlOgoKVGhh
bmtzIGZvciB0aGUgbG9nIHVwZGF0ZS4gQW5kIENjIEFuZHJldy4KCj4ga21hcCgpIGlzIGJlaW5n
IGRlcHJlY2F0ZWQgaW4gZmF2b3Igb2Yga21hcF9sb2NhbF9wYWdlKCkuCj4gCj4gVGhlcmUgYXJl
IHR3byBtYWluIHByb2JsZW1zIHdpdGgga21hcCgpOiAoMSkgSXQgY29tZXMgd2l0aCBhbiBvdmVy
aGVhZCBhcwo+IG1hcHBpbmcgc3BhY2UgaXMgcmVzdHJpY3RlZCBhbmQgcHJvdGVjdGVkIGJ5IGEg
Z2xvYmFsIGxvY2sgZm9yCj4gc3luY2hyb25pemF0aW9uIGFuZCAoMikgaXQgYWxzbyByZXF1aXJl
cyBnbG9iYWwgVExCIGludmFsaWRhdGlvbiB3aGVuIHRoZQo+IGttYXDigJlzIHBvb2wgd3JhcHMg
YW5kIGl0IG1pZ2h0IGJsb2NrIHdoZW4gdGhlIG1hcHBpbmcgc3BhY2UgaXMgZnVsbHkKPiB1dGls
aXplZCB1bnRpbCBhIHNsb3QgYmVjb21lcyBhdmFpbGFibGUuCj4gCj4gV2l0aCBrbWFwX2xvY2Fs
X3BhZ2UoKSB0aGUgbWFwcGluZ3MgYXJlIHBlciB0aHJlYWQsIENQVSBsb2NhbCwgY2FuIHRha2UK
PiBwYWdlIGZhdWx0cywgYW5kIGNhbiBiZSBjYWxsZWQgZnJvbSBhbnkgY29udGV4dCAoaW5jbHVk
aW5nIGludGVycnVwdHMpLgo+IEl0IGlzIGZhc3RlciB0aGFuIGttYXAoKSBpbiBrZXJuZWxzIHdp
dGggSElHSE1FTSBlbmFibGVkLiBGdXJ0aGVybW9yZSwKPiB0aGUgdGFza3MgY2FuIGJlIHByZWVt
cHRlZCBhbmQsIHdoZW4gdGhleSBhcmUgc2NoZWR1bGVkIHRvIHJ1biBhZ2FpbiwgdGhlCj4ga2Vy
bmVsIHZpcnR1YWwgYWRkcmVzc2VzIGFyZSByZXN0b3JlZCBhbmQgYXJlIHN0aWxsIHZhbGlkLgo+
IAo+IFNpbmNlIGl0cyB1c2UgaW4ga2V4ZWNfY29yZS5jIGlzIHNhZmUgZXZlcnl3aGVyZSwgaXQg
c2hvdWxkIGJlIHByZWZlcnJlZC4KPiAKPiBUaGVyZWZvcmUsIHJlcGxhY2Uga21hcCgpIHdpdGgg
a21hcF9sb2NhbF9wYWdlKCkgaW4ga2V4ZWNfY29yZS5jLgo+IAo+IFRlc3RlZCBvbiBhIFFFTVUv
S1ZNIHg4Nl8zMiBWTSwgNkdCIFJBTSwgYm9vdGluZyBhIGtlcm5lbCB3aXRoCj4gSElHSE1FTTY0
R0IgZW5hYmxlZC4KPiAKPiBTdWdnZXN0ZWQtYnk6IElyYSBXZWlueSA8aXJhLndlaW55QGludGVs
LmNvbT4KPiBSZXZpZXdlZC1ieTogSXJhIFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPgo+IEFj
a2VkLWJ5OiBCYW9xdWFuIEhlIDxiaGVAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBGYWJp
byBNLiBEZSBGcmFuY2VzY28gPGZtZGVmcmFuY2VzY29AZ21haWwuY29tPgo+IC0tLQo+IAo+IHYy
LT52MzogQWRkIG1vcmUgaW5mb3JtYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGFzIHJlcXVl
c3RlZCBieSBCYW9xdWFuCj4gSGUgYW5kIGZvcndhcmQgdHdvIHRhZ3MsIHJlc3BlY3RpdmVseSBm
cm9tIElyYSBXZWlueSBhbmQgQmFvcXVhbiBIZSAobWFueQo+IHRoYW5rcyB0byB0aGVtIHR3byEp
Lgo+IAo+IHYxLT52MjogQSBzZW50ZW5jZSBvZiB0aGUgY29tbWl0IG1lc3NhZ2UgY29udGFpbmVk
IGFuIGVycm9yIGR1ZSB0byBhCj4gbWlzdGFrZSBpbiBjb3B5LXBhc3RpbmcgZnJvbSBhIHByZXZp
b3VzIHBhdGNoLiBSZXBsYWNlICJhaW8uYyIgd2l0aAo+ICJrZXhlY19jb3JlLmMiLgo+IAo+ICBr
ZXJuZWwva2V4ZWNfY29yZS5jIHwgOCArKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9rZXJuZWwva2V4ZWNf
Y29yZS5jIGIva2VybmVsL2tleGVjX2NvcmUuYwo+IGluZGV4IDRkMzRjNzgzMzRjZS4uNmY5ODI3
NDc2NWQ0IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC9rZXhlY19jb3JlLmMKPiArKysgYi9rZXJuZWwv
a2V4ZWNfY29yZS5jCj4gQEAgLTgxNCw3ICs4MTQsNyBAQCBzdGF0aWMgaW50IGtpbWFnZV9sb2Fk
X25vcm1hbF9zZWdtZW50KHN0cnVjdCBraW1hZ2UgKmltYWdlLAo+ICAJCWlmIChyZXN1bHQgPCAw
KQo+ICAJCQlnb3RvIG91dDsKPiAgCj4gLQkJcHRyID0ga21hcChwYWdlKTsKPiArCQlwdHIgPSBr
bWFwX2xvY2FsX3BhZ2UocGFnZSk7Cj4gIAkJLyogU3RhcnQgd2l0aCBhIGNsZWFyIHBhZ2UgKi8K
PiAgCQljbGVhcl9wYWdlKHB0cik7Cj4gIAkJcHRyICs9IG1hZGRyICYgflBBR0VfTUFTSzsKPiBA
QCAtODI3LDcgKzgyNyw3IEBAIHN0YXRpYyBpbnQga2ltYWdlX2xvYWRfbm9ybWFsX3NlZ21lbnQo
c3RydWN0IGtpbWFnZSAqaW1hZ2UsCj4gIAkJCW1lbWNweShwdHIsIGtidWYsIHVjaHVuayk7Cj4g
IAkJZWxzZQo+ICAJCQlyZXN1bHQgPSBjb3B5X2Zyb21fdXNlcihwdHIsIGJ1ZiwgdWNodW5rKTsK
PiAtCQlrdW5tYXAocGFnZSk7Cj4gKwkJa3VubWFwX2xvY2FsKHB0cik7Cj4gIAkJaWYgKHJlc3Vs
dCkgewo+ICAJCQlyZXN1bHQgPSAtRUZBVUxUOwo+ICAJCQlnb3RvIG91dDsKPiBAQCAtODc4LDcg
Kzg3OCw3IEBAIHN0YXRpYyBpbnQga2ltYWdlX2xvYWRfY3Jhc2hfc2VnbWVudChzdHJ1Y3Qga2lt
YWdlICppbWFnZSwKPiAgCQkJZ290byBvdXQ7Cj4gIAkJfQo+ICAJCWFyY2hfa2V4ZWNfcG9zdF9h
bGxvY19wYWdlcyhwYWdlX2FkZHJlc3MocGFnZSksIDEsIDApOwo+IC0JCXB0ciA9IGttYXAocGFn
ZSk7Cj4gKwkJcHRyID0ga21hcF9sb2NhbF9wYWdlKHBhZ2UpOwo+ICAJCXB0ciArPSBtYWRkciAm
IH5QQUdFX01BU0s7Cj4gIAkJbWNodW5rID0gbWluX3Qoc2l6ZV90LCBtYnl0ZXMsCj4gIAkJCQlQ
QUdFX1NJWkUgLSAobWFkZHIgJiB+UEFHRV9NQVNLKSk7Cj4gQEAgLTg5NCw3ICs4OTQsNyBAQCBz
dGF0aWMgaW50IGtpbWFnZV9sb2FkX2NyYXNoX3NlZ21lbnQoc3RydWN0IGtpbWFnZSAqaW1hZ2Us
Cj4gIAkJZWxzZQo+ICAJCQlyZXN1bHQgPSBjb3B5X2Zyb21fdXNlcihwdHIsIGJ1ZiwgdWNodW5r
KTsKPiAgCQlrZXhlY19mbHVzaF9pY2FjaGVfcGFnZShwYWdlKTsKPiAtCQlrdW5tYXAocGFnZSk7
Cj4gKwkJa3VubWFwX2xvY2FsKHB0cik7Cj4gIAkJYXJjaF9rZXhlY19wcmVfZnJlZV9wYWdlcyhw
YWdlX2FkZHJlc3MocGFnZSksIDEpOwo+ICAJCWlmIChyZXN1bHQpIHsKPiAgCQkJcmVzdWx0ID0g
LUVGQVVMVDsKPiAtLSAKPiAyLjM3LjEKPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==

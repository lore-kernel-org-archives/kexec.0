Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00743C52D7C
	for <kexec@archiver.kernel.org>; Fri, 23 Aug 2024 07:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kza+iGSUzKWbZaVEkMS5kc5Gl22GdyDqMO5VgI7kwPA=; b=oZOiCDyLoczlPU
	9iKDXOLz4E0ytccBI3cN7OVmBN40ndRyZIOfgoimaG4ASfhjT84CXqFNWqvlaYQ5TVkUZObs8sKuX
	j+4eFvMSd8ZwdURUu0TT30iRetfLm/kcnSc0SsFrktszXKUKu3Sq0q4P519j8oq+YOGwdxzRgY0XG
	dv6XbcMfcwyjGi+d/ZAOlbi4MV/jpL1oPjJ2Vmnzrv/eORmnit/g3CKwnrdTfYMuLwaF+SiIvGnLp
	qq4U2MSaReg5ja1HGcfaRNgoJnhef41aN48Se6BB5zhB36sbSZfbGe4IdzxyaIgxGaDA6K9rVaNsb
	JG16hphJEVeiKOSGiPJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOXo-0000000FcaN-0NKj;
	Fri, 23 Aug 2024 07:17:12 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOX7-0000000FcPJ-01Ch;
	Fri, 23 Aug 2024 07:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=l7IPZ3AaL3TYIUYzSS0Hq6JrLJlHTIOmiTWkTNBFYJI=; t=1724397389; x=1725002189; 
	b=iCQVCYpXtxcBjP0FFxebkvx4FdC3liQOyNrUw15jjXL5eai6uoCwQMLiPmEhv/e1H5feXSfyrX0
	XsKlTFUOq8xTpkPksC91NaiETsx4KwSO5K39sh4wN6GK8YtbJpq9MTL5bGcjqktLEIDA1ZL5L/Rki
	jl0XtJB+xv9bmvsr8Xunu6vGGCNa5jkNcPbCnBHyC8CczFsbmkgrZB6WVTIqJAWTh60ZahfJWKSBV
	cxun88y0ktJt3acCowcFiLWVJK1sQNWqNKS/0BRaj0ym69aXcAgH+kuGzaZYoVmaG/Vveyatt/xK8
	9k44F7V+Xc6g3ZD7SSaL7BAGBrN6qSahF5CQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1shOWy-00000002p5y-3SYy; Fri, 23 Aug 2024 09:16:20 +0200
Received: from p5b13a2bf.dip0.t-ipconnect.de ([91.19.162.191] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1shOWy-0000000256e-2Oml; Fri, 23 Aug 2024 09:16:20 +0200
Message-ID: <c74e24213fd98b252a2a1ff02a107005e50f4f7b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH linux-next v3 05/14] crash: clean up kdump related
 config items
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Dave Vasilevsky <dave@vasilevsky.ca>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
 kexec@lists.infradead.org, debian-powerpc@lists.debian.org, x86@kernel.org,
  linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org,  linux-riscv@lists.infradead.org,
 loongarch@lists.linux.dev,  akpm@linux-foundation.org,
 ebiederm@xmission.com, hbathini@linux.ibm.com,  piliu@redhat.com,
 viro@zeniv.linux.org.uk, Sam James <sam@gentoo.org>
Date: Fri, 23 Aug 2024 09:16:19 +0200
In-Reply-To: <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
References: <20240124051254.67105-1-bhe@redhat.com>
	 <20240124051254.67105-6-bhe@redhat.com>
	 <a9d9ecd1ed8d62eae47ec26257093495e6cbd44a.camel@physik.fu-berlin.de>
	 <ZscCMLfNbj2MDiaB@MiWiFi-R3L-srv>
	 <c5e9996e4d2ba2a0849d65f68e3dce94fffc5828.camel@physik.fu-berlin.de>
	 <ZsfR9rdMt8yn1+Bz@MiWiFi-R3L-srv>
	 <768dfe3e-c437-40cc-96a5-6c5b34b2d19d@vasilevsky.ca>
User-Agent: Evolution 3.52.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.191
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_001629_228058_6A474293 
X-CRM114-Status: GOOD (  18.31  )
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

T24gVGh1LCAyMDI0LTA4LTIyIGF0IDIwOjQxIC0wNDAwLCBEYXZlIFZhc2lsZXZza3kgd3JvdGU6
Cj4gRnJvbSBkNmU1ZmUzYTQ1ZjQ2ZjFhYTAxOTE0NjQ4YzQ0MzI5MWQ5NTZkZTllIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQo+IEZyb206IERhdmUgVmFzaWxldnNreSA8ZGF2ZUB2YXNpbGV2c2t5
LmNhPgo+IERhdGU6IFRodSwgMjIgQXVnIDIwMjQgMjA6MTM6NDYgLTA0MDAKPiBTdWJqZWN0OiBb
UEFUQ0hdIHBvd2VycGM6IERlZmF1bHQgdG8gQ1JBU0hfRFVNUD1uIHdoZW4gT3BlbiBGaXJtd2Fy
ZSBib290IGlzCj4gIGxpa2VseQo+IE1JTUUtVmVyc2lvbjogMS4wCj4gQ29udGVudC1UeXBlOiB0
ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04Cj4gQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJp
dAo+IAo+IE9wZW4gRmlybXdhcmUgaXMgdW5hYmxlIHRvIGJvb3QgYSBrZXJuZWwgd2hlcmUgUEhZ
U0lDQUxfU1RBUlQgaXMKPiBub24temVybywgd2hpY2ggb2NjdXJzIHdoZW4gQ1JBU0hfRFVNUCBp
cyBvbi4KPiAKPiBPbiBQUENfQk9PSzNTXzMyLCB0aGUgbW9zdCBjb21tb24gd2F5IG9mIGJvb3Rp
bmcgaXMgT3BlbiBGaXJtd2FyZSwgc28KPiBtb3N0IHVzZXJzIHByb2JhYmx5IGRvbid0IHdhbnQg
Q1JBU0hfRFVNUC4gVXNlcnMgYm9vdGluZyB2aWEgc29tZQo+IG90aGVyIG1lY2hhbmlzbSBjYW4g
dHVybiBpdCBvbiBleHBsaWNpdGx5Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhdmUgVmFzaWxldnNr
eSA8ZGF2ZUB2YXNpbGV2c2t5LmNhPgo+IFJlcG9ydGVkLWJ5OiBSZWltYXIgRMO2ZmZpbmdlciA8
UmVpbWFyLkRvZWZmaW5nZXJAZ214LmRlPgo+IEZpeGVzOiA3NWJjMjU1YTc0NDQKPiAtLS0KPiAg
YXJjaC9hcm0vS2NvbmZpZyAgICAgICB8IDMgKysrCj4gIGFyY2gvYXJtNjQvS2NvbmZpZyAgICAg
fCAzICsrKwo+ICBhcmNoL2xvb25nYXJjaC9LY29uZmlnIHwgMyArKysKPiAgYXJjaC9taXBzL0tj
b25maWcgICAgICB8IDMgKysrCj4gIGFyY2gvcG93ZXJwYy9LY29uZmlnICAgfCA0ICsrKysKPiAg
YXJjaC9yaXNjdi9LY29uZmlnICAgICB8IDMgKysrCj4gIGFyY2gvczM5MC9LY29uZmlnICAgICAg
fCAzICsrKwo+ICBhcmNoL3NoL0tjb25maWcgICAgICAgIHwgMyArKysKPiAgYXJjaC94ODYvS2Nv
bmZpZyAgICAgICB8IDMgKysrCj4gIGtlcm5lbC9LY29uZmlnLmtleGVjICAgfCAyICstCj4gIDEw
IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vS2NvbmZpZyBiL2FyY2gvYXJtL0tjb25maWcKPiBpbmRleCA1NGIy
YmI4MTdhN2YuLjIwMDk5NTA1MjY5MCAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9LY29uZmlnCj4g
KysrIGIvYXJjaC9hcm0vS2NvbmZpZwo+IEBAIC0xNTk3LDYgKzE1OTcsOSBAQCBjb25maWcgQVRB
R1NfUFJPQwo+ICBjb25maWcgQVJDSF9TVVBQT1JUU19DUkFTSF9EVU1QCj4gIAlkZWZfYm9vbCB5
Cj4gIAo+ICtjb25maWcgQVJDSF9ERUZBVUxUX0NSQVNIX0RVTVAKPiArCWRlZl9ib29sIHkKPiAr
Cj4gIGNvbmZpZyBBVVRPX1pSRUxBRERSCj4gIAlib29sICJBdXRvIGNhbGN1bGF0aW9uIG9mIHRo
ZSBkZWNvbXByZXNzZWQga2VybmVsIGltYWdlIGFkZHJlc3MiIGlmICFBUkNIX01VTFRJUExBVEZP
Uk0KPiAgCWRlZmF1bHQgIShBUkNIX0ZPT1RCUklER0UgfHwgQVJDSF9SUEMgfHwgQVJDSF9TQTEx
MDApCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gvYXJtNjQvS2NvbmZp
Zwo+IGluZGV4IGEyZjhmZjM1NGNhNi4uNDNlMDhjYzgyMDRmIDEwMDY0NAo+IC0tLSBhL2FyY2gv
YXJtNjQvS2NvbmZpZwo+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwo+IEBAIC0xNTU4LDYgKzE1
NTgsOSBAQCBjb25maWcgQVJDSF9ERUZBVUxUX0tFWEVDX0lNQUdFX1ZFUklGWV9TSUcKPiAgY29u
ZmlnIEFSQ0hfU1VQUE9SVFNfQ1JBU0hfRFVNUAo+ICAJZGVmX2Jvb2wgeQo+ICAKPiArY29uZmln
IEFSQ0hfREVGQVVMVF9DUkFTSF9EVU1QCj4gKwlkZWZfYm9vbCB5Cj4gKwo+ICBjb25maWcgQVJD
SF9IQVNfR0VORVJJQ19DUkFTSEtFUk5FTF9SRVNFUlZBVElPTgo+ICAJZGVmX2Jvb2wgQ1JBU0hf
UkVTRVJWRQo+ICAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9sb29uZ2FyY2gvS2NvbmZpZyBiL2FyY2gv
bG9vbmdhcmNoL0tjb25maWcKPiBpbmRleCA3MGYxNjkyMTBiNTIuLmNlMjMyZGRjZDI3ZCAxMDA2
NDQKPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9LY29uZmlnCj4gKysrIGIvYXJjaC9sb29uZ2FyY2gv
S2NvbmZpZwo+IEBAIC01OTksNiArNTk5LDkgQEAgY29uZmlnIEFSQ0hfU1VQUE9SVFNfS0VYRUMK
PiAgY29uZmlnIEFSQ0hfU1VQUE9SVFNfQ1JBU0hfRFVNUAo+ICAJZGVmX2Jvb2wgeQo+ICAKPiAr
Y29uZmlnIEFSQ0hfREVGQVVMVF9DUkFTSF9EVU1QCj4gKwlkZWZfYm9vbCB5Cj4gKwo+ICBjb25m
aWcgQVJDSF9TRUxFQ1RTX0NSQVNIX0RVTVAKPiAgCWRlZl9ib29sIHkKPiAgCWRlcGVuZHMgb24g
Q1JBU0hfRFVNUAo+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvS2NvbmZpZyBiL2FyY2gvbWlwcy9L
Y29uZmlnCj4gaW5kZXggNjAwNzdlNTc2OTM1Li5iNTQ3ZjQzMDRkMGMgMTAwNjQ0Cj4gLS0tIGEv
YXJjaC9taXBzL0tjb25maWcKPiArKysgYi9hcmNoL21pcHMvS2NvbmZpZwo+IEBAIC0yODgxLDYg
KzI4ODEsOSBAQCBjb25maWcgQVJDSF9TVVBQT1JUU19LRVhFQwo+ICBjb25maWcgQVJDSF9TVVBQ
T1JUU19DUkFTSF9EVU1QCj4gIAlkZWZfYm9vbCB5Cj4gIAo+ICtjb25maWcgQVJDSF9ERUZBVUxU
X0NSQVNIX0RVTVAKPiArCWRlZl9ib29sIHkKPiArCj4gIGNvbmZpZyBQSFlTSUNBTF9TVEFSVAo+
ICAJaGV4ICJQaHlzaWNhbCBhZGRyZXNzIHdoZXJlIHRoZSBrZXJuZWwgaXMgbG9hZGVkIgo+ICAJ
ZGVmYXVsdCAiMHhmZmZmZmZmZjg0MDAwMDAwIgo+IGRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMv
S2NvbmZpZyBiL2FyY2gvcG93ZXJwYy9LY29uZmlnCj4gaW5kZXggZDdiMDliMDY0YThhLi4wZjNj
MWY5NThlYWMgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL0tjb25maWcKPiArKysgYi9hcmNo
L3Bvd2VycGMvS2NvbmZpZwo+IEBAIC02ODIsNiArNjgyLDEwIEBAIGNvbmZpZyBSRUxPQ0FUQUJM
RV9URVNUCj4gIGNvbmZpZyBBUkNIX1NVUFBPUlRTX0NSQVNIX0RVTVAKPiAgCWRlZl9ib29sIFBQ
QzY0IHx8IFBQQ19CT09LM1NfMzIgfHwgUFBDXzg1eHggfHwgKDQ0eCAmJiAhU01QKQo+ICAKPiAr
Y29uZmlnIEFSQ0hfREVGQVVMVF9DUkFTSF9EVU1QCj4gKwlib29sCj4gKwlkZWZhdWx0IHkgaWYg
IVBQQ19CT09LM1NfMzIKPiArCj4gIGNvbmZpZyBBUkNIX1NFTEVDVFNfQ1JBU0hfRFVNUAo+ICAJ
ZGVmX2Jvb2wgeQo+ICAJZGVwZW5kcyBvbiBDUkFTSF9EVU1QCj4gZGlmZiAtLWdpdCBhL2FyY2gv
cmlzY3YvS2NvbmZpZyBiL2FyY2gvcmlzY3YvS2NvbmZpZwo+IGluZGV4IDBmM2NkN2MzYTQzNi4u
ZWIyNDdiNWVlNTY5IDEwMDY0NAo+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZwo+ICsrKyBiL2Fy
Y2gvcmlzY3YvS2NvbmZpZwo+IEBAIC04ODAsNiArODgwLDkgQEAgY29uZmlnIEFSQ0hfU1VQUE9S
VFNfS0VYRUNfUFVSR0FUT1JZCj4gIGNvbmZpZyBBUkNIX1NVUFBPUlRTX0NSQVNIX0RVTVAKPiAg
CWRlZl9ib29sIHkKPiAgCj4gK2NvbmZpZyBBUkNIX0RFRkFVTFRfQ1JBU0hfRFVNUAo+ICsJZGVm
X2Jvb2wgeQo+ICsKPiAgY29uZmlnIEFSQ0hfSEFTX0dFTkVSSUNfQ1JBU0hLRVJORUxfUkVTRVJW
QVRJT04KPiAgCWRlZl9ib29sIENSQVNIX1JFU0VSVkUKPiAgCj4gZGlmZiAtLWdpdCBhL2FyY2gv
czM5MC9LY29uZmlnIGIvYXJjaC9zMzkwL0tjb25maWcKPiBpbmRleCBhODIyZjk1MmY2NGEuLjA1
YTFmYjQwODQ3MSAxMDA2NDQKPiAtLS0gYS9hcmNoL3MzOTAvS2NvbmZpZwo+ICsrKyBiL2FyY2gv
czM5MC9LY29uZmlnCj4gQEAgLTI3NSw2ICsyNzUsOSBAQCBjb25maWcgQVJDSF9TVVBQT1JUU19D
UkFTSF9EVU1QCj4gIAkgIFRoaXMgb3B0aW9uIGFsc28gZW5hYmxlcyBzMzkwIHpmY3BkdW1wLgo+
ICAJICBTZWUgYWxzbyA8ZmlsZTpEb2N1bWVudGF0aW9uL2FyY2gvczM5MC96ZmNwZHVtcC5yc3Q+
Cj4gIAo+ICtjb25maWcgQVJDSF9ERUZBVUxUX0NSQVNIX0RVTVAKPiArCWRlZl9ib29sIHkKPiAr
Cj4gIG1lbnUgIlByb2Nlc3NvciB0eXBlIGFuZCBmZWF0dXJlcyIKPiAgCj4gIGNvbmZpZyBIQVZF
X01BUkNIX1oxMF9GRUFUVVJFUwo+IGRpZmYgLS1naXQgYS9hcmNoL3NoL0tjb25maWcgYi9hcmNo
L3NoL0tjb25maWcKPiBpbmRleCAxYWEzYzRhMGM1YjIuLjNhNjMzODk2MjYzNiAxMDA2NDQKPiAt
LS0gYS9hcmNoL3NoL0tjb25maWcKPiArKysgYi9hcmNoL3NoL0tjb25maWcKPiBAQCAtNTQ5LDYg
KzU0OSw5IEBAIGNvbmZpZyBBUkNIX1NVUFBPUlRTX0tFWEVDCj4gIGNvbmZpZyBBUkNIX1NVUFBP
UlRTX0NSQVNIX0RVTVAKPiAgCWRlZl9ib29sIEJST0tFTl9PTl9TTVAKPiAgCj4gK2NvbmZpZyBB
UkNIX0RFRkFVTFRfQ1JBU0hfRFVNUAo+ICsJZGVmX2Jvb2wgeQo+ICsKPiAgY29uZmlnIEFSQ0hf
U1VQUE9SVFNfS0VYRUNfSlVNUAo+ICAJZGVmX2Jvb2wgeQo+ICAKPiBkaWZmIC0tZ2l0IGEvYXJj
aC94ODYvS2NvbmZpZyBiL2FyY2gveDg2L0tjb25maWcKPiBpbmRleCAwMDdiYWI5ZjJhMGUuLmFh
NDY2NmJiOWU5YyAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9LY29uZmlnCj4gKysrIGIvYXJjaC94
ODYvS2NvbmZpZwo+IEBAIC0yMDg3LDYgKzIwODcsOSBAQCBjb25maWcgQVJDSF9TVVBQT1JUU19L
RVhFQ19KVU1QCj4gIGNvbmZpZyBBUkNIX1NVUFBPUlRTX0NSQVNIX0RVTVAKPiAgCWRlZl9ib29s
IFg4Nl82NCB8fCAoWDg2XzMyICYmIEhJR0hNRU0pCj4gIAo+ICtjb25maWcgQVJDSF9ERUZBVUxU
X0NSQVNIX0RVTVAKPiArCWRlZl9ib29sIHkKPiArCj4gIGNvbmZpZyBBUkNIX1NVUFBPUlRTX0NS
QVNIX0hPVFBMVUcKPiAgCWRlZl9ib29sIHkKPiAgCj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9LY29u
ZmlnLmtleGVjIGIva2VybmVsL0tjb25maWcua2V4ZWMKPiBpbmRleCA2YzM0ZTYzYzg4ZmYuLjRk
MTExZjg3MTk1MSAxMDA2NDQKPiAtLS0gYS9rZXJuZWwvS2NvbmZpZy5rZXhlYwo+ICsrKyBiL2tl
cm5lbC9LY29uZmlnLmtleGVjCj4gQEAgLTk3LDcgKzk3LDcgQEAgY29uZmlnIEtFWEVDX0pVTVAK
PiAgCj4gIGNvbmZpZyBDUkFTSF9EVU1QCj4gIAlib29sICJrZXJuZWwgY3Jhc2ggZHVtcHMiCj4g
LQlkZWZhdWx0IHkKPiArCWRlZmF1bHQgQVJDSF9ERUZBVUxUX0NSQVNIX0RVTVAKPiAgCWRlcGVu
ZHMgb24gQVJDSF9TVVBQT1JUU19DUkFTSF9EVU1QCj4gIAlkZXBlbmRzIG9uIEtFWEVDX0NPUkUK
PiAgCXNlbGVjdCBWTUNPUkVfSU5GTwoKSXQgc2hvdWxkIGJlIGRpc2FibGVkIG9uIG02OGsgYW5k
IHNoIGJ5IGRlZmF1bHQgYXMgd2VsbC4KCkFkcmlhbgoKLS0gCiAuJydgLiAgSm9obiBQYXVsIEFk
cmlhbiBHbGF1Yml0ego6IDonIDogIERlYmlhbiBEZXZlbG9wZXIKYC4gYCcgICBQaHlzaWNpc3QK
ICBgLSAgICBHUEc6IDYyRkYgOEE3NSA4NEUwIDI5NTYgOTU0NiAgMDAwNiA3NDI2IDNCMzcgRjVC
NSBGOTEzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

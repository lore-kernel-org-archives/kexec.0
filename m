Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B84BC4332F
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FYwXrYNX513pFY3HOXkp9O3rxgYqfTGgxu1sLNVXq6Y=; b=xsce5ftn5GXanX
	tvd5kQEy4+IS+tsl/rawT1FcEnJ+BQpTjmUELd9duUcwBjQzTTBV08Otv+7o3V2xvfKOnJNV1lZ7b
	OVnC2OI94kr0pEslJchADGimf5pS852Q9GBGGGDn6QQfH4KZNKOaez3ez1zFjkB/+nhV0m9gB6m52
	EVN8gzGPL3TYzbyqzuu+vt8WN48aDeJ6tu0kz9GM2Fw42y2WyaRD/y2Qd5jisHcDe+YgEYJbmdq7e
	DyKhlSyZ+bcqEbh3hTR83I6l7AVIEWYtZvHkpSA99OHo+GQvP0Ad/SJgJSqWkwK4zkSeS4ud1h196
	NS5w8C6CWLhqOOiQnNhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjRZ-005VWn-WC; Tue, 18 Oct 2022 10:03:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjRX-005VUu-5r
	for kexec@lists.infradead.org; Tue, 18 Oct 2022 10:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666087405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbUnzvIvlrGRDX1mE6CPBS4n0v7KTHoQYr0wJY597WU=;
	b=eRSXz6ECA0TywF0lRDv+nsWrD4Smyia67uyF01mQ3RIyNoktnMjO/R41H/QcVfurH+moP4
	OC4ADFeu8mvQ+gT7LB8N6pblTb6ImDuPq91sI/ocVwh7MHZSZn8vvfvrEj2Xi2dzcHZ/JV
	HsGyeh+Ul4e6wOu/ll50Uklldh4lpxs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-nmYZgiEOO2iUX8PsY6IIIA-1; Tue, 18 Oct 2022 06:03:20 -0400
X-MC-Unique: nmYZgiEOO2iUX8PsY6IIIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A535982DFDD;
	Tue, 18 Oct 2022 10:03:19 +0000 (UTC)
Received: from localhost (ovpn-12-68.pek2.redhat.com [10.72.12.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 64908146820D;
	Tue, 18 Oct 2022 10:03:18 +0000 (UTC)
Date: Tue, 18 Oct 2022 18:03:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: Kazuhito Hagio <k-hagio-ab@nec.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
	heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
	alexandre.ghiti@canonical.com, vgoyal@redhat.com, dyoung@redhat.com,
	corbet@lwn.net, Conor.Dooley@microchip.com, bagasdotme@gmail.com,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
	hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
Message-ID: <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_030327_325682_78B90B8E 
X-CRM114-Status: GOOD (  31.08  )
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

T24gMTAvMTgvMjIgYXQgMDU6MjVwbSwgWGlhbnRpbmcgVGlhbiB3cm90ZToKPiAKPiDlnKggMjAy
Mi8xMC8xOCDkuIvljYg1OjEwLCBCYW9xdWFuIEhlIOWGmemBkzoKPiA+IE9uIDEwLzE4LzIyIGF0
IDA0OjE3cG0sIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4gPiA+IEFkZCBhcmNoX2NyYXNoX3NhdmVf
dm1jb3JlaW5mbygpLCB3aGljaCBleHBvcnRzIFZNIGxheW91dChNT0RVTEVTLCBWTUFMTE9DLAo+
ID4gPiBWTUVNTUFQIGFuZCBLRVJORUxfTElOS19BRERSIHJhbmdlcyksIHZhIGJpdHMgYW5kIHJh
bSBiYXNlIGZvciB2bWNvcmUuCj4gPiA+IAo+ID4gPiBEZWZhdWx0IHBhZ2V0YWJsZSBsZXZlbHMg
YW5kIFBBR0VfT0ZGU0VUIGFyZW4ndCBzYW1lIGZvciBkaWZmZXJlbnQga2VybmVsCj4gPiA+IHZl
cnNpb24gYXMgYmVsb3cuIEZvciBwYWdldGFibGUgbGV2ZWxzLCBpdCBzZXRzIHN2NTcgYnkgZGVm
YXVsdCBhbmQgZmFsbHMKPiA+ID4gYmFjayB0byBzZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlm
IHN2NTcgaXMgbm90IHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuCj4gPiA+IAo+ID4gPiBGb3Ig
cmFtIGJhc2UsIHRoZSBkZWZhdWx0IHZhbHVlIGlzIDB4ODAyMDAwMDAgZm9yIHFlbXUgcmlzY3Y2
NCBlbnYgYW5kLAo+ID4gPiBmb3IgZXhhbXBsZSwgaXMgMHgyMDAwMDAgb24gdGhlIFh1YW5UaWUg
OTEwIENQVS4KPiA+ID4gCj4gPiA+ICAgKiBMaW51eCBLZXJuZWwgNS4xOCB+Cj4gPiA+ICAgKiAg
ICAgIFBHVEFCTEVfTEVWRUxTID0gNQo+ID4gPiAgICogICAgICBQQUdFX09GRlNFVCA9IDB4ZmY2
MDAwMDAwMDAwMDAwMAo+ID4gPiAgICogTGludXggS2VybmVsIDUuMTcgfgo+ID4gPiAgICogICAg
ICBQR1RBQkxFX0xFVkVMUyA9IDQKPiA+ID4gICAqICAgICAgUEFHRV9PRkZTRVQgPSAweGZmZmZh
ZjgwMDAwMDAwMDAKPiA+ID4gICAqIExpbnV4IEtlcm5lbCA0LjE5IH4KPiA+ID4gICAqICAgICAg
UEdUQUJMRV9MRVZFTFMgPSAzCj4gPiA+ICAgKiAgICAgIFBBR0VfT0ZGU0VUID0gMHhmZmZmZmZl
MDAwMDAwMDAwCj4gPiA+IAo+ID4gPiBTaW5jZSB0aGVzZSBjb25maWd1cmF0aW9ucyBjaGFuZ2Ug
ZnJvbSB0aW1lIHRvIHRpbWUgYW5kIHZlcnNpb24gdG8gdmVyc2lvbiwKPiA+ID4gaXQgaXMgcHJl
ZmVyYWJsZSB0byBleHBvcnQgdGhlbSB2aWEgdm1jb3JlaW5mbyB0aGFuIHRvIGNoYW5nZSB0aGUg
Y3Jhc2gncwo+ID4gPiBjb2RlIGZyZXF1ZW50bHksIGl0IGNhbiBzaW1wbGlmeSB0aGUgZGV2ZWxv
cG1lbnQgb2YgY3Jhc2ggdG9vbC4KPiA+ID4gCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW50aW5n
IFRpYW4gPHhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAg
IGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAgICB8ICAxICsKPiA+ID4gICBhcmNoL3Jpc2N2
L2tlcm5lbC9jcmFzaF9jb3JlLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+
ID4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQo+ID4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMKPiA+ID4gCj4gPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSBiL2FyY2gvcmlzY3Yva2VybmVs
L01ha2VmaWxlCj4gPiA+IGluZGV4IGRiNmU0YjEyOTRiYS4uNGNmMzAzYTc3OWFiIDEwMDY0NAo+
ID4gPiAtLS0gYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+ID4gPiArKysgYi9hcmNoL3Jp
c2N2L2tlcm5lbC9NYWtlZmlsZQo+ID4gPiBAQCAtODEsNiArODEsNyBAQCBvYmotJChDT05GSUdf
S0dEQikJCSs9IGtnZGIubwo+ID4gPiAgIG9iai0kKENPTkZJR19LRVhFQ19DT1JFKQkrPSBrZXhl
Y19yZWxvY2F0ZS5vIGNyYXNoX3NhdmVfcmVncy5vIG1hY2hpbmVfa2V4ZWMubwo+ID4gPiAgIG9i
ai0kKENPTkZJR19LRVhFQ19GSUxFKQkrPSBlbGZfa2V4ZWMubyBtYWNoaW5lX2tleGVjX2ZpbGUu
bwo+ID4gPiAgIG9iai0kKENPTkZJR19DUkFTSF9EVU1QKQkrPSBjcmFzaF9kdW1wLm8KPiA+ID4g
K29iai0kKENPTkZJR19DUkFTSF9DT1JFKQkrPSBjcmFzaF9jb3JlLm8KPiA+ID4gICBvYmotJChD
T05GSUdfSlVNUF9MQUJFTCkJKz0ganVtcF9sYWJlbC5vCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNo
L3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3Jl
LmMKPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi44
ZDdmNWZmMTA4ZGEKPiA+ID4gLS0tIC9kZXYvbnVsbAo+ID4gPiArKysgYi9hcmNoL3Jpc2N2L2tl
cm5lbC9jcmFzaF9jb3JlLmMKPiA+ID4gQEAgLTAsMCArMSwyOSBAQAo+ID4gPiArLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+ID4gPiArCj4gPiA+ICsjaW5jbHVkZSA8
bGludXgvY3Jhc2hfY29yZS5oPgo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4KPiA+
ID4gKwo+ID4gPiArdm9pZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyh2b2lkKQo+ID4gPiAr
ewo+ID4gPiArCVZNQ09SRUlORk9fTlVNQkVSKFZBX0JJVFMpOwo+ID4gPiArCVZNQ09SRUlORk9f
TlVNQkVSKHBoeXNfcmFtX2Jhc2UpOwo+ID4gPiArCj4gPiA+ICsJdm1jb3JlaW5mb19hcHBlbmRf
c3RyKCJOVU1CRVIoUEFHRV9PRkZTRVQpPTB4JWx4XG4iLCBQQUdFX09GRlNFVCk7Cj4gPiA+ICsJ
dm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1BTExPQ19TVEFSVCk9MHglbHhcbiIsIFZN
QUxMT0NfU1RBUlQpOwo+ID4gPiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxM
T0NfRU5EKT0weCVseFxuIiwgVk1BTExPQ19FTkQpOwo+ID4gPiArCXZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKFZNRU1NQVBfU1RBUlQpPTB4JWx4XG4iLCBWTUVNTUFQX1NUQVJUKTsKPiA+
ID4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihWTUVNTUFQX0VORCk9MHglbHhcbiIs
IFZNRU1NQVBfRU5EKTsKPiA+ID4gKyNpZmRlZiBDT05GSUdfNjRCSVQKPiA+ID4gKwl2bWNvcmVp
bmZvX2FwcGVuZF9zdHIoIk5VTUJFUihNT0RVTEVTX1ZBRERSKT0weCVseFxuIiwgTU9EVUxFU19W
QUREUik7Cj4gPiA+ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoTU9EVUxFU19FTkQp
PTB4JWx4XG4iLCBNT0RVTEVTX0VORCk7Cj4gPiA+ICsjZW5kaWYKPiA+ID4gKwo+ID4gPiArCWlm
IChJU19FTkFCTEVEKENPTkZJR182NEJJVCkpIHsKPiA+ID4gKyNpZmRlZiBDT05GSUdfS0FTQU4K
PiA+ID4gKwkJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX1NUQVJU
KT0weCVseFxuIiwgS0FTQU5fU0hBRE9XX1NUQVJUKTsKPiA+ID4gKwkJdm1jb3JlaW5mb19hcHBl
bmRfc3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX0VORCk9MHglbHhcbiIsIEtBU0FOX1NIQURPV19F
TkQpOwo+ID4gPiArI2VuZGlmCj4gPiA+ICsJCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVS
KEtFUk5FTF9MSU5LX0FERFIpPTB4JWx4XG4iLCBLRVJORUxfTElOS19BRERSKTsKPiA+ID4gKwkJ
dm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoQUREUkVTU19TUEFDRV9FTkQpPTB4JWx4XG4i
LCBBRERSRVNTX1NQQUNFX0VORCk7Cj4gPiBTZWVtcyB0aGlzIGlzIHRoZSBmaXJzciBBUkNIIHdo
ZXJlIGthc2FuIGFuZCBrZXJuZWwgbGluay9icGYgc3BhY2UgYXJlCj4gPiBhZGRlZCB0byBkdW1w
IGFuZCBhbmFseXplLiBKdXN0IGN1cmlvdXMsIGhhdmUgeW91IGdvdCBjb2RlIGNoYW5nZSB0bwo+
ID4gbWFrZSB1c2Ugb2YgdGhlbSB0byBkbyBkdW1waW5nIGFuZCBhbmFseXplPwo+IAo+IEtBU0FO
X1NIQURPV19TVEFSVCBpcyBub3QgdXNlZCwgS0VSTkVMX0xJTktfQUREUiBpcyB1c2VkIGluIHRo
ZSBjcmFzaCBwYXRjaCBzZXQ6Cj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LXJpc2N2L2NvdmVyLzIwMjIwODEzMDMxNzUzLjMwOTc3MjAtMS14aWFudGluZy50aWFu
QGxpbnV4LmFsaWJhYmEuY29tLwoKT2gsIEkgd291bGQgc2F5IHBsZWFzZSBuby4gU29tZXRpbWUg
d2UgZ290IHRvbnMgb2Ygb2JqZWN0aW9uIHdoZW4gYWRkaW5nIGFuCm5lY2Vzc2FyeSBvbmUsIHdl
IGRlZmluaXRlbHkgc2hvdWxkIG5vdCBhZGQgb25lIGZvciBwb3NzaWJsZSBmdXR1cmUKdXNlLgoK
Rm9yIHRoaXMga2luZCBvZiBuZXdseSBhZGRlZCBvbmUsIHdlIG5lZWQgZ2V0IGFjayBmcm9tCm1h
a2VkdW1wZmlsZS9jcmFzaCB1dGlsaXR5IG1haW50YWluZXIgc28gdGhhdCB3ZSBrbm93IHRoZXkg
YXJlIG5lY2Vzc2FyeQp0byBoYXZlLiBBdCBsZWFzdCB0aGV5IGRvbid0IG9wcG9zZS4KCj4gCj4g
SSBhZGQgaXQgaW4gY2FzZSBvZiB1c2luZyBpbiBmdXJ0dXJlLgo+IAo+ID4gCj4gPiBUaGFua3MK
PiA+IEJhb3F1YW4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

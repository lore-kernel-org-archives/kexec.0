Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0956C4332F
	for <kexec@archiver.kernel.org>; Sat, 11 Nov 2023 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v1KkSJW11mw4+HDmhpsI2KbdgWTiw1xv9IZHGXmgNYI=; b=Dum1pz3uSlpirF
	PeYdUoY2mVC3s4r7eqyNLE6/hCOHM06F6VzZSlOkRILMXQok/aGF5XNYE7kzMmP8v2izA5BRzxpAR
	Iz7kWDefB/MUO6z0kQWnM2lLkCuTCUKy2aRWdFDEniwIpsesruSuxPtJ9zE5aU2uWo/XyfQH8Jh1o
	spfbYhoh8jxG1MrV+zk7dSXzAreoECLpv7lCfjL2p3QSIK+OBwpsLxy6ZDmKE3Oc+Q1eQF5+RDzGy
	Bv45EUVH5ZCwfU8hvK0H5Enrf7B+PKGZJ/VpZ5tEDdeCBMSl96Eff5QiiqNdnCGNiM9PKEQe0CHiB
	ZK6y7s9miTPJoMzSbMeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1uid-00BLJe-0s;
	Sat, 11 Nov 2023 20:36:39 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1uia-00BLJF-0J
	for kexec@lists.infradead.org;
	Sat, 11 Nov 2023 20:36:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1699734993;
	bh=ON6trIcp7+DuqniQpmZTvh3ZoJcgh3VkSs5gIMRrdsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WTKYSRyGsv4eOSdLugUtX+cv+QbiPhjvvPrjnW6sMArcM4T1WD6UeH9iTOwjh3jSy
	 iDmBEDpKUiUTUzOc+RxDoRUhRi+yd4bObhI4YYIWNXPtmKxefuQmnf3XHKNGuj24PY
	 3sDecx94xUTHeTf5WpLpoRx7VMq4BuZeD5vV7GLA=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 3BB58128609B;
	Sat, 11 Nov 2023 15:36:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id z2rW164A0x_h; Sat, 11 Nov 2023 15:36:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1699734993;
	bh=ON6trIcp7+DuqniQpmZTvh3ZoJcgh3VkSs5gIMRrdsU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=WTKYSRyGsv4eOSdLugUtX+cv+QbiPhjvvPrjnW6sMArcM4T1WD6UeH9iTOwjh3jSy
	 iDmBEDpKUiUTUzOc+RxDoRUhRi+yd4bObhI4YYIWNXPtmKxefuQmnf3XHKNGuj24PY
	 3sDecx94xUTHeTf5WpLpoRx7VMq4BuZeD5vV7GLA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 33B2B1286097;
	Sat, 11 Nov 2023 15:36:31 -0500 (EST)
Message-ID: <87f56530b85ea894036a74be1824d6f2716f70de.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 06/13] x86: Add early SHA support for Secure Launch
 early measurements
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Eric Biggers
	 <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org, 
 kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
 dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de,  hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
 luto@amacapital.net,  nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
 trenchboot-devel@googlegroups.com
Date: Sat, 11 Nov 2023 15:36:29 -0500
In-Reply-To: <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
References: <20231110222751.219836-1-ross.philipson@oracle.com>
	 <20231110222751.219836-7-ross.philipson@oracle.com>
	 <20231111174435.GA998@sol.localdomain>
	 <a16d44c5-2e1a-4e9a-8ca1-c7ca564f61cd@citrix.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231111_123636_140900_16762F0F 
X-CRM114-Status: GOOD (  23.16  )
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

T24gU2F0LCAyMDIzLTExLTExIGF0IDE4OjE5ICswMDAwLCBBbmRyZXcgQ29vcGVyIHdyb3RlOgo+
IE9uIDExLzExLzIwMjMgNTo0NCBwbSwgRXJpYyBCaWdnZXJzIHdyb3RlOgo+ID4gT24gRnJpLCBO
b3YgMTAsIDIwMjMgYXQgMDU6Mjc6NDRQTSAtMDUwMCwgUm9zcyBQaGlsaXBzb24gd3JvdGU6Cj4g
PiA+IMKgYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2Vhcmx5X3NoYTEuY8KgwqAgfCAxMiArKysr
Cj4gPiA+IMKgbGliL2NyeXB0by9zaGExLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDgxCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysKPiA+IEl0
J3Mgc3VycHJpc2luZyB0byBzdGlsbCBzZWUgdGhpcyBuZXcgdXNlIG9mIFNIQS0xIGFmdGVyIHNv
IG1hbnkKPiA+IHBlb3BsZSBvYmplY3RlZCB0byBpdCBpbiB0aGUgdjYgcGF0Y2hzZXQuwqAgSXQn
cyBhbHNvIGZydXN0cmF0aW5nCj4gPiB0aGF0IHRoZSBTSEEtMSBzdXBwb3J0IGlzIHN0aWxsIGJl
aW5nIG9iZnVzY2F0ZWQgYnkgYmVpbmcgY29tYmluZWQKPiA+IGluIG9uZSBwYXRjaCB3aXRoIFNI
QS0yIHN1cHBvcnQsIHBlcmhhcHMgaW4gYW4gYXR0ZW1wdCB0byBjb25mbGF0ZQo+ID4gdGhlIHR3
byBhbGdvcml0aG1zIGFuZCBhdm9pZCBoYXZpbmcgdG8gZ2l2ZSBhIHJhdGlvbmFsZSBmb3IgdGhl
Cj4gPiBpbmNsdXNpb24gb2YgU0hBLTEuwqAgRmluYWxseSwgbmV3IGZ1bmN0aW9ucyBzaG91bGQg
bm90IGJlIGFkZGVkIHRvCj4gPiBsaWIvY3J5cHRvL3NoYTEuYyB1bmxlc3MgdGhvc2UgZnVuY3Rp
b25zIGhhdmUgbXVsdGlwbGUgdXNlcnMuCj4gCj4gVGhlIHJhdGlvbmFsIHdhcyBnaXZlbi7CoCBM
ZXQgbWUgcmVpdGVyYXRlIGl0Lgo+IAo+IFRoZXJlIGFyZSByZWFsIFRQTXMgaW4gdGhlIHdvcmxk
IHRoYXQgY2FuJ3QgdXNlIFNIQS0yLsKgIFRoZSB1c2Ugb2YKPiBTSEEtMSBpcyBuZWNlc3Nhcnkg
dG8gc3VwcG9ydCBEUlRNIG9uIHN1Y2ggc3lzdGVtcywgYW5kIHRoZXJlIGFyZQo+IHJlYWwgdXNl
cnMgb2Ygc3VjaCBjb25maWd1cmF0aW9ucy4KCkdpdmVuIHRoYXQgVFBNIDIuMCBoYXMgYmVlbiBz
aGlwcGluZyBpbiBidWxrIHNpbmNlIFdpbmRvd3MgMTAgKDIwMTUpCmFuZCBpcyByZXF1aXJlZCBm
b3IgV2luZG93cyAxMSAoMjAyMSksIGFyZSB0aGVyZSByZWFsbHkgc3VjaCBodWdlCm51bWJlcnMg
b2YgVFBNIDEuMiBzeXN0ZW1zIGludm9sdmVkIGluIHNlY3VyaXR5IGZ1bmN0aW9ucz8KCj4gRFJU
TSB3aXRoIFNIQS0xLW9ubHkgaXMgYSBkYW1uc2lnaHQgYmV0dGVyIHRoYW4gbm8gRFRSTSwgZXZl
biBpZiBTSEEtCj4gMSBpcyBnZXR0aW5nIGEgbGl0dGxlIGxvbmcgaW4gdGhlIHRvb3RoLgoKVGhh
dCdzIG5vdCB0aGUgcHJvYmxlbS4gIFRoZSBwcm9ibGVtIGlzIHRoYXQgc2hhMSBpcyBzZWVuIGFz
IGEKY29tcHJvbWlzZWQgYWxnb3JpdGhtIGJ5IE5JU1Qgd2hpY2ggYmVnYW4gZGVwcmVjYXRpbmcg
aXQgaW4gMjAxMSBhbmQgaXMKbm93IHJlcXVpcmluZyBpdCB0byBiZSByZW1vdmVkIGZyb20gYWxs
IHN5c3RlbXMgc3VwcGxpZWQgdG8gdGhlIFVTCmdvdmVybm1lbnQgYnkgMjAzMAoKaHR0cHM6Ly93
d3cubmlzdC5nb3YvbmV3cy1ldmVudHMvbmV3cy8yMDIyLzEyL25pc3QtcmV0aXJlcy1zaGEtMS1j
cnlwdG9ncmFwaGljLWFsZ29yaXRobQoKVGhhdCBtZWFucyB3ZSBoYXZlIHRvIGNvbnRyb2wgYWxs
IHVzZXMgb2Ygc2hhMSBpbiB0aGUga2VybmVsIGFuZCBoYXZlCmFuIG9wdGlvbiB0byBidWlsZCB3
aXRob3V0IGl0LiAgRklQUyBoYXMgYW4gZXZlbiB0aWdodGVyIHRpbWV0YWJsZTogaXQKcmVxdWly
ZXMgc2hhMSB0byBiZSBvdXQgYnkgMjAyNS4KCj4gU28gdW5sZXNzIHlvdSBoYXZlIGEgY3JlZGli
bGUgcGxhbiB0byB1cGdyYWRlIGV2ZXJ5IG5vbi1TSEEtMiBUUE0gaW4KPiB0aGUgd29ybGQsIHlv
dSBhcmUgZGVsaWJlcmF0ZWx5IGJyZWFraW5nIHBhcnQgb2YgdGhlIHVzZWNhc2UgcGF5aW5nCj4g
Zm9yIHRoZSBlZmZvcnQgb2YgdHJ5aW5nIHRvIHVwc3RyZWFtIERSVE0gc3VwcG9ydCBpbnRvIExp
bnV4LgoKR2l2ZW4gdGhhdCBtb3N0IENTT3MgZm9sbG93IE5JU1QgYW5kIEZJUFMgaXQgc2VlbXMg
YSBsaXR0bGUgc3RyYW5nZQp0aGF0IHRoZXJlIHdvdWxkIGJlIGEgaHVnZSBkZW1hbmQgZm9yIHN1
Y2ggYW4gaW50cmljYXRlIHNlY3VyaXR5CnByb3RvY29sIGFzIER5bmFtaWMgTGF1bmNoIG9uIGEg
c3lzdGVtIHRoYXQgY2FuJ3QgYmUgRklQUyAxNDAtMwpjZXJ0aWZpZWQuCgpKYW1lcwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK

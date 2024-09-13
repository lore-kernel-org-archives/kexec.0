Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D5DEED636
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 00:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/bFUflgvADkIz+bkoPOZSkzvWolRbV/hX4hA7ss8QVA=; b=HS/2/M29ISOLXc
	KU+QMHqYdYj/DTLU4PO0Jw3gZiBcPJt+NOXjhhZRl1Ux8YvyeTJ2xBuz03zwRxzFThy4Yi5lK4nzq
	HeDKDHX4cOmHCqRp+Gyv9AIPfp8pPvho6GLeoS+LPaetBFAzh1ln4nX2LRLQ4X+o1ul+IRfBgyT1S
	AfvKsjCaBZ5skZKePolq3y2/xCC9mw2yL1+iMFylUnNMeYvzXUs3X0ah3YQRgS9lrwIxvzM9b4k8I
	ViHhaJA60HLX57J67MsLWiSVHbItlFrJ9JPLC+82ovOV496KKS9yOv/CsQArbTy6Fd3ndRflRfQ7f
	Imy6IxIj/OJO+J0iPb7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1souHT-0000000EbKQ-0I3f;
	Fri, 13 Sep 2024 00:35:23 +0000
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1souHR-0000000EbK3-01KE
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 00:35:22 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1726187681; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQZZoO1GdRMjOMaE+32jcQqZlBE73nFdLQLrlJHHDwWHrSfD9G37df/k8dYYievD5ey3GnDo4v/Torjz4Ea3uaaA4pEISHQTBYWhK6RFiJDXwOyaR+Z5D4O8HOSYtc9eBoQW7I9KYEL6pozwsRcu5nCT+kPD+JpbQg0hMPRorIc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726187681; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T7p1rwwLWDZqzIO3KBZ6In4AI2NiE3aqshFaj7LI/og=; 
	b=aJeQ6mVd6eTC96nOK3A63MwDgR17ENPkwQ5IGnCiFEQb/5PrXVw3day5oh/tQhHSKA5pg2T68lu3LNAZ/9eUBAqQs63Cklp62sbpfLON6Z27CJn6Sp9uy0KJ+Jv6HbM43ls6ROmbRzIe7Ai6ms7jxnHg7Op9X6nZaD6qiQcB0vg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726187681;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T7p1rwwLWDZqzIO3KBZ6In4AI2NiE3aqshFaj7LI/og=;
	b=ENsJ49sYMCyT34DFM1kNtaKzqa3g/gukXlVy0JpcXNWf9vA5ZxzXwD1YpEeUrVNU
	Qw0BcfCtgT3WRPi8PdBCfUIMhG4jcb5wLNncyYgsNPbG5B3OT1aeO8tCHORURMWFpti
	YHn/c9fTDv3V09tC5K+Yb8eBRUyr4hO40Eyu1rHw=
Received: by mx.zohomail.com with SMTPS id 1726187680192286.84244920487254;
	Thu, 12 Sep 2024 17:34:40 -0700 (PDT)
Message-ID: <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
Date: Thu, 12 Sep 2024 20:34:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Andy Lutomirski <luto@amacapital.net>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
 ardb@kernel.org, mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
Content-Language: en-US
In-Reply-To: <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_173521_117929_0D3615C4 
X-CRM114-Status: GOOD (  30.23  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGV5IGFnYWluLAoKT24gOS80LzI0IDIxOjAxLCBEYW5pZWwgUC4gU21pdGggd3JvdGU6Cj4gSGkg
THV0by4KPiAKPiBPbiA4LzI4LzI0IDIzOjE3LCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4+IE9u
IFRodSwgQXVnIDE1LCAyMDI0IGF0IDEyOjEw4oCvUE0gVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxp
bnV0cm9uaXguZGU+IAo+PiB3cm90ZToKPj4+Cj4+PiBPbiBUaHUsIEF1ZyAxNSAyMDI0IGF0IDEz
OjM4LCBEYW5pZWwgUC4gU21pdGggd3JvdGU6Cj4+Pj4gT24gNS8zMS8yNCAwOTo1NCwgRXJpYyBX
LiBCaWVkZXJtYW4gd3JvdGU6Cj4+Pj4+IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNAa2VybmVsLm9y
Zz4gd3JpdGVzOgo+Pj4+Pj4gVGhhdCBwYXJhZ3JhcGggaXMgYWxzbyBwaHJhc2VkIGFzIGEgaHlw
b3RoZXRpY2FsLCAiRXZlbiBpZiB3ZSdkIAo+Pj4+Pj4gcHJlZmVyIHRvIHVzZQo+Pj4+Pj4gU0hB
LTI1Ni1vbmx5Ii7CoCBUaGF0IGltcGxpZXMgdGhhdCB5b3UgZG8gbm90LCBpbiBmYWN0LCBwcmVm
ZXIgCj4+Pj4+PiBTSEEtMjU2IG9ubHkuwqAgSXMKPj4+Pj4+IHRoYXQgdGhlIGNhc2U/wqAgU3Vy
ZSwgbWF5YmUgdGhlcmUgYXJlIHNpdHVhdGlvbnMgd2hlcmUgeW91ICpoYXZlKiAKPj4+Pj4+IHRv
IHVzZSBTSEEtMSwKPj4+Pj4+IGJ1dCB3aHkgd291bGQgeW91IG5vdCBhdCBsZWFzdCAqcHJlZmVy
KiBTSEEtMjU2Pwo+Pj4+Pgo+Pj4+PiBZZXMuwqAgUGxlYXNlIHByZWZlciB0byB1c2UgU0hBLTI1
Ni4KPj4+Pj4KPj4+Pj4gSGF2ZSB5b3UgY29uc2lkZXJlZCBpbXBsZW1lbnRpbmcgSSB0aGluayBp
dCBpcyBTSEExLURDIChhcyBnaXQgaGFzKSAKPj4+Pj4gdGhhdAo+Pj4+PiBpcyBjb21wYXRpYmxl
IHdpdGggU0hBMSBidXQgYmxvY2tzIHRoZSBrbm93biBjbGFzcyBvZiBhdHRhY2tzIHdoZXJlCj4+
Pj4+IHNoYTEgaXMgYWN0aXZlbHkgYnJva2VuIGF0IHRoaXMgcG9pbnQ/Cj4+Pj4KPj4+PiBXZSBh
cmUgdXNpbmcgdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uLCBhZGRyZXNzaW5nIHdoYXQgdGhl
IGtlcm5lbAo+Pj4+IHByb3ZpZGVzIGlzIGJleW9uZCBvdXIgZWZmb3J0cy4gUGVyaGFwcyBzb21l
b25lIHdobyBpcyBpbnRlcmVzdGVkIGluCj4+Pj4gaW1wcm92aW5nIHRoZSBrZXJuZWwncyBTSEEx
IGNvdWxkIHN1Ym1pdCBhIHBhdGNoIGltcGxlbWVudGluZy9yZXBsYWNpbmcKPj4+PiBpdCB3aXRo
IFNIQTEtREMsIGFzIEkgYW0gc3VyZSB0aGUgbWFpbnRhaW5lcnMgd291bGQgd2VsY29tZSB0aGUg
aGVscC4KPj4+Cj4+PiBXZWxsLCBzb21lb25lIHdobyBpcyBpbnRlcmVzdGVkIHRvIGdldCBoaXMg
InNlY3VyZSIgY29kZSBtZXJnZWQgc2hvdWxkCj4+PiBoYXZlIGEgdmVzdGVkIGludGVyZXN0ZWQg
dG8gaGF2ZSBhIG5vbi1icm9rZW4gU0hBMSBpbXBsZW1lbnRhdGlvbiBpZgo+Pj4gdGhlcmUgaXMg
YSBzZW5zaWJsZSByZXF1aXJlbWVudCB0byB1c2UgU0hBMSBpbiB0aGF0IG5ldyAic2VjdXJlIiBj
b2RlLAo+Pj4gbm8/Cj4+Pgo+Pj4gSnVzdCBmb3IgdGhlIHJlY29yZC4gVGhlIHJlbGF0ZWQgbWFp
bnRhaW5lcnMgY2FuIHJpZ2h0ZnVsbHkgZGVjaWRlIHRvCj4+PiByZWplY3Qga25vd24gYnJva2Vu
ICJzZWN1cmUiIGNvZGUgb24gYSBwdXJlbHkgdGVjaG5pY2FsIGFyZ3VtZW50Lgo+Pj4KPj4KPj4g
V2FpdCwgaG9sZCBvbiBhIHNlY29uZC4KPj4KPj4gU0hBMS1EQyBpc24ndCBTSEExLsKgIEl0J3Mg
YSBkaWZmZXJlbnQgaGFzaCBmdW5jdGlvbiB0aGF0IGlzIG1vc3RseQo+PiBjb21wYXRpYmxlIHdp
dGggU0hBMSwgaXMgZGlmZmVyZW50IG9uIHNvbWUgaW5wdXRzLCBhbmQgaXMgbWF5YmUgbW9yZQo+
PiBzZWN1cmUuwqAgQnV0IHRoZSBfd2hvbGUgcG9pbnRfIG9mIHVzaW5nIFNIQTEgaW4gdGhlIFRQ
TSBjb2RlICh3ZWxsLAo+PiB0aGlzIHJlYWxseSBzaG91bGQgYmUgdGhlIHdob2xlIHBvaW50IGZv
ciBuZXcgYXBwbGljYXRpb25zKSBpcyB0bwo+PiBjb3JyZWN0bHkgY2FwIHRoZSBTSEExIFBDUnMg
c28gd2UgY2FuIGNvcnJlY3RseSBfdHVybiB0aGVtIG9mZl8gaW4gdGhlCj4+IGJlc3Qgd2F5IHdp
dGhvdXQgYnJlYWtpbmcgY29tcGF0aWJpbGl0eSB3aXRoIGV2ZXJ5dGhpbmcgdGhhdCBtaWdodAo+
PiByZWFkIHRoZSBldmVudCBsb2cuwqAgSSB0aGluayB0aGF0IGFueW9uZSBzdWdnZXN0aW5nIHVz
aW5nIFNIQTEtREMgZm9yCj4+IHRoaXMgcHVycG9zZSBzaG91bGQgZ2l2ZSBzb21lIGFjdHVhbCBh
bmFseXNpcyBhcyB0byB3aHkgdGhleSB0aGluawo+PiBpdCdzIGFuIGltcHJvdmVtZW50LCBsZXQg
YWxvbmUgZXZlbiB2YWxpZC4KPiAKPiBJIHdvdWxkIHNheSBhdCBhIG1pbmltdW0gaXQgaXMgdG8g
cHJvdmlkZSBhIG1lYW5zIHRvIGNhcCB0aGUgUENScy4gCj4gRGV2aWNlcyB3aXRoIFRQTTEuMiBh
cmUgc3RpbGwgcHJldmFsZW50IGluIHRoZSB3aWxkIGZvciB3aGljaCBtZW1iZXJzIG9mIAo+IHRo
ZSBUcmVuY2hCb290IGNvbW11bml0eSBzdXBwb3J0LCBhbmQgdGhlcmUgYXJlIHN0aWxsIHZhbGlk
IChhbmQgc2VjdXJlKSAKPiB2ZXJpZmljYXRpb24gdXNlcyBmb3IgU0hBMSB0aGF0IEkgb3V0bGlu
ZWQgaW4gbXkgcHJldmlvdXMgcmVzcG9uc2UuCj4gCj4+IFJvc3MgZXQgYWwsIGNhbiB5b3UgY29u
ZmlybSB0aGF0IHlvdXIgY29kZSBhY3R1YWxseSwgYXQgbGVhc3QgYnkKPj4gZGVmYXVsdCBhbmQg
d2l0aCBhIG1vbnN0cm91cyB3YXJuaW5nIHRvIGFueW9uZSB3aG8gdHJpZXMgdG8gY2hhbmdlIHRo
ZQo+PiBkZWZhdWx0LCBjYXBzIFNIQTEgUENScyBpZiBTSEEyNTYgaXMgYXZhaWxhYmxlP8KgIEFu
ZCB0aGVuIGNhbiB3ZSBtYXliZQo+PiBhbGwgc3RvcCBoYXNzbGluZyB0aGUgcGVvcGxlIHRyeWlu
ZyB0byBkZXZlbG9wIHRoaXMgc2VyaWVzIGFib3V0IHRoZQo+PiBmYWN0IHRoYXQgdGhleSdyZSBk
b2luZyB0aGVpciBiZXN0IHdpdGggdGhlIG9ibm94aW91cyBzeXN0ZW0gdGhhdCB0aGUKPj4gVFBN
IGRlc2lnbmVycyBnYXZlIHRoZW0/Cj4gCj4gT3VyIGdvYWwgaXMgdG8ga2VlcCBjb250cm9sIGlu
IHRoZSBoYW5kcyBvZiB0aGUgdXNlciwgbm90IG1ha2luZyAKPiB1bmlsYXRlcmFsIGRlY2lzaW9u
cyBvbiB0aGVpciBiZWhhbGYuIEluIHRoZSBjdXJyZW50bHkgZGVwbG95ZWQgCj4gc29sdXRpb25z
IGl0IGlzIGxlZnQgdG8gdGhlIGluaXRyZCAodXNlcikgdG8gY2FwIHRoZSBQQ1JzLiBBZnRlciBz
b21lIAo+IHRoaW5raW5nLCB3ZSBjYW4gc3RpbGwgZW5zdXJlIHVzZXIgY29udHJvbCBhbmQgZ2l2
ZSBhbiBvcHRpb24gdG8gY2FwIHRoZSAKPiBQQ1JzIGVhcmxpZXIuIFdlIGhvcGUgdG8gcG9zdCBh
IHYxMSBsYXRlciB0aGlzIHdlZWsgb3IgZWFybHkgbmV4dCB3ZWVrIAo+IHRoYXQgaW50cm9kdWNl
cyBhIG5ldyBwb2xpY3kgZmllbGQgdG8gdGhlIGV4aXN0aW5nIG1lYXN1cmVtZW50IHBvbGljeSAK
PiBmcmFtZXdvcmsuIFdpbGwgYWRkL3VwZGF0ZSB0aGUga2VybmVsIGRvY3Mgd2l0aCByZXNwZWN0
IHRvIHRoZSBwb2xpY3kgCj4gZXhwYW5zaW9uLiBXZSBhcmUgYWxzbyBsb29raW5nIHRoZSBiZXN0
IHdheSB3ZSBtaWdodCBhZGQgYSB3YXJuaW5nIHRvIAo+IHRoZSBrZXJuZWwgbG9nIGlmIHRoZSBT
SEExIGJhbmsgaXMgdXNlZCBiZXlvbmQgY2FwcGluZyB0aGUgUENScy4KCkFzIHRoZSBhdHRlbXB0
IHdhcyBtYWRlIHRvIGxheSBpbiB0aGUgcG9saWN5IGxvZ2ljLCBpdCBzdGFydGVkIHRvIGJlY29t
ZSAKY29udm9sdXRlZCBhbmQgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZC4gVGh1cyBjcmVhdGlu
ZyBtb3JlIHJpc2sgd2l0aCAKYWxsIHRoZSBib29ra2VlcGluZyBhbmQgeWV0IHNoYTEgaGFzaGVz
IHN0aWxsIGhhdmUgdG8gYmUgc2VudCwgdGhlIG51bGwgCmhhc2ggaW4gdGhpcyBjYXNlLCBzaW5j
ZSB0aGUgVFBNIGRyaXZlciB3aWxsIHJlamVjdCBleHRlbmRzIHRoYXQgZG8gbm90IApoYXZlIGhh
c2hlcyBmb3IgYWxsIGFjdGl2ZSBiYW5rcy4gQXQgdGhpcyBwb2ludCwgd2UgaGF2ZSBvcHRlZCB0
byBrZWVwIAp0aGUgbG9naWMgc2ltcGxlIGFuZCBhZGQgYSBzZWN0aW9uIHRvIG91ciBkb2N1bWVu
dGF0aW9uIGFkdmlzaW5nIG9mIHRoZSAKcG90ZW50aWFsIHJpc2sgc2hvdWxkIG9uZSBjaG9vc2Ug
dG8gaW5jb3Jwb3JhdGUgU0hBMSBpbiB0aGVpciAKYXR0ZXN0YXRpb25zIG9mIHRoZSBwbGF0Zm9y
bS4KCnYvciwKZHBzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

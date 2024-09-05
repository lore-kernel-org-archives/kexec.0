Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D460ECD4F4E
	for <kexec@archiver.kernel.org>; Thu,  5 Sep 2024 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Fb9nILz9HIjFlzmQ03akaKoP/fo3aEdsyLE11hteVR8=; b=ZGj1dDSfL//sCt
	wfvcM9WSohPPNXIPhPgsTsQVfGl3bGxiWLZf5Yj79fvW3bVh2m4hgB86GwSN5RjxxhUVR+yuOZy1T
	jDwf5MqWqJabdRDCyxne9lTAd2N9P4bnYcLGRYWd5ULxUP3GH23VwW+L7F9lva1WTwDH5OSnVNVHN
	Xg5vMs8A3NwQGbXEH223zJaoxmX0dpvetLZDGL53D9nfm5i/kHgrgYT7w5lpechS2MzlXA5+vB/Jj
	vZtYVgMT36zSQrdiZ5tLUsbawHiZi9GUBlCyxlWa5AKAIsNs2wbMlUicLJUZIhZSqdQbmH1PRiv/X
	TlyjeypkhHkvGG0XppQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm0ti-00000006Xb1-2YJg;
	Thu, 05 Sep 2024 01:02:54 +0000
Received: from sender4-of-o51.zoho.com ([136.143.188.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sm0te-00000006XaJ-3x5N
	for kexec@lists.infradead.org;
	Thu, 05 Sep 2024 01:02:52 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1725498125; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n1GwapKlqf/G11f9bXZyxIoD7k1R7NbcQOIf95YR2qUGUiwderqOqQrraRlVfwxxRmR7Re8k3NeGCmtIy2TiXvQ+zKn62wu26gh7hkiumSYANKK1u21gQgWZHbpTZl0/cgMaDaT0S7xvzFbJUhmcuijt+lurWYeobverSdHkkmQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725498125; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MHhhgvQoIAOSgBKwKAFzW1nw5ZFZN5DJupDzq3j2bCE=; 
	b=GnTIR0gSukchwjgWOItZ87i59diBhrbv1skYdEbrSqqZAONm+7S3KqrsBqEsYyOOqZj8dHTuDwBXLot2xYpClR5gjGUVW/mbeADllJ80vbvfFg9TMghEUFFa7W15JVS6l4pm9kzZrI1x9hxlHRE+UVUVGbgQPzjUxuGIRicNjXo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725498125;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MHhhgvQoIAOSgBKwKAFzW1nw5ZFZN5DJupDzq3j2bCE=;
	b=I1LE+zDbqGpOlfJl+BMuEOWTcR58dv4I/SqGYrYELweuXSrWu940A6fkSzqPXilW
	JjrMes/NSWEf39/p6FkNSCnlDXf1zVEviNihPq/lT6Tz6DsS6XbwKS/d2sp56PINbGM
	b/FYT7akWAq84UiE+6YlPxp0pbVAFdENRxnGF+OA=
Received: by mx.zohomail.com with SMTPS id 1725498123590524.2720733626318;
	Wed, 4 Sep 2024 18:02:03 -0700 (PDT)
Message-ID: <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
Date: Wed, 4 Sep 2024 21:01:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
X-ZohoMailClient: External
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_180251_071423_5FA26A08 
X-CRM114-Status: GOOD (  29.06  )
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

SGkgTHV0by4KCk9uIDgvMjgvMjQgMjM6MTcsIEFuZHkgTHV0b21pcnNraSB3cm90ZToKPiBPbiBU
aHUsIEF1ZyAxNSwgMjAyNCBhdCAxMjoxMOKAr1BNIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51
dHJvbml4LmRlPiB3cm90ZToKPj4KPj4gT24gVGh1LCBBdWcgMTUgMjAyNCBhdCAxMzozOCwgRGFu
aWVsIFAuIFNtaXRoIHdyb3RlOgo+Pj4gT24gNS8zMS8yNCAwOTo1NCwgRXJpYyBXLiBCaWVkZXJt
YW4gd3JvdGU6Cj4+Pj4gRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0BrZXJuZWwub3JnPiB3cml0ZXM6
Cj4+Pj4+IFRoYXQgcGFyYWdyYXBoIGlzIGFsc28gcGhyYXNlZCBhcyBhIGh5cG90aGV0aWNhbCwg
IkV2ZW4gaWYgd2UnZCBwcmVmZXIgdG8gdXNlCj4+Pj4+IFNIQS0yNTYtb25seSIuICBUaGF0IGlt
cGxpZXMgdGhhdCB5b3UgZG8gbm90LCBpbiBmYWN0LCBwcmVmZXIgU0hBLTI1NiBvbmx5LiAgSXMK
Pj4+Pj4gdGhhdCB0aGUgY2FzZT8gIFN1cmUsIG1heWJlIHRoZXJlIGFyZSBzaXR1YXRpb25zIHdo
ZXJlIHlvdSAqaGF2ZSogdG8gdXNlIFNIQS0xLAo+Pj4+PiBidXQgd2h5IHdvdWxkIHlvdSBub3Qg
YXQgbGVhc3QgKnByZWZlciogU0hBLTI1Nj8KPj4+Pgo+Pj4+IFllcy4gIFBsZWFzZSBwcmVmZXIg
dG8gdXNlIFNIQS0yNTYuCj4+Pj4KPj4+PiBIYXZlIHlvdSBjb25zaWRlcmVkIGltcGxlbWVudGlu
ZyBJIHRoaW5rIGl0IGlzIFNIQTEtREMgKGFzIGdpdCBoYXMpIHRoYXQKPj4+PiBpcyBjb21wYXRp
YmxlIHdpdGggU0hBMSBidXQgYmxvY2tzIHRoZSBrbm93biBjbGFzcyBvZiBhdHRhY2tzIHdoZXJl
Cj4+Pj4gc2hhMSBpcyBhY3RpdmVseSBicm9rZW4gYXQgdGhpcyBwb2ludD8KPj4+Cj4+PiBXZSBh
cmUgdXNpbmcgdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9uLCBhZGRyZXNzaW5nIHdoYXQgdGhl
IGtlcm5lbAo+Pj4gcHJvdmlkZXMgaXMgYmV5b25kIG91ciBlZmZvcnRzLiBQZXJoYXBzIHNvbWVv
bmUgd2hvIGlzIGludGVyZXN0ZWQgaW4KPj4+IGltcHJvdmluZyB0aGUga2VybmVsJ3MgU0hBMSBj
b3VsZCBzdWJtaXQgYSBwYXRjaCBpbXBsZW1lbnRpbmcvcmVwbGFjaW5nCj4+PiBpdCB3aXRoIFNI
QTEtREMsIGFzIEkgYW0gc3VyZSB0aGUgbWFpbnRhaW5lcnMgd291bGQgd2VsY29tZSB0aGUgaGVs
cC4KPj4KPj4gV2VsbCwgc29tZW9uZSB3aG8gaXMgaW50ZXJlc3RlZCB0byBnZXQgaGlzICJzZWN1
cmUiIGNvZGUgbWVyZ2VkIHNob3VsZAo+PiBoYXZlIGEgdmVzdGVkIGludGVyZXN0ZWQgdG8gaGF2
ZSBhIG5vbi1icm9rZW4gU0hBMSBpbXBsZW1lbnRhdGlvbiBpZgo+PiB0aGVyZSBpcyBhIHNlbnNp
YmxlIHJlcXVpcmVtZW50IHRvIHVzZSBTSEExIGluIHRoYXQgbmV3ICJzZWN1cmUiIGNvZGUsCj4+
IG5vPwo+Pgo+PiBKdXN0IGZvciB0aGUgcmVjb3JkLiBUaGUgcmVsYXRlZCBtYWludGFpbmVycyBj
YW4gcmlnaHRmdWxseSBkZWNpZGUgdG8KPj4gcmVqZWN0IGtub3duIGJyb2tlbiAic2VjdXJlIiBj
b2RlIG9uIGEgcHVyZWx5IHRlY2huaWNhbCBhcmd1bWVudC4KPj4KPiAKPiBXYWl0LCBob2xkIG9u
IGEgc2Vjb25kLgo+IAo+IFNIQTEtREMgaXNuJ3QgU0hBMS4gIEl0J3MgYSBkaWZmZXJlbnQgaGFz
aCBmdW5jdGlvbiB0aGF0IGlzIG1vc3RseQo+IGNvbXBhdGlibGUgd2l0aCBTSEExLCBpcyBkaWZm
ZXJlbnQgb24gc29tZSBpbnB1dHMsIGFuZCBpcyBtYXliZSBtb3JlCj4gc2VjdXJlLiAgQnV0IHRo
ZSBfd2hvbGUgcG9pbnRfIG9mIHVzaW5nIFNIQTEgaW4gdGhlIFRQTSBjb2RlICh3ZWxsLAo+IHRo
aXMgcmVhbGx5IHNob3VsZCBiZSB0aGUgd2hvbGUgcG9pbnQgZm9yIG5ldyBhcHBsaWNhdGlvbnMp
IGlzIHRvCj4gY29ycmVjdGx5IGNhcCB0aGUgU0hBMSBQQ1JzIHNvIHdlIGNhbiBjb3JyZWN0bHkg
X3R1cm4gdGhlbSBvZmZfIGluIHRoZQo+IGJlc3Qgd2F5IHdpdGhvdXQgYnJlYWtpbmcgY29tcGF0
aWJpbGl0eSB3aXRoIGV2ZXJ5dGhpbmcgdGhhdCBtaWdodAo+IHJlYWQgdGhlIGV2ZW50IGxvZy4g
IEkgdGhpbmsgdGhhdCBhbnlvbmUgc3VnZ2VzdGluZyB1c2luZyBTSEExLURDIGZvcgo+IHRoaXMg
cHVycG9zZSBzaG91bGQgZ2l2ZSBzb21lIGFjdHVhbCBhbmFseXNpcyBhcyB0byB3aHkgdGhleSB0
aGluawo+IGl0J3MgYW4gaW1wcm92ZW1lbnQsIGxldCBhbG9uZSBldmVuIHZhbGlkLgoKSSB3b3Vs
ZCBzYXkgYXQgYSBtaW5pbXVtIGl0IGlzIHRvIHByb3ZpZGUgYSBtZWFucyB0byBjYXAgdGhlIFBD
UnMuIApEZXZpY2VzIHdpdGggVFBNMS4yIGFyZSBzdGlsbCBwcmV2YWxlbnQgaW4gdGhlIHdpbGQg
Zm9yIHdoaWNoIG1lbWJlcnMgb2YgCnRoZSBUcmVuY2hCb290IGNvbW11bml0eSBzdXBwb3J0LCBh
bmQgdGhlcmUgYXJlIHN0aWxsIHZhbGlkIChhbmQgc2VjdXJlKSAKdmVyaWZpY2F0aW9uIHVzZXMg
Zm9yIFNIQTEgdGhhdCBJIG91dGxpbmVkIGluIG15IHByZXZpb3VzIHJlc3BvbnNlLgoKPiBSb3Nz
IGV0IGFsLCBjYW4geW91IGNvbmZpcm0gdGhhdCB5b3VyIGNvZGUgYWN0dWFsbHksIGF0IGxlYXN0
IGJ5Cj4gZGVmYXVsdCBhbmQgd2l0aCBhIG1vbnN0cm91cyB3YXJuaW5nIHRvIGFueW9uZSB3aG8g
dHJpZXMgdG8gY2hhbmdlIHRoZQo+IGRlZmF1bHQsIGNhcHMgU0hBMSBQQ1JzIGlmIFNIQTI1NiBp
cyBhdmFpbGFibGU/ICBBbmQgdGhlbiBjYW4gd2UgbWF5YmUKPiBhbGwgc3RvcCBoYXNzbGluZyB0
aGUgcGVvcGxlIHRyeWluZyB0byBkZXZlbG9wIHRoaXMgc2VyaWVzIGFib3V0IHRoZQo+IGZhY3Qg
dGhhdCB0aGV5J3JlIGRvaW5nIHRoZWlyIGJlc3Qgd2l0aCB0aGUgb2Jub3hpb3VzIHN5c3RlbSB0
aGF0IHRoZQo+IFRQTSBkZXNpZ25lcnMgZ2F2ZSB0aGVtPwoKT3VyIGdvYWwgaXMgdG8ga2VlcCBj
b250cm9sIGluIHRoZSBoYW5kcyBvZiB0aGUgdXNlciwgbm90IG1ha2luZyAKdW5pbGF0ZXJhbCBk
ZWNpc2lvbnMgb24gdGhlaXIgYmVoYWxmLiBJbiB0aGUgY3VycmVudGx5IGRlcGxveWVkIApzb2x1
dGlvbnMgaXQgaXMgbGVmdCB0byB0aGUgaW5pdHJkICh1c2VyKSB0byBjYXAgdGhlIFBDUnMuIEFm
dGVyIHNvbWUgCnRoaW5raW5nLCB3ZSBjYW4gc3RpbGwgZW5zdXJlIHVzZXIgY29udHJvbCBhbmQg
Z2l2ZSBhbiBvcHRpb24gdG8gY2FwIHRoZSAKUENScyBlYXJsaWVyLiBXZSBob3BlIHRvIHBvc3Qg
YSB2MTEgbGF0ZXIgdGhpcyB3ZWVrIG9yIGVhcmx5IG5leHQgd2VlayAKdGhhdCBpbnRyb2R1Y2Vz
IGEgbmV3IHBvbGljeSBmaWVsZCB0byB0aGUgZXhpc3RpbmcgbWVhc3VyZW1lbnQgcG9saWN5IApm
cmFtZXdvcmsuIFdpbGwgYWRkL3VwZGF0ZSB0aGUga2VybmVsIGRvY3Mgd2l0aCByZXNwZWN0IHRv
IHRoZSBwb2xpY3kgCmV4cGFuc2lvbi4gV2UgYXJlIGFsc28gbG9va2luZyB0aGUgYmVzdCB3YXkg
d2UgbWlnaHQgYWRkIGEgd2FybmluZyB0byAKdGhlIGtlcm5lbCBsb2cgaWYgdGhlIFNIQTEgYmFu
ayBpcyB1c2VkIGJleW9uZCBjYXBwaW5nIHRoZSBQQ1JzLgoKSG9wZWZ1bGx5IHRoaXMgYW5zd2Vy
cyB0aGUgb3V0c3RhbmRpbmcgY29tbWVudHMgb24gdGhlIFNIQTEgdGhyZWFkLgoKdi9yLApkcHMK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

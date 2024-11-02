Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC53E677F6
	for <kexec@archiver.kernel.org>; Sat,  2 Nov 2024 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9DnxbDTEZXf8geFKOTXvN1q0vccaaWrbu4oAtvuwsdQ=; b=l1rq180YV/2Ko1
	RP0CYxx6qLQQ85cjR57qAu2n1O4l7WIsxOLdQOSXImYOBnfVbWzawgh2y4JUMiIa/Qynxmgjg7yHX
	PLa5bgTmUh8ONjWm24bWoS23HCYtHU5Fa+mZpOjvvnQfJSdhTTg4ELf8N+nQJc60ZdfL5TJANMoyo
	20UGRu9gsvgiBIctxmwG9ECUia/YJMCLxIGaFquJmsx72hWEUWO+mTIrzfh+NpyhDk0pZOR8JgJPp
	Iy9I+6FHsSUL2n144iwhM1orzQQ0WXSnKV7Sf5SgrvsHLbUB8PuiulRLmSOs2d/bCYSreTcz6U8X/
	ftOMFqnmwHU2wAD2QD2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7GcJ-0000000A01j-1p0i;
	Sat, 02 Nov 2024 16:04:47 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7GcG-0000000A00c-1sKR
	for kexec@lists.infradead.org;
	Sat, 02 Nov 2024 16:04:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730563482;
	bh=61z7O+6nYz3jsRlzVcw6dm9APvP6OG4QQ5C+u9mEglw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g6BcZpKVf4c46S0HHQsfEVkmCR8vytCzuWg9yhUnzVRbPLPFtf832nknEPRo/XaP6
	 OUUji43vQhQYci5494j27o3BQsk6r2iQlc0QcFMIMlOdd/IEd2l/gK7g2/DxSdD0q5
	 ZUfWqe3HLLulPV4tZt26FTf3aBgqJisq50jO1ABw=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 536AF12868A1;
	Sat, 02 Nov 2024 12:04:42 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 9dgDmt7D3IjF; Sat,  2 Nov 2024 12:04:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1730563482;
	bh=61z7O+6nYz3jsRlzVcw6dm9APvP6OG4QQ5C+u9mEglw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=g6BcZpKVf4c46S0HHQsfEVkmCR8vytCzuWg9yhUnzVRbPLPFtf832nknEPRo/XaP6
	 OUUji43vQhQYci5494j27o3BQsk6r2iQlc0QcFMIMlOdd/IEd2l/gK7g2/DxSdD0q5
	 ZUfWqe3HLLulPV4tZt26FTf3aBgqJisq50jO1ABw=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C75741286824;
	Sat, 02 Nov 2024 12:04:39 -0400 (EDT)
Message-ID: <446cf9c70184885e4cec6dd4514ae8daf7accdcb.camel@HansenPartnership.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>, Andy Lutomirski
	 <luto@amacapital.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 mingo@redhat.com,  bp@alien8.de, hpa@zytor.com,
 dave.hansen@linux.intel.com, ardb@kernel.org,  mjg59@srcf.ucam.org,
 peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,  nivedita@alum.mit.edu,
 herbert@gondor.apana.org.au, davem@davemloft.net,  corbet@lwn.net,
 dwmw2@infradead.org, baolu.lu@linux.intel.com,  kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
Date: Sat, 02 Nov 2024 11:04:38 -0500
In-Reply-To: <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
	 <20240531010331.134441-7-ross.philipson@oracle.com>
	 <20240531021656.GA1502@sol.localdomain>
	 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
	 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
	 <87ttflli09.ffs@tglx>
	 <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
	 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
	 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
	 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
	 <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
	 <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
	 <ff0c8eed-8981-48c4-81d9-56b040ef1c7b@apertussolutions.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241102_090444_522968_618C3A1A 
X-CRM114-Status: GOOD (  22.71  )
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

T24gU2F0LCAyMDI0LTExLTAyIGF0IDEwOjUzIC0wNDAwLCBEYW5pZWwgUC4gU21pdGggd3JvdGU6
Cj4gSGkgTHV0bywKPiAKPiBNeSBhcG9sb2dpZXMsIEkgbWlzc2VkIHRoaXMgcmVzcG9uc2UgYW5k
IHRoZSBhY3RpdmUgb24gdjExIGNhdXNlIG1lCj4gdG8gCj4gZ2V0IGFuIGlucXVpcnkgd2h5IEkg
aGFkbid0IHJlc3BvbmRlZC4KPiAKPiBPbiA5LzIxLzI0IDE4OjQwLCBBbmR5IEx1dG9taXJza2kg
d3JvdGU6ClsuLi5dCj4gPiBJIGFzc3VtZWQgdGhhdCAiZGVsaWJlcmF0ZWx5IGNhcCIgbWVhbnQg
dGhhdCB0aGVyZSB3YXMgYW4gYWN0dWFsCj4gPiBmZWF0dXJlIHdoZXJlIHlvdSB3cml0ZSBzb21l
dGhpbmcgdG8gdGhlIGV2ZW50IGxvZyAoaWYgYXBwbGljYWJsZSkKPiA+IGFuZCBleHRlbmQgdGhl
IFBDUiBpbiBhIHNwZWNpYWwgd2F5IHRoYXQgKnR1cm5zIHRoYXQgUENSIG9mZiouwqAKPiA+IFRo
YXQgaXMsIGl0IGRvZXMgc29tZXRoaW5nIHN1Y2ggdGhhdCBsYXRlci1sb2FkZWQgc29mdHdhcmUg
KmNhbid0Kgo+ID4gdXNlIHRoYXQgUENSIHRvIGF0dGVzdCBvciB1bnNlYWwgYW55dGhpbmcsIGV0
Yy4KPiA+IAo+ID4gQnV0IGl0IHNvdW5kcyBsaWtlIHlvdSdyZSBzYXlpbmcgdGhhdCBubyBzdWNo
IGZlYXR1cmUgZXhpc3RzLsKgIEFuZAo+ID4gYSBxdWljayBza2ltIG9mIHRoZSBzcGVjcyBkb2Vz
bid0IGNvbWUgdXAgd2l0aCBhbnl0aGluZy7CoCBBbmQgdGhlCj4gPiBTSEExIGJhbmtzIG1heSB3
ZWxsIGJlIHN1c2NlcHRpYmxlIHRvIGEgY29sbGlzaW9uIGF0dGFjay4KPiAKPiBDb3JyZWN0LCB0
aGUgb25seSBlbnRpdHkgdGhhdCBjYW4gZGlzYWJsZSBQQ1IgYmFua3MgaXMgdGhlIGZpcm13YXJl
LiAKCk5vLCB0aGF0J3Mgbm90IGNvcnJlY3QuICBBbnkgdXNlciBjYW4gdXNlIFRQTV9QQ1JfQWxs
b2NhdGUgdG8gYWN0aXZhdGUKb3IgZGVhY3RpdmF0ZSBpbmRpdmlkdWFsIGJhbmtzLiAgVGhlIGNh
dmVhdCBpcyB0aGUgY2hhbmdlIGlzIG5vdAppbXBsZW1lbnRlZCB1bnRpbCB0aGUgbmV4dCBUUE0g
cmVzZXQgKHdoaWNoIHNob3VsZCBpbnZvbHZlIGEgcmVib290KS4gCkJJT1MgYWxzbyBnZXRzIHRv
IHRoZSBUUE0gYmVmb3JlIHRoZSBrZXJuZWwgZG9lcywgc28gaXQgY2FuLCBpbiB0aGVvcnksCmNo
ZWNrIHdoYXQgYmFua3MgYSBUUE0gaGFzIGFuZCBjYWxsIFRQTV9QQ1JfQWxsb2NhdGUgdG8gY2hh
bmdlIHRoZW0uIApJbiBwcmFjdGljZSwgYmVjYXVzZSB0aGlzIHJlcXVpcmVzIGEgcmVib290LCB0
aGlzIGlzIHVzdWFsbHkgb25seSBkb25lCmZyb20gdGhlIEJJT1MgbWVudXMgbm90IG9uIGEgZGly
ZWN0IGJvb3QgLi4uIHNvIHlvdSBjYW4gYmUgcmVhc29uYWJseQpzdXJlIHRoYXQgd2hhdGV2ZXIg
Y2hhbmdlcyB3ZXJlIG1hZGUgd2lsbCBzdGljay4KCj4gV2hlbiBpdCBpbml0aWFsaXplcyB0aGUg
VFBNLCBpdCBjYW4gZGlzYWJsZSBiYW5rcy9hbGdvcml0aG1zLiBBZnRlciAKPiB0aGF0LCB3aGVu
IGFuIGV4dGVuZCBvcGVyYXRpb24gaXMgZG9uZSwgdGhlIFRQTSBpcyBleHBlY3RpbmcgYW4gZW50
cnkKPiBmb3IgYWxsIGFjdGl2ZSBQQ1IgYmFua3MgYW5kIHRoZSBUUE0gaXRzZWxmIGRvZXMgdGhl
IGV4dGVuZCBoYXNoIHRoYXQKPiBpcyBzdG9yZWQgaW50byB0aGUgUENScy4KClRoaXMsIGFsc28s
IGlzIG5vdCBxdWl0ZSBjb3JyZWN0OiBhbiBleHRlbmQgaXMgYWxsb3dlZCB0byBzcGVjaWZ5IGJh
bmtzCnRoYXQgZG9uJ3QgZXhpc3QgKGluIHdoaWNoIGNhc2Ugbm90aGluZyBoYXBwZW5zIGFuZCBu
byBlcnJvciBpcwpyZXBvcnRlZCkgYW5kIG1pc3MgYmFua3MgdGhhdCBkbyAoaW4gd2hpY2ggY2Fz
ZSBubyBleHRlbmQgaXMgZG9uZSB0bwp0aGF0IGJhbmspLiAgSW4gdGhlIGVhcmx5IGRheXMgb2Yg
VFBNMiwgc29tZSBCSU9TIGltcGxlbWVudGF0aW9ucyBvbmx5CmV4dGVuZGVkIHNoYTEgZm9yIGlu
c3RhbmNlLCBtZWFuaW5nIHRoZSBzaGEyNTYgYmFua3Mgd2VyZSBhbGwgemVybyB3aGVuCnRoZSBr
ZXJuZWwgc3RhcnRlZC4KCkV2ZW4gdG9kYXksIGlmIHlvdSBhY3RpdmF0ZSBhIGJhbmsgdGhlIEJJ
T1MgZG9lc24ndCBrbm93IGFib3V0LCBpdApsaWtlbHkgd29uJ3QgZXh0ZW5kIGl0LiAgWW91IGNh
biBzZWUgdGhpcyBpbiBWTSBib290cyB3aXRoIE9WTUYgYW5kCnNvZnR3YXJlIFRQTXMgaGF2aW5n
IGVzb3RlcmljIGJhbmtzIGxpa2UgU00zLgoKUmVnYXJkcywKCkphbWVzCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

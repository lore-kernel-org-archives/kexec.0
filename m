Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A2CECE582
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qJEVZCQN05CS473pB0gUqYRjn0AVBEmFrAWJD6E6bT8=; b=Zze+3TKpHcFPrc
	0tGxytvBwLsy5uggJCCFyXF0yWhsJiZH94QVyRMWi0bWdeVC4pSzxM6DkSaqfk2kC4WWOu34Phh1O
	KgFyinXCq7/t1lQgvLmDndm7K4UeXJzx8Mu/+y9gVWCMLAiZ1C8lzJ7HyqPoXjBgR5CqQWVsE6fc0
	/k0ClnWHDafOPfGFkgkR5/CsOx8i6sDoWfs3LEQcrqnUnPNfMovQlH37O8olGmurEA0SMtHD943Li
	l32pyRki1bEK6mxv2Cl5lna3K5R4BoQTRiRCgQMDMeugnSlZvgZEng0y7rBHMxU8BdP90x9uIUxg9
	8NbG5eVdV/JsfA6QY5Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snviw-00000004gpq-03Oc;
	Tue, 10 Sep 2024 07:55:42 +0000
Received: from gardel.0pointer.net ([2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snviG-00000004gfM-1W9L
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 07:55:02 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 9711EE80261;
	Tue, 10 Sep 2024 09:54:57 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id D3D26160143; Tue, 10 Sep 2024 09:54:56 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:54:56 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
	Pingfan Liu <piliu@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt_7UEdDfTAQKp4I@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <Zt7EbvWjF9WPCYfn@gardel-login>
 <Zt7RJepoCiCMRZSu@archlinux>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zt7RJepoCiCMRZSu@archlinux>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_005500_576371_6BF3CF32 
X-CRM114-Status: GOOD (  26.96  )
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

T24gTW8sIDA5LjA5LjI0IDEyOjQyLCBKYW4gSGVuZHJpayBGYXJyIChrZXJuZWxAamZhcnIuY2Mp
IHdyb3RlOgoKPiBPbiAwOSAxMTo0ODozMCwgTGVubmFydCBQb2V0dGVyaW5nIHdyb3RlOgo+ID4g
T24gRnIsIDA2LjA5LjI0IDEyOjU0LCBQaGlsaXBwIFJ1ZG8gKHBydWRvQHJlZGhhdC5jb20pIHdy
b3RlOgo+ID4KPiA+ID4gSSBtb3N0bHkgYWdyZWUgb24gd2hhdCB5b3UgaGF2ZSB3cm90ZS4gQnV0
IEkgc2VlIGEgYmlnIHByb2JsZW0gaW4KPiA+ID4gcnVubmluZyB0aGUgRUZJIGVtdWxhdG9yIGlu
IHVzZXIgc3BhY2Ugd2hlbiBpdCBjb21lcyB0byBzZWN1cmUgYm9vdC4KPiA+ID4gVGhlIGNoYWlu
IG9mIHRydXN0IGVuZHMgaW4gdGhlIGtlcm5lbC4gU28gaXQncyB0aGUga2VybmVsIHRoYXQgbmVl
ZHMgdG8KPiA+ID4gdmVyaWZ5IHRoYXQgdGhlIGltYWdlIHRvIGJlIGxvYWRlZCBjYW4gYmUgdHJ1
c3RlZC4gQnV0IHdoZW4gdGhlIEVGSQo+ID4gPiBydW50aW1lIGlzIGluIHVzZXIgc3BhY2UgdGhl
IGtlcm5lbCBzaW1wbHkgY2Fubm90IGRvIHRoYXQuIFdoaWNoIG1lYW5zLAo+ID4gPiBpZiB3ZSB3
YW50IHRvIGdvIHRoaXMgd2F5LCB3ZSB3b3VsZCBuZWVkIHRvIGV4dGVuZCB0aGUgY2hhaW4gb2Yg
dHJ1c3QKPiA+ID4gdG8gdXNlciBzcGFjZS4gV2hpY2ggd2lsbCBiZSBhIHdob2xlIGJ1Y2tldCBv
ZiB3b3Jtcywgbm90IGp1c3QgYQo+ID4gPiBjYW4uCj4gPgo+ID4gTWF5IGl0IHdvdWxkIGJlIG5p
Y2UgdG8gaGF2ZSBhIHdheSB0byAiemFwIiB1c2Vyc3BhY2UgYXdheSwgaS5lLiBhbGxvdwo+ID4g
dGhlIGtlcm5lbCB0byBnZXQgcmlkIG9mIGFsbCBwcm9jZXNzZXMgaW4gc29tZSB3YXksIHJlbGlh
YmxlLiBBbmQgdGhlbgo+ID4gc2ltcGx5IHN0YXJ0IGEgbmV3IHVzZXJzcGFjZSwgZnJvbSBhIHRy
dXN0ZWQgZGVmaW5pdGlvbi4gT3IgaW4gb3RoZXIKPiA+IHdvcmRzOiBpZiB5b3UgZG9uJ3Qgd2Fu
dCB0byB0cnVzdCB0aGUgdXN1YWwgdXNlcnNwYWNlLCB0aGVuIGxldCdzCj4gPiBtYXliZSBqdXN0
IHRlcm1pbmF0ZSBpdCwgYW5kIGNyZWF0ZSBpdCBhbmV3LCB3aXRoIGEgY2xlYW4sIHByaXN0aW5l
Cj4gPiBkZWZpbml0aW9uIHRoZSBvbGQgdXNlcnNwYWNlIGNhbm5vdCBnZXQgYWNjZXNzIHRvLgo+
Cj4gV2VsbCwgdGhpcyBpcyBhbiBpbnRlcmVzdGluZyBpZGVhIQo+Cj4gSG93ZXZlciwgSSdtIHNj
ZXB0aWNhbCBpZiB0aGlzIGNvdWxkIGJlIGRvbmUgaW4gYSBzZWN1cmUgd2F5LiBIb3cgZG8gd2UK
PiBlbnN1cmUgdGhhdCBub3RoaW5nIHRoZSBvbGQgdXNlcnNwYWNlIGRpZCB3aXRoIHRoZSB2YXJp
b3VzIGludGVyZmFjZXMgdG8KPiB0aGUga2VybmVsIGhhcyBubyBpbXBhY3Qgb24gdGhlIG5ldyB1
c2Vyc3BhY2U/IE1heWJlIG90aGVycyBjYW4gY2hpbWUgaW4KPiBvbiB0aGlzPyBEb2VzIGtlcm5l
bF9sb2NrZG93biBnaXZlIG1vcmUgZ3VhcmFudGVlcyByZWxhdGVkIHRvIHRoaXM/CgpZZWFoLCBp
dCdzIG5vdCBhIHRyaXZpYWwgdGhpbmcuIEkuZS4gSSBndWVzcyB0aGluZ3MgbGlrZSBzeXNmcyBh
bmQKcHJvY2ZzIHdpbGwgcmV0YWluIG93bmVyc2hpcC9hY2Nlc3MgbW9kZS4gc3lzY3RscyBhbmQg
c3lzZnMgYXR0cnMgYXJlCmdvaW5nIHRvIHJldGFpbiB0aGVpciBtb3N0IHJlY2VudGx5IHdyaXR0
ZW4gY29udGVudHMgYW5kIHRoaW5ncyBsaWtlCnRoYXQuIFN5bnRoZXRpYyBuZXR3b3JrIGludGVy
ZmFjZXMsIERNIGRldmljZXMsIGxvb3BiYWNrIGRldmljZXMgYWxsCndvdWxkIHN1cnZpdmUgdGhp
cy4KClNvLCBubyBpZGVhIGhvdyByZWFsaXN0aWMgdGhpcyBpcywgYnV0IEkgd291bGQgKmxvdmUq
IGl0LCBub3Qgb25seSBmb3IKdGhpcyBwdXJwb3NlIGhlcmUsIGJ1dCBhbHNvIGZvciB0aGUgInNv
ZnQtcmVib290IiBsb2dpYyB3ZSBoYXZlIGluCnN5c3RlbSB0aGVzZSBkYXlzLCB3aGljaCBzaHV0
cyBkb3duIHVzZXJzcGFjZSBhbmQgc3RhcnRzIGl0IHVwIGFnYWluLAphcyBhIGZvcm0gb2Ygc3Vw
ZXItZmFzdCByZWJvb3QgdGhhdCBkb2Vzbid0IHJlcGxhY2UgdGhlIGtlcm5lbC4gSWYgd2UKY291
bGQgcmVsaWFibHkgcmVzZXQgc3lzZnMvc3lzY3RsL3Byb2Nmcy/igKYgZHVyaW5nIHRoaXMsIHRo
aXMgd291bGQgYmUKcmVhbGx5IGxvdmVseS4KCkxlbm5hcnQKCi0tCkxlbm5hcnQgUG9ldHRlcmlu
ZywgQmVybGluCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

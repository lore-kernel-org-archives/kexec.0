Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9CACD1292
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yiZTDOw1bFSNoGA+URALAIFFiNLbeW46i/JhOb+PLDM=; b=0nxSPm4h4OybIo
	z+NtTHkFH/T1XZKYnKvYFV+CRnLe1V7XyX00EvVwmBCUW7uryQOYT7tcY2hDpZs+3oB1o2jIfL3Mn
	EUJQYlxNCqpGgWEnnDMwb+fPUmkqM1oQ7XOyWy4E7Ln8DGt+VhRnG7VgEaNZIn6g42gJE/jYIl8f9
	0QIIr8oD/7L1Wjk6GQq8vP7X41bznfoeRWYlnQdgJyPPQHyFteOQHYdx8tg5ZgjG8bjyEdsz/hYQX
	BICcAM9G7AtWQc4ZS4kV8P7MiIV7PSFaxyFNr6kNZ/9g2Qc/hbGC6YKtW0cpaoWk4mm/wFk4z0dxK
	i4Z+nI1XVsiJkIAGfzhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOV8-000000037pc-0T88;
	Thu, 04 Apr 2024 14:55:38 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOV3-000000037no-2jfJ
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 14:55:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7D63DCE31D8;
	Thu,  4 Apr 2024 14:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D9FC433F1;
	Thu,  4 Apr 2024 14:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242529;
	bh=G9lUvFywXgRdKLfamnkBnonk8oOiR9MI0r12zS6dtX0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=aen+RE8ak25vlpX9Pe4w1s2I0IEuN0Xe8dsQ4xMCxRg401Ddm7Z4hTU7uhk3fCUgW
	 GO+03+G0RSM+nLr2h8MsZmTZ+t+Y+YtN5Oi35yxECq2gH1KN+OeWgdWfs2BIGtmf07
	 ozPdiS8nUL1wFS7zlORa+rjPcklbJXgUy6Y0Nvdq7gILpx6w1PCgVGDid/HHCyyQSZ
	 egq4Ie94OJd3yeK5HZMzHWjCUNOtESyziFGcUDR12e/eav83l6kxPAo3YEAeC/nq/t
	 2mXF9RP0DOWmABFVLYJWd7tjKUhoJwdz2l7KDmUWMIYSV8FBFzmoolBXAxqTe/LYpm
	 Rk+PK0mphpHSg==
Mime-Version: 1.0
Date: Thu, 04 Apr 2024 17:55:22 +0300
Message-Id: <D0BFBFRVGG47.FXCTWETKP7H4@kernel.org>
Cc: "Andrew Cooper" <andrew.cooper3@citrix.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Ross Philipson" <ross.philipson@oracle.com>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, "the arch/x86
 maintainers" <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <dpsmith@apertussolutions.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "luto@amacapital.net" <luto@amacapital.net>,
 "Arvind Sankar" <nivedita@alum.mit.edu>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, "Andy Lutomirski"
 <luto@kernel.org>
X-Mailer: aerc 0.17.0
References: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com> <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com> <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com> <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com> <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com> <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com> <20240223175449.GA1112@sol.localdomain> <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com> <20240223183004.GE1112@sol.localdomain> <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com> <20240403235635.GA24248@quark.localdomain>
In-Reply-To: <20240403235635.GA24248@quark.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_075534_097092_82109BAE 
X-CRM114-Status: GOOD (  37.10  )
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

T24gVGh1IEFwciA0LCAyMDI0IGF0IDI6NTYgQU0gRUVTVCwgRXJpYyBCaWdnZXJzIHdyb3RlOgo+
IE9uIFdlZCwgQXByIDAzLCAyMDI0IGF0IDA5OjMyOjAyQU0gLTA3MDAsIEFuZHkgTHV0b21pcnNr
aSB3cm90ZToKPiA+IE9uIEZyaSwgRmViIDIzLCAyMDI0LCBhdCAxMDozMCBBTSwgRXJpYyBCaWdn
ZXJzIHdyb3RlOgo+ID4gPiBPbiBGcmksIEZlYiAyMywgMjAyNCBhdCAwNjoyMDoyN1BNICswMDAw
LCBBbmRyZXcgQ29vcGVyIHdyb3RlOgo+ID4gPj4gT24gMjMvMDIvMjAyNCA1OjU0IHBtLCBFcmlj
IEJpZ2dlcnMgd3JvdGU6Cj4gPiA+PiA+IE9uIEZyaSwgRmViIDIzLCAyMDI0IGF0IDA0OjQyOjEx
UE0gKzAwMDAsIEFuZHJldyBDb29wZXIgd3JvdGU6Cj4gPiA+PiA+PiBZZXMsIGFuZCBJIGFncmVl
LsKgIFdlJ3JlIG5vdCBsb29raW5nIHRvIHRyeSBhbmQgZm9yY2UgdGhpcyBpbiB3aXRoCj4gPiA+
PiA+PiB1bmRlcmhhbmQgdGFjdGljcy4KPiA+ID4+ID4+Cj4gPiA+PiA+PiBCdXQgYSBibGluZCAi
bmFjayB0byBhbnkgU0hBLTEiIGlzIHNpbWlsYXJseSBkYW1hZ2luZyBpbiB0aGUgb3Bwb3NpdGUK
PiA+ID4+ID4+IGRpcmVjdGlvbi4KPiA+ID4+ID4+Cj4gPiA+PiA+IFdlbGwsIHJldmlld2VycyBo
YXZlIHNhaWQgdGhleSdkIHByZWZlciB0aGF0IFNIQS0xIG5vdCBiZSBpbmNsdWRlZCBhbmQgZ2l2
ZW4KPiA+ID4+ID4gc29tZSB0aG91Z2h0ZnVsIHJlYXNvbnMgZm9yIHRoYXQuICBCdXQgYWxzbyB0
aGV5J3ZlIGdpdmVuIHN1Z2dlc3Rpb25zIG9uIGhvdyB0bwo+ID4gPj4gPiBtYWtlIHRoZSBTSEEt
MSBzdXBwb3J0IG1vcmUgcGFsYXRhYmxlLCBzdWNoIGFzIHNwbGl0dGluZyBpdCBpbnRvIGEgc2Vw
YXJhdGUKPiA+ID4+ID4gcGF0Y2ggYW5kIGdpdmluZyBpdCBhIHByb3BlciBqdXN0aWZpY2F0aW9u
Lgo+ID4gPj4gPgo+ID4gPj4gPiBBbGwgc3VnZ2VzdGlvbnMgaGF2ZSBiZWVuIGlnbm9yZWQuCj4g
PiA+PiAKPiA+ID4+IFRoZSBwdWJsaWMgcmVjb3JkIGRlbW9uc3RyYXRlcyBvdGhlcndpc2UuCj4g
PiA+PiAKPiA+ID4+IEJ1dCBhcmUgeW91IHNheWluZyB0aGF0IHlvdSdkIGJlIGhhcHB5IGlmIHRo
ZSBjb21taXQgbWVzc2FnZSByZWFkCj4gPiA+PiBzb21ldGhpbmcgbW9yZSBsaWtlOgo+ID4gPj4g
Cj4gPiA+PiAtLS04PC0tLQo+ID4gPj4gRm9yIGJldHRlciBvciB3b3JzZSwgU2VjdXJlIExhdW5j
aCBuZWVkcyBTSEEtMSBhbmQgU0hBLTI1Ni4KPiA+ID4+IAo+ID4gPj4gVGhlIGNob2ljZSBvZiBo
YXNoZXMgdXNlZCBsaWUgd2l0aCB0aGUgcGxhdGZvcm0gZmlybXdhcmUsIG5vdCB3aXRoCj4gPiA+
PiBzb2Z0d2FyZSwgYW5kIGlzIG9mdGVuIG91dHNpZGUgb2YgdGhlIHVzZXJzIGNvbnRyb2wuCj4g
PiA+PiAKPiA+ID4+IEV2ZW4gaWYgd2UnZCBwcmVmZXIgdG8gdXNlIFNIQS0yNTYtb25seSwgaWYg
ZmlybXdhcmUgZWxlY3RlZCB0byBzdGFydCB1cwo+ID4gPj4gd2l0aCB0aGUgU0hBLTEgYW5kIFNI
QS0yNTYgYmFja3MgYWN0aXZlLCB3ZSBzdGlsbCBuZWVkIFNIQS0xIHRvIHBhcnNlCj4gPiA+PiB0
aGUgVFBNIGV2ZW50IGxvZyB0aHVzIGZhciwgYW5kIGRlbGliZXJhdGVseSBjYXAgdGhlIFNIQS0x
IFBDUnMgaW4gb3JkZXIKPiA+ID4+IHRvIHNhZmVseSB1c2UgU0hBLTI1NiBmb3IgZXZlcnl0aGlu
ZyBlbHNlLgo+ID4gPj4gLS0tCj4gPiA+Cj4gPiA+IFBsZWFzZSB0YWtlIHNvbWUgdGltZSB0byBy
ZWFkIHRocm91Z2ggdGhlIGNvbW1lbnRzIHRoYXQgcmV2aWV3ZXJzIGhhdmUgbGVmdCBvbgo+ID4g
PiBwcmV2aW91cyB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2hzZXQuCj4gPiAKPiA+IFNvIEkgd2VudCBh
bmQgcmVhZCB0aHJvdWdoIHRoZSBvbGQgY29tbWVudHMsIGFuZCBJJ20gbG9zdC4gIEluIGJyaWVm
IHN1bW1hcnk6Cj4gPiAKPiA+IElmIHRoZSBoYXJkd2FyZStmaXJtd2FyZSBvbmx5IHN1cHBvcnRz
IFNIQS0xLCB0aGVuIHNvbWUgcmV2aWV3ZXJzIHdvdWxkIHByZWZlcgo+ID4gTGludXggbm90IHRv
IHN1cHBvcnQgRFJUTS4gIEkgcGVyc29uYWxseSB0aGluayB0aGlzIGlzIGEgYml0IHNpbGx5LCBi
dXQgaXQncwo+ID4gbm90IGVudGlyZWx5IHVucmVhc29uYWJsZS4gIE1heWJlIGl0IHNob3VsZCBi
ZSBhIGNvbmZpZyBvcHRpb24/Cj4gPiAKPiA+IElmIHRoZSBoYXJkd2FyZStmaXJtd2FyZSBkb2Vz
IHN1cHBvcnQgU0hBLTI1NiwgdGhlbiBpdCBzb3VuZHMgKHRvIG1lLCByZWFkaW5nCj4gPiB0aGlz
IC0tIEkgaGF2ZW4ndCBkdWcgaW50byB0aGUgcmlnaHQgc3BlYyBwYWdlcykgdGhhdCwgZm9yIG9w
dGltYWwgc2VjdXJpdHksCj4gPiBzb21ldGhpbmcgc3RpbGwgbmVlZHMgdG8gZWZmZWN0aXZlbHkg
dHVybiBTSEEtMSAqb2ZmKiBhdCBydW50aW1lIGJ5IGNhcHBpbmcKPiA+IHRoZSBldmVudCBsb2cg
cHJvcGVybHkuICBBbmQgdGhhdCByZXF1aXJlcyBjb21wdXRpbmcgYSBTSEEtMSBoYXNoLiAgQW5k
LCB0byBiZQo+ID4gY2xlYXIsIChhKSB0aGlzIGlzIG9ubHkgb24gc3lzdGVtcyB0aGF0IGFscmVh
ZHkgc3VwcG9ydCBTSEEtMjU2IGFuZCB0aGF0IHdlCj4gPiBzaG91bGQgc3VwcG9ydCBhbmQgKGIp
ICpub3QqIGRvaW5nIHNvIGxlYXZlcyB1cyBwb3RlbnRpYWxseSBtb3JlIHZ1bG5lcmFibGUgdG8K
PiA+IFNIQS0xIGF0dGFja3MgdGhhbiBkb2luZyBzby4gIEFuZCBubyBTSEEtMjU2LXN1cHBvcnRp
bmcgdG9vbGluZyB3aWxsIGFjdHVhbGx5Cj4gPiBiZSBjb21wcm9taXNlZCBieSBhIFNIQS0xIGNv
bXByb21pc2UgaWYgd2UgY2FwIHRoZSBldmVudCBsb2cuCj4gPiAKPiA+IFNvIGlzIHRoZXJlIGEg
d2F5IGZvcndhcmQ/ICBKdXN0IHNheWluZyAicmVhZCB0aHJvdWdoIHRoZSBjb21tZW50cyIgc2Vl
bXMgbGlrZQo+ID4gYSBkZWFkIGVuZC4KPiA+IAo+Cj4gSXQgc2VlbXMgdGhlcmUgbWF5IGJlIGEg
anVzdGlmaWNhdGlvbiBmb3Igc29tZSBmb3JtIG9mIFNIQS0xIHN1cHBvcnQgaW4gdGhpcwo+IGZl
YXR1cmUuICBBcyBJJ3ZlIHNhaWQsIHRoZSBwcm9ibGVtIGlzIHRoYXQgaXQncyBub3QgZXhwbGFp
bmVkIGluIHRoZSBwYXRjaHNldAo+IGl0c2VsZi4gIFJhdGhlciwgaXQganVzdCB0YWxrcyBhYm91
dCAiU0hBIiBhbmQgcHJldGVuZHMgbGlrZSBTSEEtMSBhbmQgU0hBLTIgYXJlCj4gYmFzaWNhbGx5
IHRoZSBzYW1lLiAgSW4gZmFjdCwgU0hBLTEgZGlmZmVycyBkcmFzdGljYWxseSBmcm9tIFNIQS0y
IGluIHRlcm1zIG9mCj4gc2VjdXJpdHkuICBTSEEtMSBzdXBwb3J0IHNob3VsZCBiZSBhZGRlZCBp
biBhIHNlcGFyYXRlIHBhdGNoLCB3aXRoIGEgY2xlYXJseQo+IGV4cGxhaW5lZCByYXRpb25hbGUg
KmluIHRoZSBwYXRjaCBpdHNlbGYqIGZvciB0aGUgU0hBLTEgc3VwcG9ydCAqc3BlY2lmaWNhbGx5
Ki4KClllYWgsIHRoaXMgaXMgaW1wb3J0YW50IHNvIHRoYXQgd2UgZG9uJ3QgZW5kIHVwIGRlbGV0
aW5nIHRoYXQgc3VwcG9ydApieSBhY2NpZGVudC4gSnVzdCBhZGRpbmcgdG8gZGVub3RlIHRoYXQg
dGhpcyBtb3JlIHRoYW4ganVzdCBhICJwcm9jZXNzCmlzc3VlIi4KCj4gLSBFcmljCgpCUiwgSmFy
a2tvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhl
YyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

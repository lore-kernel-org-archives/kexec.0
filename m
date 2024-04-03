Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFB7CD1288
	for <kexec@archiver.kernel.org>; Wed,  3 Apr 2024 16:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rJUgCZ9fXw7+zbThuh7fFQFzQiBY56LSsIPAYl9J0ic=; b=0scU6HSUmDkkK0
	764ar5p55IiZmRFd7yFTqhWgZ0a1fMZjZgIhiRIETYLulJqp3D4zxFnXsosIZKM6nA6LaiVff7wkH
	svxHSnqVO9TjJpTyprgcba4AzImGf3I66Xxf7eihasqxySI6fDWgOgd+fYTq1PNnmDANoMPUXBLen
	TswwSwOq6EuHb2qj29Vtb7/PzImTt7qr46H67LO1CdVr/u+Zc3L0lBJkTaZbuDWhJGLx2qYNtPPiZ
	BGyy8FL4uhJZxHqUc/SlN814fys4/ai8k8zA4RR4dhJEAr7tENeI90qj14MMQr5THLf/TzOpEa5jT
	5VKbOJMr6Brnx2N1PwSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs3XM-0000000GzHg-18Z3;
	Wed, 03 Apr 2024 16:32:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs3XJ-0000000GzFk-0KGq
	for kexec@lists.infradead.org;
	Wed, 03 Apr 2024 16:32:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 83EBD614A7;
	Wed,  3 Apr 2024 16:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C6DC43390;
	Wed,  3 Apr 2024 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712161947;
	bh=0XnUl7dj6Ea6m99gt6Fm1hxbMTZDNcxsfZFaaTdkK5c=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=QW0wEMDgMWUZ79xdJoYkLiIHXuRzTAb74DDl4+KTGBNms5tjbS3/Dq+NcDc/zM9pO
	 6ZMVHRwU4f/KsH8hhp8YWGgsPfB2hJNE/zW10M9fNJGwioTTI5RXj9LCK+4kHdpVm7
	 56pe0foBhqSV/IedS0ZRo0OM98CPRLAZ0exUkyl4t19cXWE+Na+N4g157rMIWwR/+a
	 Jcd3P4AfBQbMfSwsNHWa4ynpqUPezzrEo0T5J8uagcJ/oCtRjq5w5FwG4qL0dwkbtX
	 JqxgjIMslOOZNAxqEP/MmDLPJKxFjR8PAcnLi14nzPRradUx/1PaspPsqJ02egM7eE
	 u7cRF7RLttn6g==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F06881200066;
	Wed,  3 Apr 2024 12:32:24 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 03 Apr 2024 12:32:25 -0400
X-ME-Sender: <xms:l4QNZnVTcmmcBj3cETMIjQPFeKyW216HWK1kyHvk5ak3_YuBQfomfQ>
    <xme:l4QNZvnCeko_j7aVMCevTqwRM7_fqcU20j_wDEsVTZHCnw-dG_YTuNPcHDSTz9Ieb
    ylCWq3tLYhNGdj3CNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeduveffvdegvdefhfegjeejlefgtdffueekudfgkeduvdetvddu
    ieeluefgjeeggfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:l4QNZjYSXaRfEAGTNz9O5uebk2fHJnste73pfQtv3vctGbwaC10s2w>
    <xmx:l4QNZiWxqHyVWKJiF4QUUEAo6lm2WIE1scUUV-YakZ7XqTXsCRovhg>
    <xmx:l4QNZhlvWkMn1SVoZn4CWHqQr0aqpqET5Ga7LXEkXKUWMws0gzMLpw>
    <xmx:l4QNZvdfRIc7OON-ak6PhAoHg4sCtKcl0fcLZQFhY7peszixkio4Ng>
    <xmx:mIQNZpOteF69teRpNuPDyBpLmH21WrVMM4syyjzPzuEhN6UyjV9zI2Zh>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0360131A0064; Wed,  3 Apr 2024 12:32:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
MIME-Version: 1.0
Message-Id: <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com>
In-Reply-To: <20240223183004.GE1112@sol.localdomain>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
 <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
 <20240223183004.GE1112@sol.localdomain>
Date: Wed, 03 Apr 2024 09:32:02 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>,
 "Andrew Cooper" <andrew.cooper3@citrix.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Ross Philipson" <ross.philipson@oracle.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "the arch/x86 maintainers" <x86@kernel.org>, linux-integrity@vger.kernel.org,
 linux-doc@vger.kernel.org,
 "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org,
 dpsmith@apertussolutions.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org,
 "Jason Gunthorpe" <jgg@ziepe.ca>,
 "luto@amacapital.net" <luto@amacapital.net>,
 "Arvind Sankar" <nivedita@alum.mit.edu>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch early
 measurements
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_093229_264074_74230C4C 
X-CRM114-Status: GOOD (  21.58  )
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

T24gRnJpLCBGZWIgMjMsIDIwMjQsIGF0IDEwOjMwIEFNLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4g
T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMDY6MjA6MjdQTSArMDAwMCwgQW5kcmV3IENvb3BlciB3
cm90ZToKPj4gT24gMjMvMDIvMjAyNCA1OjU0IHBtLCBFcmljIEJpZ2dlcnMgd3JvdGU6Cj4+ID4g
T24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgMDQ6NDI6MTFQTSArMDAwMCwgQW5kcmV3IENvb3BlciB3
cm90ZToKPj4gPj4gWWVzLCBhbmQgSSBhZ3JlZS7CoCBXZSdyZSBub3QgbG9va2luZyB0byB0cnkg
YW5kIGZvcmNlIHRoaXMgaW4gd2l0aAo+PiA+PiB1bmRlcmhhbmQgdGFjdGljcy4KPj4gPj4KPj4g
Pj4gQnV0IGEgYmxpbmQgIm5hY2sgdG8gYW55IFNIQS0xIiBpcyBzaW1pbGFybHkgZGFtYWdpbmcg
aW4gdGhlIG9wcG9zaXRlCj4+ID4+IGRpcmVjdGlvbi4KPj4gPj4KPj4gPiBXZWxsLCByZXZpZXdl
cnMgaGF2ZSBzYWlkIHRoZXknZCBwcmVmZXIgdGhhdCBTSEEtMSBub3QgYmUgaW5jbHVkZWQgYW5k
IGdpdmVuCj4+ID4gc29tZSB0aG91Z2h0ZnVsIHJlYXNvbnMgZm9yIHRoYXQuICBCdXQgYWxzbyB0
aGV5J3ZlIGdpdmVuIHN1Z2dlc3Rpb25zIG9uIGhvdyB0bwo+PiA+IG1ha2UgdGhlIFNIQS0xIHN1
cHBvcnQgbW9yZSBwYWxhdGFibGUsIHN1Y2ggYXMgc3BsaXR0aW5nIGl0IGludG8gYSBzZXBhcmF0
ZQo+PiA+IHBhdGNoIGFuZCBnaXZpbmcgaXQgYSBwcm9wZXIganVzdGlmaWNhdGlvbi4KPj4gPgo+
PiA+IEFsbCBzdWdnZXN0aW9ucyBoYXZlIGJlZW4gaWdub3JlZC4KPj4gCj4+IFRoZSBwdWJsaWMg
cmVjb3JkIGRlbW9uc3RyYXRlcyBvdGhlcndpc2UuCj4+IAo+PiBCdXQgYXJlIHlvdSBzYXlpbmcg
dGhhdCB5b3UnZCBiZSBoYXBweSBpZiB0aGUgY29tbWl0IG1lc3NhZ2UgcmVhZAo+PiBzb21ldGhp
bmcgbW9yZSBsaWtlOgo+PiAKPj4gLS0tODwtLS0KPj4gRm9yIGJldHRlciBvciB3b3JzZSwgU2Vj
dXJlIExhdW5jaCBuZWVkcyBTSEEtMSBhbmQgU0hBLTI1Ni4KPj4gCj4+IFRoZSBjaG9pY2Ugb2Yg
aGFzaGVzIHVzZWQgbGllIHdpdGggdGhlIHBsYXRmb3JtIGZpcm13YXJlLCBub3Qgd2l0aAo+PiBz
b2Z0d2FyZSwgYW5kIGlzIG9mdGVuIG91dHNpZGUgb2YgdGhlIHVzZXJzIGNvbnRyb2wuCj4+IAo+
PiBFdmVuIGlmIHdlJ2QgcHJlZmVyIHRvIHVzZSBTSEEtMjU2LW9ubHksIGlmIGZpcm13YXJlIGVs
ZWN0ZWQgdG8gc3RhcnQgdXMKPj4gd2l0aCB0aGUgU0hBLTEgYW5kIFNIQS0yNTYgYmFja3MgYWN0
aXZlLCB3ZSBzdGlsbCBuZWVkIFNIQS0xIHRvIHBhcnNlCj4+IHRoZSBUUE0gZXZlbnQgbG9nIHRo
dXMgZmFyLCBhbmQgZGVsaWJlcmF0ZWx5IGNhcCB0aGUgU0hBLTEgUENScyBpbiBvcmRlcgo+PiB0
byBzYWZlbHkgdXNlIFNIQS0yNTYgZm9yIGV2ZXJ5dGhpbmcgZWxzZS4KPj4gLS0tCj4KPiBQbGVh
c2UgdGFrZSBzb21lIHRpbWUgdG8gcmVhZCB0aHJvdWdoIHRoZSBjb21tZW50cyB0aGF0IHJldmll
d2VycyBoYXZlIGxlZnQgb24KPiBwcmV2aW91cyB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2hzZXQuCgpT
byBJIHdlbnQgYW5kIHJlYWQgdGhyb3VnaCB0aGUgb2xkIGNvbW1lbnRzLCBhbmQgSSdtIGxvc3Qu
ICBJbiBicmllZiBzdW1tYXJ5OgoKSWYgdGhlIGhhcmR3YXJlK2Zpcm13YXJlIG9ubHkgc3VwcG9y
dHMgU0hBLTEsIHRoZW4gc29tZSByZXZpZXdlcnMgd291bGQgcHJlZmVyIExpbnV4IG5vdCB0byBz
dXBwb3J0IERSVE0uICBJIHBlcnNvbmFsbHkgdGhpbmsgdGhpcyBpcyBhIGJpdCBzaWxseSwgYnV0
IGl0J3Mgbm90IGVudGlyZWx5IHVucmVhc29uYWJsZS4gIE1heWJlIGl0IHNob3VsZCBiZSBhIGNv
bmZpZyBvcHRpb24/CgpJZiB0aGUgaGFyZHdhcmUrZmlybXdhcmUgZG9lcyBzdXBwb3J0IFNIQS0y
NTYsIHRoZW4gaXQgc291bmRzICh0byBtZSwgcmVhZGluZyB0aGlzIC0tIEkgaGF2ZW4ndCBkdWcg
aW50byB0aGUgcmlnaHQgc3BlYyBwYWdlcykgdGhhdCwgZm9yIG9wdGltYWwgc2VjdXJpdHksIHNv
bWV0aGluZyBzdGlsbCBuZWVkcyB0byBlZmZlY3RpdmVseSB0dXJuIFNIQS0xICpvZmYqIGF0IHJ1
bnRpbWUgYnkgY2FwcGluZyB0aGUgZXZlbnQgbG9nIHByb3Blcmx5LiAgQW5kIHRoYXQgcmVxdWly
ZXMgY29tcHV0aW5nIGEgU0hBLTEgaGFzaC4gIEFuZCwgdG8gYmUgY2xlYXIsIChhKSB0aGlzIGlz
IG9ubHkgb24gc3lzdGVtcyB0aGF0IGFscmVhZHkgc3VwcG9ydCBTSEEtMjU2IGFuZCB0aGF0IHdl
IHNob3VsZCBzdXBwb3J0IGFuZCAoYikgKm5vdCogZG9pbmcgc28gbGVhdmVzIHVzIHBvdGVudGlh
bGx5IG1vcmUgdnVsbmVyYWJsZSB0byBTSEEtMSBhdHRhY2tzIHRoYW4gZG9pbmcgc28uICBBbmQg
bm8gU0hBLTI1Ni1zdXBwb3J0aW5nIHRvb2xpbmcgd2lsbCBhY3R1YWxseSBiZSBjb21wcm9taXNl
ZCBieSBhIFNIQS0xIGNvbXByb21pc2UgaWYgd2UgY2FwIHRoZSBldmVudCBsb2cuCgpTbyBpcyB0
aGVyZSBhIHdheSBmb3J3YXJkPyAgSnVzdCBzYXlpbmcgInJlYWQgdGhyb3VnaCB0aGUgY29tbWVu
dHMiIHNlZW1zIGxpa2UgYSBkZWFkIGVuZC4KClRoYW5rcywKQW5keQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=

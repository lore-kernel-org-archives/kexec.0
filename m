Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E25FC618D
	for <kexec@archiver.kernel.org>; Sat, 14 Sep 2024 03:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ry2QWwC4CoMP/3U8NTPzYuyeRAzkT8FfcL7szQGkbUE=; b=XntOeNg35JLoAJ
	Cschs/Gu21Y9YOkivIoveyTJMW0WHBD7j0VLmxgP7KLqP6zqCdU+TdpS1mEPyInS+NnWm3Q1SzyqI
	v8tK4w+SrUJKsyut+l1f8cU5NvmkXFdG8UxzIvRxn4vxqgC5UwOQLHm+hE8lYXaOmM5CR7X0BeJtn
	uCo+5lvxeBVVtIiU7x0clH8i3wIhwju1xeyElfFuSf10+DG6zZJ+sAHJRbLCYKhGpxjIeNNIKp7++
	/6LRx816eNkGs8D/N1CX+uup0IuOq8b/7vqor10Vlxc3kGY1Pani2wHxQkwO2xqRU9EW8erWa/OH4
	HT69H1hsTMQ+AUdyiFjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1spJum-000000000rw-1adW;
	Sat, 14 Sep 2024 03:57:40 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1spJuj-000000000rC-1hXE
	for kexec@lists.infradead.org;
	Sat, 14 Sep 2024 03:57:38 +0000
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso359034166b.1
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 20:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1726286255; x=1726891055; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frVOq4/VrOFSBx4qkzHXmRGBdSpABDY2CbvRjZSeHl4=;
        b=SWPOWp6Lp06DfPew/4peXnSwWl3CFm/MTdhiWs2+8EnXCKIBpHeqQMlDbyxpg7S4h5
         SYxaOt12x77Q00szISaq+t0RxS2kYK/HStuSa2rPKA5pKNus3vf8H5eDJMSJsztYfejA
         5QWG1rqhgDIfqeutEAHwzGo6wE7yvY8GsOmD3+k3t0Aqeiku8g5biDMx971AeOPXuBs5
         bMh9pU8Z8eMdPFBI0k7zhEFyOFLs6FAR/2zCrDcMDRTH8TWV2eClUqDlecb9JTZFLqBY
         fDA71A9NQZL8ZybwUI1MAHAC8pdH2KoPFef0lijCMpU9zcbhI7ZlJEEPAbZhMaeLr3ip
         h/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726286255; x=1726891055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frVOq4/VrOFSBx4qkzHXmRGBdSpABDY2CbvRjZSeHl4=;
        b=C3HD592TdIpspDchwaeLKcnj0LBVOimBgjwFrP8ieSPtc1+HGHOJGFD46aR+J5N4za
         gPFedhOwfxs3n0uD3NvEbpJWNH5TpwLFcaHOGkho1GeiWtp3JxWVQehAkWOdr9t9JGYx
         QOI5nLTqEPrHSglQlmYxbraXPhh1MP2e4HVW1xFP9eUeV5EDwMphAmP+uOHTe3624AGO
         B7numzOqFaDW5H2k+R5w2aheP3xtTnF8L1xJtpqpboh4k2HIxEXN0NIKbVwuA5ONMT7L
         Ukya9lqXYTF/WpxXO/xX0zipYKtrx89KU02e0gFLw2Tq0p11gXWntIqGtjuEvHG7PSeA
         BW7w==
X-Forwarded-Encrypted: i=1; AJvYcCVVpiKJlvpSio24SMJha5m4ltQlDrjrlS2Bj821e1Vnh9QIPNCP0FxyDYyTWTwgR8VajHPirw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzILExCzhJn5Td/rDe3bxtNSuwsKxCMVs6uBZT9JcYC7LE1/xKV
	DIctGXJ8+B5lW9B3VdR+6BL3BKCM+LB0BQdDsdPX/QJoYm+6/2uW2byI4ulVyURxmxDP5eZGaQa
	hIXSe9jyXksQU1H1Vh3bChoL6MYbrY/KVFX1q
X-Google-Smtp-Source: AGHT+IFF2MbJ6XCRo0MrZkYw3trl3AWEems+cbTpyeTHsgyTn4kgHQumH79FhKTJSbYKsaxyQDqJvjTVXWhQXbeHEQ0=
X-Received: by 2002:a17:907:e2a5:b0:a8a:926a:d012 with SMTP id
 a640c23a62f3a-a9029490673mr781104466b.26.1726286254571; Fri, 13 Sep 2024
 20:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com> <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
In-Reply-To: <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 13 Sep 2024 20:57:23 -0700
Message-ID: <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Eric Biggers <ebiggers@kernel.org>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_205737_742704_A2924909 
X-CRM114-Status: GOOD (  44.63  )
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

T24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgNTozNOKAr1BNIERhbmllbCBQLiBTbWl0aAo8ZHBzbWl0
aEBhcGVydHVzc29sdXRpb25zLmNvbT4gd3JvdGU6Cj4KPiBIZXkgYWdhaW4sCj4KPiBPbiA5LzQv
MjQgMjE6MDEsIERhbmllbCBQLiBTbWl0aCB3cm90ZToKPiA+IEhpIEx1dG8uCj4gPgo+ID4gT24g
OC8yOC8yNCAyMzoxNywgQW5keSBMdXRvbWlyc2tpIHdyb3RlOgo+ID4+IE9uIFRodSwgQXVnIDE1
LCAyMDI0IGF0IDEyOjEw4oCvUE0gVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
Cj4gPj4gd3JvdGU6Cj4gPj4+Cj4gPj4+IE9uIFRodSwgQXVnIDE1IDIwMjQgYXQgMTM6MzgsIERh
bmllbCBQLiBTbWl0aCB3cm90ZToKPiA+Pj4+IE9uIDUvMzEvMjQgMDk6NTQsIEVyaWMgVy4gQmll
ZGVybWFuIHdyb3RlOgo+ID4+Pj4+IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNAa2VybmVsLm9yZz4g
d3JpdGVzOgo+ID4+Pj4+PiBUaGF0IHBhcmFncmFwaCBpcyBhbHNvIHBocmFzZWQgYXMgYSBoeXBv
dGhldGljYWwsICJFdmVuIGlmIHdlJ2QKPiA+Pj4+Pj4gcHJlZmVyIHRvIHVzZQo+ID4+Pj4+PiBT
SEEtMjU2LW9ubHkiLiAgVGhhdCBpbXBsaWVzIHRoYXQgeW91IGRvIG5vdCwgaW4gZmFjdCwgcHJl
ZmVyCj4gPj4+Pj4+IFNIQS0yNTYgb25seS4gIElzCj4gPj4+Pj4+IHRoYXQgdGhlIGNhc2U/ICBT
dXJlLCBtYXliZSB0aGVyZSBhcmUgc2l0dWF0aW9ucyB3aGVyZSB5b3UgKmhhdmUqCj4gPj4+Pj4+
IHRvIHVzZSBTSEEtMSwKPiA+Pj4+Pj4gYnV0IHdoeSB3b3VsZCB5b3Ugbm90IGF0IGxlYXN0ICpw
cmVmZXIqIFNIQS0yNTY/Cj4gPj4+Pj4KPiA+Pj4+PiBZZXMuICBQbGVhc2UgcHJlZmVyIHRvIHVz
ZSBTSEEtMjU2Lgo+ID4+Pj4+Cj4gPj4+Pj4gSGF2ZSB5b3UgY29uc2lkZXJlZCBpbXBsZW1lbnRp
bmcgSSB0aGluayBpdCBpcyBTSEExLURDIChhcyBnaXQgaGFzKQo+ID4+Pj4+IHRoYXQKPiA+Pj4+
PiBpcyBjb21wYXRpYmxlIHdpdGggU0hBMSBidXQgYmxvY2tzIHRoZSBrbm93biBjbGFzcyBvZiBh
dHRhY2tzIHdoZXJlCj4gPj4+Pj4gc2hhMSBpcyBhY3RpdmVseSBicm9rZW4gYXQgdGhpcyBwb2lu
dD8KPiA+Pj4+Cj4gPj4+PiBXZSBhcmUgdXNpbmcgdGhlIGtlcm5lbCdzIGltcGxlbWVudGF0aW9u
LCBhZGRyZXNzaW5nIHdoYXQgdGhlIGtlcm5lbAo+ID4+Pj4gcHJvdmlkZXMgaXMgYmV5b25kIG91
ciBlZmZvcnRzLiBQZXJoYXBzIHNvbWVvbmUgd2hvIGlzIGludGVyZXN0ZWQgaW4KPiA+Pj4+IGlt
cHJvdmluZyB0aGUga2VybmVsJ3MgU0hBMSBjb3VsZCBzdWJtaXQgYSBwYXRjaCBpbXBsZW1lbnRp
bmcvcmVwbGFjaW5nCj4gPj4+PiBpdCB3aXRoIFNIQTEtREMsIGFzIEkgYW0gc3VyZSB0aGUgbWFp
bnRhaW5lcnMgd291bGQgd2VsY29tZSB0aGUgaGVscC4KPiA+Pj4KPiA+Pj4gV2VsbCwgc29tZW9u
ZSB3aG8gaXMgaW50ZXJlc3RlZCB0byBnZXQgaGlzICJzZWN1cmUiIGNvZGUgbWVyZ2VkIHNob3Vs
ZAo+ID4+PiBoYXZlIGEgdmVzdGVkIGludGVyZXN0ZWQgdG8gaGF2ZSBhIG5vbi1icm9rZW4gU0hB
MSBpbXBsZW1lbnRhdGlvbiBpZgo+ID4+PiB0aGVyZSBpcyBhIHNlbnNpYmxlIHJlcXVpcmVtZW50
IHRvIHVzZSBTSEExIGluIHRoYXQgbmV3ICJzZWN1cmUiIGNvZGUsCj4gPj4+IG5vPwo+ID4+Pgo+
ID4+PiBKdXN0IGZvciB0aGUgcmVjb3JkLiBUaGUgcmVsYXRlZCBtYWludGFpbmVycyBjYW4gcmln
aHRmdWxseSBkZWNpZGUgdG8KPiA+Pj4gcmVqZWN0IGtub3duIGJyb2tlbiAic2VjdXJlIiBjb2Rl
IG9uIGEgcHVyZWx5IHRlY2huaWNhbCBhcmd1bWVudC4KPiA+Pj4KPiA+Pgo+ID4+IFdhaXQsIGhv
bGQgb24gYSBzZWNvbmQuCj4gPj4KPiA+PiBTSEExLURDIGlzbid0IFNIQTEuICBJdCdzIGEgZGlm
ZmVyZW50IGhhc2ggZnVuY3Rpb24gdGhhdCBpcyBtb3N0bHkKPiA+PiBjb21wYXRpYmxlIHdpdGgg
U0hBMSwgaXMgZGlmZmVyZW50IG9uIHNvbWUgaW5wdXRzLCBhbmQgaXMgbWF5YmUgbW9yZQo+ID4+
IHNlY3VyZS4gIEJ1dCB0aGUgX3dob2xlIHBvaW50XyBvZiB1c2luZyBTSEExIGluIHRoZSBUUE0g
Y29kZSAod2VsbCwKPiA+PiB0aGlzIHJlYWxseSBzaG91bGQgYmUgdGhlIHdob2xlIHBvaW50IGZv
ciBuZXcgYXBwbGljYXRpb25zKSBpcyB0bwo+ID4+IGNvcnJlY3RseSBjYXAgdGhlIFNIQTEgUENS
cyBzbyB3ZSBjYW4gY29ycmVjdGx5IF90dXJuIHRoZW0gb2ZmXyBpbiB0aGUKPiA+PiBiZXN0IHdh
eSB3aXRob3V0IGJyZWFraW5nIGNvbXBhdGliaWxpdHkgd2l0aCBldmVyeXRoaW5nIHRoYXQgbWln
aHQKPiA+PiByZWFkIHRoZSBldmVudCBsb2cuICBJIHRoaW5rIHRoYXQgYW55b25lIHN1Z2dlc3Rp
bmcgdXNpbmcgU0hBMS1EQyBmb3IKPiA+PiB0aGlzIHB1cnBvc2Ugc2hvdWxkIGdpdmUgc29tZSBh
Y3R1YWwgYW5hbHlzaXMgYXMgdG8gd2h5IHRoZXkgdGhpbmsKPiA+PiBpdCdzIGFuIGltcHJvdmVt
ZW50LCBsZXQgYWxvbmUgZXZlbiB2YWxpZC4KPiA+Cj4gPiBJIHdvdWxkIHNheSBhdCBhIG1pbmlt
dW0gaXQgaXMgdG8gcHJvdmlkZSBhIG1lYW5zIHRvIGNhcCB0aGUgUENScy4KPiA+IERldmljZXMg
d2l0aCBUUE0xLjIgYXJlIHN0aWxsIHByZXZhbGVudCBpbiB0aGUgd2lsZCBmb3Igd2hpY2ggbWVt
YmVycyBvZgo+ID4gdGhlIFRyZW5jaEJvb3QgY29tbXVuaXR5IHN1cHBvcnQsIGFuZCB0aGVyZSBh
cmUgc3RpbGwgdmFsaWQgKGFuZCBzZWN1cmUpCj4gPiB2ZXJpZmljYXRpb24gdXNlcyBmb3IgU0hB
MSB0aGF0IEkgb3V0bGluZWQgaW4gbXkgcHJldmlvdXMgcmVzcG9uc2UuCj4gPgo+ID4+IFJvc3Mg
ZXQgYWwsIGNhbiB5b3UgY29uZmlybSB0aGF0IHlvdXIgY29kZSBhY3R1YWxseSwgYXQgbGVhc3Qg
YnkKPiA+PiBkZWZhdWx0IGFuZCB3aXRoIGEgbW9uc3Ryb3VzIHdhcm5pbmcgdG8gYW55b25lIHdo
byB0cmllcyB0byBjaGFuZ2UgdGhlCj4gPj4gZGVmYXVsdCwgY2FwcyBTSEExIFBDUnMgaWYgU0hB
MjU2IGlzIGF2YWlsYWJsZT8gIEFuZCB0aGVuIGNhbiB3ZSBtYXliZQo+ID4+IGFsbCBzdG9wIGhh
c3NsaW5nIHRoZSBwZW9wbGUgdHJ5aW5nIHRvIGRldmVsb3AgdGhpcyBzZXJpZXMgYWJvdXQgdGhl
Cj4gPj4gZmFjdCB0aGF0IHRoZXkncmUgZG9pbmcgdGhlaXIgYmVzdCB3aXRoIHRoZSBvYm5veGlv
dXMgc3lzdGVtIHRoYXQgdGhlCj4gPj4gVFBNIGRlc2lnbmVycyBnYXZlIHRoZW0/Cj4gPgo+ID4g
T3VyIGdvYWwgaXMgdG8ga2VlcCBjb250cm9sIGluIHRoZSBoYW5kcyBvZiB0aGUgdXNlciwgbm90
IG1ha2luZwo+ID4gdW5pbGF0ZXJhbCBkZWNpc2lvbnMgb24gdGhlaXIgYmVoYWxmLiBJbiB0aGUg
Y3VycmVudGx5IGRlcGxveWVkCj4gPiBzb2x1dGlvbnMgaXQgaXMgbGVmdCB0byB0aGUgaW5pdHJk
ICh1c2VyKSB0byBjYXAgdGhlIFBDUnMuIEFmdGVyIHNvbWUKPiA+IHRoaW5raW5nLCB3ZSBjYW4g
c3RpbGwgZW5zdXJlIHVzZXIgY29udHJvbCBhbmQgZ2l2ZSBhbiBvcHRpb24gdG8gY2FwIHRoZQo+
ID4gUENScyBlYXJsaWVyLiBXZSBob3BlIHRvIHBvc3QgYSB2MTEgbGF0ZXIgdGhpcyB3ZWVrIG9y
IGVhcmx5IG5leHQgd2Vlawo+ID4gdGhhdCBpbnRyb2R1Y2VzIGEgbmV3IHBvbGljeSBmaWVsZCB0
byB0aGUgZXhpc3RpbmcgbWVhc3VyZW1lbnQgcG9saWN5Cj4gPiBmcmFtZXdvcmsuIFdpbGwgYWRk
L3VwZGF0ZSB0aGUga2VybmVsIGRvY3Mgd2l0aCByZXNwZWN0IHRvIHRoZSBwb2xpY3kKPiA+IGV4
cGFuc2lvbi4gV2UgYXJlIGFsc28gbG9va2luZyB0aGUgYmVzdCB3YXkgd2UgbWlnaHQgYWRkIGEg
d2FybmluZyB0bwo+ID4gdGhlIGtlcm5lbCBsb2cgaWYgdGhlIFNIQTEgYmFuayBpcyB1c2VkIGJl
eW9uZCBjYXBwaW5nIHRoZSBQQ1JzLgo+Cj4gQXMgdGhlIGF0dGVtcHQgd2FzIG1hZGUgdG8gbGF5
IGluIHRoZSBwb2xpY3kgbG9naWMsIGl0IHN0YXJ0ZWQgdG8gYmVjb21lCj4gY29udm9sdXRlZCBh
bmQgdW5uZWNlc3NhcmlseSBjb21wbGljYXRlZC4gVGh1cyBjcmVhdGluZyBtb3JlIHJpc2sgd2l0
aAo+IGFsbCB0aGUgYm9va2tlZXBpbmcgYW5kIHlldCBzaGExIGhhc2hlcyBzdGlsbCBoYXZlIHRv
IGJlIHNlbnQsIHRoZSBudWxsCj4gaGFzaCBpbiB0aGlzIGNhc2UsIHNpbmNlIHRoZSBUUE0gZHJp
dmVyIHdpbGwgcmVqZWN0IGV4dGVuZHMgdGhhdCBkbyBub3QKPiBoYXZlIGhhc2hlcyBmb3IgYWxs
IGFjdGl2ZSBiYW5rcy4gQXQgdGhpcyBwb2ludCwgd2UgaGF2ZSBvcHRlZCB0byBrZWVwCj4gdGhl
IGxvZ2ljIHNpbXBsZSBhbmQgYWRkIGEgc2VjdGlvbiB0byBvdXIgZG9jdW1lbnRhdGlvbiBhZHZp
c2luZyBvZiB0aGUKPiBwb3RlbnRpYWwgcmlzayBzaG91bGQgb25lIGNob29zZSB0byBpbmNvcnBv
cmF0ZSBTSEExIGluIHRoZWlyCj4gYXR0ZXN0YXRpb25zIG9mIHRoZSBwbGF0Zm9ybS4KPgoKSSd2
ZSByZWFkIHRoZSBUUE0gc3RhbmRhcmQgYSBiaXQsIGJ1dCBpdCdzIGJlZW4gYXdoaWxlLCBhbmQg
aXQncyB0b28KY29tcGxpY2F0ZWQgYW55d2F5LiAgU28sIGNhbiB5b3UgcmVtaW5kIG1lIChhbmQg
cHJvYmFibHkgMy80IG9mIHRoZQpvdGhlciBwZW9wbGUgb24gdGhpcyB0aHJlYWQsIHRvbyk6CgpX
aGF0LCBleGFjdGx5LCBpcyB5b3VyIHBhdGNoc2V0IGRvaW5nIHRoYXQgcmVxdWlyZXMgaGFzaGlu
ZyBhdCBhbGw/CihJIGFzc3VtZSBpdCdzIGV4dGVuZGluZyBhIFBDUiBhbmQgZ2VuZXJhdGluZyBh
biBldmVudCBsb2cgZW50cnkuKS4KV2hhdCwgZXhhY3RseSwgZG9lcyBpdCBtZWFuIHRvICJjYXAi
IGEgUENSPyAgSG93IGlzIHRoaXMgZGlmZmVyZW50CmZyb20gd2hhdCB5b3VyIHBhdGNoc2V0IGRv
ZXM/CgpXaXRoIHRoYXQgYW5zd2VyZWQsIGl0IHdpbGwgaG9wZWZ1bGx5IGJlIGVhc3kgdG8gc2Vl
IHRoYXQgeW91J3JlCm1ha2luZyB0aGUgcmlnaHQgY2FsbCA6KQoKLS1BbmR5CgotLSAKQW5keSBM
dXRvbWlyc2tpCkFNQSBDYXBpdGFsIE1hbmFnZW1lbnQsIExMQwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

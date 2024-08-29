Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68299C87FCE
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=knrJN2EWeCczJj6/avBe+BIWByG8JDj5A1KPrWQl5IU=; b=ZeA3v1Ph/ID2Eu
	7Wo9J8PiUxksjVZzmQs4BwihNMfcli3QbWpX8UNMDSjJlS8cb7LvYrVu64sNXrOwY4AE5EOqKaagh
	2pdtCKV4vZlDoTE/b1vUdMIqodjoqBYfUU6fHRMIqZSPkpIObQ1qxZjIFSWidySdAmhuDFSxoH0+4
	aHV+8KZnZ19eV82gd97bqOMUzQ1fSylaD5su3YVWpL+A37Y6i0xzKjzoY6gnqQr1nZAfMPPCg7X6S
	n/Hsg1xq7S7quzZ0+cFRQ1EINnPNbA4ICz1IhouTWPnAxPsLZd+WjGWJICrzstjv+zuwDj25yRkCD
	AeX5jd7oR0191O6WP41w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjiup-00000002zuv-46jv;
	Thu, 29 Aug 2024 17:26:35 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjium-00000002ztp-3LU9
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 17:26:34 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5c0a9ae3665so1035039a12.0
        for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1724952391; x=1725557191; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOQJo2GeGUsaAWwa6mncP2Ys8KGeup0MpOwdKy9vZ2s=;
        b=xPNNcC4DaZBU5bW1Pq6wYDvVSpasatkuJrOGwSJq98onShuX4RKI+QynOH4Z53PrKc
         w7nF1JJmaWfgYwyAe8qUpGuTiMYd3hDXO+/tUOOi5aqcimLGGVQ/ayQ4Jjc+SgsZT49Q
         ceeZiJ7Jej5wQhNpASAnpevrXLXoF2qdiiMfRZM7c80zcke8Og/egYY9b0qlLIrtuE22
         86OQOQfNb8nqt8ieDl+Gqo0AHflwwl7lCbku0ZE3vAWoRi8snAdJqmHYqjxHfWFbnmfP
         ho5gb+R1p20oirrqsXAvNek4lHTuISVPa/R7K5VRQixri81acL7hQd+CsezByXpldYf4
         ZBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952391; x=1725557191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOQJo2GeGUsaAWwa6mncP2Ys8KGeup0MpOwdKy9vZ2s=;
        b=cg9FMtyb7s0BNk6DmgzWcPg7RJaSpq2eqGyXwb9Gal6CbSgEEoyht6z+/ZWXJNYRg2
         gGznF0AlUMHdvAjxjaIhgdia2YFIhI49yTvjoIbGe/LdOTvCjZQD7Q1t8sa1co7orbom
         sIbQVgaLK9dCtimnj71Qe4Mu6UAgPqp9kvdY6f3nMZz0yABbMokQ7GPPUGTSvqUd3MNb
         Ma1anJ6E2SHiMvtiS1+4tuBJURMiyUnnv6FJs7t/0tkVYNTaENWXxgVCEum8k5kLXNmb
         pPwGkKUMRqX9qaKi2JDwWMTEfGr5AyEPLrGoc6Efk2yMP4B9vmMym/p7zOaj97PSjb4H
         +T3w==
X-Forwarded-Encrypted: i=1; AJvYcCWpJ39NlPCksfC+NBACpTGW6xl2P5nnIbUDRpaYjCwC6q9p9vNjv9AgX3BxEDtxX4vfjcSPLQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2gv00LQuk+ggNCLCtIZiaUf37By58mmlXRvKwpsrcwPhsGvMk
	irshhaWGInsqPIzFoN5mDJVFNoblqe4Q8zkds0I+e3RvNjmUA3Z7bi6ubwZMGLZxrnzyT6etH8j
	8rKfFBVdEyIUnGBIZCfL3g8Br3C3x5uL9wcs6
X-Google-Smtp-Source: AGHT+IH4iuyCchMQAlPW+yMmxvPWO1Nlc/xUYnfiyGoA+O59EpUNxRiKYElkWTnQ0OSm9kXEGTyn1XnDACEEoQtNqZ8=
X-Received: by 2002:a05:6402:401e:b0:5be:ff22:8eef with SMTP id
 4fb4d7f45d1cf-5c21ed98f9fmr3609188a12.36.1724952390717; Thu, 29 Aug 2024
 10:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
In-Reply-To: <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 Aug 2024 10:26:18 -0700
Message-ID: <CALCETrW8jfkvMc2rwCoyiVON25YFVQZWrb4ZFFoUs3zhRV4YEQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au, 
	davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_102633_124597_2A050CBC 
X-CRM114-Status: GOOD (  16.93  )
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

T24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgODoyNeKAr1BNIE1hdHRoZXcgR2FycmV0dCA8bWpnNTlA
c3JjZi51Y2FtLm9yZz4gd3JvdGU6Cj4KPiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCAwODoxNzow
NVBNIC0wNzAwLCBBbmR5IEx1dG9taXJza2kgd3JvdGU6Cj4KPiA+IFJvc3MgZXQgYWwsIGNhbiB5
b3UgY29uZmlybSB0aGF0IHlvdXIgY29kZSBhY3R1YWxseSwgYXQgbGVhc3QgYnkKPiA+IGRlZmF1
bHQgYW5kIHdpdGggYSBtb25zdHJvdXMgd2FybmluZyB0byBhbnlvbmUgd2hvIHRyaWVzIHRvIGNo
YW5nZSB0aGUKPiA+IGRlZmF1bHQsIGNhcHMgU0hBMSBQQ1JzIGlmIFNIQTI1NiBpcyBhdmFpbGFi
bGU/ICBBbmQgdGhlbiBjYW4gd2UgbWF5YmUKPiA+IGFsbCBzdG9wIGhhc3NsaW5nIHRoZSBwZW9w
bGUgdHJ5aW5nIHRvIGRldmVsb3AgdGhpcyBzZXJpZXMgYWJvdXQgdGhlCj4gPiBmYWN0IHRoYXQg
dGhleSdyZSBkb2luZyB0aGVpciBiZXN0IHdpdGggdGhlIG9ibm94aW91cyBzeXN0ZW0gdGhhdCB0
aGUKPiA+IFRQTSBkZXNpZ25lcnMgZ2F2ZSB0aGVtPwo+Cj4gUHJlc3VtYWJseSB0aGlzIHdvdWxk
IGJlIGRlcGVuZGVudCB1cG9uIG5vbi1TSEExIGJhbmtzIGJlaW5nIGVuYWJsZWQ/CgpPZiBjb3Vy
c2UuICBJdCdzIGFsc28gbm90IGltbWVkaWF0ZWx5IG9idmlvdXMgdG8gbWUgd2hhdCBsYXllciBv
ZiB0aGUKc3RhY2sgc2hvdWxkIGJlIHJlc3BvbnNpYmxlIGZvciBjYXBwaW5nIFNIQTEgUENScy4g
IFNob3VsZCBpdCBiZSB0aGUKa2VybmVsPyAgVXNlcnNwYWNlPwoKSXQgc2VlbXMgbGlrZSBhIHdo
b2xlIGxvdCBvZiBwZW9wbGUsIGZvciBiZXR0ZXIgb3IgZm9yIHdvcnNlLCB3YW50IHRvCm1pbmlt
aXplIHRoZSBhbW91bnQgb2YgY29kZSB0aGF0IGV2ZW4ga25vd3MgaG93IHRvIGNvbXB1dGUgU0hB
MQpoYXNoZXMuICBJJ20gbm90IHBlcnNvbmFsbHkgY29udmluY2VkIEkgYWdyZWUgd2l0aCB0aGlz
IHN0cmF0ZWd5LCBidXQKaXQgaXMgd2hhdCBpdCBpcy4gIEFuZCBtYXliZSBwZW9wbGUgd291bGQg
YmUgaGFwcGllciBpZiB0aGUgZGVmYXVsdApiZWhhdmlvciBvZiB0aGUga2VybmVsIGlzIHRvIG5v
dGljZSB0aGF0IFNIQTI1NiBpcyBhdmFpbGFibGUgYW5kIHRoZW4KY2FwIFNIQTEgYmVmb3JlIGV2
ZW4gYXNraW5nIHVzZXIgY29kZSdzIHBlcm1pc3Npb24uCgotLUFuZHkKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK

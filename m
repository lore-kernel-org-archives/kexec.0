Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FDFC7115D
	for <kexec@archiver.kernel.org>; Thu, 29 Aug 2024 03:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9TZztDc5zETJocQwfV+VVKQZV9wPvsQ0T3EyeG235Pw=; b=oreUo5FsrkdD+l
	0jOQauksqhNOTALBQxltGJ+WK3II/zm3Wf1eshg+V024lQAjQTnetsRbIduPdEWdOXEg0kQKQS/dm
	s6AnXOyEmWoyO3gMbBJsRa9uUQMd9ZOaJwLvkqcYZrSUD/HXztjNQIk+6abT0jHuDqW04j16FPNqg
	JZvMWRgkPJIpiP8uC4AkrM3G5OhLNuTdg7YW7n5O1odby4BFWKY7W9sN5Hm/0za8VtF6m0vKyN92p
	INOWL6NheijPdEJYplxeT6X+cgFMpulNGqnqLGwazOWLhGxv0KARCg9cfjI8ddYCN34hPCrYx2u4J
	CITj2KpzyNbJkehySt4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjVf0-00000000KSi-1rrF;
	Thu, 29 Aug 2024 03:17:22 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjVex-00000000KRs-11y7
	for kexec@lists.infradead.org;
	Thu, 29 Aug 2024 03:17:20 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso170606a12.1
        for <kexec@lists.infradead.org>; Wed, 28 Aug 2024 20:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1724901437; x=1725506237; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNmzosmlE3keF9ZOCKanmUq6J3PfB9qYT5nEB2uhPjQ=;
        b=eblNP2JdM9C7RFeFrM59Rss+n9sSKOxcB8xQ/5GxIbouXcaQYQNnPpBQeeTSP6T6le
         NqAOuGk1qaePu6bhGyf4D6b9Z8qMKK5ahdIzb+NDn8VuOcjAXJVl1LtFI18E7CZhhCON
         3uSIkThm9fka6iK+5rk2seecsAaTm/3ieGz3pganmpFkdcujpTDuF+1iEthiV+XiFKoF
         pvOLO5HDAW9/LNL3+cQjrhaqBKA5M7ZqS9+6F2B0jMj8k+VHmChnfnNcRRMHDIIPwQP+
         EblW63I2YXNWbgCLcjwNE50JpRjRaiGMbNsMo4nkz3okmWqFSfSDu5/kpWMofA9LKLj1
         7xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724901437; x=1725506237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNmzosmlE3keF9ZOCKanmUq6J3PfB9qYT5nEB2uhPjQ=;
        b=mdwmk1TO3PlsUktleQEln+sXeBKob7T/V+dtPTeMeEuOD/JqmzWQoklamdRf+ZVJ+K
         LscGvL8jqgloxMFiXmE3fpWkUNYSezEaujhFs7S2+Tr933fzxjvN8ssgF61aB5EP7UWE
         /9EpLazNImRsjEbudZfMw6esYhhgwVP49cAt+fLstJemU42MHYrFXL0iPa6CroZEwblI
         bWHXpMcGdfMkLxsfFOjsPlcvuZAH/fYQPBEqN5Pn+7oQ+i10olxxamEH9O6NUSMW449N
         D2USCpNrbGJ6lvSM8zw3Qp/2xyy/8HK/d/0OAOVPrNAimwAZ5GbGxrmHutRieyxqgkn4
         kP7g==
X-Forwarded-Encrypted: i=1; AJvYcCX6l1mVq7pxZoQUqMaLG5ONCf+jMxo8bJns1WBE19tIeEJvEvQgdAnKrc4b2Zp2BTxQBVCoKg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0+2QmawbfgpnlRo+yk61Kuhw200cPEHrd0OjK2SH9EbdIrof3
	jBSlo6S1P7zrN2CCh8ODj6Qwv/+gvtPKOQN0Q6s1X5sF+8dW3NdKn/dGdJr+LfnmLhBSWvMtWIl
	vr/C4w5Nqy2RJunosgKOQoFPgKTzGrIS32zJF
X-Google-Smtp-Source: AGHT+IFEtovpRJEIjkfJeoX6oyzRzBMJpdpEM5rys6Mzg7Lm/FHfWD6uqtRHPHJtPhzPqMuGNpCp0pksl5KfgHXNdDI=
X-Received: by 2002:a05:6402:518e:b0:5bf:c8:78a with SMTP id
 4fb4d7f45d1cf-5c21ed5316amr952709a12.17.1724901436704; Wed, 28 Aug 2024
 20:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
In-Reply-To: <87ttflli09.ffs@tglx>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 28 Aug 2024 20:17:05 -0700
Message-ID: <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_201719_551266_9AF2E8FC 
X-CRM114-Status: GOOD (  24.73  )
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

T24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgMTI6MTDigK9QTSBUaG9tYXMgR2xlaXhuZXIgPHRnbHhA
bGludXRyb25peC5kZT4gd3JvdGU6Cj4KPiBPbiBUaHUsIEF1ZyAxNSAyMDI0IGF0IDEzOjM4LCBE
YW5pZWwgUC4gU21pdGggd3JvdGU6Cj4gPiBPbiA1LzMxLzI0IDA5OjU0LCBFcmljIFcuIEJpZWRl
cm1hbiB3cm90ZToKPiA+PiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGtlcm5lbC5vcmc+IHdyaXRl
czoKPiA+Pj4gVGhhdCBwYXJhZ3JhcGggaXMgYWxzbyBwaHJhc2VkIGFzIGEgaHlwb3RoZXRpY2Fs
LCAiRXZlbiBpZiB3ZSdkIHByZWZlciB0byB1c2UKPiA+Pj4gU0hBLTI1Ni1vbmx5Ii4gIFRoYXQg
aW1wbGllcyB0aGF0IHlvdSBkbyBub3QsIGluIGZhY3QsIHByZWZlciBTSEEtMjU2IG9ubHkuICBJ
cwo+ID4+PiB0aGF0IHRoZSBjYXNlPyAgU3VyZSwgbWF5YmUgdGhlcmUgYXJlIHNpdHVhdGlvbnMg
d2hlcmUgeW91ICpoYXZlKiB0byB1c2UgU0hBLTEsCj4gPj4+IGJ1dCB3aHkgd291bGQgeW91IG5v
dCBhdCBsZWFzdCAqcHJlZmVyKiBTSEEtMjU2Pwo+ID4+Cj4gPj4gWWVzLiAgUGxlYXNlIHByZWZl
ciB0byB1c2UgU0hBLTI1Ni4KPiA+Pgo+ID4+IEhhdmUgeW91IGNvbnNpZGVyZWQgaW1wbGVtZW50
aW5nIEkgdGhpbmsgaXQgaXMgU0hBMS1EQyAoYXMgZ2l0IGhhcykgdGhhdAo+ID4+IGlzIGNvbXBh
dGlibGUgd2l0aCBTSEExIGJ1dCBibG9ja3MgdGhlIGtub3duIGNsYXNzIG9mIGF0dGFja3Mgd2hl
cmUKPiA+PiBzaGExIGlzIGFjdGl2ZWx5IGJyb2tlbiBhdCB0aGlzIHBvaW50Pwo+ID4KPiA+IFdl
IGFyZSB1c2luZyB0aGUga2VybmVsJ3MgaW1wbGVtZW50YXRpb24sIGFkZHJlc3Npbmcgd2hhdCB0
aGUga2VybmVsCj4gPiBwcm92aWRlcyBpcyBiZXlvbmQgb3VyIGVmZm9ydHMuIFBlcmhhcHMgc29t
ZW9uZSB3aG8gaXMgaW50ZXJlc3RlZCBpbgo+ID4gaW1wcm92aW5nIHRoZSBrZXJuZWwncyBTSEEx
IGNvdWxkIHN1Ym1pdCBhIHBhdGNoIGltcGxlbWVudGluZy9yZXBsYWNpbmcKPiA+IGl0IHdpdGgg
U0hBMS1EQywgYXMgSSBhbSBzdXJlIHRoZSBtYWludGFpbmVycyB3b3VsZCB3ZWxjb21lIHRoZSBo
ZWxwLgo+Cj4gV2VsbCwgc29tZW9uZSB3aG8gaXMgaW50ZXJlc3RlZCB0byBnZXQgaGlzICJzZWN1
cmUiIGNvZGUgbWVyZ2VkIHNob3VsZAo+IGhhdmUgYSB2ZXN0ZWQgaW50ZXJlc3RlZCB0byBoYXZl
IGEgbm9uLWJyb2tlbiBTSEExIGltcGxlbWVudGF0aW9uIGlmCj4gdGhlcmUgaXMgYSBzZW5zaWJs
ZSByZXF1aXJlbWVudCB0byB1c2UgU0hBMSBpbiB0aGF0IG5ldyAic2VjdXJlIiBjb2RlLAo+IG5v
Pwo+Cj4gSnVzdCBmb3IgdGhlIHJlY29yZC4gVGhlIHJlbGF0ZWQgbWFpbnRhaW5lcnMgY2FuIHJp
Z2h0ZnVsbHkgZGVjaWRlIHRvCj4gcmVqZWN0IGtub3duIGJyb2tlbiAic2VjdXJlIiBjb2RlIG9u
IGEgcHVyZWx5IHRlY2huaWNhbCBhcmd1bWVudC4KPgoKV2FpdCwgaG9sZCBvbiBhIHNlY29uZC4K
ClNIQTEtREMgaXNuJ3QgU0hBMS4gIEl0J3MgYSBkaWZmZXJlbnQgaGFzaCBmdW5jdGlvbiB0aGF0
IGlzIG1vc3RseQpjb21wYXRpYmxlIHdpdGggU0hBMSwgaXMgZGlmZmVyZW50IG9uIHNvbWUgaW5w
dXRzLCBhbmQgaXMgbWF5YmUgbW9yZQpzZWN1cmUuICBCdXQgdGhlIF93aG9sZSBwb2ludF8gb2Yg
dXNpbmcgU0hBMSBpbiB0aGUgVFBNIGNvZGUgKHdlbGwsCnRoaXMgcmVhbGx5IHNob3VsZCBiZSB0
aGUgd2hvbGUgcG9pbnQgZm9yIG5ldyBhcHBsaWNhdGlvbnMpIGlzIHRvCmNvcnJlY3RseSBjYXAg
dGhlIFNIQTEgUENScyBzbyB3ZSBjYW4gY29ycmVjdGx5IF90dXJuIHRoZW0gb2ZmXyBpbiB0aGUK
YmVzdCB3YXkgd2l0aG91dCBicmVha2luZyBjb21wYXRpYmlsaXR5IHdpdGggZXZlcnl0aGluZyB0
aGF0IG1pZ2h0CnJlYWQgdGhlIGV2ZW50IGxvZy4gIEkgdGhpbmsgdGhhdCBhbnlvbmUgc3VnZ2Vz
dGluZyB1c2luZyBTSEExLURDIGZvcgp0aGlzIHB1cnBvc2Ugc2hvdWxkIGdpdmUgc29tZSBhY3R1
YWwgYW5hbHlzaXMgYXMgdG8gd2h5IHRoZXkgdGhpbmsKaXQncyBhbiBpbXByb3ZlbWVudCwgbGV0
IGFsb25lIGV2ZW4gdmFsaWQuCgpSb3NzIGV0IGFsLCBjYW4geW91IGNvbmZpcm0gdGhhdCB5b3Vy
IGNvZGUgYWN0dWFsbHksIGF0IGxlYXN0IGJ5CmRlZmF1bHQgYW5kIHdpdGggYSBtb25zdHJvdXMg
d2FybmluZyB0byBhbnlvbmUgd2hvIHRyaWVzIHRvIGNoYW5nZSB0aGUKZGVmYXVsdCwgY2FwcyBT
SEExIFBDUnMgaWYgU0hBMjU2IGlzIGF2YWlsYWJsZT8gIEFuZCB0aGVuIGNhbiB3ZSBtYXliZQph
bGwgc3RvcCBoYXNzbGluZyB0aGUgcGVvcGxlIHRyeWluZyB0byBkZXZlbG9wIHRoaXMgc2VyaWVz
IGFib3V0IHRoZQpmYWN0IHRoYXQgdGhleSdyZSBkb2luZyB0aGVpciBiZXN0IHdpdGggdGhlIG9i
bm94aW91cyBzeXN0ZW0gdGhhdCB0aGUKVFBNIGRlc2lnbmVycyBnYXZlIHRoZW0/CgpUaGFua3Ms
CkFuZHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

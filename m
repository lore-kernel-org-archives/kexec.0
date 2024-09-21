Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D76ACF9C5B
	for <kexec@archiver.kernel.org>; Sat, 21 Sep 2024 22:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1AyJKwQ0FEY692sHzYxWLlh9fYbg5E7EJUUqIVoycxA=; b=E3nV40MFwuCdqv
	kqq1ZCcPXCKZ+psMHReyZxU7lKOVTuhcGnza+wnKDg7fxkKy2x/YgygG/uA0Y5vdQF+1hSZnjZklq
	03jVDrhu/mU8qaJJROsti2kJlptg6o3X9nRA+YOqCB8TuDw8IvPGnN1+BL1NE1TnqAQ5Ol5fC8JWA
	uIC7eTaSWsrtzlxeh3KaIRJnLWFbb78LoNLj3Y+64Wh3+RTvip4Hy/1bIhc9CoxR65Sw41rCUmpQu
	c1sbyOxN2P32W5BaARexRvD+HzCYKjKkEDIg1azwxhaH00vme1QuHfZACpSEErOhouHQzcBYSxtZh
	xLIljUQ5HTyBMIeVWLow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ss8m1-0000000EN0A-17B3;
	Sat, 21 Sep 2024 22:40:17 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ss8lx-0000000EMzK-42VN
	for kexec@lists.infradead.org;
	Sat, 21 Sep 2024 22:40:15 +0000
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a8d2b24b7a8so767376766b.1
        for <kexec@lists.infradead.org>; Sat, 21 Sep 2024 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1726958412; x=1727563212; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvnFCbAvrKO16MD1V3kSEfcktT7GG58Kq8nfwUeCeG8=;
        b=JrnOUnMKoRREVsbDVkMyOPx4EoOF90kYTrX47nwUXpMS1xI/AQxf2P30Z+7lhWOTDf
         itx4HSEkUCtdKFDqirgQV3o4jNObFKHm2HMu8my5IlaNep1IGpZGq4+aF8m1a3fJKmRe
         DZk21KZUv5gNMHdiAb1ZFcCT4v29ejUYWLsPpEzLPAgIgFI7u2U54bJZfMq6XGIrocd4
         mKhS0sgIsj9xzHdQywCoCWN1wfnGOXWjkeT4Qp10gMiLT9f/4F3QA9aJ8x0Y9tVP9LE9
         1bZujK4QwMX2oNEnWonqlEq9n19MkzexKoEHObKvkh/5nlBtEH/PoFPjBJ6L+hIZViQ8
         2YKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726958412; x=1727563212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvnFCbAvrKO16MD1V3kSEfcktT7GG58Kq8nfwUeCeG8=;
        b=oP23ZaH++sW31+zLetgLgG2Tfurvuf7I8wRhtMm60YOf0sZV1BxRjxllGxx6nCkyI8
         7uWIz523ryvrg82ROtsZO7Z5m1IeIZ/2FsSecTntmRNRrbHRuOtiCNUk+3eeoQygdXjr
         Hp2eJ3nlVlz9ch0N5NcsbFL9rnDIZx25NGRWKSl5GNRWtIXsPNDjrroQ+EUibxAtRvgp
         sIZQY2qIMpeK9pX6TSxi1kUWJXuqomI+yedpihpsTYBVKkEcPyNlSlO5RWed2bFO+Fi4
         ih5M2zV9sZvlhTMntFu+uXmmpKmTEVwrjcr0Gx8D4x/SIYeCZUw01I3+y9JQKo583j0/
         4Eug==
X-Forwarded-Encrypted: i=1; AJvYcCVcIrZJldILrcrVbGE+/WkIrmJ+/2Cd1uf14MI734CX0APT7DKR7jGF2YbwG3ybLj3ao1T0DA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0oaXhGfW9p7vYjO/bbpSuoMNgaCJNjIzgE3t138gz8QOPl/lV
	IATXVuvKwalwwVvxFUrxtp50pil4vU1rpsiHmc1EEDklNOvjyohp3QJGTUZVY8zNMaeZkvo6Wn5
	wMhHoAmtme6rxewjOZ+SobnqojoHeMjyFSyeD
X-Google-Smtp-Source: AGHT+IFaL72COl44ZtDaFEd6ElmKPYw0sykZuhkEsvikJ8ZrALW1TY8Zoa3MjMgvyB4XF620eo77HLnUVANX4vO022w=
X-Received: by 2002:a17:906:730b:b0:a8d:65f4:c7c6 with SMTP id
 a640c23a62f3a-a90c1d6ecabmr1190329166b.24.1726958411374; Sat, 21 Sep 2024
 15:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <1a1f0c41-70de-4f46-b91d-6dc7176893ee@apertussolutions.com>
 <8a0b59a4-a5a2-42ae-bc1c-1ddc8f2aad16@apertussolutions.com>
 <CALCETrX8caT5qvCUu24hQfxUF_wUC2XdGpS2YFP6SR++7FiM3Q@mail.gmail.com> <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
In-Reply-To: <c466ed57-35a8-41c0-9647-c70e588ad1d3@apertussolutions.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 21 Sep 2024 15:40:00 -0700
Message-ID: <CALCETrW9WNNGh1dEPKfQoeU+m5q6_m97d0_bzRkZsv2LxqB_ew@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240921_154014_301432_1786DBD2 
X-CRM114-Status: GOOD (  33.44  )
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

T24gU2F0LCBTZXAgMjEsIDIwMjQgYXQgMTE6MzfigK9BTSBEYW5pZWwgUC4gU21pdGgKPGRwc21p
dGhAYXBlcnR1c3NvbHV0aW9ucy5jb20+IHdyb3RlOgo+Cj4gT24gOS8xMy8yNCAyMzo1NywgQW5k
eSBMdXRvbWlyc2tpIHdyb3RlOgo+ID4gT24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgNTozNOKAr1BN
IERhbmllbCBQLiBTbWl0aAo+ID4gPGRwc21pdGhAYXBlcnR1c3NvbHV0aW9ucy5jb20+IHdyb3Rl
Ogo+ID4+Cgo+ID4gV2hhdCwgZXhhY3RseSwgaXMgeW91ciBwYXRjaHNldCBkb2luZyB0aGF0IHJl
cXVpcmVzIGhhc2hpbmcgYXQgYWxsPwo+ID4gKEkgYXNzdW1lIGl0J3MgZXh0ZW5kaW5nIGEgUENS
IGFuZCBnZW5lcmF0aW5nIGFuIGV2ZW50IGxvZyBlbnRyeS4pLgo+ID4gV2hhdCwgZXhhY3RseSwg
ZG9lcyBpdCBtZWFuIHRvICJjYXAiIGEgUENSPyAgSG93IGlzIHRoaXMgZGlmZmVyZW50Cj4gPiBm
cm9tIHdoYXQgeW91ciBwYXRjaHNldCBkb2VzPwo+Cj4KCi4uLgoKPiBJIGRpZCBub3Qgc2VlIHRo
ZSB0ZXJtIGFjdHVhbGx5IGRlZmluZWQgaW4gdGhlIGNsaWVudCBwcm9maWxlLCBidXQgdGhlCj4g
dGVybSAiY2FwIiByZWZlcnMgdG8gdGhlIHNwZWNpZmljIGFjdGlvbiBvZiBoYXNoaW5nIGEgdmFs
dWUgYWNyb3NzIGEgc2V0Cj4gb2YgUENScy4gVGhpcyBpcyB0byByZWZsZWN0IHRoYXQgY2VydGFp
biBldmVudHMgaGF2ZSBvY2N1cnJlZCBhbmQgd2lsbAo+IHJlc3VsdCBpbiBhIGRpZmZlcmVudCBi
dXQgcHJlZGljdGFibGUgY2hhbmdlIHRvIHRoZSBQQ1IgdmFsdWUuIE9mdGVuCj4gdGltZXMgdGhp
cyBpcyB0byBlbnN1cmUgdGhhdCBpZiB0aGVyZSBhcmUgVFBNIG9iamVjdHMgc2VhbGVkIHRvIHRo
ZQo+IHN5c3RlbSB3aXRoIGVpdGhlciB0aGF0IGV2ZW50IGhhdmluZyBvciBoYXZlIG5vdCBvY2N1
cnJlZCwgdGhleSBjYW5ub3QKPiBiZSB1bnNlYWxlZC4gVGh1cywgb25lIGhhcyAiY2FwcGVkIiB0
aGUgUENScyBhcyBhIG1lYW5zIHRvIGNsb3NlIGFjY2Vzcwo+IHRvIHRoZSDigJxhY2NlcHRhYmxl
4oCdIHN5c3RlbSBzdGF0ZS4KCk9rYXksIHNvIEkgcmVhZCBSb3NzJ3MgZWFybGllciBlbWFpbCBy
YXRoZXIgZGlmZmVyZW50bHk6Cgo+IEV2ZW4gaWYgd2UnZCBwcmVmZXIgdG8gdXNlIFNIQS0yNTYt
b25seSwgaWYgZmlybXdhcmUgZWxlY3RlZCB0byBzdGFydCB1cwo+IHdpdGggdGhlIFNIQS0xIGFu
ZCBTSEEtMjU2IGJhY2tzIGFjdGl2ZSwgd2Ugc3RpbGwgbmVlZCBTSEEtMSB0byBwYXJzZQo+IHRo
ZSBUUE0gZXZlbnQgbG9nIHRodXMgZmFyLCBhbmQgZGVsaWJlcmF0ZWx5IGNhcCB0aGUgU0hBLTEg
UENScyBpbiBvcmRlcgo+IHRvIHNhZmVseSB1c2UgU0hBLTI1NiBmb3IgZXZlcnl0aGluZyBlbHNl
LgoKSSBhc3N1bWVkIHRoYXQgImRlbGliZXJhdGVseSBjYXAiIG1lYW50IHRoYXQgdGhlcmUgd2Fz
IGFuIGFjdHVhbApmZWF0dXJlIHdoZXJlIHlvdSB3cml0ZSBzb21ldGhpbmcgdG8gdGhlIGV2ZW50
IGxvZyAoaWYgYXBwbGljYWJsZSkgYW5kCmV4dGVuZCB0aGUgUENSIGluIGEgc3BlY2lhbCB3YXkg
dGhhdCAqdHVybnMgdGhhdCBQQ1Igb2ZmKi4gIFRoYXQgaXMsCml0IGRvZXMgc29tZXRoaW5nIHN1
Y2ggdGhhdCBsYXRlci1sb2FkZWQgc29mdHdhcmUgKmNhbid0KiB1c2UgdGhhdCBQQ1IKdG8gYXR0
ZXN0IG9yIHVuc2VhbCBhbnl0aGluZywgZXRjLgoKQnV0IGl0IHNvdW5kcyBsaWtlIHlvdSdyZSBz
YXlpbmcgdGhhdCBubyBzdWNoIGZlYXR1cmUgZXhpc3RzLiAgQW5kIGEKcXVpY2sgc2tpbSBvZiB0
aGUgc3BlY3MgZG9lc24ndCBjb21lIHVwIHdpdGggYW55dGhpbmcuICBBbmQgdGhlIFNIQTEKYmFu
a3MgbWF5IHdlbGwgYmUgc3VzY2VwdGlibGUgdG8gYSBjb2xsaXNpb24gYXR0YWNrLgoKU28gd2hh
dCBhcmUgdGhlIGtlcm5lbCdzIGNob2ljZXMgd3J0IHRoZSBTSEEtMSBQQ1JzPyAgSXQgY2FuOgoK
YSkgUGVyZm9ybSBidXNpbmVzcyBhcyB1c3VhbDogZXh0ZW5kIHRoZW0gY29uc2lzdGVudGx5IHdp
dGggdGhlClNIQS0yNTYgUENScy4gIFRoaXMgaXMgc29ydCBvZiAqZmluZSo6IHRoZSBrZXJuZWwg
Y29kZSBpbiBxdWVzdGlvbiBpcwpub3QgcmVseWluZyBvbiB0aGUgc2VjdXJpdHkgb2YgU0hBLTEs
IGJ1dCBpdCBpcyBtYWtpbmcgaXQgcG9zc2libGUgZm9yCmZ1dHVyZSBjb2RlIHRvICh1bndpc2Vs
eSkgcmVseSBvbiB0aGVtLiAgKEFsdGhvdWdoLCBpZiB0aGUga2VybmVsIGlzCmxvYWRpbmcgYSB0
cnVzdHdvcnRoeSBpbml0cmFtZnMsIHRoZW4gdGhlcmUgd29uJ3QgYmUgYSBjb2xsaXNpb24sIGFu
ZAp0aGVyZSBpcyBubyBrbm93biBzZWNvbmQtcHJlaW1hZ2UgYXR0YWNrIGFnYWluc3QgU0hBLTEu
KQoKYikgU2FtZSBhcyAoYSksIGJ1dCB3aXRoIGNvdW50ZXJtZWFzdXJlczogZG8gc29tZXRoaW5n
IHRvIHRoZSBlZmZlY3QKb2YgKmRldGVjdGluZyogdGhlIGF0dGFjayBhIGxhIFNIQTEtREMgYW5k
IHBhbmljIGlmIGFuIGF0dGFjayBpcwpkZXRlY3RlZC4gIE1heWJlIHRoaXMgaXMgd2lzZTsgbWF5
YmUgaXQncyBub3QuCgpjKSBEbyBub3QgZXh0ZW5kIHRoZSBTSEEtMSBQQ1JzIGFuZCBwcmV0ZW5k
IHRoZXkgZG9uJ3QgZXhpc3QuICBUaGlzCnNlZW1zIGxpa2VseSB0byBjYXVzZSBtYXNzaXZlIHNl
Y3VyaXR5IHByb2JsZW1zLCBhbmQgaGF2aW5nIHRoZSBrZXJuZWwKdHJ5IHRvIGRlZmVuZCBpdHMg
YmVoYXZpb3IgYnkgc2F5aW5nICJ3ZSBkb24ndCBzdXBwb3J0IFNIQS0xIC0tIHRoaXMKaXMgYSBw
cm9ibGVtIGRvd25zdHJlYW0iIHNlZW1zIHVud2lzZSB0byBtZS4KCmQpIEV4dGVuZCB0aGVtIGJ1
dCBpbiBhbiB1bmNvbnZlbnRpb25hbCB3YXkgdGhhdCBtYWtlcyB1c2luZyB0aGVtCmV4dHJhIHNl
Y3VyZS4gIEZvciBleGFtcGxlLCBjYWxjdWxhdGUgU0hBLTI1NihuZXh0IHN0YWdlKSwgdGhlbiBl
eHRlbmQKd2l0aCAobmV4dCBzdGFnZSB8fCAiTGludXggdGhpbmtzIHRoaXMgaXMgYmV0dGVyIiB8
fCBTSEEtMjU2KG5leHQKc3RhZ2UpLiAgVGhpcyBtYWtlcyB0aGUgU0hBLTEgYmFua3MgdXNhYmxl
LCBhbmQgaXQgc2VlbXMgbGlrZSBpdCB3aWxsCnByb2JhYmx5IGRlZmVhdCBhbnl0aGluZyByZXNl
bWJsaW5nIGEgY3VycmVudCBhdHRhY2suICBCdXQgbWF5YmUgdGhpcwppcyBzaWxseS4gIEl0IHdv
dWxkIHByb2JhYmx5IHJlcXVpcmUgZG9pbmcgdGhlIHNhbWUgdGhpbmcgdG8gdGhlClNIQS0yNTYg
YmFua3MgZm9yIHRoZSBiZW5lZml0IG9mIGFueSBzb2Z0d2FyZSB0aGF0IGNoZWNrcyB3aGV0aGVy
IHRoZQpTSEEtMSBhbmQgU0hBLTI1NiBiYW5rcyBhcmUgY29uc2lzdGVudCB3aXRoIGVhY2ggb3Ro
ZXIuCgplKSBBY3R1YWxseSB0cnkgdG8gbWFrZSB0aGUgU0hBLTEgUENScyB1bnVzYWJsZS4gIEZv
ciBleGFtcGxlLCBleHRlbmQKdGhlbSB3aXRoIHJhbmRvbSBudW1iZXJzLgoKTXkgaW5jbGluYXRp
b24gaXMgdGhhdCBoYXZpbmcgc29tZSBraW5kIG9mIExpbnV4ICJwb2xpY3kiIHRoYXQgU0hBLTEK
aXMgZm9yYmlkZGVuIGFkZHMgbm8gYWN0dWFsIHNlY3VyaXR5IHZhbHVlLiAgT3B0aW9uIChhKSBo
b25lc3RseSBzZWVtcwpmaW5lLiAgTm90aGluZyBpbiB0aGUga2VybmVsICpyZWxpZXMqIG9uIHRo
ZSBTSEEtMSBoYXNoIGJlaW5nIHNlY3VyZS4KQnV0IG9wdGlvbiAoYikgYWxzbyBzZWVtcyBva2F5
IGlmIHNvbWVvbmUgaXMgd2lsbGluZyB0byBwdXQgdGhlIGVmZm9ydAppbnRvIGltcGxlbWVudGlu
ZyBpdCBhbmQgY3JlYXRpbmcgYSBwcm9wZXIgdGVzdCBjYXNlLgoKQnV0IHRoZSBkZXNjcmlwdGlv
biBvZiBhbGwgdGhpcyBjb3VsZCBjZXJ0YWlubHkgZG8gYSBiZXR0ZXIgam9iIG9mCmV4cGxhaW5p
bmcgd2hhdCdzIGdvaW5nIG9uLgoKLS1BbmR5Cgo+IFsxXSBBIGZ1dHVyZSBleHBhbnNpb24gb2Yg
U2VjdXJlIExhdW5jaCB3aWxsIGJlIHRvIGVuYWJsZSB1c2FnZSBvZgo+IEludGVsJ3MgSGFyZHdh
cmUgU2hpZWxkLCBsaW5rIGJlbG93LCB0byBwcm92aWRlIHJ1bnRpbWUgdHJ1c3R3b3J0aHkKPiBk
ZXRlcm1pbmF0aW9uIG9mIFNNTS4gVGhlIGZ1bGwgZXh0ZW50IG9mIHRoaXMgY2FwYWJpbGl0eSBj
YW4gb25seSBiZQo+IGFjaGlldmVkIHVuZGVyIGEgRFJUTSBsYXVuY2ggb2YgdGhlIHN5c3RlbSB3
aXRoIEludGVsIFRYVC4gV2hlbiBlbmFibGVkLAo+IHRoaXMgY2FuIGJlIHVzZWQgdG8gdmVyaWZ5
IHRoZSBTTU0gcHJvdGVjdGlvbnMgYXJlIGluIHBsYWNlIGFuZCBpbmZvcm0KPiB0aGUga2VybmVs
J3MgbWVtb3J5IG1hbmFnZW1lbnQgd2hpY2ggcmVnaW9ucyBvZiBtZW1vcnkgYXJlIHNhZmUgZnJv
bSBTTU0KPiB0YW1wZXJpbmcuCj4KPiBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC9kYW0v
d3d3L2NlbnRyYWwtbGlicmFyaWVzL3VzL2VuL2RvY3VtZW50cy9kcnRtLWJhc2VkLWNvbXB1dGlu
Zy13aGl0ZXBhcGVyLnBkZgoKV293LiAgSSBza2ltbWVkIHRoaXMgcGFwZXIuICBXaGF0IGFuIG92
ZXJjb21wbGljYXRlZCBzb2x1dGlvbiB0byBhCnByb2JsZW0gdGhhdCBkb2Vzbid0IGRlc2VydmUg
dG8gZXhpc3QgaW4gdGhlIGZpcnN0IHBsYWNlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhl
Ywo=

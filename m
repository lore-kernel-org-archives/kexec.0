Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2270AEED60D
	for <kexec@archiver.kernel.org>; Thu, 12 Sep 2024 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MlNrEA/ANPVdbADXFIx9Ys0JxQMN/WaxkXG1OK2c7DU=; b=MjeL7VYLrIE92A
	8MZ96cABx1tIC+mUNi2gxHLqJUhtXuc2ikYttlm8XGLE6nXo0ETCR7q2xg33IAVMYBGT7cUZ/Wo6t
	dASEauJeqeYMBYUL7IkP9flw7H7wM4b2mWvOwmjJxpy9+mrdLoyrhxCVbNZD7S0DoOL+0TO+8qVb0
	gve/LMLB4dVZByAKhCOjOdKZ/s2R9H+9yynKrP4oMGycAGe9XdD2rootitvMUCBH7oN0KLyv5uQsk
	j+ooaXlnG1++R5InSCJ9YshG/Oq4uPb1iFByAh59RPAnf6XjxtVX+qCF88/kxx34oBKPnU9Thz83u
	5fe7Eg2HTnyJoFx3+inw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokry-0000000DMVh-1W6y;
	Thu, 12 Sep 2024 14:32:26 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sokot-0000000DLqZ-2Q8O
	for kexec@lists.infradead.org;
	Thu, 12 Sep 2024 14:29:16 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so1279676a12.0
        for <kexec@lists.infradead.org>; Thu, 12 Sep 2024 07:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726151353; x=1726756153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ojlwVPNe7KlSzk6swI2y1+uEfsmH3zHy4IiUElclC0=;
        b=Iw7SIzb/rQDcmnEujJ82rd3aNHZ+rrtm6LU46ftOIe/U0ihfNGDLJfaEny63JUJ1K4
         NQPA266p/9zTQiF7dApNRjxx1G9XHyd9Zi2Sd5MTew8BPc1y9I++ZKjwRWSyR1hk9ygd
         bo35je/JHOTV9bxABvsiE//P4/htFaRrWEP8M2hQ7PZOwkFQeVGY1TGGl22IebJNxldt
         3UNgsrr1mHzABBbdN20nJ0uMYq+GyVEC8txSuQa/h1ntQ6AultUbADyyZN4Q3Am1tpa/
         XpOwHzVpecpGiRO6B4iJg895qspzXtJO1pCWxKEmlB6+dRpne3tJnwPGhvwU4fI+sPNB
         AG6w==
X-Forwarded-Encrypted: i=1; AJvYcCULgXI1rPN0u/eJGjcHQgvseMYuUgbfdaXitlkY+gvdDOBCe4RV8jRpUvMxQukFiY+IGeTxhA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzy12SMcW3wfAk3UrMFJTK9uKfIY1DpfX1kjgFfYzkSlUFtgmx6
	UTvE54d6Tfo/SibmoDARrKg4AbQRAOo1NXtvI+9VlX7OE7h3RKuD
X-Google-Smtp-Source: AGHT+IHNDDf/Q8uWvQAGDtFVftOcPwKOzxFnfjPmpTmeeCiD52hd3Vd9S9TsRJFtVvbr7CyIHyR95A==
X-Received: by 2002:a17:907:e21b:b0:a86:842a:104a with SMTP id a640c23a62f3a-a9029636efbmr290362266b.57.1726151352792;
        Thu, 12 Sep 2024 07:29:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65c8asm754656466b.215.2024.09.12.07.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 07:29:12 -0700 (PDT)
Date: Thu, 12 Sep 2024 07:29:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Usama Arif <usamaarif642@gmail.com>, linux-efi@vger.kernel.org,
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com,
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com,
	gourry@gourry.net
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in
 820_table_firmware
Message-ID: <20240912-sapphire-koala-of-focus-918cff@leitao>
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com>
 <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao>
 <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_072915_641382_00B09945 
X-CRM114-Status: GOOD (  26.68  )
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

T24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgMDM6MTA6NDNQTSArMDIwMCwgQXJkIEJpZXNoZXV2ZWwg
d3JvdGU6Cj4gT24gVGh1LCAxMiBTZXB0IDIwMjQgYXQgMTU6MDMsIEJyZW5vIExlaXRhbyA8bGVp
dGFvQGRlYmlhbi5vcmc+IHdyb3RlOgo+ID4gT24gVGh1LCBTZXAgMTIsIDIwMjQgYXQgMTI6NTE6
NTdQTSArMDIwMCwgQXJkIEJpZXNoZXV2ZWwgd3JvdGU6Cj4gPiA+IEkgZG9uJ3Qgc2VlIGhvdyB0
aGlzIGNvdWxkIGJlIGFuIEVGSSBidWcsIGdpdmVuIHRoYXQgaXQgZG9lcyBub3QgZGVhbAo+ID4g
PiB3aXRoIEU4MjAgdGFibGVzIGF0IGFsbC4KPiA+Cj4gPiBJIHdhbnQgdG8gYmFjayB1cCBhIGxp
dHRsZSBiaXQgYW5kIG1ha2Ugc3VyZSBJIGFtIGZvbGxvd2luZyB0aGUKPiA+IGRpc2N1c3Npb24u
Cj4gPgo+ID4gRnJvbSB3aGF0IEkgdW5kZXJzdGFuZCBmcm9tIHByZXZpb3VzIGRpc2N1c3Npb24s
IHdlIGhhdmUgYW4gRUZJIGJ1ZyBhcwo+ID4gdGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBpc3N1ZS4K
PiA+Cj4gPiBUaGlzIGhhcHBlbnMgYmVjYXVzZSB0aGUgRUZJIGRvZXMgTk9UIG1hcmsgdGhlIEVG
SSBUUE0gZXZlbnQgbG9nIG1lbW9yeQo+ID4gcmVnaW9uIGFzIHJlc2VydmVkIChFRklfUkVTRVJW
RURfVFlQRSkuCj4gCj4gV2h5IGRvIHlvdSB0aGluayBFRkkgc2hvdWxkIHVzZSBFRklfUkVTRVJW
RURfVFlQRSBpbiB0aGlzIGNhc2U/Cj4gCj4gVGhlIEVGSSBzcGVjIGlzIHZlcnkgY2xlYXIgdGhh
dCBFRklfUkVTRVJWRURfVFlQRSByZWFsbHkgc2hvdWxkbid0IGJlCj4gdXNlZCBmb3IgYW55dGhp
bmcgYnkgRUZJIGl0c2VsZi4gSXQgaXMgcXVpdGUgY29tbW9uIGZvciBFRkkKPiBjb25maWd1cmF0
aW9uIHRhYmxlcyB0byBiZSBwYXNzZWQgYXMgRWZpUnVudGltZVNlcnZpY2VzRGF0YSAoU01CSU9T
KSwKPiBFZmlCb290U2VydmljZXNEYXRhIChFU1JUKSBvciBFRmlBY3BpUmVjbGFpbSAoQUNQSSB0
YWJsZXMpLgo+IAo+IFJlc2VydmVkIG1lbW9yeSBpcyBtb3N0bHkgZm9yIG1lbW9yeSB0aGF0IGV2
ZW4gdGhlIGZpcm13YXJlIGRvZXMgbm90Cj4ga25vdyB3aGF0IGl0IGlzIGZvciwgaS5lLiwgcGFy
dGljdWxhciBwbGF0Zm9ybSBzcGVjaWZpYyB1c2VzLgo+IAo+IEluIGdlbmVyYWwsIGl0IGlzIHVw
IHRvIHRoZSBPUyB0byBlbnN1cmUgdGhhdCBFRkkgY29uZmlndXJhdGlvbiB0YWJsZXMKPiB0aGF0
IGl0IGNhcmVzIGFib3V0IHNob3VsZCBiZSByZXNlcnZlZCBpbiB0aGUgY29ycmVjdCB3YXkuCgpU
aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4KClNvLCBpZiBJIHVuZGVyc3RhbmQgd2hhdCB5b3Ug
bWVhbnQgaGVyZSwgdGhlIFRQTSBldmVudCBsb2cgbWVtb3J5IHJhbmdlCnNob3VsZG4ndCBiZSBs
aXN0ZWQgYXMgYSBtZW1vcnkgcmVnaW9uIGluIEVGSSBtZW1vcnkgbWFwIChhcyBwYXNzZWQgYnkK
dGhlIGZpcm13YXJlIHRvIHRoZSBPUykuCgpIZW5jZSwgdGhpcyBpcyBub3QgYSBFRkkgZmlybXdh
cmUgYnVnLCBidXQgYSBPUy9LZXJuZWwgYnVnLgoKQW0gSSBjb3JyZWN0IHdpdGggdGhlIHN0YXRl
bWVudHMgYWJvdmU/CgpBbm90aGVyIHF1ZXN0aW9uLCBsb29raW5nIGF0IHRoZSBTcGVjWzFdIGl0
IHNheXM6CgoJSWYgdGhlIEFDUEkgVFBNMiB0YWJsZSBjb250YWlucyB0aGUgYWRkcmVzcyBhbmQg
c2l6ZSBvZiB0aGUgUGxhdGZvcm0gRmlybXdhcmUgVENHIGxvZywKCWZpcm13YXJlIOKAnHBpbnPi
gJ0gdGhlIG1lbW9yeSBhc3NvY2lhdGVkIHdpdGggdGhlIFBsYXRmb3JtIEZpcm13YXJlIFRDRyBs
b2csIGFuZCByZXBvcnRzCgl0aGlzIG1lbW9yeSBhcyDigJxSZXNlcnZlZOKAnSBtZW1vcnkgdmlh
IHRoZSBJTlQgMTVoL0U4MjAgaW50ZXJmYWNlCgoKV2hhdCBpcyB0aGUgJ2Zpcm13YXJlJyBpbiB0
aGUgc3RhdGVtZW50IGFib3ZlLCB0aGF0IHNheXMgdGhhdCByZXBvcnRzCnRoZSBtZW1vcnkgYXMg
cmVzZXJ2ZWQ/IChJcyBpdCBsaWJzdHViPyEpCgpUaGFuayB5b3Ugc28gbXVjaCBmb3IgZ3VpZGlu
ZyB1cyBoZXJlLAotLWJyZW5vCgpbMV0gaHR0cHM6Ly90cnVzdGVkY29tcHV0aW5nZ3JvdXAub3Jn
L3dwLWNvbnRlbnQvdXBsb2Fkcy9QQy1DbGllbnRQbGF0Zm9ybV9Qcm9maWxlX2Zvcl9UUE1fMnAw
X1N5c3RlbXNfdjQ5XzE2MTExNF9wdWJsaWMtcmV2aWV3LnBkZgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

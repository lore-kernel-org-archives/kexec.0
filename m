Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6839DCA0EE5
	for <kexec@archiver.kernel.org>; Fri, 30 Aug 2024 06:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AboJ+/lL5u3hhf0fNacXa1V7dDK+ksce49ihWKKkre8=; b=bwfRnhd1/HMZG5
	LMSX7S3S8NOxoUjpsbMsvwDCbxK22MzA/0Qno7pij4jgsqAJeT0FRAZrfMCKVYmwf4T7FnhZ0N55B
	i88NRbhr/YnEUGL1jkAOycn0r3xMm25fQizziTKb0+PXV1vgEMLkV/lcX5m9NV5aFs1oQtuR10Pmc
	hXye+SLIxZiTYyYl5zSmFcdRtywSxF+EVjAk8/lyRCn2HXU6RDmGWIJoveYA35q3QqKz8s7vnFQKg
	rZJ7SENJ819kjPadCLCSE8uzjCA4Z4x969Q83TjtzZeXt6bxAZDiSuIpYyJz65d6Xn5Cz04pg2Mjn
	YDhJzDRxpvje6DmhEsRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjvKg-00000004zG4-3xpF;
	Fri, 30 Aug 2024 06:42:06 +0000
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjvKd-00000004zFD-2Gzj
	for kexec@lists.infradead.org;
	Fri, 30 Aug 2024 06:42:05 +0000
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5340A3FB75
	for <kexec@lists.infradead.org>; Fri, 30 Aug 2024 06:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725000118;
	bh=stViVxHrBBEsBOu5+lfKdQqL1kmTozBEiuazG7uCPrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=jToRsgt8kmwgg4RG5Z47b3XeucXhnKLSs8NRhNR7f5Kd76fp4pJygRAwE9iVq3Rj0
	 +HXzJmqqfx+Gnex1C9ZhiNhNteMYuWoVhxlBUA9S9IWlyztHZXB1P/3ahPm5ye5COi
	 BYeJIYWE5yn+QbdGCtmzjsvhJbuYQoIHnsQvwZQBnpmfHxM6L0+pZBONlBhDEE7hUV
	 J/48MnHz6X4ipgk/nxjJsdEKy0dJuetYF4L0bj1EotClI+9lkHffsBF0d4APq+FYG2
	 epj5ux1861BTYeF5lEhz7hO/BuwLvN7p+VkXDt/Nvu3X6mv69Q9MhLKtHz6R1oJMlU
	 fl5w8l+/bjkvA==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7cd96715e6aso1514972a12.2
        for <kexec@lists.infradead.org>; Thu, 29 Aug 2024 23:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000116; x=1725604916;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stViVxHrBBEsBOu5+lfKdQqL1kmTozBEiuazG7uCPrc=;
        b=NJqbJECYy/VedxKvy9ROj8Ul2BpD0g5nAlY17Tki6EEIaoivagLIFMgFJDMQrbFy8/
         6WBe8ViVsQz6Nl6Ij6ErRzyzaNgBVkqk4946z9043eVdcZaW8/wMgXgzW4pjcTBiOtp3
         PUGQ0FcNBbb9mhcY9g7sloqSA5r790pN26vRGciFUbEAsz460xZLplBft74ylYs815FV
         p6o2Z8iHAx1xOQXy0w5TKImN0vQmINMxEjr76tMOUntoXmHt3fXR+cZRVYmbA21MNx3H
         qJjdDV4nGphpKxGkinQHpaBuvyPvQjpXx4Vhn3sykE1C3a7pp/S5YplEfQc17lLTwdRC
         vDpw==
X-Forwarded-Encrypted: i=1; AJvYcCU03FaD9T73Lq1ImUIcBsuYMY1595sV2t9J81i5CAwtacGdA1mv22iK+LG9ld7xZvTvdtWU5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YzU3bAM65O7ZWIatsrXWEHwsYGDC3yNVMoKMFN4EKCHOy/dvwbF
	DjhPAOfYsRrBkBUCSrEVkeFgXbr6WwoCjWlrkfcQo66tmVXcdIuu2a9gNDpvDvsatx42zV66e0Y
	ko2zVxhyyLnAa++ImFSuxZRxrN98uns/vUwUgO+zsktzXeya55K2WGio7Jxf0LxpNF6dxqicwDA
	==
X-Received: by 2002:a05:6a21:1304:b0:1cc:ecfc:4e19 with SMTP id adf61e73a8af0-1ccecfc5080mr2120877637.21.1725000116139;
        Thu, 29 Aug 2024 23:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaXyUn2dop9Ka0x8wrhn0wVdTWTZjUwZ/SlkcBN7yWlQ1nrIciaeWRmtziG4HoZZ26ik1ehQ==
X-Received: by 2002:a05:6a21:1304:b0:1cc:ecfc:4e19 with SMTP id adf61e73a8af0-1ccecfc5080mr2120843637.21.1725000115369;
        Thu, 29 Aug 2024 23:41:55 -0700 (PDT)
Received: from kylee-ThinkPad-E16-Gen-1 ([122.147.171.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051556a712sm20796435ad.307.2024.08.29.23.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 23:41:55 -0700 (PDT)
Date: Fri, 30 Aug 2024 14:41:49 +0800
From: Kuan-Ying Lee <kuan-ying.lee@canonical.com>
To: lijiang <lijiang@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Will Deacon <will@kernel.org>,
	HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	ardb@kernel.org
Subject: Re: [PATCH] arm64/vmcore: Add pgtable_l5_enabled information in
 vmcoreinfo
Message-ID: <ZtFprQX-UzyqnKTH@kylee-ThinkPad-E16-Gen-1>
References: <20240826065219.305963-1-kuan-ying.lee@canonical.com>
 <20240827122459.GA4679@willie-the-truck>
 <Zs5Xo5eVUvGMbtSv@MiWiFi-R3L-srv>
 <CANU+ZydbFPiSnCRr3qQ52GjUQQmU3ZO62c6hRkoLM147+u5u8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANU+ZydbFPiSnCRr3qQ52GjUQQmU3ZO62c6hRkoLM147+u5u8w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_234204_061734_FC9419E9 
X-CRM114-Status: GOOD (  24.75  )
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

T24gV2VkLCBBdWcgMjgsIDIwMjQgYXQgMDU6Mzc6MDdQTSArMDgwMCwgbGlqaWFuZyB3cm90ZToK
PiBPbiBXZWQsIEF1ZyAyOCwgMjAyNCBhdCA2OjQ44oCvQU0gQmFvcXVhbiBIZSA8YmhlQHJlZGhh
dC5jb20+IHdyb3RlOgo+IAo+ID4gT24gMDgvMjcvMjQgYXQgMDE6MjRwbSwgV2lsbCBEZWFjb24g
d3JvdGU6Cj4gPiA+IE9uIE1vbiwgQXVnIDI2LCAyMDI0IGF0IDAyOjUyOjAyUE0gKzA4MDAsIEt1
YW4tWWluZyBMZWUgd3JvdGU6Cj4gPiA+ID4gU2luY2UgYXJtNjQgc3VwcG9ydHMgNS1sZXZlbCBw
YWdlIHRhYmxlcywgd2UgbmVlZCB0byBhZGQgdGhpcwo+ID4gPiA+IGluZm9ybWF0aW9uIHRvIHZt
Y29yZWluZm8gdG8gbWFrZSBkZWJ1ZyB0b29scyBrbm93IGlmIDUtbGV2ZWwKPiA+ID4gPiBwYWdl
IHRhYmxlIGlzIGVuYWJsZWQgb3Igbm90Lgo+ID4gPiA+Cj4gPiA+ID4gTWlzc2luZyB0aGlzIGlu
Zm9ybWF0aW9uIHdpbGwgYnJlYWsgdGhlIGRlYnVnIHRvb2wgbGlrZSBjcmFzaCBbMV0uCgpTb3Jy
eSwgdGhlIGFib3ZlIGxpbmUgd2FzIG1pc3Rha2VubHkgZXhwcmVzc2VkLgoKQ3VycmVudGx5LCB0
aGUgY3Jhc2ggdG9vbCBkb2Vzbid0IHN1cHBvcnQgNEsgcGFnZSB3aXRoIDUtbGV2ZWwKcGFnZSB0
YWJsZXMgKExQQTIpLCBzbyBJIGluaXRpYWxseSBwbGFubmVkIHRvIGFkZCB0aGlzCmluZm9ybWF0
aW9uIHRvIGltcGxlbWVudCBzdXBwb3J0IGZvciA0SyBwYWdlIHdpdGggNS1sZXZlbCBwYWdlCnRh
YmxlIGluIHRoZSBjcmFzaCB0b29sLgoKPiA+ID4gPgo+ID4gPiA+IFsxXSBodHRwczovL2dpdGh1
Yi5jb20vY3Jhc2gtdXRpbGl0eS9jcmFzaAo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
S3Vhbi1ZaW5nIExlZSA8a3Vhbi15aW5nLmxlZUBjYW5vbmljYWwuY29tPgo+ID4gPiA+IC0tLQo+
ID4gPiA+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0IHwg
NiArKysrKysKPiA+ID4gPiAgYXJjaC9hcm02NC9rZXJuZWwvdm1jb3JlX2luZm8uYyAgICAgICAg
ICAgICAgICB8IDMgKysrCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCsp
Cj4gPiA+Cj4gPiA+IEluIHdoaWNoIGNhc2UsIHdvdWxkbid0IHlvdSBhbHNvIHdhbnQgdG8ga25v
dyBhYm91dCBwZ3RhYmxlX2w0X2VuYWJsZWQoKT8KPiA+Cj4gPiBUaGF0IGlzIGEgZ29vZCBxdWVz
dGlvbi4gSSBndWVzcyBpdCdzIGRlZHVjZWQgaW4gY29kZSwgbW9zdGx5IG5lZWRlZCBmb3IKPiA+
IGRpZmZlcmVudCBQQUdFX09GRlNFVCwgaG93IHRvIHRyYW5zZmVyIHZpcnR1YWwgYWRkciB0byBw
aHlzaWNhbCBhZGRyLAo+ID4gZXRjLgo+ID4KPiA+Cj4gVGhhbmtzIGZvciB0aGUgaW5mb3JtYXRp
b24sIEJhb3F1YW4uCj4gCj4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgZm9yIGFybTY0LCBj
dXJyZW50bHksIHRoZSBjcmFzaCB0b29sIGRldGVybWluZXMKPiB0aGUgbGV2ZWxzIG9mIHRoZSBw
YWdlIHRhYmxlIGJhc2VkIG9uIHBhZ2Ugc2l6ZSBhbmQgdmFfYml0cywgYW5kIHRoZW4KPiBkZWNp
ZGVzIGhvdyB0byB0cmFuc2xhdGUgdGhlIGFkZHJlc3MsIHN1Y2ggYXMgY2FsY3VsYXRpbmcgaXQg
aW4gY29uanVuY3Rpb24KPiB3aXRoIG90aGVyIHZhbHVlcywgZS5nOiBrZXJuZWwgcGdkLCBvZmZz
ZXQsIGV0Yy4KClRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uLiBJIHdpbGwgdGhlbiB0cnkgdG8g
dXNlIFZBX0JJVFMgdG8gZGV0ZXJtaW5lCmlmIGl0IGlzIGEgNS1sZXZlbCBwYWdlIHRhYmxlLgpM
ZXQgbWUgaW52ZXN0aWdhdGUgZnVydGhlci4KClRoYW5rcywKS3Vhbi1ZaW5nIExlZQoKPiAKPiBG
b3IgbW9yZSBkZXRhaWxzLCBwbGVhc2UgcmVmZXIgdG8gdGhpcyBvbmU6Cj4gaHR0cHM6Ly9naXRo
dWIuY29tL2NyYXNoLXV0aWxpdHkvY3Jhc2gvYmxvYi9tYXN0ZXIvYXJtNjQuYwo+IAo+IAo+IFRo
YW5rcwo+IExpYW5ibwo+IAo+IAo+ID4gQWRkIENyYXNoIHV0aWxpdHkgZXhwZXJ0cyBoZXJlLgo+
ID4KPiA+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F341C47258
	for <kexec@archiver.kernel.org>; Wed, 17 Jan 2024 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DsN/Bazpx2ajrk8xq6bklQnbFd4s+ov6wPhPHWsgM/c=; b=sLN5wsS6NL6MnB
	ZoqmAwTSphWmG3HMRBQ+eIBn//DKFqH5cuDRZGGOZegGKZNXzFNMRpuTW5874YQavHAIWm++6+uvF
	s1Gv6zGZCs/neGCE2N+h4G/W20Zs01hpl81cvy7h6/IzevIXpN4rqu9/JZE3cEHUSHIuAsFj/nx0P
	HZSx/7V+7/ZYqgTHgxgRRa4Byf9YLGjdoHxVEiZmwu9cOr4cn2OuHVPNjPnnRo+Bw2vsra9ccUp6G
	g+rirx/jf4E5tm374lpMgxhAS3EaR32bsw8sQWnjStpm+aFeZQuMuqpzisbde3mSWYkO42aLpdsnW
	aKZgKyQVtz/Zalb/irvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9CT-0009SA-1L;
	Wed, 17 Jan 2024 16:55:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ9CM-0009RT-0E;
	Wed, 17 Jan 2024 16:55:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 21A416166F;
	Wed, 17 Jan 2024 16:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34E8C43609;
	Wed, 17 Jan 2024 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705510497;
	bh=icda5nsBxvN2zQNuUU8kfCVX7lRfPCzR7ERj2A/6N3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RDEL+tAQiDrYDr+k2xTfms4oEQr9XgsKC5vawe89f6tpAZWWoNmBtps93TrYJqQek
	 3bKmLBnV99czurDhu/ihnOg362ETeHvOrSW+EiElOkLBhQmavBqO9DYaXDzF8VnBty
	 23GrfO8YV1Wy29k52RqUvmdxWWLfAhwv+v/US8vSNiXJU0p4UsjrVZAmOw3wLH+W2h
	 jdKuWcDvUTENMvP/2pS+SPVZLzfnbeFZYcFEVRD5EJh+pzXfMlXHb0g3w0Dtr9ox5w
	 JQRw9QiBq41GX7SWHEV9LHBrA6KvbRMwY8zZm6apDkbkMMWc3E1y4KOa1VVxhLNbMW
	 piwwQ4rJTi9rA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so141483581fa.0;
        Wed, 17 Jan 2024 08:54:57 -0800 (PST)
X-Gm-Message-State: AOJu0YxfmQ+ybaI3ixx5PYGF6NWhoQ1TIg1Iw4By26l30CctG8/pP8Xt
	RjXHZSFks4CR6ld/qYngARTVku/y+Bez5hmjHg==
X-Google-Smtp-Source: AGHT+IE1jgfkJTBfpZ+F4Qzd8uKAwaxoFhnJYLyCjbq9zXmhEnH+sTN071x2CqqdMwDg1wusyGKF4SkodcMKgVdt/Us=
X-Received: by 2002:a2e:bd02:0:b0:2cc:d864:1260 with SMTP id
 n2-20020a2ebd02000000b002ccd8641260mr5936076ljq.62.1705510496033; Wed, 17 Jan
 2024 08:54:56 -0800 (PST)
MIME-Version: 1.0
References: <20231222193607.15474-1-graf@amazon.com> <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-2-graf@amazon.com> <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
 <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
In-Reply-To: <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 17 Jan 2024 10:54:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
Message-ID: <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
To: Alexander Graf <graf@amazon.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, x86@kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	James Gowans <jgowans@amazon.com>, 
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, 
	madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, 
	Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_085530_222912_B7F46973 
X-CRM114-Status: GOOD (  43.01  )
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

T24gV2VkLCBKYW4gMTcsIDIwMjQgYXQgODowMuKAr0FNIEFsZXhhbmRlciBHcmFmIDxncmFmQGFt
YXpvbi5jb20+IHdyb3RlOgo+Cj4KPiBPbiAwMy4wMS4yNCAxOTo0OCwgUm9iIEhlcnJpbmcgd3Jv
dGU6Cj4gPgo+ID4gT24gRnJpLCBEZWMgMjIsIDIwMjMgYXQgMTI6NTLigK9QTSBBbGV4YW5kZXIg
R3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3cm90ZToKPiA+PiBXaXRoIEtITyBpbiBwbGFjZSwgbGV0
J3MgYWRkIGRvY3VtZW50YXRpb24gdGhhdCBkZXNjcmliZXMgd2hhdCBpdCBpcyBhbmQKPiA+PiBo
b3cgdG8gdXNlIGl0Lgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEdyYWYgPGdy
YWZAYW1hem9uLmNvbT4KPiA+PiAtLS0KPiA+PiAgIERvY3VtZW50YXRpb24va2hvL2NvbmNlcHRz
LnJzdCAgIHwgODggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiA+PiAgIERvY3Vt
ZW50YXRpb24va2hvL2luZGV4LnJzdCAgICAgIHwgMTkgKysrKysrKwo+ID4+ICAgRG9jdW1lbnRh
dGlvbi9raG8vdXNhZ2UucnN0ICAgICAgfCA1NyArKysrKysrKysrKysrKysrKysrKysKPiA+PiAg
IERvY3VtZW50YXRpb24vc3Vic3lzdGVtLWFwaXMucnN0IHwgIDEgKwo+ID4+ICAgNCBmaWxlcyBj
aGFuZ2VkLCAxNjUgaW5zZXJ0aW9ucygrKQo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24va2hvL2NvbmNlcHRzLnJzdAo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24va2hvL2luZGV4LnJzdAo+ID4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24va2hvL3VzYWdlLnJzdAo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
a2hvL2NvbmNlcHRzLnJzdCBiL0RvY3VtZW50YXRpb24va2hvL2NvbmNlcHRzLnJzdAo+ID4+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZTRmZThjNTc4NjUK
PiA+PiAtLS0gL2Rldi9udWxsCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9raG8vY29uY2VwdHMu
cnN0Cj4gPj4gQEAgLTAsMCArMSw4OCBAQAo+ID4+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMC1vci1sYXRlcgo+ID4+ICsKPiA+PiArPT09PT09PT09PT09PT09PT09PT09PT0K
PiA+PiArS2V4ZWMgSGFuZG92ZXIgQ29uY2VwdHMKPiA+PiArPT09PT09PT09PT09PT09PT09PT09
PT0KPiA+PiArCj4gPj4gK0tleGVjIEhhbmRPdmVyIChLSE8pIGlzIGEgbWVjaGFuaXNtIHRoYXQg
YWxsb3dzIExpbnV4IHRvIHByZXNlcnZlIHN0YXRlIC0KPiA+PiArYXJiaXRyYXJ5IHByb3BlcnRp
ZXMgYXMgd2VsbCBhcyBtZW1vcnkgbG9jYXRpb25zIC0gYWNyb3NzIGtleGVjLgo+ID4+ICsKPiA+
PiArSXQgaW50cm9kdWNlcyBtdWx0aXBsZSBjb25jZXB0czoKPiA+PiArCj4gPj4gK0tITyBEZXZp
Y2UgVHJlZQo+ID4+ICstLS0tLS0tLS0tLS0tLS0KPiA+PiArCj4gPj4gK0V2ZXJ5IEtITyBrZXhl
YyBjYXJyaWVzIGEgS0hPIHNwZWNpZmljIGZsYXR0ZW5lZCBkZXZpY2UgdHJlZSBibG9iIHRoYXQK
PiA+PiArZGVzY3JpYmVzIHRoZSBzdGF0ZSBvZiB0aGUgc3lzdGVtLiBEZXZpY2UgZHJpdmVycyBj
YW4gcmVnaXN0ZXIgdG8gS0hPIHRvCj4gPj4gK3NlcmlhbGl6ZSB0aGVpciBzdGF0ZSBiZWZvcmUg
a2V4ZWMuIEFmdGVyIEtITywgZGV2aWNlIGRyaXZlcnMgY2FuIHJlYWQKPiA+PiArdGhlIGRldmlj
ZSB0cmVlIGFuZCBleHRyYWN0IHByZXZpb3VzIHN0YXRlLgoKQ2FuIHlvdSBhdm9pZCBjYWxsaW5n
IGFueXRoaW5nICJkZXZpY2UgdHJlZSIgYXMgbXVjaCBhcyBwb3NzaWJsZS4gV2UKY2FuJ3QgYXZv
aWQgdGhlIGZvcm1hdCBpcyBGRFQvRFRCLCBidXQgb3RoZXJ3aXNlIG5vbmUgb2YgdGhpcyBpcwpE
ZXZpY2V0cmVlIGFzIG1vc3QgZm9sa3Mga25vdyBpdC4gU3VyZSwgdGhlcmUgY2FuIGJlIHRyZWVz
IG9mIGRldmljZXMKd2hpY2ggYXJlIG5vdCBEZXZpY2V0cmVlLCBidXQgdGhpcyBpcyBuZWl0aGVy
LiBZb3UgY291bGQgaGF2ZSB1c2VkCkJTT04gb3IgYW55IGhpZXJhcmNoaWNhbCBrZXktdmFsdWUg
cGFpciBzZXJpYWxpemF0aW9uIGZvcm1hdCBqdXN0IGFzCmVhc2lseSAoaWYgd2UgYWxyZWFkeSBo
YWQgYSBwYXJzZXIgaW4gdGhlIGtlcm5lbCkuCgo+ID4gSG93IGRvZXMgdGhpcyB3b3JrIHdpdGgg
a2V4ZWMgd2hlbiB0aGVyZSBpcyBhbHNvIHRoZSBGRFQgZm9yIHRoZSBoL3c/Cj4gPiBUaGUgaC93
IEZEVCBoYXMgYSAvY2hvc2VuIHByb3BlcnR5IHBvaW50aW5nIHRvIHRoaXMgRkRUIGJsb2I/Cj4K
Pgo+IFllcCwgZXhhY3RseS4KClRob3NlIHByb3BlcnRpZXMgbmVlZCB0byBiZSBkb2N1bWVudGVk
IGhlcmVbMV0uCgpbLi4uXQoKPiA+PiArS0hPIGludHJvZHVjZXMgYSBuZXcgY29uY2VwdCB0byBp
dHMgZGV2aWNlIHRyZWU6IGBgbWVtYGAgcHJvcGVydGllcy4gQQo+ID4+ICtgYG1lbWBgIHByb3Bl
cnR5IGNhbiBpbnNpZGUgYW55IHN1Ym5vZGUgaW4gdGhlIGRldmljZSB0cmVlLiBXaGVuIHByZXNl
bnQsCj4gPj4gK2l0IGNvbnRhaW5zIGFuIGFycmF5IG9mIHBoeXNpY2FsIG1lbW9yeSByYW5nZXMg
dGhhdCB0aGUgbmV3IGtlcm5lbCBtdXN0IG1hcmsKPiA+PiArYXMgcmVzZXJ2ZWQgb24gYm9vdC4g
SXQgaXMgcmVjb21tZW5kZWQsIGJ1dCBub3QgcmVxdWlyZWQsIHRvIG1ha2UgdGhlc2UgcmFuZ2Vz
Cj4gPj4gK2FzIHBoeXNpY2FsbHkgY29udGlndW91cyBhcyBwb3NzaWJsZSB0byByZWR1Y2UgdGhl
IG51bWJlciBvZiBhcnJheSBlbGVtZW50cyA6Ogo+ID4+ICsKPiA+PiArICAgIHN0cnVjdCBraG9f
bWVtIHsKPiA+PiArICAgICAgICAgICAgX191NjQgYWRkcjsKPiA+PiArICAgICAgICAgICAgX191
NjQgbGVuOwo+ID4+ICsgICAgfTsKPiA+PiArCj4gPj4gK0FmdGVyIGJvb3QsIGRyaXZlcnMgY2Fu
IGNhbGwgdGhlIGtobyBzdWJzeXN0ZW0gdG8gdHJhbnNmZXIgb3duZXJzaGlwIG9mIG1lbW9yeQo+
ID4+ICt0aGF0IHdhcyByZXNlcnZlZCB2aWEgYSBgYG1lbWBgIHByb3BlcnR5IHRvIHRoZW1zZWx2
ZXMgdG8gY29udGludWUgdXNpbmcgbWVtb3J5Cj4gPj4gK2Zyb20gdGhlIHByZXZpb3VzIGV4ZWN1
dGlvbi4KPiA+PiArCj4gPj4gK1RoZSBLSE8gZGV2aWNlIHRyZWUgZm9sbG93cyB0aGUgaW4tTGlu
dXggc2NoZW1hIHJlcXVpcmVtZW50cy4gQW55IGVsZW1lbnQgaW4KPiA+PiArdGhlIGRldmljZSB0
cmVlIGlzIGRvY3VtZW50ZWQgdmlhIGRldmljZSB0cmVlIHNjaGVtYSB5YW1scyB0aGF0IGV4cGxh
aW4gd2hhdAo+ID4+ICtkYXRhIGdldHMgdHJhbnNmZXJyZWQuCj4gPiBJZiB0aGlzIGlzIGFsbCBz
ZXBhcmF0ZSwgdGhlbiBJIHRoaW5rIHRoZSBzY2hlbWFzIHNob3VsZCBiZSB0b28uIEFuZAo+ID4g
dGhlbiBmcm9tIG15IChEVCBtYWludGFpbmVyKSBwZXJzcGVjdGl2ZSwgeW91IGNhbiBkbyB3aGF0
ZXZlciB5b3Ugd2FudAo+ID4gaGVyZSAobGlrZSBGSVQgaW1hZ2VzKS4gVGhlIGR0c2NoZW1hIHRv
b2xzIGFyZSBwcmV0dHkgbXVjaCBvbmx5IGdlYXJlZAo+ID4gZm9yICJub3JtYWwiIERUcy4gQSBj
b3VwbGUgb2YgcHJvYmxlbXMgY29tZSB0byBtaW5kLiBZb3UgY2FuJ3QgZXhjbHVkZQo+ID4gb3Ig
Y2hhbmdlIHN0YW5kYXJkIHByb3BlcnRpZXMuIFRoZSBkZWNvZGluZyBvZiB0aGUgRFRCIHRvIHJ1
bgo+ID4gdmFsaWRhdGlvbiBhc3N1bWVzIGJpZyBlbmRpYW4uIFdlIGNvdWxkIHByb2JhYmx5IHNw
bGl0IHRoaW5ncyB1cCBhCj4gPiBiaXQsIGJ1dCB5b3UgbWF5IGJlIGJldHRlciBvZmYganVzdCB1
c2luZyBqc29uc2NoZW1hIGRpcmVjdGx5LiBJJ20gbm90Cj4gPiBldmVuIHN1cmUgcnVubmluZyB2
YWxpZGF0aW9uIGhlcmUgd291bGQgdGhhdCB2YWx1YWJsZS4gWW91IGhhdmUgMQo+ID4gc291cmNl
IG9mIGNvZGUgZ2VuZXJhdGluZyB0aGUgRFQgYW5kIDEgY29uc3VtZXIuIFllcywgdGhlcmUncwo+
ID4gZGlmZmVyZW50IGtlcm5lbCB2ZXJzaW9ucyB0byBkZWFsIHdpdGgsIGJ1dCBpdCdzIG5vdCAx
MDBzIG9mIHBlb3BsZQo+ID4gY3JlYXRpbmcgMTAwMHMgb2YgRFRzIHdpdGggMTAwcyBvZiBub2Rl
cy4KPiA+Cj4gPiBZb3UgbWlnaHQgbG9vayBhdCB0aGUgbmV0bGluayBzdHVmZiB3aGljaCBpcyB1
c2luZyBpdHMgb3duIHlhbWwgc3ludGF4Cj4gPiB0byBnZW5lcmF0ZSBjb2RlIGFuZCBqc29uc2No
ZW1hIGlzIHVzZWQgdG8gdmFsaWRhdGUgdGhlIHlhbWwuCj4KPgo+IEknbSBjdXJyZW50bHkgYSBs
b3QgbW9yZSBpbnRlcmVzdGVkIGluIHRoZSBkb2N1bWVudGF0aW9uIGFzcGVjdCB0aGFuIGluCj4g
dGhlIHZhbGlkYXRpb24sIHllYWguIFNvIEkgdGhpbmsgZm9yIHYzLCBJJ2xsIGp1c3QgdGhyb3cg
dGhlIHNjaGVtYXMKPiBpbnRvIHRoZSBEb2N1bWVudGF0aW9uL2tobyBkaXJlY3Rvcnkgd2l0aG91
dCBhbnkgdmFsaWRhdGlvbi4gV2UgY2FuCj4gd29ycnkgYWJvdXQgdGhhdCBsYXRlciA6KQoKSSds
bCByZWdyZXQgdGhhdCB3aGVuIEkgZ2V0IHBhdGNoZXMgZml4aW5nIHRoZW0sIGJ1dCBva2F5LgoK
Um9iCgpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2R0LXNjaGVtYS9ibG9i
L21haW4vZHRzY2hlbWEvc2NoZW1hcy9jaG9zZW4ueWFtbAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9rZXhlYwo=

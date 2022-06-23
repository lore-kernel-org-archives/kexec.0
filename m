Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE198C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 10:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jBYy7RE3LTMRc1bCygkeRqW5zvS/7eXF8LHymamOyMU=; b=wseoggkzNwR1dI
	shkCIlku0Qvn4omTAoC/usKG1D6X9/4zGpGaAshlXTfQadeQJ/0sOxVUd1w9IoCZmtKKdtka2vQat
	EmgmbI1duR7ih5gTpd88AT+O+EBB+hwxpYuuP+ZlzMswpjbISzESVVC5iSVgci4ry0BqzT1XGBbTS
	VdKlGKZyy/EdBz1BKJAmagvv0RmvED2zci/lArPoC/irfJw9eWhcrx52Cuk43xbsnSMHs9NM2AaC3
	MJ+ELCOiE0IlF/MY2Pqunh2ylzyAvXgcIzLqjmK7XhE0aCcgfL9Nby0Puh5jvgu/TiymIDqUV7d6a
	tWRLyveNohFO6+RW3H3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4K3W-00EWaV-Al; Thu, 23 Jun 2022 10:27:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4K3T-00EWY1-Uh; Thu, 23 Jun 2022 10:27:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 70CBFCE23C7;
	Thu, 23 Jun 2022 10:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F82C3411B;
	Thu, 23 Jun 2022 10:27:07 +0000 (UTC)
Date: Thu, 23 Jun 2022 11:27:03 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
	Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	liushixin <liushixin2@huawei.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <YrQ/98J5UqPh8K89@arm.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ba3a97d6-262d-6413-135d-0be9b0af9a6a@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_032720_375514_7693EF6C 
X-CRM114-Status: GOOD (  43.84  )
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

T24gV2VkLCBKdW4gMjIsIDIwMjIgYXQgMDg6MDM6MjFQTSArMDgwMCwgS2VmZW5nIFdhbmcgd3Jv
dGU6Cj4gT24gMjAyMi82LzIyIDI6MDQsIENhdGFsaW4gTWFyaW5hcyB3cm90ZToKPiA+IE9uIFR1
ZSwgSnVuIDIxLCAyMDIyIGF0IDAyOjI0OjAxUE0gKzA4MDAsIEtlZmVuZyBXYW5nIHdyb3RlOgo+
ID4gPiBPbiAyMDIyLzYvMjEgMTM6MzMsIEJhb3F1YW4gSGUgd3JvdGU6Cj4gPiA+ID4gT24gMDYv
MTMvMjIgYXQgMDQ6MDlwbSwgWmhlbiBMZWkgd3JvdGU6Cj4gPiA+ID4gPiBJZiB0aGUgY3Jhc2hr
ZXJuZWwgaGFzIGJvdGggaGlnaCBtZW1vcnkgYWJvdmUgRE1BIHpvbmVzIGFuZCBsb3cgbWVtb3J5
Cj4gPiA+ID4gPiBpbiBETUEgem9uZXMsIGtleGVjIGFsd2F5cyBsb2FkcyB0aGUgY29udGVudCBz
dWNoIGFzIEltYWdlIGFuZCBkdGIgdG8gdGhlCj4gPiA+ID4gPiBoaWdoIG1lbW9yeSBpbnN0ZWFk
IG9mIHRoZSBsb3cgbWVtb3J5LiBUaGlzIG1lYW5zIHRoYXQgb25seSBoaWdoIG1lbW9yeQo+ID4g
PiA+ID4gcmVxdWlyZXMgd3JpdGUgcHJvdGVjdGlvbiBiYXNlZCBvbiBwYWdlLWxldmVsIG1hcHBp
bmcuIFRoZSBhbGxvY2F0aW9uIG9mCj4gPiA+ID4gPiBoaWdoIG1lbW9yeSBkb2VzIG5vdCBkZXBl
bmQgb24gdGhlIERNQSBib3VuZGFyeS4gU28gd2UgY2FuIHJlc2VydmUgdGhlCj4gPiA+ID4gPiBo
aWdoIG1lbW9yeSBmaXJzdCBldmVuIGlmIHRoZSBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbiBpcyBk
ZWZlcnJlZC4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gVGhpcyBtZWFucyB0aGF0IHRoZSBibG9jayBt
YXBwaW5nIGNhbiBzdGlsbCBiZSBwZXJmb3JtZWQgb24gb3RoZXIga2VybmVsCj4gPiA+ID4gPiBs
aW5lYXIgYWRkcmVzcyBzcGFjZXMsIHRoZSBUTEIgbWlzcyByYXRlIGNhbiBiZSByZWR1Y2VkIGFu
ZCB0aGUgc3lzdGVtCj4gPiA+ID4gPiBwZXJmb3JtYW5jZSB3aWxsIGJlIGltcHJvdmVkLgo+ID4g
PiA+IFVnaCwgdGhpcyBsb29rcyBhIGxpdHRsZSB1Z2x5LCBob25lc3RseS4KPiA+ID4gPiAKPiA+
ID4gPiBJZiB0aGF0J3MgZm9yIHN1cmUgYXJtNjQgY2FuJ3Qgc3BsaXQgbGFyZ2UgcGFnZSBtYXBw
aW5nIG9mIGxpbmVhcgo+ID4gPiA+IHJlZ2lvbiwgdGhpcyBwYXRjaCBpcyBvbmUgd2F5IHRvIG9w
dGltaXplIGxpbmVhciBtYXBwaW5nLiBHaXZlbiBrZHVtcAo+ID4gPiA+IHNldHRpbmcgaXMgbmVj
ZXNzYXJ5IG9uIGFybTY0IHNlcnZlciwgdGhlIGJvb3Rpbmcgc3BlZWQgaXMgdHJ1bHkKPiA+ID4g
PiBpbXBhY3RlZCBoZWF2aWx5Lgo+ID4gPiBJcyB0aGVyZSBzb21lIGNvbmNsdXNpb24gb3IgZGlz
Y3Vzc2lvbiB0aGF0IGFybTY0IGNhbid0IHNwbGl0IGxhcmdlIHBhZ2UKPiA+ID4gbWFwcGluZz8K
PiA+ID4gCj4gPiA+IENvdWxkIHRoZSBjcmFzaGtlcm5lbCByZXNlcnZhdGlvbiAoYW5kIEtmZW5j
ZSBwb29sKSBiZSBzcGxpdGVkIGR5bmFtaWNhbGx5Pwo+ID4gPiAKPiA+ID4gSSBmb3VuZCBNYXJr
IHJlcGxheSAiYXJtNjQ6IHJlbW92ZSBwYWdlIGdyYW51bGFyaXR5IGxpbWl0YXRpb24gZnJvbQo+
ID4gPiBLRkVOQ0UiWzFdLAo+ID4gPiAKPiA+ID4gIMKgICJXZSBhbHNvIGF2b2lkIGxpdmUgY2hh
bmdlcyBmcm9tIGJsb2NrPC0+dGFibGUgbWFwcGluZ3MsIHNpbmNlIHRoZQo+ID4gPiAgwqAgYXJj
aHRpdGVjdHVyZSBnaXZlcyB1cyB2ZXJ5IHdlYWsgZ3VhcmFudGVlcyB0aGVyZSBhbmQgZ2VuZXJh
bGx5IHJlcXVpcmVzCj4gPiA+ICDCoCBhIEJyZWFrLUJlZm9yZS1NYWtlIHNlcXVlbmNlICh0aG91
Z2ggSUlSQyB0aGlzIHdhcyB0aWdodGVuZWQgdXAKPiA+ID4gIMKgIHNvbWV3aGF0LCBzbyBtYXli
ZSBnb2luZyBvbmUgd2F5IGlzIHN1cHBvc2VkIHRvIHdvcmspLiBVbmxlc3MgaXQncwo+ID4gPiAg
wqAgcmVhbGx5IG5lY2Vzc2FyeSwgSSdkIHJhdGhlciBub3Qgc3BsaXQgdGhlc2UgYmxvY2sgbWFw
cGluZ3Mgd2hpbGUKPiA+ID4gIMKgIHRoZXkncmUgbGl2ZS4iCj4gPiBUaGUgcHJvYmxlbSB3aXRo
IHNwbGl0dGluZyBpcyB0aGF0IHlvdSBjYW4gZW5kIHVwIHdpdGggdHdvIGVudHJpZXMgaW4KPiA+
IHRoZSBUTEIgZm9yIHRoZSBzYW1lIFZBLT5QQSBtYXBwaW5nIChlLmcuIG9uZSBmb3IgYSA0S0Ig
cGFnZSBhbmQgYW5vdGhlcgo+ID4gZm9yIGEgMk1CIGJsb2NrKS4gSW4gdGhlIGx1Y2t5IGNhc2Us
IHRoZSBDUFUgd2lsbCB0cmlnZ2VyIGEgVExCIGNvbmZsaWN0Cj4gPiBhYm9ydCAoYnV0IGNhbiBi
ZSB3b3JzZSBsaWtlIGxvc3Mgb2YgY29oZXJlbmN5KS4KPiBUaGFua3MgZm9yIHlvdXIgZXhwbGFu
YXRpb27vvIwKPiA+IFByaW9yIHRvIEZFQVRfQkJNIChhZGRlZCBpbiBBUk12OC40KSwgc3VjaCBz
Y2VuYXJpbyB3YXMgbm90IGFsbG93ZWQgYXQKPiA+IGFsbCwgdGhlIHNvZnR3YXJlIHdvdWxkIGhh
dmUgdG8gdW5tYXAgdGhlIHJhbmdlLCBUTEJJLCByZW1hcC4gV2l0aAo+ID4gRkVBVF9CQk0gKGxl
dmVsIDIpLCB3ZSBjYW4gZG8gdGhpcyB3aXRob3V0IHRlYXJpbmcgdGhlIG1hcHBpbmcgZG93biBi
dXQKPiA+IHdlIHN0aWxsIG5lZWQgdG8gaGFuZGxlIHRoZSBwb3RlbnRpYWwgVExCIGNvbmZsaWN0
IGFib3J0LiBUaGUgaGFuZGxlcgo+ID4gb25seSBuZWVkcyBhIFRMQkkgYnV0IGlmIGl0IHRvdWNo
ZXMgdGhlIG1lbW9yeSByYW5nZSBiZWluZyBjaGFuZ2VkIGl0Cj4gPiByaXNrcyBmYXVsdGluZyBh
Z2Fpbi4gV2l0aCB2bWFwIHN0YWNrcyBhbmQgdGhlIGtlcm5lbCBpbWFnZSBtYXBwZWQgaW4KPiA+
IHRoZSB2bWFsbG9jIHNwYWNlLCB3ZSBoYXZlIGEgc21hbGwgd2luZG93IHdoZXJlIHRoaXMgY291
bGQgYmUgaGFuZGxlZAo+ID4gYnV0IHdlIHByb2JhYmx5IGNhbid0IGdvIGludG8gdGhlIEMgcGFy
dCBvZiB0aGUgZXhjZXB0aW9uIGhhbmRsaW5nCj4gPiAodHJhY2luZyBldGMuIG1heSBhY2Nlc3Mg
YSBrbWFsbG9jJ2VkIG9iamVjdCBmb3IgZXhhbXBsZSkuCj4gCj4gU28gaWYgd2l0aG91dCBGRUFU
X0JCTe+8jHdlIGNhbiBvbmx5IGd1YXJhbnRlZSBCQk0gc2VxdWVuY2UgdmlhCj4gInVubWFwIHRo
ZSByYW5nZSwgVExCSSwgcmVtYXAiIG9yIHRoZSBmb2xsb3dpbmcgb3B0aW9uLAoKWWVzLCB0aGF0
J3MgdGhlIGJyZWFrLWJlZm9yZS1tYWtlIHNlcXVlbmNlLgoKPiBhbmQgd2l0aCBGRUFUX0JCTSAo
bGV2ZWwgMiksIHdlIGNvdWxkIGhhdmUgZWFzeSB3YXkgdG8gYXZvaWQgVExCCj4gY29uZmxpY3Qg
Zm9yIHNvbWUgdm1hbGxvYyBzcGFjZSwgYnV0IHN0aWxsIGhhcmQgdG8gZGVhbCB3aXRoIG90aGVy
Cj4gc2NlbmNlPwoKSXQncyBub3QgdG9vIGhhcmQgaW4gdGhlb3J5LiBCYXNpY2FsbHkgdGhlcmUn
cyBhIHNtYWxsIHJpc2sgb2YgZ2V0dGluZyBhClRMQiBjb25mbGljdCBhYm9ydCBmb3IgdGhlIG1h
cHBpbmdzIHlvdSBjaGFuZ2Ugd2l0aG91dCBhIEJCTSBzZXF1ZW5jZSAoSQp0aGluayBpdCdzIG5l
YXJseSBub24tZXhpc3RlZCB3aGVuIGdvaW5nIGZyb20gbGFyZ2UgYmxvY2sgdG8gc21hbGxlcgpw
YWdlcywgdGhvdWdoIHRoZSBhcmNoaXRlY3R1cmUgc3RhdGVzIHRoYXQgaXQncyBzdGlsbCBwb3Nz
aWJsZSkuIFNpbmNlCndlIG9ubHkgd2FudCB0byBkbyB0aGlzIGZvciB0aGUgbGluZWFyIG1hcCBh
bmQgdGhlIGtlcm5lbCBhbmQgc3RhY2sgYXJlCmluIHRoZSB2bWFsbG9jIHNwYWNlLCB3ZSBjYW4g
aGFuZGxlIHN1Y2ggdHJhcCBhcyBhbiBzYWZldHkgbWVhc3VyZSAoaXQKanVzdCBuZWVkcyBhIFRM
QkkpLiBJdCBtYXkgaGVscCB0byB0d2VhayBhIG1vZGVsIHRvIGZvcmNlIGl0IHRvIGdlbmVyYXRl
CnN1Y2ggY29uZmxpY3QgYWJvcnRzLCBvdGhlcndpc2Ugd2UnZCBub3QgYmUgYWJsZSB0byB0ZXN0
IHRoZSBjb2RlLgoKSXQncyBwb3NzaWJsZSB0aGF0IHN1Y2ggdHJhcCBpcyByYWlzZWQgYXQgRUwy
IGlmIGEgZ3Vlc3QgY2F1c2VkIHRoZQpjb25mbGljdCBhYm9ydCAodGhlIGFyY2hpdGVjdHVyZSBs
ZWZ0IHRoaXMgYXMgSU1QIERFRikuIFRoZSBoeXBlcnZpc29ycwptYXkgbmVlZCB0byBiZSB0YXVn
aHQgdG8gZG8gYSBUTEJJIFZNQUxMUzEyRTEgaW5zdGVhZCBvZiBraWxsaW5nIHRoZQpndWVzdC4g
SSBoYXZlbid0IGNoZWNrZWQgd2hhdCBLVk0gZG9lcy4KCi0tIApDYXRhbGluCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==

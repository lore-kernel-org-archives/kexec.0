Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD3ED3E773
	for <kexec@archiver.kernel.org>; Tue,  5 Nov 2024 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S3UWle3W90l7OYO4gBz9rCtInAAe5pA+mDmU9FeOM40=; b=nG/QdGXfttlziu
	zxx9wq9jU4/juH11WvOjs2TKwxhXWsFkIFiREqEWNr7QCLtkRLXlzzvYcQCHTJZTjtHUbQN0+kKty
	95My4jGcDFwalZTqcr6YLFka2kVi18cREJGDNtFmEOgV00mBSOtb/fUEeK95dJI7WQ9mk4uobFptq
	3LeRvCPV/8Ug4iY/i2nxCq0fAzXVzxIC/N+fZyFF5rcFxhAmRbFFf5uSVuQQwxec58w8LUKKaW8tx
	8l4MYO1Bn0KtjylFcUeH6UzuXYkmJAZDGn85PBRzGHucXYuDG/5W/vZgkrFBC65tPCySoLkgH1tjH
	dHt/tmsrzA5Uu/1owgeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8RF1-00000000sws-0JOo;
	Tue, 05 Nov 2024 21:37:35 +0000
Received: from torg.zytor.com ([2607:7c80:54:3::138] helo=mail.zytor.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8REx-00000000sw8-2mKk
	for kexec@lists.infradead.org;
	Tue, 05 Nov 2024 21:37:33 +0000
Received: from [172.27.3.244] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A5Lb2rA394145
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 5 Nov 2024 13:37:03 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A5Lb2rA394145
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1730842624;
	bh=gVNz4z0YQjtXd1WB/AEasi4Rhq+Td1PSdtdB5FjTHlk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s2V7ohyXGEeGmyrhjDFLDX29Vc8YfP3+0uZqjIuHFLdRCDgN/KgwsS8vkj4k7IeGa
	 YuoJfmGbkVPOO5LSWWXW/NPSJzN759FXDxTuB4YUL1Zbhn+uVZcGHbHmjYnHgS1C5g
	 VBDRsAHR09NzmbXI9ApgTpXjY1PZScQPKQvyEjf8hUt7NOZ8zAWCNqyDyl10sVF4bk
	 vc1HbVknPmu0hH4vDNDl5aPKtkJzYAGUNmChtAtgFSdORczfEA2ftnKdDnB3yBlv5F
	 Z9EX/eRZ2R/9uZR/AN6jNTIJIe5Np/U1G+E2SZVBU9pGbaGZN6PezpkHUaZWcI5kmJ
	 hCr3aGoSXTeNw==
Message-ID: <b66cd5ca-aae4-48eb-a0ba-2d1d4e53f810@zytor.com>
Date: Tue, 5 Nov 2024 13:37:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 6/7] x86/kexec: Debugging support: Dump registers on
 exception
To: "Woodhouse, David" <dwmw@amazon.co.uk>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
Cc: "horms@kernel.org" <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kai.huang@intel.com" <kai.huang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
 <20241103054019.3795299-7-dwmw2@infradead.org>
 <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <230aacb0ca0d57581f9350f96390933646f203e4.camel@amazon.co.uk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_133731_729342_EA44FD1F 
X-CRM114-Status: GOOD (  21.87  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

T24gMTEvNS8yNCAxMjozOCwgV29vZGhvdXNlLCBEYXZpZCB3cm90ZToKPiBPbiBTdW4sIDIwMjQt
MTEtMDMgYXQgMDU6MzUgKzAwMDAsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPj4KPj4gKwo+PiAr
LyogUHJpbnQgdGhlIGJ5dGUgaW4gJWJsLCBjbG9iYmVyICVyYXggKi8KPj4gK1NZTV9DT0RFX1NU
QVJUX0xPQ0FMX05PQUxJR04ocHJfYnl0ZSkKPj4gK8KgwqDCoMKgwqDCoMKgbW92YsKgwqDCoMKg
JWJsLCAlYWwKPj4gK8KgwqDCoMKgwqDCoMKgbm9wCj4+ICvCoMKgwqDCoMKgwqDCoGFuZGLCoMKg
wqDCoCQweDBmLCAlYWwKPj4gK8KgwqDCoMKgwqDCoMKgYWRkYsKgwqDCoMKgJDB4MzAsICVhbAo+
PiArwqDCoMKgwqDCoMKgwqBjbXBiwqDCoMKgwqAkMHgzYSwgJWFsCj4+ICvCoMKgwqDCoMKgwqDC
oGpiwqDCoMKgwqDCoMKgMWYKPj4gK8KgwqDCoMKgwqDCoMKgYWRkYsKgwqDCoMKgJCgnYScgLSAn
MCcgLSAxMCksICVhbAo+PiArMTrCoMKgwqDCoMKgcHJfY2hhcgo+PiArwqDCoMKgwqDCoMKgwqBB
Tk5PVEFURV9VTlJFVF9TQUZFCj4+ICvCoMKgwqDCoMKgwqDCoHJldAo+PiArU1lNX0NPREVfRU5E
KHByX2J5dGUpCj4+ICsKPiAKPiBPYnZpb3VzbHkgdGhhdCBmdW5jdGlvbiBuYW1lIChhbmQgY29t
bWVudCkgYXJlIHdyb25nOyBmaXhlZCBpbiBteSB0cmVlLgo+IGF0Cj4gaHR0cHM6Ly9naXQuaW5m
cmFkZWFkLm9yZy91c2Vycy9kd213Mi9saW51eC5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9rZXhl
Yy1kZWJ1Zwo+IAo+IFRoaXMgZnVuY3Rpb24gKGFuZCBhbHNvIHByX3F3b3JkKSBhcmUgYWxzbyB3
aGF0IG9ianRvb2wgaXMgY29tcGxhaW5pbmcKPiBhYm91dDoKPiAKPiB2bWxpbnV4Lm86IHdhcm5p
bmc6IG9ianRvb2w6IHJlbG9jYXRlX3JhbmdlKzB4MmY2OiB1bnJlYWNoYWJsZSBpbnN0cnVjdGlv
bgo+IHZtbGludXgubzogd2FybmluZzogb2JqdG9vbDogcmVsb2NhdGVfcmFuZ2UrMHgzMDU6IHVu
cmVhY2hhYmxlIGluc3RydWN0aW9uCj4gCj4gSSBkb24ndCBxdWl0ZSBzZWUgd2h5LCBiZWNhdXNl
IHByX3F3b3JkKCkgcXVpdGUgYmxhdGFudGx5IGNhbGxzCj4gcHJfbnlibGxlKCksIGFzIGl0J3Mg
bm93IG5hbWVkLiBBbmQgZXhjX2hhbmRsZXIoKSByZXBlYXRlZGx5IGNhbGxzCj4gcHJfcXdvcmQo
KS4KPiAKPiBCdXQgbW9zdCBvZiB0aGUgb2JqdG9vbCBhbm5vdGF0aW9ucyBJJ3ZlIGFkZGVkIGhl
cmUgd2VyZSBqdXN0IHRvIG1ha2UKPiBpdCBzaHV0IHVwIGFuZCBidWlsZCwgd2l0aG91dCBtdWNo
IHRob3VnaC4gUGV0ZXIsIEpvc2gsIGFueSBjaGFuY2UgeW91Cj4gY2FuIGhlbHAgbWUgZml4IGl0
IHVwIHBsZWFzZT8KPiAKPiBJdCB3b3VsZCBhbHNvIGJlIHJlYWxseSB1c2VmdWwgaWYgb2JqdG9v
bCB3b3VsZCBsZXQgbWUgaGF2ZSBkYXRhIGluc2lkZQo+IGEgImNvZGUiIHNlZ21lbnQsIHdpdGhv
dXQgY29tcGxhaW5pbmcgdGhhdCBpdCBjYW4ndCBkZWNvZGUgaXQgYXMKPiBpbnN0cnVjdGlvbnMg
4oCUIGFuZCB3aXRob3V0IGFsc28gZmFpbGluZyB0byBkZWNvZGUgdGhlIGZpcnN0IGluc3RydWN0
aW9uCj4gb2YgdGhlICpzdWJzZXF1ZW50KiBmdW5jdGlvbi4gSSd2ZSBwdXQgdGhlIEdEVCBhdCB0
aGUgZW5kIHRvIHdvcmsKPiBhcm91bmQgdGhhdCwgYnV0IGl0J3MgYSBiaXQgbmFzdHkuCj4gCgpM
b29raW5nIGF0IHlvdXIgY29kZSwgeW91IGhhdmUgYSBtdWNoIGJpZ2dlciBwcm9ibGVtIGhlcmU6
CgorLyoKKyAqIFRoaXMgYWxsb3dzIG90aGVyIHR5cGVzIG9mIHNlcmlhbCBwb3J0cyB0byBiZSB1
c2VkLgorICogIC0gJWFsOiBDaGFyYWN0ZXIgdG8gYmUgcHJpbnRlZCAobm8gY2xvYmJlciAlcmF4
KQorICogIC0gJXJkeDogTU1JTyBhZGRyZXNzIG9yIHBvcnQuCisgKi8KKy5tYWNybyBwcl9jaGFy
CisgICAgICAgb3V0YiAgICAlYWwsICVkeAorLmVuZG0KKwoKVGhpcyB3aWxsIG92ZXJmbG93IHlv
dXIgVUFSVCBidWZmZXIgdmVyeSBxdWlja2x5IHNpbmNlIHlvdSBhcmUgbm93IApkdW1waW5nIGEg
d2hvbGUgYnVuY2ggb2YgZGF0YS4gVGhlIFVSVCBidWZmZXIgLS0gaWYgeW91IGV2ZW4gaGF2ZSBv
bmUgCmFuZCBpdCBpcyBlbmFibGVkIC0tIGlzIG9ubHkgMTYgYnl0ZXMgaW4gYSBzdGFuZGFyZCAx
NjU1MEEgVUFSVC4gSW4gCm9sZGVyIFVBUlRzIChvciBlbXVsYXRlZCBvbGRlciBVQVJUcykgeW91
IG1pZ2h0IG5vdCBoYXZlIGEgYnVmZmVyIGF0IAphbGwuIFRvIHByaW50IG1vcmUgdGhhbiBhIGhh
bmRmdWwgb2YgYnl0ZXMsIHlvdSBuZWVkIHRvIHBvbGwgZm9yIHRoZSAKVEhSRSBiaXQ9MSAoYml0
IDUgb2YgcmVnaXN0ZXIgNSkuCgpXaGF0IGlzIHRoZSBwb2ludCBvZiB3cml0aW5nIHRoaXMgY29k
ZSBpbiBhc3NlbWJseSBpbiB0aGUgZmlyc3QgcGxhY2U/IEEgCm11Y2ggbW9yZSBsb2dpY2FsIHRo
aW5nIHRvIGRvIGlzIHRvIGp1c3QgcHVzaCB0aGUgcmVnaXN0ZXJzIHlvdSBoYXZlbid0IApwdXNo
ZWQgYWxyZWFkeSBvbnRvIHRoZSBzdGFjayBhbmQgY2FsbCBhIEMgZnVuY3Rpb24gdG8gZG8gdGhl
IGFjdHVhbCAKZHVtcGluZz8gSXQgaXNuJ3QgbGlrZSBpdCBpcyBpbiBhbnkgc2hhcGUsIHdheSBv
ciBmb3JtIHBlcmZvcm1hbmNlIGNyaXRpY2FsLgoKCS1ocGEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508EED59F6D
	for <kexec@archiver.kernel.org>; Sat, 13 Dec 2025 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o9fJXDtXoVKnzhNQS1ylDA8uNXeuK84gVZGRdlqfvSA=; b=mEDLHbbTLvZsnjwPbqEypGNQOp
	N7AxWxm+r9fPSJztxj+3IKwUYIXGAqytP14L7XPhRdzEAsO+7O75dYBBzmIgZcVKSNH9YjkX8Utwi
	dgjCfTNp7Fk5B/sK1eAEwvE55SE272TI3rY1VEB1ICoz2h7TiwyMHFCKke9MnxUi33vayqFljLuRl
	UwuuhKqALQgtAwd1YS8ft3O9/s9DLffGZEko4jLh2ZogTKuA4jC3Bx5PFMXOiRYPmxkvU2DMTjVaC
	uox0Z4gvyED5/TThZUxkXkAnSfgUrZfoThiYZvg0/5bCiafVHxh00zaf5oETzCcK2LF1YVseyARWW
	KxOYnzEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUJmD-00000001UJH-3jbP;
	Sat, 13 Dec 2025 07:10:49 +0000
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.35.192.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUJm7-00000001UIt-0pHh
	for kexec@lists.infradead.org;
	Sat, 13 Dec 2025 07:10:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1765609843; x=1797145843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o9fJXDtXoVKnzhNQS1ylDA8uNXeuK84gVZGRdlqfvSA=;
  b=PIYmxHR9wreVSuZZX0mYszxHVdPf6roaAwufF+fOzvVyrONFFD6FU0ov
   Yhe+RkLKEC8IF3aKiQFkggq4CzByb0+Dh3wIyOpftlMrQVXrAdWJIxWpW
   NJfB8QKKeZutnuraB+9FUz2WmFTPC8wFMRSYVegnDp7cZ+5tvXwJUrPux
   wCBFyGDVBGNMr+Zluwj07qr3Sj2cT2CeXvEzYOfMJgkEzx3/iVeiI8F2S
   k2nnD+Edd7Z5sPpHdWdoVmsp/NlejsJPyRpIdXFS+Ud7xdzrxLpgOOme5
   Kc3QA3ZNROGrGp/paCoDmpHH46viFHj4wTty2mVnvWbXb+Bow9hQXEA66
   Q==;
X-CSE-ConnectionGUID: IArTKZvNTse5aI0KzG9AZQ==
X-CSE-MsgGUID: kwnkf6iXRHa0M3DtExxWHQ==
X-IronPort-AV: E=Sophos;i="6.21,145,1763424000"; 
   d="scan'208";a="8795544"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2025 07:10:36 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:26686]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.135:2525] with esmtp (Farcaster)
 id 0748e64d-5e43-4bf2-9d47-0b42a67cdd9d; Sat, 13 Dec 2025 07:10:36 +0000 (UTC)
X-Farcaster-Flow-ID: 0748e64d-5e43-4bf2-9d47-0b42a67cdd9d
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sat, 13 Dec 2025 07:10:36 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Sat, 13 Dec 2025
 07:10:27 +0000
Message-ID: <e4d1c333-7e22-47ee-81a0-2efc4ca6b17c@amazon.com>
Date: Sat, 13 Dec 2025 16:10:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] liveupdate: list all file handler versions in vmlinux
 section
To: Pratyush Yadav <pratyush@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"Pasha Tatashin" <pasha.tatashin@soleen.com>, Mike Rapoport
	<rppt@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>, Samiullah
 Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, David
 Rientjes <rientjes@google.com>, Jason Miu <jasonmiu@google.com>
CC: <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <kexec@lists.infradead.org>
References: <20251211042624.175517-1-pratyush@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20251211042624.175517-1-pratyush@kernel.org>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_231043_310649_2F9D6E0C 
X-CRM114-Status: GOOD (  19.46  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgUHJhdHl1c2gsCgpPbiAxMC4xMi4yNSAyMDoyNiwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6Cj4g
QXMgbGl2ZSB1cGRhdGUgZXZvbHZlcywgdGhlcmUgd2lsbCBiZSBhIG5lZWQgdG8gdXBkYXRlIHRo
ZSBzZXJpYWxpemF0aW9uCj4gZm9ybWF0cyBmb3IgdGhlIGRpZmZlcmVudCBmaWxlIHR5cGVzLiBU
aGlzIGNvdWxkIGJlIGZvciBhZGRpbmcgbmV3Cj4gZmVhdHVyZXMsIGZvciBzdXBwb3J0aW5nIGEg
Y2hhbmdlIGluIGJlaGF2aW91ciwgb3IgdG8gZml4IGJ1Z3MuCj4KPiBJZiB0aGUgY3VycmVudCBr
ZXJuZWwgZG9lcyBub3QgdW5kZXJzdGFuZCB0aGUgc2FtZSBzZXQgb2YgdmVyc2lvbnMgYXMKPiB0
aGUgbmV4dCBrZXJuZWwsIGxpdmUgdXBkYXRlIHdpbGwgaW5ldml0YWJseSBmYWlsLiBUaGUgbmV4
dCBrZXJuZWwgd2lsbAo+IGJlIHVuYWJsZSB0byB1bmRlcnN0YW5kIHRoZSBoYW5kZWQgb3ZlciBk
YXRhIGFuZCB3aWxsIGJlIHVuYWJsZSB0bwo+IHJlc3RvcmUgbWVtb3J5LCBkZXZpY2VzLCBJT01N
VSBwYWdlIHRhYmxlcywgZXRjLgo+Cj4gTGlzdCB0aGUgc2V0IG9mIHZlcnNpb25zIHRoZSBrZXJu
ZWwgdW5kZXJzdGFuZHMgaW4gYSBzZWN0aW9uIGluIHZtbGludXguCj4gVGhpcyBjYW4gdGhlbiBi
ZSB1c2VkIGJ5IHVzZXJzcGFjZSB0b29saW5nIHRvIG1ha2Ugc3VyZSB0aGUgc2V0IG9mIGZpbGUK
PiBkZXNjcmlwdG9ycyBpdCB1c2VzIGhhdmUgdGhlIHNhbWUgdmVyc2lvbiBiZXR3ZWVuIGJvdGgg
a2VybmVscy4gSWYgdGhlcmUKPiBpcyBhIG1pc21hdGNoLCB0aGUgdG9vbGluZyBjYW4gY2F0Y2gg
dGhpcyBlYXJseSBhbmQgYWJvcnQgbGl2ZSB1cGRhdGUKPiBiZWZvcmUgaXQgaXMgdG9vIGxhdGUu
Cj4KPiBUaGUgdmVyc2lvbnMgYXJlIGxpc3RlZCBpbiBhIHNlY3Rpb24gY2FsbGVkICIubGl2ZXVw
ZGF0ZV92ZXJzaW9ucyIuIFRoZQo+IHNlY3Rpb24gaGFzIGEgaGVhZGVyIHRoYXQgY29udGFpbnMg
YSBtYWdpYyBudW1iZXIgYW5kIHRoZSB2ZXJzaW9uIG9mIHRoZQo+IGRhdGEgZm9ybWF0LiBUaGUg
bGlzdCBvZiB2ZXJzaW9uIHN0cmluZ3MgZGlyZWN0bHkgZm9sbG93IHRoaXMgaGVhZGVyLgo+IE9u
bHkgdGhlIHZlcnNpb24gc3RyaW5ncyBhcmUgbGlzdGVkLCBhbmQgaXQgaXMgdXAgdG8gdXNlcnNw
YWNlIHRvIG1hcAo+IHRoZW0gdG8gZmlsZSBkZXNjcmlwdG9yIHR5cGVzLgo+Cj4gVGhlIGZvcm1h
dCBvZiB0aGUgc2VjdGlvbiBoYXMgdGhlIHNhbWUgQUJJIHJ1bGVzIGFzIHRoZSByZXN0IG9mIExV
TyBBQkkuCj4KPiBJbnRyb2R1Y2UgYSBMSVZFVVBEQVRFX0ZJTEVfSEFORExFUiBtYWNybyB0aGF0
IG1ha2VzIGl0IGVhc3kgdG8gZGVmaW5lIGEKPiBmaWxlIGhhbmRsZXIgd2hpbGUgYWxzbyBhZGRp
bmcgaXRzIHZlcnNpb24gc3RyaW5nIHRvIHRoZSByaWdodCBzZWN0aW9uLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogUHJhdHl1c2ggWWFkYXYgPHByYXR5dXNoQGtlcm5lbC5vcmc+CgoKVG8gc3VwcG9ydCBt
dWx0aS12ZXJzaW9uIHByZXNlcnZhdGlvbiBhbmQgcmVzdW1lLCBob3cgYWJvdXQgeW91IGFkZCBh
IAoicHJvZmlsZSIgaGludCB0byB0aGUgaGFuZGxlcnM/IFRoZW4geW91IGNhbiB0YWcgdGhlIGhh
bmRsZXJzIHdpdGggCiJjdXJyZW50IiBhbmQgYSAicHJldmlvdXMiLiBZb3UgdGhlbiBleHBvc2Ug
b25lIHNlY3Rpb24gdGFibGUgd2l0aCAKc3VwcG9ydGVkIHZlcnNpb25zIHBlciBwcm9maWxlLiBB
bmQgdGhhdCBtZWFucyB5b3UgY2FuIGZyb20gdXNlciBzcGFjZSAKc2VsZWN0IHRoZSBsb2NhbCBw
cm9maWxlIHRvIHNlcmlhbGl6ZSBhbmQgbWF0Y2ggdGhhdCBhZ2FpbnN0IHRoZSB0YXJnZXQgCnBy
b2ZpbGUgb2YgdGhlIHRhcmdldCBzeXN0ZW0uCgpJdCBhbHNvIGFsbG93cyB5b3UgdG8gc3VwcG9y
dCBtb3JlICJwcm9maWxlcyIsIHN1Y2ggYXMgZWxhYm9yYXRlIApkb3duc3RyZWFtIHZlcnNpb24g
Y29tYmluYXRpb25zLCB0aGF0IHVwc3RyZWFtIHdpbGwgbm90IGhhdmUgdG8gY2FyZSBhYm91dC4K
CgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFu
eSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVu
ZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAzNjUgNTM4IDU5Nwo=



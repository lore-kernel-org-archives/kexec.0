Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3A7C001B0
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aghnBByBM3AWWekLOBzu63Up74e2Yc2NvvWcman2W4k=; b=CbnAf5qy9y9Kji
	4wpIgYYwrbUpa3bYtREy4X+py0ToI74YtHaW4RBWEkjF7sz67dwwvxF6HPMlFuEIFodGIt0aTDjmu
	Mkv0p4dvp9F2ddG4SPF5rX+AkMD/HlcqnGXccBPgAMdil5u7vyo2kQV+5JvBBW/RoJpoZdex93B1e
	O0zA8hGceloiR//L/HJf+NjHcskN7mY6pgJQqLEkE+zR0vDgwExhfyYUSuRcwXMH5i8rEWcFO32Vz
	ujJNlgIhtKErDiMCKq/QmcdhjfMDP0vyttIbgSaK/2s1ancfY/hBfIZmenAph8iESe/Q5ZDlclARl
	fE0eOwKTO/7pYXpM8VeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTu5I-006EqR-0t;
	Thu, 10 Aug 2023 01:03:28 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTu5E-006Epk-2j
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 01:03:26 +0000
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8092920FC4EA;
	Wed,  9 Aug 2023 18:03:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8092920FC4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691629402;
	bh=2x2EFhFJgTyCZhIinQsqkFaSlOaRo4/tPw/QPajL/BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gx57cqg3A3QgQ3AYuhFcN7vGxDUiNdFywJNq4cRkOq5swDeWUQ/O4apEcC4wp0cQ3
	 O71O/OyDQwo1KSdLtUVRF8li9nCAxD7oDTgSZyT2FTZAZlJnNW8pkueOnu3tZn/E91
	 YYmU/YPLTBZsi7varAA7bynpVAUndeutc12+fVrM=
Message-ID: <e9b67fd8-3a8f-7024-5940-a093a704358e@linux.microsoft.com>
Date: Wed, 9 Aug 2023 18:03:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
 linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_180324_967879_07AC3EF5 
X-CRM114-Status: GOOD (  23.44  )
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

VGhhbmtzIGEgbG90IEphbWVzIGZvciBsb29raW5nIGF0IHRoaXMgcHJvcG9zYWwsCmFuZCBzaGFy
aW5nIHlvdXIgdGhvdWdodHMuIFJlYWxseSBhcHByZWNpYXRlIGl0LgoKT24gOC8xLzIzIDE0OjIx
LCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4gT24gVHVlLCAyMDIzLTA4LTAxIGF0IDEyOjEyIC0w
NzAwLCBTdXNoIFNocmluZ2FycHV0YWxlIHdyb3RlOgo+IFsuLi5dCj4+IFRydW5jYXRpbmcgSU1B
IGxvZyB0byByZWNsYWltIG1lbW9yeSBpcyBub3QgZmVhc2libGUsIHNpbmNlIGl0IG1ha2VzCj4+
IHRoZSBsb2cgZ28gb3V0IG9mIHN5bmMgd2l0aCB0aGUgVFBNIFBDUiBxdW90ZSBtYWtpbmcgcmVt
b3RlCj4+IGF0dGVzdGF0aW9uIGZhaWwuCj4gVGhpcyBhc3N1bXB0aW9uIGlzbid0IGVudGlyZWx5
IHRydWUuICBJdCdzIHBlcmZlY3RseSBwb3NzaWJsZSB0byBzaGFyZAo+IGFuIElNQSBsb2cgdXNp
bmcgdHdvIFRQTTJfUXVvdGUncyBmb3IgdGhlIGJlZ2lubmluZyBhbmQgZW5kIFBDUiB2YWx1ZXMK
PiB0byB2YWxpZGF0ZSB0aGUgc2hhcmQuICBUaGUgSU1BIGxvZyBjb3VsZCBiZSB0cnVuY2F0ZWQg
aW4gdGhlIHNhbWUgd2F5Cj4gKHJlcGxhY2UgdGhlIHJlbW92ZWQgcGFydCBvZiB0aGUgbG9nIHdp
dGggYSBUUE0yX1F1b3RlIGFuZCBBSywgc28gdGhlCj4gbG9nIHN0aWxsIHZhbGlkYXRlcyBmcm9t
IHRoZSBiZWdpbm5pbmcgcXVvdGUgdG8gdGhlIGVuZCkuCkhlcmUgd2UgbWVhbnQganVzdCB0cnVu
Y2F0aW5nIElNQSBsb2cgaXMgbm90IGEgY29tcGxldGUKc29sdXRpb24gaW4gaXRzZWxmLiBBcyB5
b3Ugc2FpZCwgd2UgaGF2ZSB0byB0YWtlIGFkZGl0aW9uYWwgc3RlcHMKbGlrZSBsb2dnaW5nIFRQ
TTJfUXVvdGVzIGV0Yy4gTG9nZ2luZyBBSyBpcyBhbiBpbnRlcmVzdGluZyBwcm9wb3NhbAp3aGlj
aCB3ZSBkaWRu4oCZdCBjb25zaWRlciBlYXJsaWVyLiBJIGFtIG5vdCBzdXJlIGlmIGVtYmVkZGlu
ZyBBSyB0byBJTUEKbG9nL3NuYXBzaG90IGlzIG5lZWRlZC4gSWYgdGhlIGNsaWVudCBzZW5kcyB0
aGVtIHNlcGFyYXRlbHkgd2l0aCAic2lnbmVkClBDUiBxdW90ZXMiICsgIklNQSBsb2ciICsgc25h
cHNob3RzLCBpdCBzaG91bGQgc3RpbGwgc2VydmUgdGhlIHB1cnBvc2UsCnJpZ2h0PwoKPgo+IElm
IHlvdSB1c2UgYSBUUE0yX1F1b3RlIG1lY2hhbmlzbSB0byBzYXZlIHRoZSBsb2csIGFsbCB5b3Ug
bmVlZCB0byBkbwo+IGlzIGhhdmUgdGhlIGtlcm5lbCBnZW5lcmF0ZSB0aGUgcXVvdGUgd2l0aCBh
biBpbnRlcm5hbCBBSy4gIFlvdSBjYW4KPiBrZWVwIGEgcmVjb3JkIG9mIHRoZSBxdW90ZSBhbmQg
dGhlIEFLIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIHRydW5jYXRlZAo+IGtlcm5lbCBsb2cuICBJ
ZiB0aGUgdHJ1bmNhdGVkIGVudHJpZXMgYXJlIHNhdmVkIGluIGEgZmlsZSBzaGFyZCBpdAo+IHNo
b3VsZCBoYXZlIGEgYmVnaW5uaW5nIGFuZCBlbmQgcXVvdGUgYW5kIGEgcmVjb3JkIG9mIHRoZSBB
SyB1c2VkLgpBIG5ldyBJTUEgbG9nIHNuYXBzaG90IGZpbGUgKG9yIHNoYXJkIGFzIHlvdSBjYWxs
IGl0KSB3aWxsIGhhdmUKdGhlIFRQTTJfUXVvdGUgcmVjb3JkIChwbHVzIHNvbWUgYWRkaXRpb25h
bCBtZXRhZGF0YSkgYXQgdGhlIGJlZ2lubmluZy4KSSBkb24ndCBiZWxpZXZlIGl0IG5lZWRzIHRv
IGJlIGxvZ2dlZCBhdCB0aGUgZW5kIG9mIHRoZSBzbmFwc2hvdCAoc2luY2UgCml0IGNhbgpiZSBj
b21wdXRlZCBieSByZXBsYXlpbmcgdGhlIHJlbWFpbmluZyBlbnRyaWVzIGluIHRoZSBzbmFwc2hv
dCkuCgpTZWUgdGhlIHNuYXBzaG90X2FnZ3JlZ2F0ZSBmaWVsZCBpbiBzZWN0aW9uIEIuNSBpbiB0
aGUgb3JpZ2luYWwgUkZDIG1haWwgClsxXS4KPiBTaW5jZSB2ZXJpZmllcnMgbGlrZSBLZXlsaW1l
IGFyZSBhbHJlYWR5IHVzaW5nIHRoaXMgYmVnaW5uaW5nIGFuZCBlbmQKPiBxdW90ZSBmb3Igc2hh
cmRlZCBsb2dzLCBpdCdzIHRoZSBtb3N0IG5hdHVyYWwgZm9ybWF0IHRvIGZlZWQgdG8KPiBzb21l
dGhpbmcgZXh0ZXJuYWxseSBmb3IgdmVyaWZpY2F0aW9uIGFuZCBpdCBtZWFucyB5b3UgZG9uJ3Qg
aGF2ZSB0bwo+IGludmVudCBhIG5ldyBmb3JtYXQgdG8gZG8gdGhlIHNhbWUgdGhpbmcuCkNvdWxk
IHlvdSBwbGVhc2UgcG9pbnQgdG8gdGhlIEtleWxpbWUgc291cmNlIGFuZC9vciBkb2N1bWVudGF0
aW9uCndoaWNoIGV4cGxhaW5zIHRoZSB1c2Ugb2YgYmVnaW5uaW5nIGFuZCBlbmQgcXVvdGVzPyBX
ZSB3b3VsZCBsaWtlIHRvCnVuZGVyc3RhbmQgaG93IHRoZSB2ZXJpZmllcnMgYXJlIGFkZHJlc3Np
bmcgdGhpcyBwcm9ibGVtIGN1cnJlbnRseS4KCgpbMV0gCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC9jNTczNzE0MS03ODI3LTFjODMtYWIzOC0wMTE5ZGNmZWE0ODVAbGludXgubWljcm9zb2Z0
LmNvbS8jdAoKflR1c2hhcgo+Cj4gUmVnYXJkcywKPgo+IEphbWVzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=

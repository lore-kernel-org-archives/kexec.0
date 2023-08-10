Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC10AC001DB
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 04:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EbLB8vFEX49Nbrg1Cz3YB5zUkuSh1Pze62Bz7VtPY24=; b=wPd1BqOCThpKJo
	EcglldotHjx8s7UiaQvLIJ/mpcHc3D9AFf+xjgzzmyNqL1qVtWMvkLACA3lk/N+Nxw0kxLJVWSNgn
	1C+OBIiSdCML2hkp7IjOceHbzyKIqe714Ag7OsFe4t8uO4Wx4bA2o07xYs7yc079fRyB06tJzsP/J
	mky53/GOVnFKn03jXa71GzvB6fMFsguW2AZ74XFBYcZpT/63udPlQVFg+462wkrbEr9Wkcvm5qEp2
	uw4/Ff/vBKeQewEqScim+8oL2atnyBKHMrdxl44eSuvLIw4iL3PY4zEOF/s3+ivrK3m71SsahpLhF
	NXEEfJ+sACU3MssbfBkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTxJG-006VIf-2U;
	Thu, 10 Aug 2023 04:30:06 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTxJD-006VHf-2U
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 04:30:05 +0000
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1347020FC4FB;
	Wed,  9 Aug 2023 21:30:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1347020FC4FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691641800;
	bh=k31hLNuy3uVy7+4q9DCDJvSzlz9LoI8LcuQobinX960=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fw7sGXJfrYeAkbPYvDkT1MmuGouPoieRPBhzdqLDGsnYZeYErQE4nTEIg7mTLd/ei
	 P2PwqceyzN0f15F9tSkb/9UY/ITfUUrfsQwVC1TgWUwxwXwQwm60u319da9vyK0D2R
	 F01mya1gN4d6O2qOqaDhq/UzrsJi9kLNSsdrHHxY=
Message-ID: <480fb280-90ef-73c9-42cf-d72c76267259@linux.microsoft.com>
Date: Wed, 9 Aug 2023 21:29:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, zohar@linux.ibm.com, peterhuewe@gmx.de,
 jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
 jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com,
 linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_213003_868955_B6161B98 
X-CRM114-Status: GOOD (  21.56  )
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

CgpPbiA4LzgvMjMgMDY6MzEsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4KPgo+IE9uIDgvOC8yMyAw
ODozNSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+PiBPbiBNb24sIDIwMjMtMDgtMDcgYXQgMTg6
NDkgLTA0MDAsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4+Pgo+Pj4KPj4+IE9uIDgvMS8yMyAxNzoy
MSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+Pj4+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAxMjox
MiAtMDcwMCwgU3VzaCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPj4+PiBbLi4uXQo+Pj4+PiBUcnVu
Y2F0aW5nIElNQSBsb2cgdG8gcmVjbGFpbSBtZW1vcnkgaXMgbm90IGZlYXNpYmxlLCBzaW5jZSBp
dAo+Pj4+PiBtYWtlcyB0aGUgbG9nIGdvIG91dCBvZiBzeW5jIHdpdGggdGhlIFRQTSBQQ1IgcXVv
dGUgbWFraW5nIHJlbW90ZQo+Pj4+PiBhdHRlc3RhdGlvbiBmYWlsLgo+Pj4+Cj4+Pj4gVGhpcyBh
c3N1bXB0aW9uIGlzbid0IGVudGlyZWx5IHRydWUuwqAgSXQncyBwZXJmZWN0bHkgcG9zc2libGUg
dG8KPj4+PiBzaGFyZCBhbiBJTUEgbG9nIHVzaW5nIHR3byBUUE0yX1F1b3RlJ3MgZm9yIHRoZSBi
ZWdpbm5pbmcgYW5kIGVuZAo+Pj4+IFBDUiB2YWx1ZXMgdG8gdmFsaWRhdGUgdGhlIHNoYXJkLsKg
IFRoZSBJTUEgbG9nIGNvdWxkIGJlIHRydW5jYXRlZAo+Pj4+IGluIHRoZSBzYW1lIHdheSAocmVw
bGFjZSB0aGUgcmVtb3ZlZCBwYXJ0IG9mIHRoZSBsb2cgd2l0aCBhCj4+Pj4gVFBNMl9RdW90ZSBh
bmQgQUssIHNvIHRoZSBsb2cgc3RpbGwgdmFsaWRhdGVzIGZyb20gdGhlIGJlZ2lubmluZwo+Pj4+
IHF1b3RlIHRvIHRoZSBlbmQpLgo+Pj4+Cj4+Pj4gSWYgeW91IHVzZSBhIFRQTTJfUXVvdGUgbWVj
aGFuaXNtIHRvIHNhdmUgdGhlIGxvZywgYWxsIHlvdSBuZWVkIHRvCj4+Pj4gZG8gaXMgaGF2ZSB0
aGUga2VybmVsIGdlbmVyYXRlIHRoZSBxdW90ZSB3aXRoIGFuIGludGVybmFsIEFLLsKgIFlvdQo+
Pj4+IGNhbiBrZWVwIGEgcmVjb3JkIG9mIHRoZSBxdW90ZSBhbmQgdGhlIEFLIGF0IHRoZSBiZWdp
bm5pbmcgb2YgdGhlCj4+Pj4gdHJ1bmNhdGVkIGtlcm5lbCBsb2cuwqAgSWYgdGhlIHRydW5jYXRl
ZCBlbnRyaWVzIGFyZSBzYXZlZCBpbiBhIGZpbGUKPj4+PiBzaGFyZCBpdAo+Pj4KPj4+IFRoZSB0
cnVuY2F0aW9uIHNlZW1zIGRhbmdlcm91cyB0byBtZS4gTWF5YmUgbm90IGFsbCB0aGUgc2NlbmFy
aW9zCj4+PiB3aXRoIGFuIGF0dGVzdGF0aW9uIGNsaWVudCAoY2xpZW50ID0gcmVhZGluZyBsb2dz
IGFuZCBxdW90aW5nKSBhcmUKPj4+IHBvc3NpYmxlIHRoZW4gYW55bW9yZSwgc3VjaCBhcyBzdGFy
dGluZyBhbiBhdHRlc3RhdGlvbiBjbGllbnQgb25seQo+Pj4gYWZ0ZXIgdHJ1bmNhdGlvbiBidXQg
YSB2ZXJpZmllciBtdXN0IGhhdmUgd2l0bmVzc2VkIHRoZSBzeXN0ZW0ncyBQQ1JzCj4+PiBhbmQg
bG9nIHN0YXRlIGJlZm9yZSB0aGUgdHJ1bmNhdGlvbiBvY2N1cnJlZC4KPj4KPj4gVGhhdCdzIG5v
dCBleGFjdGx5IGNvcnJlY3QuwqAgTm90aGluZyBuZWVkcyB0byBoYXZlICJ3aXRuZXNzZWQiIHRo
ZQo+PiBzdGFydGluZyBQQ1IgdmFsdWUgYmVjYXVzZSB0aGUgcXVvdGUgdm91Y2hlcyBmb3IgaXQg
KGFuZCBjYW4gdm91Y2ggZm9yCj4+IGl0IGFmdGVyIHRoZSBmYWN0KS7CoCBUaGUgb25seSB0aGlu
ZyB5b3UgbmVlZCB0byB2ZXJpZnkgdGhlIHF1b3RlIGlzIHRoZQo+PiBhdHRlc3RhdGlvbiBrZXkg
YW5kIHRoZSBvbmx5IHRoaW5nIHlvdSBuZWVkIHRvIGRvIHRvIHRydXN0IHRoZT4gCj4+IGF0dGVz
dGF0aW9uIGtleSBpcyBlbnN1cmUgaXQgd2FzIFRQTSBjcmVhdGVkLsKgIEFsbCBvZiB0aGF0IGNh
biBiZQo+PiB2ZXJpZmllZCBhZnRlciB0aGUgZmFjdCBhcyB3ZWxsLsKgIFRoZSBvbmx5IHRoaW5n
IHRoYXQgY2FuIGJlIGRvbmUgdG8KPj4gZGlzcnVwdCB0aGlzIGlzIHRvIGRlc3Ryb3kgdGhlIFRQ
TSAob3IgcmUtb3duIGl0KS4+IFJlbWVtYmVyIHRoZSAKPj4gYXNzdW1wdGlvbiBpcyB5b3UgKmFs
c28qIGhhdmUgdGhlIHJlbW92ZWQgbG9nIHNoYXJkIHRvCj4+IHByZXNlbnQuwqAgRnJvbSB0aGF0
IHRoZSBQQ1Igc3RhdGUgb2YgdGhlIHN0YXJ0aW5nIHF1b3RlIGNhbiBiZQo+Cj4gWWVzLCB0aGUg
d2hvbGUgc2VxdWVuY2Ugb2Ygb2xkIGxvZ3MgbmVlZHMgdG8gYmUgYXZhaWxhYmxlLiBJRiB0aGF0
J3MgdGhlCj4gY2FzZSBhbmQgdGhlIGxvZ3MgY2FuIGJlIHN0aXRjaGVkIHRvZ2V0aGVyIHNlYW1s
ZXNzbHksIHdobyB0aGVuIGxvb2tzIAo+IGF0IHRoZQo+IGtlcm5lbCBBSyBxdW90ZSBhbmQgdW5k
ZXIgd2hhdCBjaXJjdW1zdGFuY2VzPwo+CkphbWVzIGhhcyBhZGRyZXNzZWQgdGhpcyBxdWVzdGlv
biBpbiBoaXMgcmVzcG9uc2UgdG8gdGhpcyBtZXNzYWdlIFsxXS4KClRoYW5rcyBKYW1lcy4KClsx
XSAKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzM1MGVjZGNiZjc3OTZmNDg4ODA3ZmNkNzk4
MzQxNGEwMmRkNzFiZTQuY2FtZWxASGFuc2VuUGFydG5lcnNoaXAuY29tLyNyIAoKCn5UdXNoYXIK
Cj4+IGNhbGN1bGF0ZWQgYW5kIGNoZWNrZWQgZm9yIG1hdGNoaW5nIHRoZSBxdW90ZS7CoCBJZiB5
b3UgbG9zZSB0aGF0LCBpdCdzCj4+IGVxdWl2YWxlbnQgdG8gdGhlIGxvZyBiZWluZyB0YW1wZXJl
ZCB3aXRoIGFuZCBhbGwgYmV0cyBhcmUgb2ZmLiBUaGUKPj4gYXNzdW1wdGlvbiBpcyB0aGF0IGJl
Y2F1c2Ugb2YgdGhlIGltcG9zc2liaWxpdHkgb2YgZW5naW5lZXJpbmcgVFBNCj4+IGV4dGVuc2lv
bnMsIGl0IHNob3VsZCBiZSBpbXBvc3NpYmxlIHRvIGNvbWUgdXAgd2l0aCBhIGZha2UgbG9nIHRo
YXQKPj4gcHJvZHVjZXMgdGhlIFBDUnMgb2YgdGhlIHJlYWwgb25lLsKgIElmIHRoYXQncyB2aW9s
YXRlZCwgdGhlbiBJTUEgaXRzZWxmCj4+IGJlY29tZXMgdXNlbGVzcy4KPj4KPj4gSmFtZXMKPj4K
Pj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4g
a2V4ZWMgbWFpbGluZyBsaXN0Cj4+IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK

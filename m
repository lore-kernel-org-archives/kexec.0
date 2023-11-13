Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C84EC4332F
	for <kexec@archiver.kernel.org>; Mon, 13 Nov 2023 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NMkFGWqKhzwStE8IzZlbbo45T3OY8p3FbXOyV9dnCxs=; b=RCrdxv3uXITn6a
	k6rdfalW0j6lAKlFYfSRgyS6V7bwxCk6AfmDwMf2tRrMlMU5FphLIZufd190qzVfSEvSaX8B+1auE
	JNKQBI2hBTScJGGn9+Ue2kPKpBFaLKzQSL81tTV26fkxS3FmboCUV53k7238PU+MlTZp16TOJf0EV
	Ek+FmZTmAJbX7T6ZpA2hv4F8Vwqt050WouckbX79xpslr3KZEsE+mM6bn0ds1ynREHre7wqyPEsbd
	+iWS+1p+stM7D+lBk6oo74bGsM6W6bTh0QY4KWkcb81JzlixrwNVjnAwFYBSTKpBadMIwjqSgKO7g
	nj/6YoDp73IISPdjPvlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2bSK-00EUDR-2l;
	Mon, 13 Nov 2023 18:14:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2bSG-00EUD1-1v
	for kexec@lists.infradead.org;
	Mon, 13 Nov 2023 18:14:37 +0000
Received: from [10.137.114.52] (unknown [131.107.159.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5F7F20B74C1;
	Mon, 13 Nov 2023 10:14:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5F7F20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699899275;
	bh=PQZ5UmPmG9pef+E8G3YPru2uMvofveJcbTaptSpXym8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=If6jd5xAyRgPs1mkzjtt0JuLiVptdwy3eAWFRmV0jEc6GBjz9CKpOBgCdemAX9/OQ
	 BUcs3cRJYY9NUnjcxmMd8YbDg5IN0bJQnobcdzFp2exSnOMR7/PVaz3vPz+nbFH/z+
	 16Yr5nQc2vWnH3kaKyVCXQd87neogo/GzKDQeza8=
Message-ID: <86366328-512e-47a0-950d-450412319c26@linux.microsoft.com>
Date: Mon, 13 Nov 2023 10:14:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Ken Goldman <kgold@linux.ibm.com>,
 Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 bhe@redhat.com, vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Content-Language: en-US
From: Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_101436_697294_0D840F10 
X-CRM114-Status: GOOD (  16.02  )
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

CgpPbiAxMC8zMS8yMDIzIDExOjM3IEFNLCBLZW4gR29sZG1hbiB3cm90ZToKPiBPbiAxMC8xOS8y
MDIzIDI6NDkgUE0sIFR1c2hhciBTdWdhbmRoaSB3cm90ZToKPj4gwqDCoCBmLiBBIG5ldyBldmVu
dCwgInNuYXBzaG90X2FnZ3JlZ2F0ZSIsIHdpbGwgYmUgY29tcHV0ZWQgYW5kIG1lYXN1cmVkCj4+
IMKgwqDCoMKgwqDCoMKgIGluIHRoZSBJTUEgbG9nIGFzIHBhcnQgb2YgdGhpcyBmZWF0dXJlLsKg
IEl0IHNob3VsZCBoZWxwIHRoZQo+PiDCoMKgwqDCoMKgwqDCoCByZW1vdGUtYXR0ZXN0YXRpb24g
Y2xpZW50L3NlcnZpY2UgdG8gYmVuZWZpdCBmcm9tIHRoZSBJTUEgbG9nCj4+IMKgwqDCoMKgwqDC
oMKgIHNuYXBzaG90IGZlYXR1cmUuCj4+IMKgwqDCoMKgwqDCoMKgIFRoZSAic25hcHNob3RfYWdn
cmVnYXRlIiBldmVudCBpcyBkZXNjcmliZWQgaW4gbW9yZSBkZXRhaWxzIGluCj4+IMKgwqDCoMKg
wqDCoMKgIHNlY3Rpb24gIkQuMSBTbmFwc2hvdCBBZ2dyZWdhdGUgRXZlbnQiIGJlbG93Lgo+Cj4g
V2hhdCBpcyB0aGUgdXNlIGNhc2UgZm9yIHRoZSBzbmFwc2hvdCBhZ2dyZWdhdGU/wqAgTXkgdGhp
bmtpbmcgaXM6Cj4KPiAxLiBUaGUgcGxhdGZvcm0gbXVzdCByZXRhaW4gdGhlIGVudGlyZSBtZWFz
dXJlbWVudCBsaXN0LsKgIEVhcmx5IAo+IG1lYXN1cmVtZW50cyBjYW4gbmV2ZXIgYmUgZGlzY2Fy
ZGVkIGJlY2F1c2UgYSBuZXcgcXVvdGUgdmVyaWZpZXIKPiBtdXN0IHJlY2VpdmUgdGhlIGVudGly
ZSBsb2cgc3RhcnRpbmcgYXQgdGhlIGZpcnN0IG1lYXN1cmVtZW50Lgo+Cj4gSW4gdGhpcyBjYXNl
LCBpc24ndCB0aGUgc25hcHNob3QgYWdncmVnYXRlIHJlZHVuZGFudD8KTm90IHF1aXRlLiBUaGUg
c25hcHNob3QgYWdncmVnYXRlIHN0aWxsIGhhcyBhIHB1cnBvc2UsIHdoaWNoIGlzIHRvIHN0aXRj
aAp0b2dldGhlciB0aGUgc25hcHNob3RzIG9uIHRoZSBkaXNrIGFuZCB0aGUgaW4tbWVtb3J5IHNl
Z21lbnQgb2YgdGhlIElNQQpsb2cuIFRoZSBzcGVjaWZpYyBkZXRhaWxzIGFyZSBpbiB0aGUgUkZD
IFNlY3Rpb24gRC4xLCBxdW90ZWQgaGVyZToKClRoZSAic25hcHNob3RfYWdncmVnYXRlIiBtYXJr
ZXIgcHJvdmlkZXMgdGhlIGZvbGxvd2luZyBiZW5lZml0czoKCmEuIEl0IGZhY2lsaXRhdGVzIHRo
ZSBJTUEgbG9nIHRvIGJlIGRpdmlkZWQgaW50byBtdWx0aXBsZSBjaHVua3MgYW5kCnByb3ZpZGVz
IG1lY2hhbmlzbSB0byB2ZXJpZnkgdGhlIGludGVncml0eSBvZiB0aGUgc3lzdGVtIHVzaW5nIG9u
bHkgdGhlCmxhdGVzdCBjaHVua3MgZHVyaW5nIHJlbW90ZSBhdHRlc3RhdGlvbi4KCmIuIEl0IHBy
b3ZpZGVzIHRhbmdpYmxlIGV2aWRlbmNlIGZyb20gS2VybmVsIHRvIHRoZSBhdHRlc3RhdGlvbiBj
bGllbnQKdGhhdCBJTUEgbG9nIHNuYXBzaG90dGluZyBoYXMgYmVlbiBlbmFibGVkIGFuZCBhdCBs
ZWFzdCBvbmUgc25hcHNob3QKZXhpc3RzIG9uIHRoZSBzeXN0ZW0uCgpjLiBJdCBoZWxwcyBib3Ro
IHRoZSBLZXJuZWwgYW5kIFVNIGF0dGVzdGF0aW9uIGNsaWVudCBkZWZpbmUgY2xlYXIKYm91bmRh
cmllcyBiZXR3ZWVuIG11bHRpcGxlIHNuYXBzaG90cy4KCmQuIEluIHRoZSBldmVudCBvZiBtdWx0
aXBsZSBzbmFwc2hvdHMsIHRoZSBsYXN0IG1lYXN1cmVkCiJzbmFwc2hvdF9hZ2dyZWdhdGUiIG1h
cmtlciwgd2hpY2ggaXMgcHJlc2VudCBpbiB0aGUgY3VycmVudCBzZWdtZW50IG9mCnRoZSBJTUEg
bG9nLCBoYXMgc3VmZmljaWVudCBpbmZvcm1hdGlvbiB0byB2ZXJpZnkgdGhlIGludGVncml0eSBv
ZiB0aGUKSU1BIGxvZyBzZWdtZW50IGFzIHdlbGwgYXMgdGhlIHByZXZpb3VzIHNuYXBzaG90cyB1
c2luZyB0aGUgUENSIHF1b3Rlcy4KCmUuIEluIHRoZSBldmVudCBvZiBtdWx0aXBsZSBzbmFwc2hv
dHMsIHNheSBOLCBpZiB0aGUgcmVtb3RlLWF0dGVzdGF0aW9uCnNlcnZpY2UgaGFzIGFscmVhZHkg
cHJvY2Vzc2VkIHRoZSBsYXN0IE4tMSBzbmFwc2hvdHMsIGl0IGNhbiBlZmZpY2llbnRseQpwYXJz
ZSB0aHJvdWdoIHRoZW0gYnkganVzdCBwcm9jZXNzaW5nICJzbmFwc2hvdF9hZ2dyZWdhdGUiIGV2
ZW50cyB0bwpjb21wdXRlIHRoZSBQQ1IgcXVvdGVzIG5lZWRlZCB0byB2ZXJpZnkgdGhlIGV2ZW50
cyBpbiB0aGUgbGFzdCBzbmFwc2hvdC4KVGhpcyBzaG91bGQgZHJhc3RpY2FsbHkgaW1wcm92ZSB0
aGUgSU1BIGxvZyBwcm9jZXNzaW5nIGVmZmljaWVuY3kgb2YKdGhlIHNlcnZpY2UuCgo+Cj4gMi4g
VGhlcmUgaXMgYSBkaXNhZHZhbnRhZ2UgdG8gcmVkdW5kYW50IGRhdGEuwqAgVGhlIHZlcmlmaWVy
IG11c3QgCj4gc3VwcG9ydCB0aGlzIG5ldyBldmVudCB0eXBlLiBJdCByZWNlaXZlcyB0aGlzIGV2
ZW50IGFuZCBtdXN0IHZhbGlkYXRlIAo+IHRoZSBhZ2dyZWdhdGUgYWdhaW5zdCB0aGUgc25hcHNo
b3QtZWQgZXZlbnRzLiBUaGlzIGlzIGFuIGF0dGFjayAKPiBzdXJmYWNlLiBUaGUgYXR0YWNrZXIg
Y2FuIHNlbmQgYW4gYWdncmVnYXRlIGFuZCBzbmFwc2hvdC1lZCAKPiBtZWFzdXJlbWVudHMgdGhh
dCBkbyBub3QgbWF0Y2ggdG8gZXhwbG9pdCBhIGZsYXcgaW4gdGhlIHZlcmlmaWVyLgpJIGRpc2Fn
cmVlIHdpdGggdGhpcy7CoCBSZWR1bmRhbmN5IGlzIGEgbW9vdCBwb2ludCBiZWNhdXNlCiJzbmFw
c2hvdF9hZ2dyZWdhdGUiIGlzIHJlcXVpcmVkIGZvciB0aGUgcG9pbnRzIG1lbnRpb25lZCBhYm92
ZS4KLSBTdXNoCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

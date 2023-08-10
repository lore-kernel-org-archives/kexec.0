Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73182C001E0
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 01:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yeZq10ptpWl+eioBvSH0UwABlt1wYWsKebfdwUHxM/o=; b=gHVrJQ5trcT3uA
	C9OyPTizWFY210o+APgz8YJo5vs98lJGEDVwpFt/A++cZ9wpK7CWh0Ak4/e3OTsr3hbKJRxYSOuPH
	iVMNTKke5Pr4wEQ3ETIHioE2fs22IBPjuM/0FGhPtQpSwzrjl/hX5SS91+u5DuSdKv52XexKBCpWV
	ubaHY6eMaVblH4jsF0cyajoUl2Y2Qrv1jmqWcAX0QH4OgPxLi178tz0uUhpcMeBwUKyuzAe3bDZqS
	3ai4s/NLMyiE2Gq37z3cXB8s65SHimYKBKTZjTRVEbl47e1S86BsbIBI5Y1V7KF8Q+ynR0X2F1/lp
	q2HP2kn+pCB4bMpOiX6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTuOI-006H2r-1I;
	Thu, 10 Aug 2023 01:23:06 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTuOF-006H2S-1O
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 01:23:04 +0000
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 306FA207F5A7;
	Wed,  9 Aug 2023 18:23:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 306FA207F5A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691630582;
	bh=bnyN1ioY9d5da9MP76r8u/PYucM9RcXgBXwj7glxDzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J73xUhApar6cGSwznTcwtaXCRZweAtzrglnLh+E41AtN8uxrbnvZMEIto5To7NMm1
	 0Kcs5lCVhAdz7blS893tvpaW207q2vrvAEK1DP+ok+sDotcBfVSNhTZk42oFR4InJM
	 QVWIMvWNqtZdRJ/B/lSziLwOCRX9sGx3CVWe60f0=
Message-ID: <72f195f3-d96e-c516-d9e6-983ad7f86cdc@linux.microsoft.com>
Date: Wed, 9 Aug 2023 18:23:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_182303_520729_07700037 
X-CRM114-Status: GOOD (  21.30  )
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

aGkgSmFtZXMsClRoYW5rcyBmb3IgYWRkcmVzc2luZyBTdGVmYW4ncyBjb25jZXJucy4KCk9uIDgv
OC8yMyAwNTozNSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+IE9uIE1vbiwgMjAyMy0wOC0wNyBh
dCAxODo0OSAtMDQwMCwgU3RlZmFuIEJlcmdlciB3cm90ZToKPj4KPj4gT24gOC8xLzIzIDE3OjIx
LCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4+PiBPbiBUdWUsIDIwMjMtMDgtMDEgYXQgMTI6MTIg
LTA3MDAsIFN1c2ggU2hyaW5nYXJwdXRhbGUgd3JvdGU6Cj4+PiBbLi4uXQo+Pj4+IFRydW5jYXRp
bmcgSU1BIGxvZyB0byByZWNsYWltIG1lbW9yeSBpcyBub3QgZmVhc2libGUsIHNpbmNlIGl0Cj4+
Pj4gbWFrZXMgdGhlIGxvZyBnbyBvdXQgb2Ygc3luYyB3aXRoIHRoZSBUUE0gUENSIHF1b3RlIG1h
a2luZyByZW1vdGUKPj4+PiBhdHRlc3RhdGlvbiBmYWlsLgo+Pj4gVGhpcyBhc3N1bXB0aW9uIGlz
bid0IGVudGlyZWx5IHRydWUuwqAgSXQncyBwZXJmZWN0bHkgcG9zc2libGUgdG8KPj4+IHNoYXJk
IGFuIElNQSBsb2cgdXNpbmcgdHdvIFRQTTJfUXVvdGUncyBmb3IgdGhlIGJlZ2lubmluZyBhbmQg
ZW5kCj4+PiBQQ1IgdmFsdWVzIHRvIHZhbGlkYXRlIHRoZSBzaGFyZC7CoCBUaGUgSU1BIGxvZyBj
b3VsZCBiZSB0cnVuY2F0ZWQKPj4+IGluIHRoZSBzYW1lIHdheSAocmVwbGFjZSB0aGUgcmVtb3Zl
ZCBwYXJ0IG9mIHRoZSBsb2cgd2l0aCBhCj4+PiBUUE0yX1F1b3RlIGFuZCBBSywgc28gdGhlIGxv
ZyBzdGlsbCB2YWxpZGF0ZXMgZnJvbSB0aGUgYmVnaW5uaW5nCj4+PiBxdW90ZSB0byB0aGUgZW5k
KS4KPj4+Cj4+PiBJZiB5b3UgdXNlIGEgVFBNMl9RdW90ZSBtZWNoYW5pc20gdG8gc2F2ZSB0aGUg
bG9nLCBhbGwgeW91IG5lZWQgdG8KPj4+IGRvIGlzIGhhdmUgdGhlIGtlcm5lbCBnZW5lcmF0ZSB0
aGUgcXVvdGUgd2l0aCBhbiBpbnRlcm5hbCBBSy7CoCBZb3UKPj4+IGNhbiBrZWVwIGEgcmVjb3Jk
IG9mIHRoZSBxdW90ZSBhbmQgdGhlIEFLIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlCj4+PiB0cnVu
Y2F0ZWQga2VybmVsIGxvZy7CoCBJZiB0aGUgdHJ1bmNhdGVkIGVudHJpZXMgYXJlIHNhdmVkIGlu
IGEgZmlsZQo+Pj4gc2hhcmQgaXQKPj4gVGhlIHRydW5jYXRpb24gc2VlbXMgZGFuZ2Vyb3VzIHRv
IG1lLiBNYXliZSBub3QgYWxsIHRoZSBzY2VuYXJpb3MKPj4gd2l0aCBhbiBhdHRlc3RhdGlvbiBj
bGllbnQgKGNsaWVudCA9IHJlYWRpbmcgbG9ncyBhbmQgcXVvdGluZykgYXJlCj4+IHBvc3NpYmxl
IHRoZW4gYW55bW9yZSwgc3VjaCBhcyBzdGFydGluZyBhbiBhdHRlc3RhdGlvbiBjbGllbnQgb25s
eQo+PiBhZnRlciB0cnVuY2F0aW9uIGJ1dCBhIHZlcmlmaWVyIG11c3QgaGF2ZSB3aXRuZXNzZWQg
dGhlIHN5c3RlbSdzIFBDUnMKPj4gYW5kIGxvZyBzdGF0ZSBiZWZvcmUgdGhlIHRydW5jYXRpb24g
b2NjdXJyZWQuCj4gVGhhdCdzIG5vdCBleGFjdGx5IGNvcnJlY3QuICBOb3RoaW5nIG5lZWRzIHRv
IGhhdmUgIndpdG5lc3NlZCIgdGhlCj4gc3RhcnRpbmcgUENSIHZhbHVlIGJlY2F1c2UgdGhlIHF1
b3RlIHZvdWNoZXMgZm9yIGl0IChhbmQgY2FuIHZvdWNoIGZvcgo+IGl0IGFmdGVyIHRoZSBmYWN0
KS4gIFRoZSBvbmx5IHRoaW5nIHlvdSBuZWVkIHRvIHZlcmlmeSB0aGUgcXVvdGUgaXMgdGhlCj4g
YXR0ZXN0YXRpb24ga2V5IGFuZCB0aGUgb25seSB0aGluZyB5b3UgbmVlZCB0byBkbyB0byB0cnVz
dCB0aGUKPiBhdHRlc3RhdGlvbiBrZXkgaXMgZW5zdXJlIGl0IHdhcyBUUE0gY3JlYXRlZC4gIEFs
bCBvZiB0aGF0IGNhbiBiZQo+IHZlcmlmaWVkIGFmdGVyIHRoZSBmYWN0IGFzIHdlbGwuICBUaGUg
b25seSB0aGluZyB0aGF0IGNhbiBiZSBkb25lIHRvCj4gZGlzcnVwdCB0aGlzIGlzIHRvIGRlc3Ry
b3kgdGhlIFRQTSAob3IgcmUtb3duIGl0KS4KQWdyZWVkLgo+Cj4gUmVtZW1iZXIgdGhlIGFzc3Vt
cHRpb24gaXMgeW91ICphbHNvKiBoYXZlIHRoZSByZW1vdmVkIGxvZyBzaGFyZCB0bwo+IHByZXNl
bnQuICBGcm9tIHRoYXQgdGhlIFBDUiBzdGF0ZSBvZiB0aGUgc3RhcnRpbmcgcXVvdGUgY2FuIGJl
Cj4gY2FsY3VsYXRlZCBhbmQgY2hlY2tlZCBmb3IgbWF0Y2hpbmcgdGhlIHF1b3RlLiAgSWYgeW91
IGxvc2UgdGhhdCwgaXQncwo+IGVxdWl2YWxlbnQgdG8gdGhlIGxvZyBiZWluZyB0YW1wZXJlZCB3
aXRoIGFuZCBhbGwgYmV0cyBhcmUgb2ZmLiAgVGhlCj4gYXNzdW1wdGlvbiBpcyB0aGF0IGJlY2F1
c2Ugb2YgdGhlIGltcG9zc2liaWxpdHkgb2YgZW5naW5lZXJpbmcgVFBNCj4gZXh0ZW5zaW9ucywg
aXQgc2hvdWxkIGJlIGltcG9zc2libGUgdG8gY29tZSB1cCB3aXRoIGEgZmFrZSBsb2cgdGhhdAo+
IHByb2R1Y2VzIHRoZSBQQ1JzIG9mIHRoZSByZWFsIG9uZS4gIElmIHRoYXQncyB2aW9sYXRlZCwg
dGhlbiBJTUEgaXRzZWxmCj4gYmVjb21lcyB1c2VsZXNzLgpUb3RhbGx5IGFncmVlZC4gSSBiZWxp
ZXZlIG91ciBwcm9wb3NhbCBpcyBjb25zaXN0ZW50IHdpdGggeW91cgpjb21tZW50cy4gUGxlYXNl
IGxldCB1cyBrbm93IGlmIHlvdSBzZWUgYW55IGluY29uc2lzdGVuY2llcyBvciB0ZWNobmljYWwK
YmxvY2tlcnMuCgp+VHVzaGFyCgo+Cj4gSmFtZXMKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==

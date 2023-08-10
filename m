Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56185C001DB
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 04:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0NVF35/fdYzEDM9n57B3STw26pzmJ39sPu07pJk/1LM=; b=jCxjCMa1eP/ii8
	B/OIHtIenfrcoyhkhoGeAgqLhAeKJM9KgE9yz2PqEPlSAXfsqGmzEMTM+Mf+OafyzTU7pH73mzd6F
	tuTmvBH0RSvvf66JZmdTAZKVh7QzeZ2rLvnfX/uAzQhKNzXUDQPoUST1GCPTZDFwral+x3g81ovoU
	6VEPN8stSCWCFymtfj+lkmWirnG28B5SirDeIKlhUn0kd6kMsjjNYiupo3qo/QYiGm39sFohiXwTy
	uFvdGEvtYoh9Wo3hlHIe4uAjLGgbYi2KTvFZMYKXvtZTuzLyeFHjmRH46GXhqu4HnggvPhu5DTEsH
	kKth6JhzTn1Otqm8APRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTxKm-006VPv-0G;
	Thu, 10 Aug 2023 04:31:40 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTxKj-006VPQ-0J
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 04:31:38 +0000
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2002820FC4EA;
	Wed,  9 Aug 2023 21:31:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2002820FC4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1691641896;
	bh=nraAPWOICvNXkZftejzgjjq0Wg6iJe2sFPMDKZdWoRg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BAjmFHtw0r59qAg2VS0JDt720MQZXxOpcR45G0eHR7t2LNeR9eNroaB+cHO0gqPd+
	 8YTgwP708jbMz2PahIx238OzmSBkSKvtsZzk+R+FqtSBFfdvbuzq4SBOqtf55oBj5W
	 T877ETAip+1R/gNsT0bC8I6cQ0SYHBTuy1TWXUXs=
Message-ID: <2f60bc38-6a9e-6a2d-038d-cd3daf46faf2@linux.microsoft.com>
Date: Wed, 9 Aug 2023 21:31:35 -0700
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
 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
 <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_213137_186445_ABA3F20A 
X-CRM114-Status: GOOD (  22.46  )
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

CgpPbiA4LzgvMjMgMTE6MjYsIEphbWVzIEJvdHRvbWxleSB3cm90ZToKPiBPbiBUdWUsIDIwMjMt
MDgtMDggYXQgMDk6MzEgLTA0MDAsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6Cj4+Cj4+IE9uIDgvOC8y
MyAwODozNSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+Pj4gT24gTW9uLCAyMDIzLTA4LTA3IGF0
IDE4OjQ5IC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+Pj4+Cj4+Pj4gT24gOC8xLzIzIDE3
OjIxLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4+Pj4+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAx
MjoxMiAtMDcwMCwgU3VzaCBTaHJpbmdhcnB1dGFsZSB3cm90ZToKPj4+Pj4gWy4uLl0KPj4+Pj4+
IFRydW5jYXRpbmcgSU1BIGxvZyB0byByZWNsYWltIG1lbW9yeSBpcyBub3QgZmVhc2libGUsIHNp
bmNlCj4+Pj4+PiBpdCBtYWtlcyB0aGUgbG9nIGdvIG91dCBvZiBzeW5jIHdpdGggdGhlIFRQTSBQ
Q1IgcXVvdGUgbWFraW5nCj4+Pj4+PiByZW1vdGUgYXR0ZXN0YXRpb24gZmFpbC4KPj4+Pj4gVGhp
cyBhc3N1bXB0aW9uIGlzbid0IGVudGlyZWx5IHRydWUuwqAgSXQncyBwZXJmZWN0bHkgcG9zc2li
bGUKPj4+Pj4gdG8gc2hhcmQgYW4gSU1BIGxvZyB1c2luZyB0d28gVFBNMl9RdW90ZSdzIGZvciB0
aGUgYmVnaW5uaW5nCj4+Pj4+IGFuZCBlbmQgUENSIHZhbHVlcyB0byB2YWxpZGF0ZSB0aGUgc2hh
cmQuwqAgVGhlIElNQSBsb2cgY291bGQgYmUKPj4+Pj4gdHJ1bmNhdGVkIGluIHRoZSBzYW1lIHdh
eSAocmVwbGFjZSB0aGUgcmVtb3ZlZCBwYXJ0IG9mIHRoZSBsb2cKPj4+Pj4gd2l0aCBhIFRQTTJf
UXVvdGUgYW5kIEFLLCBzbyB0aGUgbG9nIHN0aWxsIHZhbGlkYXRlcyBmcm9tIHRoZQo+Pj4+PiBi
ZWdpbm5pbmcgcXVvdGUgdG8gdGhlIGVuZCkuCj4+Pj4+Cj4+Pj4+IElmIHlvdSB1c2UgYSBUUE0y
X1F1b3RlIG1lY2hhbmlzbSB0byBzYXZlIHRoZSBsb2csIGFsbCB5b3UgbmVlZAo+Pj4+PiB0byBk
byBpcyBoYXZlIHRoZSBrZXJuZWwgZ2VuZXJhdGUgdGhlIHF1b3RlIHdpdGggYW4gaW50ZXJuYWwK
Pj4+Pj4gQUsuwqAgWW91IGNhbiBrZWVwIGEgcmVjb3JkIG9mIHRoZSBxdW90ZSBhbmQgdGhlIEFL
IGF0IHRoZQo+Pj4+PiBiZWdpbm5pbmcgb2YgdGhlIHRydW5jYXRlZCBrZXJuZWwgbG9nLsKgIElm
IHRoZSB0cnVuY2F0ZWQKPj4+Pj4gZW50cmllcyBhcmUgc2F2ZWQgaW4gYSBmaWxlIHNoYXJkIGl0
Cj4+Pj4gVGhlIHRydW5jYXRpb24gc2VlbXMgZGFuZ2Vyb3VzIHRvIG1lLiBNYXliZSBub3QgYWxs
IHRoZSBzY2VuYXJpb3MKPj4+PiB3aXRoIGFuIGF0dGVzdGF0aW9uIGNsaWVudCAoY2xpZW50ID0g
cmVhZGluZyBsb2dzIGFuZCBxdW90aW5nKQo+Pj4+IGFyZSBwb3NzaWJsZSB0aGVuIGFueW1vcmUs
IHN1Y2ggYXMgc3RhcnRpbmcgYW4gYXR0ZXN0YXRpb24gY2xpZW50Cj4+Pj4gb25seSBhZnRlciB0
cnVuY2F0aW9uIGJ1dCBhIHZlcmlmaWVyIG11c3QgaGF2ZSB3aXRuZXNzZWQgdGhlCj4+Pj4gc3lz
dGVtJ3MgUENScyBhbmQgbG9nIHN0YXRlIGJlZm9yZSB0aGUgdHJ1bmNhdGlvbiBvY2N1cnJlZC4K
Pj4+IFRoYXQncyBub3QgZXhhY3RseSBjb3JyZWN0LsKgIE5vdGhpbmcgbmVlZHMgdG8gaGF2ZSAi
d2l0bmVzc2VkIiB0aGUKPj4+IHN0YXJ0aW5nIFBDUiB2YWx1ZSBiZWNhdXNlIHRoZSBxdW90ZSB2
b3VjaGVzIGZvciBpdCAoYW5kIGNhbiB2b3VjaAo+Pj4gZm9yIGl0IGFmdGVyIHRoZSBmYWN0KS7C
oCBUaGUgb25seSB0aGluZyB5b3UgbmVlZCB0byB2ZXJpZnkgdGhlCj4+PiBxdW90ZSBpcyB0aGUg
YXR0ZXN0YXRpb24ga2V5IGFuZCB0aGUgb25seSB0aGluZyB5b3UgbmVlZCB0byBkbyB0bwo+Pj4g
dHJ1c3QgdGhlIGF0dGVzdGF0aW9uIGtleSBpcyBlbnN1cmUgaXQgd2FzIFRQTSBjcmVhdGVkLsKg
IEFsbCBvZgo+Pj4gdGhhdCBjYW4gYmUgdmVyaWZpZWQgYWZ0ZXIgdGhlIGZhY3QgYXMgd2VsbC7C
oCBUaGUgb25seSB0aGluZyB0aGF0Cj4+PiBjYW4gYmUgZG9uZSB0byBkaXNydXB0IHRoaXMgaXMg
dG8gZGVzdHJveSB0aGUgVFBNIChvciByZS1vd24gaXQpLj4KPj4+IFJlbWVtYmVyIHRoZSBhc3N1
bXB0aW9uIGlzIHlvdSAqYWxzbyogaGF2ZSB0aGUgcmVtb3ZlZCBsb2cgc2hhcmQgdG8KPj4+IHBy
ZXNlbnQuwqAgRnJvbSB0aGF0IHRoZSBQQ1Igc3RhdGUgb2YgdGhlIHN0YXJ0aW5nIHF1b3RlIGNh
biBiZQo+PiBZZXMsIHRoZSB3aG9sZSBzZXF1ZW5jZSBvZiBvbGQgbG9ncyBuZWVkcyB0byBiZSBh
dmFpbGFibGUuCj4gWWVzIGFuZCBuby4gIElmIHRoZSBwZXJzb24gcmVseWluZyBvbiB0aGUgbG9n
cyBpcyBoYXBweSB0aGV5J3ZlCj4gZXh0cmFjdGVkIGFsbCB0aGUgZXZpZGVudGlhcnkgdmFsdWUg
ZnJvbSB0aGUgbG9nIGl0c2VsZiB0aGVuIHRoZXkgY2FuCj4gcmVkdWNlIHRoZSBwcmVjZWRpbmcg
bG9nIHNoYXJkIHRvIHNpbXBseSB0aGUgUENSIHZhbHVlcyB0aGF0IG1hdGNoIHRoZQo+IHF1b3Rl
IGFuZCBkaXNjYXJkIHRoZSByZXN0Lgo+Cj4+ICAgSUYgdGhhdCdzIHRoZSBjYXNlIGFuZCB0aGUg
bG9ncyBjYW4gYmUgc3RpdGNoZWQgdG9nZXRoZXIgc2VhbWxlc3NseSwKPj4gd2hvIHRoZW4gbG9v
a3MgYXQgdGhlIGtlcm5lbCBBSyBxdW90ZSBhbmQgdW5kZXIgd2hhdCBjaXJjdW1zdGFuY2VzPwo+
IEZvciBpbmNyZW1lbnRhbCBhdHRlc3RhdGlvbi4gIEVhY2ggbG9nIHNoYXJkIGNhbiBiZSB2ZXJp
ZmllZCB1c2luZyB0aGUKPiBiYXNlIFBDUiB2YWx1ZXMgY29ycmVzcG9uZGluZyB0byB0aGUgYm90
dG9tIHF1b3RlIHRoZW4gcmVwbGF5ZWQgYW5kIHRoZQo+IHRvcCBxdW90ZSB2ZXJpZmllZC4gIFRo
aXMgbWVhbnMgdGhhdCBsb2dzIHRoYXQgYXJlbid0IG5lZWRlZCBhbnltb3JlCj4gY2FuIGJlIGRp
c2NhcmRlZCwgd2hpY2gsIEkgcmVjYWxsLCB3YXMgdGhlIGJhc2UgcmVhc29uIGZvciB0aGlzCj4g
cHJvcG9zYWw6IHJlZHVjaW5nIElNQSBtZW1vcnkgY29uc3VtcHRpb24uICBBbHRob3VnaCBhbGwg
eW91IG5lZWQgdG8gZG8KPiBpcyBleHRyYWN0IHRoZSBzaGFyZHMgZnJvbSBrZXJuZWwgbWVtb3J5
IHRvIGZpbGUgc3BhY2UgYW5kIGZyZWUgdGhlCj4ga2VybmVsIG1lbW9yeS4gIFNpbmNlIHRoYXQg
c2NoZW1lIGNhbiBrZWVwIGFsbCBsb2dzIGludGFjdCwgdGhlcmUncyBubwo+IHJlYXNvbiB0byBm
dXJ0aGVyIHJlZHVjZSB0aGVtIHVubGVzcyB0aGUgZmlsZXN5c3RlbSBpcyBydW5uaW5nIG91dCBv
Zgo+IHNwYWNlLgo+Cj4gSmFtZXMKVGhhbmsgeW91IEphbWVzIGZvciBhZGRyZXNzaW5nIFN0ZWZh
buKAmXMgY29uY2VybnMgaGVyZS4KQXBwcmVjaWF0ZSBpdC4KCgp+VHVzaGFyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==

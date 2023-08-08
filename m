Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE18C001B0
	for <kexec@archiver.kernel.org>; Tue,  8 Aug 2023 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XUW90K0vXgG+dS/LyVw54VH4DUcLDh7ETqEvww7H4/c=; b=k8Xb9P1+Ly5tim
	0tjAeSH0pA4DaEdte+yP5RqbzocKM1KBC8H+743+xXuboj8xf3K4Rsap4JbpA98b6LrLudEoJpbZ7
	zZ4D7jJKvEN0/WtJtitHV0GVZKKDDz4yegX3RrXnI7dqrMfy5FK0ozd0RHeo6FmpIAq+v0lqg0VzV
	0elNxydYcwSx8aJ//Qc1goYH3cmi/18rDO3AIjis109B1bvQSN0z14fWUMfZLsXBVDZhbMX9+OrYq
	hDuHOh/gA+GfjkwPQyZ9J7fkPE3kI5sdv/tNMoh8GlAmIpD7Wl4B2DENr9eWQciIH8UfAOrTgJAL8
	6n2KysCMmFYt8wsdhwjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRQ5-003E2Z-1z;
	Tue, 08 Aug 2023 18:27:01 +0000
Received: from bedivere.hansenpartnership.com ([96.44.175.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTRQ2-003E13-0a
	for kexec@lists.infradead.org;
	Tue, 08 Aug 2023 18:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691519214;
	bh=nf3BaQXxRA33pJp2hKQJ3qUrmelsR3GEg4lBetR0PAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=AnuO9/kREwKZFONz5+Ut6FZhZXvoM0vuCQzrlcV00CRLv7xUDw5D5Xqj79fJVyWil
	 WbBQcbiR0vDM2X00epRdX8sVuYliMI1juUyshQl3JTeZL5w8M8VNl79U0XVfspxPoN
	 lo0GMhX5wE75aYSMIqoq+CxDbUe4EDt8CI/aJU48=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id EA32C1281F11;
	Tue,  8 Aug 2023 14:26:54 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id yoVfUEHA7qBG; Tue,  8 Aug 2023 14:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691519214;
	bh=nf3BaQXxRA33pJp2hKQJ3qUrmelsR3GEg4lBetR0PAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=AnuO9/kREwKZFONz5+Ut6FZhZXvoM0vuCQzrlcV00CRLv7xUDw5D5Xqj79fJVyWil
	 WbBQcbiR0vDM2X00epRdX8sVuYliMI1juUyshQl3JTeZL5w8M8VNl79U0XVfspxPoN
	 lo0GMhX5wE75aYSMIqoq+CxDbUe4EDt8CI/aJU48=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 381461281B5C;
	Tue,  8 Aug 2023 14:26:53 -0400 (EDT)
Message-ID: <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Stefan Berger <stefanb@linux.ibm.com>, Sush Shringarputale
 <sushring@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
 zohar@linux.ibm.com, peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, 
 kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, 
 kexec@lists.infradead.org, jmorris@namei.org, Paul Moore
 <paul@paul-moore.com>,  serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com, Tushar Sugandhi
	 <tusharsu@linux.microsoft.com>, linux-security-module@vger.kernel.org
Date: Tue, 08 Aug 2023 14:26:51 -0400
In-Reply-To: <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
	 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
	 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
	 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_112658_229037_950A1DAC 
X-CRM114-Status: GOOD (  32.53  )
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

T24gVHVlLCAyMDIzLTA4LTA4IGF0IDA5OjMxIC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+
IAo+IAo+IE9uIDgvOC8yMyAwODozNSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+ID4gT24gTW9u
LCAyMDIzLTA4LTA3IGF0IDE4OjQ5IC0wNDAwLCBTdGVmYW4gQmVyZ2VyIHdyb3RlOgo+ID4gPiAK
PiA+ID4gCj4gPiA+IE9uIDgvMS8yMyAxNzoyMSwgSmFtZXMgQm90dG9tbGV5IHdyb3RlOgo+ID4g
PiA+IE9uIFR1ZSwgMjAyMy0wOC0wMSBhdCAxMjoxMiAtMDcwMCwgU3VzaCBTaHJpbmdhcnB1dGFs
ZSB3cm90ZToKPiA+ID4gPiBbLi4uXQo+ID4gPiA+ID4gVHJ1bmNhdGluZyBJTUEgbG9nIHRvIHJl
Y2xhaW0gbWVtb3J5IGlzIG5vdCBmZWFzaWJsZSwgc2luY2UKPiA+ID4gPiA+IGl0IG1ha2VzIHRo
ZSBsb2cgZ28gb3V0IG9mIHN5bmMgd2l0aCB0aGUgVFBNIFBDUiBxdW90ZSBtYWtpbmcKPiA+ID4g
PiA+IHJlbW90ZSBhdHRlc3RhdGlvbiBmYWlsLgo+ID4gPiA+IAo+ID4gPiA+IFRoaXMgYXNzdW1w
dGlvbiBpc24ndCBlbnRpcmVseSB0cnVlLsKgIEl0J3MgcGVyZmVjdGx5IHBvc3NpYmxlCj4gPiA+
ID4gdG8gc2hhcmQgYW4gSU1BIGxvZyB1c2luZyB0d28gVFBNMl9RdW90ZSdzIGZvciB0aGUgYmVn
aW5uaW5nCj4gPiA+ID4gYW5kIGVuZCBQQ1IgdmFsdWVzIHRvIHZhbGlkYXRlIHRoZSBzaGFyZC7C
oCBUaGUgSU1BIGxvZyBjb3VsZCBiZQo+ID4gPiA+IHRydW5jYXRlZCBpbiB0aGUgc2FtZSB3YXkg
KHJlcGxhY2UgdGhlIHJlbW92ZWQgcGFydCBvZiB0aGUgbG9nCj4gPiA+ID4gd2l0aCBhIFRQTTJf
UXVvdGUgYW5kIEFLLCBzbyB0aGUgbG9nIHN0aWxsIHZhbGlkYXRlcyBmcm9tIHRoZQo+ID4gPiA+
IGJlZ2lubmluZyBxdW90ZSB0byB0aGUgZW5kKS4KPiA+ID4gPiAKPiA+ID4gPiBJZiB5b3UgdXNl
IGEgVFBNMl9RdW90ZSBtZWNoYW5pc20gdG8gc2F2ZSB0aGUgbG9nLCBhbGwgeW91IG5lZWQKPiA+
ID4gPiB0byBkbyBpcyBoYXZlIHRoZSBrZXJuZWwgZ2VuZXJhdGUgdGhlIHF1b3RlIHdpdGggYW4g
aW50ZXJuYWwKPiA+ID4gPiBBSy7CoCBZb3UgY2FuIGtlZXAgYSByZWNvcmQgb2YgdGhlIHF1b3Rl
IGFuZCB0aGUgQUsgYXQgdGhlCj4gPiA+ID4gYmVnaW5uaW5nIG9mIHRoZSB0cnVuY2F0ZWQga2Vy
bmVsIGxvZy7CoCBJZiB0aGUgdHJ1bmNhdGVkCj4gPiA+ID4gZW50cmllcyBhcmUgc2F2ZWQgaW4g
YSBmaWxlIHNoYXJkIGl0Cj4gPiA+IAo+ID4gPiBUaGUgdHJ1bmNhdGlvbiBzZWVtcyBkYW5nZXJv
dXMgdG8gbWUuIE1heWJlIG5vdCBhbGwgdGhlIHNjZW5hcmlvcwo+ID4gPiB3aXRoIGFuIGF0dGVz
dGF0aW9uIGNsaWVudCAoY2xpZW50ID0gcmVhZGluZyBsb2dzIGFuZCBxdW90aW5nKQo+ID4gPiBh
cmUgcG9zc2libGUgdGhlbiBhbnltb3JlLCBzdWNoIGFzIHN0YXJ0aW5nIGFuIGF0dGVzdGF0aW9u
IGNsaWVudAo+ID4gPiBvbmx5IGFmdGVyIHRydW5jYXRpb24gYnV0IGEgdmVyaWZpZXIgbXVzdCBo
YXZlIHdpdG5lc3NlZCB0aGUKPiA+ID4gc3lzdGVtJ3MgUENScyBhbmQgbG9nIHN0YXRlIGJlZm9y
ZSB0aGUgdHJ1bmNhdGlvbiBvY2N1cnJlZC4KPiA+IAo+ID4gVGhhdCdzIG5vdCBleGFjdGx5IGNv
cnJlY3QuwqAgTm90aGluZyBuZWVkcyB0byBoYXZlICJ3aXRuZXNzZWQiIHRoZQo+ID4gc3RhcnRp
bmcgUENSIHZhbHVlIGJlY2F1c2UgdGhlIHF1b3RlIHZvdWNoZXMgZm9yIGl0IChhbmQgY2FuIHZv
dWNoCj4gPiBmb3IgaXQgYWZ0ZXIgdGhlIGZhY3QpLsKgIFRoZSBvbmx5IHRoaW5nIHlvdSBuZWVk
IHRvIHZlcmlmeSB0aGUKPiA+IHF1b3RlIGlzIHRoZSBhdHRlc3RhdGlvbiBrZXkgYW5kIHRoZSBv
bmx5IHRoaW5nIHlvdSBuZWVkIHRvIGRvIHRvCj4gPiB0cnVzdCB0aGUgYXR0ZXN0YXRpb24ga2V5
IGlzIGVuc3VyZSBpdCB3YXMgVFBNIGNyZWF0ZWQuwqAgQWxsIG9mCj4gPiB0aGF0IGNhbiBiZSB2
ZXJpZmllZCBhZnRlciB0aGUgZmFjdCBhcyB3ZWxsLsKgIFRoZSBvbmx5IHRoaW5nIHRoYXQKPiA+
IGNhbiBiZSBkb25lIHRvIGRpc3J1cHQgdGhpcyBpcyB0byBkZXN0cm95IHRoZSBUUE0gKG9yIHJl
LW93biBpdCkuPiAKPiA+IFJlbWVtYmVyIHRoZSBhc3N1bXB0aW9uIGlzIHlvdSAqYWxzbyogaGF2
ZSB0aGUgcmVtb3ZlZCBsb2cgc2hhcmQgdG8KPiA+IHByZXNlbnQuwqAgRnJvbSB0aGF0IHRoZSBQ
Q1Igc3RhdGUgb2YgdGhlIHN0YXJ0aW5nIHF1b3RlIGNhbiBiZQo+IAo+IFllcywgdGhlIHdob2xl
IHNlcXVlbmNlIG9mIG9sZCBsb2dzIG5lZWRzIHRvIGJlIGF2YWlsYWJsZS4KClllcyBhbmQgbm8u
ICBJZiB0aGUgcGVyc29uIHJlbHlpbmcgb24gdGhlIGxvZ3MgaXMgaGFwcHkgdGhleSd2ZQpleHRy
YWN0ZWQgYWxsIHRoZSBldmlkZW50aWFyeSB2YWx1ZSBmcm9tIHRoZSBsb2cgaXRzZWxmIHRoZW4g
dGhleSBjYW4KcmVkdWNlIHRoZSBwcmVjZWRpbmcgbG9nIHNoYXJkIHRvIHNpbXBseSB0aGUgUENS
IHZhbHVlcyB0aGF0IG1hdGNoIHRoZQpxdW90ZSBhbmQgZGlzY2FyZCB0aGUgcmVzdC4KCj4gIElG
IHRoYXQncyB0aGUgY2FzZSBhbmQgdGhlIGxvZ3MgY2FuIGJlIHN0aXRjaGVkIHRvZ2V0aGVyIHNl
YW1sZXNzbHksCj4gd2hvIHRoZW4gbG9va3MgYXQgdGhlIGtlcm5lbCBBSyBxdW90ZSBhbmQgdW5k
ZXIgd2hhdCBjaXJjdW1zdGFuY2VzPwoKRm9yIGluY3JlbWVudGFsIGF0dGVzdGF0aW9uLiAgRWFj
aCBsb2cgc2hhcmQgY2FuIGJlIHZlcmlmaWVkIHVzaW5nIHRoZQpiYXNlIFBDUiB2YWx1ZXMgY29y
cmVzcG9uZGluZyB0byB0aGUgYm90dG9tIHF1b3RlIHRoZW4gcmVwbGF5ZWQgYW5kIHRoZQp0b3Ag
cXVvdGUgdmVyaWZpZWQuICBUaGlzIG1lYW5zIHRoYXQgbG9ncyB0aGF0IGFyZW4ndCBuZWVkZWQg
YW55bW9yZQpjYW4gYmUgZGlzY2FyZGVkLCB3aGljaCwgSSByZWNhbGwsIHdhcyB0aGUgYmFzZSBy
ZWFzb24gZm9yIHRoaXMKcHJvcG9zYWw6IHJlZHVjaW5nIElNQSBtZW1vcnkgY29uc3VtcHRpb24u
ICBBbHRob3VnaCBhbGwgeW91IG5lZWQgdG8gZG8KaXMgZXh0cmFjdCB0aGUgc2hhcmRzIGZyb20g
a2VybmVsIG1lbW9yeSB0byBmaWxlIHNwYWNlIGFuZCBmcmVlIHRoZQprZXJuZWwgbWVtb3J5LiAg
U2luY2UgdGhhdCBzY2hlbWUgY2FuIGtlZXAgYWxsIGxvZ3MgaW50YWN0LCB0aGVyZSdzIG5vCnJl
YXNvbiB0byBmdXJ0aGVyIHJlZHVjZSB0aGVtIHVubGVzcyB0aGUgZmlsZXN5c3RlbSBpcyBydW5u
aW5nIG91dCBvZgpzcGFjZS4KCkphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

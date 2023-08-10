Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A3C001DB
	for <kexec@archiver.kernel.org>; Thu, 10 Aug 2023 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JFHwF8aneKgvWB1rooUrGcaRmYxS7Qb0H97ZhJ7nKQw=; b=eWGwR0/1MkvUC+
	biYqDQKVIS34ZHLXKpgrQoGTw3Aa4wxxDYPuTSSw6Cirj946E6KSWIKNmFjXqTjqdmk5oiPKhctVY
	i4Sl9KHseHUsplGX8sU6RwTFAW8IIbIZmMviy7JAHA2ZhHYB4t8zPVbVWq4plsHvurvEl88Vu7FSW
	aeIVUTLuGSotsYQ10c+PyBkl7BnbgUDzsXr60zpzfxwrkwSgoA5bZ3aB8Uk+5m817795sLN1P4ORH
	x3xYBcXKeECIyydaQmwWTFCRl81qgr+9SDe3rn+r+zZdRkLwA6UCe6Dn3ZEgX9grc+9yEXRlHT2QC
	E7iueDfN+KJv48/v2ulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU44o-007Ul0-1D;
	Thu, 10 Aug 2023 11:43:38 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU44l-007Uk7-0n
	for kexec@lists.infradead.org;
	Thu, 10 Aug 2023 11:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691667810;
	bh=nEaH47B5XUG+dGWKW2MTI/k+KrlwMmhRhGED9/yMPoY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=tsmOTLMDWCdMKJ6jnBtKg+1cNJKoROy+6PYx53l52uIx7ypH4yWcot/RNrW2/22/W
	 kWXyo3ntZaMSXaxJ1bBnFtZ6SAHkn8vOvzOpvNZE/LRN4liZO9aOPisqC2NwQ0Kgjd
	 E8SnD0iMAk4D9AbCTVq2G4CqWAIMYcCb3QYw6zxc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 31B151281B19;
	Thu, 10 Aug 2023 07:43:30 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xfvz0UbcUk3I; Thu, 10 Aug 2023 07:43:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1691667809;
	bh=nEaH47B5XUG+dGWKW2MTI/k+KrlwMmhRhGED9/yMPoY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=kNVgQPrNN45DM9R91wZjrcClQB6Oo5nadexXVgwIsJy5hlIE8iRPQ6Ja2UEWah7II
	 SD8OX0pbv8rvPPHrRK4RokmMRsYsh5UINXvpBXKOfHAUXJlqnD+EsXyb88x8bsNp3A
	 Rk2aYnkruY7BKGXKaXeDau1dE/n9X4tJp0GdJLiI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 605111281A2E;
	Thu, 10 Aug 2023 07:43:28 -0400 (EDT)
Message-ID: <8ccaec30bf85cfbf4415bbafa22646a62e753840.camel@HansenPartnership.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>, Stefan Berger
 <stefanb@linux.ibm.com>, Sush Shringarputale
 <sushring@linux.microsoft.com>,  linux-integrity@vger.kernel.org,
 zohar@linux.ibm.com, peterhuewe@gmx.de,  jarkko@kernel.org, jgg@ziepe.ca,
 kgold@linux.ibm.com, bhe@redhat.com,  vgoyal@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, jmorris@namei.org,  Paul Moore
 <paul@paul-moore.com>, serge@hallyn.com
Cc: code@tyhicks.com, nramas@linux.microsoft.com, 
	linux-security-module@vger.kernel.org
Date: Thu, 10 Aug 2023 07:43:25 -0400
In-Reply-To: <5cb03349-7a32-8f74-f2a1-ff3c6247c1ef@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
	 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
	 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
	 <8ad131f35c33cf10788344be6c981473971f9c1c.camel@HansenPartnership.com>
	 <abe53dde-9a83-81fd-422d-babf4587c545@linux.ibm.com>
	 <350ecdcbf7796f488807fcd7983414a02dd71be4.camel@HansenPartnership.com>
	 <04fb2fe5-9ebe-b35f-bdde-6ef22786438f@linux.ibm.com>
	 <a522b17a536ea87a6a4c2faf95583ae3b7b74a26.camel@HansenPartnership.com>
	 <5cb03349-7a32-8f74-f2a1-ff3c6247c1ef@linux.microsoft.com>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_044335_294949_39102621 
X-CRM114-Status: GOOD (  37.72  )
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

T24gV2VkLCAyMDIzLTA4LTA5IGF0IDIxOjQzIC0wNzAwLCBUdXNoYXIgU3VnYW5kaGkgd3JvdGU6
Cj4gT24gOC84LzIzIDE0OjQxLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6Cj4gPiBPbiBUdWUsIDIw
MjMtMDgtMDggYXQgMTY6MDkgLTA0MDAsIFN0ZWZhbiBCZXJnZXIgd3JvdGU6ClsuLi5dCj4gPiA+
IMKgIGF0IHRoaXMgcG9pbnQgZG9lc24ndCBzZWVtIG5lY2Vzc2FyeSBzaW5jZSBvbmUgcHJlc3Vt
YWJseSBjYW4KPiA+ID4gdmVyaWZ5IHRoZSBsb2cgYW5kIFBDUiBzdGF0ZXMgYXQgdGhlIGVuZCB3
aXRoIHRoZSAncmVndWxhcicKPiA+ID4gcXVvdGUuCj4gPiDCoAo+ID4gSSBkb24ndCB1bmRlcnN0
YW5kIHRoaXMuwqAgQSByZWd1bGFyIHF1b3RlIGlzIGEgc2lnbmF0dXJlIG92ZXIgUENSCj4gPiBz
dGF0ZSBieSBhbiBBSy7CoCBUaGUgcG9pbnQgYWJvdXQgc2F2aW5nIHRoZSBBSyBpbiB0aGUgbG9n
IGZvciB0aGUKPiA+IG9yaWdpbmFsIGlzIHRoYXQgaWYgdGhlICprZXJuZWwqIHRydW5jYXRlcyB0
aGUgbG9nIGFuZCBzYXZlcyBpdCB0bwo+ID4gYSBmaWxlLCBpdCBuZWVkcyB0byBnZW5lcmF0ZSBi
b3RoIHRoZSBBSyBhbmQgdGhlIHF1b3RlIGZvciB0aGUgdG9wCj4gPiBvZiB0aGUgZmlsZSBzaGFy
ZC4gVGhhdCBtZWFucyB0aGUgQUsvRUsgYmluZGluZyBpcyB1bnZlcmlmaWVkLCBidXQKPiA+IGNh
biBiZSB2ZXJpZmllZCBieSBsb2FkaW5nIHRoZSBBSyBhbmQgcnVubmluZyB0aGUgdXN1YWwgdGVz
dHMsCj4gPiB3aGljaCBjYW4gb25seSBiZSBkb25lIGlmIHlvdSBoYXZlIHRoZSBsb2FkYWJsZSBB
Sywgd2hpY2ggaXMgd2h5Cj4gPiB5b3UgbmVlZCBpdCBhcyBwYXJ0IG9mIHRoZSBsb2cgc2F2aW5n
IHByb3Bvc2FsLgo+IMKgCj4gSSBoYWQgdGhpcyBxdWVzdGlvbiBhYm91dCB0aGUgdXNhYmlsaXR5
IG9mIEFLL0VLIGluIHRoaXMKPiBjb250ZXh0LiBBbHRob3VnaCBBSy9FSyArIFBDUiBxdW90ZSBp
cyBuZWVkZWQgdG8gdmVyaWZ5IHRoZSBzbmFwc2hvdAo+IHNoYXJkcyAvIElNQSBsb2dzIGFyZSBu
b3QgdGFtcGVyZWQgd2l0aCwgSSBhbSBzdGlsbCBub3Qgc3VyZSB3aHkKPiBBSy9FSyBuZWVkcyB0
byBiZSBwYXJ0IG9mIHRoZSBzaGFyZC9JTUEgbG9nLiBUaGUgY2xpZW50IHNlbmRpbmcgQUsvRUsK
PiB0byBhdHRlc3RhdGlvbiBzZXJ2aWNlIHNlcGFyYXRlbHkgd291bGQgc3RpbGwgc2VydmUgdGhl
IHB1cnBvc2UsCj4gcmlnaHQ/CgpXZWxsLCB0aGUgRUsgZG9lc24ndCBuZWVkIHRvIGJlIHBhcnQg
b2YgdGhlIGxvZzogaXQncyBqdXN0IGEgcGVybWFuZW50CnBhcnQgb2YgdGhlIFRQTSBpZGVudGl0
eS4gIFRvIHZlcmlmeSB0aGUgbG9nLCB5b3UgbmVlZCBhY2Nlc3MgdG8gdGhlClRQTSB0aGF0IHdh
cyB1c2VkIHRvIGNyZWF0ZSBpdCwgc28gdGhhdCdzIHRoZSBwb2ludCBhdCB3aGljaCB5b3UgZ2V0
CnRoZSBFSy4KCkFuIEFLIGlzIHNpbXBseSBhIFRQTSBnZW5lcmF0ZWQgc2lnbmluZyBrZXkgKG1l
YW5pbmcgdGhlIHByaXZhdGUgcGFydApvZiB0aGUga2V5IGlzIHNlY3VyZWQgYnkgdGhlIFRQTSBh
bmQga25vd24gdG8gbm8tb25lIGVsc2UpLiAgSW4gdGhlCmxpdGVyYXR1cmUgYSBUUE0gZ2VuZXJh
dGVkIHNpZ25pbmcga2V5IGRvZXNuJ3QgYmVjb21lIGFuIEF0dGVzdGF0aW9uCktleSB1bnRpbCBp
dCdzIGJlZW4gdmVyaWZpZWQgdXNpbmcgYW4gRUsgcHJvcGVydHkgKGVpdGhlciBhIGNlcnRpZnkg
Zm9yCmEgc2lnbmluZyBFSyBvciBhIG1ha2UvYWN0aXZhdGUgY3JlZGVudGlhbCByb3VuZCB0cmlw
IGZvciB0aGUgbW9yZQp1c3VhbCBlbmNyeXB0aW9uIEVLLgoKU28gdGhlIHByb3Bvc2FsIGlzIGZv
ciBlYWNoIHF1b3RlIHRoYXQncyB1c2VkIHRvIHZlcmlmeSBhIGxvZyBzaGFyZCBpcwp0aGF0IHRo
ZSBUUE0gc2ltcGx5IGdlbmVyYXRlIGEgcmFuZG9tIHNpZ25pbmcga2V5IGFuZCB1c2UgdGhhdCB0
byBzaWduCnRoZSBxdW90ZS4gIFlvdSBuZWVkIHRvIHNhdmUgdGhlIFRQTSBmb3JtIG9mIHRoZSBn
ZW5lcmF0ZWQga2V5IHNvIGl0CmNhbiBiZSBsb2FkZWQgbGF0ZXIgYW5kIHRoZSByZWFzb24gZm9y
IHRoYXQgaXMgeW91IGNhbiBkbyB0aGUgRUsKdmVyaWZpY2F0aW9uIGF0IGFueSB0aW1lIGFmdGVy
IHRoZSBxdW90ZSB3YXMgZ2l2ZW4gYnkgbG9hZGluZyB0aGUgc2F2ZWQKa2V5IGFuZCBydW5uaW5n
IHRoZSB2ZXJpZmljYXRpb24gcHJvdG9jb2wuICBJbiB0aGUgbm9ybWFsIGF0dGVzdGF0aW9uCnlv
dSBkbyB0aGUgRUsgdmVyaWZpY2F0aW9uIG9mIHRoZSBBSyAqYmVmb3JlKiB0aGUgcXVvdGUsIGJ1
dCB0aGVyZSdzIG5vCnByb3BlcnR5IG9mIHRoZSBxdW90ZSB0aGF0IGRlcGVuZHMgb24gdGhpcyBw
cmVjZWRlbmNlIHByb3ZpZGVkIHlvdSBkbwp0aGUgcXVvdGUgd2l0aCBhIFRQTSBnZW5lcmF0ZWQg
c2lnbmluZyBrZXkuCgpUaGUgdW5kZXJseWluZyBwb2ludCBpcyB0aGF0IHRoZSB1c3VhbCB3YXkg
YW4gRUsgdmVyaWZpZXMgYW4gQUsKcmVxdWlyZXMgYSByZW1vdGUgb2JzZXJ2ZXIsIHdoaWNoIHRo
ZSBrZXJuZWwgd29uJ3QgaGF2ZSwgc28gdGhlIGtlcm5lbAptdXN0IGRvIGFsbCBpdHMgc3R1ZmYg
bG9jYWxseSAoZ2VuZXJhdGUga2V5LCBnZXQgcXVvdGUpIGFuZCB0aGVuIGF0CnNvbWUgcG9pbnQg
bGF0ZXIgdGhlIHN5c3RlbSBjYW4gYmVjb21lIHJlbW90ZSBjb25uZWN0ZWQgYW5kIHByb3ZlIHRv
CndoYXRldmVyIGV4dGVybmFsIGVudGl0eSB0aGF0IHRoZSBsb2cgc2hhcmQgaXMgdmFsaWQuICBT
byB3ZSBoYXZlIHRvCmhhdmUgYWxsIHRoZSBjb21wb25lbnRzIG5lY2Vzc2FyeSBmb3IgdGhhdCBw
cm9vZjogdGhlIGxvZyBzaGFyZCwgdGhlCnF1b3RlIGFuZCB0aGUgVFBNIGZvcm0gb2YgdGhlIEFL
LgoKPiBGb3IgaW5zdGFuY2UsIFBDUiBxdW90ZXMgd2lsbCBiZSBzaWduZWQgYnkgQUsuIFNvIGFz
IGxvbmcgYXMgdGhlCj4gdmVyaWZpZXIgdHJ1c3RzIHRoZSBBSy9FSywKClJpZ2h0LCBidXQgaWYg
eW91J3JlIHNoYXJkaW5nIGEgbG9nLCB0aGUga2VybmVsIGRvZXNuJ3Qga25vdyBpZiBhCnZlcmlm
aWVyIGhhcyBiZWVuIGluIGNvbnRhY3QgeWV0LiAgVGhlIHBvaW50IG9mIHRoZSBwcm90b2NvbCBh
Ym92ZSBpcwp0byBtYWtlIHRoYXQgbm90IG1hdHRlci4gIFRoZSB2ZXJpZmllciBjYW4gY29udGFj
dCB0aGUgc3lzdGVtIGFmdGVyIHRoZQpsb2cgaGFzIGJlZW4gc2F2ZWQgYW5kIHRoZSB2ZXJpZmlj
YXRpb24gd2lsbCBzdGlsbCB3b3JrLgoKPiAgaXQgY2FuIHZlcmlmeSB0aGUgcXVvdGVzIGFyZSBu
b3QgdGFtcGVyZWQgd2l0aC4KPiBSZXBsYXlpbmcgSU1BIGxvZy9zbmFwc2hvdCBjYW4gcHJvZHVj
ZSB0aGUgUENSIHF1b3RlcyB3aGljaCBjYW4gYmUKPiBtYXRjaGVkIHdpdGggc2lnbmVkIFBDUiBx
dW90ZXMuIElmIHRoZXkgbWF0Y2gsIHRoZW4gdGhlIHZlcmlmaWVyIGNhbgo+IGNvbmNsdWRlIHRo
YXQgdGhlIElNQSBsb2cgaXMgbm90IHRhbXBlcmVkIHdpdGguIFNvIEFLIGRvZXNuJ3QgbmVlZCB0
bwo+IGJlIHBhcnQgb2YgdGhlIGxvZy9zbmFwc2hvdC4KCk9ubHkgaWYgdGhlIHN5c3RlbSBpcyBj
dXJyZW50bHkgaW4gY29udGFjdCB3aXRoIHRoZSB2ZXJpZmllciBhbmQgdGhlCnZlcmlmaWVyIGhh
cyBjcmVhdGVkIHRoZSBBSy4gIFRoYXQgbWF5IG5vdCBoYXZlIGhhcHBlbmVkLgoKPiBCVFcsIGlu
IHRoaXMgcHJvcG9zYWwsIGtlcm5lbCBpcyB0cnVuY2F0aW5nIHRoZSBsb2cgYW5kIHBhc3Npbmcg
dGhlCj4gdHJ1bmNhdGVkIGJ1ZmZlciB0byBVTS7CoCBVTSBjbGllbnQgbmVlZCB0byBzYXZlIGl0
IHRvIHRoZSBkaXNrCj4gbG9jYXRpb24gb2YgaXQncyBjaG9pY2UuCgpZZXMsIGJ1dCBJIHdhcyBh
c3N1bWluZyB0YW1wZXJpbmcgd2l0aCBvciBkaXNjYXJkaW5nIHRoZSBsb2cgZmlsZSB3b3VsZApi
ZSB0cmVhdGVkIGluIGV4YWN0bHkgdGhlIHNhbWUgd2F5IGFzIGFuIGluLWtlcm5lbCBJTUEgbG9n
IHRhbXBlci4KCkphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

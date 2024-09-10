Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08180ECE564
	for <kexec@archiver.kernel.org>; Tue, 10 Sep 2024 07:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r/Dl5gu84ktri68pxuKkNYhgo4u1dVCvCHy/aML42IA=; b=yeHa2ueuNuktUA
	g/sTfbcTecjQNR7M/knXh8LKVjubxoJYA087ROARgSo/tGS4cY/WrknxeLxRo3gBiOdytObPrmtb2
	I4tpgHLe3S7oSxJmYf3yXjCI09kSnLSuGbNnMlW5wfhXM2oMqyQzEiaEL9l43l7AJa04d62sFsCFQ
	swV9ZUYNeMBSS7LAIh2TJOJ8JG/j6DZYlOPytv+Ox8kIDuemYIiIWpEZEck9HK518H/SD/CbO0t0A
	pYciK8q5bmeahASdQDhlpLKmfV6tLPYanpnhnsJH2gMdx1Q04QftOH6wUMgIlofcKtTvRIUUzceJV
	P4ediOF2V3fmStGU7k7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snuzL-00000004XoO-2Gdk;
	Tue, 10 Sep 2024 07:08:35 +0000
Received: from gardel.0pointer.net ([2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snuxI-00000004XMl-0ysq
	for kexec@lists.infradead.org;
	Tue, 10 Sep 2024 07:06:30 +0000
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 4287CE80261;
	Tue, 10 Sep 2024 09:06:25 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 0000C160143; Tue, 10 Sep 2024 09:06:23 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:06:23 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt_v7zRSsmanW89Z@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
 <ZsyFr8V6yizMiBTw@gardel-login>
 <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_000628_440271_AF81BCC1 
X-CRM114-Status: GOOD (  29.76  )
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

T24gTW8sIDA5LjA5LjI0IDIxOjM4LCBQaW5nZmFuIExpdSAocGlsaXVAcmVkaGF0LmNvbSkgd3Jv
dGU6Cgo+IEhpIExlbm5hcnQsCj4KPiBJIHNwZW50IHNvbWUgdGltZSB1bmRlcnN0YW5kaW5nIHRo
ZSBzeXN0ZW1kLXBjcmxvY2sgYW5kIFRQTSBzdHVmZiwgYW5kCj4gZ290IHNvbWUgaWRlYSBhYm91
dCBpdC4gQ291bGQgeW91IGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nPyBQbGVhc2Ugc2VlCj4gdGhl
IGZvbGxvd2luZyBjb21tZW50cyBpbmxpbmVkLgo+Cj4gT24gTW9uLCBBdWcgMjYsIDIwMjQgYXQg
OTo0MOKAr1BNIExlbm5hcnQgUG9ldHRlcmluZyA8bXp4cmVhcnlAMHBvaW50ZXIuZGU+IHdyb3Rl
Ogo+ID4KPiA+IE9uIERvLCAyMi4wOC4yNCAyMjoyOSwgUGluZ2ZhbiBMaXUgKHBpbGl1QHJlZGhh
dC5jb20pIHdyb3RlOgo+ID4KPiA+ID4gPiBIbW0sIEknZCByZWFsbHkgdGhpbmsgYWJvdXQgdGhp
cyB3aXRoIHNvbWUgcHJpb3JpdHkuIFRoZSBtZWFzdXJlbWVudAo+ID4gPiA+IHN0dWZmIHNob3Vs
ZCBub3QgYmUgYW4gYWZ0ZXJ0aG91Z2h0LCBpdCB0eXBpY2FsbHkgaGFzIG1ham9yCj4gPiA+ID4g
aW1wbGljYXRpb25zIG9uIGhvdyB5b3UgZGVzaWduIHlvdXIgdHJhbnNpdGlvbnMsIGJlY2F1c2Ug
bWVhc3VyZW1lbnRzCj4gPiA+ID4gb2Ygc29tZSBjb21wb25lbnQgYWx3YXlzIG5lZWQgdG8gaGFw
cGVuICpiZWZvcmUqIHlvdSBwYXNzIGNvbnRyb2wgdG8KPiA+ID4gPiBpdCwgb3RoZXJ3aXNlIHRo
ZXkgYXJlIHBvaW50bGVzcy4KPiA+ID4gPgo+ID4gPgo+ID4gPiBBdCBwcmVzZW50LCBteSBlbXVs
YXRvciByZXR1cm5zIGZhbHNlIHRvIGlzX2VmaV9zZWN1cmVfYm9vdCgpLCBzbwo+ID4gPiBzeXN0
ZW1kLXN0dWIgZG9lcyBub3QgY2FyZSBhYm91dCB0aGUgbWVhc3VyZW1lbnQsIGFuZCBtb3ZlcyBv
bi4KPiA+ID4KPiA+ID4gQ291bGQgeW91IGVubGlnaHRlbiBtZSBhYm91dCBob3cgc3lzdGVtZCB1
dGlsaXplcyB0aGUgbWVhc3VyZW1lbnQ/IEkKPiA+ID4gZ3JlcHBlZCAnVFBNMl9QQ1JfS0VSTkVM
X0NPTkZJRycsIGFuZCBzYXcgdGhlIHN5c3RlbWQtc3R1YiBhc2tzIHRvCj4gPiA+IGV4dGVuZCBQ
Q1IuIEJ1dCB3aGVyZSBpcyB0aGUgdmFsdWUgY2hlY2tlZD8gSSBndWVzcyB0aGUgc3lzdGVtZCB3
aWxsCj4gPiA+IGhhbmcgaWYgdGhlIGNoZWNrIGZhaWxzLgo+ID4KPiA+IHN5c3RlbWQncyAic3lz
dGVtZC1wY3Jsb2NrIiB0b29sIHdpbGwgbG9vayBmb3IgbWVhc3VyZW1lbnRzIGxpa2UgdGhhdAo+
ID4gYW5kIGdlbmVyYXRlIGRpc2sgZW5jcnlwdGlvbiBUUE0gcG9saWNpZXMgZnJvbSB0aGF0Lgo+
ID4KPgo+IEJlZm9yZSBrZXhlYyByZWJvb3RzIHRvIHRoZSBuZXcga2VybmVsCj4gc3lzdGVtZC1w
Y3Jsb2NrIGNhbiBwcmVkaWN0IHRoZSBleHBlY3RlZCBQQ1IgdmFsdWUgYW5kIHN0b3JlIGl0IGlu
IHRoZQo+IGZpbGUgc3lzdGVtLgoKSSdzIGEgc2V0IG9mIFBDUiB2YWx1ZXMgcGNybG9jayBwcmVk
aWN0cywgb25lIG9yIG1vcmUgZm9yIGVhY2ggUENSLiBJdAp0aGVuIGNvbXBpbGVzIGEgVFBNICJw
b2xpY3kiIGZyb20gdGhhdCwgd2hpY2ggaXMgaWRlbnRpZmllZCBieSBhIGhhc2gsCmFuZCB0aGF0
IGhhc2ggaXMgdGhlbiBzdG9yZWQgaW4gYSBUUE0gIm52aW5kZXgiICh3aGljaCBpcyBhIGJpdCBv
ZgptZW1vcnkgYSB0cG0gcHJvdmlkZXMpLgoKPiBPbmUgdGhpbmcgc2hvdWxkIGJlIG5vdGljZWQg
aXMgdGhhdCBQQ1IgdmFsdWUgY2FuIG5vdCBiZSBhZmZlY3RlZC4KCldlbGwsIGEga2V4ZWMgKnNo
b3VsZCogYWZmZWN0IHNvbWUgUENScy4gUmVwbGFjZW1lbnQgb2YgdGhlIGtlcm5lbAoqbXVzdCog
YmUgdmlzaWJsZSBpbiB0aGUgbWVhc3VyZW1lbnQgbG9ncyBzb21laG93LCBpbiBhIHByZWRpY3Rh
YmxlCmZhc2hpb24uCgo+IEFuZCBrZXhlYyByZWJvb3RpbmcgaGFwcGVucy4gc3lzdGVtZC1zdHVi
IGV4dGVuZHMgdGhlIFBDUiB2YWx1ZS4gV2hlbgo+IHRoZSBzeXN0ZW0gaXMgdXAsIHN5c3RlbWQg
Y2hlY2tzIHRoZSByZWFsIFBDUiB2YWx1ZSBhZ2FpbnN0IHRoZQo+IGV4cGVjdGVkIHZhbHVlIHJl
bmRlcmVkIGJ5IHN5c3RlbWQtcGNybG9jaz8gSWYgbWF0Y2hpbmcsIGFsbCByZWxhdGVkCj4gcG9s
aWNpZXMgc3VjY2VlZC4KCldlbGwsIGl0J3Mgbm90IHN5c3RlbWQgdGhhdCBjaGVja3MgdGhhdCwg
YnV0IHRoZSBUUE0uIGkuZS4gbm90IHRoZQp1bnRydXN0ZWQgT1MgYnV0IHRoZSB0aGUgc3VwcGVk
bHkgbW9yZSB0cnVzdGVkIFRQTS4KClNvLCBrZXkgaXMgdGhhdCB3ZSB3YW50IHRoYXQgbWVhc3Vy
ZW1lbnRzIHRha2UgcGxhY2UsIHRoZSBrZXhlYwpvcGVyYXRpb24gKm11c3QqIGJlIG1hZGUgdmlz
aWJsZSBpbiB0aGUgbWVhc3VyZW1lbnQgbG9ncy4gQnV0IGl0IG11c3QKYmUgaW4gYSB3ZWxsLWRl
ZmluZWQgd2F5LCBhbmQgaWRlYWxseSBhcyBhbiBleHRlbnNpb24gb2YgdGhlCm1lYXN1cmVtZW50
cyBzZC1zdHViIGN1cnJlbnRseSBtYWtlcy4KCihCVFcsIEkgcGVyc29uYWxseSBkb24ndCB0aGlu
ayBlbXVsYXRpbmcgRUZJIGlzIHJlYWxseSB0aGF0CmltcG9ydGFudC4gQXMgbG9uZyBhcyB3ZSBn
ZXQgdGhlIGtleSBmdW5jdGlvbmFsaXR5IHRoYXQgc2Qtc3R1Ygpwcm92aWRlcyBhbHNvIHdoZW4g
ZG9pbmcga2V4ZWMgSSBhbSBoYXBweS4gaS5lLiB3aGV0aGVyIGl0IGlzIHNkLXN0dWIKdGhhdCBk
b2VzIHRoaXMgb3Igc29tZSBvdGhlciBwaWVjZSBvZiBjb2RlIGRvZXNuJ3QgcmVhbGx5IG1hdHRl
ciB0bwptZS4gV2hhdCBJIGRvIGNhcmUgYWJvdXQgaXMgdGhhdCB3ZSBjYW4gcGFyYW1ldGVyaXpl
IHRoZSBpbnZva2VkCmtlcm5lbCBpbiBhIHNpbWlsYXIgZmFzaGlvbiBhcyB3ZSBjYW4gcGFyYW1l
dGVyaXplIHNkLXN0dWIsIGFuZCB0aGF0CnRoZSBtZWFzdXJlbWVudHMgYXBwbGllZCBhcmUgYWxz
byBlcXVpdmFsZW50LikKCkxlbm5hcnQKCi0tCkxlbm5hcnQgUG9ldHRlcmluZywgQmVybGluCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWls
aW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

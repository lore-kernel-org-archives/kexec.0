Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB9CED26E
	for <kexec@archiver.kernel.org>; Tue,  8 Oct 2024 06:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:Cc:Date:
	In-Reply-To:From:Subject:Mime-Version:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mjXK/MTPuumDJKOK/TOQXc8MW3qTKzrfcVjRCEYLeY0=; b=DGDddVDOmBFwCj
	16VrFno6QZwtXRvq0R8iymeW6xAIAPtaMLkCJ07LuEYDlkB5dbH5c4N1YGeWPfA8uqFB7RfZloyNO
	nFb7IGD1JiOUbvJp6ElkIiPfSO3VwQPdsI0QINT3muvaJqmmnXnnfBifMg3Qjh7mWwCXf/IO1m66Y
	waIe095ndYQIh1pdmxBiCfy34mUc1A3NZ1wBnsUFdMOWCed0eor+cXIfYewkhm+Q9Bd94CMzVH7zJ
	sh2n9sDUU0tMtYGMUFw6RllyAyPt/rxrEK41vs2qtpYsU3BfhHLQQsoglIoBtCGvypK5X0Bd27vRS
	pShXN7refXq4bBchiHVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3TH-00000004cR0-2GiY;
	Tue, 08 Oct 2024 06:13:23 +0000
Received: from dediextern.your-server.de ([85.10.215.232])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3TD-00000004cQM-3FnE
	for kexec@lists.infradead.org;
	Tue, 08 Oct 2024 06:13:21 +0000
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <martin.friedrich@hetzner-cloud.de>)
	id 1sy3T5-000McM-Kn; Tue, 08 Oct 2024 08:13:11 +0200
Received: from [2a01:4f8:0:a105::1002] (helo=smtpclient.apple)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <martin.friedrich@hetzner-cloud.de>)
	id 1sy3T5-000N39-0H;
	Tue, 08 Oct 2024 08:13:11 +0200
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: makedumpfile fail to strip pages
From: Martin Friedrich <martin.friedrich@hetzner-cloud.de>
In-Reply-To: <6a41c11b-0956-4101-9892-173bd78668b9@nec.com>
Date: Tue, 8 Oct 2024 08:13:00 +0200
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Message-Id: <FC7D62F0-F41F-4773-8EAC-6235E22AD6F9@hetzner-cloud.de>
References: <164F5E03-EB17-451A-810F-58962BBC53B2@hetzner-cloud.de>
 <6a41c11b-0956-4101-9892-173bd78668b9@nec.com>
To: =?utf-8?B?IkhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSki?= <k-hagio-ab@nec.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-Authenticated-Sender: martin.friedrich@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27420/Mon Oct  7 10:43:46 2024)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_231319_838188_22C5A3AA 
X-CRM114-Status: GOOD (  13.12  )
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

SGVsbG8sCgp3ZSBoYXZlIGJ1aWx0IGEgbmV3IHBhY2thZ2UgdXNpbmcgdGhlIGxhdGVzdCBjb21t
aXQgKGJkMzA0MzdjNjI5MikgYW5kIGFyZSB1bmFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4K
QWxsIGR1bXBzIHdlcmUgY29ycmVjdGx5IHN0cmlwcGVkIGFuZCBjb21wbGV0ZWQgc3VjY2Vzc2Z1
bGx5LgoKV2Ugd2lsbCBtb25pdG9yIHRoZSBzaXR1YXRpb24gYW5kIGNvbWUgYmFjayBpZiB3ZSBz
ZWUgZnVydGhlciBpc3N1ZXMuClRoYW5rIHlvdSBmb3IgeW91ciBhc3Npc3RhbmNlLgoKQmVzdCwK
TWFydGluCgo+IE9uIDI1LiBTZXAgMjAyNCwgYXQgMDM6MzYsIEhBR0lPIEtBWlVISVRPKOiQqeWw
vuOAgOS4gOS7gSkgPGstaGFnaW8tYWJAbmVjLmNvbT4gd3JvdGU6Cj4gCj4gT24gMjAyNC8wOS8y
MCAxNjozMSwgTWFydGluIEZyaWVkcmljaCB3cm90ZToKPj4gSGVsbG8sCj4+IAo+PiBJIHRyeSB0
byBpZGVudGlmeSB0aGUgcm9vdC1jYXVzZSBvZiBhbiBpc3N1ZSB3aXRoIGtkdW1wICYgbWFrZWR1
bXBmaWxlIHdoaWNoIHJlc3VsdHMgaW4gZHVtcHMgdG8gaGF2ZSBhIHNpemUgb2YgdGhlIHN5c3Rl
bSBtZW1vcnkuCj4+IEtkdW1wLXRvb2xzL21ha2VkdW1wZmlsZSBoYXMgYmVlbiBjb25maWd1cmVk
IHRvIHN0cmlwIG1vc3QgcGFnZXMgd2l0aCB0aGUgZmxhZ3M6ICIgLWMgLWQgMzEiIGFuZCB0cmFu
c2ZlciB0aGUgZHVtcCB0byBhbiBzc2ggdGFyZ2V0Lgo+PiAKPj4gSSdtIHVuYWJsZSB0byByZXBs
aWNhdGUgdGhlIGlzc3VlIGJ5IGNyYXNoaW5nIGtlcm5lbCB1c2luZyBzeXNycS10cmlnZ2Vycy4g
QXMgbG9uZyB0aGUgc3lzdGVtIGNyYXNoZWQgYnkgc3lzcnEtdHJpZ2dlciwgdGhlIGR1bXAgaGFz
IHRoZSBjb3JyZWN0IHNpemUgYW5kIGNvbXBsZXRlcyBzdWNjZXNzZnVsbHkuCj4+IEJ1dCBhcyBz
b29uIGEgc3lzdGVtIGNyYXNoZXMgZm9yIG90aGVyIHJlYXNvbnMsIGR1bXBzIGdldCBodWdlIGFu
ZCBmYWlsIHRvIHRyYW5zZmVyIHRvIHRoZSBzc2ggdGFyZ2V0IGR1ZSB0byB0aGVpciBzaXplLgo+
PiAKPj4gT3VyIHNlcnZlcnMgKHg2NC9hYXJjaDY0KSBhcmUgcnVubmluZyBVYnVudHUgMjIuMDQg
d2l0aCBhIHNlbGYgYnVpbHQga2VybmVsIDYuNi4zMiAoY29uZmlnIGF0dGFjaGVkKSBhbmQgbWFr
ZWR1bXBmaWxlIChiYWNrcG9ydGVkIDEuNy41LTMgdG8gVWJ1bnR1IDIyLjA0KS4KPj4gCj4+IEFt
IEkgbWlzc2luZyBzb21ldGhpbmcgd2l0aGluIHRoZSBrZXJuZWwgY29uZmlnIHdoaWNoIGNvdWxk
IGNhdXNlIHRoaXMgYmVoYXZpb3I/Cj4gCj4gaG1tLCBJIGhhdmUgbm90IHNlZW4gc3VjaCBhIGJl
aGF2aW9yLgo+IAo+IC0gd2hhdCBoYXBwZW5zIHdpdGggdGhlIGxhdGVzdCAoYmQzMDQzN2M2Mjky
KSBtYWtlZHVtcGZpbGU/Cj4gLSBpcyBpdCBwb3NzaWJsZSB0byBnZXQgbWFrZWR1bXBmaWxlIGxv
Z3Mgd2l0aCAiLS1tZXNzYWdlLWxldmVsIDMxIiBvbiAKPiBzeXNycSBjcmFzaCBhbmQgb3RoZXIg
cmVhc29ucz8gKHRvIGNvbXBhcmUgdGhlIGxvZ3MgaW5jbHVkaW5nIHN0YXRzKQo+IAo+IFRoYW5r
cywKPiBLYXp1CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

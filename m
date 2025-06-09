Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E5FC61DB2
	for <kexec@archiver.kernel.org>; Mon,  9 Jun 2025 07:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:CC:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XcnfmvlhIF30BE7p6htpDEP/XNEkMJK0HdmXgaozwwg=; b=tc6JoDgU1FBXjipPQXnPfJzNM9
	iYdLMA00bJpN2k7ByQUwcKWhjyoS0y1mkqrthMqjPd6b279Ci5ajiOyd3QcgSIBVS9P1zT4GWF8eK
	7y4PV1twgswJQIQ6mm5PR18irog35IUCvBlmo61sL6SujDyWvjzwhiy7XWoKUaub0io4BwUn9GHhc
	QaZJq10szX95FmU3ddycloDvKD31KE0vognpU4ef0EaRPgRpUsVmOx+PhiwxYVEJ/sR/YIQ3anT/d
	mWjjN1vRV+i1d/UY8YowvbAEQmZePoutPnxj/soVYtYf2pINJMyehdjrNLnUPP1WdUfBMv9a5Oh+b
	gzZuPZpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOWXl-00000003Xro-2uQl;
	Mon, 09 Jun 2025 07:03:41 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOWXi-00000003Xpq-3XlZ
	for kexec@lists.infradead.org;
	Mon, 09 Jun 2025 07:03:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749452619; x=1780988619;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=XcnfmvlhIF30BE7p6htpDEP/XNEkMJK0HdmXgaozwwg=;
  b=AiohB4PCBT0A2pT/+ZY1xwqsP0YiA79k3iIvpI4S7LT1KYWVTgGozSjb
   sF6Q/w29FvLJ3NHROMGvRKtYAP0AMj1Qje17a++3p0CnC0e7nSVbyRsuB
   K3UONC6ANskAInRKguf96dvuh6UkgDj0bibciE0bhPzNIyDlTH4N+v/ki
   nrtGtaeXKYtXhc0lGUFrNPwB2pmv2VUigw5yc60BCMgL+eluhZK4tox36
   b9HHhFOIhIHwQ/BQBLcW6lNsJmeWLRdwVvWtjzoMr/RddR536m8xcpupy
   Eu5iSZBX8DGXaTukafQCzhfXpB6KGSwqq6Jt9MV5rSiCHzUV+ZUAb2AhS
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,221,1744070400"; 
   d="scan'208";a="753312924"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 07:03:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:37955]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.188:2525] with esmtp (Farcaster)
 id da5e9136-63b9-4140-819b-9bc25cba9392; Mon, 9 Jun 2025 07:03:14 +0000 (UTC)
X-Farcaster-Flow-ID: da5e9136-63b9-4140-819b-9bc25cba9392
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 9 Jun 2025 07:03:14 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 9 Jun 2025
 07:03:12 +0000
Message-ID: <f609d5a0-99d5-4328-8a18-00f6a9e1a48c@amazon.com>
Date: Mon, 9 Jun 2025 09:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] kexec: Enable CMA based contiguous allocation
From: Alexander Graf <graf@amazon.com>
To: <kexec@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, <nh-open-source@amazon.com>, Baoquan He
	<bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>, Andrew Morton
	<akpm@linux-foundation.org>
References: <20250521152934.48841-1-graf@amazon.com>
Content-Language: en-US
In-Reply-To: <20250521152934.48841-1-graf@amazon.com>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250609_000339_108369_C5679926 
X-CRM114-Status: GOOD (  26.93  )
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

Ck9uIDIxLjA1LjI1IDE3OjI5LCBBbGV4YW5kZXIgR3JhZiB3cm90ZToKPiBXaGVuIGJvb3Rpbmcg
YSBuZXcga2VybmVsIHdpdGgga2V4ZWNfZmlsZSwgdGhlIGtlcm5lbCBwaWNrcyBhIHRhcmdldAo+
IGxvY2F0aW9uIHRoYXQgdGhlIGtlcm5lbCBzaG91bGQgbGl2ZSBhdCwgdGhlbiBhbGxvY2F0ZXMg
cmFuZG9tIHBhZ2VzLAo+IGNoZWNrcyB3aGV0aGVyIGFueSBvZiB0aG9zZSBwYXRjaGVzIG1hZ2lj
YWxseSBoYXBwZW5zIHRvIGNvaW5jaWRlIHdpdGgKPiBhIHRhcmdldCBhZGRyZXNzIHJhbmdlIGFu
ZCBpZiBzbywgdXNlcyB0aGVtIGZvciB0aGF0IHJhbmdlLgo+Cj4gRm9yIGV2ZXJ5IHBhZ2UgYWxs
b2NhdGVkIHRoaXMgd2F5LCBpdCB0aGVuIGNyZWF0ZXMgYSBwYWdlIGxpc3QgdGhhdCB0aGUKPiBy
ZWxvY2F0aW9uIGNvZGUgLSBjb2RlIHRoYXQgZXhlY3V0ZXMgd2hpbGUgYWxsIENQVXMgYXJlIG9m
ZiBhbmQgd2UgYXJlCj4ganVzdCBhYm91dCB0byBqdW1wIGludG8gdGhlIG5ldyBrZXJuZWwgLSBj
b3BpZXMgdG8gdGhlaXIgZmluYWwgbWVtb3J5Cj4gbG9jYXRpb24uIFdlIGNhbiBub3QgcHV0IHRo
ZW0gdGhlcmUgYmVmb3JlLCBiZWNhdXNlIGNoYW5jZXMgYXJlIHByZXR0eQo+IGdvb2QgdGhhdCBh
dCBsZWFzdCBzb21lIHBhZ2UgaW4gdGhlIHRhcmdldCByYW5nZSBpcyBhbHJlYWR5IGluIHVzZSBi
eQo+IHRoZSBjdXJyZW50bHkgcnVubmluZyBMaW51eCBlbnZpcm9ubWVudC4gQ29weWluZyBpcyBo
YXBwZW5pbmcgZnJvbSBhCj4gc2luZ2xlIENQVSBhdCBSQU0gcmF0ZSwgd2hpY2ggdGFrZXMgYXJv
dW5kIDQtNTAgbXMgcGVyIDEwMCBNaUIuCj4KPiBBbGwgb2YgdGhpcyBpcyBpbmVmZmljaWVudCBh
bmQgZXJyb3IgcHJvbmUuCj4KPiBUbyBzdWNjZXNzZnVsbHkga2V4ZWMsIHdlIG5lZWQgdG8gcXVp
ZXNjZSBhbGwgZGV2aWNlcyBvZiB0aGUgb3V0Z29pbmcKPiBrZXJuZWwgc28gdGhleSBkb24ndCBz
Y3JpYmJsZSBvdmVyIHRoZSBuZXcga2VybmVsJ3MgbWVtb3J5LiBXZSBoYXZlIHNlZW4KPiBjYXNl
cyB3aGVyZSB0aGF0IGRvZXMgbm90IGhhcHBlbiBwcm9wZXJseSAoKmNvdWdoKiBHSUMgKmNvdWdo
KikgYW5kIGhlbmNlCj4gdGhlIG5ldyBrZXJuZWwgd2FzIGNvcnJ1cHRlZC4gVGhpcyBzdGFydGVk
IGEgbW9udGggbG9uZyBqb3VybmV5IHRvIHJvb3QKPiBjYXVzZSBmYWlsaW5nIGtleGVjcyB0byBl
dmVudHVhbGx5IHNlZSBtZW1vcnkgY29ycnVwdGlvbiwgYmVjYXVzZSB0aGUgbmV3Cj4ga2VybmVs
IHdhcyBjb3JydXB0ZWQgc2V2ZXJlbHkgZW5vdWdoIHRoYXQgaXQgY291bGQgbm90IGVtaXQgb3V0
cHV0IHRvCj4gdGVsbCB1cyBhYm91dCB0aGUgZmFjdCB0aGF0IGl0IHdhcyBjb3JydXB0ZWQuIEJ5
IGFsbG9jYXRpbmcgbWVtb3J5IGZvciB0aGUKPiBuZXh0IGtlcm5lbCBmcm9tIGEgbWVtb3J5IHJh
bmdlIHRoYXQgaXMgZ3VhcmFudGVlZCBzY3JpYmJsaW5nIGZyZWUsIHdlIGNhbgo+IGJvb3QgdGhl
IG5leHQga2VybmVsIHVwIHRvIGEgcG9pbnQgd2hlcmUgaXQgaXMgYXQgbGVhc3QgYWJsZSB0byBk
ZXRlY3QKPiBjb3JydXB0aW9uIGFuZCBtYXliZSBldmVuIHN0b3AgaXQgYmVmb3JlIGl0IGJlY29t
ZXMgc2V2ZXJlLiBUaGlzIGluY3JlYXNlcwo+IHRoZSBjaGFuY2UgZm9yIHN1Y2Nlc3NmdWwga2V4
ZWNzLgo+Cj4gU2luY2Uga2V4ZWMgZ290IGludHJvZHVjZWQsIExpbnV4IGhhcyBnYWluZWQgdGhl
IENNQSBmcmFtZXdvcmsgd2hpY2gKPiBjYW4gcGVyZm9ybSBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMg
bWVtb3J5IG1hcHBpbmdzLCB3aGlsZSBrZWVwaW5nIHRoYXQKPiBtZW1vcnkgYXZhaWxhYmxlIGZv
ciBtb3ZhYmxlIG1lbW9yeSB3aGVuIGl0IGlzIG5vdCBuZWVkZWQgZm9yIGNvbnRpZ3VvdXMKPiBh
bGxvY2F0aW9ucy4gVGhlIGRlZmF1bHQgQ01BIGFsbG9jYXRvciBpcyBmb3IgRE1BIGFsbG9jYXRp
b25zLgo+Cj4gVGhpcyBwYXRjaCBhZGRzIGxvZ2ljIHRvIHRoZSBrZXhlYyBmaWxlIGxvYWRlciB0
byBhdHRlbXB0IHRvIHBsYWNlIHRoZQo+IHRhcmdldCBwYXlsb2FkIGF0IGEgbG9jYXRpb24gYWxs
b2NhdGVkIGZyb20gQ01BLiBJZiBzdWNjZXNzZnVsLCBpdCB1c2VzCj4gdGhhdCBtZW1vcnkgcmFu
Z2UgZGlyZWN0bHkgaW5zdGVhZCBvZiBjcmVhdGluZyBjb3B5IGluc3RydWN0aW9ucyBkdXJpbmcK
PiB0aGUgaG90IHBoYXNlLiBUbyBlbnN1cmUgdGhhdCB0aGVyZSBpcyBhIHNhZmV0eSBuZXQgaW4g
Y2FzZSBhbnl0aGluZyBnb2VzCj4gd3Jvbmcgd2l0aCB0aGUgQ01BIGFsbG9jYXRpb24sIGl0IGFs
c28gYWRkcyBhIGZsYWcgZm9yIHVzZXIgc3BhY2UgdG8gZm9yY2UKPiBkaXNhYmxlIENNQSBhbGxv
Y2F0aW9ucy4KPgo+IFVzaW5nIENNQSBhbGxvY2F0aW9ucyBoYXMgdHdvIGFkdmFudGFnZXM6Cj4K
PiAgICAxKSBGYXN0ZXIgYnkgNC01MCBtcyBwZXIgMTAwIE1pQi4gVGhlcmUgaXMgbm8gbW9yZSBu
ZWVkIHRvIGNvcHkgaW4gdGhlCj4gICAgICAgaG90IHBoYXNlLgo+ICAgIDIpIE1vcmUgcm9idXN0
LiBFdmVuIGlmIGJ5IGFjY2lkZW50IHNvbWUgcGFnZSBpcyBzdGlsbCBpbiB1c2UgZm9yIERNQSwK
PiAgICAgICB0aGUgbmV3IGtlcm5lbCBpbWFnZSB3aWxsIGJlIHNhZmUgZnJvbSB0aGF0IGFjY2Vz
cyBiZWNhdXNlIGl0IHJlc2lkZXMKPiAgICAgICBpbiBhIG1lbW9yeSByZWdpb24gdGhhdCBpcyBj
b25zaWRlcmVkIGFsbG9jYXRlZCBpbiB0aGUgb2xkIGtlcm5lbCBhbmQKPiAgICAgICBoYXMgYSBj
aGFuY2UgdG8gcmVpbml0aWFsaXplIHRoYXQgY29tcG9uZW50Lgo+Cj4gU2lnbmVkLW9mZi1ieTog
QWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KCgpQaW5nPyBOb3Qgc2VlaW5nIHRoaXMg
cGF0Y2ggaW4gTGludXMnIG1hc3RlciB0cmVlIDopCgpBbGV4CgoKCgoKQW1hem9uIFdlYiBTZXJ2
aWNlcyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMK
MTAyNDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9u
YXRoYW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50
ZXIgSFJCIDI1Nzc2NCBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDM2NSA1MzggNTk3Cg==



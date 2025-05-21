Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D05C2D0CD
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nk8z5Gs5eLoZgW+Hc5Wq/7fT0NKPPcI5LGcc9H4Q4dE=; b=NpjNEF3gmVBKsq8zvu6vTX4fws
	8EP491NDpWq4zpBF1uFpEKyIzMD2BePsImBc7O/DNn/i/WXx1pyirVfKUmUVH9NZ8S8FdOFJLDvt7
	BsUlq58cUq02TaRBYcl73t5BWyoexOvH1xHUUBm7NASR2P/KDUFar/Jfk0MbD3lqjBtarCzIXLMD6
	unMd+fbwogvLv/1cR3TKe2WRtNDJIxxbJBKqPt4fm+xzrBug+er9qnkwqS5OZY7Pzj6A2gVjM5hLF
	iCdoBQDAZ002FuhiuZDIcWwrRLIpiqLNbOfgz8wtCDKxlAYaMD3O9A8VLoj1cwEH6f8JQbjJP55LQ
	N5YtU40g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHlQy-0000000GHze-1gIu;
	Wed, 21 May 2025 15:32:44 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHlOy-0000000GHlC-3DWG
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 15:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747841440; x=1779377440;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nk8z5Gs5eLoZgW+Hc5Wq/7fT0NKPPcI5LGcc9H4Q4dE=;
  b=T6XWa/BwlgtlvRvclMZ2qauGh/LUXoP4Q/fswOwUCIdID6bQ1crWBm84
   GoNomQqWR89aJgSsZVEAuVAKozU3nPGY4fVlhrRSJ4vdM8CFQBqYu4Nxj
   f7wEJJfkhrwtQjcFApvKIpZf8ZDsN9vhaW0aZIlzb4Dz4OeX4Br49nEHH
   3ppp3t9FEcKAMx9aRXFRcugh/QVCENPbsLBYh4kwkPY60s5XMxTGxBdwN
   +9yB0Q1JR37pgRarT1N8mT/Op/L6JFsoLXhAJuAxa02pnOzu0Gl6vlN1A
   1JbMCyPSJ7cdlEMOArOx3gVNXG3ZAdosIRbwRk6f6KWJ7etoCZM7rR6EF
   g==;
X-IronPort-AV: E=Sophos;i="6.15,303,1739836800"; 
   d="scan'208";a="199384302"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 15:30:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:50565]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.96:2525] with esmtp (Farcaster)
 id 20b6510f-c251-4956-8061-047d8f31a265; Wed, 21 May 2025 15:30:38 +0000 (UTC)
X-Farcaster-Flow-ID: 20b6510f-c251-4956-8061-047d8f31a265
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 21 May 2025 15:30:36 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC003.ant.amazon.com
 (10.13.138.187) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Wed, 21 May 2025
 15:30:34 +0000
Message-ID: <3e1ffd2e-b002-48b5-b41c-24787aa652e3@amazon.com>
Date: Wed, 21 May 2025 17:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kexec: Enable CMA based contiguous allocation
To: Baoquan He <bhe@redhat.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>
CC: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
	<nh-open-source@amazon.com>
References: <20250513180229.7494-1-graf@amazon.com>
 <CACSyD1OU1zjvc2YdQpi-F_qZ0EWyb6jLNODJkRDPQa6m1eObJg@mail.gmail.com>
 <aC2rNv49pzy1Wh3D@MiWiFi-R3L-srv>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <aC2rNv49pzy1Wh3D@MiWiFi-R3L-srv>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D020UWC003.ant.amazon.com (10.13.138.187)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_083040_850559_7D9F5914 
X-CRM114-Status: GOOD (  11.99  )
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

Ck9uIDIxLjA1LjI1IDEyOjMwLCBCYW9xdWFuIEhlIHdyb3RlOgo+Cj4gT24gMDUvMjEvMjUgYXQg
MDM6NDdwbSwgWmhvbmdrdW4gSGUgd3JvdGU6Cj4+IE9uIFdlZCwgTWF5IDE0LCAyMDI1IGF0IDI6
NDDigK9BTSBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPiB3cm90ZToKPiAuLi4uLi4K
Pj4+ICAgLyoqCj4+PiAgICAqIGtleGVjX2xvY2F0ZV9tZW1faG9sZSAtIGZpbmQgZnJlZSBtZW1v
cnkgZm9yIHRoZSBwdXJnYXRvcnkgb3IgdGhlIG5leHQga2VybmVsCj4+PiAgICAqIEBrYnVmOiAg
ICAgIFBhcmFtZXRlcnMgZm9yIHRoZSBtZW1vcnkgc2VhcmNoLgo+Pj4gQEAgLTY0OCw2ICs2ODQs
MTMgQEAgaW50IGtleGVjX2xvY2F0ZV9tZW1faG9sZShzdHJ1Y3Qga2V4ZWNfYnVmICprYnVmKQo+
Pj4gICAgICAgICAgaWYgKGtidWYtPm1lbSAhPSBLRVhFQ19CVUZfTUVNX1VOS05PV04pCj4+PiAg
ICAgICAgICAgICAgICAgIHJldHVybiAwOwo+Pj4KPj4+ICsgICAgICAgLyoKPj4+ICsgICAgICAg
ICogVHJ5IHRvIGZpbmQgYSBmcmVlIHBoeXNpY2FsbHkgY29udGlndW91cyBibG9jayBvZiBtZW1v
cnkgZmlyc3QuIFdpdGggdGhhdCwgd2UKPj4+ICsgICAgICAgICogY2FuIGF2b2lkIGFueSBjb3B5
aW5nIGF0IGtleGVjIHRpbWUuCj4+PiArICAgICAgICAqLwo+Pj4gKyAgICAgICBpZiAoIWtleGVj
X2FsbG9jX2NvbnRpZyhrYnVmKSkKPj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4gSUlV
QywgVGhlIGtleGVjX2xvY2F0ZV9tZW1faG9sZSgpIGZ1bmN0aW9uIGlzIGFsc28gdXNlZCBpbgo+
PiB0aGUgS0VYRUNfVFlQRV9DUkFTSCBraW1hZ2UsIGJ1dCBrZXhlY19hbGxvY19jb250aWcoKSBk
b2VzIG5vdCBza2lwIGl0Lgo+PiBUaGlzIGNhbiBjYXVzZSBrZHVtcCB0byBmYWlsIGFuZCBsZWFk
IHRvIENNQSBtZW1vcnkgbGVha2FnZS4KPiBUaGF0IGlzIHRydWUgYW5kIGdvb2QgY2F0Y2gsIGFu
ZCBmaXggaXMgbmVlZGVkIHRvIHNraXAgY21hIGFsbG9jIGZvcgo+IGtkdW1wLgoKClRoYW5rcyBm
b3IgY2F0Y2hpbmcgdGhpcyEgSSBhZGRlZCBhIGNoZWNrIHRvIGVuc3VyZSB3ZSBkb24ndCB1c2Ug
dGhlIENNQSAKbG9naWMgd2l0aCBjcmFzaCBrZXJuZWxzIGluIHY0IGFuZCBwb3N0ZWQgaXQuCgoK
QWxleAoKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkg
R21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1bmc6
IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVpbmdldHJhZ2VuIGFtIEFtdHNn
ZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0
LUlEOiBERSAzNjUgNTM4IDU5Nwo=



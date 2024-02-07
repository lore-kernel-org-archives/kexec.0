Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6518C4828D
	for <kexec@archiver.kernel.org>; Wed,  7 Feb 2024 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9tOPJb3OgrD0iXehMoySZEVnFgZ1LHifQxgWB1a31E=; b=g2nx98o7eYX9Dc
	Fob+70hZUGRbCFwpXeRIKNtr6ybFqjxErLUScMiErG14+25x7vNw6JXwcw9w2PK353XoM9hWtu+kK
	1VyNkA4rzkLNzSUWe6hlWOtccxEgHZoRAZNjx5esXCwD3lkXEeOwV4zocBIzk1UJ5rskqn38dq+/y
	TMGDJLzMJPqtlmYFPe5Ffa2RYMnKDPA9mA6DOACL55ezPhG1yOwSWB15RHKliVy7KC4OkAlV/JUhS
	NCSKhIit1tIYL8aI+i4drvfTS0Ol7oGW75Xcp4ywFU7C5x5CbLoiyRbVwtcAqikosE0SvOn+vwYTL
	7AiHu253J1NHpdu7fP9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXjM0-0000000B0P6-269a;
	Wed, 07 Feb 2024 14:56:48 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXjLy-0000000B0N7-1fXj
	for kexec@lists.infradead.org;
	Wed, 07 Feb 2024 14:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1707317807; x=1738853807;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=TkFpvZmkphqkK0Mc10r/Fe7liBcw8osCeQ/jSq2WNzk=;
  b=SNuyea+JgvDXElPZqn5EG8uPXppEFA16FlroZkymxbDm3dyNH7bxsAEX
   havE6SP+ZTe6WJU+LxDU4+wsduqJPmA7VgyiLGaRFq5F6ql7rfzp9F72P
   2Z+q849+nB5QBz06sGsAyPFwEkAT3lsFa+bxBJUkhyw0ZrwVa6iR505ar
   s=;
X-IronPort-AV: E=Sophos;i="6.05,251,1701129600"; 
   d="scan'208";a="702749743"
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Thread-Topic: [RFC 00/18] Pkernfs: Support persistence for live update
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 14:56:36 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:53357]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.191:2525] with esmtp (Farcaster)
 id 163cb722-79c0-4cd0-bb34-f3f452cd665d; Wed, 7 Feb 2024 14:56:33 +0000 (UTC)
X-Farcaster-Flow-ID: 163cb722-79c0-4cd0-bb34-f3f452cd665d
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:56:33 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 7 Feb 2024 14:56:33 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Wed, 7 Feb 2024 14:56:33 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "anthony.yznaga@oracle.com"
	<anthony.yznaga@oracle.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "steven.sistare@oracle.com"
	<steven.sistare@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "ebiederm@xmission.com"
	<ebiederm@xmission.com>, =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?=
	<jschoenh@amazon.de>, "will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Thread-Index: AQHaWFZfiDfmUo9FfU6oG+xq/LSkjrD++v0A
Date: Wed, 7 Feb 2024 14:56:33 +0000
Message-ID: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
References: <20240205120203.60312-1-jgowans@amazon.com>
	 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
In-Reply-To: <20240205101040.5d32a7e4.alex.williamson@redhat.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.95.74.199]
Content-ID: <E7A761E4DFFA1B418369CD572A93C5BE@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_065646_500930_9210B9BB 
X-CRM114-Status: GOOD (  16.26  )
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

T24gTW9uLCAyMDI0LTAyLTA1IGF0IDEwOjEwIC0wNzAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6
DQo+ID4gKiBOZWVkaW5nIHRvIGRyaXZlIGFuZCByZS1oeWRyYXRlIHRoZSBJT01NVSBwYWdlIHRh
YmxlcyBieSBkZWZpbmluZw0KPiA+IGFuIElPTU1VIGZpbGUuDQo+ID4gUmVhbGx5IHdlIHNob3Vs
ZCBtb3ZlIHRoZSBhYnN0cmFjdGlvbiBvbmUgbGV2ZWwgdXAgYW5kIG1ha2UgdGhlDQo+ID4gd2hv
bGUgVkZJTw0KPiA+IGNvbnRhaW5lciBwZXJzaXN0ZW50IHZpYSBhIHBrZXJuZnMgZmlsZS4gVGhh
dCB3YXkgeW914oCZZCAianVzdCIgcmUtDQo+ID4gb3BlbiB0aGUgVkZJTw0KPiA+IGNvbnRhaW5l
ciBmaWxlIGFuZCBhbGwgb2YgdGhlIERNQSBtYXBwaW5ncyBpbnNpZGUgVkZJTyB3b3VsZCBhbHJl
YWR5DQo+ID4gYmUgc2V0IHVwLg0KPiANCj4gTm90ZSB0aGF0IHRoZSB2ZmlvIGNvbnRhaW5lciBp
cyBvbiBhIHBhdGggdG93YXJkcyBkZXByZWNhdGlvbiwgdGhpcw0KPiBzaG91bGQgYmUgcmVmb2N1
c2VkIG9uIHZmaW8gcmVsYXRpdmUgdG8gaW9tbXVmZC7CoCBUaGVyZSB3b3VsZCBuZWVkIHRvDQo+
IGJlIGEgc3Ryb25nIGFyZ3VtZW50IGZvciBhIGNvbnRhaW5lci90eXBlMSBleHRlbnNpb24gdG8g
c3VwcG9ydCB0aGlzLA0KPiBpb21tdWZkIHdvdWxkIG5lZWQgdG8gYmUgdGhlIGZpcnN0IGNsYXNz
IGltcGxlbWVudGF0aW9uLsKgIFRoYW5rcywNCg0KQWNrISBXaGVuIEkgZmlyc3Qgc3RhcnRlZCBw
dXR0aW5nIHBrZXJuZnMgdG9nZXRoZXIsIGlvbW11ZmQgd2Fzbid0DQppbnRlZ3JhdGVkIGludG8g
UUVNVSB5ZXQsIGhlbmNlIEkgc3R1Y2sgd2l0aCBWRklPIGZvciB0aGlzIFBvQy4NCkknbSB0aHJp
bGxlZCB0byBzZWUgdGhhdCBpb21tdWZkIG5vdyBzZWVtcyB0byBiZSBpbnRlZ3JhdGVkIGluIFFF
TVUhDQpHb29kIG9wcG9ydHVuaXR5IHRvIGdldCB0byBncmlwcyB3aXRoIGl0Lg0KDQpUaGUgVkZJ
Ty1zcGVjaWZpYyBwYXJ0IG9mIHRoaXMgcGF0Y2ggaXMgZXNzZW50aWFsbHkgaW9jdGxzIG9uIHRo
ZQ0KKmNvbnRhaW5lciogdG8gYmUgYWJsZSB0bzoNCg0KMS4gZGVmaW5lIHBlcnNpc3RlbnQgcGFn
ZSB0YWJsZXMgKFBQVHMpIG9uIHRoZSBjb250YWluZXJzIHNvIHRoYXQgdGhvc2UNClBQVHMgYXJl
IHVzZWQgYnkgdGhlIElPTU1VIGRvbWFpbiBhbmQgaGVuY2UgYnkgYWxsIGRldmljZXMgYWRkZWQg
dG8gdGhhdA0KY29udGFpbmVyLg0KaHR0cHM6Ly9naXRodWIuY29tL2pnb3dhbnMvcWVtdS9jb21t
aXQvZTg0Y2ZiODE4NmQ3MWY3OTdlZjFmNzJkNTdkODczMjIyYTliNDc5ZQ0KDQoyLiBUZWxsIFZG
SU8gdG8gYXZvaWQgbWFwcGluZyB0aGUgbWVtb3J5IGluIGFnYWluIGFmdGVyIGxpdmUgdXBkYXRl
DQpiZWNhdXNlIGl0IGFscmVhZHkgZXhpc3RzLg0KaHR0cHM6Ly9naXRodWIuY29tL2pnb3dhbnMv
cWVtdS9jb21taXQvNmU0ZjE3ZjcwM2VhZjJhNmYxZTRjYjI1NzZkNjE2ODNlYWVlMDJiMA0KKHRo
ZSBhYm92ZSBmbGFnIHNob3VsZCBvbmx5IGJlIHNldCAqYWZ0ZXIqIGxpdmUgdXBkYXRlLi4uKS4N
Cg0KRG8geW91IGhhdmUgYSByb3VnaCBzdWdnZXN0aW9uIGFib3V0IGhvdyBzaW1pbGFyIGNvdWxk
IGJlIGRvbmUgd2l0aA0KaW9tbXVmZD8NCg0KSkcNCg0KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=

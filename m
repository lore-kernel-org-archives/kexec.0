Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD7C4167B
	for <kexec@archiver.kernel.org>; Sat,  9 Dec 2023 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tVh5XGkYIEUsddNTxvlJuC02fZzkkEHZ8JbIHj+eDiY=; b=XzxaikoyEYX3QL
	4K2ycPd+C/BYCGQGOaYgA5YU7Yb3V0aSq1UuwihOM2lNMvmOecLLIGQMMxVu0Wfii7zibHkOulSjo
	+iHez/c+idfnYe4nuA6h/+MT9f4DslO9zU+G16X7aG8RXZ3JeRSelAVR2lwibCdAqVx7AnUaSjxDK
	anqvo+VceidhfVuUF+9jrXOsktQC/eKHUGYw8EexuTlw6fcWCqCxCYuiOhBa7zBKXqshfzMOjstUs
	AL6uiUd56rD7WB9AmygDR+KY06eQNJTn4siJI/4VhV/nDxMLNI5T0Jkomxr/vhP2e+8YpOGxAS4QC
	FdAG726euBDg7iVffiUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBrjl-00HFMG-20;
	Sat, 09 Dec 2023 07:26:57 +0000
Received: from smtp-fw-80007.amazon.com ([99.78.197.218])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBrjg-00HFLm-0M;
	Sat, 09 Dec 2023 07:26:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702106813; x=1733642813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4okwfpjiOL9ZonK2dWGC50lt5XsgIOEt8Jz9Lhvjzo4=;
  b=mGb7vJyS2EOpon5TR24zhgBDo8ze6dJvIPcL7CCkj2ns0HL36vwhj9kH
   wZfvHC10JB3w0jKAARx2YqEuW3jLxwX1FJWuAmUTqwi3ulMP4JZtLCPtK
   DCznjl83rD1WdRQE+CR6YocipIKKVgo9iBLw0wueKmjK+13WCTkoDh3bq
   8=;
X-IronPort-AV: E=Sophos;i="6.04,262,1695686400"; 
   d="scan'208";a="258537457"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 07:26:47 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-d8e96288.us-east-1.amazon.com (Postfix) with ESMTPS id C784184A4F;
	Sat,  9 Dec 2023 07:26:41 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:62225]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.20.114:2525] with esmtp (Farcaster)
 id 6f872b6f-41b3-41a6-ab54-db2adfc2df23; Sat, 9 Dec 2023 07:26:40 +0000 (UTC)
X-Farcaster-Flow-ID: 6f872b6f-41b3-41a6-ab54-db2adfc2df23
Received: from EX19D012EUC004.ant.amazon.com (10.252.51.220) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 07:26:37 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC004.ant.amazon.com (10.252.51.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 07:26:37 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Sat, 9 Dec 2023 07:26:37 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "seanjc@google.com" <seanjc@google.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>
CC: "yuzenghui@huawei.com" <yuzenghui@huawei.com>, "atishp@atishpatra.org"
	<atishp@atishpatra.org>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "maz@kernel.org"
	<maz@kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
	"anup@brainfault.org" <anup@brainfault.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to
 hook restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier
 to hook restart/shutdown
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCA
Date: Sat, 9 Dec 2023 07:26:36 +0000
Message-ID: <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
	 <20230512233127.804012-2-seanjc@google.com>
In-Reply-To: <20230512233127.804012-2-seanjc@google.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.221]
Content-ID: <A719B06918EA30498C61BE1015DC918C@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_232652_229006_35E3FD03 
X-CRM114-Status: GOOD (  13.79  )
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

SGkgU2VhbiwNCg0KQmxhc3QgZnJvbSB0aGUgcGFzdCBidXQgSSd2ZSBqdXN0IGJlZW4gYml0dGVu
IGJ5IHRoaXMgcGF0Y2ggd2hlbg0KcmViYXNpbmcgYWNyb3NzIHY2LjQuDQoNCk9uIEZyaSwgMjAy
My0wNS0xMiBhdCAxNjozMSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToNCj4gVXNl
IHN5c2NvcmVfb3BzLnNodXRkb3duIHRvIGRpc2FibGUgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24g
ZHVyaW5nIGENCj4gcmVib290IGluc3RlYWQgb2YgdXNpbmcgdGhlIGRlZGljYXRlZCByZWJvb3Rf
bm90aWZpZXIgc28gdGhhdCBLVk0gZGlzYWJsZXMNCj4gdmlydHVhbGl6YXRpb24gX2FmdGVyXyBz
eXN0ZW1fc3RhdGUgaGFzIGJlZW4gdXBkYXRlZC7CoCBUaGlzIHdpbGwgYWxsb3cNCj4gZml4aW5n
IGEgcmFjZSBpbiBLVk0ncyBoYW5kbGluZyBvZiBhIGZvcmNlZCByZWJvb3Qgd2hlcmUgS1ZNIGNh
biBlbmQgdXANCj4gZW5hYmxpbmcgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24gYmV0d2VlbiBrZXJu
ZWxfcmVzdGFydF9wcmVwYXJlKCkgYW5kDQo+IG1hY2hpbmVfcmVzdGFydCgpLg0KDQpUaGUgaXNz
dWUgaXMgdGhhdCwgQUZBSUNULCB0aGUgc3lzY29yZV9vcHMuc2h1dGRvd24gYXJlIG5vdCBjYWxs
ZWQgd2hlbg0KZG9pbmcgYSBrZXhlYy4gUmVib290IG5vdGlmaWVycyBhcmUgY2FsbGVkIGFjcm9z
cyBrZXhlYyB2aWE6DQoNCmtlcm5lbF9rZXhlYw0KICBrZXJuZWxfcmVzdGFydF9wcmVwYXJlDQog
ICAgYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbg0KICAgICAga3ZtX3JlYm9vdA0KDQpTbyBh
ZnRlciB0aGlzIHBhdGNoLCBLVk0gaXMgbm90IHNodXRkb3duIGR1cmluZyBrZXhlYzsgaWYgaGFy
ZHdhcmUgdmlydA0KbW9kZSBpcyBlbmFibGVkIHRoZW4gdGhlIGtleGVjIGhhbmdzIGluIGV4YWN0
bHkgdGhlIHNhbWUgbWFubmVyIGFzIHlvdQ0KZGVzY3JpYmUgd2l0aCB0aGUgcmVib290Lg0KDQpT
b21lIHNwZWNpZmljIHNodXRkb3duIGNhbGxiYWNrcywgZm9yIGV4YW1wbGUgSU9NTVUsIEhQRVQs
IElSUSwgZXRjIGFyZQ0KY2FsbGVkIGluIG5hdGl2ZV9tYWNoaW5lX3NodXRkb3duLCBidXQgS1ZN
IGlzIG5vdCBvbmUgb2YgdGhlc2UuDQoNClRob3VnaHRzIG9uIHBvc3NpYmxlIHdheXMgdG8gZml4
IHRoaXM6DQphKSBnbyBiYWNrIHRvIHJlYm9vdCBub3RpZmllcnMNCmIpIGdldCBrZXhlYyB0byBj
YWxsIHN5c2NvcmVfc2h1dGRvd24oKSB0byBpbnZva2UgYWxsIG9mIHRoZXNlIGNhbGxiYWNrcw0K
YykgQWRkIGEgS1ZNLXNwZWNpZmljIGNhbGxiYWNrIHRvIG5hdGl2ZV9tYWNoaW5lX3NodXRkb3du
KCk7IHdlIG9ubHkNCm5lZWQgdGhpcyBmb3IgSW50ZWwgeDg2LCByaWdodD8NCg0KTXkgc2xpZ2h0
IHByZWZlcmVuY2UgaXMgdG93YXJkcyBhZGRpbmcgc3lzY29yZV9zaHV0ZG93bigpIHRvIGtleGVj
LCBidXQNCkknbSBub3Qgc3VyZSB0aGF0J3MgZmVhc2libGUuIEFkZGluZyBrZXhlYyBtYWludGFp
bmVycyBmb3IgaW5wdXQuDQoNCkpHDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

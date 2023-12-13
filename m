Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2D5C4332F
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 06:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZPib7o0o+bvJTFfC16kiVjCCPEXRqu/9+S37vs6zsQ=; b=4l4s76eUuydvNm
	MsxMBFYt+m2LP2dT/Vd1BuPFoNVEJEHeAOhrUga5sYtz983dE9kcWDXOQT2w8FVu/79lvq+9wV2w9
	fGi4mTUCveVuCosnpl4BkxqEk69vvZBSAFQDFyOMwl12SaU+p9/9NPygvHCvjyrjmcAD2CtqbFAZg
	uZIar++JV/BTYmojCszE+xIulV6DdOJWY4e5MM2C4ze5geK96X5Uul1xJdzxGzI3w8XrZcdS30uT5
	H5Mkf+1atrlk/p4TTgnD31uY0Wr2tKj7icyBdoP/4pDkXbsqH/tHr+MTv6BreYMo22Du+IHoXgWju
	LWYG50t4xgO/vgc/dEIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDJ2X-00DpPV-2G;
	Wed, 13 Dec 2023 06:48:17 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDJ2T-00DpO3-1k;
	Wed, 13 Dec 2023 06:48:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702450094; x=1733986094;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=T4YzwzIh5x/zMGeD1nVoy0zE9fuJYRN3bXfZYwH+II0=;
  b=E8xDoeJ+f6Ckp4QQaYJEnC+AjzdX0jfA497Wr5XcIWa59/KccwRJkY7p
   jsxi0xCiaFrFFdNkK5HBZN3sq+Xz78zSj/0vb/enOt0vabP0waygp5J0+
   SkFEb1KGbD7ch1jVTeqZ8NnYmH3LZrfbbadfo2Xpg211mwhz8xiffTv00
   A=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="373461589"
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 06:48:06 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-9694bb9e.us-east-1.amazon.com (Postfix) with ESMTPS id 3194380750;
	Wed, 13 Dec 2023 06:48:01 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:65523]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.73:2525] with esmtp (Farcaster)
 id 3df70858-a3e1-4ab0-981d-8ca502e63e40; Wed, 13 Dec 2023 06:48:00 +0000 (UTC)
X-Farcaster-Flow-ID: 3df70858-a3e1-4ab0-981d-8ca502e63e40
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 06:48:00 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 06:48:00 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Wed, 13 Dec 2023 06:47:59 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>, "seanjc@google.com"
	<seanjc@google.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>
CC: "yuzenghui@huawei.com" <yuzenghui@huawei.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"atishp@atishpatra.org" <atishp@atishpatra.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maz@kernel.org" <maz@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
	"anup@brainfault.org" <anup@brainfault.org>
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCAgAFn6T+AAcSbgIAAKp8AgADgykyAAJaPgIABcBIA
Date: Wed, 13 Dec 2023 06:47:59 +0000
Message-ID: <2811860ff7d24fd32dfa0cd8f0f36a33266a58df.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
	 <20230512233127.804012-2-seanjc@google.com>
	 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	 <871qbud5f9.fsf@email.froward.int.ebiederm.org>
	 <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
	 <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
	 <87wmtk9u46.fsf@email.froward.int.ebiederm.org>
	 <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
In-Reply-To: <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.114]
Content-ID: <446610E114709A4D85F3C8DF06BF2AAA@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_224813_713374_654EA5E4 
X-CRM114-Status: GOOD (  20.81  )
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

T24gVHVlLCAyMDIzLTEyLTEyIGF0IDEwOjUwICswMjAwLCBKYW1lcyBHb3dhbnMgd3JvdGU6DQo+
ID4gDQo+ID4gSW4gYW55IGV2ZW50IEkgYmVsaWV2ZSB0aGUgYnVnIHdpdGggcmVzcGVjdCB0byBr
ZXhlYyB3YXMgaW50cm9kdWNlZCBpbg0KPiA+IGNvbW1pdCA2ZjM4OWE4ZjFkZDIgKCJQTSAvIHJl
Ym9vdDogY2FsbCBzeXNjb3JlX3NodXRkb3duKCkgYWZ0ZXINCj4gPiBkaXNhYmxlX25vbmJvb3Rf
Y3B1cygpIikuwqAgVGhhdCBpcyB3aGVyZSBzeXNjb3JlX3NodXRkb3duIHdhcyByZW1vdmVkDQo+
ID4gZnJvbSBrZXJuZWxfcmVzdGFydF9wcmVwYXJlKCkuDQo+ID4gDQo+ID4gQXQgdGhpcyBwb2lu
dCBpdCBsb29rcyBsaWtlIHNvbWVvbmUganVzdCBuZWVkcyB0byBhZGQgdGhlIG1pc3NpbmcNCj4g
PiBzeXNjb3JlX3NodXRkb3duIGNhbGwgaW50byBrZXJuZWxfa2V4ZWMoKSByaWdodCBhZnRlcg0K
PiA+IG1pZ3JhdGVfdG9fcmVib290X2NwdSgpIGlzIGNhbGxlZC4NCj4gDQo+IFNlZW1zIGdvb2Qg
YW5kIEknbSBoYXBweSB0byBkbyB0aGF0OyBvbmUgdGhpbmcgd2UgbmVlZCB0byBjaGVjayBmaXJz
dDoNCj4gYXJlIGFsbCBDUFVzIG9ubGluZSBhdCB0aGF0IHBvaW50PyBUaGUgY29tbWl0IG1lc3Nh
Z2UgZm9yDQo+IDZmMzg5YThmMWRkMiAoIlBNIC8gcmVib290OiBjYWxsIHN5c2NvcmVfc2h1dGRv
d24oKSBhZnRlciBkaXNhYmxlX25vbmJvb3RfY3B1cygpIikNCj4gc3BlYWtzIGFib3V0OiAib25l
IENQVSBvbi1saW5lIGFuZCBpbnRlcnJ1cHRzIGRpc2FibGVkIiB3aGVuDQo+IHN5c2NvcmVfc2h1
dGRvd24gaXMgY2FsbGVkLiBLVk0ncyBzeXNjb3JlIHNodXRkb3duIGhvb2sgZG9lczoNCj4gDQo+
IG9uX2VhY2hfY3B1KGhhcmR3YXJlX2Rpc2FibGVfbm9sb2NrLCBOVUxMLCAxKTsNCj4gDQo+IC4u
LiBzbyB0aGF0IHNtZWxscyB0byBtZSBsaWtlIGl0IHdhbnRzIGFsbCB0aGUgQ1BVcyB0byBiZSBv
bmxpbmUgYXQNCj4ga3ZtX3NodXRkb3duIHBvaW50Lg0KPiANCj4gSXQncyBub3QgY2xlYXIgdG8g
bWU6DQo+IA0KPiAxLiBEb2VzIGhhcmR3YXJlX2Rpc2FibGVfbm9sb2NrIGFjdHVhbGx5IG5lZWQg
dG8gYmUgZG9uZSBvbiAqZXZlcnkqIENQVQ0KPiBvciB3b3VsZCB0aGUgb2ZmbGluZWQgb25lcyBi
ZSBmaW5lIHRvIGlnbm9yZSBiZWNhdXNlIHRoZXkgd2lsbCBiZSByZXNldA0KPiBhbmQgdGhlIFZN
WEUgYml0IHdpbGwgYmUgY2xlYXJlZCB0aGF0IHdheT8gV2l0aCBjb29wZXJhdGl2ZSBDUFUgaGFu
ZG92ZXINCj4gd2UgcHJvYmFibHkgZG8gaW5kZWVkIHdhbnQgdG8gZG8gdGhpcyBvbiBldmVyeSBD
UFUgYW5kIG5vdCBkZXBlbmQgb24NCj4gcmVzZXR0aW5nLg0KPiANCj4gMi4gQXJlIENQVXMgYWN0
dWFsbHkgb2ZmbGluZSBhdCB0aGlzIHBvaW50PyBXaGVuIHRoYXQgY29tbWl0IHdhcw0KPiBhdXRo
b3JlZCB0aGVyZSB1c2VkIHRvIGJlIGEgY2FsbCB0byBoYXJkd2FyZV9kaXNhYmxlX25vbG9jaygp
IGJ1dCB0aGF0J3MNCj4gbm90IHRoZXJlIGFueW1vcmUuDQoNCkkndmUgc2VudCBvdXQgYSBwYXRj
aDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2tleGVjLzIwMjMxMjEzMDY0MDA0LjI0MTk0NDct
MS1qZ293YW5zQGFtYXpvbi5jb20vVC8jdQ0KDQpMZXQncyBjb250aW51ZSB0aGUgZGlzY3Vzc2lv
biB0aGVyZS4NCg0KSkcNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

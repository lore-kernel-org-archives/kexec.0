Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B29C4167B
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=t44UucdoTf4rd7PZI1U/FS3cokwROqQN6hFImRKjAik=; b=xk5AJDumsRg4GC5NgrMmA3VFBB
	ACyD+NSIEujqJEr3xycTDbvQpdMW38oGBf7dSnZS+5H3k+IfEuyBlFJrlzY7HwRAE10K85MCj9Guj
	6BA9cFHk9G2QVBRvbkCKXuJuihyh4EF2CRbr/Xv/o15D6YGBY8rrIqQuBj3oLlU33C9Uh7cPvYexg
	bbsoxkKRVsp5U/AtfBhmGnjh2+Sj+mfX13Z1YV93bSUdchld0BUn9ebwsanMRrU4ltB+MSyYEAfmW
	lvdxZ8u++IIOyANdRxCOsAhRsyAELfll1cyeyDmAzgkwzglkd4mn1Sm8L5SH3EjAHEATu8b3p5YMP
	UW5W4HVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCkB9-006Ngn-0z;
	Mon, 11 Dec 2023 17:34:51 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCkAr-006NcD-2d
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 17:34:44 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d09a64eaebso41740065ad.3
        for <kexec@lists.infradead.org>; Mon, 11 Dec 2023 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702316066; x=1702920866; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dy1GZPt4ahloA1lKMAAh2vw8dnz9eCUNT+pZwXAOsM=;
        b=bby3CSpeweuC+94rI3O5hmeE8e2Td88Ckpm+zV6J2r2cQt/k7/AprEUrqpCboXAbPI
         uq8cCPHGVx5nNfirHp+HjxA3dknHg8zlSFvIYUCJBb+FiE7cPfjIO82aGQ9gfVA6VsWM
         heP6ygrMpH/EF8RpgWAvtkuP0ty+mBcHhWA9ci8BT3GU9G3SEBPD/aiw1Pf+V4kd1cCY
         4dg2Q6mmZ623LRa6D2ApODt0Oy/vYHo9zSQftLeyy77z0F5ht3wmzXue5lKEqIJ8QP+w
         fOXRhSGtTcQl/WhncLtgnw4AlVCh+1eO+DmTtSXq+DuBpNKKRZULWwF4NOzS9I0a8AO2
         529w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702316066; x=1702920866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4dy1GZPt4ahloA1lKMAAh2vw8dnz9eCUNT+pZwXAOsM=;
        b=IpNvVfy8jiwkH4bd9nTFn88ujZPvW0NCIOHvBxsepiJ5xFR8TjnIzIYggUB3iJaeAK
         nGuKEOX4mmVVoMhALk+aR4+rQjfM/HJGc5cEjsT3nR1HOuIHy+YnP1TzP8rAW0ue7jX0
         OTBHqxpCmnfNXsIu5KpcYxtI7iPsHwRIToRVnc1umNY4L5UQPCSuGbwd3IcPNcdewYC4
         zc7j5+hfvCOL+f/XD6w6YK4oIa8F/r0w5J7SWzuW4U+MS88Eg7iijRq61XziiX2M7dYH
         lW9xtApkqfGqrAL0w8pCSUnTrC72mDQKmYb2LdtksRjy+fU187j+2iRU3Z4fGkx/FIMu
         ljtQ==
X-Gm-Message-State: AOJu0YxM65u/MvRAoIqo/Vq7YS0etyhaXGEIqSAow6D1ddXkva/BVLcD
	kHyTPoMeojWnx0FDQe+U36HH2H4dcfM=
X-Google-Smtp-Source: AGHT+IHqkXvBHkzpZr4xBbgwsL3PvOCK8qSlSmIRPscVFj5vuMB/n5MJcuPBtGQA7MQkmEwS8R6UC/HFYLE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41cf:b0:1d0:80cd:4c44 with SMTP id
 u15-20020a17090341cf00b001d080cd4c44mr36557ple.10.1702316066276; Mon, 11 Dec
 2023 09:34:26 -0800 (PST)
Date: Mon, 11 Dec 2023 09:34:24 -0800
In-Reply-To: <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
Mime-Version: 1.0
References: <20230512233127.804012-1-seanjc@google.com> <20230512233127.804012-2-seanjc@google.com>
 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
Message-ID: <ZXdIIBUXcCIK28ys@google.com>
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to
 hook restart/shutdown
From: Sean Christopherson <seanjc@google.com>
To: James Gowans <jgowans@amazon.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Alexander Graf <graf@amazon.de>, 
	"Jan =?utf-8?Q?Sch=C3=B6nherr?=" <jschoenh@amazon.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "atishp@atishpatra.org" <atishp@atishpatra.org>, 
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>, "james.morse@arm.com" <james.morse@arm.com>, 
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "maz@kernel.org" <maz@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>, 
	"anup@brainfault.org" <anup@brainfault.org>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_093441_758911_74B3D3EA 
X-CRM114-Status: GOOD (  25.14  )
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

T24gU2F0LCBEZWMgMDksIDIwMjMsIEphbWVzIEdvd2FucyB3cm90ZToKPiBIaSBTZWFuLAo+IAo+
IEJsYXN0IGZyb20gdGhlIHBhc3QgYnV0IEkndmUganVzdCBiZWVuIGJpdHRlbiBieSB0aGlzIHBh
dGNoIHdoZW4KPiByZWJhc2luZyBhY3Jvc3MgdjYuNC4KPiAKPiBPbiBGcmksIDIwMjMtMDUtMTIg
YXQgMTY6MzEgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gPiBVc2Ugc3lzY29y
ZV9vcHMuc2h1dGRvd24gdG8gZGlzYWJsZSBoYXJkd2FyZSB2aXJ0dWFsaXphdGlvbiBkdXJpbmcg
YQo+ID4gcmVib290IGluc3RlYWQgb2YgdXNpbmcgdGhlIGRlZGljYXRlZCByZWJvb3Rfbm90aWZp
ZXIgc28gdGhhdCBLVk0gZGlzYWJsZXMKPiA+IHZpcnR1YWxpemF0aW9uIF9hZnRlcl8gc3lzdGVt
X3N0YXRlIGhhcyBiZWVuIHVwZGF0ZWQuwqAgVGhpcyB3aWxsIGFsbG93Cj4gPiBmaXhpbmcgYSBy
YWNlIGluIEtWTSdzIGhhbmRsaW5nIG9mIGEgZm9yY2VkIHJlYm9vdCB3aGVyZSBLVk0gY2FuIGVu
ZCB1cAo+ID4gZW5hYmxpbmcgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24gYmV0d2VlbiBrZXJuZWxf
cmVzdGFydF9wcmVwYXJlKCkgYW5kCj4gPiBtYWNoaW5lX3Jlc3RhcnQoKS4KPiAKPiBUaGUgaXNz
dWUgaXMgdGhhdCwgQUZBSUNULCB0aGUgc3lzY29yZV9vcHMuc2h1dGRvd24gYXJlIG5vdCBjYWxs
ZWQgd2hlbgo+IGRvaW5nIGEga2V4ZWMuIFJlYm9vdCBub3RpZmllcnMgYXJlIGNhbGxlZCBhY3Jv
c3Mga2V4ZWMgdmlhOgo+IAo+IGtlcm5lbF9rZXhlYwo+ICAga2VybmVsX3Jlc3RhcnRfcHJlcGFy
ZQo+ICAgICBibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluCj4gICAgICAga3ZtX3JlYm9vdAo+
IAo+IFNvIGFmdGVyIHRoaXMgcGF0Y2gsIEtWTSBpcyBub3Qgc2h1dGRvd24gZHVyaW5nIGtleGVj
OyBpZiBoYXJkd2FyZSB2aXJ0Cj4gbW9kZSBpcyBlbmFibGVkIHRoZW4gdGhlIGtleGVjIGhhbmdz
IGluIGV4YWN0bHkgdGhlIHNhbWUgbWFubmVyIGFzIHlvdQo+IGRlc2NyaWJlIHdpdGggdGhlIHJl
Ym9vdC4KPiAKPiBTb21lIHNwZWNpZmljIHNodXRkb3duIGNhbGxiYWNrcywgZm9yIGV4YW1wbGUg
SU9NTVUsIEhQRVQsIElSUSwgZXRjIGFyZQo+IGNhbGxlZCBpbiBuYXRpdmVfbWFjaGluZV9zaHV0
ZG93biwgYnV0IEtWTSBpcyBub3Qgb25lIG9mIHRoZXNlLgo+IAo+IFRob3VnaHRzIG9uIHBvc3Np
YmxlIHdheXMgdG8gZml4IHRoaXM6Cj4gYSkgZ28gYmFjayB0byByZWJvb3Qgbm90aWZpZXJzCj4g
YikgZ2V0IGtleGVjIHRvIGNhbGwgc3lzY29yZV9zaHV0ZG93bigpIHRvIGludm9rZSBhbGwgb2Yg
dGhlc2UgY2FsbGJhY2tzCj4gYykgQWRkIGEgS1ZNLXNwZWNpZmljIGNhbGxiYWNrIHRvIG5hdGl2
ZV9tYWNoaW5lX3NodXRkb3duKCk7IHdlIG9ubHkKPiBuZWVkIHRoaXMgZm9yIEludGVsIHg4Niwg
cmlnaHQ/CgpJIGRvbid0IGxpa2UgKGMpLiAgVk1YIGlzIHRoZSBtb3N0IHNlbnNpdGl2ZS9wcm9i
bGVtYXRpYywgZS5nLiB0aGUgd2hvbGUgYmxvY2tpbmcKb2YgSU5JVCB0aGluZywgYnV0IFNWTSBj
YW4gYWxzbyBydW4gYWZvdWwgb2YgRUZFUi5TVk1FIGJlaW5nIGNsZWFyZWQsIGFuZCBLVk0gcmVh
bGx5IApzaG91bGQgbGVhdmUgdmlydHVhbGl6YXRpb24gZW5hYmxlZCBhY3Jvc3Mga2V4ZWMoKSwg
ZXZlbiBpZiBsZWF2aW5nIHZpcnR1YWxpemF0aW9uCmVuYWJsZWQgaXMgcmVsYXRpdmVseSBiZW5p
Z24gb24gb3RoZXIgYXJjaGl0ZWN0dXJlcy4KCk9uZSBtb3JlIG9wdGlvbiB3b3VsZCBiZToKCiBk
KSBBZGQgYW5vdGhlciBzeWNvcmUgaG9vaywgZS5nLiBzeXNjb3JlX2tleGVjKCkgc3BlY2lmaWNh
bGx5IGZvciB0aGlzIHBhdGguCgo+IE15IHNsaWdodCBwcmVmZXJlbmNlIGlzIHRvd2FyZHMgYWRk
aW5nIHN5c2NvcmVfc2h1dGRvd24oKSB0byBrZXhlYywgYnV0Cj4gSSdtIG5vdCBzdXJlIHRoYXQn
cyBmZWFzaWJsZS4gQWRkaW5nIGtleGVjIG1haW50YWluZXJzIGZvciBpbnB1dC4KCkluIGEgdmFj
dXVtLCB0aGF0J2QgYmUgbXkgcHJlZmVyZW5jZSB0b28uICBJdCdzIHRoZSBvYnZpb3VzIGNob2lj
ZSBJTU8sIGUuZy4gdGhlCmtleGVjX2ltYWdlLT5wcmVzZXJ2ZV9jb250ZXh0IHBhdGggZG9lcyBz
eXNjb3JlX3N1c3BlbmQoKSAoYW5kIHRoZW4gcmVzdW1lKCksIHNvCml0J3Mgbm90IGNvbXBsZXRl
bHkgdW5jaGFydGVkIHRlcnJpdG9yeS4KCkhvd2V2ZXIsIHRoZXJlJ3MgYSByYXRoZXIgYmlnIHdy
aW5rbGUgaW4gdGhhdCBub3QgYWxsIG9mIHRoZSBleGlzdGluZyAuc2h1dGRvd24oKQppbXBsZW1l
bnRhdGlvbnMgYXJlIG9idmlvdXNseSBvayB0byBjYWxsIGR1cmluZyBrZXhlYy4gIEx1Y2tpbHks
IEFGQUlDVCB0aGVyZSBhcmUKdmVyeSBmZXcgdXNlcnMgb2YgdGhlIHN5c2NvcmUgLnNodXRkb3du
IGhvb2ssIHNvIGl0J3MgYXQgbGVhc3QgZmVhc2libGUgdG8gZ28gdGhhdApyb3V0ZS4KCng4Nidz
IG1jZV9zeXNjb3JlX3NodXRkb3duKCkgc2hvdWxkIGJlIG9rLCBhbmQgYXJndWFibHkgaXMgY29y
cmVjdCwgZS5nLiBJIGRvbid0CnNlZSBob3cgbGVhdmluZyAjTUMgcmVwb3J0aW5nIGVuYWJsZWQg
YWNyb3NzIGtleGVjIGNhbiB3b3JrLgoKbGVkdHJpZ19jcHVfc3lzY29yZV9zaHV0ZG93bigpIGlz
IGFsc28gbGlrZWx5IG9rIGFuZCBhcmd1YWJseSBjb3JyZWN0LgoKVGhlIGludGVycnVwdCBjb250
cm9sbGVycyB0aG91Z2g/ICB4ODYgZGlzYWJsZXMgSVJRcyBhdCB0aGUgdmVyeSBiZWdpbm5pbmcg
b2YKbWFjaGluZV9rZXhlYygpLCBzbyBpdCdzIGxpa2VseSBmaW5lLiAgQnV0IGV2ZXJ5IG90aGVy
IGFyY2hpdGVjdHVyZT8gIE5vIGNsdWUuCkUuZy4gUFBDJ3MgZGVmYXVsdF9tYWNoaW5lX2tleGVj
KCkgc2VuZHMgSVBJcyB0byBzaHV0ZG93biBvdGhlciBDUFVzLCB0aG91Z2ggSQpoYXZlIG5vIGlk
ZWEgaWYgdGhhdCBjYW4gcnVuIGFmb3VsIG9mIGFueSBvZiB0aGUgcGF0aHMgYmVsb3cuCgogICAg
ICAgIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvY2VsbC9zcHVfYmFzZS5jICAuc2h1dGRvd24gPSBz
cHVfc2h1dGRvd24sCiAgICAgICAgYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jCSAgICAg
ICAgLnNodXRkb3duID0gbWNlX3N5c2NvcmVfc2h1dGRvd24sCiAgICAgICAgYXJjaC94ODYva2Vy
bmVsL2k4MjU5LmMgICAgICAgICAgICAgICAgIC5zaHV0ZG93biA9IGk4MjU5QV9zaHV0ZG93biwK
ICAgICAgICBkcml2ZXJzL2lycWNoaXAvaXJxLWk4MjU5LmMJICAgICAgICAuc2h1dGRvd24gPSBp
ODI1OUFfc2h1dGRvd24sCiAgICAgICAgZHJpdmVycy9pcnFjaGlwL2lycS1zdW42aS1yLmMJICAg
ICAgICAuc2h1dGRvd24gPSBzdW42aV9yX2ludGNfc2h1dGRvd24sCiAgICAgICAgZHJpdmVycy9s
ZWRzL3RyaWdnZXIvbGVkdHJpZy1jcHUuYwkuc2h1dGRvd24gPSBsZWR0cmlnX2NwdV9zeXNjb3Jl
X3NodXRkb3duLAogICAgICAgIGRyaXZlcnMvcG93ZXIvcmVzZXQvc2MyN3h4LXBvd2Vyb2ZmLmMJ
LnNodXRkb3duID0gc2MyN3h4X3Bvd2Vyb2ZmX3NodXRkb3duLAogICAgICAgIGtlcm5lbC9pcnEv
Z2VuZXJpYy1jaGlwLmMJICAgICAgICAuc2h1dGRvd24gPSBpcnFfZ2Nfc2h1dGRvd24sCiAgICAg
ICAgdmlydC9rdm0va3ZtX21haW4uYwkgICAgICAgICAgICAgICAgLnNodXRkb3duID0ga3ZtX3No
dXRkb3duLAoKVGhlIHdob2xlIHRoaW5nIGlzIGEgYml0IG9mIGEgbWVzcy4gIEUuZy4geDg2IHRy
ZWF0cyBtYWNoaW5lX3NodXRkb3duKCkgZnJvbQprZXhlYyBwcmV0dHkgbXVjaCB0aGUgc2FtZSBh
cyBzaHV0ZG93biBmb3IgcmVib290LCBidXQgb3RoZXIgYXJjaGl0ZWN0dXJlcyBoYXZlCndoYXQg
YXBwZWFyIHRvIGJlIHVuaXF1ZSBwYXRocyBmb3IgaGFuZGxpbmcga2V4ZWMuCgpGV0lXLCBpZiB3
ZSB3YW50IHRvIGdvIHdpdGggb3B0aW9uIChiKSwgc3lzY29yZV9zaHV0ZG93bigpIGhvb2tzIGNv
dWxkIHVzZQprZXhlY19pbl9wcm9ncmVzcyB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gInJlZ3Vs
YXIiIHNodXRkb3duL3JlYm9vdCBhbmQga2V4ZWMuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==

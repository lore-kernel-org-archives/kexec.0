Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F18C10F05
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:From:Subject:Message-ID:
	References:Mime-Version:In-Reply-To:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=c8zIocskUJQIkpPFkSv4r8rqYXw+i6Bimig5wvx2ees=; b=HBWK8TJmXX9/RJqUJZng6s7AVK
	RKn+KtS0OzCwwi4TRByZaPfyBpZY2MY6hxizmx5oV0S2pJGK2jbmDDZlFWnt/bg7+2G/q9BFNcrvA
	Wz+2J2jYv/HP/v7yrQj2JmwsYJBZJjzZz/2J53NA35z3IOFGGn9CYQTx/ztDhSaEtB0RyrZKdUBAx
	V1zPU3pVvvORSG9NI+tPIJ1x8t9LakXYBymuz1ODbUjHY8qOXPjysQNSGiWGGjTOhcl2mQeRly0N6
	Xuqi/e4V0AeEhqb7X/4lxADWz2+Grb1cq7QjtY+ptI7abBhdYo0ncZNLhzyDGWDkZ/AluaDYOsLVZ
	k4oSmqAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCkR1-006XQ1-0F;
	Mon, 11 Dec 2023 17:51:15 +0000
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCkQx-006XJS-0a
	for kexec@lists.infradead.org;
	Mon, 11 Dec 2023 17:51:12 +0000
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e03f0ede64so16467757b3.0
        for <kexec@lists.infradead.org>; Mon, 11 Dec 2023 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702317068; x=1702921868; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+QItwKYZkmQjKZfvnmL7h1+BIrbGG/qsUdX1MWn8c0=;
        b=PVW1Tz3JMrcwH3seSp2YIQqMRb8495rK4uGiTG+nIX2BBfX1Rr5BeClF2FjI3WjvJa
         Lsda9UM8UBHk+HG28ki/1uHyzcQIp/dR2yniAxUVMqlqL1u4SkqbjvNmNlKzUrApbE8c
         qV22HVWGfedM59ffD/3I0LMhhMtyRvJNrvfqLDU0kYsfFFdv74fpCLpXUKlLb3ZQizbR
         pGwXbFxtHgJiSQoLR4VbuqoN+FmmLOQg4Pqj/2FvIWOOQImFmekEr4QjLwF5z0LanvOl
         Lse7TnGf9ZJtTCkJCd3wJPLPMz3vPF48qQbEx3Pl4J0DdbSjReofLG45ARAQKVS4QX3N
         phYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317068; x=1702921868;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+QItwKYZkmQjKZfvnmL7h1+BIrbGG/qsUdX1MWn8c0=;
        b=OQILWS5u1KmWO54mdxQB8Ygrht+D7t9bO73Fd+79VepjCg9oklmRZlLtfCX/UwV0ZS
         toFyJnMqpstXgEp3mnUewEHCEbK7VYyODcSxtCP4Bbo3HtOc/24Pft3FhjC1pRatgLqm
         MRElnn7an12iRvVzxxUpVjIBgufBp5QleuHwucRCj4LGL5B5sjnzDjCLoq16VDF1jGwb
         91TBkbRzhyzhelMUa+mnmrqpDdKTbCYinmhT8HO0uWt/K8rgEp4bI7LGpkGx4f0Go4Sn
         tmTPuQ8FP5qtafOXYb8UGA2nn7XEN1ui0YGKUpIktLPw4Ux1cb//bI85lfRwEWYDytLJ
         hDTA==
X-Gm-Message-State: AOJu0YzpNM8ZaMgUnraqn9KDBQCbCK0aDgU0oOC5kCHIto6rBr/76i+D
	fu/8nTZRqRfh5f6GPYgubQOt0g6CTeE=
X-Google-Smtp-Source: AGHT+IEJlbs6t42JuBe9Zaw8UIu5remsf7pFjNUwnZXA86IgYB4Hsz7JOVUF1FGFr+oR81Ahwo5DnMt1rK4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3381:b0:5d5:5183:ebdb with SMTP id
 fl1-20020a05690c338100b005d55183ebdbmr48534ywb.10.1702317068533; Mon, 11 Dec
 2023 09:51:08 -0800 (PST)
Date: Mon, 11 Dec 2023 09:51:07 -0800
In-Reply-To: <ZXdIIBUXcCIK28ys@google.com>
Mime-Version: 1.0
References: <20230512233127.804012-1-seanjc@google.com> <20230512233127.804012-2-seanjc@google.com>
 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com> <ZXdIIBUXcCIK28ys@google.com>
Message-ID: <ZXdMC9rCHqAx2SfF@google.com>
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
X-CRM114-CacheID: sfid-20231211_095111_234088_BE288D5A 
X-CRM114-Status: GOOD (  30.23  )
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

T24gTW9uLCBEZWMgMTEsIDIwMjMsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gT24gU2F0
LCBEZWMgMDksIDIwMjMsIEphbWVzIEdvd2FucyB3cm90ZToKPiA+IEhpIFNlYW4sCj4gPiAKPiA+
IEJsYXN0IGZyb20gdGhlIHBhc3QgYnV0IEkndmUganVzdCBiZWVuIGJpdHRlbiBieSB0aGlzIHBh
dGNoIHdoZW4KPiA+IHJlYmFzaW5nIGFjcm9zcyB2Ni40Lgo+ID4gCj4gPiBPbiBGcmksIDIwMjMt
MDUtMTIgYXQgMTY6MzEgLTA3MDAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6Cj4gPiA+IFVz
ZSBzeXNjb3JlX29wcy5zaHV0ZG93biB0byBkaXNhYmxlIGhhcmR3YXJlIHZpcnR1YWxpemF0aW9u
IGR1cmluZyBhCj4gPiA+IHJlYm9vdCBpbnN0ZWFkIG9mIHVzaW5nIHRoZSBkZWRpY2F0ZWQgcmVi
b290X25vdGlmaWVyIHNvIHRoYXQgS1ZNIGRpc2FibGVzCj4gPiA+IHZpcnR1YWxpemF0aW9uIF9h
ZnRlcl8gc3lzdGVtX3N0YXRlIGhhcyBiZWVuIHVwZGF0ZWQuwqAgVGhpcyB3aWxsIGFsbG93Cj4g
PiA+IGZpeGluZyBhIHJhY2UgaW4gS1ZNJ3MgaGFuZGxpbmcgb2YgYSBmb3JjZWQgcmVib290IHdo
ZXJlIEtWTSBjYW4gZW5kIHVwCj4gPiA+IGVuYWJsaW5nIGhhcmR3YXJlIHZpcnR1YWxpemF0aW9u
IGJldHdlZW4ga2VybmVsX3Jlc3RhcnRfcHJlcGFyZSgpIGFuZAo+ID4gPiBtYWNoaW5lX3Jlc3Rh
cnQoKS4KPiA+IAo+ID4gVGhlIGlzc3VlIGlzIHRoYXQsIEFGQUlDVCwgdGhlIHN5c2NvcmVfb3Bz
LnNodXRkb3duIGFyZSBub3QgY2FsbGVkIHdoZW4KPiA+IGRvaW5nIGEga2V4ZWMuIFJlYm9vdCBu
b3RpZmllcnMgYXJlIGNhbGxlZCBhY3Jvc3Mga2V4ZWMgdmlhOgo+ID4gCj4gPiBrZXJuZWxfa2V4
ZWMKPiA+ICAga2VybmVsX3Jlc3RhcnRfcHJlcGFyZQo+ID4gICAgIGJsb2NraW5nX25vdGlmaWVy
X2NhbGxfY2hhaW4KPiA+ICAgICAgIGt2bV9yZWJvb3QKPiA+IAo+ID4gU28gYWZ0ZXIgdGhpcyBw
YXRjaCwgS1ZNIGlzIG5vdCBzaHV0ZG93biBkdXJpbmcga2V4ZWM7IGlmIGhhcmR3YXJlIHZpcnQK
PiA+IG1vZGUgaXMgZW5hYmxlZCB0aGVuIHRoZSBrZXhlYyBoYW5ncyBpbiBleGFjdGx5IHRoZSBz
YW1lIG1hbm5lciBhcyB5b3UKPiA+IGRlc2NyaWJlIHdpdGggdGhlIHJlYm9vdC4KPiA+IAo+ID4g
U29tZSBzcGVjaWZpYyBzaHV0ZG93biBjYWxsYmFja3MsIGZvciBleGFtcGxlIElPTU1VLCBIUEVU
LCBJUlEsIGV0YyBhcmUKPiA+IGNhbGxlZCBpbiBuYXRpdmVfbWFjaGluZV9zaHV0ZG93biwgYnV0
IEtWTSBpcyBub3Qgb25lIG9mIHRoZXNlLgo+ID4gCj4gPiBUaG91Z2h0cyBvbiBwb3NzaWJsZSB3
YXlzIHRvIGZpeCB0aGlzOgo+ID4gYSkgZ28gYmFjayB0byByZWJvb3Qgbm90aWZpZXJzCj4gPiBi
KSBnZXQga2V4ZWMgdG8gY2FsbCBzeXNjb3JlX3NodXRkb3duKCkgdG8gaW52b2tlIGFsbCBvZiB0
aGVzZSBjYWxsYmFja3MKPiA+IGMpIEFkZCBhIEtWTS1zcGVjaWZpYyBjYWxsYmFjayB0byBuYXRp
dmVfbWFjaGluZV9zaHV0ZG93bigpOyB3ZSBvbmx5Cj4gPiBuZWVkIHRoaXMgZm9yIEludGVsIHg4
NiwgcmlnaHQ/Cj4gCj4gSSBkb24ndCBsaWtlIChjKS4gIFZNWCBpcyB0aGUgbW9zdCBzZW5zaXRp
dmUvcHJvYmxlbWF0aWMsIGUuZy4gdGhlIHdob2xlIGJsb2NraW5nCj4gb2YgSU5JVCB0aGluZywg
YnV0IFNWTSBjYW4gYWxzbyBydW4gYWZvdWwgb2YgRUZFUi5TVk1FIGJlaW5nIGNsZWFyZWQsIGFu
ZCBLVk0gcmVhbGx5IAo+IHNob3VsZCBsZWF2ZSB2aXJ0dWFsaXphdGlvbiBlbmFibGVkIGFjcm9z
cyBrZXhlYygpLCBldmVuIGlmIGxlYXZpbmcgdmlydHVhbGl6YXRpb24KCipzaG91bGRuJ3QqCgo+
IGVuYWJsZWQgaXMgcmVsYXRpdmVseSBiZW5pZ24gb24gb3RoZXIgYXJjaGl0ZWN0dXJlcy4KPiAK
PiBPbmUgbW9yZSBvcHRpb24gd291bGQgYmU6Cj4gCj4gIGQpIEFkZCBhbm90aGVyIHN5Y29yZSBo
b29rLCBlLmcuIHN5c2NvcmVfa2V4ZWMoKSBzcGVjaWZpY2FsbHkgZm9yIHRoaXMgcGF0aC4KPiAK
PiA+IE15IHNsaWdodCBwcmVmZXJlbmNlIGlzIHRvd2FyZHMgYWRkaW5nIHN5c2NvcmVfc2h1dGRv
d24oKSB0byBrZXhlYywgYnV0Cj4gPiBJJ20gbm90IHN1cmUgdGhhdCdzIGZlYXNpYmxlLiBBZGRp
bmcga2V4ZWMgbWFpbnRhaW5lcnMgZm9yIGlucHV0Lgo+IAo+IEluIGEgdmFjdXVtLCB0aGF0J2Qg
YmUgbXkgcHJlZmVyZW5jZSB0b28uICBJdCdzIHRoZSBvYnZpb3VzIGNob2ljZSBJTU8sIGUuZy4g
dGhlCj4ga2V4ZWNfaW1hZ2UtPnByZXNlcnZlX2NvbnRleHQgcGF0aCBkb2VzIHN5c2NvcmVfc3Vz
cGVuZCgpIChhbmQgdGhlbiByZXN1bWUoKSwgc28KPiBpdCdzIG5vdCBjb21wbGV0ZWx5IHVuY2hh
cnRlZCB0ZXJyaXRvcnkuCj4gCj4gSG93ZXZlciwgdGhlcmUncyBhIHJhdGhlciBiaWcgd3Jpbmts
ZSBpbiB0aGF0IG5vdCBhbGwgb2YgdGhlIGV4aXN0aW5nIC5zaHV0ZG93bigpCj4gaW1wbGVtZW50
YXRpb25zIGFyZSBvYnZpb3VzbHkgb2sgdG8gY2FsbCBkdXJpbmcga2V4ZWMuICBMdWNraWx5LCBB
RkFJQ1QgdGhlcmUgYXJlCj4gdmVyeSBmZXcgdXNlcnMgb2YgdGhlIHN5c2NvcmUgLnNodXRkb3du
IGhvb2ssIHNvIGl0J3MgYXQgbGVhc3QgZmVhc2libGUgdG8gZ28gdGhhdAo+IHJvdXRlLgo+IAo+
IHg4NidzIG1jZV9zeXNjb3JlX3NodXRkb3duKCkgc2hvdWxkIGJlIG9rLCBhbmQgYXJndWFibHkg
aXMgY29ycmVjdCwgZS5nLiBJIGRvbid0Cj4gc2VlIGhvdyBsZWF2aW5nICNNQyByZXBvcnRpbmcg
ZW5hYmxlZCBhY3Jvc3Mga2V4ZWMgY2FuIHdvcmsuCj4gCj4gbGVkdHJpZ19jcHVfc3lzY29yZV9z
aHV0ZG93bigpIGlzIGFsc28gbGlrZWx5IG9rIGFuZCBhcmd1YWJseSBjb3JyZWN0Lgo+IAo+IFRo
ZSBpbnRlcnJ1cHQgY29udHJvbGxlcnMgdGhvdWdoPyAgeDg2IGRpc2FibGVzIElSUXMgYXQgdGhl
IHZlcnkgYmVnaW5uaW5nIG9mCj4gbWFjaGluZV9rZXhlYygpLCBzbyBpdCdzIGxpa2VseSBmaW5l
LiAgQnV0IGV2ZXJ5IG90aGVyIGFyY2hpdGVjdHVyZT8gIE5vIGNsdWUuCj4gRS5nLiBQUEMncyBk
ZWZhdWx0X21hY2hpbmVfa2V4ZWMoKSBzZW5kcyBJUElzIHRvIHNodXRkb3duIG90aGVyIENQVXMs
IHRob3VnaCBJCj4gaGF2ZSBubyBpZGVhIGlmIHRoYXQgY2FuIHJ1biBhZm91bCBvZiBhbnkgb2Yg
dGhlIHBhdGhzIGJlbG93Lgo+IAo+ICAgICAgICAgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9jZWxs
L3NwdV9iYXNlLmMgIC5zaHV0ZG93biA9IHNwdV9zaHV0ZG93biwKPiAgICAgICAgIGFyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2NvcmUuYwkgICAgICAgIC5zaHV0ZG93biA9IG1jZV9zeXNjb3JlX3No
dXRkb3duLAo+ICAgICAgICAgYXJjaC94ODYva2VybmVsL2k4MjU5LmMgICAgICAgICAgICAgICAg
IC5zaHV0ZG93biA9IGk4MjU5QV9zaHV0ZG93biwKPiAgICAgICAgIGRyaXZlcnMvaXJxY2hpcC9p
cnEtaTgyNTkuYwkgICAgICAgIC5zaHV0ZG93biA9IGk4MjU5QV9zaHV0ZG93biwKPiAgICAgICAg
IGRyaXZlcnMvaXJxY2hpcC9pcnEtc3VuNmktci5jCSAgICAgICAgLnNodXRkb3duID0gc3VuNmlf
cl9pbnRjX3NodXRkb3duLAo+ICAgICAgICAgZHJpdmVycy9sZWRzL3RyaWdnZXIvbGVkdHJpZy1j
cHUuYwkuc2h1dGRvd24gPSBsZWR0cmlnX2NwdV9zeXNjb3JlX3NodXRkb3duLAo+ICAgICAgICAg
ZHJpdmVycy9wb3dlci9yZXNldC9zYzI3eHgtcG93ZXJvZmYuYwkuc2h1dGRvd24gPSBzYzI3eHhf
cG93ZXJvZmZfc2h1dGRvd24sCj4gICAgICAgICBrZXJuZWwvaXJxL2dlbmVyaWMtY2hpcC5jCSAg
ICAgICAgLnNodXRkb3duID0gaXJxX2djX3NodXRkb3duLAo+ICAgICAgICAgdmlydC9rdm0va3Zt
X21haW4uYwkgICAgICAgICAgICAgICAgLnNodXRkb3duID0ga3ZtX3NodXRkb3duLAo+IAo+IFRo
ZSB3aG9sZSB0aGluZyBpcyBhIGJpdCBvZiBhIG1lc3MuICBFLmcuIHg4NiB0cmVhdHMgbWFjaGlu
ZV9zaHV0ZG93bigpIGZyb20KPiBrZXhlYyBwcmV0dHkgbXVjaCB0aGUgc2FtZSBhcyBzaHV0ZG93
biBmb3IgcmVib290LCBidXQgb3RoZXIgYXJjaGl0ZWN0dXJlcyBoYXZlCj4gd2hhdCBhcHBlYXIg
dG8gYmUgdW5pcXVlIHBhdGhzIGZvciBoYW5kbGluZyBrZXhlYy4KPiAKPiBGV0lXLCBpZiB3ZSB3
YW50IHRvIGdvIHdpdGggb3B0aW9uIChiKSwgc3lzY29yZV9zaHV0ZG93bigpIGhvb2tzIGNvdWxk
IHVzZQo+IGtleGVjX2luX3Byb2dyZXNzIHRvIGRpZmZlcmVudGlhdGUgYmV0d2VlbiAicmVndWxh
ciIgc2h1dGRvd24vcmVib290IGFuZCBrZXhlYy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4
ZWMK

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32AEC4167B
	for <kexec@archiver.kernel.org>; Sun, 10 Dec 2023 04:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=IfC0CSrAY4AshQbNRMK9G/86qD9wgl02/2SiOQo/VuQ=; b=JU73sqvkCXDq14amdsrUHu9eDJ
	kzMyVgOPe/64q8SsOFGPHp20CSScS9VuujiDdGbCgMRLMA99BkhsgsZfbjmmK9kZGm5xYAmWoQviR
	JshKuksELlcEybuhQ9AffK5MBRIwCcSJ/OTloJJ2wkaMq8zAYfKZXnMI97uOI57/OwLPSI6VQezRX
	RPa6q+wpESc4m6ws+YI1FmLJd5nMrmhhc4HOVN/Jr+W+S5ekP1jxF16JwvD9ATY6H77+Fr3mO4Yzr
	d9qRfyFYBr7XlfABCtyzj9DvQSL7nVWpVAK4kB5DKIt6ptYuYKGHTtOKxV+X1CBlLMt+zqpBSN8/W
	lP5n3NBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCBpo-000y2D-05;
	Sun, 10 Dec 2023 04:54:32 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCBpl-000y1I-0L;
	Sun, 10 Dec 2023 04:54:30 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:33540)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rCBpP-00B9T9-5N; Sat, 09 Dec 2023 21:54:07 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:35840 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rCBpN-00BEzy-T4; Sat, 09 Dec 2023 21:54:06 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,  "Graf (AWS), Alexander"
 <graf@amazon.de>,  "seanjc@google.com" <seanjc@google.com>,  =?utf-8?Q?Sc?=
 =?utf-8?Q?h=C3=B6nherr=2C_Jan_H=2E?= <jschoenh@amazon.de>,
  "yuzenghui@huawei.com"
 <yuzenghui@huawei.com>,  "atishp@atishpatra.org" <atishp@atishpatra.org>,
  "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
  "james.morse@arm.com" <james.morse@arm.com>,  "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>,  "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>,  "chenhuacai@kernel.org"
 <chenhuacai@kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  "kvmarm@lists.linux.dev"
 <kvmarm@lists.linux.dev>,  "maz@kernel.org" <maz@kernel.org>,
  "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
  "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
  "anup@brainfault.org" <anup@brainfault.org>,  "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>
References: <20230512233127.804012-1-seanjc@google.com>
	<20230512233127.804012-2-seanjc@google.com>
	<cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
Date: Sat, 09 Dec 2023 22:53:30 -0600
In-Reply-To: <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	(James Gowans's message of "Sat, 9 Dec 2023 07:26:36 +0000")
Message-ID: <871qbud5f9.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rCBpN-00BEzy-T4;;;mid=<871qbud5f9.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+JmH+hfPfL+HY3DU2+KTDcxM737ZP9cTs=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier
 to hook restart/shutdown
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231209_205429_169690_EA02B371 
X-CRM114-Status: GOOD (  18.78  )
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

Ikdvd2FucywgSmFtZXMiIDxqZ293YW5zQGFtYXpvbi5jb20+IHdyaXRlczoKCj4gSGkgU2VhbiwK
Pgo+IEJsYXN0IGZyb20gdGhlIHBhc3QgYnV0IEkndmUganVzdCBiZWVuIGJpdHRlbiBieSB0aGlz
IHBhdGNoIHdoZW4KPiByZWJhc2luZyBhY3Jvc3MgdjYuNC4KPgo+IE9uIEZyaSwgMjAyMy0wNS0x
MiBhdCAxNjozMSAtMDcwMCwgU2VhbiBDaHJpc3RvcGhlcnNvbiB3cm90ZToKPj4gVXNlIHN5c2Nv
cmVfb3BzLnNodXRkb3duIHRvIGRpc2FibGUgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24gZHVyaW5n
IGEKPj4gcmVib290IGluc3RlYWQgb2YgdXNpbmcgdGhlIGRlZGljYXRlZCByZWJvb3Rfbm90aWZp
ZXIgc28gdGhhdCBLVk0gZGlzYWJsZXMKPj4gdmlydHVhbGl6YXRpb24gX2FmdGVyXyBzeXN0ZW1f
c3RhdGUgaGFzIGJlZW4gdXBkYXRlZC7CoCBUaGlzIHdpbGwgYWxsb3cKPj4gZml4aW5nIGEgcmFj
ZSBpbiBLVk0ncyBoYW5kbGluZyBvZiBhIGZvcmNlZCByZWJvb3Qgd2hlcmUgS1ZNIGNhbiBlbmQg
dXAKPj4gZW5hYmxpbmcgaGFyZHdhcmUgdmlydHVhbGl6YXRpb24gYmV0d2VlbiBrZXJuZWxfcmVz
dGFydF9wcmVwYXJlKCkgYW5kCj4+IG1hY2hpbmVfcmVzdGFydCgpLgo+Cj4gVGhlIGlzc3VlIGlz
IHRoYXQsIEFGQUlDVCwgdGhlIHN5c2NvcmVfb3BzLnNodXRkb3duIGFyZSBub3QgY2FsbGVkIHdo
ZW4KPiBkb2luZyBhIGtleGVjLiBSZWJvb3Qgbm90aWZpZXJzIGFyZSBjYWxsZWQgYWNyb3NzIGtl
eGVjIHZpYToKPgo+IGtlcm5lbF9rZXhlYwo+ICAga2VybmVsX3Jlc3RhcnRfcHJlcGFyZQo+ICAg
ICBibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluCj4gICAgICAga3ZtX3JlYm9vdAo+Cj4gU28g
YWZ0ZXIgdGhpcyBwYXRjaCwgS1ZNIGlzIG5vdCBzaHV0ZG93biBkdXJpbmcga2V4ZWM7IGlmIGhh
cmR3YXJlIHZpcnQKPiBtb2RlIGlzIGVuYWJsZWQgdGhlbiB0aGUga2V4ZWMgaGFuZ3MgaW4gZXhh
Y3RseSB0aGUgc2FtZSBtYW5uZXIgYXMgeW91Cj4gZGVzY3JpYmUgd2l0aCB0aGUgcmVib290LgoK
a2VybmVsX3Jlc3RhcnRfcHJlcGFyZSBjYWxscyBkZXZpY2Vfc2h1dGRvd24uICBXaGljaCBzaG91
bGQgY2FsbCBhbGwKb2YgdGhlIHNodXRkb3duIG9wZXJhdGlvbnMuICBUaGlzIGhhcyBiZWVuIHRo
ZSB3YXkgdGhlIGNvZGUgaGFzIGJlZW4Kc3RydWN0dXJlZCBzaW5jZSBEZWNlbWJlciAyMDA1LgoK
PiBTb21lIHNwZWNpZmljIHNodXRkb3duIGNhbGxiYWNrcywgZm9yIGV4YW1wbGUgSU9NTVUsIEhQ
RVQsIElSUSwgZXRjIGFyZQo+IGNhbGxlZCBpbiBuYXRpdmVfbWFjaGluZV9zaHV0ZG93biwgYnV0
IEtWTSBpcyBub3Qgb25lIG9mIHRoZXNlLgo+Cj4gVGhvdWdodHMgb24gcG9zc2libGUgd2F5cyB0
byBmaXggdGhpczoKPiBhKSBnbyBiYWNrIHRvIHJlYm9vdCBub3RpZmllcnMKPiBiKSBnZXQga2V4
ZWMgdG8gY2FsbCBzeXNjb3JlX3NodXRkb3duKCkgdG8gaW52b2tlIGFsbCBvZiB0aGVzZSBjYWxs
YmFja3MKPiBjKSBBZGQgYSBLVk0tc3BlY2lmaWMgY2FsbGJhY2sgdG8gbmF0aXZlX21hY2hpbmVf
c2h1dGRvd24oKTsgd2Ugb25seQo+IG5lZWQgdGhpcyBmb3IgSW50ZWwgeDg2LCByaWdodD8KPgo+
IE15IHNsaWdodCBwcmVmZXJlbmNlIGlzIHRvd2FyZHMgYWRkaW5nIHN5c2NvcmVfc2h1dGRvd24o
KSB0byBrZXhlYywgYnV0Cj4gSSdtIG5vdCBzdXJlIHRoYXQncyBmZWFzaWJsZS4gQWRkaW5nIGtl
eGVjIG1haW50YWluZXJzIGZvciBpbnB1dC4KCldoeSBpc24ndCBkZXZpY2Vfc3V0aGRvd24gY2Fs
bGluZyBzeXNjb3JlX3NodXRkb3duPwoKV2hhdCBwcm9ibGVtIGFyZSB5b3UgcnVubmluZyBpbnRv
IHdpdGggeW91ciByZWJhc2UgdGhhdCB3b3JrZWQgd2l0aApyZWJvb3Qgbm90aWZpZXJzIHRoYXQg
aXMgbm90IHdvcmtpbmcgd2l0aCBzeXNjb3JlX3NodXRkb3duPwoKRXJpYwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5217AC001B0
	for <kexec@archiver.kernel.org>; Tue, 25 Jul 2023 01:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YqRFJVMJ2P9iFgTrNeAfn0cMzNKBNxDEDE7vldkDpFw=; b=ieMAGxUMxLLxsB
	GEVs762TUjPYt4vNF2BdnHFlCEJkU6oO3VB8uLCv3cxafMrLtNWaqkE5tjtM/QhI03NpRweM79T3t
	og7/B9hXDq5PvRKl2z/KwxVlDRthKAAMdIhSkwdEP22yMmGFymq6hd6c4GAFhA/zweB8tbCAmpLbA
	xSpMIxhNm3oAAP/84gyi5Hu9nbQf+MADr8w+Z20tBIH1XL4w3iYhMPLoD9G/btMWoh10+XXXLCH2x
	gqeF7RFLtKs4ql3qH8Z/uW9ys9GZSVohQLv2Xbv28usT7lYH0Q9NjGSAo85U647NcZm6lrzNjj8v2
	XJ+Dhdj/HJ5imA5jImWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO7EJ-005rIy-2r;
	Tue, 25 Jul 2023 01:52:51 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO7EF-005rHS-1S;
	Tue, 25 Jul 2023 01:52:50 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VoAl.6s_1690249956;
Received: from 30.221.109.71(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VoAl.6s_1690249956)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 09:52:37 +0800
Message-ID: <f452ad3e-c0cd-8d02-48af-f20497875b68@linux.alibaba.com>
Date: Tue, 25 Jul 2023 09:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
To: Song Shuai <suagrfillet@gmail.com>, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
 robh@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 conor.dooley@microchip.com
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230724100917.309061-1-suagrfillet@gmail.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_185247_672994_E75013B6 
X-CRM114-Status: GOOD (  11.18  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

CuWcqCAyMDIzLzcvMjQg5LiL5Y2INjowOSwgU29uZyBTaHVhaSDlhpnpgZM6Cj4gU2luY2UgUklT
Qy1WIExpbnV4IHY2LjQsIHRoZSBjb21taXQgMzMzNTA2OGY4NzIxICgicmlzY3Y6IFVzZQo+IFBV
RC9QNEQvUEdEIHBhZ2VzIGZvciB0aGUgbGluZWFyIG1hcHBpbmciKSBjaGFuZ2VzIHBoeXNfcmFt
X2Jhc2UKPiBmcm9tIHRoZSBwaHlzaWNhbCBzdGFydCBvZiB0aGUga2VybmVsIHRvIHRoZSBhY3R1
YWwgc3RhcnQgb2YgdGhlIERSQU0uCj4KPiBUaGUgQ3Jhc2gtdXRpbGl0eSdzIFZUT1AoKSBzdGls
bCB1c2VzIHBoeXNfcmFtX2Jhc2UgYW5kIGtlcm5lbF9tYXAudmlydF9hZGRyCj4gdG8gdHJhbnNs
YXRlIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3MsIHRoYXQgZmFpbGVkIHRoZSBDcmFzaCB3aXRoIExp
bnV4IHY2LjQgWzFdLgo+Cj4gRXhwb3J0IGtlcm5lbF9tYXAudmFfa2VybmVsX3BhX29mZnNldCBp
biB2bWNvcmVpbmZvIHRvIGhlbHAgQ3Jhc2ggdHJhbnNsYXRlCj4gdGhlIGtlcm5lbCB2aXJ0dWFs
IGFkZHJlc3MgY29ycmVjdGx5Lgo+Cj4gRml4ZXM6IDMzMzUwNjhmODcyMSAoInJpc2N2OiBVc2Ug
UFVEL1A0RC9QR0QgcGFnZXMgZm9yIHRoZSBsaW5lYXIgbWFwcGluZyIpCj4gTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcmlzY3YvMjAyMzA3MjQwNDA2NDkuMjIwMjc5LTEtc3Vh
Z3JmaWxsZXRAZ21haWwuY29tLyBbMV0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIFNodWFpIDxzdWFn
cmZpbGxldEBnbWFpbC5jb20+Cj4gLS0tCj4gICBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3Jl
LmMgfCAyICsrCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIGIvYXJjaC9yaXNjdi9rZXJuZWwv
Y3Jhc2hfY29yZS5jCj4gaW5kZXggYjM1MWEzYzAxMzU1Li41NWYxZDc4NTZiNTQgMTAwNjQ0Cj4g
LS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jCj4gKysrIGIvYXJjaC9yaXNjdi9r
ZXJuZWwvY3Jhc2hfY29yZS5jCj4gQEAgLTE4LDQgKzE4LDYgQEAgdm9pZCBhcmNoX2NyYXNoX3Nh
dmVfdm1jb3JlaW5mbyh2b2lkKQo+ICAgCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKE1P
RFVMRVNfRU5EKT0weCVseFxuIiwgTU9EVUxFU19FTkQpOwo+ICAgI2VuZGlmCj4gICAJdm1jb3Jl
aW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsIEtFUk5F
TF9MSU5LX0FERFIpOwo+ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIodmFfa2VybmVs
X3BhX29mZnNldCk9MHglbHhcbiIsCj4gKwkJCQkJCWtlcm5lbF9tYXAudmFfa2VybmVsX3BhX29m
ZnNldCk7Cj4gICB9ClJldmlld2VkLWJ5OiBYaWFudGluZyBUaWFuwqAgPHhpYW50aW5nLnRpYW5A
bGludXguYWxpYmFiYS5jb20+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2CFC001DF
	for <kexec@archiver.kernel.org>; Wed,  2 Aug 2023 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8wZ+8zfJ7pedofLr6a3jJocrAFp6lZD7Pox5GBLp3WY=; b=fYBb1oAUy0qgbO
	HUu4fSKia8XM6eqCgTuu/M7Dqcgl47oXsqrMaVApu4/kqX1Xcv9JL1E7em1frkk1eDg0LUQP0x57f
	zvRbABNJf0YdL3MGX4Id6yZyl2jDXgM5vmmFyOEc0rUxGq1hzr9yHw88Bixvn4TqiW0vYXEtrBf+8
	Fh5eUsBRQD87LuFDcfHzmZwfNZeCYKqgBMHlT1eGkGCJnQNjICA1bmjvg6m9IRYoV9zsd5xeXA2yg
	aJoJyYNGoJ/jzWHzPUklAlMJ6BFq4y+EGGP9nVkyhl69eMQWcOPjGzFW/+XIRn8E/A7FD9ZKQSS8j
	raknvz4fzJwyKZmtwVwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR78w-004Mgm-0V;
	Wed, 02 Aug 2023 08:23:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR78r-004Mg4-35
	for kexec@lists.infradead.org;
	Wed, 02 Aug 2023 08:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690964614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6xA1F/tQvnceD1AFJdAnCO4v6zT18KFQE0US8wehYA=;
	b=OqkPaNTUQG9J8JRZNgOOzP0OCUsPPFYyi6/yIfJXV6+ozvFj6uvneSo+CGDb/wGNnhMhd3
	I9bWb/WkrXvRs6RQjeZ3KAzyceKWlSFPQ5sDf1h7soxaHz/HS3i/3OoRMDD70bCs5BVqC4
	poPjbA+zWtY2S5MG9/vinfxVe+3cDfU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-Q5YGIEweOgezrVmqM8leAw-1; Wed, 02 Aug 2023 04:23:32 -0400
X-MC-Unique: Q5YGIEweOgezrVmqM8leAw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4fb76659d37so6096829e87.2
        for <kexec@lists.infradead.org>; Wed, 02 Aug 2023 01:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690964611; x=1691569411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6xA1F/tQvnceD1AFJdAnCO4v6zT18KFQE0US8wehYA=;
        b=TP3TOPN/5lDgtjkR3LnNihU5eXVX2+Ks3i2EGVGkMSXItTlF0Hn5mfFDE2u330FukF
         JPq2CFGDunV2KbaIkuI3bhrtdPaAp3vPa5mLKPRyDxz2QA2AJXiC6vL2CU18yhVvY1cT
         HAZIhRkOlqRnvN7wTVuZlhwbElbA0Ov/HITlqsL+RRQKMHxQAegWk13JADTPO9afKez5
         4TRlVXANRYVsmwxHnsEArMc4Ec8QsjU9Hu/pfGJPFcGCR1FBbProkm4FhHcFHovklo+d
         iBSiQROpx3K5C6kgZLeNb+68t4vDHS4v/zLO5WXzxNCrzv0ceY96f1725uUccIW948pz
         dJzQ==
X-Gm-Message-State: ABy/qLYa6KtGo2NioAEu+8efDRl9fxZDOrSp9SN5Gt2AyRUVLOjsLBgf
	Ho83kPVi4WAkSlMyLgDwjihzTiOPGoM91UhmfKYenJSMlbJkAaDfVof75Jwru59wIvoLH+sa+Bx
	1WaPbiKmpc3B4wJChBzCF+oU7HnCEzVLKmRt+
X-Received: by 2002:a05:6512:3c9d:b0:4fd:d016:c2e8 with SMTP id h29-20020a0565123c9d00b004fdd016c2e8mr5267056lfv.43.1690964611479;
        Wed, 02 Aug 2023 01:23:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEJNKHF2p2CytRgIKLCKCUGGjT7LyJXykVvMQOxHkWM+4I6/V0yxuRpiIuVaotJpuNHCW0V42NQ2DovrfXG528=
X-Received: by 2002:a05:6512:3c9d:b0:4fd:d016:c2e8 with SMTP id
 h29-20020a0565123c9d00b004fdd016c2e8mr5267031lfv.43.1690964611133; Wed, 02
 Aug 2023 01:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <20230717141409.GGZLVMsU6d/9mpJvMO@fat_crate.local> <CAO7dBbXJv9JzDbSa-DLT03+osYCQXNUXFwz63gbq=NGDxEVyEA@mail.gmail.com>
 <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
In-Reply-To: <20230728165535.GDZMPzB/ek5QM+xJqA@fat_crate.local>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 2 Aug 2023 16:22:54 +0800
Message-ID: <CAO7dBbVyuLHH6RfdVQkU5ThXaJ-F4yvFAYD1PDNGkOpph9xvnA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, ardb@kernel.org, linux-kernel@vger.kernel.org, 
	bhe@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230802_012338_081935_316EACBC 
X-CRM114-Status: GOOD (  29.01  )
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

SGkgQm9yaXNsYXYsCgpPbiBTYXQsIEp1bCAyOSwgMjAyMyBhdCAxMjo1NuKAr0FNIEJvcmlzbGF2
IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToKPgo+IE9uIFRodSwgSnVsIDI3LCAyMDIzIGF0
IDA3OjAzOjI2UE0gKzA4MDAsIFRhbyBMaXUgd3JvdGU6Cj4gPiBIaSBCb3Jpc2xhdiwKPiA+Cj4g
PiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UuIEkgc3BlbnQgc29tZSB0aW1lIHJldGVzdGlu
ZyB5b3VyIHBhdGNoCj4gPiBhZ2FpbnN0IDYuNS4wLXJjMSBhbmQgNi41LjAtcmMzLCBhbmQgaXQg
aXMgT0suIFNvCj4gPgo+ID4gUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogVGFvIExpdSA8bHRhb0By
ZWRoYXQuY29tPgo+ID4KPiA+IEFuZCB3aWxsIHdlIHVzZSB0aGlzIHBhdGNoIGFzIGEgd29ya2Fy
b3VuZCBvciB3aWxsIHdlIHdhaXQgZm9yIGEKPiA+IGJldHRlciBzb2x1dGlvbiBhcyBwcm9wb3Nl
ZCBieSBNaWNoYWVsPwo+Cj4gRmlyc3Qgb2YgYWxsLCBwbGVhc2UgZG8gbm90IHRvcC1wb3N0Lgo+
CgpPSywgdGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuCgo+IEFuZCB5ZXMsIGhlcmUncyBhIGJldHRl
ciBvbmUuIEknZCBhcHByZWNpYXRlIGl0IHlvdSB0ZXN0aW5nIGl0Lgo+CgpUaGFua3MgZm9yIHRo
ZSBwYXRjaCEgSSBoYXZlIHRlc3RlZCBpdCBvbiB0aGUgbGVub3ZvIG1hY2hpbmUgaW4gdGhlCnBh
c3QgZmV3IGRheXMsIG5vIGlzc3VlIGZvdW5kLCBzbyB0aGUgcGF0Y2ggdGVzdHMgT0suCgpUaGFu
a3MsClRhbyBMaXUKCj4gVGh4Lgo+Cj4gLS0tCj4gIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9p
ZHRfNjQuYyB8ICA1ICsrKystCj4gIGFyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9zZXYuYyAgICB8
IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAz
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2Jvb3QvY29tcHJlc3NlZC9pZHRfNjQuYyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZHRf
NjQuYwo+IGluZGV4IDZkZWJiODE2ZTgzZC4uMGYwM2FjMTJlMmE2IDEwMDY0NAo+IC0tLSBhL2Fy
Y2gveDg2L2Jvb3QvY29tcHJlc3NlZC9pZHRfNjQuYwo+ICsrKyBiL2FyY2gveDg2L2Jvb3QvY29t
cHJlc3NlZC9pZHRfNjQuYwo+IEBAIC02Myw3ICs2MywxMCBAQCB2b2lkIGxvYWRfc3RhZ2UyX2lk
dCh2b2lkKQo+ICAgICAgICAgc2V0X2lkdF9lbnRyeShYODZfVFJBUF9QRiwgYm9vdF9wYWdlX2Zh
dWx0KTsKPgo+ICAjaWZkZWYgQ09ORklHX0FNRF9NRU1fRU5DUllQVAo+IC0gICAgICAgc2V0X2lk
dF9lbnRyeShYODZfVFJBUF9WQywgYm9vdF9zdGFnZTJfdmMpOwo+ICsgICAgICAgaWYgKHNldl9z
dGF0dXMgJiBCSVQoMSkpCj4gKyAgICAgICAgICAgICAgIHNldF9pZHRfZW50cnkoWDg2X1RSQVBf
VkMsIGJvb3Rfc3RhZ2UyX3ZjKTsKPiArICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgc2V0
X2lkdF9lbnRyeShYODZfVFJBUF9WQywgTlVMTCk7Cj4gICNlbmRpZgo+Cj4gICAgICAgICBsb2Fk
X2Jvb3RfaWR0KCZib290X2lkdF9kZXNjKTsKPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvYm9vdC9j
b21wcmVzc2VkL3Nldi5jIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3Nldi5jCj4gaW5kZXgg
MDlkYzhjMTg3YjNjLi5jM2UzNDNiZDQ3NjAgMTAwNjQ0Cj4gLS0tIGEvYXJjaC94ODYvYm9vdC9j
b21wcmVzc2VkL3Nldi5jCj4gKysrIGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3Nldi5jCj4g
QEAgLTQwNCwxMyArNDA0LDQ2IEBAIHZvaWQgc2V2X2VuYWJsZShzdHJ1Y3QgYm9vdF9wYXJhbXMg
KmJwKQo+ICAgICAgICAgaWYgKGJwKQo+ICAgICAgICAgICAgICAgICBicC0+Y2NfYmxvYl9hZGRy
ZXNzID0gMDsKPgo+ICsgICAgICAgLyoKPiArICAgICAgICAqIERvIGFuIGluaXRpYWwgU0VWIGNh
cGFiaWxpdHkgY2hlY2sgYmVmb3JlIHNucF9pbml0KCkgd2hpY2gKPiArICAgICAgICAqIGxvYWRz
IHRoZSBDUFVJRCBwYWdlIGFuZCB0aGUgc2FtZSBjaGVja3MgYWZ0ZXJ3YXJkcyBhcmUgZG9uZQo+
ICsgICAgICAgICogd2l0aG91dCB0aGUgaHlwZXJ2aXNvciBhbmQgYXJlIHRydXN0d29ydGh5Lgo+
ICsgICAgICAgICoKPiArICAgICAgICAqIElmIHRoZSBIViBmYWtlcyBTRVYgc3VwcG9ydCwgdGhl
IGd1ZXN0IHdpbGwgY3Jhc2gnbididXJuCj4gKyAgICAgICAgKiB3aGljaCBpcyBnb29kIGVub3Vn
aC4KPiArICAgICAgICAqLwo+ICsKPiArICAgICAgIC8qIENoZWNrIGZvciB0aGUgU01FL1NFViBz
dXBwb3J0IGxlYWYgKi8KPiArICAgICAgIGVheCA9IDB4ODAwMDAwMDA7Cj4gKyAgICAgICBlY3gg
PSAwOwo+ICsgICAgICAgbmF0aXZlX2NwdWlkKCZlYXgsICZlYngsICZlY3gsICZlZHgpOwo+ICsg
ICAgICAgaWYgKGVheCA8IDB4ODAwMDAwMWYpCj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiAr
Cj4gKyAgICAgICAvKgo+ICsgICAgICAgICogQ2hlY2sgZm9yIHRoZSBTTUUvU0VWIGZlYXR1cmU6
Cj4gKyAgICAgICAgKiAgIENQVUlEIEZuODAwMF8wMDFGW0VBWF0KPiArICAgICAgICAqICAgLSBC
aXQgMCAtIFNlY3VyZSBNZW1vcnkgRW5jcnlwdGlvbiBzdXBwb3J0Cj4gKyAgICAgICAgKiAgIC0g
Qml0IDEgLSBTZWN1cmUgRW5jcnlwdGVkIFZpcnR1YWxpemF0aW9uIHN1cHBvcnQKPiArICAgICAg
ICAqICAgQ1BVSUQgRm44MDAwXzAwMUZbRUJYXQo+ICsgICAgICAgICogICAtIEJpdHMgNTowIC0g
UGFnZXRhYmxlIGJpdCBwb3NpdGlvbiB1c2VkIHRvIGluZGljYXRlIGVuY3J5cHRpb24KPiArICAg
ICAgICAqLwo+ICsgICAgICAgZWF4ID0gMHg4MDAwMDAxZjsKPiArICAgICAgIGVjeCA9IDA7Cj4g
KyAgICAgICBuYXRpdmVfY3B1aWQoJmVheCwgJmVieCwgJmVjeCwgJmVkeCk7Cj4gKyAgICAgICAv
KiBDaGVjayB3aGV0aGVyIFNFViBpcyBzdXBwb3J0ZWQgKi8KPiArICAgICAgIGlmICghKGVheCAm
IEJJVCgxKSkpCj4gKyAgICAgICAgICAgICAgIHJldHVybjsKPiArCj4gICAgICAgICAvKgo+ICAg
ICAgICAgICogU2V0dXAvcHJlbGltaW5hcnkgZGV0ZWN0aW9uIG9mIFNOUC4gVGhpcyB3aWxsIGJl
IHNhbml0eS1jaGVja2VkCj4gICAgICAgICAgKiBhZ2FpbnN0IENQVUlEL01TUiB2YWx1ZXMgbGF0
ZXIuCj4gICAgICAgICAgKi8KPiAgICAgICAgIHNucCA9IHNucF9pbml0KGJwKTsKPgo+IC0gICAg
ICAgLyogQ2hlY2sgZm9yIHRoZSBTTUUvU0VWIHN1cHBvcnQgbGVhZiAqLwo+ICsgICAgICAgLyog
Tm93IHJlcGVhdCB0aGUgY2hlY2tzIHdpdGggdGhlIFNOUCBDUFVJRCB0YWJsZS4gKi8KPiArCj4g
KyAgICAgICAvKiBSZWNoZWNrIHRoZSBTTUUvU0VWIHN1cHBvcnQgbGVhZiAqLwo+ICAgICAgICAg
ZWF4ID0gMHg4MDAwMDAwMDsKPiAgICAgICAgIGVjeCA9IDA7Cj4gICAgICAgICBuYXRpdmVfY3B1
aWQoJmVheCwgJmVieCwgJmVjeCwgJmVkeCk7Cj4gQEAgLTQxOCw3ICs0NTEsNyBAQCB2b2lkIHNl
dl9lbmFibGUoc3RydWN0IGJvb3RfcGFyYW1zICpicCkKPiAgICAgICAgICAgICAgICAgcmV0dXJu
Owo+Cj4gICAgICAgICAvKgo+IC0gICAgICAgICogQ2hlY2sgZm9yIHRoZSBTTUUvU0VWIGZlYXR1
cmU6Cj4gKyAgICAgICAgKiBSZWNoZWNrIGZvciB0aGUgU01FL1NFViBmZWF0dXJlOgo+ICAgICAg
ICAgICogICBDUFVJRCBGbjgwMDBfMDAxRltFQVhdCj4gICAgICAgICAgKiAgIC0gQml0IDAgLSBT
ZWN1cmUgTWVtb3J5IEVuY3J5cHRpb24gc3VwcG9ydAo+ICAgICAgICAgICogICAtIEJpdCAxIC0g
U2VjdXJlIEVuY3J5cHRlZCBWaXJ0dWFsaXphdGlvbiBzdXBwb3J0Cj4gLS0KPiAyLjQxLjAKPgo+
IC0tCj4gUmVnYXJkcy9HcnVzcywKPiAgICAgQm9yaXMuCj4KPiBodHRwczovL3Blb3BsZS5rZXJu
ZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1ZXR0ZQo+CgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350D1CA1002
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wjGzphpQSmdgD73ekPijlgtAxRIRaR7CsFHs0fRNlso=; b=XgnyFti3mo/NZu8s3dJRDJvbL9
	tiem0xDCE9a/mAR3W0En91yAUdPZtkYZk+HMg20JZAJPKYLgxahBOQSROaYo3t6rqQ1YM3XoZ/2RH
	Er3ywZBId97eYzh2xNfDfER2ZBsBnOLqG2NxUabZ8yaTtZxW6Y/qEQs5hXquEcaJPnOP7QyOVN+/y
	Fm8NotuTX8kCedWihek4Hx6JAIVCGAgSfml6QDt5PO2MX2ZcO6uhRfqR+BoxiRtuV5vFbY6yo1/P1
	yqsqfTcKORp9ejemYw/LuHF0HEdlMPumxjRkvXKm8sIddscTyycwwvo08NcQQxyb7IvaCI9El5fyt
	3VQukCdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu7Vp-0000000B090-3tF8;
	Thu, 04 Sep 2025 10:48:17 +0000
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com ([35.162.73.231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu6O7-0000000AbdC-0csO
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 09:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1756978575; x=1788514575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wjGzphpQSmdgD73ekPijlgtAxRIRaR7CsFHs0fRNlso=;
  b=BCxeXRFppPcwpx3FzP/qlctHt+m/LjAZflTn/tM6xusE7AiQw5QZIKVn
   v5YO4OTTJ28xjL7lwcb2WcSyBJyhQeegTYezs5EvRR25Ym6maM85RzABR
   I6ORHLLZSUnwrpOCiwQ5ni7Fw3uNi1oN4zJC8Pg/Jih2tl7o/mRo5WsSS
   Zmq9L/NBPpS7n9DdlFpB//ot3ml+Yu1rRIGPGhcvhYxdyeh03Z3oKgjh/
   ojNupkR7+JIozlJR/koaDeOxJOU8y8AC0jvYk9PJdXGnqBF3ceQOswgCF
   eFZDZuLFW1tkfI8K4P9+f2KCnc/L/TjKUCMvJ2khETRpjm4xdXbKKQm10
   g==;
X-CSE-ConnectionGUID: bjc+8o0ZQjSAH2UyMvYysw==
X-CSE-MsgGUID: 4EwNZJGCR2GA8AZ5/CtUCA==
X-IronPort-AV: E=Sophos;i="6.18,238,1751241600"; 
   d="scan'208";a="2272356"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 09:36:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:47410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id 67cfe508-291c-474a-991f-c5f04ba32975; Thu, 4 Sep 2025 09:36:10 +0000 (UTC)
X-Farcaster-Flow-ID: 67cfe508-291c-474a-991f-c5f04ba32975
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 4 Sep 2025 09:36:10 +0000
Received: from dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com
 (10.253.109.105) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Thu, 4 Sep 2025
 09:36:08 +0000
From: Evangelos Petrongonas <epetron@amazon.de>
To: <ardb@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <bhe@redhat.com>, <changyuanl@google.com>, <graf@amazon.com>,
	<kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<nh-open-source@amazon.com>, <rppt@kernel.org>
Subject: Re: Re: [PATCH v3 2/2] efi: Support booting with kexec handover (KHO)
Date: Thu, 4 Sep 2025 09:34:09 +0000
Message-ID: <20250904093455.73184-1-epetron@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
References: <cover.1755721529.git.epetron@amazon.de> <b34da9fd50c89644cd4204136cfa6f5533445c56.1755721529.git.epetron@amazon.de> <CAMj1kXFQwOHyQg2LtabMA3qxiBn_AVV_JNfki2WPSg8u_XbBcg@mail.gmail.com> <CAMj1kXFzKzpoqczq7Rk-u+kKLFO057XEXMD+KM=iRMMsoUZbJA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.253.109.105]
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_023615_248973_36E66238 
X-CRM114-Status: GOOD (  22.75  )
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

T24gVGh1LCA0IFNlcCAyMDI1IDA5OjE5OjIxICswMjAwLCBBcmQgQmllc2hldXZlbCA8YXJkYkBr
ZXJuZWwub3JnPiB3cm90ZToKPiBPbiBTYXQsIDIzIEF1ZyAyMDI1IGF0IDIzOjQ3LCBBcmQgQmll
c2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPiB3cm90ZToKPiA+Cj4gPiAoY2MgSWxpYXMpCj4gPgo+
ID4gTm90ZSB0byBha3BtOiBwbGVhc2UgZHJvcCB0aGlzIHNlcmllcyBmb3Igbm93Lgo+ID4KPiA+
IE9uIEZyaSwgMjIgQXVnIDIwMjUgYXQgMDQ6MDAsIEV2YW5nZWxvcyBQZXRyb25nb25hcyA8ZXBl
dHJvbkBhbWF6b24uZGU+IHdyb3RlOgo+ID4gPgo+ID4gPiBXaGVuIEtITyAoS2V4ZWMgSGFuZE92
ZXIpIGlzIGVuYWJsZWQsIGl0IHNldHMgdXAgc2NyYXRjaCBtZW1vcnkgcmVnaW9ucwo+ID4gPiBl
YXJseSBkdXJpbmcgZGV2aWNlIHRyZWUgc2Nhbm5pbmcuIEFmdGVyIGtleGVjLCB0aGUgbmV3IGtl
cm5lbAo+ID4gPiBleGNsdXNpdmVseSB1c2VzIHRoaXMgcmVnaW9uIGZvciBtZW1vcnkgYWxsb2Nh
dGlvbnMgZHVyaW5nIGJvb3QgdXAgdG8KPiA+ID4gdGhlIGluaXRpYWxpemF0aW9uIG9mIHRoZSBw
YWdlIGFsbG9jYXRvcgo+ID4gPgo+ID4gPiBIb3dldmVyLCB3aGVuIGJvb3Rpbmcgd2l0aCBFRkks
IEVGSSdzIHJlc2VydmVfcmVnaW9ucygpIHVzZXMKPiA+ID4gbWVtYmxvY2tfcmVtb3ZlKDAsIFBI
WVNfQUREUl9NQVgpIHRvIGNsZWFyIGFsbCBtZW1vcnkgcmVnaW9ucyBiZWZvcmUKPiA+ID4gcmVi
dWlsZGluZyB0aGVtIGZyb20gRUZJIGRhdGEuIFRoaXMgZGVzdHJveXMgS0hPIHNjcmF0Y2ggcmVn
aW9ucyBhbmQKPiA+ID4gdGhlaXIgZmxhZ3MsIHRodXMgY2F1c2luZyBhIGtlcm5lbCBwYW5pYywg
YXMgdGhlcmUgYXJlIG5vIHNjcmF0Y2gKPiA+ID4gbWVtb3J5IHJlZ2lvbnMuCj4gPiA+Cj4gPiA+
IEluc3RlYWQgb2Ygd2hvbGVzYWxlIHJlbW92YWwsIGl0ZXJhdGUgdGhyb3VnaCBtZW1vcnkgcmVn
aW9ucyBhbmQgb25seQo+ID4gPiByZW1vdmUgbm9uLUtITyBvbmVzLiBUaGlzIHByZXNlcnZlcyBL
SE8gc2NyYXRjaCByZWdpb25zLCB3aGljaCBhcmUKPiA+ID4gZ29vZCBrbm93biBtZW1vcnksIHdo
aWxlIHN0aWxsIGFsbG93aW5nIEVGSSB0byByZWJ1aWxkIGl0cyBtZW1vcnkgbWFwLgo+ID4gPgo+
ID4gPiBBY2tlZC1ieTogTWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KSA8cnBwdEBrZXJuZWwub3Jn
Pgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBFdmFuZ2Vsb3MgUGV0cm9uZ29uYXMgPGVwZXRyb25AYW1h
em9uLmRlPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlcyBpbiB2MzoKPiA+ID4gICAgICAgICAtIElt
cHJvdmUgdGhlIGNvZGUgY29tbWVudHMsIGJ5IHN0YXRpbmcgdGhhdCB0aGUgc2NyYXRjaCByZWdp
b25zIGFyZQo+ID4gPiAgICAgICAgIGdvb2Qga25vd24gbWVtb3J5Cj4gPiA+Cj4gPiA+IENoYW5n
ZXMgaW4gdjI6Cj4gPiA+ICAgICAgICAgLSBSZXBsYWNlIHRoZSBmb3IgbG9vcCB3aXRoIGZvcl9l
YWNoX21lbV9yZWdpb24KPiA+ID4gICAgICAgICAtIEZpeCBjb21tZW50IGluZGVudGF0aW9uCj4g
PiA+ICAgICAgICAgLSBBbWVuZCBjb21taXQgbWVzc2FnZSB0byBzcGVjaWZ5IHRoYXQgc2NyYXRj
aCByZWdpb25zCj4gPiA+ICAgICAgICAgYXJlIGtub3duIGdvb2QgcmVnaW9ucwo+ID4gPgo+ID4g
PiAgZHJpdmVycy9maXJtd2FyZS9lZmkvZWZpLWluaXQuYyB8IDI5ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPiA+ID4KPiA+Cj4gPiBJJ2QgcmF0aGVyIGRyb3AgdGhlIG1lbWJsb2NrX3Jl
bW92ZSgpIGVudGlyZWx5IGlmIHBvc3NpYmxlLiBDb3VsZCB3ZQo+ID4gZ2V0IHNvbWUgaW5zaWdo
dCBpbnRvIHdoZXRoZXIgbWVtYmxvY2tzIGFyZSBnZW5lcmFsbHkgYWxyZWFkeQo+ID4gcG9wdWxh
dGVkIGF0IHRoaXMgcG9pbnQgZHVyaW5nIHRoZSBib290Pwo+ID4KPiA+Cj4gCj4gUGluZz8KCkhl
eSBBcmQgSSB3YXMgQUZLIHRyYXZlbGxpbmcuIEkgYW0gYmFjayBub3cgYW5kIHdpbGwgZ2V0IHRv
IGl0LgpQUzogS2VlbiB0byBtZWV0IHlvdSBsYXRlciB0b2RheSBpbiB0aGUgS1ZNIEZvcnVtLgoK
S2luZCBSZWdhcmRzLApFdmFuZ2Vsb3MKCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1l
bnQgQ2VudGVyIEdlcm1hbnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=



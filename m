Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1286F9D0CC
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2mscJTrff+wQfdwB3mlX8JtQE8/2Ht+mJQARI/Gk4Z8=; b=I4Gz4U0tGjrqJMqKg2W2unEic6
	vMAuMaYhrqpTo1cbJyujXhVpldrp5JC+sX42MifMtmSbuYVb6xp+sHlYhxHCBF3SBUGTDGkd7EWzL
	Hyr2Vu78PwRBBQ9RxYqk6RGzt5Ng/uKv3kuUScQep66TJs3kjUj1+YWaHD678D5GHK7Q6Swx+3NEy
	w5A3YEZ8x9uJuWlZEj4GtdYUWRN0IELBg6e2qu8g9HmcpMRkIqc41xrmtGubjHU+ehJ03k1T4L8XX
	4O9IaWn5Wq57Hee/v/zBb+r1fhG1Z5sH8kqYShsPQVXjVEW8/hOMKwDZQrBw0/sMY41IP6F8ZZhcX
	r+jGVGGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCd24-0000000HIwy-1b53;
	Tue, 14 Apr 2026 12:38:20 +0000
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com ([52.13.214.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCd22-0000000HIwP-1YKM
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 12:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776170298; x=1807706298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2mscJTrff+wQfdwB3mlX8JtQE8/2Ht+mJQARI/Gk4Z8=;
  b=RCxRijoEABwcTrKvErhdVdb9yccDwwwrWNSksqrNCfV4ErEDlFP+0q5a
   TZtrcOmOwoucQfvih+ttAk0B2vGtg1MOZ1KqunP/Ue8s0MEjWrOxfQ6Mc
   XAePtMVoYkg9ciTJh5B1evRHrIlMqM6/miNZeYTPydRSq68Bnr5SyH+Ny
   dhb78yAAdPGrX5NgAt8daH0DNEKVlxdLGncFzV3IMxAo7+qVCV5h3eUCB
   w+yznNlvSQzy1s4o+ie9JI+zEEoX7FlzZ18jl7EpQs9M/SrSvFbjbSV9A
   +KOVcv97tpea2xSsEOOdIw8LWIzUol5JTzNV2PCHjvC/hdgcw5GgxtqDA
   w==;
X-CSE-ConnectionGUID: cfEeLPAyTd2vlaZgOWPhtA==
X-CSE-MsgGUID: NSmikFhRQwSOZPY/Sesf+g==
X-IronPort-AV: E=Sophos;i="6.23,179,1770595200"; 
   d="scan'208";a="17248928"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 12:38:11 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:1933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.173:2525] with esmtp (Farcaster)
 id b6cb576a-944f-4948-b49f-225317c145e3; Tue, 14 Apr 2026 12:38:10 +0000 (UTC)
X-Farcaster-Flow-ID: b6cb576a-944f-4948-b49f-225317c145e3
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 14 Apr 2026 12:38:10 +0000
Received: from [0.0.0.0] (172.19.99.218) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Tue, 14 Apr 2026
 12:38:08 +0000
Message-ID: <45617e3d-59c5-4c2a-9c2d-b7bfad805d78@amazon.com>
Date: Tue, 14 Apr 2026 14:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: update KHO and LIVE UPDATE maintainers
To: Pratyush Yadav <pratyush@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, "David
 Hildenbrand (Arm)" <david@kernel.org>
CC: <kexec@lists.infradead.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20260414121752.1912847-1-pratyush@kernel.org>
 <20260414121752.1912847-2-pratyush@kernel.org>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20260414121752.1912847-2-pratyush@kernel.org>
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_053818_525451_64FE91F7 
X-CRM114-Status: GOOD (  15.22  )
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

Ck9uIDE0LjA0LjI2IDE0OjE3LCBQcmF0eXVzaCBZYWRhdiB3cm90ZToKPiBGcm9tOiAiUHJhdHl1
c2ggWWFkYXYgKEdvb2dsZSkiIDxwcmF0eXVzaEBrZXJuZWwub3JnPgo+Cj4gSSBoYXZlIGJlZW4g
aGVscGluZyBvdXQgd2l0aCByZXZpZXdpbmcgYW5kIGRldmVsb3BpbmcgS0hPLiBJIHdvdWxkIGFs
c28KPiBsaWtlIHRvIGhlbHAgbWFpbnRhaW4gaXQuIENoYW5nZSBteSBlbnRyeSBmcm9tIFIgdG8g
TSBmb3IgS0hPIGFuZCBsaXZlCj4gdXBkYXRlLiBBbGV4IGhhcyBiZWVuIGluYWN0aXZlIGZvciBh
IHdoaWxlLCBzbyB0byBhdm9pZCBvdmVyLWNyb3dkaW5nCj4gdGhlIEtITyBlbnRyeSBhbmQgdG8g
a2VlcCB0aGUgaW5mb3JtYXRpb24gdXAtdG8tZGF0ZSwgbW92ZSBoaXMgZW50cnkKPiBmcm9tIE0g
dG8gUi4KPgo+IFdlIGFsc28gbm93IGhhdmUgYSB0cmVlIGZvciBLSE8gYW5kIGxpdmUgdXBkYXRl
IGF0IGxpdmV1cGRhdGUvbGludXguZ2l0Cj4gd2hlcmUgd2UgcGxhbiB0byBzdGFydCBtYWludGFp
bmluZyB0aG9zZSBzdWJzeXN0ZW1zIGFuZCBzdGFydCBxdWV1aW5nCj4gdGhlIHBhdGNoZXMuIExp
c3QgdGhhdCBpbiB0aGUgZW50cmllcyBhcyB3ZWxsLgo+Cj4gU2lnbmVkLW9mZi1ieTogUHJhdHl1
c2ggWWFkYXYgKEdvb2dsZSkgPHByYXR5dXNoQGtlcm5lbC5vcmc+CgoKUmV2aWV3ZWQtYnk6IEFs
ZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+CgoKQWxleAoKCj4gLS0tCj4gICBDUkVESVRT
ICAgICB8IDQgKysrKwo+ICAgTUFJTlRBSU5FUlMgfCA4ICsrKysrLS0tCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9D
UkVESVRTIGIvQ1JFRElUUwo+IGluZGV4IDkwOTFiYWMzZDJkYS4uOTE3MzUwOGI0ZTAzIDEwMDY0
NAo+IC0tLSBhL0NSRURJVFMKPiArKysgYi9DUkVESVRTCj4gQEAgLTE0NTYsNiArMTQ1NiwxMCBA
QCBOOiBBbmR5IEdvc3BvZGFyZWsKPiAgIEU6IGFuZHlAZ3JleWhvdXNlLm5ldAo+ICAgRDogTWFp
bnRlbmFuY2UgYW5kIGNvbnRyaWJ1dGlvbnMgdG8gdGhlIG5ldHdvcmsgaW50ZXJmYWNlIGJvbmRp
bmcgZHJpdmVyLgo+Cj4gK046IEFsZXhhbmRlciBHcmFmCj4gK0U6IGdyYWZAYW1hem9uLmNvbQo+
ICtEOiBLZXhlYyBIYW5kb3ZlciAoS0hPKQo+ICsKPiAgIE46IFdvbGZnYW5nIEdyYW5kZWdnZXIK
PiAgIEU6IHdnQGdyYW5kZWdnZXIuY29tCj4gICBEOiBDb250cm9sbGVyIEFyZWEgTmV0d29yayAo
ZGV2aWNlIGRyaXZlcnMpCj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMK
PiBpbmRleCA5MTVmMDc0YzM1NzcuLjk3ODIwMTg4YTYwMCAxMDA2NDQKPiAtLS0gYS9NQUlOVEFJ
TkVSUwo+ICsrKyBiL01BSU5UQUlORVJTCj4gQEAgLTE0MTA5LDEzICsxNDEwOSwxNCBAQCBGOiAg
ICBpbmNsdWRlL3VhcGkvbGludXgva2V4ZWMuaAo+ICAgRjogICAgIGtlcm5lbC9rZXhlYyoKPgo+
ICAgS0VYRUMgSEFORE9WRVIgKEtITykKPiAtTTogICAgIEFsZXhhbmRlciBHcmFmIDxncmFmQGFt
YXpvbi5jb20+Cj4gICBNOiAgICAgTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPgo+ICAg
TTogICAgIFBhc2hhIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBzb2xlZW4uY29tPgo+IC1SOiAg
ICAgUHJhdHl1c2ggWWFkYXYgPHByYXR5dXNoQGtlcm5lbC5vcmc+Cj4gK006ICAgICBQcmF0eXVz
aCBZYWRhdiA8cHJhdHl1c2hAa2VybmVsLm9yZz4KPiArUjogICAgIEFsZXhhbmRlciBHcmFmIDxn
cmFmQGFtYXpvbi5jb20+Cj4gICBMOiAgICAga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+ICAg
TDogICAgIGxpbnV4LW1tQGt2YWNrLm9yZwo+ICAgUzogICAgIE1haW50YWluZWQKPiArVDogICAg
IGdpdCBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGl2ZXVw
ZGF0ZS9saW51eC5naXQKPiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2to
by5yc3QKPiAgIEY6ICAgICBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2toby8qCj4gICBGOiAgICAg
aW5jbHVkZS9saW51eC9rZXhlY19oYW5kb3Zlci5oCj4gQEAgLTE0ODAyLDkgKzE0ODAzLDEwIEBA
IEY6ICAgICB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9saXZlcGF0Y2gvCj4gICBMSVZFIFVQREFU
RQo+ICAgTTogICAgIFBhc2hhIFRhdGFzaGluIDxwYXNoYS50YXRhc2hpbkBzb2xlZW4uY29tPgo+
ICAgTTogICAgIE1pa2UgUmFwb3BvcnQgPHJwcHRAa2VybmVsLm9yZz4KPiAtUjogICAgIFByYXR5
dXNoIFlhZGF2IDxwcmF0eXVzaEBrZXJuZWwub3JnPgo+ICtNOiAgICAgUHJhdHl1c2ggWWFkYXYg
PHByYXR5dXNoQGtlcm5lbC5vcmc+Cj4gICBMOiAgICAgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZwo+ICAgUzogICAgIE1haW50YWluZWQKPiArVDogICAgIGdpdCBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbGl2ZXVwZGF0ZS9saW51eC5naXQKPiAgIEY6
ICAgICBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL2xpdmV1cGRhdGUucnN0Cj4gICBGOiAgICAgRG9j
dW1lbnRhdGlvbi9tbS9tZW1mZF9wcmVzZXJ2YXRpb24ucnN0Cj4gICBGOiAgICAgRG9jdW1lbnRh
dGlvbi91c2Vyc3BhY2UtYXBpL2xpdmV1cGRhdGUucnN0Cj4gLS0KPiAyLjU0LjAucmMwLjYwNS5n
NTk4YTI3M2IwMy1nb29nCj4KCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9wbWVudCBDZW50
ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAyNDMgQmVybGluCkdlc2NoYWVm
dHNmdWVocnVuZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBTdGllZ2VyCkVpbmdldHJhZ2Vu
IGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQgQgpTaXR6OiBC
ZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=



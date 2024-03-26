Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E101FCD1280
	for <kexec@archiver.kernel.org>; Tue, 26 Mar 2024 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8a1G6mnVi4DD9uey/TBHOSsNjF6GxBKsWlsCzd0dPLA=; b=ukLW5QWy66pKpM
	sKfykoCHwGcs7Q6jO2iAlNqWk1UgFYlMlnNYlDcn1n5hBM06EvwLzupvoKj1i9QFv4Nh3BTPE+Ff3
	1l3ufkPgfJhwfNdJqylhXWBA1l9Vi2CboZknJrv6VSKBudoDOkke00EaU/Y/0+l8jfQ9axXBF2JW7
	HDTnUArnJrMx5yKBgK9MuSsz61U8v6nXzx288i5kNMYIcmFVolT4TEP36bWARlqt9ibOK0SXgTf6x
	9YdaHZ6+bELQHxxtRQIg2fWL9K7z9jQP2AULn5rDWk1ylI8YMyuvqkbauBy0pZMpfZC+ffACVWLpy
	lcUdN1RI2M962OBzbNnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp61C-00000004UJF-1bVQ;
	Tue, 26 Mar 2024 12:35:06 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp619-00000004UFZ-2N09
	for kexec@lists.infradead.org;
	Tue, 26 Mar 2024 12:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711456504; x=1742992504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mRQbNSw2E83MSaXvm8O7UtJ5JtXj8itcmTN7uuFR/aQ=;
  b=QuVA1v8MSYwBhm2to+oF3b8og+XIkn2UD0hxcFRuWunMdtDIQ7sup8Dv
   ZxDv39qFvb1BwuabAkvM57Ej32NcI6Ir9pqUbSITSmM+8YotRHK+UHEds
   KnQRnSq8gFjKgZaRm4KEM8mSi8W4197s0uPWdnH91kIJgtFL/vfCII7Ww
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,156,1708387200"; 
   d="scan'208";a="390593410"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 12:34:56 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:54885]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.153:2525] with esmtp (Farcaster)
 id 1431dfb6-3a84-49e8-b598-f34b07be410d; Tue, 26 Mar 2024 12:34:54 +0000 (UTC)
X-Farcaster-Flow-ID: 1431dfb6-3a84-49e8-b598-f34b07be410d
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 12:34:54 +0000
Received: from [192.168.79.84] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 12:34:50 +0000
Message-ID: <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
Date: Tue, 26 Mar 2024 14:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Implementing .shutdown method for efa module
Content-Language: en-US
To: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>
CC: <sleybo@amazon.com>, <jgg@ziepe.ca>, <leon@kernel.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
X-Originating-IP: [10.85.143.175]
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_053503_802740_76EFA730 
X-CRM114-Status: GOOD (  18.11  )
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

SGkgVGFvLAoKVGhhbmtzIGZvciBicmluZ2luZyB0aGlzIHVwLgoKSSd2ZSB1bnN1Y2Nlc3NmdWxs
eSB0cmllZCB0byByZXByb2R1Y2UgdGhpcyBrZXJuZWwgcGFuaWMgdXNpbmcgCnByb2R1Y3Rpb24g
UmVkIEhhdCA5LjMgQU1JICg1LjE0LjAtMzYyLjE4LjEuZWw5XzMuYWFyY2g2NCkuCgpBcmUgdGhl
cmUgYW55IHJlbGF0ZWQgY2hhbmdlcyBpbiB0aGUga2VybmVsIHlvdSBhcmUgdGVzdGluZz8KCkFu
eXdheXMgd2UgZG8gbmVlZCB0byBoYW5kbGUgc2h1dGRvd24gcHJvcGVybHksIHBsZWFzZSBsZXQg
a25vdyBpZiAKY2FsbGluZyB0byBlZmFfcmVtb3ZlIHNvbHZlcyB5b3VyIGlzc3VlLgoKTWljaGFl
bAoKT24gMy8yNi8yMDI0IDM6MzggQU0sIFRhbyBMaXUgd3JvdGU6Cj4gSGkgR2FsLAo+Cj4gT24g
TW9uLCBNYXIgMjUsIDIwMjQgYXQgNDowNuKAr1BNIEdhbCBQcmVzc21hbiA8Z2FsLnByZXNzbWFu
QGxpbnV4LmRldj4gd3JvdGU6Cj4+IE9uIDI1LzAzLzIwMjQgNDoxMCwgVGFvIExpdSB3cm90ZToK
Pj4+IEhpLAo+Pj4KPj4+IFJlY2VudGx5IEkgZXhwZXJpZW5jZWQgYSBrZXJuZWwgcGFuaWMgd2hp
Y2ggaXMgcmVsYXRlZCB0byBlZmEgbW9kdWxlCj4+PiB3aGVuIHRlc3Rpbmcga2V4ZWMgLWwgJiYg
a2V4ZWMgLWUgdG8gc3dpdGNoIHRvIGEgbmV3IGtlcm5lbCBvbiBBV1MKPj4+IGk0Zy4xNnhsYXJn
ZSBpbnN0YW5jZS4KPj4+Cj4+PiBIZXJlIGlzIHRoZSBkbWVzZyBsb2c6Cj4+Pgo+Pj4gWyAgICA2
LjM3OTkxOF0gc3lzdGVtZFsxXTogTW91bnRpbmcgRlVTRSBDb250cm9sIEZpbGUgU3lzdGVtLi4u
Cj4+PiBbICAgIDYuMzgxOTg0XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBLZXJuZWwgQ29uZmlndXJh
dGlvbiBGaWxlIFN5c3RlbS4uLgo+Pj4gWyAgICA2LjM4MzkxOF0gc3lzdGVtZFsxXTogU3RhcnRp
bmcgQXBwbHkgS2VybmVsIFZhcmlhYmxlcy4uLgo+Pj4gWyAgICA2LjM4NTQzMF0gc3lzdGVtZFsx
XTogU3RhcnRlZCBKb3VybmFsIFNlcnZpY2UuCj4+PiBbICAgIDYuMzk0MjIxXSBBQ1BJOiBidXMg
dHlwZSBkcm1fY29ubmVjdG9yIHJlZ2lzdGVyZWQKPj4+IFsgICAgNi40MjE0MDhdIHN5c3RlbWQt
am91cm5hbGRbMTI2M106IFJlY2VpdmVkIGNsaWVudCByZXF1ZXN0IHRvCj4+PiBmbHVzaCBydW50
aW1lIGpvdXJuYWwuCj4+PiBbICAgIDcuMjYyNTQzXSBlZmEgMDAwMDowMDoxYi4wOiBlbmFibGlu
ZyBkZXZpY2UgKDAwMTAgLT4gMDAxMikKPj4+IFsgICAgNy40MzI0MjBdIGVmYSAwMDAwOjAwOjFi
LjA6IFNldHVwIGlycToxOTEgbmFtZTplZmEtbWdtbnRAcGNpOjAwMDA6MDA6MWIuMAo+Pj4gWyAg
ICA3LjQzNTU4MV0gZWZhIDAwMDA6MDA6MWIuMCBlZmFfMDogSUIgZGV2aWNlIHJlZ2lzdGVyZWQK
Pj4+IFsgICAgNy44ODU1NjRdIHJhbmRvbTogY3JuZyBpbml0IGRvbmUKPj4+IFsgICAgOC4xMzk4
NTddIFhGUyAobnZtZTBuMXAyKTogTW91bnRpbmcgVjUgRmlsZXN5c3RlbQo+Pj4gZDcwMDNlY2Mt
ZGI2Zi00YmZiLWJmOTItNjAzNzZiNmE2NTYzCj4+PiBbICAgIDguMjY1MjMzXSBYRlMgKG52bWUw
bjFwMik6IEVuZGluZyBjbGVhbiBtb3VudAo+Pj4gWyAgIDEwLjU1NTYxMl0gSVB2NjogQUREUkNP
TkYoTkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsgYmVjb21lcyByZWFkeQo+Pj4KPj4+IFJlZCBI
YXQgRW50ZXJwcmlzZSBMaW51eCA5LjQgQmV0YSAoUGxvdykKPj4+IEtlcm5lbCA1LjE0LjAtNDI1
LmVsOS5hYXJjaDY0IG9uIGFuIGFhcmNoNjQKPj4+Cj4+PiBpcC0xMC0wLTI3LTIyNiBsb2dpbjog
WyAgIDI5Ljk0MDM4MV0ga2V4ZWNfY29yZTogU3RhcnRpbmcgbmV3IGtlcm5lbAo+Pj4gWyAgIDMw
LjA3OTI3OV0gcHNjaTogQ1BVMSBraWxsZWQgKHBvbGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjExOTIy
Ml0gcHNjaTogQ1BVMiBraWxsZWQgKHBvbGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjE5OTI5M10gcHNj
aTogQ1BVMyBraWxsZWQgKHBvbGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjMwOTIxNF0gcHNjaTogQ1BV
NCBraWxsZWQgKHBvbGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjM3OTIyMV0gcHNjaTogQ1BVNSBraWxs
ZWQgKHBvbGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjQxOTIxMF0gcHNjaTogQ1BVNiBraWxsZWQgKHBv
bGxlZCAwIG1zKQo+Pj4gWyAgIDMwLjQ4OTIwN10gSVJRIDE5MTogbm8gbG9uZ2VyIGFmZmluZSB0
byBDUFU3Cj4+PiBbICAgMzAuNDg5NjY3XSBwc2NpOiBDUFU3IGtpbGxlZCAocG9sbGVkIDAgbXMp
Cj4+PiAuLnNuaXAuLi4KPj4+IFsgICAzMy44NDkxMjNdIHBzY2k6IENQVTYzIGtpbGxlZCAocG9s
bGVkIDAgbXMpCj4+PiBbICAgMzMuODQ5OTQzXSBCeWUhCj4+PiBbICAgIDAuMDAwMDAwXSBCb290
aW5nIExpbnV4IG9uIHBoeXNpY2FsIENQVSAweDAwMDAwMDAwMDAgWzB4NDEzZmQwYzFdCj4+PiBb
ICAgIDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDUuMTQuMC00MTcuZWw5LmFhcmNoNjQKPj4+ICht
b2NrYnVpbGRAYXJtNjQtMDI1LmJ1aWxkLmVuZy5ib3MucmVkaGF0LmNvbSkgKGdjYyAoR0NDKSAx
MS40LjEKPj4+IDIwMjMxMjE4IChSZWQgSGF0IDExLjQuMS0zKSwgR05VIGxkIHZlcnNpb24gMi4z
NS4yLTQyLmVsOSkgIzEgU01QCj4+PiBQUkVFTVBUX0RZTkFNSUMgVGh1IEZlYiAxIDIxOjIzOjAz
IEVTVCAyMDI0Cj4+PiAuLi5zbmlwLi4uCj4+PiBbICAgIDEuMDEyNjkyXSBGcmVlaW5nIHVudXNl
ZCBrZXJuZWwgbWVtb3J5OiA2MDE2Swo+Pj4gWyAgICAyLjM3MDk0N10gQ2hlY2tlZCBXK1ggbWFw
cGluZ3M6IHBhc3NlZCwgbm8gVytYIHBhZ2VzIGZvdW5kCj4+PiBbICAgIDIuMzcwOTgwXSBSdW4g
L2luaXQgYXMgaW5pdCBwcm9jZXNzCj4+PiBbICAgIDIuMzcwOTgyXSAgIHdpdGggYXJndW1lbnRz
Ogo+Pj4gWyAgICAyLjM3MDk4M10gICAgIC9pbml0Cj4+PiBbICAgIDIuMzcwOTg0XSAgIHdpdGgg
ZW52aXJvbm1lbnQ6Cj4+PiBbICAgIDIuMzcwOTg0XSAgICAgSE9NRT0vCj4+PiBbICAgIDIuMzcw
OTg1XSAgICAgVEVSTT1saW51eAo+Pj4gWyAgICAyLjM3MzI1N10gS2VybmVsIHBhbmljIC0gbm90
IHN5bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhCj4+PiBleGl0Y29kZT0weDAwMDAwMDBi
Cj4+PiBbICAgIDIuMzczMjU5XSBDUFU6IDEgUElEOiAxIENvbW06IGluaXQgTm90IHRhaW50ZWQg
NS4xNC4wLTQxNy5lbDkuYWFyY2g2NCAjMQo+Pj4gWyAgICAyLjM4MjI0MF0gSGFyZHdhcmUgbmFt
ZTogQW1hem9uIEVDMiBpNGcuMTZ4bGFyZ2UvLCBCSU9TIDEuMCAxMS8xLzIwMTgKPj4+IFsgICAg
Mi4zODM4MTRdIENhbGwgdHJhY2U6Cj4+PiBbICAgIDIuMzg0NDEwXSAgZHVtcF9iYWNrdHJhY2Ur
MHhhOC8weDEyMAo+Pj4gWyAgICAyLjM4NTMxOF0gIHNob3dfc3RhY2srMHgxYy8weDMwCj4+PiBb
ICAgIDIuMzg2MTI0XSAgZHVtcF9zdGFja19sdmwrMHg3NC8weDhjCj4+PiBbICAgIDIuMzg3MDEx
XSAgZHVtcF9zdGFjaysweDE0LzB4MjQKPj4+IFsgICAgMi4zODc4MTBdICBwYW5pYysweDE1OC8w
eDM2OAo+Pj4gWyAgICAyLjM4ODU1M10gIGRvX2V4aXQrMHgzYTgvMHgzYjAKPj4+IFsgICAgMi4z
ODkzMzNdICBkb19ncm91cF9leGl0KzB4MzgvMHhhNAo+Pj4gWyAgICAyLjM5MDE5NV0gIGdldF9z
aWduYWwrMHg3YTQvMHg4MTAKPj4+IFsgICAgMi4zOTEwNDRdICBkb19zaWduYWwrMHgxYmMvMHgy
NjAKPj4+IFsgICAgMi4zOTE4NzBdICBkb19ub3RpZnlfcmVzdW1lKzB4MTA4LzB4MjEwCj4+PiBb
ICAgIDIuMzkyODM5XSAgZWwwX2RhKzB4MTU0LzB4MTYwCj4+PiBbICAgIDIuMzkzNjAzXSAgZWww
dF82NF9zeW5jX2hhbmRsZXIrMHhkYy8weDE1MAo+Pj4gWyAgICAyLjM5NDYyOF0gIGVsMHRfNjRf
c3luYysweDE3Yy8weDE4MAo+Pj4gWyAgICAyLjM5NTUxM10gU01QOiBzdG9wcGluZyBzZWNvbmRh
cnkgQ1BVcwo+Pj4gWyAgICAyLjM5NjQ4M10gS2VybmVsIE9mZnNldDogMHg1ODZmMDRlMDAwMDAg
ZnJvbSAweGZmZmY4MDAwMDgwMDAwMDAKPj4+IFsgICAgMi4zOTc5MzRdIFBIWVNfT0ZGU0VUOiAw
eDQwMDAwMDAwCj4+PiBbICAgIDIuMzk4Nzc0XSBDUFUgZmVhdHVyZXM6IDB4MCwwMDAwMDEwMSw3
MDAyMDE0MywxMDQxN2EwYgo+Pj4gWyAgICAyLjQwMDA0Ml0gTWVtb3J5IExpbWl0OiBub25lCj4+
PiBbICAgIDIuNDAwNzgzXSAtLS1bIGVuZCBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0
ZW1wdGVkIHRvIGtpbGwKPj4+IGluaXQhIGV4aXRjb2RlPTB4MDAwMDAwMGIgXS0tLQo+Pj4KPj4+
IEluIHRoZSBkbWVzZyBsb2csIEkgZm91bmQgIlsgICAzMC40ODkyMDddIElSUSAxOTE6IG5vIGxv
bmdlciBhZmZpbmUgdG8KPj4+IENQVTciIGlzIHN1c3BpY2lvdXMsIHdoaWNoIGlzIHJlbGF0ZWQg
dG8gZWZhIG1vZHVsZS4gQWZ0ZXIgYmxhY2tsaXN0Cj4+PiBlZmEgbW9kdWxlIGZyb20gYXV0b21h
dGljIGxvYWRpbmcgd2hlbiBib290dXAsIHRoZSBrZXJuZWwgcGFuaWMgaXNzdWUKPj4+IGRvZXNu
J3QgYXBwZWFyIGFnYWluLgo+Pj4KPj4+IEl0IGxvb2tzIHRvIG1lIGl0IGlzIGR1ZSB0byB0aGUg
ZWZhIGJlaW5nIG5vdCBwcm9wZXJseSBzaHV0ZG93biBkdXJpbmcKPj4+IGtleGVjLCBzbyB0aGUg
b25nb2luZyBETUEvaW50ZXJydXB0cyBldGMgb3ZlcndyaXRlIHRoZSBtZW1vcnkgcmFuZ2UuCj4+
Pgo+Pj4gVGhvdWdoIHRoZSBpc3N1ZSBpcyByZXByb2R1Y2VkIG9uIHJoZWwncyBrZXJuZWwsIHRo
ZSB1cHN0cmVhbSBrZXJuZWwKPj4+IFsxXSBkb2Vzbid0IGhhdmUgdGhlIC5zaHV0ZG93biBtZXRo
b2QgaW1wbGVtZW50ZWQgZWl0aGVyLiBTaW5jZSBJJ20KPj4+IG5vdCB2ZXJ5IGZhbWlsaWFyIHdp
dGggdGhlIGVmYSBkcml2ZXIsIGNvdWxkIHlvdSBwbGVhc2UgaW1wbGVtZW50IHRoZQo+Pj4gLnNo
dXRkb3duIG1ldGhvZCBpbiBkcml2ZXJzL2luZmluaWJhbmQvaHcvZWZhL2VmYV9tYWluLmM/IFRo
YW5rcyBpbgo+Pj4gYWR2YW5jZSEKPj4gRGlkIHlvdSB0cnkgdG8gcmVwcm9kdWNlIGl0IG9uIHVw
c3RyZWFtIGtlcm5lbD8KPj4KPiBUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhIE5vIEkgaGF2ZW4n
dCwgSSB3aWxsIGdpdmUgaXQgYSB0cnkuCj4+PiBbMV06IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibG9iL21hc3Rlci9kcml2ZXJzL2luZmluaWJhbmQvaHcvZWZhL2VmYV9tYWlu
LmMjTDY3NAo+Pj4KPj4+IFRoYW5rcywKPj4+IFRhbyBMaXUKPj4+Cj4+IFRyeSBhc3NpZ25pbmcg
ZWZhX3JlbW92ZSBhcyB0aGUgc2h1dGRvd24gY2FsbGJhY2s6Cj4+ICAgICAgLnNodXRkb3duID0g
ZWZhX3JlbW92ZSwKPj4KPj4gRG9lcyBpdCBmaXggaXQ/Cj4gVGhhbmtzLCBJIHdpbGwgYWxzbyB0
cnkgdGhlIGNvZGUsIGFuZCBJIHdpbGwgcG9zdCB0aGUgdGVzdGluZyByZXN1bHRzLgo+Cj4gVGhh
bmtzLAo+IFRhbyBMaXUKPgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

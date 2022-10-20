Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC48C4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 03:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sLAF/bwrCX6LY8KP5ilwNjA3XyxcP7s8nEjfj2e8FQY=; b=Ttzm9qs8VM+Ir2
	IUTfFKd00JmUSaetjhbAJ/x/TNoh2PTORlB88XoL6vsq8Ws0fA7MIvx0A1l+jKizw/48bo48WQNj4
	IcXEX42RfliMcwD1Fp+TzCnLioQe1SMwYlA6x9oPJPzdsQa/uHhdObpAmfi6a+PFxEqT/KxhzVwvW
	Btf30Uhh83DoG1kbIepdJNGYIUgtvNqDOfrmoD9eliVSXQNtQ2BaE1wzYJKpak8rCMdaopQxxHdcB
	RNEk5h9AHrL+bjrLUk+vCtYrPHOGM9+bj7c/5lIae+Bu+/Xpja8+yX78twDoTpOZpQyLQ5R+SZaUX
	LvDu+fOFcB2eYh1wbk1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olLnn-009bUa-5b; Thu, 20 Oct 2022 03:00:59 +0000
Received: from out199-13.us.a.mail.aliyun.com ([47.90.199.13])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olKjl-009AvD-W8; Thu, 20 Oct 2022 01:52:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VScdp8u_1666230756;
Received: from 30.221.97.125(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VScdp8u_1666230756)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 09:52:38 +0800
Message-ID: <5fa1f75a-1641-771e-3670-2d8978c99d2a@linux.alibaba.com>
Date: Thu, 20 Oct 2022 09:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?=
 <k-hagio-ab@nec.com>, Baoquan He <bhe@redhat.com>,
 lijiang <lijiang@redhat.com>
Cc: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
 "anup@brainfault.org" <anup@brainfault.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "guoren@kernel.org"
 <guoren@kernel.org>, "mick@ics.forth.gr" <mick@ics.forth.gr>,
 "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
 "vgoyal@redhat.com" <vgoyal@redhat.com>,
 "dyoung@redhat.com" <dyoung@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
 "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "crash-utility@redhat.com" <crash-utility@redhat.com>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
 "yixun.lan@gmail.com" <yixun.lan@gmail.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
 <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
 <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
 <52023285-172a-97cc-bad4-4ab4e709885c@nec.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <52023285-172a-97cc-bad4-4ab4e709885c@nec.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_185246_329529_AF0A0A15 
X-CRM114-Status: GOOD (  15.04  )
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

CuWcqCAyMDIyLzEwLzIwIOS4iuWNiDk6MzUsIEhBR0lPIEtBWlVISVRPKOiQqeWwviDkuIDku4Ep
IOWGmemBkzoKPiBPbiAyMDIyLzEwLzE5IDEyOjE3LCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Cj4+
Pj4+Pj4+ICvCoMKgwqAgaWYgKElTX0VOQUJMRUQoQ09ORklHXzY0QklUKSkgewo+Pj4+Pj4+PiAr
I2lmZGVmIENPTkZJR19LQVNBTgo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19h
cHBlbmRfc3RyKCJOVU1CRVIoS0FTQU5fU0hBRE9XX1NUQVJUKT0weCVseFxuIiwgS0FTQU5fU0hB
RE9XX1NUQVJUKTsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHZtY29yZWluZm9fYXBwZW5kX3N0
cigiTlVNQkVSKEtBU0FOX1NIQURPV19FTkQpPTB4JWx4XG4iLCBLQVNBTl9TSEFET1dfRU5EKTsK
Pj4+Pj4+Pj4gKyNlbmRpZgo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19hcHBl
bmRfc3RyKCJOVU1CRVIoS0VSTkVMX0xJTktfQUREUik9MHglbHhcbiIsIEtFUk5FTF9MSU5LX0FE
RFIpOwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJOVU1C
RVIoQUREUkVTU19TUEFDRV9FTkQpPTB4JWx4XG4iLCBBRERSRVNTX1NQQUNFX0VORCk7Cj4+Pj4+
Pj4gU2VlbXMgdGhpcyBpcyB0aGUgZmlyc3IgQVJDSCB3aGVyZSBrYXNhbiBhbmQga2VybmVsIGxp
bmsvYnBmIHNwYWNlIGFyZQo+Pj4+Pj4+IGFkZGVkIHRvIGR1bXAgYW5kIGFuYWx5emUuIEp1c3Qg
Y3VyaW91cywgaGF2ZSB5b3UgZ290IGNvZGUgY2hhbmdlIHRvCj4+Pj4+Pj4gbWFrZSB1c2Ugb2Yg
dGhlbSB0byBkbyBkdW1waW5nIGFuZCBhbmFseXplPwo+Pj4+Pj4gS0FTQU5fU0hBRE9XX1NUQVJU
IGlzIG5vdCB1c2VkLCBLRVJORUxfTElOS19BRERSIGlzIHVzZWQgaW4gdGhlIGNyYXNoIHBhdGNo
IHNldDoKPj4+Pj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1y
aXNjdi9jb3Zlci8yMDIyMDgxMzAzMTc1My4zMDk3NzIwLTEteGlhbnRpbmcudGlhbkBsaW51eC5h
bGliYWJhLmNvbS8KPj4+Pj4gT2gsIEkgd291bGQgc2F5IHBsZWFzZSBuby4gU29tZXRpbWUgd2Ug
Z290IHRvbnMgb2Ygb2JqZWN0aW9uIHdoZW4gYWRkaW5nIGFuCj4+Pj4+IG5lY2Vzc2FyeSBvbmUs
IHdlIGRlZmluaXRlbHkgc2hvdWxkIG5vdCBhZGQgb25lIGZvciBwb3NzaWJsZSBmdXR1cmUKPj4+
Pj4gdXNlLgo+Pj4+Pgo+Pj4+PiBGb3IgdGhpcyBraW5kIG9mIG5ld2x5IGFkZGVkIG9uZSwgd2Ug
bmVlZCBnZXQgYWNrIGZyb20KPj4+Pj4gbWFrZWR1bXBmaWxlL2NyYXNoIHV0aWxpdHkgbWFpbnRh
aW5lciBzbyB0aGF0IHdlIGtub3cgdGhleSBhcmUgbmVjZXNzYXJ5Cj4+Pj4+IHRvIGhhdmUuIEF0
IGxlYXN0IHRoZXkgZG9uJ3Qgb3Bwb3NlLgo+Pj4+IEhpIEthenUsIExpIEppYW5nCj4+Pj4KPj4+
PiBDb3VsZCB5b3UgaGVscCBjb21tZW50IHdoZXRoZXIgd2UgbmVlZCBLQVNBTl9TSEFET1dfU1RB
UlQgYW5kIEtFUk5FTF9MSU5LX0FERFIgYXJlYSBleHBvcnQgZm9yIHZtY29yZSBmcm9tIGNyYXNo
IHBvaW50IG9mIHZpZXfvvJ8KPj4+Pgo+Pj4+IEluIG15IGNyYXNoIHBhdGNoIHNldCwgSSBkb24n
dCB1c2UgS0FTQU5fU0hBRE9XX1NUQVJULAo+Pj4+IEFuZCBvbmx5IGdldCB0aGUgdmFsdWUgb2Yg
S0VSTkVMX0xJTktfQUREUiwgbm90IHJlYWx5IHVzZSBpdC4KPj4+PiBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcmlzY3YvY292ZXIvMjAyMjA4MTMwMzE3NTMuMzA5
NzcyMC0xLXhpYW50aW5nLnRpYW5AbGludXguYWxpYmFiYS5jb20vCj4+PiBJbiB5b3VyIGNyYXNo
IHBhdGNoIHNldCwgS0VSTkVMX0xJTktfQUREUiBpcyB1c2VkIGluIFZUT1AoKSBhbmQgbG9va3MK
Pj4+IG5lY2Vzc2FyeSB0byBtZS4KPj4+Cj4+PiBUaGUgb3RoZXJzIChLQVNBTl9TSEFET1dfU1RB
UlQsIEtBU0FOX1NIQURPV19FTkQgYW5kIEFERFJFU1NfU1BBQ0VfRU5EKQo+Pj4gYXJlIG5vdCBj
dXJyZW50bHkgdXNlZC7CoCBJdCBtYXkgYmUgYmV0dGVyIHRvIGFkZCB0aGVtIHdoZW4gdGhleSBh
cmUKPj4+IHJlYWxseSB1c2VkLgo+PiBJIGFtIHZlcnkgc29ycnksIEkgbWlzc2VkIGl0ICwgS0VS
TkVMX0xJTktfQUREUiBpcyB1c2VkIGluZGVlZC4KPj4KPj4gS0FTQU5fU0hBRE9XX1NUQVJUIGlz
IG5vdCB1c2VkLCBzbyBJIGRvbid0IG5lZWQgdG8gc2VuZCBjcmFzaCBwYXRjaCBzZXQ+IGFnYWlu
LiBvbmx5IG5lZWQgdG8gcmVtb3ZlIEtBU0FOX1NIQURPV19FTkQgaW4ga2VybmVsIHBhdGNoIHNl
dC4KPiBJIHNlZSB0aGF0IHlvdXIgdjQga2VybmVsIHBhdGNoIHNldCBkb2VzIG5vdCBoYXZlIEFE
RFJFU1NfU1BBQ0VfRU5ELAo+IHNvIGl0IHNlZW1zIHRoZXJlIHdvdWxkIGJlIG5lZWQgdG8gY2hh
bmdlIHRoaXMgcGFydCBhbmQgcmVsYXRlZCBvbmVzCj4gYXQgY3Jhc2ggc2lkZS4KPgo+ICAgICAg
ICAgICBpZiAoKHN0cmluZyA9IHBjLT5yZWFkX3ZtY29yZWluZm8oIk5VTUJFUihBRERSRVNTX1NQ
QUNFX0VORCkiKSkpIHsKPiAgICAgICAgICAgICAgICAgICBtcy0+YWRkcmVzc19zcGFjZV9lbmQg
PSBodG9sKHN0cmluZywgUVVJRVQsIE5VTEwpOwo+ICAgICAgICAgICAgICAgICAgIGZyZWUoc3Ry
aW5nKTsKPiAgICAgICAgICAgfSBlbHNlCj4gICAgICAgICAgICAgICAgICAgZ290byBlcnJvcjsK
PiAuLi4KPiBlcnJvcjoKPiAgICAgICAgICAgZXJyb3IoRkFUQUwsICJjYW5ub3QgZ2V0IHZtIGxh
eW91dFxuIik7Cgp0aGFua3MsCgpJIGp1c3Qgc2VuZCBWNCBvZiBjcmFzaCBwYXRjaCBzZXQsIHRo
ZSBpc3N1ZSBpcyBhbHNvIGZpeGVkIGluIFY0LgoKPgo+IFRoYW5rcywKPiBLYXp1CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

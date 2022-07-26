Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD79C433EF
	for <kexec@archiver.kernel.org>; Tue, 26 Jul 2022 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veA7KHQ/x3G9QO5iNhNQuF9PMOm9uAGRU7EiSpweIr4=; b=1CmEx9jzjpGZrvjP3aKHUAERNW
	awZGHJhfWkpdOYJBBmHqavidNrgthMiOpxWww1DdtnUYgdQlVGfsEoiGE4mY1cFm5rewzn3xDy/Qr
	HmfcuFc6hdN6/8VNuZ9ZNmCSnFxlobjI055V4uWEtJrZ6Btgv+JqGmKNG64RyGkrfyn2frqAZillB
	IyyR1n/Bt25UfwUeHY6w99dFEQCPGr6C+ni3QsKKfVVkbEWIt14yo9EZq6yYXh2xo3HPAZRV+AjYz
	mIdBHGBcxWfLjUBXTy3G/iLx5agbuUDvzihhKysHAVhMz78geUA/1RwKdp0kLwMEADlfBqUIQNxo5
	isKWlAyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGHAV-00BrwH-FF; Tue, 26 Jul 2022 09:47:59 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGHAS-00Brnv-4P; Tue, 26 Jul 2022 09:47:58 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKV-R7N_1658828869;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKV-R7N_1658828869)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 17:47:51 +0800
Subject: Re: [RESEND PATCH V2 0/5] Fixups to work with crash tool
To: Conor.Dooley@microchip.com
Cc: alexandre.ghiti@canonical.com, heiko@sntech.de, palmer@dabbelt.com,
 mick@ics.forth.gr, guoren@kernel.org, kexec@lists.infradead.org,
 bhe@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 linux-riscv@lists.infradead.org, dyoung@redhat.com,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 huanyi.xj@alibaba-inc.com, heinrich.schuchardt@canonical.com,
 anup@brainfault.org, corbet@lwn.net, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
References: <20220725014539.1037627-1-xianting.tian@linux.alibaba.com>
 <51c97da7-422f-1b5b-03d3-dc36c9132c2a@microchip.com>
 <7a395f64-8ec7-e07f-e763-afc1f2611c75@linux.alibaba.com>
 <2301681f-361d-b85b-e255-3bf449ceeaa9@microchip.com>
 <cf00c1f6-b043-a11e-f7a5-bed1e829cb73@linux.alibaba.com>
 <6320e6dd-ebd9-3575-a85f-c3a2f92e9f54@linux.alibaba.com>
 <31b13104-cc37-985a-cdeb-05a9507fa74c@microchip.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <9fe2ec74-3062-4c23-2683-6a7e4a4765e7@linux.alibaba.com>
Date: Tue, 26 Jul 2022 17:47:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <31b13104-cc37-985a-cdeb-05a9507fa74c@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_024756_402333_051DB42F 
X-CRM114-Status: GOOD (  11.36  )
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

CuWcqCAyMDIyLzcvMjYg5LiL5Y2INTo0MiwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g5YaZ
6YGTOgo+IE9uIDI2LzA3LzIwMjIgMTA6MjgsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQo+Pgo+PiDlnKggMjAyMi83LzI2IOS4i+WNiDQ6
MTYsIFhpYW50aW5nIFRpYW4g5YaZ6YGTOgo+Pj4g5ZyoIDIwMjIvNy8yNiDkuIvljYg0OjAxLCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSDlhpnpgZM6Cj4+Pj4gT24gMjYvMDcvMjAyMiAwODo1
NCwgdGlhbnhpYW50aW5nIHdyb3RlOgo+Pj4+PiDlnKggMjAyMi83LzI2IOS4iuWNiDE6MTMsIENv
bm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIOWGmemBkzoKPj4+Pj4+IFRoYXQgc2FpZCwgdGhpcyBk
b2VzIG5vdCBhcHBseSB0byByaXNjdi9mb3ItbmV4dDoKPj4+Pj4+IGI0IHNoYXphbSAyMDIyMDcy
NTAxNDUzOS4xMDM3NjI3LTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbQo+Pj4+Pj4g
R3JhYmJpbmcgdGhyZWFkIGZyb20KPj4+Pj4+IGxvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA3MjUw
MTQ1MzkuMTAzNzYyNy0xLXhpYW50aW5nLnRpYW4lNDBsaW51eC5hbGliYWJhLmNvbS90Lm1ib3gu
Z3oKPj4+Pj4+IENoZWNraW5nIGZvciBuZXdlciByZXZpc2lvbnMgb24gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLwo+Pj4+Pj4gQW5hbHl6aW5nIDYgbWVzc2FnZXMgaW4gdGhlIHRocmVhZAo+
Pj4+Pj4gQ2hlY2tpbmcgYXR0ZXN0YXRpb24gb24gYWxsIG1lc3NhZ2VzLCBtYXkgdGFrZSBhIG1v
bWVudC4uLgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgwqDCoMKgIFtQQVRDSCB2MiAxLzVdIFJJU0MtVjog
dXNlIF9fc21wX3Byb2Nlc3Nvcl9pZCgpIGluc3RlYWQgb2YKPj4+Pj4+IHNtcF9wcm9jZXNzb3Jf
aWQoKQo+Pj4+Pj4gIMKgwqDCoCBbUEFUQ0ggdjIgMi81XSBSSVNDLVY6IEFkZCBhcmNoX2NyYXNo
X3NhdmVfdm1jb3JlaW5mbyBzdXBwb3J0Cj4+Pj4+PiAgwqDCoMKgIFtQQVRDSCB2MiAzLzVdIHJp
c2N2OiBBZGQgbW9kdWxlcyB0byB2aXJ0dWFsIGtlcm5lbCBtZW1vcnkKPj4+Pj4+IGxheW91dCBk
dW1wCj4+Pj4+PiAgwqDCoMKgIFtQQVRDSCB2MiA0LzVdIFJJU0MtVjogRml4dXAgZ2V0dGluZyBj
b3JyZWN0IGN1cnJlbnQgcGMKPj4+Pj4+ICDCoMKgwqAgW1BBVENIIHYyIDUvNV0gcmlzY3Y6IGNy
YXNoX2NvcmU6IEV4cG9ydCBrZXJuZWwgdm0gbGF5b3V0LAo+Pj4+Pj4gcGh5c19yYW1fYmFzZQo+
Pj4+Pj4gLS0tCj4+Pj4+PiBUb3RhbCBwYXRjaGVzOiA1Cj4+Pj4+PiAtLS0KPj4+Pj4+IEFwcGx5
aW5nOiBSSVNDLVY6IHVzZSBfX3NtcF9wcm9jZXNzb3JfaWQoKSBpbnN0ZWFkIG9mCj4+Pj4+PiBz
bXBfcHJvY2Vzc29yX2lkKCkKPj4+Pj4+IEFwcGx5aW5nOiBSSVNDLVY6IEFkZCBhcmNoX2NyYXNo
X3NhdmVfdm1jb3JlaW5mbyBzdXBwb3J0Cj4+Pj4+PiBQYXRjaCBmYWlsZWQgYXQgMDAwMiBSSVND
LVY6IEFkZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbyBzdXBwb3J0Cj4+Pj4+IHBhdGNoIDIg
YXBwbHkgaXMgT0sgZm9yIG1lLCBJIGRvbid0IGtub3cgd2h5IHlvdSBmYWlsZWQgOigKPj4+Pj4g
RG8geW91IGhhdmUgbW9yZSBkZXRhbHMgZm9yIHRoaXM/Cj4+Pj4+Cj4+Pj4gV2hhdCBkaWQgeW91
IGFwcGx5IGl0IHRvPyBJdCBkb2VzIG5vdCBhcHBseSBmb3IgbWUgdG8gcmlzY3YvZm9yLW5leHQ6
Cj4+Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmlz
Y3YvbGludXguZ2l0L2xvZy8/aD1mb3ItbmV4dAo+Pj4+Cj4+PiBUaGlzIDUgcGF0Y2hlcyBhcmUg
YmFzZWQgb24gdGhlIG1hc3RlciBicmFuY2ggb2YgYmVsb3cgZ2l0Ogo+Pj4KPj4+IGh0dHBzOi8v
a2VybmVsLmdvb2dsZXNvdXJjZS5jb20vcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdAo+Pj4KPj4+Cj4+PiAiZ2l0IGFtIDAwMDItUklTQy1WLUFkZC1hcmNoX2NyYXNo
X3NhdmVfdm1jb3JlaW5mby1zdXBwb3J0LnBhdGNoIiB0bwo+Pj4gdGhpcyBnaXQgaXMgb2sgZm9y
IG1lLgo+Pj4KPj4+IEFsbCBpcyBjb3JyZWN0Pwo+PiBJIGZpZ3VyZWQgb3V0IHRoZSByZWFzb24s
IHRoZXJlIGlzIG9uZSBkaWZmZXJlbmNlIGluCj4+IGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxl
IGJldHdlZW4gcmlzY3YvZm9yLW5leHQgYW5kIHRvcnZhbGRzL2xpbnV4Lgo+Pgo+PiBGb3Igcmlz
Y3YvZm9yLW5leHQsIGluIGxpbmUgODEgb2YgYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUsIGl0
IGlzOgo+Pgo+PiAgIMKgwqDCoCBvYmotJChDT05GSUdfS0VYRUMpwqDCoMKgwqDCoMKgwqAgKz0g
a2V4ZWNfcmVsb2NhdGUubyBjcmFzaF9zYXZlX3JlZ3Mubwo+PiBtYWNoaW5lX2tleGVjLm8KPj4K
Pj4gQnV0IGZvciB0b3J2YWxkcy9saW51eCwgaW4gbGluZSA4MSBvZiBhcmNoL3Jpc2N2L2tlcm5l
bC9NYWtlZmlsZSwgaXQgaXM6Cj4+Cj4+ICAgwqDCoMKgIG9iai0kKENPTkZJR19LRVhFQ19DT1JF
KcKgwqDCoMKgwqDCoMKgICs9IGtleGVjX3JlbG9jYXRlLm8KPj4gY3Jhc2hfc2F2ZV9yZWdzLm8g
bWFjaGluZV9rZXhlYy5vCj4+Cj4+IHRvcnZhbGRzL2xpbnV4IGlzIG5ld2VyIHRoYW4gcmlzY3Yv
Zm9yLW5leHQswqAgY29tbWl0IDNhNjZhMDg3NTkKPj4gKCJSSVNDLVY6IGtleGVjOiBGaXggYnVp
bGQgZXJyb3Igd2l0aG91dCBDT05GSUdfS0VYRUMiKSBhZGRlZAo+PiAiQ09ORklHX0tFWEVDX0NP
UkUiIGZvciB0b3J2YWxkcy9saW51eCwgQnV0IHJpc2N2L2Zvci1uZXh0Cj4+Cj4+IGRvZXNuJ3Qg
Y29udGFpbiB0aGUgY29tbWl0Lgo+IEFoIHJpZ2h0LCBzaW5jZSBpdCdzIGxhdGUgaW4gdGhlIGN5
Y2xlIChtdyBpcyBuZXh0IHdlZWspIG1heWJlCj4gaXQncyBiZXN0IHRvIHdhaXQgZm9yIHJjMSB0
aGVuIGFuZCByZWJhc2Ugd2hlbiBmb3ItbmV4dCAmIGZpeGVzCj4gaGF2ZSBiZWVuIHN5bmNlZC4g
Q29uZmxpY3QgZG9lc24ndCBzZWVtIHRvIGhhcmQgdG8gc29ydCBvdXQgZm9yCj4gdGhvc2Ugd2hv
IHVzZSBrZXhlYyA7KQpPa2F5LCB0aGFua3MuCj4KPiBUaGFua3MsCj4gQ29ub3IuCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC9BC25B07
	for <kexec@archiver.kernel.org>; Thu, 11 Aug 2022 02:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9rafzVeDbDmKWjrBFBa3cJpBJfGjNCZiHAPKfnN38+E=; b=zdt70Zz4Sdvs8XSXc1f2nrSva8
	DqPNOI2E5RQQuXKp6PC7bInaI5hQfDgXbz7EjA7RhUwsC0vkStm2Lfx5CRb7x6N2NXJPYW/LiTpHz
	3G5PpynIPMApGr6rE4jWB6ax8WXZ/bUSlbzrhIWzhWPuWXdT/M7ce2UZGm7+gqOYl499uI/IGZ9yF
	w+wjASJ4J1Clko/b5ES0R0sIAYsUr2DuUjmFZ0zhHr8yk/wYgslHnJ5etNPBgX1n6k0qh1y+VTdPj
	s6Gb5pzRrTEF9wk2gRAe6KKidsMXB9UY0Kjtc8c1d3Z9lIBjRmppHZTEBZJDqqSHe+9d3+jU9fpzh
	RrxiXaAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyLC-004MI1-OL; Thu, 11 Aug 2022 02:54:34 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLyL8-004M7F-Ev; Thu, 11 Aug 2022 02:54:32 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VLxOlmu_1660186462;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VLxOlmu_1660186462)
          by smtp.aliyun-inc.com;
          Thu, 11 Aug 2022 10:54:23 +0800
Subject: Re: [PATCH V5 0/6] RISC-V fixups to work with crash tool
To: Conor.Dooley@microchip.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
 guoren@kernel.org, mick@ics.forth.gr, alexandre.ghiti@canonical.com,
 bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
 heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20220802121818.2201268-1-xianting.tian@linux.alibaba.com>
 <b79ab47e-a1e2-eb21-0611-bcbc8b7802c5@linux.alibaba.com>
 <b3184653-7ef4-eec3-9ef6-a8449fe24323@microchip.com>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <5afbd9b6-37c5-8a8d-6fdf-bca721ebd25e@linux.alibaba.com>
Date: Thu, 11 Aug 2022 10:54:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b3184653-7ef4-eec3-9ef6-a8449fe24323@microchip.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_195430_714735_F1D34A9C 
X-CRM114-Status: GOOD (  17.27  )
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

CuWcqCAyMDIyLzgvMTAg5LiK5Y2INToyNCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20g5YaZ
6YGTOgo+IE9uIDA5LzA4LzIwMjIgMDc6NTgsIFhpYW50aW5nIFRpYW4gd3JvdGU6Cj4+IEhpIFBh
bG1lcgo+Pgo+PiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2ggc2V0P8Kg
IHRoYW5rcy4KPiBIZXkgWGlhbnRpbmcsCj4KPiBPYnZpb3VzbHkgSSBhbSBub3QgUGFsbWVyLCBi
dXQgSSBsZWZ0IHNvbWUgY29tbWVudHMgb24gdGhlCj4gcGF0Y2hzZXQuIFNvcnJ5IGZvciB0aGUg
ZGVsYXkgaW4gZ2V0dGluZyBiYWNrIG9udG8geW91IG9uIHlvdXIKPiBsYXRlc3QgdmVyc2lvbiwg
SSBnb3QgY29uZnVzZWQgYXMgdG8gd2hpY2ggdmVyc2lvbnMgSSBoYWQgcmV2aWV3ZWQuCgpZb3Ug
ZXZlciByZXZpZXdlZCB0aGlzIHZlcnNpb24gcGF0Y2ggc2V0LAoKaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDIyMDcyNTAxNDUzOS4xMDM3NjI3LTEteGlhbnRpbmcudGlhbkBsaW51eC5h
bGliYWJhLmNvbS8gCjxodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIwNzI1MDE0NTM5
LjEwMzc2MjctMS14aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLz4KCj4KPiBDb25vci4K
Pgo+PiAgIAo+PiBDcmFzaC11dGlsaXR5IHBhdGNoIHNldCBpcyByZWFkeShhY2tlZCBieSBIQUdJ
TyBLQVpVSElUTyksIG5vdyB3YWl0aW5nIHRoZSBrZXJuZWwgcGF0Y2ggc2V0IG1lcmdlZCBmaXJz
dGx5Lgo+Pgo+PiDlnKggMjAyMi84LzIg5LiL5Y2IODoxOCwgWGlhbnRpbmcgVGlhbiDlhpnpgZM6
Cj4+PiBJIGV2ZXIgc2VudCB0aGUgcGF0Y2ggMSBpbiB0aGUgbGluazoKPj4+IGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yaXNjdi9wYXRjaC8yMDIyMDcwODA3MzE1
MC4zNTI4MzAtMy14aWFudGluZy50aWFuQGxpbnV4LmFsaWJhYmEuY29tLwo+Pj4gQW5kIHBhdGNo
IDIsMyBpbiB0aGUgbGluazoKPj4+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1yaXNjdi9wYXRjaC8yMDIyMDcxNDExMzMwMC4zNjc4NTQtMi14aWFudGluZy50aWFu
QGxpbnV4LmFsaWJhYmEuY29tLwo+Pj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LXJpc2N2L3BhdGNoLzIwMjIwNzE0MTEzMzAwLjM2Nzg1NC0zLXhpYW50aW5nLnRp
YW5AbGludXguYWxpYmFiYS5jb20vCj4+Pgo+Pj4gVGhpcyBwYXRjaCBzZXQganVzdCBwdXQgdGhl
c2UgcGF0Y2hlcyB0b2dldGhlciwgYW5kIHdpdGggdGhyZWUgbmV3IHBhdGNoIDQsIDUsIDYuCj4+
PiB0aGVzZSBzaXggcGF0Y2hlcyBhcmUgdGhlIGZpeHVwcyBmb3IgbWFjaGluZV9rZXhlYywga2Vy
bmVsIG1vZGUgUEMgZm9yIHZtY29yZQo+Pj4gYW5kIGltcHJvdmVtZW50cyBmb3Igdm1jb3JlaW5m
bywgbWVtb3J5IGxheW91dCBkdW1wIGFuZCBmaXh1cCBjaGVkdWxlIG91dCBpc3N1ZQo+Pj4gaW4g
bWFjaGluZV9jcmFzaF9zaHV0ZG93bigpLgo+Pj4KPj4+IFRoZSBtYWluIGNoYW5nZXMgaW4gdGhl
IHNpeCBwYXRjaHMgYXMgYmVsb3csCj4+PiBQYXRjaCAxOiB1c2UgX19zbXBfcHJvY2Vzc29yX2lk
KCkgaW5zdGVhZCBvZiBzbXBfcHJvY2Vzc29yX2lkKCkgdG8gY2xlYW51cAo+Pj4gIMKgwqDCoMKg
wqDCoMKgwqDCoCB0aGUgY29uc29sZSBwcmludHMuCj4+PiBQYXRjaCAyOiBBZGQgVk0gbGF5b3V0
LCB2YSBiaXRzLCByYW0gYmFzZSB0byB2bWNvcmVpbmZvLCB3aGljaCBjYW4gc2ltcGxpZnkKPj4+
ICDCoMKgwqDCoMKgwqDCoMKgwqAgdGhlIGRldmVsb3BtZW50IG9mIGNyYXNoIHRvb2wgYXMgQVJN
NjQgYWxyZWFkeSBkaWQKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgKGFyY2gvYXJtNjQva2VybmVs
L2NyYXNoX2NvcmUuYykuCj4+PiBQYXRjaCAzOiBBZGQgbW9kdWxlcyB0byB2aXJ0dWFsIGtlcm5l
bCBtZW1vcnkgbGF5b3V0IGR1bXAuCj4+PiBQYXRjaCA0OiBGaXh1cCB0byBnZXQgY29ycmVjdCBr
ZXJuZWwgbW9kZSBQQyBmb3Igdm1jb3JlLgo+Pj4gUGF0Y2ggNTogVXBkYXRlcyB2bWNvcmVpbmZv
LnJzdC4KPj4+IFBhdGNoIDY6IEZpeHVwIHNjaGVkdWxlIG91dCBpc3N1ZSBpbiBtYWNoaW5lX2Ny
YXNoX3NodXRkb3duKCkKPj4+Cj4+PiBXaXRoIHRoZXNlIHNpeCBwYXRjaGVzKHBhdGNoIDIgaXMg
bXVzdCksIGNyYXNoIHRvb2wgY2FuIHdvcmsgd2VsbCB0byBhbmFseXplCj4+PiBhIHZtY29yZS4g
VGhlIHBhdGNoZXMgZm9yIGNyYXNoIHRvb2wgZm9yIFJJU0NWNjQgaXMgaW4gdGhlIGxpbms6Cj4+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yaXNjdi8yMDIyMDgwMTA0MzA0MC4yMDAz
MjY0LTEteGlhbnRpbmcudGlhbkBsaW51eC5hbGliYWJhLmNvbS8KPj4+Cj4+PiAtLS0tLS0KPj4+
IENoYW5nZXMgdjEgLT4gdjI6Cj4+PiAgwqAgMSwgcmVtb3ZlIHRoZSBwYXRjaCAiQWRkIGEgZmFz
dCBjYWxsIHBhdGggb2YgY3Jhc2hfa2V4ZWMoKSIgZnJvbSB0aGlzIHNlcmllcwo+Pj4gIMKgIG9m
IHBhdGNoZXMsIGFzIGl0IGFscmVhZHkgYXBwbGllZCB0byByaXNjdiBnaXQuCj4+PiAgwqAgaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmlzY3YvbGludXgu
Z2l0L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD0zZjE5MDExMTBhODliMGUyZTEzYWRiMmFjOGQxYTcx
MDI4NzllYTk4Cj4+PiAgwqAgMiwgYWRkICdSZXZpZXdlZC1ieScgYmFzZWQgb24gdGhlIGNvbW1l
bnRzIG9mIHYxLgo+Pj4gQ2hhbmdlcyB2MiAtPiB2MzoKPj4+ICDCoCB1c2UgInJpc2N2IiBpbnN0
ZWFkIG9mICJyaXNjdjY0IiBpbiBwYXRjaCA1IHN1YmplY3QgbGluZS4KPj4+IENoYW5nZXMgdjMg
LT4gdjQ6Cj4+PiAgwqAgdXNlICJyaXNjdiIgaW5zdGVhZCBvZiAicmlzY3Y2NCIgaW4gdGhlIHN1
bW1hcnkgb2YgcGF0Y2ggNSBzdWJqZWN0IGxpbmUuCj4+PiBDaGFuZ2VzIHY0IC0+IHY1Ogo+Pj4g
IMKgIGFkZCBhIG5ldyBwYXRjaCAiUklTQy1WOiBGaXh1cCBzY2hlZHVsZSBvdXQgaXNzdWUgaW4g
bWFjaGluZV9jcmFzaF9zaHV0ZG93bigpIgo+Pj4KPj4+IFhpYW50aW5nIFRpYW4gKDYpOgo+Pj4g
IMKgwqAgUklTQy1WOiB1c2UgX19zbXBfcHJvY2Vzc29yX2lkKCkgaW5zdGVhZCBvZiBzbXBfcHJv
Y2Vzc29yX2lkKCkKPj4+ICDCoMKgIFJJU0MtVjogQWRkIGFyY2hfY3Jhc2hfc2F2ZV92bWNvcmVp
bmZvIHN1cHBvcnQKPj4+ICDCoMKgIHJpc2N2OiBBZGQgbW9kdWxlcyB0byB2aXJ0dWFsIGtlcm5l
bCBtZW1vcnkgbGF5b3V0IGR1bXAKPj4+ICDCoMKgIFJJU0MtVjogRml4dXAgZ2V0dGluZyBjb3Jy
ZWN0IGN1cnJlbnQgcGMKPj4+ICDCoMKgIHJpc2N2OiBjcmFzaF9jb3JlOiBFeHBvcnQga2VybmVs
IHZtIGxheW91dCwgcGh5c19yYW1fYmFzZQo+Pj4gIMKgwqAgUklTQy1WOiBGaXh1cCBzY2hlZHVs
ZSBvdXQgaXNzdWUgaW4gbWFjaGluZV9jcmFzaF9zaHV0ZG93bigpCj4+Pgo+Pj4gIMKgIC4uLi9h
ZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMxICsr
KysrKysrKysrKysrKysrKysKPj4+ICDCoCBhcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPj4+ICDCoCBhcmNoL3Jp
c2N2L2tlcm5lbC9jcmFzaF9jb3JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAy
OSArKysrKysrKysrKysrKysrKwo+Pj4gIMKgIGFyY2gvcmlzY3Yva2VybmVsL2NyYXNoX3NhdmVf
cmVncy5TwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0KPj4+ICDCoCBhcmNoL3Jpc2N2L2tl
cm5lbC9tYWNoaW5lX2tleGVjLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyOCArKysrKysr
KysrKysrKy0tLQo+Pj4gIMKgIGFyY2gvcmlzY3YvbW0vaW5pdC5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDQgKysrCj4+PiAgwqAgNiBmaWxl
cyBjaGFuZ2VkLCA4OSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pj4gIMKgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMKPj4+CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C300BC4332F
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 02:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vGIc2mD+Dt4P091bKptHnwyHdjZtNWKpCpnk2CWhYtw=; b=b3esmmzkd8oevq
	vxM6YX4Ja1YotgXORcpP3vrdH6+uvH0jvLel1Yrs4HsTYBmGvedVsX4YPHfU4xAXOFLibrZy/3ZI3
	Tug2J9/37v7y5HQawpnX0dpTOZ8ULNWmuhJXi5OGEOdAw3A9k3vQVVddqN3L65wlklwQ256h2DG8W
	MsGAaF5e/I79XjWPtFwp2qqiAVgtbXGOhIrNkwR3HqDeuoapZ6+m9YNQ4q5C2u8h8HisF/VkAFDd9
	zCvpHBvGYwsLpMZW7txKUKz1PaZXnDffTF/TV6uwrbQEQWeG98FUq7gnJ+TY0vWcovbJtmdHme6PB
	aCyiw6q8SQfUFtGY8uXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okcYP-001WTd-Ig; Tue, 18 Oct 2022 02:42:05 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okcYN-001W45-4R; Tue, 18 Oct 2022 02:42:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSSPzYT_1666060910;
Received: from 30.221.96.155(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSSPzYT_1666060910)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 10:41:52 +0800
Message-ID: <a4d2dc7e-7f45-00b7-6c31-cc934ba9c1f5@linux.alibaba.com>
Date: Tue, 18 Oct 2022 10:41:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To: Conor Dooley <conor@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 bagasdotme@gmail.com, kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y02vm7FrhdEoSXZ+@spud>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y02vm7FrhdEoSXZ+@spud>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_194203_369271_01463DD6 
X-CRM114-Status: GOOD (  14.43  )
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

CuWcqCAyMDIyLzEwLzE4IOS4iuWNiDM6NDAsIENvbm9yIERvb2xleSDlhpnpgZM6Cj4gT24gRnJp
LCBPY3QgMTQsIDIwMjIgYXQgMDk6NDE6MzlQTSArMDgwMCwgWGlhbnRpbmcgVGlhbiB3cm90ZToK
Pj4gVGhlIGZvbGxvd2luZyBpbnRlcnJlbGF0ZWQgZGVmaW5pdGlvbnMgYW5kIHJhbmdlcyBhcmUg
bmVlZGVkIGJ5IHRoZSBrZHVtcAo+PiBjcmFzaCB0b29sLCB0aGV5IGFyZSBleHBvcnRlZCBieSAi
YXJjaC9yaXNjdi9rZXJuZWwvY3Jhc2hfY29yZS5jIjoKPj4gICAgICBWQV9CSVRTLAo+PiAgICAg
IFBBR0VfT0ZGU0VULAo+PiAgICAgIHBoeXNfcmFtX2Jhc2UsCj4+ICAgICAgTU9EVUxFU19WQURE
UiB+IE1PRFVMRVNfRU5ELAo+PiAgICAgIFZNQUxMT0NfU1RBUlQgfiBWTUFMTE9DX0VORCwKPj4g
ICAgICBWTUVNTUFQX1NUQVJUIH4gVk1FTU1BUF9FTkQsCj4+ICAgICAgS0FTQU5fU0hBRE9XX1NU
QVJUIH4gS0FTQU5fU0hBRE9XX0VORCwKPj4gICAgICBLRVJORUxfTElOS19BRERSIH4gQUREUkVT
U19TUEFDRV9FTkQKPj4KPj4gRG9jdW1lbnQgdGhlc2UgUklTQ1Y2NCBleHBvcnRzIGFib3ZlLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFs
aWJhYmEuY29tPgo+PiAtLS0KPj4gICAuLi4vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5y
c3QgICAgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDMwIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2R1bXAvdm1jb3JlaW5mby5yc3QgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tk
dW1wL3ZtY29yZWluZm8ucnN0Cj4+IGluZGV4IDY3MjZmNDM5OTU4Yy4uOGUyZTE2NGNmM2RiIDEw
MDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8u
cnN0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5y
c3QKPj4gQEAgLTU5NSwzICs1OTUsMzMgQEAgWDJUTEIKPj4gICAtLS0tLQo+PiAgIAo+PiAgIElu
ZGljYXRlcyB3aGV0aGVyIHRoZSBjcmFzaGVkIGtlcm5lbCBlbmFibGVkIFNIIGV4dGVuZGVkIG1v
ZGUuCj4+ICsKPj4gK1JJU0NWNjQKPj4gKz09PT09PT0KPj4gKwo+PiArVkFfQklUUwo+PiArLS0t
LS0tLQo+PiArCj4+ICtUaGUgbWF4aW11bSBudW1iZXIgb2YgYml0cyBmb3IgdmlydHVhbCBhZGRy
ZXNzZXMuIFVzZWQgdG8gY29tcHV0ZSB0aGUKPj4gK3ZpcnR1YWwgbWVtb3J5IHJhbmdlcy4KPj4g
Kwo+PiArUEFHRV9PRkZTRVQKPj4gKy0tLS0tLS0tLS0tCj4+ICsKPj4gK0luZGljYXRlcyB0aGUg
dmlydHVhbCBrZXJuZWwgc3RhcnQgYWRkcmVzcyBvZiBkaXJlY3QtbWFwcGVkIFJBTSByZWdpb24u
Cj4gQXBvbG9naWVzIGZvciBub3Qgc2VlaW5nIHRoaXMgc29vbmVyLCBidXQgc2hvdWxkIHRoZXJl
IG5vdCBiZSBhICJ0aGUiCj4gcHJpb3IgdG8gImRpcmVjdC1tYXBwZWQiPwp3aWxsIGZpeCBpbiB2
Mwo+Cj4+ICsKPj4gK3BoeXNfcmFtX2Jhc2UKPj4gKy0tLS0tLS0tLS0tLS0KPj4gKwo+PiArSW5k
aWNhdGVzIHRoZSBzdGFydCBwaHlzaWNhbCBSQU0gYWRkcmVzcy4KPj4gKwo+PiArTU9EVUxFU19W
QUREUnxNT0RVTEVTX0VORHxWTUFMTE9DX1NUQVJUfFZNQUxMT0NfRU5EfFZNRU1NQVBfU1RBUlR8
Vk1FTU1BUF9FTkR8S0FTQU5fU0hBRE9XX1NUQVJUfEtBU0FOX1NIQURPV19FTkR8S0VSTkVMX0xJ
TktfQUREUnxBRERSRVNTX1NQQUNFX0VORAo+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+PiArCj4+ICtVc2VkIHRvIGdldCB0aGUgY29ycmVjdCByYW5nZXM6Cj4+ICsKPj4g
KyAgKiBNT0RVTEVTX1ZBRERSIH4gTU9EVUxFU19FTkQgOiBLZXJuZWwgbW9kdWxlIHNwYWNlLgo+
PiArICAqIFZNQUxMT0NfU1RBUlQgfiBWTUFMTE9DX0VORCA6IHZtYWxsb2MoKSAvIGlvcmVtYXAo
KSBzcGFjZS4KPj4gKyAgKiBWTUVNTUFQX1NUQVJUIH4gVk1FTU1BUF9FTkQgOiB2bWVtbWFwIHJl
Z2lvbiwgdXNlZCBmb3Igc3RydWN0IHBhZ2UgYXJyYXkuCj4gU2luY2UgSSdtIGluIHBlZGFudCBt
b2RlLCBpdCBkb2VzIGxvb2sgYSBsaXR0bGUgb2RkIHRoYXQgeW91J3JlIHVzaW5nCj4gcmVnaW9u
IGZvciB2bWVtbWFwIGJ1dCBzcGFjZSBmb3IgdGhlIG90aGVycyBidXQgaWRjIHRoYXQgbXVjaC4K
ClNvcnJ5LCBJIGRpZG4ndCBnZXQgeW91ciBwb2ludCA6KAoKaXQgY29udGFpbnMgdm1lbW1hcCBh
cmVhIHdpdGggcmVmZXJlbmNlIHd0aCBhcmNoL2FybTY0L2tlcm5lbC9jcmFzaF9jb3JlLmMuCgo+
Cj4gVGhhbmtzLAo+IENvbm9yLgo+Cj4+ICsgICogS0FTQU5fU0hBRE9XX1NUQVJUIH4gS0FTQU5f
U0hBRE9XX0VORCA6IGthc2FuIHNoYWRvdyBzcGFjZS4KPj4gKyAgKiBLRVJORUxfTElOS19BRERS
IH4gQUREUkVTU19TUEFDRV9FTkQgOiBLZXJuZWwgbGluayBhbmQgQlBGIHNwYWNlLgo+PiAtLSAK
Pj4gMi4xNy4xCj4+Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

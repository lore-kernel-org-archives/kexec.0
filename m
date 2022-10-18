Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA1FFC433FE
	for <kexec@archiver.kernel.org>; Tue, 18 Oct 2022 05:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CbddWzyh8yXAPfSouZgMn5x58O977UarZC1cG9c7pN4=; b=lfZNXMChLuxGFt
	mrYVnXCCHJdNjrJLJNMiraYRjmgEjyVHOvhhuLbHgfvM19mLSb3w0ZWEHIPIlEOunUE0JXKlL1jT/
	2PTKMiUEceMJSQoBG8UM9wP1bFFbYX7ZRFr5aT57bGecKDl0aF7JxRWXa9BytJ00aKVS1uKe29VIi
	HHsWwjjXQDPgHfQwEwpO34SomF5GOSEWY1ZEGFw+JRub5/PJ5hBvdxfAbbJk+gCFbruBEINDWsfoN
	vU7fH6fY9kILUgrCVLQ7uA8V/SmYrwgSlSr/2KqynzHvH9oSYel9SUZrzrIg+QmpG2OArNkfEJ+aZ
	kpA/drWFLlCv3qy9KFUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okfDt-002kT9-Ux; Tue, 18 Oct 2022 05:33:05 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okfDq-002kSh-I5; Tue, 18 Oct 2022 05:33:04 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0VSTEQpA_1666071173;
Received: from 30.221.96.155(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSTEQpA_1666071173)
          by smtp.aliyun-inc.com;
          Tue, 18 Oct 2022 13:32:55 +0800
Message-ID: <f872ec97-89d8-16ca-b0ff-a2d713d72b85@linux.alibaba.com>
Date: Tue, 18 Oct 2022 13:32:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V2 2/2] Documentation: kdump: describe VMCOREINFO export
 for RISCV64
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
 k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014134139.5151-1-xianting.tian@linux.alibaba.com>
 <20221014134139.5151-3-xianting.tian@linux.alibaba.com>
 <Y04bOv49sRsauLb6@debian.me>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y04bOv49sRsauLb6@debian.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_223302_808978_42E6A014 
X-CRM114-Status: GOOD (  10.41  )
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

CuWcqCAyMDIyLzEwLzE4IOS4iuWNiDExOjE5LCBCYWdhcyBTYW5qYXlhIOWGmemBkzoKPiBPbiBG
cmksIE9jdCAxNCwgMjAyMiBhdCAwOTo0MTozOVBNICswODAwLCBYaWFudGluZyBUaWFuIHdyb3Rl
Ogo+PiBUaGUgZm9sbG93aW5nIGludGVycmVsYXRlZCBkZWZpbml0aW9ucyBhbmQgcmFuZ2VzIGFy
ZSBuZWVkZWQgYnkgdGhlIGtkdW1wCj4+IGNyYXNoIHRvb2wsIHRoZXkgYXJlIGV4cG9ydGVkIGJ5
ICJhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMiOgo+IEJldHRlciBzYXkgIi4uLiwgd2hp
Y2ggYXJlIGV4cG9ydGVkIGJ5IC4uLiIKCndpbGwgZml4IGl0IGluIHYzCgp0aGFua3MKCj4KPj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5y
c3QgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0Cj4+IGlu
ZGV4IDY3MjZmNDM5OTU4Yy4uOGUyZTE2NGNmM2RiIDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tkdW1wL3ZtY29yZWluZm8ucnN0Cj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5yc3QKPj4gQEAgLTU5NSwzICs1OTUsMzMg
QEAgWDJUTEIKPj4gICAtLS0tLQo+PiAgIAo+PiAgIEluZGljYXRlcyB3aGV0aGVyIHRoZSBjcmFz
aGVkIGtlcm5lbCBlbmFibGVkIFNIIGV4dGVuZGVkIG1vZGUuCj4+ICsKPj4gK1JJU0NWNjQKPj4g
Kz09PT09PT0KPj4gKwo+PiArVkFfQklUUwo+PiArLS0tLS0tLQo+PiArCj4+ICtUaGUgbWF4aW11
bSBudW1iZXIgb2YgYml0cyBmb3IgdmlydHVhbCBhZGRyZXNzZXMuIFVzZWQgdG8gY29tcHV0ZSB0
aGUKPj4gK3ZpcnR1YWwgbWVtb3J5IHJhbmdlcy4KPj4gKwo+PiArUEFHRV9PRkZTRVQKPj4gKy0t
LS0tLS0tLS0tCj4+ICsKPj4gK0luZGljYXRlcyB0aGUgdmlydHVhbCBrZXJuZWwgc3RhcnQgYWRk
cmVzcyBvZiBkaXJlY3QtbWFwcGVkIFJBTSByZWdpb24uCj4+ICsKPj4gK3BoeXNfcmFtX2Jhc2UK
Pj4gKy0tLS0tLS0tLS0tLS0KPj4gKwo+PiArSW5kaWNhdGVzIHRoZSBzdGFydCBwaHlzaWNhbCBS
QU0gYWRkcmVzcy4KPj4gKwo+PiArTU9EVUxFU19WQUREUnxNT0RVTEVTX0VORHxWTUFMTE9DX1NU
QVJUfFZNQUxMT0NfRU5EfFZNRU1NQVBfU1RBUlR8Vk1FTU1BUF9FTkR8S0FTQU5fU0hBRE9XX1NU
QVJUfEtBU0FOX1NIQURPV19FTkR8S0VSTkVMX0xJTktfQUREUnxBRERSRVNTX1NQQUNFX0VORAo+
PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiArCj4+ICtVc2VkIHRvIGdl
dCB0aGUgY29ycmVjdCByYW5nZXM6Cj4+ICsKPj4gKyAgKiBNT0RVTEVTX1ZBRERSIH4gTU9EVUxF
U19FTkQgOiBLZXJuZWwgbW9kdWxlIHNwYWNlLgo+PiArICAqIFZNQUxMT0NfU1RBUlQgfiBWTUFM
TE9DX0VORCA6IHZtYWxsb2MoKSAvIGlvcmVtYXAoKSBzcGFjZS4KPj4gKyAgKiBWTUVNTUFQX1NU
QVJUIH4gVk1FTU1BUF9FTkQgOiB2bWVtbWFwIHJlZ2lvbiwgdXNlZCBmb3Igc3RydWN0IHBhZ2Ug
YXJyYXkuCj4+ICsgICogS0FTQU5fU0hBRE9XX1NUQVJUIH4gS0FTQU5fU0hBRE9XX0VORCA6IGth
c2FuIHNoYWRvdyBzcGFjZS4KPj4gKyAgKiBLRVJORUxfTElOS19BRERSIH4gQUREUkVTU19TUEFD
RV9FTkQgOiBLZXJuZWwgbGluayBhbmQgQlBGIHNwYWNlLgo+IFRoZSBkb2N1bWVudGF0aW9uIExH
VE0sIHRoYW5rcy4KPgo+IFdoZW4gdGhlIHBhdGNoIHN1YmplY3QgaXMgZml4ZWQsCj4KPiBSZXZp
ZXdlZC1ieTogQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+Cj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK

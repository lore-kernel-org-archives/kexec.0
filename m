Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A01C4332F
	for <kexec@archiver.kernel.org>; Thu, 20 Oct 2022 04:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v/ar2L9SpqBXEOfao7Qg5jKycOCWnu6ytODcmVf4Ig0=; b=CTrt1lSqcdWwKE
	cTcCCTKNW9Kp/PYTAKO2TmojYwKG/OG29hBs5sfQUcHjxRyQ9y1YtfzBQSaW5R62sZu/ywtWVcu3d
	qhuJ1/0YFllaHT7ORDlwoWykWDHJxfzyntMs5EfOD/becKZHqdCaVlRjdAuuJg4d34vQDA7Ehzt9T
	OqxIqa4SRA9Al0SMkvjo7MBdRtiQ6WpTbeboMgx+U6Zy0/Fh0iEg91bJxAgVlKLQ1KK76Oi39vAJg
	hvRZC/c2qxF9Vk9Vuh6uMO+A9eheFl/pakIWyeMQiOjkSBdbrCebowcGIYU5GCWUDhBhZOUEGf1/w
	cgHvGhYd10buVNREgLVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olNNM-00AHR4-NN; Thu, 20 Oct 2022 04:41:48 +0000
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olNNJ-00AHIC-4h; Thu, 20 Oct 2022 04:41:47 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSdd-XS_1666240825;
Received: from 30.221.97.125(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSdd-XS_1666240825)
          by smtp.aliyun-inc.com;
          Thu, 20 Oct 2022 12:40:27 +0800
Message-ID: <6af05838-fa58-8197-f3ce-ca95457077a7@linux.alibaba.com>
Date: Thu, 20 Oct 2022 12:40:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V4 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To: Baoquan He <bhe@redhat.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 anup@brainfault.org, heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, vgoyal@redhat.com, dyoung@redhat.com,
 corbet@lwn.net, Conor.Dooley@microchip.com, bagasdotme@gmail.com,
 k-hagio-ab@nec.com, lijiang@redhat.com, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 heinrich.schuchardt@canonical.com, hschauhan@nulltrace.org,
 yixun.lan@gmail.com
References: <20221019103623.7008-1-xianting.tian@linux.alibaba.com>
 <20221019103623.7008-2-xianting.tian@linux.alibaba.com>
 <Y1CtreAKT/SEh4vN@MiWiFi-R3L-srv>
 <30621b3b-47ba-d612-cfb0-583d779691a3@linux.alibaba.com>
 <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
From: Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <Y1C681H2mlxX+zqf@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_214145_397487_2E416E56 
X-CRM114-Status: GOOD (  13.28  )
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

CuWcqCAyMDIyLzEwLzIwIOS4iuWNiDExOjA1LCBCYW9xdWFuIEhlIOWGmemBkzoKPiBPbiAxMC8y
MC8yMiBhdCAxMDoxN2FtLCBYaWFudGluZyBUaWFuIHdyb3RlOgo+PiDlnKggMjAyMi8xMC8yMCDk
uIrljYgxMDowOCwgQmFvcXVhbiBIZSDlhpnpgZM6Cj4+PiBPbiAxMC8xOS8yMiBhdCAwNjozNnBt
LCBYaWFudGluZyBUaWFuIHdyb3RlOgo+Pj4+IEFkZCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5m
bygpLCB3aGljaCBleHBvcnRzIFZNIGxheW91dChNT0RVTEVTLCBWTUFMTE9DLAo+Pj4+IFZNRU1N
QVAgcmFuZ2VzIGFuZCBLRVJORUxfTElOS19BRERSKSwgdmEgYml0cyBhbmQgcmFtIGJhc2UgZm9y
IHZtY29yZS4KPj4+Pgo+Pj4+IERlZmF1bHQgcGFnZXRhYmxlIGxldmVscyBhbmQgUEFHRV9PRkZT
RVQgYXJlbid0IHNhbWUgZm9yIGRpZmZlcmVudCBrZXJuZWwKPj4+PiB2ZXJzaW9uIGFzIGJlbG93
LiBGb3IgcGFnZXRhYmxlIGxldmVscywgaXQgc2V0cyBzdjU3IGJ5IGRlZmF1bHQgYW5kIGZhbGxz
Cj4+Pj4gYmFjayB0byBzZXR0aW5nIHN2NDggYXQgYm9vdCB0aW1lIGlmIHN2NTcgaXMgbm90IHN1
cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUuCj4+Pj4KPj4+PiBGb3IgcmFtIGJhc2UsIHRoZSBkZWZh
dWx0IHZhbHVlIGlzIDB4ODAyMDAwMDAgZm9yIHFlbXUgcmlzY3Y2NCBlbnYgYW5kLAo+Pj4+IGZv
ciBleGFtcGxlLCBpcyAweDIwMDAwMCBvbiB0aGUgWHVhblRpZSA5MTAgQ1BVLgo+Pj4+Cj4+Pj4g
ICAgKiBMaW51eCBLZXJuZWwgNS4xOCB+Cj4+Pj4gICAgKiAgICAgIFBHVEFCTEVfTEVWRUxTID0g
NQo+Pj4+ICAgICogICAgICBQQUdFX09GRlNFVCA9IDB4ZmY2MDAwMDAwMDAwMDAwMAo+Pj4+ICAg
ICogTGludXggS2VybmVsIDUuMTcgfgo+Pj4+ICAgICogICAgICBQR1RBQkxFX0xFVkVMUyA9IDQK
Pj4+PiAgICAqICAgICAgUEFHRV9PRkZTRVQgPSAweGZmZmZhZjgwMDAwMDAwMDAKPj4+PiAgICAq
IExpbnV4IEtlcm5lbCA0LjE5IH4KPj4+PiAgICAqICAgICAgUEdUQUJMRV9MRVZFTFMgPSAzCj4+
Pj4gICAgKiAgICAgIFBBR0VfT0ZGU0VUID0gMHhmZmZmZmZlMDAwMDAwMDAwCj4+Pj4KPj4+PiBT
aW5jZSB0aGVzZSBjb25maWd1cmF0aW9ucyBjaGFuZ2UgZnJvbSB0aW1lIHRvIHRpbWUgYW5kIHZl
cnNpb24gdG8gdmVyc2lvbiwKPj4+PiBpdCBpcyBwcmVmZXJhYmxlIHRvIGV4cG9ydCB0aGVtIHZp
YSB2bWNvcmVpbmZvIHRoYW4gdG8gY2hhbmdlIHRoZSBjcmFzaCdzCj4+Pj4gY29kZSBmcmVxdWVu
dGx5LCBpdCBjYW4gc2ltcGxpZnkgdGhlIGRldmVsb3BtZW50IG9mIGNyYXNoIHRvb2wuCj4+Pj4K
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWFudGluZyBUaWFuIDx4aWFudGluZy50aWFuQGxpbnV4LmFs
aWJhYmEuY29tPgo+Pj4+IC0tLQo+Pj4+ICAgIGFyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlICAg
ICB8ICAxICsKPj4+PiAgICBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgfCAyMyArKysr
KysrKysrKysrKysrKysrKysrKwo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9u
cygrKQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9j
b3JlLmMKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZSBi
L2FyY2gvcmlzY3Yva2VybmVsL01ha2VmaWxlCj4+Pj4gaW5kZXggZGI2ZTRiMTI5NGJhLi40Y2Yz
MDNhNzc5YWIgMTAwNjQ0Cj4+Pj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvTWFrZWZpbGUKPj4+
PiArKysgYi9hcmNoL3Jpc2N2L2tlcm5lbC9NYWtlZmlsZQo+Pj4+IEBAIC04MSw2ICs4MSw3IEBA
IG9iai0kKENPTkZJR19LR0RCKQkJKz0ga2dkYi5vCj4+Pj4gICAgb2JqLSQoQ09ORklHX0tFWEVD
X0NPUkUpCSs9IGtleGVjX3JlbG9jYXRlLm8gY3Jhc2hfc2F2ZV9yZWdzLm8gbWFjaGluZV9rZXhl
Yy5vCj4+Pj4gICAgb2JqLSQoQ09ORklHX0tFWEVDX0ZJTEUpCSs9IGVsZl9rZXhlYy5vIG1hY2hp
bmVfa2V4ZWNfZmlsZS5vCj4+Pj4gICAgb2JqLSQoQ09ORklHX0NSQVNIX0RVTVApCSs9IGNyYXNo
X2R1bXAubwo+Pj4+ICtvYmotJChDT05GSUdfQ1JBU0hfQ09SRSkJKz0gY3Jhc2hfY29yZS5vCj4+
Pj4gICAgb2JqLSQoQ09ORklHX0pVTVBfTEFCRUwpCSs9IGp1bXBfbGFiZWwubwo+Pj4+IGRpZmYg
LS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9jcmFzaF9jb3JlLmMgYi9hcmNoL3Jpc2N2L2tlcm5l
bC9jcmFzaF9jb3JlLmMKPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+IGluZGV4IDAwMDAw
MDAwMDAwMC4uM2U4ODlkMGVkN2JkCj4+Pj4gLS0tIC9kZXYvbnVsbAo+Pj4+ICsrKyBiL2FyY2gv
cmlzY3Yva2VybmVsL2NyYXNoX2NvcmUuYwo+Pj4+IEBAIC0wLDAgKzEsMjMgQEAKPj4+PiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+Pj4+ICsKPj4+PiArI2luY2x1
ZGUgPGxpbnV4L2NyYXNoX2NvcmUuaD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L3BhZ2VtYXAuaD4K
Pj4+PiArCj4+Pj4gK3ZvaWQgYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkKPj4+PiAr
ewo+Pj4+ICsJVk1DT1JFSU5GT19OVU1CRVIoVkFfQklUUyk7Cj4+Pj4gKwlWTUNPUkVJTkZPX05V
TUJFUihwaHlzX3JhbV9iYXNlKTsKPj4+PiArCj4+Pj4gKwl2bWNvcmVpbmZvX2FwcGVuZF9zdHIo
Ik5VTUJFUihQQUdFX09GRlNFVCk9MHglbHhcbiIsIFBBR0VfT0ZGU0VUKTsKPj4+PiArCXZtY29y
ZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxMT0NfU1RBUlQpPTB4JWx4XG4iLCBWTUFMTE9D
X1NUQVJUKTsKPj4+PiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFZNQUxMT0NfRU5E
KT0weCVseFxuIiwgVk1BTExPQ19FTkQpOwo+Pj4+ICsJdm1jb3JlaW5mb19hcHBlbmRfc3RyKCJO
VU1CRVIoVk1FTU1BUF9TVEFSVCk9MHglbHhcbiIsIFZNRU1NQVBfU1RBUlQpOwo+Pj4+ICsJdm1j
b3JlaW5mb19hcHBlbmRfc3RyKCJOVU1CRVIoVk1FTU1BUF9FTkQpPTB4JWx4XG4iLCBWTUVNTUFQ
X0VORCk7Cj4+Pj4gKyNpZmRlZiBDT05GSUdfNjRCSVQKPj4+PiArCXZtY29yZWluZm9fYXBwZW5k
X3N0cigiTlVNQkVSKE1PRFVMRVNfVkFERFIpPTB4JWx4XG4iLCBNT0RVTEVTX1ZBRERSKTsKPj4+
PiArCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKE1PRFVMRVNfRU5EKT0weCVseFxuIiwg
TU9EVUxFU19FTkQpOwo+Pj4+ICsjZW5kaWYKPj4+PiArCj4+Pj4gKwlpZiAoSVNfRU5BQkxFRChD
T05GSUdfNjRCSVQpKQo+Pj4+ICsJCXZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKEtFUk5F
TF9MSU5LX0FERFIpPTB4JWx4XG4iLCBLRVJORUxfTElOS19BRERSKTsKPj4+IFdvbmRlcmluZyB3
aHkgeW91IGRvbid0IHB1dCBLRVJORUxfTElOS19BRERSIGV4cG9ydGluZyBpbnRvIHRoZSBhYm92
ZQo+Pj4gaWZkZWZmZXJ5IHNjb3BlLCB3aXRoIHRoYXQgeW91IGNhbiBzYXZlIG9uZSBsaW5lIG9m
ICJJU19FTkFCTEVEKENPTkZJR182NEJJVCkiLgo+PiBJIGZvbGxvd2VkIHRoZSBydWxlIGluIHBy
aW50X3ZtX2xheW91dCgpIG9mIGFyY2gvcmlzY3YvbW0vaW5pdC5jLCB3aGljaCB1c2VkCj4+IElT
X0VOQUJMRUQgd2hlbiBwcmludCB0aGUgdmFsdWUgb2YgS0VSTkVMX0xJTktfQUREUi4KPj4KPiBJ
IHNlZS4gVGhlcmUncyBQQUdFX09GRlNFVCBpbiB0aGUgbWlkZGxlLiBUaGFua3MuCj4KPiAgICAg
ICAgICBwcmludF9tbCgibG93bWVtIiwgKHVuc2lnbmVkIGxvbmcpUEFHRV9PRkZTRVQsCj4gICAg
ICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyloaWdoX21lbW9yeSkKPgo+IFNvIG5vdywgZG8g
eW91IHRoaW5rIGlmIGl0J3MgbmVjZXNzYXJ5IHRvIGhhdmUgYW5vdGhlcgo+IElTX0VOQUJMRUQo
Q09ORklHXzY0QklUKSBpbiB0aGUgY3VycmVudCBhcmNoX2NyYXNoX3NhdmVfdm1jb3JlaW5mbygp
PwoKRm9yIHdoaWNoIE1BQ1JPP8KgIEkgdGhpbmsgY3VycmVudCBjb2RlIGZvciBQQUdFX09GRlNF
VCBpcyBPSy4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

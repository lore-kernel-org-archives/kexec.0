Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Q4xBZ-0007Gx-BS
	for kexec@lists.infradead.org; Wed, 30 Mar 2011 15:19:54 +0000
Received: by iyb39 with SMTP id 39so1596273iyb.36
	for <kexec@lists.infradead.org>; Wed, 30 Mar 2011 08:19:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
References: <D6CBEE2F420741indou.takao@jp.fujitsu.com>
Date: Wed, 30 Mar 2011 23:19:50 +0800
Message-ID: <AANLkTi=cne0mSNOV0BC3X-SGeNOPPa5MSUf3L6yLJ1-t@mail.gmail.com>
Subject: Re: [PATCH v2] generic-ipi: Initialize call_single_queue before
	enabling interrupt
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>, Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

T24gV2VkLCBNYXIgMzAsIDIwMTEgYXQgMTI6MzUgQU0sIFRha2FvIEluZG9oCjxpbmRvdS50YWth
b0BqcC5mdWppdHN1LmNvbT4gd3JvdGU6Cj4gSGkgYWxsLAo+Cj4gVGhpcyBwYXRjaCByZW5hbWVz
IGluaXRfY2FsbF9zaW5nbGVfZGF0YSgpIHRvIGNhbGxfZnVuY3Rpb25faW5pdCgpIGFuZAo+IGNh
bGxzIGl0IGluIHN0YXJ0X2tlcm5lbCgpIHNvIHRoYXQgY2FsbF9zaW5nbGVfcXVldWUgY2FuIGJl
IGluaXRpYWxpemVkCj4gYmVmb3JlIGVuYWJsaW5nIGludGVycnVwdC4KPgo+IFRoZXJlIGlzIGEg
cHJvYmxlbSB0aGF0IGtkdW1wKDJuZCBrZXJuZWwpIHNvbWV0aW1lcyBoYW5ncyB1cCBkdWUgdG8K
PiBwZW5kaW5nIElQSSBmcm9tIDFzdCBrZXJuZWwuIEtlcm5lbCBwYW5pYyBvY2N1cnMgYmVjYXVz
ZSBJUEkgY29tZXMKPiBiZWZvcmUgY2FsbF9zaW5nbGVfcXVldWUgaXMgaW5pdGlhbGl6ZWQuIFRo
ZSBkZXRhaWxzIGFyZSBhcyBmb2xsb3dzLgo+ICgxKSAybmQga2VybmVsIGJvb3QgdXAKPiAoMikg
QSBwZW5kaW5nIElQSSBmcm9tIDFzdCBrZXJuZWwgY29tZXMgd2hlbiBpcnFzIGFyZSBmaXJzdCBl
bmFibGVkCj4gwqAgwqBpbiBzdGFydF9rZXJuZWwoKS4KPiAoMykgS2VybmVsIHRyaWVzIHRvIGhh
bmRsZSB0aGUgaW50ZXJydXB0LCBidXQgY2FsbF9zaW5nbGVfcXVldWUgaXMgbm90Cj4gwqAgwqBp
bml0aWFsaXplZCB5ZXQgYXQgdGhpcyBwb2ludC4gQXMgYSByZXN1bHQsIGluIHRoZQo+IMKgIMKg
Z2VuZXJpY19zbXBfY2FsbF9mdW5jdGlvbl9zaW5nbGVfaW50ZXJydXB0KCksIE5VTEwgcG9pbnRl
cgo+IMKgIMKgZGVyZWZlcmVuY2Ugb2NjdXJzIHdoZW4gbGlzdF9yZXBsYWNlX2luaXQoKSB0cmll
cyB0byBhY2Nlc3MKPiDCoCDCoCZxLT5saXN0Lm5leHQuCj4gVGhlcmVmb3JlIHRoaXMgcGF0Y2gg
Y2hhbmdlcyB0aGUgbmFtZSBvZiBpbml0X2NhbGxfc2luZ2xlX2RhdGEoKSB0bwo+IGNhbGxfZnVu
Y3Rpb25faW5pdCgpIGFuZCBjYWxscyBpdCBiZWZvcmUgbG9jYWxfaXJxX2VuYWJsZSgpIGluCj4g
c3RhcnRfa2VybmVsKCkuCj4KPiB2MjoKPiAtIFJlbmFtZSBpbml0X2NhbGxfc2luZ2xlX2RhdGEo
KSB0byBjYWxsX2Z1bmN0aW9uX2luaXQoKSBhbmQgY2FsbHMgaXQgaW4KPiDCoHN0YXJ0X2tlcm5l
bCgpCj4gLSBDaGFuZ2UgaW5zZXJ0IHBvc2l0aW9uIGluIHN0YXJ0X2tlcm5lbCgpLgo+IC0gQWRq
dXN0IGZvciBDT05GSUdfU01QL0NPTkZJR19VU0VfR0VORVJJQ19TTVBfSEVMUEVSUyBvcHRpb25z
Cj4gLSBSZWJhc2VkIHRvIExpbnVzJ3MgbGF0ZXN0IHRyZWUKPgoKTG9va3MgZ29vZCB0byBteSBl
eWVzLAoKUmV2aWV3ZWQtYnk6IFdBTkcgQ29uZyA8eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tPgoK
VGhhbmtzLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

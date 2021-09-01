Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLMXI-004szd-KS
 for kexec@lists.infradead.org; Wed, 01 Sep 2021 09:28:02 +0000
From: Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: RE: [PATCH 1/1] fix left bit-shift overflow in
 __exclude_unnecessary_pages()
In-Reply-To: <TYYPR01MB67777DFB702E9801AA414B6ADDCD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
In-Reply-To: 
References: <TYYPR01MB67777DFB702E9801AA414B6ADDCD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Date: Wed, 01 Sep 2021 11:27:49 +0200
Message-ID: <87v93ksl0q.fsf@oc8242746057.ibm.com>
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Discussion list
 for crash utility usage, 	maintenance and development" <crash-utility@redhat.com>

SGkgS2F6dSwKCkhBR0lPIEtBWlVISVRPKOiQqeWwvuOAgOS4gOS7gSkJPGstaGFnaW8tYWJAbmVj
LmNvbT4gd3JpdGVzOgoKPiBIaSBBbGV4LAo+ICtjYyBrZXhlYyBsaXN0ICh0aGUgcmlnaHQgb25l
IGZvciBtYWtlZHVtcGZpbGUgcGF0Y2gpCj4KClRoYW5rcywgc29ycnkgZm9yIHRoZSBtaXggdXAg
OigKCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4gV2hlbmV2ZXIgdGhlIHZhcmlhYmxl
cyBjb21wb3VuZF9vcmRlciBvciBwcml2YXRlIGJlY29tZSBncmVhdGVyIHRoYW4KPj4gMzEsIGxl
ZnQgYml0LXNoaWZ0IG9mIDEgb3ZlcmZsb3dzLCBhbmQgbnJfcGFnZXMgYmVjb21lcyB6ZXJvLiBJ
ZiBucl9wYWdlcwo+PiBiZWNvbWVzIDAgYW5kIHBhZ2VzIGFyZSBiZWluZyBleGNsdWRlZCBhdCB0
aGUgZW5kIG9mIHRoZSBQRk4gbG9vcCwgdGhlCj4+IGVsc2UgYnJhbmNoIG9mIHRoZSBsYXN0IGlm
IHN0YXRlbWVudCBpcyBlbnRlcmVkIGFuZCBwZm4gaXMgZGVjcmVtZW50ZWQgYnkKPj4gMSBiZWNh
dXNlIG5yX3BhZ2VzIGlzIDAuIEZpbmFsbHksIHRoaXMgY2F1c2VzIHRoZSBsb29wIHZhcmlhYmxl
IHBmbiB0bwo+PiBiZSBhc3NpZ25lZCB0aGUgc2FtZSB2YWx1ZSBhcyBiZWZvcmUgd2hlbiB0aGUg
bmV4dCBsb29wIGl0ZXJhdGlvbiBiZWdpbnMKPj4gd2hpY2ggcmVzdWx0cyBpbiBhbiBpbmZpbml0
ZSBsb29wLgo+PiAKPj4gVGhpcyBpc3N1ZSBhcHBlYXJlZCBvbiBzMzkwIDY0Yml0IGFyY2hpdGVj
dHVyZSB3aXRoIGEgZHVtcCBvZiAxNkdCIFJBTS4KPgo+IFRoZSBwYXRjaCBsb29rcyBnb29kIHRv
IG1lLCBidXQganVzdCBvdXQgb2YgY3VyaW9zaXR5LCB3aGVuIGRvIHRoZQo+IGNvbXBvdW5kX29y
ZGVyIG9yIHByaXZhdGUgYmVjb21lIGdyZWF0ZXIgdGhhbiAzMSBvbiBzMzkwPwo+Cj4gVGhhbmtz
LAo+IEthenUKPgoKSSBhZGRlZCBzb21lIGRlYnVnIHN0YXRlbWVudHMgYW5kIHRoaXMgd2hhdCBp
IGdvdDoKCmNvbXBvdW5kX29yZGVyIDAKY29tcG91bmRfb3JkZXIgMQpjb21wb3VuZF9vcmRlciAy
CmNvbXBvdW5kX29yZGVyIDMKY29tcG91bmRfb3JkZXIgNApjb21wb3VuZF9vcmRlciA1CmNvbXBv
dW5kX29yZGVyIDYKY29tcG91bmRfb3JkZXIgNwpjb21wb3VuZF9vcmRlciA4CnByaXZhdGUgMApw
cml2YXRlIDEKcHJpdmF0ZSAyCnByaXZhdGUgMwpwcml2YXRlIDQKcHJpdmF0ZSA1CnByaXZhdGUg
NTIKcHJpdmF0ZSA2CnByaXZhdGUgNwpwcml2YXRlIDgKCkl0IHNlZW1zIHRoYXQgbm90IGNvbXBv
dW5kX29yZGVyIGJ1dCBwcml2YXRlIGlzIGF0IGZhdWx0IGhlcmUgYW5kCnRyaWdnZXJzIHRoZSBi
dWcuIE5vdCBzdXJlIHlldCB3aGF0IHRoYXQgZXhhY3RseSBtZWFucyBhbmQgd2hldGhlciB3ZQpo
YXZlIGhlcmUgYW5vdGhlciBidWcgd2hpY2ggdHJpZ2dlcnMgdGhpcyBvbmUgOi8KClJlZ2FyZHMK
QWxleAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

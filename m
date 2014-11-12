Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XoctU-0007WH-Mq
 for kexec@lists.infradead.org; Wed, 12 Nov 2014 18:43:53 +0000
Date: Wed, 12 Nov 2014 19:43:25 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: uniquely identifying KDUMP files that originate from QEMU
Message-ID: <20141112194325.246ff381@hananiah.suse.cz>
In-Reply-To: <546373B8.70103@redhat.com>
References: <5461F18C.2080400@redhat.com>
 <20141111130913.11eec0a3@hananiah.suse.cz>
 <20141112.120838.303682123986142686.d.hatayama@jp.fujitsu.com>
 <20141112090441.3ee42632@hananiah.suse.cz>
 <546373B8.70103@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kexec@lists.infradead.org

ViBXZWQsIDEyIE5vdiAyMDE0IDE1OjUwOjMyICswMTAwCkxhc3psbyBFcnNlayA8bGVyc2VrQHJl
ZGhhdC5jb20+IG5hcHPDoW5vOgoKPiBPbiAxMS8xMi8xNCAwOTowNCwgUGV0ciBUZXNhcmlrIHdy
b3RlOgo+ID4gT24gV2VkLCAxMiBOb3YgMjAxNCAxMjowODozOCArMDkwMCAoSlNUKQo+ID4gSEFU
QVlBTUEgRGFpc3VrZSA8ZC5oYXRheWFtYUBqcC5mdWppdHN1LmNvbT4gd3JvdGU6Cj4gCj4gPj4g
QW55d2F5LCBwaHlzX2Jhc2UgaXMga2VybmVsIGluZm9ybWF0aW9uLiBUbyBtYWtlIGl0IGF2YWls
YWJsZSBmb3IgcWVtdQo+ID4+IHNpZGUsIHRoZXJlJ3MgbmVlZCB0byBwcmVwYXJlIGEgbWVjaGFu
aXNtIGZvciBxZW11IHRvIGhhdmUgYW55IGFjY2Vzcwo+ID4+IHRvIGl0Lgo+ID4gCj4gPiBZZXMu
IEkgd29uZGVyIGlmIHlvdSBjYW4gaGF2ZSBhY2Nlc3Mgd2l0aG91dCBzb21lIHNvcnQgb2YgY28t
b3BlcmF0aW9uCj4gPiBmcm9tIHRoZSBndWVzdCBrZXJuZWwgaXRzZWxmLiBJIGd1ZXNzIG5vdC4K
PiAKPiBQcm9wYWdhdGluZyBhbnkga2luZCBvZiBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGZyb20g
dGhlIGd1ZXN0IGtlcm5lbAo+ICh3aGljaCBpcyB1bnByaXZpbGVnZWQgYW5kIHBvdGVudGlhbGx5
IG1hbGljaW91cykgdG8gdGhlIGhvc3Qtc2lkZSBxZW11Cj4gcHJvY2VzcyAod2hpY2ggaXMgYnkg
ZGVmaW5pdGlvbiBtb3JlIHByaXZpbGVnZWQsIGFsdGhvdWdoIHN0aWxsIGNvbmZpbmVkCj4gYnkg
dmFyaW91cyBtZWFzdXJlcykgaXMgc29tZXRoaW5nIHdlJ2QgZXhwbGljaXRseSBsaWtlIHRvIGF2
b2lkLgo+IAo+IFRoaW5rIG9mIGl0IGxpa2UgdGhpcy4gSSB0aHJvdyBhIHBoeXNpY2FsIGJveCBh
dCB5b3UsIHJ1bm5pbmcgTGludXgsCj4gdGhhdCBoYXMgZnJvemVuIGluIHRpbWUuIENhbiAiY3Jh
c2giIHdvcmsgd2l0aCBub3RoaW5nIGVsc2UgYnV0IHRoZQo+IGNvbnRlbnRzIG9mIHRoZSBtZW1v
cnksIGFuZCBpbmZvcm1hdGlvbiBhYm91dCB0aGUgQ1BVcz8KCklmIG9ubHkgeW91IGNvdWxkIHNh
dmUgdGhlIF9jb21wbGV0ZV8gc3RhdGUgb2YgdGhlIENQVS4uLiBGb3IgZXhhbXBsZQp0aGUgY29u
dGVudCBvZiBDUjMgd291bGQgYmUgcXVpdGUgdXNlZnVsLgoKUGV0ciBUCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==

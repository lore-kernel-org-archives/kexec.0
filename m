Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZyvEx-0000Re-0w
 for kexec@lists.infradead.org; Wed, 18 Nov 2015 05:25:07 +0000
Message-ID: <1447824280.2500.1.camel@redhat.com>
Subject: Re: [PATCH v3] vmcore-dmesg: Collect full dmesg regardless of
 logged_chars
From: Dangyi Liu <dliu@redhat.com>
Date: Wed, 18 Nov 2015 13:24:40 +0800
In-Reply-To: <1446023724-12445-1-git-send-email-dliu@redhat.com>
References: <1446023724-12445-1-git-send-email-dliu@redhat.com>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

U2ltb24sCgpDb3VsZCB5b3UgaGVscCB0byByZXZpZXcgdGhpcyBwYXRjaD8KClRoYW5rcywKRGFu
Z3lpIExpdQoKT24gV2VkLCAyMDE1LTEwLTI4IGF0IDE3OjE1ICswODAwLCBEYW5neWkgTGl1IHdy
b3RlOgo+IGxvZ2dlZF9jaGFycyB3b3VsZCBiZSBzZXQgdG8gMCBieSBgZG1lc2cgLWNgLCBidXQg
ZnVsbCBkbWVzZyBpcwo+IHVzZWZ1bAo+IGZvciBkZWJ1Z2dpbmcuIFNvIGluc3RlYWQgb2YgdXNp
bmcgbG9nZ2VkX2NoYXJzIGRpcmVjdGx5LCB3ZQo+IGNhbGN1bGF0ZQo+IGl0IGJ5IG91cnNlbHZl
cy4KPiAKPiBOb3cgbG9nZ2VkX2NoYXJzIGlzIHNldCB0byB0aGUgbWluaW11bSBvZiBsb2dfZW5k
IGFuZCBsb2dfYnVmX2xlbiwgYXMKPiB0aGUgc2FtZSBsb2dpYyBhcyBjcmFzaCB1dGlsaXR5IGlz
IHVzaW5nLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhbmd5aSBMaXUgPGRsaXVAcmVkaGF0LmNvbT4K
PiBDYzogRGF2ZSBZb3VuZyA8ZHlvdW5nQHJlZGhhdC5jb20+Cj4gLS0tCj4gQ2hhbmdlczoKPiDC
oCB2MS0+djI6IFVwZGF0ZSBjb21tZW50IGFuZCBjb21taXQgbWVzc2FnZS4KPiDCoCB2Mi0+djM6
IEFkanVzdCBtYXhpbXVtIGxpbmUgbGVuZ3RoCj4gCj4gwqB2bWNvcmUtZG1lc2cvdm1jb3JlLWRt
ZXNnLmMgfCA2ICsrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+IAo+
IGRpZmYgLS1naXQgYS92bWNvcmUtZG1lc2cvdm1jb3JlLWRtZXNnLmMgYi92bWNvcmUtZG1lc2cv
dm1jb3JlLQo+IGRtZXNnLmMKPiBpbmRleCBmNDdlZTExLi4wMzY0NjM2IDEwMDY0NAo+IC0tLSBh
L3ZtY29yZS1kbWVzZy92bWNvcmUtZG1lc2cuYwo+ICsrKyBiL3ZtY29yZS1kbWVzZy92bWNvcmUt
ZG1lc2cuYwo+IEBAIC01NDAsNiArNTQwLDEyIEBAIHN0YXRpYyB2b2lkIGR1bXBfZG1lc2dfbGVn
YWN5KGludCBmZCkKPiDCoAkJZXhpdCg1Myk7Cj4gwqAJfQo+IMKgCj4gKwkvKgo+ICsJwqAqIFRv
IGNvbGxlY3QgZnVsbCBkbWVzZyBpbmNsdWRpbmcgdGhlIHBhcnQgYmVmb3JlIGBkbWVzZwo+IC1j
YCBpcyB1c2VmdWwKPiArCcKgKiBmb3IgbGF0ZXIgZGVidWdnaW5nLiBVc2Ugc2FtZSBsb2dpYyBh
cyB3aGF0IGNyYXNoIHV0aWxpdHkKPiBpcyB1c2luZy4KPiArCcKgKi8KPiArCWxvZ2dlZF9jaGFy
cyA9IGxvZ19lbmQgPCBsb2dfYnVmX2xlbiA/IGxvZ19lbmQgOgo+IGxvZ19idWZfbGVuOwo+ICsK
PiDCoAl3cml0ZV90b19zdGRvdXQoYnVmICsgKGxvZ19idWZfbGVuIC3CoMKgbG9nZ2VkX2NoYXJz
KSwKPiBsb2dnZWRfY2hhcnMpOwo+IMKgfQo+IMKgCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tl
eGVjCg==

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxoui-0005JH-0w
 for kexec@lists.infradead.org; Fri, 08 Jan 2021 10:22:36 +0000
Date: Fri, 8 Jan 2021 18:22:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210108102224.GC4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "lijiang@redhat.com" <lijiang@redhat.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Egorenkov <egorenar@linux.ibm.com>, "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>

T24gMDEvMDgvMjEgYXQgMTA6MDdhbSwgSEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSkgd3Jv
dGU6Cj4gSGkgQmFvcXVhbiwKPiAKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+ID4gT24g
MDkvMzAvMjAgYXQgMTI6MjNwbSwgQWxleGFuZGVyIEVnb3JlbmtvdiB3cm90ZToKPiA+ID4gVGhl
IG9mZnNldCBvZiB0aGUgZmllbGQgJ2luaXRfdXRzX25zLm5hbWUnIGhhcyBjaGFuZ2VkCj4gPiA+
IHNpbmNlIGNvbW1pdCA5YTU2NDkzZjY5NDIgKCJ1dHM6IFVzZSBnZW5lcmljIG5zX2NvbW1vbjo6
Y291bnQiKS4KPiA+IAo+ID4gVGhpcyBwYXRjaCBpcyBtZXJnZWQgaW50byA1LjExLXJjMSwgYnV0
IHdlIG1ldCB0aGUgbWFrZWR1bXBmaWxlIGZhaWx1cmUKPiA+IG9mIGtkdW1wIHRlc3QgY2FzZSBp
biA1LjEwLjAga2VybmVsLiBTaG91bGQgYWZmZWN0IDUuOSB0b28gc2luY2UKPiA+IGNvbW1pdCA5
YTU2NDkzZjY5NDIgaXMgbWVyZ2VkIGludG8gNS45LXJjMi4KPiAKPiBIbW0sIGNvbW1pdCA5YTU2
NDkzZjY5NDIgc2hvdWxkIGhhdmUgYmVlbiBtZXJnZWQgaW50byA1LjExLXJjMQo+IHRvZ2V0aGVy
IHdpdGggY29tbWl0IGNhNGE5MjQxY2M1ZS4KCkNoZWNrZWQgb24gbWFzdGVyIGJyYW5jaCBvZiBt
YWlubGluZSBrZXJuZWwsIGNvbW1pdCA5YTU2NDkzZjY5NDIgaXMgaW4KNS45LXJjMS4gY29tbWl0
IGNhNGE5MjQxY2M1ZSBpcyBtZXJnZWQgaW50byA1LjExLXJjMS4KCmNvbW1pdCA5YTU2NDkzZjY5
NDJjMGUyZGYxNTc5OTg2MTI4NzIxZGE5NmUwMGQ4CkF1dGhvcjogS2lyaWxsIFRraGFpIDxrdGto
YWlAdmlydHVvenpvLmNvbT4KRGF0ZTogICBNb24gQXVnIDMgMTM6MTY6MjEgMjAyMCArMDMwMAoK
ICAgIHV0czogVXNlIGdlbmVyaWMgbnNfY29tbW9uOjpjb3VudAoKCmNvbW1pdCBjYTRhOTI0MWNj
NWU3MThkZTg2YTM0YWZkNDE5NzI4Njk1NDZhNWUzCkF1dGhvcjogQWxleGFuZGVyIEVnb3Jlbmtv
diA8ZWdvcmVuYXJAbGludXguaWJtLmNvbT4KRGF0ZTogICBUdWUgRGVjIDE1IDIwOjQ1OjMxIDIw
MjAgLTA4MDAKCiAgICBrZHVtcDogYXBwZW5kIHV0c19uYW1lc3BhY2UubmFtZSBvZmZzZXQgdG8g
Vk1DT1JFSU5GTwoKCj4gCj4gRG9lcyB5b3VyIG1ha2VkdW1wZmlsZSBoYXZlIHRoZSBmb2xsb3dp
bmcgcGF0Y2g/Cj4gaHR0cHM6Ly9naXRodWIuY29tL21ha2VkdW1wZmlsZS9tYWtlZHVtcGZpbGUv
Y29tbWl0LzU0YWVjMzg3OGIzZjkxMzQxZTZiYzczNWVkYTE1OGNjYTVjNTRlYzkKCldlIG1ldCB0
aGlzIGlzc3VlIG9uIDUuMTAga2VybmVsLCB0aGUgbGF0ZXN0IG1ha2VkdW1wZmlsZSAxLjYuOCsg
Zml4cwppdC4gTWFrZWR1bXBmaWxlIDEuNi44KyBpbmNsdWRlcyB0aGUgY29tbWl0IDU0YWVjMzg3
OGIzZi4gTm90IHN1cmUgaWYgSQpnb3QgdGhlIGtlcm5lbCBjb21taXQgcmlnaHQgaW4gdGhlaXIg
Y29ycmVzcG9uZGluZyByZWxlYXNlLgoKVGhhbmtzCkJhb3F1YW4KCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==

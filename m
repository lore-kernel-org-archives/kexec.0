Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyu3O-0005kC-JG
 for kexec@lists.infradead.org; Mon, 11 Jan 2021 10:04:04 +0000
Date: Mon, 11 Jan 2021 18:03:44 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <20210111100344.GF4959@MiWiFi-R3L-srv>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20210108102224.GC4959@MiWiFi-R3L-srv> <X/wXU9G/+AJhb4HP@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X/wXU9G/+AJhb4HP@kroah.com>
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
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>
Cc: "lijiang@redhat.com" <lijiang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Egorenkov <egorenar@linux.ibm.com>, "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>

T24gMDEvMTEvMjEgYXQgMTA6MTZhbSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6
Cj4gT24gRnJpLCBKYW4gMDgsIDIwMjEgYXQgMDY6MjI6MjRQTSArMDgwMCwgQmFvcXVhbiBIZSB3
cm90ZToKPiA+IE9uIDAxLzA4LzIxIGF0IDEwOjA3YW0sIEhBR0lPIEtBWlVISVRPKOiQqeWwviDk
uIDku4EpIHdyb3RlOgo+ID4gPiBIaSBCYW9xdWFuLAo+ID4gPiAKPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPiA+ID4gPiBPbiAwOS8zMC8yMCBhdCAxMjoyM3BtLCBBbGV4YW5kZXIg
RWdvcmVua292IHdyb3RlOgo+ID4gPiA+ID4gVGhlIG9mZnNldCBvZiB0aGUgZmllbGQgJ2luaXRf
dXRzX25zLm5hbWUnIGhhcyBjaGFuZ2VkCj4gPiA+ID4gPiBzaW5jZSBjb21taXQgOWE1NjQ5M2Y2
OTQyICgidXRzOiBVc2UgZ2VuZXJpYyBuc19jb21tb246OmNvdW50IikuCj4gPiA+ID4gCj4gPiA+
ID4gVGhpcyBwYXRjaCBpcyBtZXJnZWQgaW50byA1LjExLXJjMSwgYnV0IHdlIG1ldCB0aGUgbWFr
ZWR1bXBmaWxlIGZhaWx1cmUKPiA+ID4gPiBvZiBrZHVtcCB0ZXN0IGNhc2UgaW4gNS4xMC4wIGtl
cm5lbC4gU2hvdWxkIGFmZmVjdCA1LjkgdG9vIHNpbmNlCj4gPiA+ID4gY29tbWl0IDlhNTY0OTNm
Njk0MiBpcyBtZXJnZWQgaW50byA1LjktcmMyLgo+ID4gPiAKPiA+ID4gSG1tLCBjb21taXQgOWE1
NjQ5M2Y2OTQyIHNob3VsZCBoYXZlIGJlZW4gbWVyZ2VkIGludG8gNS4xMS1yYzEKPiA+ID4gdG9n
ZXRoZXIgd2l0aCBjb21taXQgY2E0YTkyNDFjYzVlLgo+ID4gCj4gPiBDaGVja2VkIG9uIG1hc3Rl
ciBicmFuY2ggb2YgbWFpbmxpbmUga2VybmVsLCBjb21taXQgOWE1NjQ5M2Y2OTQyIGlzIGluCj4g
PiA1LjktcmMxLgo+IAo+IAo+IE5vLCB0aGF0IGNvbW1pdCBpcyBpbiA1LjExLXJjMSwgbm90IDUu
OS1yYzE6Cj4gCSQgZ2l0IGRlc2NyaWJlIC0tY29udGFpbnMgOWE1NjQ5M2Y2OTQyCj4gCXY1LjEx
LXJjMX4xODJeMn45CgpPaCwgdGhlbiBJIHdhcyB3cm9uZyBhYm91dCBpdC4gSSBhZGQgbGludXgt
bmV4dCByZXBvIGluIG15IGxpbnV4IGtlcm5lbApmb2xkZXIsIHNvIEkgY2FuJ3QgZ2V0IGl0IHdp
dGggdGhlIGFib3ZlIGNvbW1hbmQgb24gbWFzdGVyIGJyYW5jaCBvZgptYWlubGluZSBrZXJuZWw6
CgpbYmhlQH4gbGludXhdJCBnaXQgZGVzY3JpYmUgLS1jb250YWlucyA5YTU2NDkzZjY5NDIKbmV4
dC0yMDIwMDgyMH4xMDdeMn44CgpJIGp1c3QgdXNlICdnaXQgbG9nIC0tb25lbGluZScgYW5kIGZv
dW5kIG91dCBjb21taXQgOWE1NjQ5M2Y2OTQyIGlzCmFkZGVkIGJlZm9yZSA1LjktcmMxLiBTZWVt
cyB0aGlzIGlzIG5vdCByaWdodCB3YXkgdG8gZ2V0IHRoZSBrZXJuZWwKcmVsZWFzZS4gU28gcGxl
YXNlIGlnbm9yZSB0aGUgYmFjayBwb3J0aW5nIHJlcXVlc3Qgb2Ygc3RhYmxlIHRyZWUuClNvcnJ5
IGFib3V0IHRoZSBjb25mdXNpb24uCgpUaGFua3MKQmFvcXVhbgoKPiAKPiA+IGNvbW1pdCBjYTRh
OTI0MWNjNWUgaXMgbWVyZ2VkIGludG8gNS4xMS1yYzEuCj4gPiAKPiA+IGNvbW1pdCA5YTU2NDkz
ZjY5NDJjMGUyZGYxNTc5OTg2MTI4NzIxZGE5NmUwMGQ4Cj4gPiBBdXRob3I6IEtpcmlsbCBUa2hh
aSA8a3RraGFpQHZpcnR1b3p6by5jb20+Cj4gPiBEYXRlOiAgIE1vbiBBdWcgMyAxMzoxNjoyMSAy
MDIwICswMzAwCj4gPiAKPiA+ICAgICB1dHM6IFVzZSBnZW5lcmljIG5zX2NvbW1vbjo6Y291bnQK
PiA+IAo+ID4gCj4gPiBjb21taXQgY2E0YTkyNDFjYzVlNzE4ZGU4NmEzNGFmZDQxOTcyODY5NTQ2
YTVlMwo+ID4gQXV0aG9yOiBBbGV4YW5kZXIgRWdvcmVua292IDxlZ29yZW5hckBsaW51eC5pYm0u
Y29tPgo+ID4gRGF0ZTogICBUdWUgRGVjIDE1IDIwOjQ1OjMxIDIwMjAgLTA4MDAKPiA+IAo+ID4g
ICAgIGtkdW1wOiBhcHBlbmQgdXRzX25hbWVzcGFjZS5uYW1lIG9mZnNldCB0byBWTUNPUkVJTkZP
Cj4gCj4gCj4gQXJlIHlvdSBhbGwgc3VyZSB0aGlzIGlzIG5lZWRlZCBpbiA1LjEwLnk/Cj4gCj4g
dGhhbmtzLAo+IAo+IGdyZWcgay1oCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0cy5pbmZy
YWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

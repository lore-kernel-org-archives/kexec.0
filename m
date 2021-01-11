Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kytHo-0006OG-T4
 for kexec@lists.infradead.org; Mon, 11 Jan 2021 09:14:53 +0000
Date: Mon, 11 Jan 2021 10:16:03 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] kdump: append uts_namespace.name offset to
 VMCOREINFO
Message-ID: <X/wXU9G/+AJhb4HP@kroah.com>
References: <20200930102328.396488-1-egorenar@linux.ibm.com>
 <20210108033248.GA4959@MiWiFi-R3L-srv>
 <OSBPR01MB1991DBFA6C4BD6818947EF6BDDAE0@OSBPR01MB1991.jpnprd01.prod.outlook.com>
 <20210108102224.GC4959@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108102224.GC4959@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: "lijiang@redhat.com" <lijiang@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Egorenkov <egorenar@linux.ibm.com>, HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dyoung@redhat.com" <dyoung@redhat.com>, "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>, "keescook@chromium.org" <keescook@chromium.org>

T24gRnJpLCBKYW4gMDgsIDIwMjEgYXQgMDY6MjI6MjRQTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90
ZToKPiBPbiAwMS8wOC8yMSBhdCAxMDowN2FtLCBIQUdJTyBLQVpVSElUTyjokKnlsL4g5LiA5LuB
KSB3cm90ZToKPiA+IEhpIEJhb3F1YW4sCj4gPiAKPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tCj4gPiA+IE9uIDA5LzMwLzIwIGF0IDEyOjIzcG0sIEFsZXhhbmRlciBFZ29yZW5rb3Ygd3Jv
dGU6Cj4gPiA+ID4gVGhlIG9mZnNldCBvZiB0aGUgZmllbGQgJ2luaXRfdXRzX25zLm5hbWUnIGhh
cyBjaGFuZ2VkCj4gPiA+ID4gc2luY2UgY29tbWl0IDlhNTY0OTNmNjk0MiAoInV0czogVXNlIGdl
bmVyaWMgbnNfY29tbW9uOjpjb3VudCIpLgo+ID4gPiAKPiA+ID4gVGhpcyBwYXRjaCBpcyBtZXJn
ZWQgaW50byA1LjExLXJjMSwgYnV0IHdlIG1ldCB0aGUgbWFrZWR1bXBmaWxlIGZhaWx1cmUKPiA+
ID4gb2Yga2R1bXAgdGVzdCBjYXNlIGluIDUuMTAuMCBrZXJuZWwuIFNob3VsZCBhZmZlY3QgNS45
IHRvbyBzaW5jZQo+ID4gPiBjb21taXQgOWE1NjQ5M2Y2OTQyIGlzIG1lcmdlZCBpbnRvIDUuOS1y
YzIuCj4gPiAKPiA+IEhtbSwgY29tbWl0IDlhNTY0OTNmNjk0MiBzaG91bGQgaGF2ZSBiZWVuIG1l
cmdlZCBpbnRvIDUuMTEtcmMxCj4gPiB0b2dldGhlciB3aXRoIGNvbW1pdCBjYTRhOTI0MWNjNWUu
Cj4gCj4gQ2hlY2tlZCBvbiBtYXN0ZXIgYnJhbmNoIG9mIG1haW5saW5lIGtlcm5lbCwgY29tbWl0
IDlhNTY0OTNmNjk0MiBpcyBpbgo+IDUuOS1yYzEuCgoKTm8sIHRoYXQgY29tbWl0IGlzIGluIDUu
MTEtcmMxLCBub3QgNS45LXJjMToKCSQgZ2l0IGRlc2NyaWJlIC0tY29udGFpbnMgOWE1NjQ5M2Y2
OTQyCgl2NS4xMS1yYzF+MTgyXjJ+OQoKPiBjb21taXQgY2E0YTkyNDFjYzVlIGlzIG1lcmdlZCBp
bnRvIDUuMTEtcmMxLgo+IAo+IGNvbW1pdCA5YTU2NDkzZjY5NDJjMGUyZGYxNTc5OTg2MTI4NzIx
ZGE5NmUwMGQ4Cj4gQXV0aG9yOiBLaXJpbGwgVGtoYWkgPGt0a2hhaUB2aXJ0dW96em8uY29tPgo+
IERhdGU6ICAgTW9uIEF1ZyAzIDEzOjE2OjIxIDIwMjAgKzAzMDAKPiAKPiAgICAgdXRzOiBVc2Ug
Z2VuZXJpYyBuc19jb21tb246OmNvdW50Cj4gCj4gCj4gY29tbWl0IGNhNGE5MjQxY2M1ZTcxOGRl
ODZhMzRhZmQ0MTk3Mjg2OTU0NmE1ZTMKPiBBdXRob3I6IEFsZXhhbmRlciBFZ29yZW5rb3YgPGVn
b3JlbmFyQGxpbnV4LmlibS5jb20+Cj4gRGF0ZTogICBUdWUgRGVjIDE1IDIwOjQ1OjMxIDIwMjAg
LTA4MDAKPiAKPiAgICAga2R1bXA6IGFwcGVuZCB1dHNfbmFtZXNwYWNlLm5hbWUgb2Zmc2V0IHRv
IFZNQ09SRUlORk8KCgpBcmUgeW91IGFsbCBzdXJlIHRoaXMgaXMgbmVlZGVkIGluIDUuMTAueT8K
CnRoYW5rcywKCmdyZWcgay1oCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

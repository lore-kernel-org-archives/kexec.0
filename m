Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6cZL-0003fY-93
 for kexec@lists.infradead.org; Mon, 01 Feb 2021 17:00:57 +0000
Received: by mail-oi1-x22f.google.com with SMTP id k25so19499267oik.13
 for <kexec@lists.infradead.org>; Mon, 01 Feb 2021 09:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20210130184920.1385887-1-jiang.wang@bytedance.com>
 <OSBPR01MB19911206BBDE1223B48CF5B6DDB69@OSBPR01MB1991.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB19911206BBDE1223B48CF5B6DDB69@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Mon, 1 Feb 2021 09:00:40 -0800
Message-ID: <CAP_N_Z_1B8X_MCcjnh58J7AA7CynLdKXh-6G_TdPcTqRwW+_8w@mail.gmail.com>
Subject: Re: [External] RE: [PATCH] makedumpfile: Fix a compile error on
 Debian with pthread
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
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

QXdlc29tZSwgdGhhbmtzIQoKT24gU3VuLCBKYW4gMzEsIDIwMjEgYXQgNTo0MiBQTSBIQUdJTyBL
QVpVSElUTyjokKnlsL7jgIDkuIDku4EpCjxrLWhhZ2lvLWFiQG5lYy5jb20+IHdyb3RlOgo+Cj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiA+IEZyb206ICJqaWFuZy53YW5nIiA8amlhbmcu
d2FuZ0BieXRlZGFuY2UuY29tPgo+ID4KPiA+IE9uIERlYmlhbiAxMCwgbWFrZSByZXBvcnRzIGVy
cm9ycyBhYm91dCB1bmRlZmluZWQgcmVmZXJlbmNlIHRvCj4gPiBgcHRocmVhZF9yd2xvY2tfdHJ5
cmRsb2NrJy4gVG8gZml4IGl0LCBwdXQgbGR3IGJlZm9yZSBscHRocmVhZAo+ID4gaW4gdGhlIE1h
a2VmaWxlLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5nIFdhbmcgPGppYW5nLndhbmdAYnl0
ZWRhbmNlLmNvbT4KPiA+IC0tLQo+ID4gIE1ha2VmaWxlIHwgMiArLQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9N
YWtlZmlsZSBiL01ha2VmaWxlCj4gPiBpbmRleCBjYjZiZDQyLi4wMTBkNDQ3IDEwMDY0NAo+ID4g
LS0tIGEvTWFrZWZpbGUKPiA+ICsrKyBiL01ha2VmaWxlCj4gPiBAQCAtNjgsNyArNjgsNyBAQCBl
bmRpZgo+ID4gIENGTEFHUyArPSAtRFVTRVNOQVBQWQo+ID4gIGVuZGlmCj4gPgo+ID4gLUxJQlMg
Oj0gLWxwdGhyZWFkICQoTElCUykKPiA+ICtMSUJTIDo9ICQoTElCUykgLWxwdGhyZWFkCj4gPgo+
ID4gIHRyeS1ydW4gPSAkKHNoZWxsIHNldCAtZTsgICAgICAgICAgICBcCj4gPiAgICAgICBUTVA9
Ii4kJCQkLnRtcCI7ICAgICAgICAgICAgICAgIFwKPiA+IC0tCj4gPiAyLjExLjAKPgo+IFRoYW5r
cyBmb3IgdGhlIHBhdGNoLCBhcHBsaWVkLgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9tYWtlZHVtcGZp
bGUvbWFrZWR1bXBmaWxlL2NvbW1pdC8wMWI0YmQzNTRjNGE4NDVjMTYwZDE0NDg3YTkzMjcwY2Qx
ZTIyMDMxCj4KPiBLYXp1Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

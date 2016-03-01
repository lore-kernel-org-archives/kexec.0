Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aafQQ-0003P6-Ms
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 08:12:59 +0000
Date: Tue, 1 Mar 2016 16:16:26 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
Message-ID: <20160301081626.GA10288@dhcp-128-25.nay.redhat.com>
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
 <20160223052616.GA19420@dhcp-128-25.nay.redhat.com>
 <56CBF266.8070107@cn.fujitsu.com>
 <20160224014323.GA23058@dhcp-128-25.nay.redhat.com>
 <56CD1369.3050905@cn.fujitsu.com>
 <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
 <56D53DEA.1080307@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56D53DEA.1080307@cn.fujitsu.com>
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
To: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

T24gMDMvMDEvMTYgYXQgMDI6NTlwbSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3cm90ZToK
PiBIaSBNaW5mZWksCj4gCj4gQ291bGQgeW91IGhlbHAgbWUgdGVzdCB0aGUgcGF0Y2ggaW4gdGhl
IGF0dGFjaG1lbnQ/CgpPay4gSSB3aWxsIHZlcmlmeSBpdCB3aXRoIHRoaXMgcGF0Y2guIEZlZWRi
YWNrIHdpbGwgYmUgZ2l2ZW4gaW4gbmV4dCBmZXcKZGF5cy4gVGhhbmtzIGZvciB5b3VyIGVmZm9y
dC4KClRoYW5rcwpNaW5mZWkKCj4gCj4gSSBoYXZlIHJ1biBpdCBhIHRob3VzYW5kIHRpbWVzIGFu
ZCBoYXZlbid0IGdvdCBhIGZhaWx1cmUuCj4gUHJldmlvdXNseSwgSSBjYW4gYWx3YXlzIGdldCBh
IGZhaWx1cmUgYWZ0ZXIgcnVubmluZyBodW5kcmVkcyBvZiB0aW1lcy4KPiAKPiBCdXQgSSdtIG5v
dCBzdXJlIGlmIGl0IGlzIHRoZSBzYW1lIHByb2JsZW0geW91IGhhdmUgbWV0Lgo+IAo+IC0tIAo+
IFRoYW5rcwo+IFpob3UKPiAKPiBPbiAwMi8yNC8yMDE2IDEwOjI0IEFNLCBNaW5mZWkgSHVhbmcg
d3JvdGU6Cj4gPgo+ID4+T24gRmViIDI0LCAyMDE2LCBhdCAxMDoyMCwgWmhvdSwgV2Vuamlhbi/l
kajmlofliZEgPHpob3V3ai1mbnN0QGNuLmZ1aml0c3UuY29tPiB3cm90ZToKPiA+Pgo+ID4+SGks
Cj4gPj4KPiA+Pk9uIDAyLzI0LzIwMTYgMDk6NDMgQU0sIE1pbmZlaSBIdWFuZyB3cm90ZToKPiA+
Pj5PbiAwMi8yMy8xNiBhdCAwMTo0N3BtLCAiWmhvdSwgV2Vuamlhbi/lkajmlofliZEiIHdyb3Rl
Ogo+ID4+Pj5IZWxsbywgTWluZmVpLAo+ID4+Pj4KPiA+Pj4+RG9lcyBpdCBvY2N1ciBldmVyeSB0
aW1lPwo+ID4+Pj5JZiBub3QsIEkgdGhpbmsgSSBoYXZlIGtub3duIHRoZSByZWFzb24uCj4gPj4+
Cj4gPj4+SGksIFdlbmppYW4uCj4gPj4+Cj4gPj4+VGhpcyBwYXRjaCBpcyBhcHBsaWVkIGRpcmVj
dGx5IG9uIHZlcnNpb24gMS41LjkuIEFuZCBtYWtlZHVtcGZpbGUgaGFuZ3MKPiA+Pj5pZiBvcHRp
b24gbnVtLXRocmVhZCBpcyBhcHBlbmRlZC4KPiA+Pj4KPiA+Pgo+ID4+SSBzZWUuCj4gPj5JJ20g
d29ya2luZyBvbiBpdC4KPiA+Pgo+ID4+QlRXLCBkaWQgeW91IG9ubHkgdGVzdCBpdCB3aXRoIC0t
bnVtLXRocmVhZHMgMTI4Pwo+ID4+SG93IGlzIGl0IHdpdGggLS1udW0tdGhyZWFkcyAzMihvciBz
bWFsbGVyIHZhbHVlKT8KPiA+Cj4gPlllcy4gSSBoYXZlIHRlc3RlZCB3aXRoIG51bS10aHJlYWQg
MSwgMiwgOCBhbmQgMzIuIEV4Y2VwdCBmb3Ig4oCUbnVtLXRocmVhZHMgMSwKPiA+YWxsIG9mIHRo
ZSB0ZXN0IGZhaWwuCj4gPgo+ID5UaGFua3MKPiA+TWluZmVpCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==

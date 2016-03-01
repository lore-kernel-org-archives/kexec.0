Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aafR3-0003Uv-S1
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 08:13:38 +0000
Date: Tue, 1 Mar 2016 16:17:08 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
Message-ID: <20160301081708.GB10288@dhcp-128-25.nay.redhat.com>
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
 <20160223052616.GA19420@dhcp-128-25.nay.redhat.com>
 <56CBF266.8070107@cn.fujitsu.com>
 <20160224014323.GA23058@dhcp-128-25.nay.redhat.com>
 <56CD1369.3050905@cn.fujitsu.com>
 <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
 <56D542C5.5060205@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56D542C5.5060205@cn.fujitsu.com>
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

T24gMDMvMDEvMTYgYXQgMDM6MjBwbSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3cm90ZToK
PiBIZWxsbyBNaW5mZWksCj4gCj4gVGhlIG1haWwgSSBzZW50IHRvIHlvdSBhbmQga2V4ZWMgbGlz
dCBpcyBoZWxkIGJ5IHRoZSBrZXhlYyBsaXN0Lgo+IEhhdmUgeW91IHJlY2VpdmVkIGl0Pwo+IFNo
b3VsZCBJIHJlc2VuZD8KCkl0J3MgZmluZSwgc2luY2UgSSBoYXZlIHJlY2VpZXZlZCB5b3VyIHJl
cXVlc3QuCgpUaGFua3MKTWluZmVpCgo+IAo+IC0tIAo+IFRoYW5rcwo+IFpob3UKPiAKPiBPbiAw
Mi8yNC8yMDE2IDEwOjI0IEFNLCBNaW5mZWkgSHVhbmcgd3JvdGU6Cj4gPgo+ID4+T24gRmViIDI0
LCAyMDE2LCBhdCAxMDoyMCwgWmhvdSwgV2Vuamlhbi/lkajmlofliZEgPHpob3V3ai1mbnN0QGNu
LmZ1aml0c3UuY29tPiB3cm90ZToKPiA+Pgo+ID4+SGksCj4gPj4KPiA+Pk9uIDAyLzI0LzIwMTYg
MDk6NDMgQU0sIE1pbmZlaSBIdWFuZyB3cm90ZToKPiA+Pj5PbiAwMi8yMy8xNiBhdCAwMTo0N3Bt
LCAiWmhvdSwgV2Vuamlhbi/lkajmlofliZEiIHdyb3RlOgo+ID4+Pj5IZWxsbywgTWluZmVpLAo+
ID4+Pj4KPiA+Pj4+RG9lcyBpdCBvY2N1ciBldmVyeSB0aW1lPwo+ID4+Pj5JZiBub3QsIEkgdGhp
bmsgSSBoYXZlIGtub3duIHRoZSByZWFzb24uCj4gPj4+Cj4gPj4+SGksIFdlbmppYW4uCj4gPj4+
Cj4gPj4+VGhpcyBwYXRjaCBpcyBhcHBsaWVkIGRpcmVjdGx5IG9uIHZlcnNpb24gMS41LjkuIEFu
ZCBtYWtlZHVtcGZpbGUgaGFuZ3MKPiA+Pj5pZiBvcHRpb24gbnVtLXRocmVhZCBpcyBhcHBlbmRl
ZC4KPiA+Pj4KPiA+Pgo+ID4+SSBzZWUuCj4gPj5JJ20gd29ya2luZyBvbiBpdC4KPiA+Pgo+ID4+
QlRXLCBkaWQgeW91IG9ubHkgdGVzdCBpdCB3aXRoIC0tbnVtLXRocmVhZHMgMTI4Pwo+ID4+SG93
IGlzIGl0IHdpdGggLS1udW0tdGhyZWFkcyAzMihvciBzbWFsbGVyIHZhbHVlKT8KPiA+Cj4gPlll
cy4gSSBoYXZlIHRlc3RlZCB3aXRoIG51bS10aHJlYWQgMSwgMiwgOCBhbmQgMzIuIEV4Y2VwdCBm
b3Ig4oCUbnVtLXRocmVhZHMgMSwKPiA+YWxsIG9mIHRoZSB0ZXN0IGZhaWwuCj4gPgo+ID5UaGFu
a3MKPiA+TWluZmVpCj4gPj4KPiA+Cj4gPgo+ID4KPiAKPiAKPiAKPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8va2V4ZWMK

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ab3v1-0008PE-Pn
 for kexec@lists.infradead.org; Wed, 02 Mar 2016 10:22:12 +0000
Date: Wed, 2 Mar 2016 18:25:43 +0800
From: Minfei Huang <mhuang@redhat.com>
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
Message-ID: <20160302102543.GA923@dhcp-128-25.nay.redhat.com>
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
 <20160223052616.GA19420@dhcp-128-25.nay.redhat.com>
 <56CBF266.8070107@cn.fujitsu.com>
 <20160224014323.GA23058@dhcp-128-25.nay.redhat.com>
 <56CD1369.3050905@cn.fujitsu.com>
 <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
 <56D53DEA.1080307@cn.fujitsu.com>
 <20160301081626.GA10288@dhcp-128-25.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160301081626.GA10288@dhcp-128-25.nay.redhat.com>
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

T24gMDMvMDEvMTYgYXQgMDQ6MTZwbSwgTWluZmVpIEh1YW5nIHdyb3RlOgo+IE9uIDAzLzAxLzE2
IGF0IDAyOjU5cG0sICJaaG91LCBXZW5qaWFuL+WRqOaWh+WJkSIgd3JvdGU6Cj4gPiBIaSBNaW5m
ZWksCj4gPiAKPiA+IENvdWxkIHlvdSBoZWxwIG1lIHRlc3QgdGhlIHBhdGNoIGluIHRoZSBhdHRh
Y2htZW50Pwo+IAo+IE9rLiBJIHdpbGwgdmVyaWZ5IGl0IHdpdGggdGhpcyBwYXRjaC4gRmVlZGJh
Y2sgd2lsbCBiZSBnaXZlbiBpbiBuZXh0IGZldwo+IGRheXMuIFRoYW5rcyBmb3IgeW91ciBlZmZv
cnQuCj4gCj4gVGhhbmtzCj4gTWluZmVpCj4gCj4gPiAKPiA+IEkgaGF2ZSBydW4gaXQgYSB0aG91
c2FuZCB0aW1lcyBhbmQgaGF2ZW4ndCBnb3QgYSBmYWlsdXJlLgo+ID4gUHJldmlvdXNseSwgSSBj
YW4gYWx3YXlzIGdldCBhIGZhaWx1cmUgYWZ0ZXIgcnVubmluZyBodW5kcmVkcyBvZiB0aW1lcy4K
PiA+IAo+ID4gQnV0IEknbSBub3Qgc3VyZSBpZiBpdCBpcyB0aGUgc2FtZSBwcm9ibGVtIHlvdSBo
YXZlIG1ldC4KCkhpLgoKSSBoYXZlIHZlcmlmaWVkIHRoaXMgcGF0Y2ggYmFzZWQgb24gMS41Ljku
IG1ha2VkdW1wZmlsZSB3b3JrcyB3ZWxsIGJvdGgKd2l0aCBhbmQgd2l0aG91dCBvcHRpb24gLS1u
dW0tdGhyZWFkcyBhZnRlciBhcHBseWluZyB0aGlzIHBhdGNoLgoKVGhlcmUgYXJlIDEyOCBhY3Rp
dmUgQ1BVcyBhbmQgNFQgbWVtb3J5IGluIGtkdW1wIGtlcm5lbC4KCndpdGggb3B0aW9uIC1kIDMx
CnJlYWwgICAgM200NS45MTZzCgp3aXRoIG9wdGlvbiAtLW51bS10aHJlYWRzIDEgLWQgMzEKcmVh
bCAgICA2bTMwLjI4NnMKCndpdGggb3B0aW9uIC0tbnVtLXRocmVhZHMgMiAtZCAzMQpyZWFsICAg
IDdtNDUuNTk3cwoKd2l0aCBvcHRpb24gLS1udW0tdGhyZWFkcyA4IC1kIDMxCnJlYWwgICAgMTNt
Ny45MTRzCgp3aXRoIG9wdGlvbiAtLW51bS10aHJlYWRzIDMyIC1kIDMxCnJlYWwgICAgMTBtMTAu
MjQ4cwoKb3JpZ2luYWwgbWFrZWR1bXBmaWxlIHdpdGggb3B0aW9uIC1kIDMxCnJlYWwgICAgNG0y
Ny42MTdzCgpTZWVtIG1vcmUgdGltZSB3aWxsIGJlIHRha2VuIGJ5IGluY3JlYXNpbmcgdGhyZWFk
IG51bWJlci4KClRoYW5rcwpNaW5mZWkKCj4gPiAKPiA+IC0tIAo+ID4gVGhhbmtzCj4gPiBaaG91
Cj4gPiAKPiA+IE9uIDAyLzI0LzIwMTYgMTA6MjQgQU0sIE1pbmZlaSBIdWFuZyB3cm90ZToKPiA+
ID4KPiA+ID4+T24gRmViIDI0LCAyMDE2LCBhdCAxMDoyMCwgWmhvdSwgV2Vuamlhbi/lkajmlofl
iZEgPHpob3V3ai1mbnN0QGNuLmZ1aml0c3UuY29tPiB3cm90ZToKPiA+ID4+Cj4gPiA+PkhpLAo+
ID4gPj4KPiA+ID4+T24gMDIvMjQvMjAxNiAwOTo0MyBBTSwgTWluZmVpIEh1YW5nIHdyb3RlOgo+
ID4gPj4+T24gMDIvMjMvMTYgYXQgMDE6NDdwbSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3
cm90ZToKPiA+ID4+Pj5IZWxsbywgTWluZmVpLAo+ID4gPj4+Pgo+ID4gPj4+PkRvZXMgaXQgb2Nj
dXIgZXZlcnkgdGltZT8KPiA+ID4+Pj5JZiBub3QsIEkgdGhpbmsgSSBoYXZlIGtub3duIHRoZSBy
ZWFzb24uCj4gPiA+Pj4KPiA+ID4+PkhpLCBXZW5qaWFuLgo+ID4gPj4+Cj4gPiA+Pj5UaGlzIHBh
dGNoIGlzIGFwcGxpZWQgZGlyZWN0bHkgb24gdmVyc2lvbiAxLjUuOS4gQW5kIG1ha2VkdW1wZmls
ZSBoYW5ncwo+ID4gPj4+aWYgb3B0aW9uIG51bS10aHJlYWQgaXMgYXBwZW5kZWQuCj4gPiA+Pj4K
PiA+ID4+Cj4gPiA+Pkkgc2VlLgo+ID4gPj5JJ20gd29ya2luZyBvbiBpdC4KPiA+ID4+Cj4gPiA+
PkJUVywgZGlkIHlvdSBvbmx5IHRlc3QgaXQgd2l0aCAtLW51bS10aHJlYWRzIDEyOD8KPiA+ID4+
SG93IGlzIGl0IHdpdGggLS1udW0tdGhyZWFkcyAzMihvciBzbWFsbGVyIHZhbHVlKT8KPiA+ID4K
PiA+ID5ZZXMuIEkgaGF2ZSB0ZXN0ZWQgd2l0aCBudW0tdGhyZWFkIDEsIDIsIDggYW5kIDMyLiBF
eGNlcHQgZm9yIOKAlG51bS10aHJlYWRzIDEsCj4gPiA+YWxsIG9mIHRoZSB0ZXN0IGZhaWwuCj4g
PiA+Cj4gPiA+VGhhbmtzCj4gPiA+TWluZmVpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==

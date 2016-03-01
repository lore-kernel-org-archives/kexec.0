Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aaedS-00046v-NL
 for kexec@lists.infradead.org; Tue, 01 Mar 2016 07:22:23 +0000
Message-ID: <56D542C5.5060205@cn.fujitsu.com>
Date: Tue, 1 Mar 2016 15:20:37 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] Improve the performance of --num-threads -d 31
References: <1455692739-14878-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20160222165817.GA20170@dhcp-128-25.nay.redhat.com>
 <20160223052616.GA19420@dhcp-128-25.nay.redhat.com>
 <56CBF266.8070107@cn.fujitsu.com>
 <20160224014323.GA23058@dhcp-128-25.nay.redhat.com>
 <56CD1369.3050905@cn.fujitsu.com>
 <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
In-Reply-To: <A315254E-BB2A-46C0-B3C7-0BDAAF89883C@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Minfei Huang <mhuang@redhat.com>
Cc: kexec@lists.infradead.org

SGVsbG8gTWluZmVpLAoKVGhlIG1haWwgSSBzZW50IHRvIHlvdSBhbmQga2V4ZWMgbGlzdCBpcyBo
ZWxkIGJ5IHRoZSBrZXhlYyBsaXN0LgpIYXZlIHlvdSByZWNlaXZlZCBpdD8KU2hvdWxkIEkgcmVz
ZW5kPwoKLS0gClRoYW5rcwpaaG91CgpPbiAwMi8yNC8yMDE2IDEwOjI0IEFNLCBNaW5mZWkgSHVh
bmcgd3JvdGU6Cj4KPj4gT24gRmViIDI0LCAyMDE2LCBhdCAxMDoyMCwgWmhvdSwgV2Vuamlhbi/l
kajmlofliZEgPHpob3V3ai1mbnN0QGNuLmZ1aml0c3UuY29tPiB3cm90ZToKPj4KPj4gSGksCj4+
Cj4+IE9uIDAyLzI0LzIwMTYgMDk6NDMgQU0sIE1pbmZlaSBIdWFuZyB3cm90ZToKPj4+IE9uIDAy
LzIzLzE2IGF0IDAxOjQ3cG0sICJaaG91LCBXZW5qaWFuL+WRqOaWh+WJkSIgd3JvdGU6Cj4+Pj4g
SGVsbG8sIE1pbmZlaSwKPj4+Pgo+Pj4+IERvZXMgaXQgb2NjdXIgZXZlcnkgdGltZT8KPj4+PiBJ
ZiBub3QsIEkgdGhpbmsgSSBoYXZlIGtub3duIHRoZSByZWFzb24uCj4+Pgo+Pj4gSGksIFdlbmpp
YW4uCj4+Pgo+Pj4gVGhpcyBwYXRjaCBpcyBhcHBsaWVkIGRpcmVjdGx5IG9uIHZlcnNpb24gMS41
LjkuIEFuZCBtYWtlZHVtcGZpbGUgaGFuZ3MKPj4+IGlmIG9wdGlvbiBudW0tdGhyZWFkIGlzIGFw
cGVuZGVkLgo+Pj4KPj4KPj4gSSBzZWUuCj4+IEknbSB3b3JraW5nIG9uIGl0Lgo+Pgo+PiBCVFcs
IGRpZCB5b3Ugb25seSB0ZXN0IGl0IHdpdGggLS1udW0tdGhyZWFkcyAxMjg/Cj4+IEhvdyBpcyBp
dCB3aXRoIC0tbnVtLXRocmVhZHMgMzIob3Igc21hbGxlciB2YWx1ZSk/Cj4KPiBZZXMuIEkgaGF2
ZSB0ZXN0ZWQgd2l0aCBudW0tdGhyZWFkIDEsIDIsIDggYW5kIDMyLiBFeGNlcHQgZm9yIOKAlG51
bS10aHJlYWRzIDEsCj4gYWxsIG9mIHRoZSB0ZXN0IGZhaWwuCj4KPiBUaGFua3MKPiBNaW5mZWkK
Pj4KPgo+Cj4KCgoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

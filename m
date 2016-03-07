Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1acitk-0002PC-EJ
 for kexec@lists.infradead.org; Mon, 07 Mar 2016 00:19:44 +0000
Message-ID: <56DCC8AB.5090109@cn.fujitsu.com>
Date: Mon, 7 Mar 2016 08:17:47 +0800
From: =?UTF-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?=
 <zhouwj-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] Improve the performance of --num-threads -d 31
References: <1457080544-16469-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <56D95069.5030903@cn.fujitsu.com>
In-Reply-To: <56D95069.5030903@cn.fujitsu.com>
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
To: Minfei Huang <mhuang@redhat.com>, Minoru Usui <min-usui@ti.jp.nec.com>
Cc: kexec@lists.infradead.org

T24gMDMvMDQvMjAxNiAwNTowNyBQTSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3cm90ZToK
PiBIZWxsbyBNaW5mZWkgYW5kIE1pbm9ydSwKPgo+IFRoaXMgaXMgYSByZXBseSB0byB0aGUgcHJl
dmlvdXMgbGV0dGVycy4KPiBTb3JyeSBmb3Igc28gbGF0ZS4KPiBBbmQgaXQgaXMgYWxzbyBhbiBp
bnRyb2R1Y3Rpb24gb2YgdGhlIHBhdGNoIHYzLgo+Cj4gQWJvdXQgcGVyZm9ybWFuY2U6Cj4gSSBt
b2RpZmllZCB0aGUgcGF0Y2ggYWZ0ZXIgcmVhZGluZyBNaW5vcnUncyBjb2RlLgo+IFRoYW5rcyBN
aW5vcnUsIGl0IGhhcyBiZXR0ZXIgcGVyZm9ybWFuY2Ugbm93Lgo+Cj4gQWJvdXQgYnVnczoKPiBU
aGVyZSBhcmUgdHdvIGJ1Z3MgaW4gdGhlIHBhdGNoIHYyLgo+IEZpcnN0IGlzIHJlcG9ydGVkIGJ5
IE1pbmZlaS4KPiBNaW5vcnUncyBleHBsYW5hdGlvbiBhbmQgc29sdXRpb24gYXJlIHJpZ2h0Lgo+
IEJ1dCBJIHVzZWQgYW5vdGhlciBzb2x1dGlvbi4KPiArICAgICAgICAgICAgaWYgKHBmbiA+PSBr
ZHVtcF90aHJlYWRfYXJncy0+ZW5kX3Bmbikgewo+ICsgICAgICAgICAgICAgICAgcGFnZV9kYXRh
X2J1ZltpbmRleF0udXNlZCA9IEZBTFNFOwo+ICsgICAgICAgICAgICAgICAgcGFnZV9mbGFnX2J1
Zi0+cmVhZHkgPSBGTEFHX1JFQURZOwo+ICsgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKyAgICAg
ICAgICAgIH0KPiBUaGUgYnVnIGlzIGNhdXNlZCBieSB0aGUgYWJvdmUgY29kZS4KPiBKdXN0IHJl
bW92ZSAicGFnZV9mbGFnX2J1Zi0+cmVhZHkgPSBGTEFHX1JFQURZOyIgaXMgT0suCj4KPiBTZWNv
bmQgYnVnIGlzIHdoYXQgSSBtZXQuCj4gSWYgcnVuIG1ha2VkdW1wZmlsZSBhIGxvdCBvZiB0aW1l
cywgYSBmZXcgcGFnZXMnIGRhdGEgd2lsbCBub3QgYmUgY29ycmVjdC4KPiBJIGZpeCBpdCBieSB1
c2luZyAidm9sYXRpbGUiIGFuZCBpbmZvLT5wYWdlX2RhdGFfbXV0ZXguCj4gU28gSSBkZWxldGUg
dGhlIG9yaWdpbmFsIG11dGV4IGluIHBhZ2VfZGF0YV9idWYuIEl0IGNhbiBhbHNvIHVzZSBsZXNz
IG1lbW9yeS4KPiBJIGhhdmUgcnVuIGl0IDUwMCB0aW1lcyBhbmQgaGF2ZW4ndCBnb3QgYW55IHdy
b25nIHBhZ2UgZGF0YS4KPgoKU29ycnksIHRoZSBzZWNvbmQgYnVnIHN0aWxsIGV4aXN0cy4KCgot
LSAKVGhhbmtzClpob3UKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

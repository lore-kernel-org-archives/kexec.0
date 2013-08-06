Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V6cUn-0005Gi-0Y
 for kexec@lists.infradead.org; Tue, 06 Aug 2013 08:19:58 +0000
Message-ID: <5200B185.9010402@cn.fujitsu.com>
Date: Tue, 06 Aug 2013 16:19:17 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: remove unnecessary return
References: <5200AE50.2010108@huawei.com>
In-Reply-To: <5200AE50.2010108@huawei.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Xishi Qiu <qiuxishi@huawei.com>
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, LKML <linux-kernel@vger.kernel.org>

5LqOIDIwMTMvOC82IDE2OjA1LCBYaXNoaSBRaXUg5YaZ6YGTOgo+IENvZGUgY2FuIG5vdCBydW4g
aGVyZSBmb3JldmVyLCBzbyByZW1vdmUgdGhlIHVubmVjZXNzYXJ5IHJldHVybi4KPiAKPiBTaWdu
ZWQtb2ZmLWJ5OiBYaXNoaSBRaXUgPHFpdXhpc2hpQGh1YXdlaS5jb20+Cj4gLS0tCj4gIGtlcm5l
bC9rZXhlYy5jIHwgICAgMiAtLQo+ICAxIGZpbGVzIGNoYW5nZWQsIDAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEva2VybmVsL2tleGVjLmMgYi9rZXJuZWwv
a2V4ZWMuYwo+IGluZGV4IDU5ZjdiNTUuLmMxNGUzZWEgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2tl
eGVjLmMKPiArKysgYi9rZXJuZWwva2V4ZWMuYwo+IEBAIC0xNDc3LDggKzE0NzcsNiBAQCBzdGF0
aWMgaW50IF9faW5pdCBfX3BhcnNlX2NyYXNoa2VybmVsKGNoYXIgKmNtZGxpbmUsCj4gIAllbHNl
Cj4gIAkJcmV0dXJuIHBhcnNlX2NyYXNoa2VybmVsX3NpbXBsZShja19jbWRsaW5lLCBjcmFzaF9z
aXplLAo+ICAJCQkJY3Jhc2hfYmFzZSk7Cj4gLQo+IC0JcmV0dXJuIDA7Cj4gIH0KPiAgCj4gIC8q
Cj4gCgpIaSBYaXNoaSwKCmNoYW5nZQoKMTQ3NCAgICAgICAgIGlmIChmaXJzdF9jb2xvbiAmJiAo
IWZpcnN0X3NwYWNlIHx8IGZpcnN0X2NvbG9uIDwgZmlyc3Rfc3BhY2UpKQoxNDc1ICAgICAgICAg
ICAgICAgICByZXR1cm4gcGFyc2VfY3Jhc2hrZXJuZWxfbWVtKGNrX2NtZGxpbmUsIHN5c3RlbV9y
YW0sCjE0NzYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjcmFzaF9zaXplLCBjcmFz
aF9iYXNlKTsKMTQ3NyAgICAgICAgIGVsc2UKMTQ3OCAgICAgICAgICAgICAgICAgcmV0dXJuIHBh
cnNlX2NyYXNoa2VybmVsX3NpbXBsZShja19jbWRsaW5lLCBjcmFzaF9zaXplLAoxNDc5ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY3Jhc2hfYmFzZSk7CjE0ODAgCjE0ODEgICAgICAg
ICByZXR1cm4gMDsKCnRvCgoxNDc0ICAgICAgICAgaWYgKGZpcnN0X2NvbG9uICYmICghZmlyc3Rf
c3BhY2UgfHwgZmlyc3RfY29sb24gPCBmaXJzdF9zcGFjZSkpCjE0NzUgICAgICAgICAgICAgICAg
IHJldHVybiBwYXJzZV9jcmFzaGtlcm5lbF9tZW0oY2tfY21kbGluZSwgc3lzdGVtX3JhbSwKMTQ3
NiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNyYXNoX3NpemUsIGNyYXNoX2Jhc2Up
OwoKMTQ3OCAgICAgICAgIHJldHVybiBwYXJzZV9jcmFzaGtlcm5lbF9zaW1wbGUoY2tfY21kbGlu
ZSwgY3Jhc2hfc2l6ZSwgY3Jhc2hfYmFzZSk7CgpzZWVtcyBiZXR0ZXIuCi0tIApUaGFua3MuClpo
YW5nIFlhbmZlaQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

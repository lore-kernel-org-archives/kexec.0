Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TdAOY-0003mJ-0T
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 01:55:31 +0000
Message-ID: <50B41D1C.1010802@cn.fujitsu.com>
Date: Tue, 27 Nov 2012 09:53:32 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 1/2] x86/kexec: add a new atomic notifier list for kdump
References: <50ADE0C2.1000106@cn.fujitsu.com> <50ADE11A.401@cn.fujitsu.com>
 <87ip8sxuyh.fsf@xmission.com> <20121126172054.GF12969@redhat.com>
 <87fw3wuuoh.fsf@xmission.com> <20121126175327.GG12969@redhat.com>
 <87mwy4teh8.fsf@xmission.com> <50B41849.9040103@cn.fujitsu.com>
 <87haobolvw.fsf@xmission.com>
In-Reply-To: <87haobolvw.fsf@xmission.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

09ogMjAxMsTqMTHUwjI3yNUgMDk6NDksIEVyaWMgVy4gQmllZGVybWFuINC0tcA6Cj4gWmhhbmcg
WWFuZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4gd3JpdGVzOgo+IAo+PiBTbyBpbiBz
dW1tYXJ5LAo+Pgo+PiAxLiBhIHNwZWNpZmljIGNhbGxiYWNrIGZ1bmN0aW9uIGluc3RlYWQgb2Yg
YSBub3RpZmllcj8KPiAKPiBZZXMuCj4gCj4+IDIuIEluc3RlYWQgb2YgY2FsbGluZyB2bWNsZWFy
X2xvY2FsX2xvYWRlZF92bWNzcywgdGhlIHZtY2xlYXIgb3BlcmF0aW9uCj4+ICAgIHdpbGwganVz
dCBjYWxsIHRoZSB2bWNsZWFyIG9uIGV2ZXJ5IHZtY3NzIGxvYWRlZCBvbiB0aGUgY3B1Pwo+Pgo+
PiAgICBsaWtlIGJlbG93Ogo+Pgo+PiAgICBzdGF0aWMgdm9pZCBjcmFzaF92bWNsZWFyX2xvY2Fs
X2xvYWRlZF92bWNzcyh2b2lkKQo+PiAgICB7Cj4+ICAgICAgICAgaW50IGNwdSA9IHJhd19zbXBf
cHJvY2Vzc29yX2lkKCk7Cj4+ICAgICAgICAgc3RydWN0IGxvYWRlZF92bWNzICp2LCAqbjsKPj4K
Pj4gICAgICAgICBpZiAoIWNyYXNoX2xvY2FsX3ZtY2xlYXJfZW5hYmxlZChjcHUpKQo+PiAgICAg
ICAgICAgICAgICAgcmV0dXJuOwo+Pgo+PiAgICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZSh2LCBuLCAmcGVyX2NwdShsb2FkZWRfdm1jc3Nfb25fY3B1LCBjcHUpLAo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsb2FkZWRfdm1jc3Nfb25fY3B1X2xpbmspCj4+ICAgICAg
ICAgICAgICAgICB2bWNzX2NsZWFyKHYtPnZtY3MpOwo+PiAgICB9Cj4+Cj4+ICAgIHJpZ2h0Pwo+
IAo+IFllYWggdGhhdCBsb29rcyBnb29kLiAgSSB3b3VsZCBkbyBsaXN0X2Zvcl9lYWNoX2VudHJ5
IGJlY2F1c2UgdGhlIGxpc3QKPiBpc24ndCBjaGFuZ2luZy4KCk9LLgoKSSB3aWxsIHVwZGF0ZSB0
aGUgcGF0Y2ggYW5kIHJlc2VuZCBpdC4KClpoYW5nCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK

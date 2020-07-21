Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jy02i-0006Qi-3a
 for kexec@lists.infradead.org; Tue, 21 Jul 2020 21:43:21 +0000
Received: by mail-wm1-x343.google.com with SMTP id 22so42318wmg.1
 for <kexec@lists.infradead.org>; Tue, 21 Jul 2020 14:43:18 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <ec326654-c43b-259c-409c-63929ad5b217@broadcom.com>
Date: Tue, 21 Jul 2020 14:43:07 -0700
MIME-Version: 1.0
In-Reply-To: <20200717174309.1164575-7-keescook@chromium.org>
Content-Language: en-US
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
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Boyd <stephen.boyd@linaro.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Peter Jones <pjones@redhat.com>, "Joel Fernandes (Google)" <joel@joelfernandes.org>, linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Matthew Wilcox <willy@infradead.org>, KP Singh <kpsingh@google.com>, "Serge E. Hallyn" <serge@hallyn.com>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-integrity@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

SGkgS2VlcywKCk9uIDIwMjAtMDctMTcgMTA6NDMgYS5tLiwgS2VlcyBDb29rIHdyb3RlOgo+IElu
IHByZXBhcmF0aW9uIGZvciByZWZhY3RvcmluZyBrZXJuZWxfcmVhZF9maWxlKigpLCByZW1vdmUg
dGhlIHJlZHVuZGFudAo+ICJzaXplIiBhcmd1bWVudCB3aGljaCBpcyBub3QgbmVlZGVkOiBpdCBj
YW4gYmUgaW5jbHVkZWQgaW4gdGhlIHJldHVybgo+IGNvZGUsIHdpdGggY2FsbGVycyBhZGp1c3Rl
ZC4gKFZGUyByZWFkcyBhbHJlYWR5IGNhbm5vdCBiZSBsYXJnZXIgdGhhbgo+IElOVF9NQVguKQo+
Cj4gU2lnbmVkLW9mZi1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4gLS0t
Cj4gICBkcml2ZXJzL2Jhc2UvZmlybXdhcmVfbG9hZGVyL21haW4uYyB8ICA4ICsrKystLS0tCj4g
ICBmcy9rZXJuZWxfcmVhZF9maWxlLmMgICAgICAgICAgICAgICB8IDIwICsrKysrKysrKy0tLS0t
LS0tLS0tCj4gICBpbmNsdWRlL2xpbnV4L2tlcm5lbF9yZWFkX2ZpbGUuaCAgICB8ICA4ICsrKyst
LS0tCj4gICBrZXJuZWwva2V4ZWNfZmlsZS5jICAgICAgICAgICAgICAgICB8IDEzICsrKysrKy0t
LS0tLS0KPiAgIGtlcm5lbC9tb2R1bGUuYyAgICAgICAgICAgICAgICAgICAgIHwgIDcgKysrLS0t
LQo+ICAgc2VjdXJpdHkvaW50ZWdyaXR5L2RpZ3NpZy5jICAgICAgICAgfCAgNSArKystLQo+ICAg
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9pbWFfZnMuYyAgICAgfCAgNSArKystLQo+ICAgNyBmaWxl
cyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfbG9hZGVyL21haW4uYyBiL2RyaXZlcnMvYmFzZS9m
aXJtd2FyZV9sb2FkZXIvbWFpbi5jCj4gaW5kZXggZDRhNDEzZWE0OGNlLi5lYTQxOWM3ZDNkMzQg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9iYXNlL2Zpcm13YXJlX2xvYWRlci9tYWluLmMKPiArKysg
Yi9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfbG9hZGVyL21haW4uYwo+IEBAIC00NjIsNyArNDYyLDcg
QEAgZndfZ2V0X2ZpbGVzeXN0ZW1fZmlybXdhcmUoc3RydWN0IGRldmljZSAqZGV2aWNlLCBzdHJ1
Y3QgZndfcHJpdiAqZndfcHJpdiwKPiAgIAkJCQkJICAgICBzaXplX3QgaW5fc2l6ZSwKPiAgIAkJ
CQkJICAgICBjb25zdCB2b2lkICppbl9idWZmZXIpKQo+ICAgewo+IC0JbG9mZl90IHNpemU7Cj4g
KwlzaXplX3Qgc2l6ZTsKPiAgIAlpbnQgaSwgbGVuOwo+ICAgCWludCByYyA9IC1FTk9FTlQ7Cj4g
ICAJY2hhciAqcGF0aDsKPiBAQCAtNDk0LDEwICs0OTQsOSBAQCBmd19nZXRfZmlsZXN5c3RlbV9m
aXJtd2FyZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UsIHN0cnVjdCBmd19wcml2ICpmd19wcml2LAo+
ICAgCQlmd19wcml2LT5zaXplID0gMDsKPiAgIAo+ICAgCQkvKiBsb2FkIGZpcm13YXJlIGZpbGVz
IGZyb20gdGhlIG1vdW50IG5hbWVzcGFjZSBvZiBpbml0ICovCj4gLQkJcmMgPSBrZXJuZWxfcmVh
ZF9maWxlX2Zyb21fcGF0aF9pbml0bnMocGF0aCwgJmJ1ZmZlciwKPiAtCQkJCQkJICAgICAgICZz
aXplLCBtc2l6ZSwKPiArCQlyYyA9IGtlcm5lbF9yZWFkX2ZpbGVfZnJvbV9wYXRoX2luaXRucyhw
YXRoLCAmYnVmZmVyLCBtc2l6ZSwKPiAgIAkJCQkJCSAgICAgICBSRUFESU5HX0ZJUk1XQVJFKTsK
PiAtCQlpZiAocmMpIHsKPiArCQlpZiAocmMgPCAwKSB7Cj4gICAJCQlpZiAocmMgIT0gLUVOT0VO
VCkKPiAgIAkJCQlkZXZfd2FybihkZXZpY2UsICJsb2FkaW5nICVzIGZhaWxlZCB3aXRoIGVycm9y
ICVkXG4iLAo+ICAgCQkJCQkgcGF0aCwgcmMpOwo+IEBAIC01MDYsNiArNTA1LDcgQEAgZndfZ2V0
X2ZpbGVzeXN0ZW1fZmlybXdhcmUoc3RydWN0IGRldmljZSAqZGV2aWNlLCBzdHJ1Y3QgZndfcHJp
diAqZndfcHJpdiwKPiAgIAkJCQkJIHBhdGgpOwo+ICAgCQkJY29udGludWU7Cj4gICAJCX0KPiAr
CQlzaXplID0gcmM7CkNoYW5nZSBmYWlscyB0byByZXR1cm4gMC7CoCBOZWVkIHJjID0gMDsgaGVy
ZS4KPiAgIAkJZGV2X2RiZyhkZXZpY2UsICJMb2FkaW5nIGZpcm13YXJlIGZyb20gJXNcbiIsIHBh
dGgpOwo+ICAgCQlpZiAoZGVjb21wcmVzcykgewo+ICAgCQkJZGV2X2RiZyhkZXZpY2UsICJmL3cg
ZGVjb21wcmVzc2luZyAlc1xuIiwKPgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

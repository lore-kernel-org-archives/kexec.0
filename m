Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwfeM-0004FT-Im
 for kexec@lists.infradead.org; Sat, 18 Jul 2020 05:44:44 +0000
Received: by mail-wm1-x341.google.com with SMTP id l2so20448642wmf.0
 for <kexec@lists.infradead.org>; Fri, 17 Jul 2020 22:44:41 -0700 (PDT)
Subject: Re: [PATCH 06/13] fs/kernel_read_file: Remove redundant size argument
References: <20200717174309.1164575-1-keescook@chromium.org>
 <20200717174309.1164575-7-keescook@chromium.org>
 <39b2d8af-812f-8c5e-3957-34543add0173@broadcom.com>
 <202007171502.22E12A4E9@keescook>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <99c58d32-da28-79ad-2fdb-83e0ca29660a@broadcom.com>
Date: Fri, 17 Jul 2020 22:44:30 -0700
MIME-Version: 1.0
In-Reply-To: <202007171502.22E12A4E9@keescook>
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

SGkgS2VlcywKCk9uIDIwMjAtMDctMTcgMzowNiBwLm0uLCBLZWVzIENvb2sgd3JvdGU6Cj4gT24g
RnJpLCBKdWwgMTcsIDIwMjAgYXQgMTI6MDQ6MThQTSAtMDcwMCwgU2NvdHQgQnJhbmRlbiB3cm90
ZToKPj4gT24gMjAyMC0wNy0xNyAxMDo0MyBhLm0uLCBLZWVzIENvb2sgd3JvdGU6Cj4+PiBJbiBw
cmVwYXJhdGlvbiBmb3IgcmVmYWN0b3Jpbmcga2VybmVsX3JlYWRfZmlsZSooKSwgcmVtb3ZlIHRo
ZSByZWR1bmRhbnQKPj4+ICJzaXplIiBhcmd1bWVudCB3aGljaCBpcyBub3QgbmVlZGVkOiBpdCBj
YW4gYmUgaW5jbHVkZWQgaW4gdGhlIHJldHVybgo+PiBJIGRvbid0IHRoaW5rIHRoZSBzaXplIGFy
Z3VtZW50IGlzIHJlZHVuZGFudCB0aG91Z2guCj4+IFRoZSBleGlzdGluZyBrZXJuZWxfcmVhZF9m
aWxlIGZ1bmN0aW9ucyBhbHdheXMgcmVhZCB0aGUgd2hvbGUgZmlsZS4KPj4gTm93LCB3aGF0IGhh
cHBlbnMgaWYgdGhlIGZpbGUgaXMgYmlnZ2VyIHRoYW4gdGhlIGJ1ZmZlci4KPj4gSG93IGRvZXMg
a2VybmVsX3JlYWRfZmlsZSBrbm93IGl0IHJlYWQgdGhlIHdob2xlIGZpbGUgYnkgbG9va2luZyBh
dCB0aGUKPj4gcmV0dXJuIHZhbHVlPwo+IFllczsgYW4gZW50aXJlbHkgcmVhc29uYWJsZSBjb25j
ZXJuLiBUaGlzIGlzIHdoeSBJIGFkZCB0aGUgZmlsZV9zaXplCj4gb3V0cHV0IGFyZ3VtZW50IGxh
dGVyIGluIHRoZSBzZXJpZXMuClRoZXJlIGlzIHNvbWV0aGluZyB3cm9uZyB3aXRoIHRoaXMgcGF0
Y2guwqAgSSBhcHBseSBwYXRjaGVzIDEtNSBhbmQgdGhlc2UgCnBhc3MgdGhlIGtlcm5lbCBzZWxm
IHRlc3QuClBhdGNoIDYgZG9lcyBub3QgcGFzcyB0aGUga2VybmVsLXNlbGZ0ZXN0L2Zpcm13YXJl
L2Z3X3J1bl90ZXN0cy5zaAoKPj4+IGNvZGUsIHdpdGggY2FsbGVycyBhZGp1c3RlZC4gKFZGUyBy
ZWFkcyBhbHJlYWR5IGNhbm5vdCBiZSBsYXJnZXIgdGhhbgo+Pj4gSU5UX01BWC4pCj4+PiBbLi4u
XQo+Pj4gLQlpZiAoaV9zaXplID4gU0laRV9NQVggfHwgKG1heF9zaXplID4gMCAmJiBpX3NpemUg
PiBtYXhfc2l6ZSkpIHsKPj4+ICsJaWYgKGlfc2l6ZSA+IElOVF9NQVggfHwgKG1heF9zaXplID4g
MCAmJiBpX3NpemUgPiBtYXhfc2l6ZSkpIHsKPj4gU2hvdWxkIHRoaXMgYmUgU1NJWkVfTUFYPwo+
IE5vLCBmb3IgdHdvIHJlYXNvbnM6IHRoZW4gd2UgbmVlZCB0byBjaGFuZ2UgdGhlIHJldHVybiB2
YWx1ZSBhbmQgbGlrZWx5Cj4gdGhlIGNhbGxlcnMgbmVlZCBtb3JlIGNhcmVmdWwgY2hlY2tzLCBh
bmQgbW9yZSBpbXBvcnRhbnRseSwgYmVjYXVzZSB0aGUKPiBWRlMgYWxyZWFkeSBsaW1pdHMgc2lu
Z2xlIHJlYWQgYWN0aW9ucyB0byBJTlRfTUFYLCBzbyBsaW1pdHMgYWJvdmUgdGhpcwo+IG1ha2Ug
bm8gc2Vuc2UuIFdpbiB3aW4hIDopCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz2yw-0008Dz-Ve
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 19:03:49 +0000
Received: by mail-pj1-x1041.google.com with SMTP id 8so5823436pjj.1
 for <kexec@lists.infradead.org>; Fri, 24 Jul 2020 12:03:44 -0700 (PDT)
Subject: Re: [PATCH v2 15/18] fs/kernel_file_read: Add "offset" arg for
 partial reads
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-16-keescook@chromium.org>
 <c0cf63be-7291-9e8f-b622-00205f0d637a@broadcom.com>
 <202007231131.9704A8B330@keescook>
 <02cffea0-5ed4-05a5-f86d-b6643f32e595@broadcom.com>
 <202007241122.50FD503@keescook> <202007241138.8A3E468@keescook>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <02221f39-ad01-c45d-cc60-a3ffe3d0d284@broadcom.com>
Date: Fri, 24 Jul 2020 12:03:36 -0700
MIME-Version: 1.0
In-Reply-To: <202007241138.8A3E468@keescook>
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
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, linux-security-module@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Aaron Goidel <acgoide@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, selinux@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

SGkgS2VlcywKCk9uIDIwMjAtMDctMjQgMTE6MzkgYS5tLiwgS2VlcyBDb29rIHdyb3RlOgo+IE9u
IEZyaSwgSnVsIDI0LCAyMDIwIGF0IDExOjIzOjM3QU0gLTA3MDAsIEtlZXMgQ29vayB3cm90ZToK
Pj4gT24gVGh1LCBKdWwgMjMsIDIwMjAgYXQgMTA6NDE6MDdQTSAtMDcwMCwgU2NvdHQgQnJhbmRl
biB3cm90ZToKPj4+Cj4+PiBPbiAyMDIwLTA3LTIzIDEyOjE1IHAubS4sIEtlZXMgQ29vayB3cm90
ZToKPj4+PiBPbiBXZWQsIEp1bCAyMiwgMjAyMCBhdCAwMzoyOToyNlBNIC0wNzAwLCBTY290dCBC
cmFuZGVuIHdyb3RlOgo+Pj4+PiBUaGVzZSBjaGFuZ2VzIGRvbid0IHBhc3MgdGhlIGtlcm5lbC1z
ZWxmdGVzdCBmb3IgcGFydGlhbCByZWFkcyBJIGFkZGVkCj4+Pj4+ICh3aGljaCBhcmUgYXQgdGhl
IGVuZCBvZiB0aGlzIHBhdGNoIHYyIHNlcmllcykuCj4+Pj4gT2gsIGludGVyZXN0aW5nLiBJcyB0
aGVyZSBhbnkgZmVlZGJhY2sgaW4gZG1lc2c/IEkgd29uZGVyIGlmIEkgaGF2ZSB0aGUKPj4+PiBM
U01zIGNvbmZpZ3VyZWQgZGlmZmVyZW50bHkgdGhhbiB5b3U/Cj4+PiBJIGhhdmUgbm8gTFNNcyBj
b25maWd1cmVkIHRoYXQgSSBrbm93IG9mLgo+Pj4gWWVzLCB0aGVyZSBpcyBmYWlsdXJlIGluIGRt
ZXNnIHdoaWNoIGlzIGhvdyBJIGRldGVybWluZWQgdG8gYWRkIG15Cj4+PiB3b3JrYXJvdW5kLgo+
Pj4gV2l0aG91dCB3b3JrYXJvdW5kLCBkbWVzZyBsb2cgYXR0YWNoZWQgYWZ0ZXIgYm9vdGluZyBh
bmQgcnVubmluZwo+Pj4gZndfcnVuX3Rlc3RzLmgKPj4+Pj4gU2VlIGNoYW5nZSBiZWxvdyBhZGRl
ZCBmb3IgdGVtcCB3b3JrYXJvdW5kIGZvciBpc3N1ZS4KPj4+Pj4+IFsuLi5dCj4+Pj4+PiArCj4+
Pj4+PiArCXdob2xlX2ZpbGUgPSAob2Zmc2V0ID09IDAgJiYgaV9zaXplIDw9IGJ1Zl9zaXplKTsK
Pj4+Pj4gQSBoYWNrIHRvIGdldCB0aGlzIHBhc3NpbmcgSSBhZGRlZCB3aGljaCBwcm9iYWJseSBi
cmVha3Mgc29tZSBzZWN1cml0eT8KPj4+Pj4gaWYgKHdob2xlX2ZpbGUpIHsKPj4+Pj4+ICsJcmV0
ID0gc2VjdXJpdHlfa2VybmVsX3JlYWRfZmlsZShmaWxlLCBpZCwgd2hvbGVfZmlsZSk7Cj4+Pj4+
PiArCWlmIChyZXQpCj4+Pj4+PiArCQlnb3RvIG91dDsKPj4+Pj4+ICsKPj4+Pj4gfQo+Pj4+IFRo
aXMgd291bGQgaW1wbHkgSSBkaWQgc29tZXRoaW5nIHdyb25nIGluIHRoZSBMU00gaG9vayByZWZh
Y3RvcmluZyAoaS5lLgo+Pj4+IHNvbWUgTFNNIGlzIHJlamVjdGluZyB0aGUgIXdob2xlX2ZpbGUg
Y2FzZSwgYnV0IGlmIHRoZSBlbnRpcmUgY2FsbCB0bwo+Pj4+IHRoZSBob29rcyBhcmUgc2tpcHBl
ZCwgaXQncyBva2F5KS4KPj4+Pgo+Pj4+IFdoYXQgZG9lcyB0aGlzIHJldHVybiBvbiB5b3VyIHRl
c3Qgc3lzdGVtOgo+Pj4+Cj4+Pj4gCWVjaG8gJChjYXQgL3N5cy9rZXJuZWwvc2VjdXJpdHkvbHNt
KQo+Pj4gaW1hIGtlcm5lbCBjb25maWdzIGFyZSBlbmFibGVkIGJ1dCBJIGRvbid0IGVuYWJsZSBz
ZWN1cml0eSBwb2xpY2llcwo+Pj4gb24gdGhlIGtlcm5lbCBjb21tYW5kIGxpbmUuCj4+Pgo+Pj4g
ZWNobyAkKGNhdCAvc3lzL2tlcm5lbC9zZWN1cml0eS9sc20pCj4+PiBjYXQ6IC9zeXMva2VybmVs
L3NlY3VyaXR5L2xzbTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQo+PiBPaCwgZXIuLi4gQ09O
RklHX1NFQ1VSSVRZRlMgaXMgbWlzc2luZz8KPj4KPj4gQ2FuIHlvdSBzZW5kIG1lIHlvdXIgLmNv
bmZpZz8KPiBBaCwgbmV2ZXJtaW5kLCBJIGZvdW5kIG15IGNvbmZpZyBtaXN0YWtlLiBJIHRob3Vn
aHQgSSBoYWQgdGhlIHJpZ2h0Cj4gc2V0dGluZywgYnV0IEknZCBtaXNzZWQgQ09ORklHX0lNQV9B
UFBSQUlTRT15LiBXaXRoIHRoYXQgZW5hYmxlZCwgdGhlCj4gZmlybXdhcmUgdGVzdHMgX2NvcnJl
Y3RseV8gZmFpbCwgc2luY2UgSU1BIGNhbid0IGFwcHJhaXNlIHBhcnRpYWwgcmVhZHMuCj4KPiBT
bywgdGhpcyBkb2Vzbid0IGxvb2sgbGlrZSBhIGJ1ZyB0byBtZS4KPgpOb3cgSSdtIGNvbmZ1c2Vk
LsKgIFRoZSBvcmlnaW5hbCBwYXRjaCBzZXJpZXMgSSBtYWRlIHdpdGggSU1BIGFkZGl0aW9ucyAK
dW5kZXIgTWltaSdzIGRpcmVjdGlvbgpwYXNzZWQgdGhlIGtlcm5lbCBzZWxmdGVzdHMgd2l0aCBw
YXJ0aWFsIHJlYWQuwqAgQW5kIApyZXF1ZXN0X3BhcnRpYWxfZmlybXdhcmVfaW50b19idWYgdGhl
cmVmb3JlIHdvcmtlZC4KWW91ciBjaGFuZ2VzIGRvbid0IHdvcmsgd2l0aCBDT05GSUdfSU1BX0FQ
UFJBSVNFPXkgb24/wqAgSXMgdGhlcmUgYSB3YXkgCnRvIG1ha2UgSU1BIGlnbm9yZSB0aGlzIGZp
bGUgdG8gbWFrZSB0aGluZ3Mgd29yayB0aGVuPwpTZWVtcyBsaWtlIGFub3RoZXIgY2hhbmdlIGlz
IG5lZWRlZCBmb3IgSU1BIHRvIGlnbm9yZSBwYXJ0aWFsIHJlYWRzIGlmIAppdCBjYW4ndCBhcHBy
YWlzZSB0aGVtPwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

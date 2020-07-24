Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyqXW-0001PX-Uh
 for kexec@lists.infradead.org; Fri, 24 Jul 2020 05:46:39 +0000
Received: by mail-pg1-x544.google.com with SMTP id t6so4665815pgq.1
 for <kexec@lists.infradead.org>; Thu, 23 Jul 2020 22:46:38 -0700 (PDT)
Subject: Re: [PATCH v2 15/18] fs/kernel_file_read: Add "offset" arg for
 partial reads
References: <20200722193020.2676422-1-keescook@chromium.org>
 <20200722193020.2676422-16-keescook@chromium.org>
 <c0cf63be-7291-9e8f-b622-00205f0d637a@broadcom.com>
 <354ec0c3-b56d-f5b5-574f-4032fee0b55a@broadcom.com>
 <202007231215.D6E097C@keescook>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <899b7bd3-40d8-73d3-cc04-ac36058aacaf@broadcom.com>
Date: Thu, 23 Jul 2020 22:46:12 -0700
MIME-Version: 1.0
In-Reply-To: <202007231215.D6E097C@keescook>
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

CgpPbiAyMDIwLTA3LTIzIDEyOjE3IHAubS4sIEtlZXMgQ29vayB3cm90ZToKPiBPbiBXZWQsIEp1
bCAyMiwgMjAyMCBhdCAxMToyMzo0M1BNIC0wNzAwLCBTY290dCBCcmFuZGVuIHdyb3RlOgo+PiBJ
IG1hZGUgYW4gYWRqdXN0bWVudCBpbiB0aGUgbG9naWMgb2YgdGhlIGRyaXZlciB3aXRoIHVzZSBv
Zgo+PiByZXF1ZXN0X3BhcnRpYWxfZmlybXdhcmVfaW50b19idWYgYW5kIG5vdyBldmVyeXRoaW5n
IGlzIHdvcmtpbmcuCj4gRXhjZWxsZW50ISBXYXMgdGhlcmUgc29tZXRoaW5nIHdyb25nIHdpdGgg
aG93IEkgcG9ydGVkIHRoZQo+IHJlcXVlc3RfcGFydGlhbF9maXJtd2FyZV9pbnRvX2J1ZigpIGNo
YW5nZXM/IChTaG91bGQgdGhlIGJlaGF2aW9yIGJlCj4gY2hhbmdlZCBpbiBzb21lIHdheT8gSSBk
aWRuJ3QgY2hhbmdlIHRoZSBzZWxmLXRlc3RzLCBzbyBJIHRob3VnaHQgdGhlCj4gYmVoYXZpb3Ig
bWF0Y2hlZCB5b3VyIG9yaWdpbmFsIHNlcmllcy4pClRoZSBjaGFuZ2UgaW4gYmVoYXZpb3VyIGlz
IGZ3LT5md19zaXplIHVzZWQgdG8gaW5kaWNhdGUgdGhlIHBvc2l0aW9uIGluIAp0aGUgZmlsZSBh
ZnRlciB0aGUgcGFydGlhbCByZWFkIGNvbXBsZXRlcy4KWW91ciB2ZXJzaW9uIGhhcyBmdy0+Zndf
c2l6ZSBpbmRpY2F0ZSB0aGUgYW1vdW50IG9mIGRhdGEgcmVhZC4KTm8gbmVlZCBmb3IgeW91IHRv
IGNoYW5nZSBhbnl0aGluZy7CoCBJIGp1c3QgbmVlZCBhIGxvY2FsIHZhcmlhYmxlIG5vdyB0byAK
a2VlcCB0cmFjayBvZiB3aGVyZSBJIGxlZnQgb2ZmIGluIHRoZSBmaWxlLgo+Cj4+IFNvIG9ubHkg
aXNzdWUgSSBmaW5kIHdpdGggdGhpcyBlbnRpcmUgcGF0Y2ggc2VyaWVzIGlzIHRoZSBwcm9ibGVt
Cj4+IG9mIHNlY3VyaXR5IGZhaWxpbmcgd2l0aG91dCB0aGUgd29ya2Fyb3VuZCBiZWxvdy4KPiBZ
dXA7IEknbSB0cnlpbmcgdG8gcmVwcm9kdWNlIHRoaXMgbm93IHRvby4uLgpJIHJlcGxpZWQgaW4g
dGhlIG90aGVyIGVtYWlsIHdpdGggZGV0YWlscyBhbmQgdGhlIGRtZXNnIGxvZy4KPgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK

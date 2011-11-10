Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1ROVRp-0004M5-D0
 for kexec@lists.infradead.org; Thu, 10 Nov 2011 14:17:45 +0000
Received: by iapp10 with SMTP id p10so3674157iap.36
 for <kexec@lists.infradead.org>; Thu, 10 Nov 2011 06:17:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111109160400.cc2d27d9.akpm@linux-foundation.org>
References: <1319639649.3321.11.camel@br98xy6r>
 <20111028161143.e5ebf617.akpm@linux-foundation.org>
 <1320055036.2796.8.camel@br98xy6r>
 <20111031033948.a0edb7f3.akpm@linux-foundation.org>
 <1320314844.2989.6.camel@br98xy6r>
 <20111109160400.cc2d27d9.akpm@linux-foundation.org>
Date: Thu, 10 Nov 2011 22:17:42 +0800
Message-ID: <CAM_iQpVT_z++a9G2H5oCPk8uPiSpfqV_eC=7KA+3nedgaNHz7g@mail.gmail.com>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Don Zickus <dzickus@redhat.com>, linux-arch@vger.kernel.org, "Luck,
 Tony" <tony.luck@intel.com>, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, holzheu@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

T24gVGh1LCBOb3YgMTAsIDIwMTEgYXQgODowNCBBTSwgQW5kcmV3IE1vcnRvbgo8YWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4KPiBIbyBodW0sIEkgZ3Vlc3Mgd2Ugc3RpY2sgd2l0
aCB0aGUgb3JpZ2luYWwgcGF0Y2guIMKgSXQgKnNob3VsZCogd29yaywgYXMKPiBsb25nIGFzIGFs
bCBhcmNodGVjdHVyZXMgYXJlIGRvaW5nIHRoZSBleHBlY3RlZCB0aGluZy4gwqBCdXQgaW4gdGhp
cwo+IHNpdHVhdGlvbiBpdCBpcyBiYWQgb2YgdXMgdG8ganVzdCBob3BlIHRoYXQgdGhlIGFyY2hp
dGVjdHVyZXMgYXJlIGRvaW5nCj4gdGhpcy4gwqBXZSBzaG91bGQgZ28gYW5kIGZpbmQgb3V0LCBy
YXRoZXIgdGhhbiB3YWl0aW5nIGZvciBidWcgcmVwb3J0cwo+IHRvIGNvbWUgaW4uIMKgRXNwZWNp
YWxseSBiZWNhdXNlIGluIHRoaXMgY2FzZSwgYnVncyB3aWxsIHRha2UgYSB2ZXJ5Cj4gbG9uZyB0
aW1lIGluZGVlZCB0byBldmVuIGJlIG5vdGljZWQuCj4KPiBPbmUgd2F5IHRvIHJlc29sdmUgdGhp
cyB3b3VsZCBiZSB0byBhc2sgdGhlIHZhcmlvdXMgYXJjaCBtYWludGFpbmVycyEKCkF0IGxlYXN0
IHdlIGNhbiBhZGQgdGhlIHNwaW5fbG9jayBqdXN0IGZvciB4ODYgYW5kIHMzOTAsIGFuZCBsZWF2
ZQphIGJpZyBjb21tZW50IHNheWluZyB3ZSBhcmUgd2FpdGluZyBmb3IgdGhlIG90aGVyIGFyY2gg
dG8gYmUgZml4ZWQuLi4KClRoYW5rcy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

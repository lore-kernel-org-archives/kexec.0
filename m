Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SWw5Y-0006ch-7v
 for kexec@lists.infradead.org; Tue, 22 May 2012 20:53:53 +0000
Received: by vcbf13 with SMTP id f13so745120vcb.36
 for <kexec@lists.infradead.org>; Tue, 22 May 2012 13:53:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FBB0DB7.3040909@cn.fujitsu.com>
References: <4FB35C48.30708@cn.fujitsu.com>
 <CAG7+5M2nc3qPAS-GvX=YoVKqwdwSGdesoBQ6nsksHp2LFfzYcQ@mail.gmail.com>
 <4FBB0DB7.3040909@cn.fujitsu.com>
Date: Tue, 22 May 2012 13:53:47 -0700
Message-ID: <CAG7+5M3UZBevahU2T0+kESs4kn2Sbbg2fs_itKpVQ_Z8c9od3g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Export offsets of VMCS fields as note information
 for kdump
From: Eric Northup <digitaleric@google.com>
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
To: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, Avi Kivity <avi@redhat.com>, Greg KH <gregkh@linuxfoundation.org>, ebiederm@xmission.com

T24gTW9uLCBNYXkgMjEsIDIwMTIgYXQgODo1MyBQTSwgWWFuZmVpIFpoYW5nCjx6aGFuZ3lhbmZl
aUBjbi5mdWppdHN1LmNvbT4gd3JvdGU6Cj4g09ogMjAxMsTqMDXUwjIyyNUgMDI6NTgsIEVyaWMg
Tm9ydGh1cCDQtLXAOgpbLi4uXQo+PiBTbyB5b3UgY2FuIGhhdmUgdGhlIFZNQ1Mgb2Zmc2V0IGR1
bXBpbmcgYmUgYSBtYW51YWxseS1sb2FkZWQgbW9kdWxlLgo+PiBCdWlsZCBhIGRhdGFiYXNlIG1h
cHBpbmcgZnJvbSAoQ1BVSUQsIG1pY3JvY29kZSByZXZpc2lvbikgLT4gKFZNQ1NJTkZPKS4KPj4g
VGhlcmUncyBubyBuZWVkIGZvciBhbnl0aGluZyBiZXlvbmQgdGhlIChDUFVJRCwgbWljcm9jb2Rl
IHJldmlzaW9uKSB0bwo+PiBiZSBwdXQgaW4gdGhlIGtkdW1wLCBzaW5jZSB5b3VyIG9mZmxpbmUg
cHJvY2Vzc2luZyBvZiBhIGtkdW1wIGNhbiB0aGVuCj4+IGxvb2sgdXAgdGhlIHJlc3QuClsuLi5d
Cj4KPiBXZSBoYXZlIGNvbnNpZGVyZWQgdGhpcyB3YXksIGJ1dCB0aGVyZSBhcmUgdHdvIGlzc3Vl
czoKPiAxKSB2bXggcmVzb3VyY2UgaXMgdW5pcXVlIGZvciBhIHNpbmdsZSBjcHUsIGFuZCBpdCdz
IHJpc2t5IHRvIGdyYWIgaXQgZm9yY2libHkKPiBvbiB0aGUgZW52aXJvbm1lbnQgd2hlcmUga3Zt
IG1vZHVsZSBpcyB1c2VkLCBpbiBwYXJ0aWN1bGFyIG9uIGN1c3RvbWVyJ3MgZW52aXJvbm1lbnQu
Cj4gVG8gZG8gdGhpcyBzYWZlbHksIGt2bSBzdXBwb3J0IGlzIG5lZWRlZC4KCkl0J3Mgbm90IHJp
c2t5OiB5b3UganVzdCBoYXZlIHRvIG1ha2Ugc3VyZSB0aGF0IG5vIG9uZSBlbHNlIGlzIGdvaW5n
CnRvIHVzZSB0aGUgVk1DUyBvbiB5b3VyIENQVSB3aGlsZSB5b3UncmUgcnVubmluZy4gIFlvdSBj
YW4gZGlzYWJsZQpwcmVlbXB0aW9uIGFuZCB0aGVuIHNhdmUgdGhlIG9sZCBWTUNTIHBvaW50ZXIg
ZnJvbSB0aGUgQ1BVIChzZWUgdGhlClZNUFRSU1QgaW5zdHJ1Y3Rpb25zKS4gIExvYWQgeW91ciB0
ZW1wb3JhcnkgVk1DUyBwb2ludGVyLCBkaXNjb3Zlcgp0aGUgZmllbGRzLCB0aGVuIHJlc3RvcmUg
dGhlIG9yaWdpbmFsIFZNQ1MgcG9pbnRlci4gIFRoZW4gcmUtZW5hYmxlCnByZWVtcHRpb24gYW5k
IHlvdSdyZSBkb25lLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

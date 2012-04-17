Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SJxip-0000UJ-4f
 for kexec@lists.infradead.org; Tue, 17 Apr 2012 02:00:48 +0000
Message-ID: <4F8CCCEA.2090706@cn.fujitsu.com>
Date: Tue, 17 Apr 2012 09:52:42 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] ksysfs: export VMCSINFO via sysfs
References: <4F84E0DF.8040206@cn.fujitsu.com>
 <4F84E50E.2090008@cn.fujitsu.com> <20120412230058.GA23292@kroah.com>
In-Reply-To: <20120412230058.GA23292@kroah.com>
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
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, avi@redhat.com, ebiederm@xmission.com

5LqOIDIwMTLlubQwNOaciDEz5pelIDA3OjAwLCBHcmVnIEtIIOWGmemBkzoKPiBPbiBXZWQsIEFw
ciAxMSwgMjAxMiBhdCAwOTo1NzozNEFNICswODAwLCB6aGFuZ3lhbmZlaSB3cm90ZToKPj4gVGhp
cyBwYXRjaCBjcmVhdGVzIHN5c2ZzIGZpbGUgdG8gZXhwb3J0IHdoZXJlIFZNQ1NJTkZPIGlzIGFs
bG9jYXRlZCwKPj4gYXMgYmVsb3c6Cj4+ICAgICAgICAgJCBjYXQgL3N5cy9rZXJuZWwvdm1jc2lu
Zm8KPj4gICAgICAgICAxY2I4OGEwIDIwMDAKPj4gbnVtYmVyIG9uIHRoZSBsZWZ0LWhhbmQgc2lk
ZSBpcyB0aGUgcGh5c2ljYWwgYWRkcmVzcyBvZiBWTUNTSU5GTywKPj4gd2hpbGUgdGhlIG9uZSBv
biB0aGUgcmlnaHQtaGFuZCBzaWRlIGlzIHRoZSBtYXggc2l6ZSBvZiBWTUNTSU5GTy4KPiAKPiBJ
Y2ssIHdoeSBkbyB5b3UgaGF2ZSAyIHZhbHVlcyBpbiBvbmUgc3lzZnMgZmlsZSwgdGhhdCdzIG5v
dCBuaWNlLCBvcgo+IGdvb2QuCj4gCj4gV2hhdCdzIHdyb25nIHdpdGggMiBkaWZmZXJlbnQgZmls
ZXM/Cj4gCgpUaGUgcmVhc29uIHdoeSBJIHB1dCB0aGUgMiB2YWx1ZXMgaW4gb25lIHN5c2ZzIGZp
bGUgaXMgdGhhdCB0aGVyZSBpcyBhIHNpbWlsYXIKZmlsZSAndm1jb3JlaW5mbycgaW4gc3lzZnMu
CiAgICAgICAgIyBjYXQgL3N5cy9rZXJuZWwvdm1jb3JlaW5mbyAKICAgICAgICAxZDc1MzgwIDEw
MDAKTm90aGluZyB3cm9uZyB3aXRoIHR3byBkaWZmZXJlbnQgZmlsZXMsIEkganVzdCB3YW50ZWQg
dG8gZXhwb3J0IHRoZSB2bWNzaW5mbwp3aXRoIHRoZSBpbnRlcmZhY2UgdGhhdCBpcyB0aGUgc2Ft
ZSBhcyB2bWNvcmVpbmZvLiBTbyBsYXRlciBpbiBrZXhlYy10b29scywKdm1jc2luZm8gbm90ZSBp
bmZvcm1hdGlvbiB3aWxsIGJlIGhhbmRsZWQgaW4gYSB2ZXJ5IHNpbWlsYXIgd2F5IGFzIHZtY29y
ZWluZm8Kbm90ZSBpbmZvcm1hdGlvbi4KCj4gQWxzbywgYW55IG5ldyBzeXNmcyBmaWxlIHlvdSBh
ZGQgbmVlZHMgdG8gYWxzbyBoYXZlIGEgRG9jdW1lbnRhdGlvbi9BQkkKPiBlbnRyeSBhZGRlZCBh
cyB3ZWxsLgoKU29ycnkgZm9yIG1pc3NpbmcgdGhpcy4gSSB3aWxsIGFkZCBpdCBpbiBuZXh0IHZl
cnNpb24gb2YgcGF0Y2guCgo+IAo+IEJ1dCB3ZSBjYW4ndCBhY2NlcHQgdGhpcyBhcy1pcywgc29y
cnksIHBsZWFzZSBzcGxpdCBpdCB1cCBpbnRvIDIgZmlsZXMuCj4KIApUaGFua3MKWmhhbmcgWWFu
ZmVpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

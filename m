Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SKRWj-0005I7-QR
 for kexec@lists.infradead.org; Wed, 18 Apr 2012 09:50:18 +0000
Message-ID: <4F8E8E3D.8040707@cn.fujitsu.com>
Date: Wed, 18 Apr 2012 17:49:49 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] Export offsets of VMCS fields as note information
 for kdump
References: <4F84E0DF.8040206@cn.fujitsu.com> <4F8D1F46.3090901@redhat.com>
 <4F8D4B4C.8070705@cn.fujitsu.com> <4F8D4D1C.4010400@redhat.com>
 <4F8E6DA5.8030503@cn.fujitsu.com> <4F8E7A5B.5030904@redhat.com>
In-Reply-To: <4F8E7A5B.5030904@redhat.com>
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
To: Avi Kivity <avi@redhat.com>
Cc: dzickus@redhat.com, luto@mit.edu, gregkh@suse.de, kvm@vger.kernel.org, joerg.roedel@amd.com, mtosatti@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com

5LqOIDIwMTLlubQwNOaciDE45pelIDE2OjI0LCBBdmkgS2l2aXR5IOWGmemBkzoKPiBPbiAwNC8x
OC8yMDEyIDEwOjMwIEFNLCB6aGFuZ3lhbmZlaSB3cm90ZToKPj4+Cj4+PiBPa2F5LiAgRG8geW91
IGV4cGVjdCBpdCB0byBoZWxwIGluIGRlYnVnZ2luZyB0aGUgY3Jhc2g/ICBEaWQgeW91IGhhdmUK
Pj4+IGNhc2VzIHdoZXJlIGl0IHdvdWxkIGhlbHA/Cj4+Pgo+Pgo+PiBZZXMsIEkgZG8gZXhwZWN0
IGl0IHRvIGhlbHAgaW4gZGVidWdnaW5nIHRoZSBjcmFzaC4KPj4gTG9va2luZyBpbnRvIGhvc3Qg
bWFjaGluZSdzIGNyYXNoIGR1bXAsIGlmIHdlIGZpZ3VyZSBvdXQgdGhlIGZhY3QgdGhhdCB0aGUg
Y3Jhc2gKPj4gaGFkIGhhcHBlbmQgd2hlbiBzb21lIGhvc3QncyByZXNvdXJjZSB3YXMgcmVxdWVz
dGVkIGFuZCB1c2VkIGJ5IHNvbWUgZ3VzZXQgbWFjaGluZS4KPj4gVGhlbiwgd2Ugc3VyZWx5IHdh
bnQgdG8gbG9vayBpbnRvIHRoZSBzaXR1YXRpb24gZnJvbSBndWVzdCBtYWNoaW5lJ3Mgdmlldy4K
Pj4KPj4KPiAKPiBXaGF0IHR5cGUgb2YgcmVzb3VyY2U/ICBDYW4geW91IGdpdmUgYW4gZXhhbXBs
ZT8KPiAKU29ycnkuIE5vIGNvbmNyZXRlIGV4YW1wbGUgZm9yIG5vdy4KCldlIGFyZSBkZXZlbG9w
aW5nIHRoaXMgb24gYSBjb25zZXJ2YXRpdmUgcG9saWN5IGFuZCBJIGhhdmUgcHV0IHRoZSB2bWNz
IHByb2Nlc3NpbmcKaW4gYSBuZXcgbW9kdWxlIGluIHBhdGNoIHNldCB2MiBhcyB5b3UgcmVxdWly
ZWQuIFRoZSBuZXcgbW9kdWxlIGlzIGF1dG8tbG9hZGVkIHdoZW4KdGhlIHZteCBjcHVmZWF0dXJl
IGlzIGRldGVjdGVkIGFuZCBpdCBkZXBlbmRzIG9uIG1vZHVsZSBrdm0taW50ZWwuIExvYWRpbmcg
YW5kIHVubG9hZGluZwp0aGlzIG1vZHVsZSB3aWxsIGhhdmUgbm8gc2lkZSBlZmZlY3Qgb24gdGhl
IHJ1bm5pbmcgZ3Vlc3RzLgoKQW5kIG9uZSB0aGluZyBJIGhhdmUgdG8gc3RyZXNzIGlzIHRoYXQs
IHdlIGNhbiBzZWUgZ3Vlc3QgaW1hZ2UgYXMgY3Jhc2ggZHVtcCBmcm9tCmd1ZXN0IG1hY2hpbmUn
cyB2aWV3IGlmIHdlIGhhdmUgdGhlIHZtY3NpbmZvLCB0aGlzIGl0c2VsZiBpcyB1c2VmdWwuCgpU
aGFua3MKWmhhbmcgWWFuZmVpCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

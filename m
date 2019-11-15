Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iVPJf-0006hP-2w
 for kexec@lists.infradead.org; Fri, 15 Nov 2019 00:18:24 +0000
Subject: Re: [PATCH 3/3 v9] kexec: Fix i386 build warnings that missed
 declaration of struct kimage
References: <20191108090027.11082-1-lijiang@redhat.com>
 <20191108090027.11082-4-lijiang@redhat.com> <20191114123920.GA7222@zn.tnic>
 <59fbd119-495a-4d00-9738-98c22b276c1f@redhat.com>
 <20191114144353.GB7222@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <16a61f4d-a112-6766-0272-9cfd65e78503@redhat.com>
Date: Fri, 15 Nov 2019 08:18:02 +0800
MIME-Version: 1.0
In-Reply-To: <20191114144353.GB7222@zn.tnic>
Content-Language: en-US
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Borislav Petkov <bp@alien8.de>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, horms@verge.net.au, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, d.hatayama@fujitsu.com, vgoyal@redhat.com

5ZyoIDIwMTnlubQxMeaciDE05pelIDIyOjQzLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFRodSwgTm92IDE0LCAyMDE5IGF0IDEwOjIwOjQyUE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEkgcmVhbGx5IHNhdyBteSBidWlsZGluZyByZXN1bHQsIGJ1dCBrYnVpbGQgcmVwb3J0ZWQgdGhl
IGZvbGxvd2luZyBtZXNzYWdlczoKPj4KPj4gdmltICs1IGFyY2gveDg2L2luY2x1ZGUvYXNtL2Ny
YXNoLmgKPj4KPj4gZGQ1ZjcyNjA3NmNjNzYgVml2ZWsgR295YWwgMjAxNC0wOC0wOCAgIDQgIAo+
PiBkZDVmNzI2MDc2Y2M3NiBWaXZlayBHb3lhbCAyMDE0LTA4LTA4ICBANSAgaW50IGNyYXNoX2xv
YWRfc2VnbWVudHMoc3RydWN0IGtpbWFnZSAqaW1hZ2UpOwo+PiBkZDVmNzI2MDc2Y2M3NiBWaXZl
ayBHb3lhbCAyMDE0LTA4LTA4ICAgNiAgaW50IGNyYXNoX2NvcHlfYmFja3VwX3JlZ2lvbihzdHJ1
Y3Qga2ltYWdlICppbWFnZSk7Cj4+IGRkNWY3MjYwNzZjYzc2IFZpdmVrIEdveWFsIDIwMTQtMDgt
MDggICA3ICBpbnQgY3Jhc2hfc2V0dXBfbWVtbWFwX2VudHJpZXMoc3RydWN0IGtpbWFnZSAqaW1h
Z2UsCj4+IGRkNWY3MjYwNzZjYzc2IFZpdmVrIEdveWFsIDIwMTQtMDgtMDggICA4ICAJCXN0cnVj
dCBib290X3BhcmFtcyAqcGFyYW1zKTsKPj4gODlmNTc5Y2U5OWY3ZTAgWWkgV2FuZyAgICAgMjAx
OC0xMS0yMiAgIDkgIHZvaWQgY3Jhc2hfc21wX3NlbmRfc3RvcCh2b2lkKTsKPj4gZGQ1ZjcyNjA3
NmNjNzYgVml2ZWsgR295YWwgMjAxNC0wOC0wOCAgMTAgIAo+Pgo+PiA6Ojo6OjogVGhlIGNvZGUg
YXQgbGluZSA1IHdhcyBmaXJzdCBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCAKPj4gICAgICAgIF5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl4KPj4gOjo6Ojo6IGRk
NWY3MjYwNzZjYzc2MzlkOTcxM2IzMzRjOGMxMzNmNzdjNjc1N2Ega2V4ZWM6IHN1cHBvcnQgZm9y
IGtleGVjIG9uIHBhbmljIHVzaW5nIG5ldyBzeXN0ZW0gY2FsbAo+PiAgICAgICAgXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eCj4gCj4gWW91IHNob3VsZCBub3QgdGFrZSB0
aGUgcmVwb3J0IG9mIGEgYm90IGJsaW5kbHkgYnV0IHNob3VsZCBhbHdheXMgZG91YmxlCj4gY2hl
Y2sgaXQuIExpa2UgZXZlcnkgb3RoZXIgY29tcHV0ZXIgc3lzdGVtIHByb2dyYW1tZWQgYnkgaHVt
YW5zLCBpdCBjYW4KPiBtYWtlIG1pc3Rha2VzLgo+IAoKSW5kZWVkLCBpIHRvdGFsbHkgYWdyZWUu
Cgo+PiBXb3VsZCB5b3UgbWluZCBnaXZpbmcgbWUgYW55IHN1Z2dlc3Rpb25zIGFib3V0IHRoaXM/
Cj4gCj4gSSdsbCB0YWtlIGNhcmUgb2YgaXQgYWxsIGFuZCBwdXNoIHRoZSByZXN1bHRzIG91dCBz
b29uLgo+IAoKT0ssIHRoYW5rIHlvdSBzbyBtdWNoLgoKTGlhbmJvCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=

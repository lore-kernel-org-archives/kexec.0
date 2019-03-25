Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8G1w-0002yj-EC
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 03:12:13 +0000
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com> <20190322175114.GL12472@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
Date: Mon, 25 Mar 2019 11:11:45 +0800
MIME-Version: 1.0
In-Reply-To: <20190322175114.GL12472@zn.tnic>
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
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwM+aciDIz5pelIDAxOjUxLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFRodSwgTWFyIDIxLCAyMDE5IGF0IDA2OjMzOjA3UE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90
ZToKPj4gRm9sbG93aW5nIHRoZSBjb21taXQgPDBlNGMxMmI0NWFhOD4gKCJ4ODYvbW0sIHJlc291
cmNlOiBVc2UKPj4gUEFHRV9LRVJORUwgcHJvdGVjdGlvbiBmb3IgaW9yZW1hcCBvZiBtZW1vcnkg
cGFnZXMiKSwKPiAKPiBUaGUgcHJvcGVyIGNvbW1pdCBxdW90YXRpb24gZm9ybWF0IGlzIGRvbmUg
YnkgYWRkaW5nIHRoaXMgdG8geW91cgo+IC5naXRjb25maWc6Cj4gCj4gW2NvcmVdCj4gICAgICAg
ICBhYmJyZXYgPSAxMgo+IFthbGlhc10KPiAgICAgICAgIG9uZSA9IHNob3cgLXMgLS1wcmV0dHk9
J2Zvcm1hdDolaCAoXCIlc1wiKScKPiAKPiBhbmQgdGhlbiBkb2luZzoKPiAKPiAkIGdpdCBvbmUg
PGNvbW1pdCBpZD4KPiAKPiB3aGljaCB3aWxsIGdpdmUgeW91Cj4gCj4gMGU0YzEyYjQ1YWE4ICgi
eDg2L21tLCByZXNvdXJjZTogVXNlIFBBR0VfS0VSTkVMIHByb3RlY3Rpb24gZm9yIGlvcmVtYXAg
b2YgbWVtb3J5IHBhZ2VzIikKCk5pY2UuIEkgYWRkZWQgdGhlbSB0byBteSAuZ2l0Y29uZmlnLiBJ
dCB3b3Jrcy4gVGhhbmsgeW91IHZlcnkgbXVjaC4KCj4gCj4+IGhlcmUgaXQgaXMgcmVhbGx5IGNo
ZWNraW5nIGZvciB0aGUgJ0lPUkVTX0RFU0NfQUNQSV8qJyB2YWx1ZXMuCj4gCj4gV2VsbCwgaXQg
aXMgbm90IHJlYWxseSBjaGVja2luZyB0aGF0LgoKSSBtZWFuIGl0IG5lZWRzIHRvIGZpbmQgYWxs
IHRoZSB2YWx1ZSBvZiB0aGUgJ0lPUkVTX0RFU0NfQUNQSV8qJyB0eXBlLgoKPiAKPj4gVGhlcmVm
b3JlLCBpdCBpcyBuZWNlc3NhcnkgdG8gY2hhbmdlIHRoZSBleGFtaW5hdGlvbiBjb25kaXRpb24K
Pj4gdG8gYXZvaWQgY29uZnVzaW9uLgo+IAo+IFdoYXQgY29uZnVzaW9uPwoKQXMgYWJvdmUgbWVu
dGlvbmVkLCBpdCBuZWVkcyB0byBmaW5kIGFsbCB0aGUgdmFsdWUgb2YgdGhlICdJT1JFU19ERVND
X0FDUElfKicKdHlwZSwgc28gd2Ugc2hvdWxkIGV4cGxpY2l0bHkgdXNlIHRoZSAnSU9SRVNfREVT
Q19BQ1BJXyonIHR5cGUgYXMgdGhlIGNoZWNrCmNvbmRpdGlvbiBpbnN0ZWFkIG9mIHRoZSAnSU9S
RVNfREVTQ19OT05FJy4KClRoYW5rcy4KTGlhbmJvCgo+IAo+IFRoZSBqdXN0aWZpY2F0aW9uIGZv
ciB0aGF0IGNoYW5nZSBzb3VuZHMgcmVhbGx5IGZpc2h5Lgo+IAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwo=

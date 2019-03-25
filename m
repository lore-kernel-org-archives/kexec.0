Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8Lmv-0002KJ-8R
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 09:21:03 +0000
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com> <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
 <20190325064046.GB12016@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <dd7b5fb6-bd77-61a2-afa5-d52137c24cbd@redhat.com>
Date: Mon, 25 Mar 2019 17:20:43 +0800
MIME-Version: 1.0
In-Reply-To: <20190325064046.GB12016@zn.tnic>
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

5ZyoIDIwMTnlubQwM+aciDI15pelIDE0OjQwLCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgTWFyIDI1LCAyMDE5IGF0IDExOjExOjQ1QU0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEkgbWVhbiBpdCBuZWVkcyB0byBmaW5kIGFsbCB0aGUgdmFsdWUgb2YgdGhlICdJT1JFU19ERVND
X0FDUElfKicgdHlwZS4KPiAKPiBBIGZ1bmN0aW9uIGNhbGxlZCBfX2lvcmVtYXBfY2hlY2tfZGVz
Y19vdGhlcigpIG5lZWRzIHRvIGZpbmQKPiBJT1JFU19ERVNDX0FDUElfKiB0eXBlcy4uLgo+IAo+
IE5vLCBzdGlsbCBkb24ndCBrbm93IHdoYXQgeW91J3JlIHRyeWluZyB0byBkby4KCkxldCdzIGxv
b2sgYXQgdGhlIGRpc2N1c3Npb24gaW4gcGF0Y2ggdjgsIHBsZWFzZSByZWZlciB0byB0aGlzIGxp
bms6Cmh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzMvMTYvMTUKCkkgZGlkIGEgdGVzdCBhY2Nv
cmRpbmcgdG8gVG9tJ3MgcmVwbHksIGFuZCB0aGUgdGVzdCBpbmRpY2F0ZWQgaGlzIHN1Z2dlc3Rp
b24gd2FzCmNvcnJlY3QsIHdlIHNob3VsZCBjaGFuZ2UgdGhpcyB0byBjaGVjayBmb3IgSU9SRVNf
REVTQ19BQ1BJXyogdmFsdWVzLgoKPiAKPj4gQXMgYWJvdmUgbWVudGlvbmVkLCBpdCBuZWVkcyB0
byBmaW5kIGFsbCB0aGUgdmFsdWUgb2YgdGhlICdJT1JFU19ERVNDX0FDUElfKicKPj4gdHlwZSwg
c28gd2Ugc2hvdWxkIGV4cGxpY2l0bHkgdXNlIHRoZSAnSU9SRVNfREVTQ19BQ1BJXyonIHR5cGUg
YXMgdGhlIGNoZWNrCj4+IGNvbmRpdGlvbiBpbnN0ZWFkIG9mIHRoZSAnSU9SRVNfREVTQ19OT05F
Jy4KPiAKPiBBbmQgbm93IHRoZSBzYW1lIHF1ZXN0aW9uIEknbSBhc2tpbmcgeW91IGVhY2ggdGlt
ZTogV0hZIGRvZXMgaXQgbmVlZCB0byBmaW5kCj4gdGhlIEFDUEkgdHlwZXM/Cj4gCgpXaGVuIFNF
ViBpcyBlbmFibGVkIGFuZCB0aGUgcGFnZSBiZWluZyBtYXBwZWQgaXMgaW4gbWVtb3J5LCBuZWVk
IHRvIGVuc3VyZSB0aGUKbWVtb3J5IGVuY3J5cHRpb24gYXR0cmlidXRlIGlzIGFsc28gZW5hYmxl
ZCBpbiB0aGUgcmVzdWx0aW5nIG1hcHBpbmcuCgpJIGJlbGlldmUgVG9tIGtub3dzIGJldHRlciB0
aGFuIG1lLiA6LSkKClRoYW5rcy4KTGlhbmJvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==

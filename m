Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h9Va8-0004eZ-Ip
 for kexec@lists.infradead.org; Thu, 28 Mar 2019 14:00:39 +0000
Subject: Re: [PATCH 2/3 v9] resource: add the new I/O resource descriptor
 'IORES_DESC_RESERVED'
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-3-lijiang@redhat.com> <20190322192800.GM12472@zn.tnic>
 <47bfcbe2-1631-9733-74c2-fb3e56540052@redhat.com>
 <20190325122426.GK12016@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <86919dfe-ab72-efef-8304-b2608078d320@redhat.com>
Date: Thu, 28 Mar 2019 22:00:01 +0800
MIME-Version: 1.0
In-Reply-To: <20190325122426.GK12016@zn.tnic>
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

5ZyoIDIwMTnlubQwM+aciDI15pelIDIwOjI0LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IE1vbiwgTWFyIDI1LCAyMDE5IGF0IDAyOjUzOjAyUE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEluIHRoaXMgZnVuY3Rpb24sIGkgcHJpbnRlZCBpdHMgdmFsdWVzLCBhbmQgb25seSBnb3QgdGhl
IHZhbHVlIG9mIHJlc2VydmVkCj4+IHR5cGUsIHNvIGkgY2hhbmdlZCB0aGUgSU9SRVNfREVTQ19O
T05FIHRvIHRoZSBJT1JFU19ERVNDX1JFU0VSVkVELgo+Pgo+PiBJbiBhZGRpdGlvbiwgYWZ0ZXIg
dGhlIG5ldyBkZXNjcmlwdG9yICdJT1JFU19ERVNDX1JFU0VSVkVEJyBpcyBpbnRyb2R1Y2VkLAo+
PiB0aGUgSU9SRVNfREVTQ19OT05FIGRvZXMgbm90IGluY2x1ZGUgdGhlIElPUkVTX0RFU0NfUkVT
RVJWRUQgYW55IG1vcmUsIGl0Cj4+IGNvdWxkIG1pc3MgdG8gaGFuZGxlIHRoZSB2YWx1ZSBvZiB0
aGUgcmVzZXJ2ZWQgdHlwZS4KPiAKPiBZZXMsIElPUkVTX0RFU0NfUkVTRVJWRUQgaXMgc3VwcG9z
ZWQgdG8gZGVub3RlIHRoZSBlODIwIHJlc2VydmVkIHR5cGUuCj4gV2h5IHNob3VsZCBJT1JFU19E
RVNDX05PTkUgaW5jbHVkZSBpdCA/IT8hCj4gCj4gSU9SRVNfREVTQ19OT05FIGlzLCB3ZWxsLCBh
biBpbnZhbGlkLCBpLmUuLCAibm9uZSIgdHlwZToKClllcywgaSBzZWUuIFRoYXQgaW5kaWNhdGVz
IGFuIGVtcHR5IGFyZWEsIG9yICJ2b2lkIiB0eXBlLgoKPiAKPiAvKgo+ICAqIEkvTyBSZXNvdXJj
ZSBEZXNjcmlwdG9ycwo+ICAqCj4gICogRGVzY3JpcHRvcnMgYXJlIHVzZWQgYnkgd2Fsa19pb21l
bV9yZXNfZGVzYygpIGFuZCByZWdpb25faW50ZXJzZWN0cygpCj4gICogZm9yIHNlYXJjaGluZyBh
IHNwZWNpZmljIHJlc291cmNlIHJhbmdlIGluIHRoZSBpb21lbSB0YWJsZS4gIEFzc2lnbgo+ICAq
IGEgbmV3IGRlc2NyaXB0b3Igd2hlbiBhIHJlc291cmNlIHJhbmdlIHN1cHBvcnRzIHRoZSBzZWFy
Y2ggaW50ZXJmYWNlcy4KPiAgKiBPdGhlcndpc2UsIHJlc291cmNlLmRlc2MgbXVzdCBiZSBzZXQg
dG8gSU9SRVNfREVTQ19OT05FICgwKS4KPiAgKi8KPiAKPj4gRG8geW91IG1lYW4gaSBzaG91bGQg
bmV2ZXIgdG91Y2ggdGhlIHRocmVlIGNodW5rcz8gSWYgaSBtYWRlIGEgbWlzdGFrZSwgaQo+PiB3
aWxsIHJlbW92ZSB0aGlzIGNoYW5nZXMgbmV4dCBwb3N0Lgo+IAo+IEknbSBsb29raW5nIGF0IHRo
ZSBodW5rcyBiZWxvdyBhbmQgeW91J3JlIGNoYW5naW5nIC0+ZGVzYyBhc3NpZ25tZW50cyBpbgo+
IHNvbWUgcmFuZG9tIGZ1bmN0aW9uIHdoaWNoIGRvZXNuJ3QgbG9vayBsaWtlIHlvdSBrbm93IHdo
YXQgeW91J3JlIGRvaW5nLgo+IE1heWJlIGl0IGdldHMgeW91IHdoYXQgeW91IHdhbnQgYnV0IGl0
IHN1cmUgYXMgaGVsbCBkb2Vzbid0IGxvb2sgcmlnaHQKPiB0byBtZS4KPiAKSSBoYXZlIHJlYWxp
emVkIHRoYXQgdGhlcmUgY291bGQgYmUgYSBwcm9ibGVtIHdpdGggdGhpcyBjaGFuZ2VzLiBJbmRl
ZWQsIGhlcmUKaXQgZGVub3RlcyBhbiBlbXB0eSBhcmVhIGluc3RlYWQgb2YgYSByZXNlcnZlZCBh
cmVhLgoKQlRXOiBMb29rcyBsaWtlIHRoZSBuYW1lIG9mIHRoaXMgZnVuY3Rpb24oX19yZXNlcnZl
X3JlZ2lvbl93aXRoX3NwbGl0KSBpcyBhIGJpdAptaXNsZWFkaW5nLgoKVGhhbmsgeW91IGZvciBw
b2ludGluZyBvdXQgdGhpcyBwcm9ibGVtLCBpIHdpbGwgY29ycmVjdCB0aGVtIG5leHQgcG9zdC4K
CkxpYW5ibwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
a2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

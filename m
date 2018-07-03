Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faJjy-0001Fd-1m
 for kexec@lists.infradead.org; Tue, 03 Jul 2018 11:45:03 +0000
Subject: Re: [PATCH 1/5 V5] Add a function(ioremap_encrypted) for kdump when
 AMD sme enabled
References: <20180702072639.10110-1-lijiang@redhat.com>
 <20180702072639.10110-2-lijiang@redhat.com> <20180702101451.GB28730@zn.tnic>
 <4ae1cfb5-0a4b-2aac-2575-024e2c74826f@redhat.com>
 <895db996-febd-d50c-91af-4f1ef3d27bd8@redhat.com>
 <20180703111428.GB5748@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <4fbb843b-9597-a48b-8b6f-00e354b91950@redhat.com>
Date: Tue, 3 Jul 2018 19:44:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180703111428.GB5748@zn.tnic>
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
Cc: thomas.lendacky@amd.com, bhe@redhat.com, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com

5ZyoIDIwMTjlubQwN+aciDAz5pelIDE5OjE0LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFR1ZSwgSnVsIDAzLCAyMDE4IGF0IDA2OjU4OjE0UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IEZvciBrZHVtcCwgdGhlIGVsZiBoZWFkZXIgZmluYWxseSB1c2UgdGhlIGNyYXNoIGtlcm5lbCBy
ZXNlcnZlZCBtZW1vcnksIGl0IGlzIG5vdCBhbiBvbGQgbWVtb3J5Lgo+IAo+IExhbW1lIHJlcGVh
dCBteSBzdWdnZXN0aW9uOgo+IAo+IFNvIGJlZWYgdXAgdGhlIGxvZ2ljIGluIF9faW9yZW1hcF9j
YWxsZXIoKSB0byBmaWd1cmUgb3V0IGJhc2VkIG9uIHRoZQo+IGFkZHJlc3Mgd2hldGhlciB0byBh
Y2Nlc3MgdGhlIG1lbW9yeSBlbmNyeXB0ZWQgb3Igbm90LiBJbiBnZW5lcmFsLCB5b3UKPiBjYW4g
ZGVkdWNlLCBiYXNlZCBvbiB0aGUgcmVnaW9uIHlvdSdyZSBtYXBwaW5nLCB3aGV0aGVyIHlvdSBu
ZWVkIHRvIG1hcAo+IGluIGVuY3J5cHRlZCBvciBkZWNyeXB0ZWQuCj4gCj4gRm9yIGV4YW1wbGU6
Cj4gCj4gICAgICAgICBhZGRyID0gZWxmY29yZWhkcl9hZGRyOwo+IAo+ICAgICAgICAgLyogUmVh
ZCBFbGYgaGVhZGVyICovCj4gICAgICAgICByYyA9IGVsZmNvcmVoZHJfcmVhZCgoY2hhciAqKSZl
aGRyLCBzaXplb2YoRWxmNjRfRWhkciksICZhZGRyKTsKPiAgICAgICAgIGlmIChyYyA8IDApCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByYzsKPiAKPiBlbGZjb3JlaGRyX2FkZHIgaGFzIHRoYXQg
ZWxmY29yZWhkciBhZGRyZXNzLiBTbyB5b3UgY2FuIGNoZWNrIHdoaWNoIGFkZHJlc3MKPiB5b3Un
cmUgbWFwcGluZyBhbmQgZG86Cj4gCj4gX19pb3JlbWFwX2NhbGxlcjoKPiAKPiAuLi4KPiAJcHJv
dCA9IF9faW9yZW1hcF9jb21wdXRlX3Byb3QoLi4uKTsKPiAKPiBhbmQgdGhhdCBfX2lvcmVtYXBf
Y29tcHV0ZV9wcm90KCkgZnVuY3Rpb24gd2hpY2ggeW91IHdpbGwgYWRkIHdpbGwgaGF2ZQo+IGFs
bCB0aGF0IGxvZ2ljIHRvIGRldGVybWluZSBlbmNyeXB0ZWQgb3Igbm90IGJ5IGNvbXBhcmluZyBh
ZGRyZXNzZXMgZXRjLgo+IAo+IERvZXMgdGhhdCBtYWtlIG1vcmUgc2Vuc2U/Cj4gClRoYW5rIHlv
dSwgQm9yaXMuIEdvb2QgaWRlYSwgSSB3aWxsIHJldGhpbmsgYWJvdXQgdGhpcyBpc3N1ZSBhbmQg
cG9zdCBpdCBhZ2Fpbi4KClJlZ2FyZHMsCkxpYW5ibwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZN2Jm-0002bR-5P
 for kexec@lists.infradead.org; Wed, 05 Aug 2015 17:17:30 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20150724011615.6834.79628.stgit@softrs>
 <55BF4B1F.9000602@hitachi.com> <877fpcfi2j.fsf@x220.int.ebiederm.org>
 <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
Date: Wed, 05 Aug 2015 12:10:06 -0500
In-Reply-To: <04EAB7311EE43145B2D3536183D1A84454926993@GSjpTKYDCembx31.service.hitachi.net>
 (=?utf-8?B?Iuays+WQiOiLseWujw==?= / =?utf-8?Q?KAWAI=EF=BC=8CHIDEHIRO=22's?=
 message of "Tue, 4 Aug 2015 11:41:14 +0000")
Message-ID: <87io8tvez5.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [RFC V2 PATCH 0/1] kexec: crash_kexec_post_notifiers boot option
 related fixes
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
To: =?utf-8?B?5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTw==?= <hidehiro.kawai.ez@hitachi.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, =?utf-8?B?5bmz5p2+6ZuF?= =?utf-8?B?5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Daniel Walker <dwalker@fifo99.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

Iuays+WQiOiLseWujyAvIEtBV0FJ77yMSElERUhJUk8iICA8aGlkZWhpcm8ua2F3YWkuZXpAaGl0
YWNoaS5jb20+IHdyaXRlczoKCj4gSGVsbG8sCj4KPiBUaGFua3MgZm9yIHRoZSByZXBseS4KPgo+
PiBGcm9tOiBFcmljIFcuIEJpZWRlcm1hbiBbbWFpbHRvOmViaWVkZXJtQHhtaXNzaW9uLmNvbV0K
PiBbLi4uXQo+PiBBIHNwZWNpZmljIGhvb2sgZm9yIGEgdmVyeSBzcGVjaWZpYyBwdXJwb3NlIHdo
ZW4gdGhlcmUgaXMgbm8gb3RoZXIgd2F5Cj4+IHdlIGNhbiBjb25zaWRlci4KPgo+IFNvLCBpcyBr
bXNnX2R1bXAgbGlrZSBmZWF0dXJlIGFkbWlzc2libGU/Cj4KPj4gSWYgeW91IGRvbid0IGhhdmUg
c29tZXRoaW5nIHRoYXQgZ2VuZXJhbGlzZXMgd2VsbCBpbnRvIGEgZ2VuZXJhbCBwdXJwb3NlCj4+
IG9wZXJhdGlvbiB0aGF0IGl0IG1ha2VzIHNlbnNlIGZvciBldmVyeW9uZSB0byBjYWxsIHlvdSBj
YW4gYWx3YXlzIHVzZQo+PiB0aGUgd29ybGQncyBsYXJnZXN0IGFrYSB5b3UgY2FuIHJ1biBjb2Rl
IGJlZm9yZSB0aGUgbmV3IGtlcm5lbCBzdGFydHMKPj4gdGhhdCBpcyBsb2FkZWQgd2l0aCBrZXhl
Y19sb2FkLgo+Cj4gT25lIG9mIG91ciBwdXJwb3Nlcywgbm90aWZ5aW5nICJJJ20gZHlpbmciLCB3
b3VsZCBiZSBhY2hpZXZlZCBieSBwdXJnYXRvcnkKPiBjb2RlIHByb3ZpZGVkIGJ5IGtleGVjIGNv
bW1hbmQgYXMgSSBzdGF0ZWQgYmVmb3JlLiAgU2luY2UgdGhlIHdheSBvZiB0aGUKPiBub3RpZmlj
YXRpb24gd2lsbCBkaWZmZXIgZnJvbSBlYWNoIHZlbmRvciwgSSB0aGluayB3ZSBuZWVkIHRvIG1v
ZGlmeQo+IHRoZSBwdXJnYXRvcnkgY29kZXMgcGx1Z2dhYmxlLiAgQWxzbywgSSB0aGluayB3ZSBu
ZWVkIHNvbWUgcGFyYW1ldGVyCj4gcGFzc2luZyBtZWNoYW5pc20gdG8gdGhlIHB1cmdhdG9yeSBj
b2RlLiAgRm9yIGV4YW1wbGUsIHBhc3NpbmcgdGhlIHBhbmljCj4gbWVzc2FnZSB2aWEgYm9vdCBw
YXJhbWV0ZXIgdG8gc2F2ZSBpdCB0byBTRUwuICBBbHRob3VnaCBJJ20gbm90IHN1cmUKPiB3ZSBj
YW4gZG8gdGhhdCAoSSd2ZSBub3QgaW52ZXN0aWdhdGVkIHdlbGwgeWV0KS4gIElzIHRoYXQgYWNj
ZXB0YWJsZT8KCkkgdGhpbmsgdGhlIGFkZHJlc3Mgb2YgcGFuaWMgbWVzc2FnZSBpcyBhdmFpbGFi
bGUgaW4gY3Jhc2ggbm90ZXMuICBJZgpub3QgdGhhdCBpcyB2ZXJ5IHJlYXNvbmFibGUgdG8gYWRk
LgoKVXBkYXRpbmcgdGhlIFNFTCBmcm9tIHB1cmdhdG9yeSBhZnRlciBwdXJnYXRvcnkgaGFzIHZh
bGlkYXRlZCB0aGUKY2hlY2tzdW1zIG9mIHRoZSBjcmFzaCBoYW5kbGluZyBjb2RlIGlzIGFjY2Vw
dGFibGUuCgpBbGwgdGhhdCBpcyBkZXNpcmVkIGlzIHRvIHJ1biBhcyBsaXR0bGUgY29kZSBhcyBw
b3NzaWJsZSBpbiBhIGtlcm5lbAp0aGF0IGlzIGtub3duIGJyb2tlbi4gIE9uY2UgdGhlIGNoZWNr
c3VtcyBoYXZlIHZlcmlmaWVkIHRoaW5ncyBpbgpwdXJnYXRvcnkgeW91IHNob3VsZCBiZSBpbiBn
b29kIHNoYXBlLCBhbmQgdGhlcmUgaXMgbm8gcG9zc2liaWxpdHkgb2YKcmVseWluZyBvbiBicm9r
ZW4gaW5mcmFzdHJ1Y3R1cmUgYmVjYXVzZSB0aGF0IGNvZGUgc2ltcGx5IGlzIG5vdCBwcmVzZW50
CmluIHB1cmdhdG9yeS4KCldlIGFscmVhZHkgaGF2ZSBhIGZldyBlYXJseV9wcmludGsgc3R5bGUg
ZHJpdmVycyBpbiBwdXJnYXRvcnkgYW5kIEkKZG9uJ3QgdGhlIGNvZGUgdG8gdXBkYXRlIHRoZSBT
RUwgd291bGQgYmUgbXVjaCB3b3JzZS4KCk9uIHRoZSBmbGlwIHNpZGUgdGhlcmUgYXJlIGVub3Vn
aCBmaXJtd2FyZSBidWdzIHRoYXQgSSBwZXJzb25hbGx5IHdvdWxkCm5vdCB3YW50IHRvIHJlbHkg
b24gZmlybXdhcmUgY29kZSBydW5uaW5nIHByb3Blcmx5IHdoZW4gdGhlIG1hY2hpbmUgaXMKaW4g
YSBrbm93biBicm9rZW4gc3RhdGUsIHNvIEkgZG9uJ3Qgd2FudCB0aGUgU0VMIHVwZGF0ZSB0byBi
ZQp1bmNvbmRpdGlvbmFsLgoKRXJpYwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

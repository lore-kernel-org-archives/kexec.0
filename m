Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgYQK-0003j9-HB
 for kexec@lists.infradead.org; Wed, 03 Jun 2020 18:47:38 +0000
Received: by mail-wr1-x442.google.com with SMTP id r7so3508307wro.1
 for <kexec@lists.infradead.org>; Wed, 03 Jun 2020 11:47:35 -0700 (PDT)
Subject: Re: Re: [RESEND PATCH v5 5/5] Documentation/vmcoreinfo: Add
 documentation for 'TCR_EL1.T1SZ'
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-6-git-send-email-bhsharma@redhat.com>
 <8a982138-f1fa-34e8-18fd-49a79cea3652@arm.com>
 <b7d8d603-d9fe-3e18-c754-baf2015acd16@redhat.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <51606585-77a3-265f-1d4e-19f25a90697d@broadcom.com>
Date: Wed, 3 Jun 2020 11:47:28 -0700
MIME-Version: 1.0
In-Reply-To: <b7d8d603-d9fe-3e18-c754-baf2015acd16@redhat.com>
Content-Language: en-US
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>, James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Dave Anderson <anderson@redhat.com>, bhupesh.linux@gmail.com, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Steve Capper <steve.capper@arm.com>

SGkgQmh1cGVzaCwKCldvdWxkIGJlIGdyZWF0IHRvIGdldCB0aGlzIHBhdGNoIHNlcmllcyB1cHN0
cmVhbWVkPwoKT24gMjAxOS0xMi0yNSAxMDo0OSBhLm0uLCBCaHVwZXNoIFNoYXJtYSB3cm90ZToK
PiBIaSBKYW1lcywKPgo+IE9uIDEyLzEyLzIwMTkgMDQ6MDIgUE0sIEphbWVzIE1vcnNlIHdyb3Rl
Ogo+PiBIaSBCaHVwZXNoLAo+Cj4gSSBhbSBzb3JyeSB0aGlzIHJldmlldyBtYWlsIHNraXBwZWQg
bXkgYXR0ZW50aW9uIGR1ZSB0byBob2xpZGF5cyBhbmQgCj4gZm9jdXMgb24gb3RoZXIgdXJnZW50
IGlzc3Vlcy4KPgo+PiBPbiAyOS8xMS8yMDE5IDE5OjU5LCBCaHVwZXNoIFNoYXJtYSB3cm90ZToK
Pj4+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBUQ1JfRUwxLlQxU1ogdmFyaWFibGUgYmVpbmcgYWRk
ZWQgdG8KPj4+IHZtY29yZWluZm8uCj4+Pgo+Pj4gSXQgaW5kaWNhdGVzIHRoZSBzaXplIG9mZnNl
dCBvZiB0aGUgbWVtb3J5IHJlZ2lvbiBhZGRyZXNzZWQgYnkgCj4+PiBUVEJSMV9FTDEKPj4KPj4+
IGFuZCBoZW5jZSBjYW4gYmUgdXNlZCBmb3IgZGV0ZXJtaW5pbmcgdGhlIHZhYml0c19hY3R1YWwg
dmFsdWUuCj4+Cj4+IHVzZWQgZm9yIGRldGVybWluaW5nIHJhbmRvbS1pbnRlcm5hbC1rZXJuZWwt
dmFyaWFibGUsIHRoYXQgbWlnaHQgbm90IAo+PiBleGlzdCB0b21vcnJvdy4KPj4KPj4gQ291bGQg
eW91IGRlc2NyaWJlIGhvdyB0aGlzIGlzIHVzZWZ1bC9uZWNlc3NhcnkgaWYgYSBkZWJ1Z2dlciB3
YW50cyAKPj4gdG8gd2FsayB0aGUgcGFnZQo+PiB0YWJsZXMgZnJvbSB0aGUgY29yZSBmaWxlPyBJ
IHRoaW5rIHRoaXMgaXMgYSBiZXR0ZXIgYXJndW1lbnQuCj4+Cj4+IFdvdWxkbid0IHRoZSBkb2N1
bWVudGF0aW9uIGJlIGJldHRlciBhcyBwYXJ0IG9mIHRoZSBwYXRjaCB0aGF0IGFkZHMgCj4+IHRo
ZSBleHBvcnQ/Cj4+ICguLi4gdW5sZXNzIHRoZXNlIGhhdmUgdG8gZ28gdmlhIGRpZmZlcmVudCB0
cmVlcz8gLi4pCj4KPiBPaywgd2lsbCBmaXggdGhlIHNhbWUgaW4gdjYgdmVyc2lvbi4KPgo+Pj4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5y
c3QgCj4+PiBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1bXAvdm1jb3JlaW5mby5yc3QK
Pj4+IGluZGV4IDQ0N2I2NDMxNGY1Ni4uZjkzNDlmOWQzMzQ1IDEwMDY0NAo+Pj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdAo+Pj4gKysrIGIvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdAo+Pj4gQEAgLTM5OCw2
ICszOTgsMTIgQEAgS0VSTkVMT0ZGU0VUCj4+PiDCoCBUaGUga2VybmVsIHJhbmRvbWl6YXRpb24g
b2Zmc2V0LiBVc2VkIHRvIGNvbXB1dGUgdGhlIHBhZ2Ugb2Zmc2V0LiBJZgo+Pj4gwqAgS0FTTFIg
aXMgZGlzYWJsZWQsIHRoaXMgdmFsdWUgaXMgemVyby4KPj4+IMKgICtUQ1JfRUwxLlQxU1oKPj4+
ICstLS0tLS0tLS0tLS0KPj4+ICsKPj4+ICtJbmRpY2F0ZXMgdGhlIHNpemUgb2Zmc2V0IG9mIHRo
ZSBtZW1vcnkgcmVnaW9uIGFkZHJlc3NlZCBieSBUVEJSMV9FTDEKPj4KPj4+ICthbmQgaGVuY2Ug
Y2FuIGJlIHVzZWQgZm9yIGRldGVybWluaW5nIHRoZSB2YWJpdHNfYWN0dWFsIHZhbHVlLgo+Pgo+
PiAndmFiaXRzX2FjdHVhbCcgbWF5IG5vdCBleGlzdCB3aGVuIHRoZSBuZXh0IHBlcnNvbiBjb21l
cyB0byByZWFkIHRoaXMgCj4+IGRvY3VtZW50YXRpb24gKGl0cwo+PiBnb2luZyB0byByb3QgcmVh
bGx5IHF1aWNrbHkpLgo+Pgo+PiBJIHRoaW5rIHRoZSBmaXJzdCBoYWxmIG9mIHRoaXMgdGV4dCBp
cyBlbm91Z2ggdG8gc2F5IHdoYXQgdGhpcyBpcyAKPj4gZm9yLiBZb3Ugc2hvdWxkIGluY2x1ZGUK
Pj4gd29yZHMgdG8gdGhlIGVmZmVjdCB0aGF0IGl0cyB0aGUgaGFyZHdhcmUgdmFsdWUgdGhhdCBn
b2VzIHdpdGggCj4+IHN3YXBwZXJfcGdfZGlyLiBZb3UgbWF5Cj4+IHdhbnQgdG8gcG9pbnQgcmVh
ZGVycyB0byB0aGUgYXJtLWFybSBmb3IgbW9yZSBkZXRhaWxzIG9uIHdoYXQgdGhlIAo+PiB2YWx1
ZSBtZWFucy4KPgo+IE9rLCBnb3QgaXQuIEZpeGVkIHRoaXMgaW4gdjYsIHdoaWNoIHNob3VsZCBi
ZSBvbiBpdHMgd2F5IHNob3J0bHkuCkkgY2FuJ3Qgc2VlbSB0byBmaW5kIHY2Pwo+Cj4gVGhhbmtz
LAo+IEJodXBlc2gKPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KPiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo+CgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=

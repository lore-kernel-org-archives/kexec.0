Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjXS2-0008N7-MJ
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 16:49:59 +0000
Date: Thu, 21 Nov 2013 17:49:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch 4/9 v3] efi: cleanup efi_enter_virtual_mode function
Message-ID: <20131121164929.GM26009@pd.tnic>
References: <20131121061704.363730447@dhcp-16-126.nay.redhat.com>
 <20131121061754.304016344@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131121061754.304016344@dhcp-16-126.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, toshi.kani@hp.com, matt@console-pimps.org, greg@kroah.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, ebiederm@xmission.com, hpa@zytor.com, vgoyal@redhat.com

T24gVGh1LCBOb3YgMjEsIDIwMTMgYXQgMDI6MTc6MDhQTSArMDgwMCwgZHlvdW5nQHJlZGhhdC5j
b20gd3JvdGU6Cj4gQWRkIHR3byBzbWFsbCBmdW5jdGlvbnM6Cj4gZWZpX21lcmdlX3JlZ2lvbnMg
YW5kIGVmaV9tYXBfcmVnaW9ucywgZWZpX2VudGVyX3ZpcnR1YWxfbW9kZQo+IGNhbGxzIHRoZW0g
aW5zdGVhZCBvZiBlbWJlZGRpbmcgdHdvIGxvbmcgZm9yIGxvb3AuCj4gCj4gdjEtPnYyOgo+IHJl
ZnJlc2g7IGNvZGluZyBzdHlsZSBmaXhlcy4KPiAKPiB2Mi0+djM6Cj4gVG9zaGkgS2FuaToKPiBy
ZW1vdmUgdW51c2VkIHZhcmlhYmxlCj4gTWF0dDogY2hlY2sgcmV0dXJuIHZhbHVlIG9mIGtyZWFs
bG9jLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERhdmUgWW91bmcgPGR5b3VuZ0ByZWRoYXQuY29tPgoK
U2FtZSBzaG9ydCBjb21tZW50IG5pdHBpY2sgYXMgZWFybGllciA6KQoKT3RoZXJ3aXNlOgoKQWNr
ZWQtYnk6IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT4KCj4gLS0tCj4gIGFyY2gveDg2L3Bs
YXRmb3JtL2VmaS9lZmkuYyB8ICAxMDkgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKyksIDQzIGRlbGV0
aW9ucygtKQo+IAo+IC0tLSBlZmkub3JpZy9hcmNoL3g4Ni9wbGF0Zm9ybS9lZmkvZWZpLmMKPiAr
KysgZWZpL2FyY2gveDg2L3BsYXRmb3JtL2VmaS9lZmkuYwoKWyDigKYgXQoKPiBAQCAtODM3LDYg
KzgwNSwxOCBAQCB2b2lkIF9faW5pdCBlZmlfZW50ZXJfdmlydHVhbF9tb2RlKHZvaWQpCj4gIAkJ
cHJldl9tZCA9IG1kOwo+ICAKPiAgCX0KPiArfQo+ICsKPiArLyoKPiArICogTWFwIGVmaSBtZW1v
cnkgcmFuZ2VzIGZvciBydW50aW1lIHNlcml2Y2UgYW5kCj4gKyAqIHVwZGF0ZSBuZXdfbWVtbWFw
IHdpdGggdmlydHVhbCBhZGRyZXNzZXMuCj4gKyAqLwoKU3RyZXRjaCBjb21tZW50IHRvIDgwIGNv
bHM6CgovKgogKiBNYXAgZWZpIG1lbW9yeSByYW5nZXMgZm9yIHJ1bnRpbWUgc2VyaXZjZSBhbmQg
dXBkYXRlIG5ld19tZW1tYXAgd2l0aCB2aXJ0dWFsCiAqIGFkZHJlc3Nlcy4KICovCgpsaWtlIGl0
IGlzIGN1c3RvbWFyeSBmb3IgdGhlIHJlc3Qgb2YgdGhlIGZpbGUuCgo+ICtzdGF0aWMgdm9pZCAq
IF9faW5pdCBlZmlfbWFwX3JlZ2lvbnMoaW50ICpjb3VudCkKPiArewo+ICsJZWZpX21lbW9yeV9k
ZXNjX3QgKm1kOwo+ICsJdm9pZCAqcCwgKm5ld19tZW1tYXAgPSBOVUxMOwo+ICsJdW5zaWduZWQg
bG9uZyBzaXplOwo+ICsJdTY0IGVuZCwgc3lzdGFiOwo+ICAKPiAgCWZvciAocCA9IG1lbW1hcC5t
YXA7IHAgPCBtZW1tYXAubWFwX2VuZDsgcCArPSBtZW1tYXAuZGVzY19zaXplKSB7Cj4gIAkJbWQg
PSBwOwoKLS0gClJlZ2FyZHMvR3J1c3MsCiAgICBCb3Jpcy4KClNlbnQgZnJvbSBhIGZhdCBjcmF0
ZSB1bmRlciBteSBkZXNrLiBGb3JtYXR0aW5nIGlzIGZpbmUuCi0tCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==

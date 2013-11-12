Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vg9gt-0007t4-ML
 for kexec@lists.infradead.org; Tue, 12 Nov 2013 08:51:20 +0000
Date: Tue, 12 Nov 2013 16:50:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [patch 1/3 v2] Add function get_bootparam
Message-ID: <20131112085015.GA14151@dhcp-16-126.nay.redhat.com>
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
 <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
 <1384219658.1847.84.camel@misato.fc.hp.com>
 <52819E71.70201@zytor.com> <20131112075831.GA6213@kroah.com>
 <20131112080854.GD6999@dhcp-16-126.nay.redhat.com>
 <20131112083012.GB7708@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131112083012.GB7708@kroah.com>
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
To: Greg KH <greg@kroah.com>
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, x86@kernel.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, vgoyal@redhat.com

T24gMTEvMTIvMTMgYXQgMTI6MzBhbSwgR3JlZyBLSCB3cm90ZToKPiBPbiBUdWUsIE5vdiAxMiwg
MjAxMyBhdCAwNDowODo1NFBNICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+ID4gT24gMTEvMTEv
MTMgYXQgMTE6NThwbSwgR3JlZyBLSCB3cm90ZToKPiA+ID4gPiBrZXhlYy10b29scyBjYW4gaGF2
ZSBhIGZhbGxiYWNrIHRvIGRlYnVnZnMgaWYgd2UgcmVhbGx5IG5lZWQgaXQsIGJ1dAo+ID4gPiA+
IG1ha2luZyBwZW9wbGUgbW91bnQgZGVidWdmcyB0byBoYXZlIHNvbWUgZXNzZW50aWFsIHBpZWNl
IG9mCj4gPiA+ID4gZnVuY3Rpb25hbGl0eSBzY2FyZXMgdGhlIGhlY2sgb3V0IG9mIG1lLgo+ID4g
PiAKPiA+ID4gSSBhZ3JlZSwgdGhhdCB3b3VsZCBub3QgYmUgZ29vZC4KPiA+ID4gCj4gPiA+IEkn
bSBub3Qgc3VyZSB3aGF0IGV4YWN0bHkgdGhlIHN5c2ZzIGZpbGUgaXMgd2FudGluZyB0byBsb29r
IGxpa2U/ICBUaGUKPiA+ID4gZWZpIHNlY3Rpb24gdmFyaWFibGUgc3lzZnMgZmlsZSBpc24ndCBv
ayAobXVsdGlwbGUgbGluZXMgd2l0aCBtdWx0aXBsZQo+ID4gPiB2YWx1ZXMuKSAgV2hhdCBpcyB0
aGlzIGdvaW5nIHRvIGxvb2sgbGlrZT8KPiA+IAo+ID4gVGhlIGN1cnJlbnQgc3RydWN0dXJlIGlu
IGRlYnVnZnMgaXMgbGlrZSBiZWxvdywgZXhwb3J0IGV2ZXJ5IGZpZWxkIG9mIHNldHVwCj4gPiBo
ZWFkZXIgYXMgb25lIGZpbGUgd2lsbCBiZSB0b28gbXVjaCBJTUhPOgo+ID4gW3Jvb3RAZGFya3N0
YXIgZGVidWddIyB0cmVlIGJvb3RfcGFyYW1zCj4gPiBib290X3BhcmFtcwo+ID4g4pSc4pSA4pSA
IGRhdGEgLyogYmluYXJ5IGRhdGEgb2Ygc2V0dXAgaGVhZGVyICovCj4gPiDilJzilIDilIAgc2V0
dXBfZGF0YSAvKiBzZXR1cF9kYXRhIGxpbmsgbGlzdCBub2RlcyAqLwo+ID4g4pSCwqDCoCDilJzi
lIDilIAgMAo+ID4g4pSCwqDCoCDilILCoMKgIOKUnOKUgOKUgCBkYXRhIC8qIGJpbmFyeSBkYXRh
IG9mIHNldHVwIGRhdGEgKi8KPiA+IOKUgsKgwqAg4pSCwqDCoCDilJTilIDilIAgdHlwZSAvKiB0
eXBlIG9mIHNldHVwIGRhdGEgKi8KPiA+IOKUgsKgwqAg4pSU4pSA4pSAIDEKPiA+IOKUgsKgwqAg
ICAgIOKUnOKUgOKUgCBkYXRhCj4gPiDilILCoMKgICAgICDilJTilIDilIAgdHlwZQo+ID4g4pSU
4pSA4pSAIHZlcnNpb24gLyogYm9vdCBwcm90b2NvbCB2ZXJzaW9uICovCj4gCj4gQW5kIHRoZXNl
IGJpbmFyeSBkYXRhIGJsb2JzIGFyZSBhICJzdGFuZGFyZCIgc29tZXdoZXJlLCBhbmQgd2lsbCBu
b3QKPiBjaGFuZ2UgcGVyIGtlcm5lbCB2ZXJzaW9uIGNoYW5nZT8KCklNTyB0aGUgdG9wb2xvZ3kg
c2hvdWxkIGJlIHN0YW5kYXJkLiBUaGUgY29udGVudCBjb3VsZCBjaGFuZ2UsCmZvciBleGFtcGxl
IGxhdGVyIGJ1bXBpbmcgYm9vdCBwcm90b2NvbCB2ZXJzaW9uLCB3ZSBjb3VsZCBhZGQKbmV3IGZp
ZWxkIGluIHNldHVwIGhlYWRlci4uCgpocGEgc2hvdWxkIGtub3cgbW9yZSBhYm91dCB0aGlzLi4g
UGV0ZXIgY291bGQgeW91IGFuc3dlciB0aGlzIHF1ZXN0aW9uPwoKPiAKPiBJZiBzbywgdGhhdCBz
dHJ1Y3R1cmUgaXMgZmluZSB3aXRoIG1lLgo+IAo+IHRoYW5rcywKPiAKPiBncmVnIGstaAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

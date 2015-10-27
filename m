Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zr0DV-0003mz-2t
 for kexec@lists.infradead.org; Tue, 27 Oct 2015 09:06:53 +0000
Date: Tue, 27 Oct 2015 17:06:27 +0800
From: "'Baoquan He'" <bhe@redhat.com>
Subject: Re: [V4 PATCH 4/4] x86/apic: Introduce noextnmi boot option
Message-ID: <20151027090627.GA29587@dhcp-128-28.nay.redhat.com>
References: <20150925112803.4258.94241.stgit@softrs>
 <20150925112811.4258.54494.stgit@softrs>
 <20151027084622.GA5141@dhcp-128-28.nay.redhat.com>
 <04EAB7311EE43145B2D3536183D1A844549DC280@GSjpTKYDCembx31.service.hitachi.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04EAB7311EE43145B2D3536183D1A844549DC280@GSjpTKYDCembx31.service.hitachi.net>
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
Cc: "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?= <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

T24gMTAvMjcvMTUgYXQgMDk6MDFhbSwg5rKz5ZCI6Iux5a6PIC8gS0FXQUnvvIxISURFSElSTyB3
cm90ZToKPiBIaSwKPiAKPiA+IEkganVzdCBoYXZlIGEgbG9vayBhdCB0aGlzIHRocmVhZC4gSSBh
bSB3b25kZXJpbmcgd2h5IHdlIGRvbid0IHVzZQo+ID4gZXhpc3RpbmcgaXNfa2R1bXBfa2VybmVs
KCkgZGlyZWN0bHkgdG8gZGlzYWJsZSBleHRlcm5hbCBOTUkgaWYgaXQncwo+ID4gaW4ga2R1bXAg
a2VybmVsLiBUaGVuIG5vIG5lZWQgdG8gaW50cm9kdWNlIGFub3RoZXIgYm9vdCBvcHRpb24gIm5v
ZXh0bm1pIgo+ID4gd2hpY2ggaXMgdXNlZCBvbmx5IGZvciBrZHVtcCBrZXJuZWwuCj4gCj4gQXMg
SSBzdGF0ZWQgaW4gYW5vdGhlciBtYWlsLCB0aGVyZSBpcyBhIGNhc2Ugd2hlcmUgd2UgZG9uJ3Qg
d2FudCB0bwo+IG1hc2sgZXh0ZXJuYWwgTk1JcyBpbiB0aGUgc2Vjb25kIGtlcm5lbC4gIFNvLCB3
ZSBuZWVkIHNvbWUKPiBjb25maWd1cmFibGUgd2F5LiAgUGxlYXNlIHNlZSB0aGUgZm9sbG93aW5n
IHF1b3RhdGlvbi4KCkdvdCBpdC4gVGhhbmtzIGZvciB0ZWxsaW5nLgoKPiAKPiA+IFdlIHNvdWxk
bid0IGVuYWJsZSB0aGlzIGZlYXR1cmUgc2lsZW50bHkuICBTb21lIHVzZXJzIHdvdWxkbid0IGxp
a2UKPiA+IHRvIGVuYWJsZSB0aGlzIGZlYXR1cmUuICBGb3IgZXhhbXBsZSwgYSB1c2VyIGVuYWJs
ZXMgYSB3YXRjaGRvZyB0aW1lcgo+ID4gd2hpY2ggcmFpc2VzIGFuIGV4dGVybmFsIE5NSSB3aGVu
IHRoZSBjb3VudGVyIGlzIG5vdCByZXNldCBmb3IgYQo+ID4gc3BlY2lmaWMgZHVyYXRpb24uICBU
aGVuLCB0aGUgc2Vjb25kIGtlcm5lbCBoYW5ncyB1cCB3aGlsZSBzYXZpbmcKPiA+IGNyYXNoIGR1
bXAsIGFuZCBOTUkgaXMgZGVsaXZlcmVkIHRvIHRoZSBDUFUuICBUaGUga2VybmVsIGdldHMgcGFu
aWMKPiA+IGR1ZSB0byB0aGUgTk1JLCBwcmludHMgc29tZSBpbmZvcm1hdGlvbiB0byB0aGUgZGlz
cGxheSBhbmQgc2VyaWFsCj4gPiBjb25zb2xlLCBhbmQgdGhlbiBhdXRvbWF0aWNhbGx5IHJlYm9v
dC4gIEluIHRoaXMgY2FzZSwgdXNlcnMgZG9uJ3QKPiA+IHdhbnQgdG8gYmxvY2sgZXh0ZXJuYWwg
Tk1Jcy4KPiAKPiBSZWdhcmRzLAo+IAo+IEhpZGVoaXJvIEthd2FpCj4gSGl0YWNoaSwgTHRkLiBS
ZXNlYXJjaCAmIERldmVsb3BtZW50IEdyb3VwCj4gCj4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2tleGVjCg==

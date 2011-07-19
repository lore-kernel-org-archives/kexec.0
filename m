Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Tue, 19 Jul 2011 14:47:59 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC][PATCH -mmotm 0/4] Improvement of pstore/kmsg_dump in
	kexec/panic path
Message-ID: <20110719184759.GC7001@redhat.com>
References: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64C2@USINDEVS01.corp.hds.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5C4C569E8A4B9B42A84A977CF070A35B2C199C64C2@USINDEVS01.corp.hds.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Seiji Aguchi <seiji.aguchi@hds.com>
Cc: "dzickus@redhat.com" <dzickus@redhat.com>, Satoru Moriya <satoru.moriya@hds.com>, "dle-develop@lists.sourceforge.net" <dle-develop@lists.sourceforge.net>, "tony.luck@intel.com" <tony.luck@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Jarod Wilson <jwilson@redhat.com>, Americo Wang <xiyou.wangcong@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Garrett <mjg@redhat.com>

T24gVHVlLCBKdWwgMTksIDIwMTEgYXQgMDI6MjM6MjZQTSAtMDQwMCwgU2VpamkgQWd1Y2hpIHdy
b3RlOgo+IEhpLAo+IAo+IFtVcHN0cmVhbSBzdGF0dXNdCj4gICAgRGlzY3Vzc2lvbiBhYm91dCBr
bXNnX2R1bXAoKSBpbiBrZHVtcCBwYXRoOiAKPiAgICAgLSBFcmljIGFuZCBWaXZlayBhcmUgd29y
cmllZCBhYm91dCByZWxpYWJpbGl0eSBvZiBleGlzdGluZyBrbXNnX2R1bXAoKS4KPiAgICAgLSBF
c3BlY2lhbGx5LCBWaXZlayB3b3VsZCBsaWtlIHRvIHJlbW92ZSBhIFJDVSAgZnVuY3Rpb24gY2Fs
bCBjaGFpbiBpbiBrZHVtcCBwYXRoCj4g44CA44CA44CAIHdoaWNoIGtlcm5lbCBtb2R1bGVzIGNh
biByZWdpc3RlciB0aGVpciBmdW5jdGlvbiBjYWxscyBmcmVlbHkuIAo+IAo+ICAgIERpc2N1c3Np
b24gYWJvdXQgcHN0b3JlIGluIG5taV9oYW5kZXIuCj4gICAgIC0gRG9uIFppY2t1cyBmb3VuZCBh
biBpc3N1ZSBvZiBwc3RvcmUgaW4gbm1pX2hhbmRsZXIgZHVlIHRvIGl0cyBtdXRleF9sb2NrLgoK
WW91IGRpZCBub3QgYW5zd2VyIG15IHF1ZXN0aW9ucyBpbiB0aGUgbGFzdCBwb3N0aW5nIG1haWwg
dGhyZWFkIGFuZCBnb25lCmFoZWFkIHdpdGggdGhlIG5ldyBwb3N0aW5nLiBIb3cgYXJlIHdlIHN1
cHBvc2VkIHRvIGRpc2N1c3Mgc29tZXRoaW5nLiBUaGlzCmhhcyBiZWVuIGEgcHJvYmxlbSBvbiB0
aGlzIG1haWwgdGhyZWFkIHNpbmNlIHRoZSBiZWdpbm5laW5nLiBUaGVyZSBpcwpsaXR0bGUgb3Bl
biBkaXNjdXNzaW9uLiAKClNvIGlmIHlvdSB3YW50IHRvIG1ha2UgYW55IHByb2dyZXNzIGluIHRo
aXMgZGlyZWN0aW9uLCB3aGF0IHdpbGwgaGVscAppcyBvcGVuIGRpc2N1c3Npb24uCgpMb2NraW5n
IGlzIGdvaW5nIHRvIGJlIGEgcHJvYmxlbS4gU28gYXRsZWFzdCB3ZSBjYW4gcmVtb3ZlIGttc2df
ZHVtcCgpCmluZnJhc3RydWN0dXJlIGZyb20gcmVib290IHBhdGguIFdoeSBjYW4ndCB3ZSBsb2cg
c29tZXRoaW5nIGluIHVzZXIKc3BhY2Ugd2hlbiB1c2VyIGluaXRpYXRlcyBhIHJlYm9vdCwgbGV0
IGl0IGdldCBsb2dnZWQgaW4gL3Zhci9sb2cvbWVzc2FnZXMKYW5kIHRoZW4gdW1vdW50IHRoZSBm
aWxlIHJvb3QgYW5kIGdvIGFoZWFkIHdpdGggcmVib290LiBXaHkgZG9lcyBrZXJuZWwKbmVlZCB0
byBjYXB0dXJlIHRoYXQgaW5mbyBpbiBOVlJBTS4KCklmIHdlIGNhbiBnZXQgcmlkIG9mIGFsbCB0
aGUgbG9nZ2luZyB0aGluZyBvbiByZWJvb3QgcGF0aCwgdGhlbiBhdCBsZWFzdAppdCBkb2VzIG5v
dCBuZWVkIHRvIGJlIGxvY2sgcHJvdGVjdGVkIHdpdGggY3Jhc2ggcGF0aC4KClRoYW5rcwpWaXZl
awoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMg
bWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

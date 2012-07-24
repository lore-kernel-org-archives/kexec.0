Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Sta7q-0005v0-FW
 for kexec@lists.infradead.org; Tue, 24 Jul 2012 08:05:57 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 0/8] makedumpfile: Xen4 support for SLES11
Date: Tue, 24 Jul 2012 10:05:19 +0200
References: <20120723113244.751777873@suse.cz>
 <20120724141317.94818eff2aaa00fac3362ece@mxc.nes.nec.co.jp>
In-Reply-To: <20120724141317.94818eff2aaa00fac3362ece@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Message-Id: <201207241005.19839.ptesarik@suse.cz>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, fngw.zhang@huawei.com, Norbert.Trapp@ts.fujitsu.com

RG5lIMOadCAyNC4gxI1lcnZlbmNlIDIwMTIgMDc6MTM6MTcgQXRzdXNoaSBLdW1hZ2FpIG5hcHNh
bChhKToKPiBIZWxsbyBQZXRyLAo+IAo+IE9uIE1vbiwgMjMgSnVsIDIwMTIgMTM6MzI6NDQgKzAy
MDAKPiAKPiBwdGVzYXJpa0BzdXNlLmN6IHdyb3RlOgo+ID4gVGhpcyBwYXRjaHNldCB3YXMgY3Jl
YXRlZCB0byBhbGxvdyB1c2luZyBtYWtlZHVtcGZpbGUgZm9yIERvbTAgZHVtcHMgaW4KPiA+IFNM
RVMgU1AxIGFuZCBTUDIuIE1vc3Qgb2YgdGhlIHBhdGNoZXMgYWNjb3VudCBmb3IgY2hhbmdlcyB0
byB0aGUgWGVuCj4gPiBoeXBlcnZpc29yLCBleGNlcHQgdGhlIGxhc3Qgb25lLCB3aGljaCByZWZs
ZWN0cyB0aGF0IHRoZSAibWF4X3BmbiIKPiA+IHN5bWJvbCBpcyBub3QgZXhwb3J0ZSBieSB0aGUg
U0xFUyBrZXJuZWwuCj4gPiAKPiA+IFBldHIgVGVzYXJpawo+ID4gU1VTRSBMaW51eAo+IAo+IFRo
YW5rIHlvdSBmb3IgeW91ciB3b3JrLgo+IAo+IEFsdGhvdWdoIEkgaGF2ZW4ndCBzZWVuIGFsbW9z
dCB5b3VyIHBhdGNoc2V0IHlldCwgZG9lcyB5b3VyIHBhdGNoc2V0IGhhdmUKPiBhIGZ1bmN0aW9u
YWwgb3ZlcmxhcCB3aXRoIHRoZSBwYXRjaHNldCBOb3JiZXJ0IHNlbnQgPwo+IAo+ICAgaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2tleGVjLzIwMTItSnVuZS8wMDY0MjAuaHRt
bAo+ICAgKFRoaXMgdGhyZWFkIG5lZWRzIHNvbWUgZXhwZXJ0cyBpbiBYZW4pCgpZZXMsIEkgZm91
bmQgdGhhdCBvbmUgb25seSBhZnRlciBJIHNlbnQgbXkgcGF0Y2ggc2V0LiBJJ3ZlIGNvbnRhY3Rl
ZCBOb3JiZXJ0IAphbmQgYXNrZWQgaGltIGFib3V0IGhpcyBvcGluaW9uLgoKPiBJdCBzZWVtcyB0
aGF0IHRoZSB0d28gaGF2ZSB0aGUgc2FtZSBwdXJwb3NlLCBidXQgSSBjYW4ndCBkZWNpZGUgd2hp
Y2ggaXMKPiBiZXR0ZXIgd2F5LiBEbyB5b3UgaGF2ZSBhbnkgb3BpbmlvbiA/CgpPSywgSSdsbCBo
YXZlIGEgbG9vayBhdCBOb3JiZXJ0J3Mgd29yayBhbmQgc2VlIGlmIEkgY2FuIGNvbWJpbmUgdGhl
IHR3byAKc29tZWhvdy4KClN0YXkgdHVuZWQsClBldHIgVGVzYXJpawoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=

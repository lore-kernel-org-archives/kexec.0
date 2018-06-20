Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVXNG-0005r3-9w
 for kexec@lists.infradead.org; Wed, 20 Jun 2018 07:17:51 +0000
Date: Wed, 20 Jun 2018 09:17:33 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Do not print ETA value if current
 progress is 0
Message-ID: <20180620091733.290580b9@ezekiel.suse.cz>
In-Reply-To: <b7e96843-7a88-1c2f-6b62-09ed94f8c78e@redhat.com>
References: <20180409114020.1b48ba8c@ezekiel.suse.cz>
 <90ec5728-2318-1074-0fc2-b02a69e6c7f4@redhat.com>
 <20180410094707.0d1ec7f2@ezekiel.suse.cz>
 <b7e96843-7a88-1c2f-6b62-09ed94f8c78e@redhat.com>
MIME-Version: 1.0
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
To: lijiang <lijiang@redhat.com>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Dave Young <dyoung@redhat.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

SGkgTGlhbmJvLAoKT24gV2VkLCAyMCBKdW4gMjAxOCAxMTowNzo0NiArMDgwMApsaWppYW5nIDxs
aWppYW5nQHJlZGhhdC5jb20+IHdyb3RlOgoKPiDlnKggMjAxOOW5tDA05pyIMTDml6UgMTU6NDcs
IFBldHIgVGVzYXJpayDlhpnpgZM6Cj5bLi4uXQo+ID4gWWVzLCB0aGUgY3VycmVudCBjb2RlIHdp
bGwgbm90IHByb2R1Y2Ugc2Vuc2libGUgcmVzdWx0cyBpZiB0aGUgc3lzdGVtCj4gPiBjbG9jayBt
b3ZlcyBiYWNrd2FyZHMuIFdpdGggbXkgcGF0Y2ggaXQgd2lsbCBtb3N0IGxpa2VseSBzYXk6ICI+
MmRheSIuCj4gPiBCdXQgaXQgd2lsbCBub3Qgd29yayBhbnkgYmV0dGVyIGlmIHlvdSB1c2UgYSA2
NC1iaXQgaW50ZWdlci4KPiA+IAo+ID4gSW5zdGVhZCwgd2Ugc2hvdWxkIGJlIHVzaW5nIGNsb2Nr
X2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAuLi4pLgo+ID4gVGhhdCdzIGEgc2VwYXJhdGUgaXNz
dWUgdGhhdCBJIGNhbiBzb2x2ZSBpbiBhbm90aGVyIHBhdGNoLiAgCj4gSGksIFBldHIKPiBQcmV2
aW91c2x5IG1lbnRpb25lZCB0aGF0IHlvdSB3b3VsZCBzb2x2ZSB0aGlzIGlzc3VlLCB3b3VsZCB5
b3UgaGF2ZSBhbnkgcGxhbnMKPiBhYm91dCB0aGlzIGlzc3VlPwoKVGhhbmsgeW91IGZvciB0aGUg
cmVtaW5kZXIuIFllcywgbGV0IG1lIGRvIGl0IG5vdyEKClBldHIgVAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=

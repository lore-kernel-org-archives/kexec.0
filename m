Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVbEl-00088L-1Q
 for kexec@lists.infradead.org; Wed, 20 Jun 2018 11:25:21 +0000
Subject: Re: [PATCH] makedumpfile: Do not print ETA value if current progress
 is 0
References: <20180409114020.1b48ba8c@ezekiel.suse.cz>
 <90ec5728-2318-1074-0fc2-b02a69e6c7f4@redhat.com>
 <20180410094707.0d1ec7f2@ezekiel.suse.cz>
 <b7e96843-7a88-1c2f-6b62-09ed94f8c78e@redhat.com>
 <20180620091733.290580b9@ezekiel.suse.cz>
From: lijiang <lijiang@redhat.com>
Message-ID: <7d1bf253-89af-a6f9-4579-04378e514d71@redhat.com>
Date: Wed, 20 Jun 2018 19:24:59 +0800
MIME-Version: 1.0
In-Reply-To: <20180620091733.290580b9@ezekiel.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Masaki Tachibana <mas-tachibana@vf.jp.nec.com>, Daisuke Nishimura <dai-nishimura@rc.jp.nec.com>, Dave Young <dyoung@redhat.com>, Takuya Nakayama <tak-nakayama@tg.jp.nec.com>, kexec-ml <kexec@lists.infradead.org>

5ZyoIDIwMTjlubQwNuaciDIw5pelIDE1OjE3LCBQZXRyIFRlc2FyaWsg5YaZ6YGTOgo+IEhpIExp
YW5ibywKPiAKPiBPbiBXZWQsIDIwIEp1biAyMDE4IDExOjA3OjQ2ICswODAwCj4gbGlqaWFuZyA8
bGlqaWFuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiAKPj4g5ZyoIDIwMTjlubQwNOaciDEw5pelIDE1
OjQ3LCBQZXRyIFRlc2FyaWsg5YaZ6YGTOgo+PiBbLi4uXQo+Pj4gWWVzLCB0aGUgY3VycmVudCBj
b2RlIHdpbGwgbm90IHByb2R1Y2Ugc2Vuc2libGUgcmVzdWx0cyBpZiB0aGUgc3lzdGVtCj4+PiBj
bG9jayBtb3ZlcyBiYWNrd2FyZHMuIFdpdGggbXkgcGF0Y2ggaXQgd2lsbCBtb3N0IGxpa2VseSBz
YXk6ICI+MmRheSIuCj4+PiBCdXQgaXQgd2lsbCBub3Qgd29yayBhbnkgYmV0dGVyIGlmIHlvdSB1
c2UgYSA2NC1iaXQgaW50ZWdlci4KPj4+Cj4+PiBJbnN0ZWFkLCB3ZSBzaG91bGQgYmUgdXNpbmcg
Y2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsIC4uLikuCj4+PiBUaGF0J3MgYSBzZXBhcmF0
ZSBpc3N1ZSB0aGF0IEkgY2FuIHNvbHZlIGluIGFub3RoZXIgcGF0Y2guICAKPj4gSGksIFBldHIK
Pj4gUHJldmlvdXNseSBtZW50aW9uZWQgdGhhdCB5b3Ugd291bGQgc29sdmUgdGhpcyBpc3N1ZSwg
d291bGQgeW91IGhhdmUgYW55IHBsYW5zCj4+IGFib3V0IHRoaXMgaXNzdWU/Cj4gCj4gVGhhbmsg
eW91IGZvciB0aGUgcmVtaW5kZXIuIFllcywgbGV0IG1lIGRvIGl0IG5vdyEKPiAKPiBQZXRyIFQK
PiAKU3dpZnQgYWN0aW9uISBJIGhhdmUgc2VlbiB5b3VyIHBhdGNoZXMsIHRoYW5rIHlvdS4KCkxp
YW5ibwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4
ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

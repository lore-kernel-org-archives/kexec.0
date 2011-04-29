Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QFg4q-0006bw-JA
	for kexec@lists.infradead.org; Fri, 29 Apr 2011 05:17:17 +0000
Date: Fri, 29 Apr 2011 14:17:09 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: remove duplicated backup_src_start field from
	struct crash_elf_info
Message-ID: <20110429051705.GA12758@verge.net.au>
References: <1303875207-9273-1-git-send-email-amwang@redhat.com>
	<20110427150151.GB7790@redhat.com> <4DB91DFC.4060708@redhat.com>
	<20110428131539.GA7883@redhat.com>
	<20110428220515.GI3610@verge.net.au> <4DBA299C.6020003@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DBA299C.6020003@redhat.com>
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
To: Cong Wang <amwang@redhat.com>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

T24gRnJpLCBBcHIgMjksIDIwMTEgYXQgMTA6NTk6NDBBTSArMDgwMCwgQ29uZyBXYW5nIHdyb3Rl
Ogo+IOS6jiAyMDEx5bm0MDTmnIgyOeaXpSAwNjowNSwgU2ltb24gSG9ybWFuIOWGmemBkzoKPiA+
T24gVGh1LCBBcHIgMjgsIDIwMTEgYXQgMDk6MTU6MzlBTSAtMDQwMCwgVml2ZWsgR295YWwgd3Jv
dGU6Cj4gPj5PbiBUaHUsIEFwciAyOCwgMjAxMSBhdCAwMzo1Nzo0OFBNICswODAwLCBDb25nIFdh
bmcgd3JvdGU6Cj4gPj4+5LqOIDIwMTHlubQwNOaciDI35pelIDIzOjAxLCBWaXZlayBHb3lhbCDl
hpnpgZM6Cj4gPj4+PkFtZXJpZ28sCj4gPj4+Pgo+ID4+Pj5Ob3cgd2hvIHdpbGwgZG8gZm9sbG93
aW5nIGluaXRpYWxpemF0aW9uIGZvciBwcGM/Cj4gPj4+Pgo+ID4+Pj5pbmZvLT5iYWNrdXBfc3Jj
X3N0YXJ0ID0gQkFDS1VQX1NSQ19TVEFSVDsKPiA+Pj4+aW5mby0+YmFja3VwX3N6ID0gQkFDS1VQ
X1NSQ19FTkQgLSBCQUNLVVBfU1JDX1NUQVJUICsgMTsKPiA+Pj4+Cj4gPj4+PkkgdGhpbmsgSSBo
YXZlIGNvbmNlcm4gZm9yIG1pcHMgdG9vLgo+ID4+Pgo+ID4+PlJpZ2h0LCB3ZSBuZWVkIHRvIGlu
aXRpYWxpemUgdGhlbSBpbiBsb2FkX2NyYXNoZHVtcF9zZWdtZW50cygpLgo+ID4+Pgo+ID4+Pkhv
dyBhYm91dCB0aGUgYXR0YWNoZWQgcGF0Y2g/IEl0IGlzIHVudGVzdGVkLgo+ID4+Pgo+ID4+Cj4g
Pj4+U2lnbmVkLW9mZi1ieTogV0FORyBDb25nPGFtd2FuZ0ByZWRoYXQuY29tPgo+ID4+Cj4gPj5P
aywgdGhpcyBvbmUgbG9va3MgYmV0dGVyLgo+ID4KPiA+Vml2ZWssIGNhbiBJIHRha2UgdGhhdCBh
cyBhbiBBY2tlZC1ieT8KPiA+Cj4gPkNvbmcsIGNhbiB5b3UgY2xhcmlmeSBpZiBJIG5lZWQgdG8g
cmV2ZXJ0IGFueSBvZiB5b3VyIHJlY2VudCBwYXRjaGVzIG9yCj4gPm5vdD8KPiAKPiBObywgdGhh
dCBhdHRhY2hlZCBwYXRjaCBpcyByaWdodCB0byBmaXggdGhlIGZpcnN0IG9uZSwgc28geW91IGRv
bid0Cj4gbmVlZCB0byByZXZlcnQgYW55dGhpbmcuCgpUaGFua3MsIHB1c2hlZC4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlz
dAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8va2V4ZWMK

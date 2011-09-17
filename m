Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1R4pzy-0001cU-Qa
	for kexec@lists.infradead.org; Sat, 17 Sep 2011 08:11:43 +0000
Date: Sat, 17 Sep 2011 17:11:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC] sh: Take into account the base of physical memory in
	virt_to_phys()
Message-ID: <20110917081129.GB22218@verge.net.au>
References: <1316085179-4207-1-git-send-email-horms@verge.net.au>
	<CANqRtoSa-Bk-QAdfzHQra8WTe93Qp=yMMm5Z81zYnHo7t158Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANqRtoSa-Bk-QAdfzHQra8WTe93Qp=yMMm5Z81zYnHo7t158Bw@mail.gmail.com>
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
To: Magnus Damm <magnus.damm@gmail.com>
Cc: kexec@lists.infradead.org, linux-sh@vger.kernel.org

T24gRnJpLCBTZXAgMTYsIDIwMTEgYXQgMDc6NTk6MjFQTSArMDkwMCwgTWFnbnVzIERhbW0gd3Jv
dGU6Cj4gT24gVGh1LCBTZXAgMTUsIDIwMTEgYXQgODoxMiBQTSwgU2ltb24gSG9ybWFuIDxob3Jt
c0B2ZXJnZS5uZXQuYXU+IHdyb3RlOgo+ID4gUHJldmlvdXNseSB2aXJ0X3RvX3BoeXMoKSBhc3N1
bWVkIHRoYXQgcGh5c2ljYWwgbWVtb3J5IGFsd2F5cyBzdGFydGVkCj4gPiBhdCBhZGRyZXNzIDAu
IFRoaXMgaXMgbm90IGFsd2F5cyB0aGUgY2FzZS4KPiAKPiBJIHRoaW5rIG1vc3QgYm9hcmRzIGhh
dmUgTk9SIEZsYXNoIG9yIFJPTSBtYXBwZWQgYXQgcGh5c2ljYWwgYWRkcmVzcyAwLgo+IAo+IEZv
ciBtb3JlIGluZm9ybWF0aW9uIHBsZWFzZSBoYXZlIGEgbG9vayBhdDogYXJjaC9zaC9ib2FyZHMv
bWFjaC1lY292ZWMyNC9zZXR1cC5jCj4gCj4gPiAtLS0gYS9rZXhlYy9hcmNoL3NoL2tleGVjLXNo
LmMKPiA+ICsrKyBiL2tleGVjL2FyY2gvc2gva2V4ZWMtc2guYwo+ID4gQEAgLTE4OCwxMCArMTg4
LDE4IEBAIHZvaWQga2V4ZWNfc2hfc2V0dXBfemVyb19wYWdlKGNoYXIgKnplcm9fcGFnZV9idWYs
IHNpemVfdCB6ZXJvX3BhZ2Vfc2l6ZSwKPiA+IMKgdW5zaWduZWQgbG9uZyB2aXJ0X3RvX3BoeXMo
dW5zaWduZWQgbG9uZyBhZGRyKQo+ID4gwqB7Cj4gPiDCoCDCoCDCoCDCoHVuc2lnbmVkIGxvbmcg
c2VnID0gYWRkciAmIDB4ZTAwMDAwMDA7Cj4gPiArIMKgIMKgIMKgIHVuc2lnbmVkIGxvbmcgbG9u
ZyBzdGFydCwgZW5kOwo+ID4gKyDCoCDCoCDCoCBpbnQgcmV0Owo+ID4gKwo+ID4gKyDCoCDCoCDC
oCAvKiBBc3N1bWUgdGhlcmUgaXMgb25seSBvbmUgIlN5c3RlbSBSQU0iIHJlZ2lvbiAqLwo+ID4g
KyDCoCDCoCDCoCByZXQgPSBwYXJzZV9pb21lbV9zaW5nbGUoIlN5c3RlbSBSQU1cbiIsICZzdGFy
dCwgJmVuZCk7Cj4gPiArIMKgIMKgIMKgIGlmIChyZXQpCj4gPiArIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGRpZSgiQ291bGQgbm90IHBhcnNlIFN5c3RlbSBSQU0gcmVnaW9uIGluIC9wcm9jL2lvbWVt
XG4iKTsKPiA+ICsKPiA+IMKgIMKgIMKgIMKgaWYgKHNlZyAhPSAweDgwMDAwMDAwICYmIHNlZyAh
PSAweGMwMDAwMDAwKQo+ID4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBkaWUoIlZpcnR1YWwgYWRk
cmVzcyAlcCBpcyBub3QgaW4gUDEgb3IgUDJcbiIsICh2b2lkICopYWRkcik7Cj4gPgo+ID4gLSDC
oCDCoCDCoCByZXR1cm4gYWRkciAtIHNlZzsKPiA+ICsgwqAgwqAgwqAgcmV0dXJuIGFkZHIgLSBz
ZWcgKyBzdGFydDsKPiA+IMKgfQo+IAo+IFRoaXMgd2lsbCBtb3N0IGxpa2VseSBhbHNvIGNoYW5n
ZSBob3cgMjktYml0IHBsYXRmb3JtcyB0cmFuc2xhdGUgdGhlaXIKPiBhZGRyZXNzZXMsIG5vdCBz
dXJlIGlmIHRoYXQncyB3aGF0IHlvdSB3YW50IHRvIGRvLgoKSSBhbSBhbHNvIHVuc3VyZSBhYm91
dCB0aGUgMjliaXQgY2FzZS4gRG8geW91IGhhdmUgYW55IHRob3VnaHRzIG9uCndoYXQgYSBnb29k
IGFwcHJvYWNoIG1pZ2h0IGxvb2sgbGlrZT8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVj
Cg==

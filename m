Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RSPai-0005QJ-Jp
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 08:51:09 +0000
Date: Mon, 21 Nov 2011 17:50:58 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [Patch] kexec: fix several issues in get_crash_notes()
Message-ID: <20111121085057.GB6187@verge.net.au>
References: <1321448966-25163-1-git-send-email-xiyou.wangcong@gmail.com>
 <20111118021155.GM14082@verge.net.au>
 <CAM_iQpUFSHrEy9z902iMucEN5EisxdjO=QYtJGkF=f1m6qnAKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAM_iQpUFSHrEy9z902iMucEN5EisxdjO=QYtJGkF=f1m6qnAKg@mail.gmail.com>
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
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org

T24gTW9uLCBOb3YgMjEsIDIwMTEgYXQgMDM6NDM6MzRQTSArMDgwMCwgQ29uZyBXYW5nIHdyb3Rl
Ogo+IE9uIEZyaSwgTm92IDE4LCAyMDExIGF0IDEwOjExIEFNLCBTaW1vbiBIb3JtYW4gPGhvcm1z
QHZlcmdlLm5ldC5hdT4gd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAxNiwgMjAxMSBhdCAwOTowOToy
NlBNICswODAwLCBXQU5HIENvbmcgd3JvdGU6Cj4gPj4gYSkgV2UgZG9uJ3QgbmVlZCAnY3Jhc2hf
bm90ZXMnIGFycmF5IGF0IGFsbCwgc2F2ZSBzb21lIGJ5dGVzIG9uIHN0YWNrLgo+ID4+IGIpIFdl
IGZvcmdvdCB0byBmY2xvc2UgJ2ZwJyBiZWZvcmUgcmV0dXJuLgo+ID4+Cj4gPj4gU2lnbmVkLW9m
Zi1ieTogV0FORyBDb25nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5jb20+Cj4gPj4KPiA+PiAtLS0K
PiA+PiBkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9pMzg2L2NyYXNoZHVtcC14ODYuYyBiL2tleGVj
L2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKPiA+PiBpbmRleCA5OGNkYTcyLi4zMzNmNmJhIDEw
MDY0NAo+ID4+IC0tLSBhL2tleGVjL2FyY2gvaTM4Ni9jcmFzaGR1bXAteDg2LmMKPiA+PiArKysg
Yi9rZXhlYy9hcmNoL2kzODYvY3Jhc2hkdW1wLXg4Ni5jCj4gPj4gQEAgLTU4OSwyMCArNTg5LDE4
IEBAIHN0YXRpYyBpbnQgY21kbGluZV9hZGRfZWxmY29yZWhkcihjaGFyICpjbWRsaW5lLCB1bnNp
Z25lZCBsb25nIGFkZHIpCj4gPj4gwqAgKi8KPiA+PiDCoHN0YXRpYyBpbnQgZ2V0X2NyYXNoX25v
dGVzKGludCBjcHUsIHVpbnQ2NF90ICphZGRyLCB1aW50NjRfdCAqbGVuKQo+ID4+IMKgewo+ID4+
IC0gwqAgwqAgY2hhciBjcmFzaF9ub3Rlc1tQQVRIX01BWF07Cj4gPgo+ID4gSSB3b25kZXIgaWYg
dGhlIGZvbGxvd2luZyBtaWdodCByZWR1Y2UgbWVtb3J5IHVzYWdlOgo+ID4KPiA+IMKgIMKgIMKg
IMKgY29uc3QgY2hhciAqY3Jhc2hfbm90ZXMgPSAiL3N5cy9rZXJuZWwvY3Jhc2hfbm90ZXMiOwo+
IAo+IFllYWgsIHN1cmUuIEJlbG93IGlzIHRoZSBuZXcgcGF0Y2guCj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0+Cj4gCj4gYSkgV2UgZG9uJ3QgbmVlZCAnY3Jhc2hfbm90ZXMnIGFycmF5IGF0IGFsbCwg
c2F2ZSBzb21lIGJ5dGVzIG9uIHN0YWNrLgo+IGIpIFdlIGZvcmdvdCB0byBmY2xvc2UgJ2ZwJyBi
ZWZvcmUgcmV0dXJuLgoKVGhhbmtzLCBhcHBsaWVkLgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK

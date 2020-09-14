Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHgWx-0005En-Fn
 for kexec@lists.infradead.org; Mon, 14 Sep 2020 04:55:56 +0000
Subject: Re: makedumpfile: a feature question about filtering
References: <9da0d585-4170-5758-e27d-814fcb97d575@redhat.com>
 <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
From: piliu <piliu@redhat.com>
Message-ID: <0b99591e-7117-7661-e728-684ece22787e@redhat.com>
Date: Mon, 14 Sep 2020 12:55:45 +0800
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB1991C082928AD18ED5574DDBDD240@OSBPR01MB1991.jpnprd01.prod.outlook.com>
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
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= <k-hagio-ab@nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

CgpPbiAwOS8xMS8yMDIwIDA0OjUzIFBNLCBIQUdJTyBLQVpVSElUTyjokKnlsL7jgIDkuIDku4Ep
IHdyb3RlOgo+IEhpIFBpbmdmYW4sCj4gCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPj4g
SGVsbG8sCj4+Cj4+IFRoZXJlIGlzIGFuIGFwcGVhbCB3aGljaCBvbmx5IHdhbnRzIHRvIHNhdmUg
c29tZSB1c2VyIHBhZ2UgaW5jbHVkaW5nIGVudgo+PiBhbmQgYXJncyBwYWdlcywgYW5kIGRpc2Nh
cmRzIHRoZSBvdGhlciB1c2VyIHNwYWNlIHBhZ2VzLgo+IAo+IEkgdW5kZXJzdGFuZCB0aGF0IGl0
J3MgaGVscGZ1bCB0byBnZXQgdGhlbSBldmVuIHdpdGggLWQgMzEgZm9yIGNyYXNoJ3MKPiAicHMg
LWEiIG9wdGlvbi4uCj4gCj4+Cj4+IFRvIGFjaGlldmUgdGhpcyBmZWF0dXJlLCBtbV9zdHJ1Y3Qn
cyBtZW1iZXJzICJhcmdfc3RhcnQsIGFyZ19lbmQsCj4+IGVudl9zdGFydCwgZW52X2VuZDsiIHNo
b3VsZCBiZSBhY2Nlc3NlZC4gU28gd2UgbmVlZCB0byBleHBvcnQgbW1fc3RydWN0Cj4+IGFuZCBp
bml0X21tIHRocm91Z2ggdm1jb3JlLgo+IAo+IEhvdyBtYW55IG9mZnNldHMvc2l6ZXMgd2lsbCBi
ZSByZXF1aXJlZCB0byB3YWxrIGFsbCB0YXNrcz8KQXQgcHJlc2VudCwgSSB0aGluayBvbmx5IHRo
ZSBpbmZvICJhcmdfc3RhcnQsIGFyZ19lbmQsIGVudl9zdGFydCwKZW52X2VuZCIgaW4gbW1fc3Ry
dWN0IGFyZSByZXF1aXJlZC4KPiBJZiBrZXJuZWwgbWFpbnRhaW5lcnMgYWNjZXB0IGl0LCBJIHdp
bGwgbm90IG9wcG9zZSB0aGF0IGZlYXR1cmUuLgpPSywgSSB3aWxsIHN0YXJ0IHdpdGgga2VybmVs
IHNpZGUgYXMgdGhlIGZpcnN0IHN0ZXAuCj4gCj4gKG9yIGl0IHdvdWxkIGJlIHNpbXBsZXIgdG8g
bWFyayB0aGUgcGFnZXMgc29tZXRoaW5nIHNwZWNpYWwgd2hlbiBhbGxvY2F0aW5nLAo+IGJ1dCBJ
IGRvbid0IGZlZWwgbGlrZSBpdCdzIGVhc3kgdG8gY2hhbmdlIGtlcm5lbCB0byBkbyBzby4pClll
cywgSSBhZ3JlZS4gRnJvbSBrZXJuZWwgc2lkZSwgdGhlIHBhZ2UgaXMgYSBub3JtYWwgdXNlciBz
cGFjZSBwYWdlLAp0aGVyZSBzaG91bGQgbm90IGJlIGV4Y2VwdGlvbi4KClRoYW5rcywKUGluZ2Zh
bgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVj
IG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

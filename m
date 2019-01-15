Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjMSH-0003O9-Az
 for kexec@lists.infradead.org; Tue, 15 Jan 2019 11:00:26 +0000
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190114192144.GQ2773@zn.tnic>
 <134663991.69764038.1547494607008.JavaMail.zimbra@redhat.com>
 <20190114195940.GS2773@zn.tnic>
 <244986363.69770015.1547496453312.JavaMail.zimbra@redhat.com>
 <20190114201812.GT2773@zn.tnic>
 <221183717.69773903.1547497592624.JavaMail.zimbra@redhat.com>
 <20190114203500.GU2773@zn.tnic>
 <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
From: lijiang <lijiang@redhat.com>
Message-ID: <a1613510-658e-410c-7554-4b378ae2e756@redhat.com>
Date: Tue, 15 Jan 2019 19:00:12 +0800
MIME-Version: 1.0
In-Reply-To: <1862896935.69778880.1547498954956.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>, Borislav Petkov <bp@alien8.de>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

5ZyoIDIwMTnlubQwMeaciDE15pelIDA0OjQ5LCBEYXZlIEFuZGVyc29uIOWGmemBkzoKPiAKPiAK
PiAtLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4+IE9uIE1vbiwgSmFuIDE0LCAyMDE5IGF0
IDAzOjI2OjMyUE0gLTA1MDAsIERhdmUgQW5kZXJzb24gd3JvdGU6Cj4+PiBOby4gIEl0IG5lZWRz
ICpib3RoKiB0aGUgdm1saW51eCBmaWxlIGFuZCB0aGUgdm1jb3JlIGZpbGUgaW4gb3JkZXIgdG8g
cmVhZAo+Pj4ga2VybmVsCj4+PiB2aXJ0dWFsIG1lbW9yeSwgc28ganVzdCBoYXZpbmcgYSBrZXJu
ZWwgdmlydHVhbCBhZGRyZXNzIGlzIGluc3VmZmljaWVudC4KPj4+Cj4+PiBTbyBpdCdzIGEgY2hp
Y2tlbi1hbmQtZWdnIHNpdHVhdGlvbi4gIFRoaXMgcGFydGljdWxhciAtLW9zcmVsZWFzZSBvcHRp
b24gaXMgdXNlZAo+Pj4gdG8gZGV0ZXJtaW5lICp3aGF0KiB2bWxpbnV4IGZpbGUgd291bGQgYmUg
cmVxdWlyZWQgZm9yIGFuIGFjdHVhbCBjcmFzaCBhbmFseXNpcwo+Pj4gc2Vzc2lvbi4KPj4KPj4g
T2ssIHRoYXQgbWFrZXMgc2Vuc2UuIEkgY291bGQndmUgdXNlZCB0aGF0IGV4cGxhbmF0aW9uIHdo
ZW4gcmV2aWV3aW5nCj4+IHRoZSBkb2N1bWVudGF0aW9uLiBEbyB5b3UgbWluZCBza2ltbWluZyB0
aHJvdWdoIHRoaXM6Cj4+Cj4+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTAxMTExNDU2
NTAuR0c0NzI5QHpuLnRuaWMKPj4KPj4gaW4gY2FzZSB3ZSd2ZSBtaXNzZWQgZXhwbGFpbmluZyBy
ZWxldmFudCB1c2FnZSAtIGxpa2UgdGhhdCBhYm92ZSAtIG9mCj4+IHNvbWUgb2YgdGhlIHZtY29y
ZWluZm8gbWVtYmVycz8KPiAKPiBZZWFoLCBJJ3ZlIGJlZW4gd2F0Y2hpbmcgdGhlIHRocmVhZCwg
YW5kIHRoZSBkb2N1bWVudCBsb29rcyBmaW5lIHRvIG1lLgo+IEl0J3MganVzdCB0aGF0IHdoZW4g
SSBzYXcgdGhlIGRpc2N1c3Npb24gb2YgdGhpcyBvbmUgYmVpbmcgcmVtb3ZlZCB0aGF0Cj4gSSBm
ZWx0IHRoZSBuZWVkIHRvIHJlc3BvbmQuLi4gIDstKQoKVGhhbmsgeW91IGZvciBleHBsYWluaW5n
IHRoaXMgaXNzdWUuIAoKUmVnYXJkcywKTGlhbmJvCgo+IAo+IERhdmUKPiAKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK

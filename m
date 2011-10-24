Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RINz8-0004qU-Rv
	for kexec@lists.infradead.org; Mon, 24 Oct 2011 17:06:51 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1319468137.3615.16.camel@br98xy6r>
	<m1ipneifqv.fsf@fess.ebiederm.org>
	<CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
Date: Mon, 24 Oct 2011 10:07:19 -0700
In-Reply-To: <CAM_iQpVktWsgOFCWoT47dQ1YdSTnnbTZAAKNYEEX=5wWzhHMzg@mail.gmail.com>
	(=?utf-8?Q?=22Am=C3=A9rico?= Wang"'s message of "Mon,
	24 Oct 2011 23:23:33 +0800")
Message-ID: <m1aa8qfhdk.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kdump: crash_kexec()-smp_send_stop() race in panic
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
To: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org, holzheu@linux.vnet.ibm.com, Vivek Goyal <vgoyal@redhat.com>

QW3DqXJpY28gV2FuZyA8eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tPiB3cml0ZXM6Cgo+IE9uIE1v
biwgT2N0IDI0LCAyMDExIGF0IDExOjE0IFBNLCBFcmljIFcuIEJpZWRlcm1hbgo+IDxlYmllZGVy
bUB4bWlzc2lvbi5jb20+IHdyb3RlOgo+PiBNaWNoYWVsIEhvbHpoZXUgPGhvbHpoZXVAbGludXgu
dm5ldC5pYm0uY29tPiB3cml0ZXM6Cj4+Cj4+PiBIZWxsbyBWaXZlaywKPj4+Cj4+PiBJbiBvdXIg
dGVzdHMgd2UgcmFuIGludG8gdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoKPj4+Cj4+PiBUd28gQ1BV
cyBoYXZlIGNhbGxlZCBwYW5pYyBhdCB0aGUgc2FtZSB0aW1lLiBUaGUgZmlyc3QgQ1BVIGNhbGxl
ZAo+Pj4gY3Jhc2hfa2V4ZWMoKSBhbmQgdGhlIHNlY29uZCBDUFUgY2FsbGVkIHNtcF9zZW5kX3N0
b3AoKSBpbiBwYW5pYygpCj4+PiBiZWZvcmUgY3Jhc2hfa2V4ZWMoKSBmaW5pc2hlZCBvbiB0aGUg
Zmlyc3QgQ1BVLiBTbyB0aGUgc2Vjb25kIENQVQo+Pj4gc3RvcHBlZCB0aGUgZmlyc3QgQ1BVIGFu
ZCB0aGVyZWZvcmUga2R1bXAgZmFpbGVkLgo+Pj4KPj4+IDFzdCBDUFU6Cj4+PiBwYW5pYygpLT5j
cmFzaF9rZXhlYygpLT5tdXRleF90cnlsb2NrKCZrZXhlY19tdXRleCktPiBkbyBrZHVtcAo+Pj4K
Pj4+IDJuZCBDUFU6Cj4+PiBwYW5pYygpLT5jcmFzaF9rZXhlYygpLT5rZXhlY19tdXRleCBhbHJl
YWR5IGhlbGQgYnkgMXN0IENQVQo+Pj4gwqAgwqAgwqAgwqAtPnNtcF9zZW5kX3N0b3AoKS0+IHN0
b3AgQ1BVIDEgKHN0b3Aga2R1bXApCj4+Pgo+Pj4gSG93IHNob3VsZCB3ZSBmaXggdGhpcyBwcm9i
bGVtPyBPbmUgcG9zc2liaWxpdHkgY291bGQgYmUgdG8gZG8KPj4+IHNtcF9zZW5kX3N0b3AoKSBi
ZWZvcmUgd2UgY2FsbCBjcmFzaF9rZXhlYygpLgo+Pj4KPj4+IFdoYXQgZG8geW91IHRoaW5rPwo+
Pgo+PiBzbXBfc2VuZF9zdG9wIGlzIGluc3VmZmljaWVudGx5IHJlbGlhYmxlIHRvIGJlIHVzZWQg
YmVmb3JlIGNyYXNoX2tleGVjLgo+Pgo+PiBNeSBmaXJzdCByZWFjdGlvbiB3b3VsZCBiZSB0byB0
ZXN0IG9vcHNfaW5fcHJvZ3Jlc3MgYW5kIHdhaXQgdW50aWwKPj4gb29wc19pbl9wcm9ncmVzcyA9
PSAxIGJlZm9yZSBjYWxsaW5nIHNtcF9zZW5kX3N0b3AuCj4+Cj4KPiArMQo+Cj4gT25lIG9mIG15
IGNvbGxlYWd1ZSBtZW50aW9uZWQgdGhlIHNhbWUgcHJvYmxlbSB3aXRoIG1lIGluc2lkZQo+IFJI
LCBnaXZlbiB0aGUgZmFjdCB0aGF0IHRoZSByYWNlIGNvbmRpdGlvbiB3aW5kb3cgaXMgc21hbGws
IGl0IHdvdWxkCj4gbm90IGJlIGVhc3kgdG8gcmVwcm9kdWNlIHRoaXMgc2NlbmFyaW8uCgpBcyBm
b3IgcmVwcm9kdWNpbmcgaXQgSSBoYXZlIGEgaHVuY2ggeW91IGNvdWxkIGhhY2sgdXAgc29tZXRo
aW5nCmhvcnJpYmxlIHdpdGggc21wX2NhbGxfZnVuY3Rpb24gYW5kIGtwcm9iZXMuCgoKT24gYSBs
aXR0bGUgbW9yZSByZWZsZWN0aW9uIHdlIGNhbid0IHdhaXQgdW50aWwgb29wc19pbl9wcm9ncmVz
cyBnb2VzCnRvIDEgYmVmb3JlIGNhbGxpbmcgc21wX3NlbmRfc3RvcC4gIEJlY2F1c2UgaWYgY3Jh
c2hfa2V4ZWMgaXMgbm90Cmludm9sdmVkIG5vdGhpbmcgd2Ugd2lsbCBuZXZlciBjYWxsIHNtcF9z
ZW5kX3N0b3AuIAoKU28gbXkgc2Vjb25kIHRob3VnaHQgaXMgdG8gaW50cm9kdWNlIGFub3RoZXIg
YXRvbWljIHZhcmlhYmxlCnBhbmljX2luX3Byb2dyZXNzLCB2aXNpYmxlIG9ubHkgaW4gcGFuaWMu
ICBUaGUgY3B1IHRoYXQgc2V0cwppbmNyZW1lbnRzIHBhbmljX2luX3Byb2dyZXNzIGNhbiBjYWxs
IHNtcF9zZW5kX3N0b3AuICBUaGUgcmVzdCBvZgp0aGUgY3B1cyBjYW4ganVzdCBnbyBpbnRvIGEg
YnVzeSB3YWl0LiAgVGhhdCBzaG91bGQgc3RvcCBuYXN0eQpmaWdodHMgYWJvdXQgd2hvIGlzIGdv
aW5nIHRvIGNvbWUgb3V0IG9mIHNtcF9zZW5kX3N0b3AgZmlyc3QuCgpFcmljCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==

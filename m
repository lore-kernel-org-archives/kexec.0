Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OdgE3-0005Wj-C4
	for kexec@lists.infradead.org; Tue, 27 Jul 2010 09:13:28 +0000
Received: by pzk3 with SMTP id 3so1587695pzk.36
	for <kexec@lists.infradead.org>; Tue, 27 Jul 2010 02:13:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100726152315.GA18789@hmsreliant.think-freely.org>
References: <20100713134609.GA14514@hmsreliant.think-freely.org>
	<20100726152315.GA18789@hmsreliant.think-freely.org>
Date: Tue, 27 Jul 2010 17:13:24 +0800
Message-ID: <AANLkTimx4=y4DgreWJOQ2=y4CmMm1p7bku=UJtsXXss3@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add vmcoreinfo symbols to allow makdumpfile to 
	filter core files properly
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, paulus@samba.org, vgoyal@redhat.com

T24gTW9uLCBKdWwgMjYsIDIwMTAgYXQgMTE6MjMgUE0sIE5laWwgSG9ybWFuIDxuaG9ybWFuQHR1
eGRyaXZlci5jb20+IHdyb3RlOgo+IE9uIFR1ZSwgSnVsIDEzLCAyMDEwIGF0IDA5OjQ2OjA5QU0g
LTA0MDAsIE5laWwgSG9ybWFuIHdyb3RlOgo+PiBIZXkgYWxsLQo+PiDCoCDCoCDCoCBBYm91dCAy
IHllYXJzIGFnbyBub3csIEkgc2VudCB0aGlzIHBhdGNoIHVwc3RyZWFtIHRvIGFsbG93IG1ha2Vk
dW1wZmlsZQo+PiB0byBwcm9wZXJseSBmaWx0ZXIgY29yZXMgb24gcHBjNjQ6Cj4+IGh0dHA6Ly93
d3cubWFpbC1hcmNoaXZlLmNvbS9rZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnL21zZzAyNDI2Lmh0
bWwKPj4gSXQgZ290IGFja3MgZnJvbSB0aGUga2V4ZWMgZm9sa3Mgc28gSSBwdWxsZWQgaXQgaW50
byBSSEVMLCBidXQgSSBuZXZlciBjaGVja2VkCj4+IGJhY2sgaGVyZSB0byBtYWtlIHN1cmUgaXQg
ZXZlciBtYWRlIGl0IGluLCB3aGljaCBhcHBhcmVudGx5IGl0IGRpZG4ndC4gwqBJdCBzdGlsbAo+
PiBuZWVkcyB0byBiZSBpbmNsdWRlZCwgc28gSSdtIHJlcG9zdGluZyBpdCBoZXJlLCBtYWtpbmcg
c3VyZSB0byBjb3B5IGFsbCB0aGUgcHBjCj4+IGZvbGtzIHRoaXMgdGltZS4gwqBJJ3ZlIHJldGVz
dGVkIGl0IG9uIHRoZSBsYXRlc3QgbGludXMga2VybmVsIGFuZCBpdCB3b3JrcyBmaW5lLAo+PiBh
bGxvd2luZyBtYWtlZHVtcGZpbGUgdG8gZmluZCBhbGwgdGhlIHN5bWJvbHMgaXQgbmVlZHMgdG8g
cHJvcGVybHkgc3RyaXAgYQo+PiB2bWNvcmUgb24gcHBjNjQuCj4+Cj4+IE5laWwKPj4KPj4gU2ln
bmVkLW9mZi1ieTogTmVpbCBIb3JtYW4gPG5ob3JtYW5AdHV4ZHJpdmVyLmNvbT4KPj4KPiBQaW5n
LCBhbnlvbmUgd2FudCB0byBjaGltZSBpbiBvbiB0aGlzLCBpdHMgbmVlZGVkIGZvciBkdW1wIGZp
bHRlcmluZyB0byB3b3JrCj4gcHJvcGVybHkgb24gcHBjNjQKClRoaXMgcGF0Y2ggbG9va3MgZ29v
ZCBmb3IgbWUuCgpSZXZpZXdlZC1ieTogV0FORyBDb25nIDx4aXlvdS53YW5nY29uZ0BnbWFpbC5j
b20+CgpUaGFua3MhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

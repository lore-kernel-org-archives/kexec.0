Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from az33egw02.freescale.net ([192.88.158.103])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MoWXP-0003zn-NT
	for kexec@lists.infradead.org; Fri, 18 Sep 2009 06:01:49 +0000
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8I61eBY000478
	for <kexec@lists.infradead.org>; Thu, 17 Sep 2009 23:01:41 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8I63auL010013
	for <kexec@lists.infradead.org>; Fri, 18 Sep 2009 01:03:37 -0500 (CDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: The failure of the KEXEC on ARM1136
Date: Fri, 18 Sep 2009 14:01:10 +0800
Message-ID: <E99B4DCB8B5A0241832DBF4FCB7C813A7D05A5@zch01exm27.fsl.freescale.net>
In-Reply-To: <20090916035131.GO24467@verge.net.au>
References: <E99B4DCB8B5A0241832DBF4FCB7C813A7D0280@zch01exm27.fsl.freescale.net>
	<20090916035131.GO24467@verge.net.au>
From: "Lai Weilin-B04597" <B04597@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

SGkgU2ltb24sCkkgYW0gdHJ5aW5nIHRvIGdldCBrZXhlYyB3b3JraW5nIG9uIGFuIEFSTTExMzYg
dXNpbmcgdGhlIDIuMC4xIHZlcnNpb24gb2YgdGhlIEtFWEVDLgoKVGhlIGxvYWRpbmcgc2VlbXMg
dG8gd29yayBvay4gT24gImtleGVjIC1lIiwgSSBzZWU6CgpTdGFydGluZyBuZXcga2VybmVsClVu
Y29tcHJlc3NpbmcgTGludXguLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4KCmNyYyBlcnJvcgoKIC0tIFN5c3RlbSBoYWx0ZWQKCkhhdmUgeW91IGV2ZXIgc2VlbiB0aGlz
IGtpbmQgb2YgZmFpbHVyZSA/IAoKCkJlc3QgUmVnYXJkcy4KV2lsbGlhbSBMYWkKMDIxLTI4OTM3
MTUyCjE1OTIxMjU2MzgzCiAKCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCkZyb206IFNpbW9u
IEhvcm1hbiBbbWFpbHRvOmhvcm1zQHZlcmdlLm5ldC5hdV0gClNlbnQ6IDIwMDnE6jnUwjE2yNUg
MTE6NTIKVG86IExhaSBXZWlsaW4tQjA0NTk3CkNjOiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
ClN1YmplY3Q6IFJlOiBIb3cgdG8gYnVpbGQgdGhlIGtleGVjIHRvbyBmb3IgQVJNMTEgdXNpbmcg
dGhlIGNyb3NzIGNvbXBpbGVyLgoKT24gV2VkLCBTZXAgMTYsIDIwMDkgYXQgMTE6MDY6MzRBTSAr
MDgwMCwgTGFpIFdlaWxpbi1CMDQ1OTcgd3JvdGU6Cj4gSGksCj4gSSBhbSB0cnlpbmcgdG8gYnVp
bGQga2V4ZWMgdG9vbCBmb3IgQVJNMTEuICBJIGNhbid0IHNlZSBhbnkgZG9jIHRoYXQgCj4gaGVs
cHMgdG8gY29uZmlndXJlLiBUaGUgY3Jvc3MgY29tcGlsZXIgaXMgdXNlZCwgYW5kIEkgdHJpZWQg
dGhlIAo+IGZvbGxvd2luZyBjb25maWd1cmUgb3B0aW9uLCAuL2NvbmZpZ3VyZSBhcm0gLS1wcmVm
aXg9L3VzciAKPiAtLWJ1aWxkPWFybS1ub25lLWxpbnV4LWdudWVhYmkgLS1ob3N0PWk2ODYtcGMt
bGludXgtZ251IAo+IC0tdGFyZ2V0PWFybS1ub25lLWxpbnV4LWdudWVhYmkgYnV0IGZhaWxlZC4K
PiBBbnlvbmUgY2FuIGhlbHAgPwoKSGksCgpXaGVuIGNyb3NzLWNvbXBpbGluZyBmb3IgYXJtIHRo
ZSBmb2xsb3dpbmcgd29ya3MgZm9yIG1lOgoKYXV0b2hlYWRlcgphdXRvY29uZgouL2NvbmZpZ3Vy
ZSAtLWhvc3Q9YXJtLXVua25vd24tbGludXgtZ251CgpJbiB3aGF0IHdheSBpcyB3aGF0IHlvdSBh
cmUgdHJ5aW5nIGZhaWxpbmc/CkFuZCBhcmUgeW91IHRyeWluZyB0byBidWlsZCBuYXRpdmVseSBv
ciBjcm9zcy1jb21waWxlPwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

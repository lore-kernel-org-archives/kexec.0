Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx7.zte.com.cn ([202.103.147.169] helo=zte.com.cn)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y8NtL-0003y0-4y
 for kexec@lists.infradead.org; Tue, 06 Jan 2015 06:45:24 +0000
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Websense Email Security Gateway with ESMTPS id B27DE7C1C9891
 for <kexec@lists.infradead.org>; Tue,  6 Jan 2015 14:44:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id t066iSM3060819
 for <kexec@lists.infradead.org>; Tue, 6 Jan 2015 14:44:28 +0800 (GMT-8)
 (envelope-from liu.song11@zte.com.cn)
Subject: some questions about elf_ppc64_load
Message-ID: <OF9C6CA8A8.9D7923CD-ON48257DC5.0023F61F-48257DC5.0024E800@zte.com.cn>
From: liu.song11@zte.com.cn
Date: Tue, 6 Jan 2015 14:44:14 +0800
MIME-Version: 1.0
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
Cc: kexec@lists.infradead.org

DQpoaSBhbGyjrA0KDQpJIHVzZSBrZXhlYy10b29scy0yLjAuOCBmb3IgcHBjNjQsIGluIGZ1Y3Rp
b24gZWxmX3BwYzY0X2xvYWQgcHJvbXB0ICJDYW4ndCB1c2UgcmFtZGlzayB3aXRoIGRldmljZSB0
cmVlIGJsb2IgaW5wdXQiLg0KDQpJIGRvbid0IGtub3cgd2h5IGhlcmUgcmFtZGlzayBjYW4ndCB0
b2dldGhlciB3aXRoIGR0YixhbmQgbmVlZCBzb21lIGhlbHAuDQoNCkkgYWxzbyBoYXZlIHNvbWUg
cXVlc3Rpb25zLCB3aGVuIEkganVzdCAuL2tleGUgLWwgdm1saW51eCB0aGVuIC4va2V4ZWMgLWUs
IHdpbGwganVtcCB0byBzZWNvbmQga2VybmVsIHN1Y2Vzc2Z1bGx5LA0KDQpidXQgd2l0aG91dCB1
c2VmdWwgZHRiLCB0aGVuIGRldmljZSBjYW4ndCBpbml0IGNvcnJlY3QuIEJ1dCwgd2hlbiBJIGlu
cHV0IC4va2V4ZWMgLWwgdm1saW51eCAtLWR0Yj1teS5kdGIgLCB0aGVuDQoNCi4va2V4ZWMgLWUs
IHRoZSBrZXJuZWwgY291bGRuJ3Qgd29yayBhbmQgY3Jhc2ggaW4gaGVhZF82NC5TLCB0aGlzIHBy
b2JsZW0gYWxzbyBtYWtlIG1lIGNvbmZ1c2VkLg0KDQpUaGFua3MNClJlZ2FyZHMNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpaVEUgSW5m
b3JtYXRpb24gU2VjdXJpdHkgTm90aWNlOiBUaGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGluIHRo
aXMgbWFpbCAoYW5kIGFueSBhdHRhY2htZW50IHRyYW5zbWl0dGVkIGhlcmV3aXRoKSBpcyBwcml2
aWxlZ2VkIGFuZCBjb25maWRlbnRpYWwgYW5kIGlzIGludGVuZGVkIGZvciB0aGUgZXhjbHVzaXZl
IHVzZSBvZiB0aGUgYWRkcmVzc2VlKHMpLiAgSWYgeW91IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVj
aXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBkaXN0cmlidXRpb24gb3Igb3Ro
ZXIgZGlzc2VtaW5hdGlvbiBvciB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpcyBz
dHJpY3RseSBwcm9oaWJpdGVkLiAgSWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBtYWlsIGluIGVy
cm9yLCBwbGVhc2UgZGVsZXRlIGl0IGFuZCBub3RpZnkgdXMgaW1tZWRpYXRlbHkuDQpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxp
c3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2tleGVjCg==

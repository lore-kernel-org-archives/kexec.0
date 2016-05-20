Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lb0-x241.google.com ([2a00:1450:4010:c04::241])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b3h5w-0006oF-B4
 for kexec@lists.infradead.org; Fri, 20 May 2016 09:51:48 +0000
Received: by mail-lb0-x241.google.com with SMTP id wx2so1824034lbb.0
 for <kexec@lists.infradead.org>; Fri, 20 May 2016 02:51:27 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH] makedumpfile: Fix compilation warning
Date: Fri, 20 May 2016 12:51:14 +0300
Message-Id: <1463737874-4610-1-git-send-email-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: kexec@lists.infradead.org, Andrey Skvortsov <andrej.skvortzov@gmail.com>

QWZ0ZXIgY29tbWl0IDViYzFmNTIwCltMb29raW5nIGZvciBwYWdlLmNvbXBvdW5kX29yZGVyL2Nv
bXBvdW5kX2R0b3IgdG8gZXhjbHVkZSBodWdlcGFnZXNdCmR1cmluZyBidWlsZCBhcHBlYXJzIGZv
bGxvd2luZyBjb21waWxhdGlvbiB3YXJuaW5nOgoKbWFrZWR1bXBmaWxlLmM6IEluIGZ1bmN0aW9u
IOKAmGlzSHVnZXRsYuKAmToKbWFrZWR1bXBmaWxlLmM6MjQ0OjE6IHdhcm5pbmc6IHR5cGUgb2Yg
4oCYZHRvcuKAmSBkZWZhdWx0cyB0byDigJhpbnTigJkKWy1XaW1wbGljaXQtaW50XQogaXNIdWdl
dGxiKGR0b3IpCiAgXgoKVGVzdGVkIHdpdGggZ2NjIDUuMy4xLgoKU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFNrdm9ydHNvdiA8YW5kcmVqLnNrdm9ydHpvdkBnbWFpbC5jb20+Ci0tLQogbWFrZWR1bXBm
aWxlLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9tYWtlZHVtcGZpbGUuYyBiL21ha2VkdW1wZmlsZS5jCmluZGV4IGNl
OWZiYTYuLjRmMTc2ODYgMTAwNjQ0Ci0tLSBhL21ha2VkdW1wZmlsZS5jCisrKyBiL21ha2VkdW1w
ZmlsZS5jCkBAIC0yNDEsNyArMjQxLDcgQEAgaXNfaW5fc2FtZV9wYWdlKHVuc2lnbmVkIGxvbmcg
dmFkZHIxLCB1bnNpZ25lZCBsb25nIHZhZGRyMikKIH0KIAogc3RhdGljIGlubGluZSBpbnQKLWlz
SHVnZXRsYihkdG9yKQoraXNIdWdldGxiKGludCBkdG9yKQogewogICAgICAgICByZXR1cm4gKChO
VU1CRVIoSFVHRVRMQl9QQUdFX0RUT1IpICE9IE5PVF9GT1VORF9OVU1CRVIpCiAJCSYmIChOVU1C
RVIoSFVHRVRMQl9QQUdFX0RUT1IpID09IGR0b3IpKQotLSAKMi44LjEKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2tleGVjCg==

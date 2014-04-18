Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wb9UM-0004BA-CC
 for kexec@lists.infradead.org; Fri, 18 Apr 2014 14:09:59 +0000
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <clg@fr.ibm.com>;
 Fri, 18 Apr 2014 15:09:34 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id B1CDE1B0805F
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 15:09:35 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3IE9WxD50135130
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 14:09:32 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3IE9VF1028993
 for <kexec@lists.infradead.org>; Fri, 18 Apr 2014 08:09:32 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
Subject: [PATCH 4/7] ppc64, cleanup: cmdline_len variables are unused
Date: Fri, 18 Apr 2014 16:08:37 +0200
Message-Id: <1397830120-13323-5-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
References: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>

Li4va2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYtcHBjNjQuYzoxMDA6MTk6IHdhcm5pbmc6IHZh
cmlhYmxlIOKAmG1vZGlmaWVkX2NtZGxpbmVfbGVu4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51
c2VkLWJ1dC1zZXQtdmFyaWFibGVdCiAgaW50IGNtZGxpbmVfbGVuLCBtb2RpZmllZF9jbWRsaW5l
X2xlbjsKICAgICAgICAgICAgICAgICAgIF4KLi4va2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYt
cHBjNjQuYzoxMDA6Njogd2FybmluZzogdmFyaWFibGUg4oCYY21kbGluZV9sZW7igJkgc2V0IGJ1
dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KICBpbnQgY21kbGluZV9sZW4s
IG1vZGlmaWVkX2NtZGxpbmVfbGVuOwoKU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0Bmci5pYm0uY29tPgotLS0KIGtleGVjL2FyY2gvcHBjNjQva2V4ZWMtZWxmLXBwYzY0LmMg
fCAgICA4ICstLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDcgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEva2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYtcHBjNjQuYyBi
L2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtZWxmLXBwYzY0LmMKaW5kZXggMDY5ZDhiYTZlNjkwLi43
YmUzNTE5OWM3ZTAgMTAwNjQ0Ci0tLSBhL2tleGVjL2FyY2gvcHBjNjQva2V4ZWMtZWxmLXBwYzY0
LmMKKysrIGIva2V4ZWMvYXJjaC9wcGM2NC9rZXhlYy1lbGYtcHBjNjQuYwpAQCAtOTcsNyArOTcs
NiBAQCBpbnQgZWxmX3BwYzY0X2xvYWQoaW50IGFyZ2MsIGNoYXIgKiphcmd2LCBjb25zdCBjaGFy
ICpidWYsIG9mZl90IGxlbiwKIAlzdHJ1Y3QgbWVtX2VoZHIgZWhkcjsKIAljaGFyICpjbWRsaW5l
LCAqbW9kaWZpZWRfY21kbGluZSA9IE5VTEw7CiAJY29uc3QgY2hhciAqZGV2aWNldHJlZWJsb2I7
Ci0JaW50IGNtZGxpbmVfbGVuLCBtb2RpZmllZF9jbWRsaW5lX2xlbjsKIAl1aW50NjRfdCBtYXhf
YWRkciwgaG9sZV9hZGRyOwogCWNoYXIgKnNlZ19idWYgPSBOVUxMOwogCW9mZl90IHNlZ19zaXpl
ID0gMDsKQEAgLTE2NCwxMCArMTYzLDcgQEAgaW50IGVsZl9wcGM2NF9sb2FkKGludCBhcmdjLCBj
aGFyICoqYXJndiwgY29uc3QgY2hhciAqYnVmLCBvZmZfdCBsZW4sCiAJCX0KIAl9CiAKLQljbWRs
aW5lX2xlbiA9IDA7Ci0JaWYgKGNtZGxpbmUpCi0JCWNtZGxpbmVfbGVuID0gc3RybGVuKGNtZGxp
bmUpICsgMTsKLQllbHNlCisJaWYgKCFjbWRsaW5lKQogCQlmcHJpbnRmKHN0ZG91dCwgIldhcm5p
bmc6IGFwcGVuZD0gb3B0aW9uIGlzIG5vdCBwYXNzZWQuIFVzaW5nIHRoZSBmaXJzdCBrZXJuZWwg
cm9vdCBwYXJ0aXRpb25cbiIpOwogCiAJaWYgKHJhbWRpc2sgJiYgcmV1c2VfaW5pdHJkKQpAQCAt
MTgzLDcgKzE3OSw2IEBAIGludCBlbGZfcHBjNjRfbG9hZChpbnQgYXJnYywgY2hhciAqKmFyZ3Ys
IGNvbnN0IGNoYXIgKmJ1Ziwgb2ZmX3QgbGVuLAogCQkJc3RybmNweShtb2RpZmllZF9jbWRsaW5l
LCBjbWRsaW5lLCBDT01NQU5EX0xJTkVfU0laRSk7CiAJCQltb2RpZmllZF9jbWRsaW5lW0NPTU1B
TkRfTElORV9TSVpFIC0gMV0gPSAnXDAnOwogCQl9Ci0JCW1vZGlmaWVkX2NtZGxpbmVfbGVuID0g
c3RybGVuKG1vZGlmaWVkX2NtZGxpbmUpOwogCX0KIAogcmV0cnk6CkBAIC0yMzQsNyArMjI5LDYg
QEAgcmV0cnk6CiAJCQlyZXR1cm4gLTE7CiAJCS8qIFVzZSBuZXcgY29tbWFuZCBsaW5lLiAqLwog
CQljbWRsaW5lID0gbW9kaWZpZWRfY21kbGluZTsKLQkJY21kbGluZV9sZW4gPSBzdHJsZW4obW9k
aWZpZWRfY21kbGluZSkgKyAxOwogCX0KIAogCS8qIEFkZCB2MndyYXAgdG8gdGhlIGN1cnJlbnQg
aW1hZ2UgKi8KLS0gCjEuNy4xMC40CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=

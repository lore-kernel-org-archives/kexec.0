Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IKjJE-0002IP-Rm
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 19:26:56 -0400
Received: from [172.16.3.165] (vagw.valinux.co.jp [210.128.90.14])
	by mail.valinux.co.jp (Postfix) with ESMTP id CED272DC876
	for <kexec@lists.infradead.org>; Tue, 14 Aug 2007 08:26:44 +0900 (JST)
Date: Tue, 14 Aug 2007 08:27:17 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: makedumpfile-1.1.5: Xen support
Message-Id: <20070814082614.DC30.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------_46C0E896E2A7069B6410_MULTIPART_MIXED_"
Content-Transfer-Encoding: 7bit
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

--------_46C0E896E2A7069B6410_MULTIPART_MIXED_
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

> Hmm, adding to skip zero-filled pages is easy but I wonder
> how effective it is ...

I found it is sometimes effective.

The attached patch enables the "-d" option with --xen-syms.
Note that only the level 1 (skip zero-filled pages) is supported.

ex. # makedumpfile -E -d 1 --xen-syms xen-syms.debug vmcore output

Thanks.
Itsuro Oda

On Tue, 31 Jul 2007 07:19:48 +0900
Itsuro ODA <oda@valinux.co.jp> wrote:

> Hi,
> 
> > Is the "-d" dump_level option completely ignored, or can it
> > (without vmlinux awareness) recognize and skip zero-filled
> > pages?
> 
> Yes, "-d" is ignored.
> 
> Hmm, adding to skip zero-filled pages is easy but I wonder
> how effective it is ...
> 
> Thanks.
> -- 
> Itsuro ODA <oda@valinux.co.jp>
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexe
-- 
Itsuro ODA <oda@valinux.co.jp>

--------_46C0E896E2A7069B6410_MULTIPART_MIXED_
Content-Type: application/octet-stream;
 name="patch-zero-070810"
Content-Disposition: attachment;
 filename="patch-zero-070810"
Content-Transfer-Encoding: base64

LS0tIG1ha2VkdW1wZmlsZS5jLm9yZwkyMDA3LTA4LTEwIDE1OjE0OjIyLjAwMDAwMDAwMCArMDkw
MAorKysgbWFrZWR1bXBmaWxlLmMJMjAwNy0wOC0xMCAxNTo1MToxNi4wMDAwMDAwMDAgKzA5MDAK
QEAgLTUxOTUsNiArNTE5NSw5IEBACiAJaW50IGk7CiAJc3RydWN0IHB0X2xvYWRfc2VnbWVudCAq
cGxzOwogCWludCByZXQgPSBGQUxTRTsKKwl1bnNpZ25lZCBsb25nIGxvbmcgcGFkZHI7CisJb2Zm
X3Qgb2Zmc2V0X3BhZ2U7CisJdW5zaWduZWQgY2hhciAqYnVmID0gTlVMTDsKIAogCS8qCiAJICog
Tk9URTogdGhlIGZpcnN0IGhhbGYgb2YgYml0bWFwIGlzIG5vdCB1c2VkIGZvciBYZW4gZXh0cmFj
dGlvbgpAQCAtNTIxMSw2ICs1MjE0LDExIEBACiAJCSAgICBzdHJlcnJvcihlcnJubykpOwogCQln
b3RvIG91dDsKIAl9CisJaWYgKChidWYgPSBtYWxsb2MoaW5mby0+cGFnZV9zaXplKSkgPT0gTlVM
TCkgeworCQlFUlJNU0coIkNhbid0IGFsbG9jYXRlIG1lbW9yeSBmb3IgdGhlIHBhZ2UuICVzXG4i
LAorCQkgICAgc3RyZXJyb3IoZXJybm8pKTsKKwkJZ290byBvdXQ7CisJfQogCiAJcGZuID0gMDsK
IAlmb3IgKGkgPSAwOyBpIDwgaW5mby0+bnVtX2xvYWRfbWVtb3J5OyBpKyspIHsKQEAgLTUyNTUs
MTEgKzUyNjMsMzUgQEAKIAkJCSAqICAtIHhlbiBoZWFwIGFyZWEsIG9yCiAJCQkgKiAgLSBzZWxl
Y3RlZCBkb21haW4gcGFnZQogCQkJICovCi0JCQlpZiAoX2RvbWFpbiA9PSAwIHx8CisJCQlpZiAo
IShfZG9tYWluID09IDAgfHwKIAkJCQkoaW5mby0+eGVuX2hlYXBfc3RhcnQgPD0gcGZuICYmIHBm
biA8IGluZm8tPnhlbl9oZWFwX2VuZCkgfHwKLQkJCQkoKGNvdW50X2luZm8gJiAweGZmZmYpICYm
IGlzX3NlbGVjdF9kb21haW4oaW5mbywgX2RvbWFpbikpKSB7Ci0JCQkJc2V0X2JpdG1hcChibTIu
YnVmLCBwZm4lUEZOX0JVRkJJVE1BUCwgMSk7CisJCQkJKChjb3VudF9pbmZvICYgMHhmZmZmKSAm
JiBpc19zZWxlY3RfZG9tYWluKGluZm8sIF9kb21haW4pKSkpIHsKKwkJCQljb250aW51ZTsKKwkJ
CX0KKwkJCWlmIChpbmZvLT5kdW1wX2xldmVsICYgRExfRVhDTFVERV9aRVJPKSB7CisJCQkJcGFk
ZHIgPSAodW5zaWduZWQgbG9uZyBsb25nKXBmbiAqIGluZm8tPnBhZ2Vfc2l6ZTsKKwkJCQlvZmZz
ZXRfcGFnZSA9IHBhZGRyX3RvX29mZnNldChpbmZvLCBwYWRkcik7CisJCQkJaWYgKCFvZmZzZXRf
cGFnZSkgeworCQkJCQlFUlJNU0coIkNhbid0IGNvbnZlcnQgcGh5c2FkZHIoJWxseCkgdG8gYSBv
ZmZzZXQuXG4iLAorCQkJCQkgICAgcGFkZHIpOworCQkJCQlnb3RvIG91dDsKKwkJCQl9CisJCQkJ
aWYgKGxzZWVrKGluZm8tPmZkX21lbW9yeSwgb2Zmc2V0X3BhZ2UsCisJCQkJICAgIFNFRUtfU0VU
KSA9PSAob2ZmX3QpLTEpIHsKKwkJCQkJRVJSTVNHKCJDYW4ndCBzZWVrIHRoZSBkdW1wIG1lbW9y
eSglcykuICVzXG4iLAorCQkJCQkgICAgaW5mby0+bmFtZV9tZW1vcnksIHN0cmVycm9yKGVycm5v
KSk7CisJCQkJCWdvdG8gb3V0OworCQkJCX0KKwkJCQlpZiAocmVhZChpbmZvLT5mZF9tZW1vcnks
IGJ1ZiwgaW5mby0+cGFnZV9zaXplKQorCQkJCSAgICAhPSBpbmZvLT5wYWdlX3NpemUpIHsKKwkJ
CQkJRVJSTVNHKCJDYW4ndCByZWFkIHRoZSBkdW1wIG1lbW9yeSglcykuICVzXG4iLAorCQkJCQkg
ICAgaW5mby0+bmFtZV9tZW1vcnksIHN0cmVycm9yKGVycm5vKSk7CisJCQkJCWdvdG8gb3V0Owor
CQkJCX0KKwkJCQlpZiAoaXNfemVyb19wYWdlKGJ1ZiwgaW5mby0+cGFnZV9zaXplKSkKKwkJCQkJ
Y29udGludWU7CiAJCQl9CisJCQlzZXRfYml0bWFwKGJtMi5idWYsIHBmbiVQRk5fQlVGQklUTUFQ
LCAxKTsKIAkJfQogCX0KIApAQCAtNTI3NSw2ICs1MzA3LDggQEAKIG91dDoKIAlpZiAoYm0yLmJ1
ZiAhPSBOVUxMKQogCQlmcmVlKGJtMi5idWYpOworCWlmIChidWYgIT0gTlVMTCkKKwkJZnJlZShi
dWYpOwogCiAJcmV0dXJuIHJldDsKIH0KQEAgLTU1NDYsNyArNTU4MCw3IEBACiAJCQlNU0coIi1F
IG11c3QgYmUgc3BlY2lmaWVkIHdpdGggLS14ZW4tc3ltcyBvciAtLXhlbi12bWNvcmVpbmZvLlxu
Iik7CiAJCQlnb3RvIG91dDsKIAkJfQotCQlpbmZvLT5kdW1wX2xldmVsID0gRExfRVhDTFVERV9Y
RU47CisJCWluZm8tPmR1bXBfbGV2ZWwgfD0gRExfRVhDTFVERV9YRU47CiAJCXJldHVybiBoYW5k
bGVfeGVuKGluZm8pOwogCiAJfSBlbHNlIGlmIChpbmZvLT5mbGFnX3JlYXJyYW5nZSkgewo=
--------_46C0E896E2A7069B6410_MULTIPART_MIXED_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------_46C0E896E2A7069B6410_MULTIPART_MIXED_--



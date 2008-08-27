Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.251])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYCMZ-0001yW-Gs
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 04:10:31 +0000
Received: by rv-out-0708.google.com with SMTP id b17so2259660rvf.42
	for <kexec@lists.infradead.org>; Tue, 26 Aug 2008 21:10:30 -0700 (PDT)
Message-ID: <aec7e5c30808262110p8197b84ieaf38211a495daa0@mail.gmail.com>
Date: Wed, 27 Aug 2008 13:10:30 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH 06/06] sh: Add vmlinux support
In-Reply-To: <20080827023905.GL19066@verge.net.au>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13446_27845089.1219810230509"
References: <20080826111150.615.97501.sendpatchset@rx1.opensource.se>
	<20080826111232.615.24048.sendpatchset@rx1.opensource.se>
	<20080827023905.GL19066@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

------=_Part_13446_27845089.1219810230509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Simon,

On Wed, Aug 27, 2008 at 11:39 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Aug 26, 2008 at 08:12:32PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Add SuperH vmlinux support through a zero-page aware elf loader. Only for
>> kexec at this point, in the future kdump support will be added.
>
> If these series of patches are fine by you then they are fine by me.
> I just have a few minor issues with this last patch.

How does the attached patch look?

Thanks for your help!

/ magnus

------=_Part_13446_27845089.1219810230509
Content-Type: application/octet-stream;
	name=kexec-tools-git-superh-vmlinux-fixes-20080827.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fkdfhc5j0
Content-Disposition: attachment;
	filename=kexec-tools-git-superh-vmlinux-fixes-20080827.patch

LS0tIDAwMDcva2V4ZWMvYXJjaC9zaC9rZXhlYy1lbGYtc2guYworKysgd29yay9rZXhlYy9hcmNo
L3NoL2tleGVjLWVsZi1zaC5jCTIwMDgtMDgtMjcgMTI6NTU6NDAuMDAwMDAwMDAwICswOTAwCkBA
IC02NSwxNiArNjUsMTYgQEAgdm9pZCBlbGZfc2hfdXNhZ2Uodm9pZCkKIAkJKTsKIH0KIAotaW50
IGVsZl9zaF9sb2FkKGludCBhcmdjLCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqYnVmLCBvZmZf
dCBsZW4sIAotCXN0cnVjdCBrZXhlY19pbmZvICppbmZvKQoraW50IGVsZl9zaF9sb2FkKGludCBh
cmdjLCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqYnVmLCBvZmZfdCBsZW4sCisJCXN0cnVjdCBr
ZXhlY19pbmZvICppbmZvKQogewogCXN0cnVjdCBtZW1fZWhkciBlaGRyOwotCWNvbnN0IGNoYXIg
KmNvbW1hbmRfbGluZTsKKwljaGFyICpjb21tYW5kX2xpbmU7CiAJc3RydWN0IG1lbV9zeW0gc3lt
OwogCWludCBvcHQ7CiAJc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24gb3B0aW9uc1tdID0gewog
CQlLRVhFQ19BUkNIX09QVElPTlMKLQkJeyAwLCAJCQkwLCBOVUxMLCAwIH0sCisJCXsgMCwgMCwg
MCwgMCB9LAogCX07CiAKIAlzdGF0aWMgY29uc3QgY2hhciBzaG9ydF9vcHRpb25zW10gPSBLRVhF
Q19PUFRfU1RSICIiOwpAQCAtMTA1LDcgKzEwNSw3IEBAIGludCBlbGZfc2hfbG9hZChpbnQgYXJn
YywgY2hhciAqKmFyZ3YsIGMKIAogCS8qIElmIHdlJ3JlIGJvb3RpbmcgYSB2bWxpbnV4IHRoZW4g
ZmlsbCBpbiBlbXB0eV96ZXJvX3BhZ2UgKi8KIAlpZiAoZWxmX3JlbF9maW5kX3N5bWJvbCgmZWhk
ciwgImVtcHR5X3plcm9fcGFnZSIsICZzeW0pID09IDApIHsKLQkJdW5zaWduZWQgY2hhciAqenAg
PSAodm9pZCAqKWVoZHIuZV9zaGRyW3N5bS5zdF9zaG5keF0uc2hfZGF0YTsKKwkJY2hhciAqenAg
PSAodm9pZCAqKWVoZHIuZV9zaGRyW3N5bS5zdF9zaG5keF0uc2hfZGF0YTsKIAogCQlrZXhlY19z
aF9zZXR1cF96ZXJvX3BhZ2UoenAsIDQwOTYsIGNvbW1hbmRfbGluZSk7CiAJfQo=
------=_Part_13446_27845089.1219810230509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

------=_Part_13446_27845089.1219810230509--


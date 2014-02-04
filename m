Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WAejW-0005co-3D
 for kexec@lists.infradead.org; Tue, 04 Feb 2014 12:04:07 +0000
Received: by mail-qc0-f170.google.com with SMTP id e9so13632401qcy.29
 for <kexec@lists.infradead.org>; Tue, 04 Feb 2014 04:03:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140204083053.GC30621@verge.net.au>
References: <CAL5wTH6B-QYbY9bcC+HuBJkk=rEEZhQsggi921YtbGNS4xUfxQ@mail.gmail.com>
 <20140204083053.GC30621@verge.net.au>
Date: Tue, 4 Feb 2014 13:03:42 +0100
Message-ID: <CAL5wTH52b74cixBSfx84w5HH08hieo=pn8vGTnF_9x4GwMPv9w@mail.gmail.com>
Subject: Re: [PATCH] Avoid buffer overflow on strncat usage
From: =?UTF-8?B?RGlyayBNw7xsbGVy?= <dirk@dmllr.de>
Content-Type: multipart/mixed; boundary=001a11c309ea71effc04f1936e75
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

--001a11c309ea71effc04f1936e75
Content-Type: text/plain; charset=UTF-8

Hi Simon,

> I don't think you need the -1 as filename will have a trailing '\0'
> which is not counted in the return value of strlen()

Thats true, but strncat always writes a trailing NUL, and to avoid
that this one overflows the buffer, you need to subtract -1.

However, this code in particular can be rewrittten to use snprintf(),
which avoids
the overflow and is also a bit more readable.

How about the attached patch?

Thanks,
Dirk

--001a11c309ea71effc04f1936e75
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Avoid-buffer-overflow-on-strncat-usage.patch"
Content-Disposition: attachment; 
	filename="0001-Avoid-buffer-overflow-on-strncat-usage.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hr94cnxf0

RnJvbSAwMWQ2ZTQzNzFmMmM0OTQ1OWYzNjAwYTJiYmFkYmM2NmE5NGY4NzBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEaXJrIE11ZWxsZXIgPGRtdWVsbGVyQHN1c2UuY29tPgpEYXRl
OiBNb24sIDMgRmViIDIwMTQgMTg6NTA6MDQgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBdm9pZCBi
dWZmZXIgb3ZlcmZsb3cgb24gc3RybmNhdCB1c2FnZQoKc3RybmNhdCgpIGRvZXMgbm90IHdhbnQg
dGhlIHRvdGFsIHNpemUgYnV0IHRoZSBtYXhpbXVtIGxlbmd0aAood2l0aG91dCB0cmFpbGluZyBO
VUwpIHRoYXQgY2FuIHN0aWxsIGJlIGFkZGVkLiBTd2l0Y2ggb3Zlcgp0byBzbnByaW50ZiB3aGlj
aCBpcyBib3RoIG1vcmUgcmVhZGFibGUgYW5kIGF2b2lkcyB0aGlzIGlzc3VlLgoKU2lnbmVkLW9m
Zi1ieTogRGlyayBNdWVsbGVyIDxkbXVlbGxlckBzdXNlLmNvbT4KLS0tCiBrZXhlYy9mczJkdC5j
IHwgNyArKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2tleGVjL2ZzMmR0LmMgYi9rZXhlYy9mczJkdC5jCmluZGV4IDcz
YzFmYjkuLjVlNmI5OGQgMTAwNjQ0Ci0tLSBhL2tleGVjL2ZzMmR0LmMKKysrIGIva2V4ZWMvZnMy
ZHQuYwpAQCAtNjE5LDggKzYxOSw3IEBAIHN0YXRpYyB2b2lkIHB1dG5vZGUodm9pZCkKIAkJICog
Y29kZSBjYW4gcHJpbnQgJ0knbSBpbiBwdXJnYXRvcnknIG1lc3NhZ2UuIEN1cnJlbnRseSBvbmx5
CiAJCSAqIHBzZXJpZXMvaHZjdGVybWluYWwgaXMgc3VwcG9ydGVkLgogCQkgKi8KLQkJc3RyY3B5
KGZpbGVuYW1lLCBwYXRobmFtZSk7Ci0JCXN0cm5jYXQoZmlsZW5hbWUsICJsaW51eCxzdGRvdXQt
cGF0aCIsIE1BWFBBVEgpOworCQlzbnByaW50ZihmaWxlbmFtZSwgTUFYUEFUSCwgIiVzbGludXgs
c3Rkb3V0LXBhdGgiLCBwYXRobmFtZSk7CiAJCWZkID0gb3BlbihmaWxlbmFtZSwgT19SRE9OTFkp
OwogCQlpZiAoZmQgPT0gLTEpIHsKIAkJCXByaW50ZigiVW5hYmxlIHRvIGZpbmQgJXMsIHByaW50
aW5nIGZyb20gcHVyZ2F0b3J5IGlzIGRpYWJsZWRcbiIsCkBAIC02NDgsOSArNjQ3LDcgQEAgc3Rh
dGljIHZvaWQgcHV0bm9kZSh2b2lkKQogCQkJCQkJCQkJCQkJCQlmaWxlbmFtZSk7CiAJCQlnb3Rv
IG5vX2RlYnVnOwogCQl9Ci0JCXN0cm5jcHkoZmlsZW5hbWUsICIvcHJvYy9kZXZpY2UtdHJlZS8i
LCBNQVhQQVRIKTsKLQkJc3RybmNhdChmaWxlbmFtZSwgYnVmZiwgTUFYUEFUSCk7Ci0JCXN0cm5j
YXQoZmlsZW5hbWUsICIvY29tcGF0aWJsZSIsIE1BWFBBVEgpOworCQlzbnByaW50ZihmaWxlbmFt
ZSwgTUFYUEFUSCwgIi9wcm9jL2RldmljZS10cmVlLyVzL2NvbXBhdGlibGUiLCBidWZmKTsKIAkJ
ZmQgPSBvcGVuKGZpbGVuYW1lLCBPX1JET05MWSk7CiAJCWlmIChmZCA9PSAtMSkgewogCQkJcHJp
bnRmKCJVbmFibGUgdG8gZmluZCAlcyBwcmludGluZyBmcm9tIHB1cmdhdG9yeSBpcyBkaWFibGVk
XG4iLAotLSAKMS44LjQuMQoK
--001a11c309ea71effc04f1936e75
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--001a11c309ea71effc04f1936e75--


Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR2mi-0002n2-Tr
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:08:21 +0000
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:07:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7416B3578054
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:07:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J7eWD48300120
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:48 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J7CQu008878
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:13 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 04/22] firmware: simplify dev_*() print messages for
 generic helpers
Date: Wed,  3 Feb 2016 14:06:12 -0500
Message-Id: <1454526390-19792-5-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ming Lei <ming.lei@canonical.com>, Kyle McMartin <kyle@kernel.org>, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, =?UTF-8?q?Vojt=C4=9Bch=20Pavl=C3=ADk?= <vojtech@suse.cz>, Casey Schaufler <casey@schaufler-ca.com>, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>

RnJvbTogIkx1aXMgUi4gUm9kcmlndWV6IiA8bWNncm9mQGtlcm5lbC5vcmc+CgpTaW1wbGlmeSBh
IGZldyBvZiB0aGUgKmdlbmVyaWMqIHNoYXJlZCBkZXZfd2FybigpIGFuZCBkZXZfZGJnKCkKcHJp
bnQgbWVzc2FnZXMgZm9yIHRocmVlIHJlYXNvbnM6CgowKSBIaXN0b3JpY2FsbHkgZmlybXdhcmVf
Y2xhc3MgY29kZSB3YXMgYWRkZWQgdG8gaGVscAogICBnZXQgZGV2aWNlIGRyaXZlciBmaXJtd2Fy
ZSBiaW5hcmllcyBidXQgdGhlc2UgZGF5cwogICByZXF1ZXN0X2Zpcm13YXJlKigpIGhlbHBlcnMg
YXJlIGJlaW5nIHJlcHVycG9zZWQgZm9yCiAgIGdlbmVyYWwgKnN5c3RlbSBkYXRhKiBuZWVkZWQg
YnkgdGhlIGtlcm5lbC4KCjEpIFRoaXMgd2lsbCBhbHNvIGhlbHAgZ2VuZXJhbGl6ZSBzaGFyZWQg
Y29kZSBhcyBtdWNoIGFzIHBvc3NpYmxlCiAgIGxhdGVyIGluIHRoZSBmdXR1cmUgaW4gY29uc2lk
ZXJhdGlvbiBmb3IgYSBuZXcgZXh0ZW5zaWJsZSBmaXJtd2FyZQogICBBUEkgd2hpY2ggd2lsbCBl
bmFibGUgdG8gc2VwYXJhdGUgdXNlcm1vZGUgaGVscGVyIGNvZGUgb3V0IGFzIG11Y2gKICAgYXMg
cG9zc2libGUuCgoyKSBLZWVzIENvb2sgcG9pbnRlZCBvdXQgdGhlIHRoZSBwcmludHMgYWxyZWFk
eSBoYXZlIHRoZSBkZXZpY2UKICAgYXNzb2NpYXRlZCBhcyBkZXZfKigpIGhlbHBlcnMgYXJlIHVz
ZWQsIHRoYXQgc2hvdWxkIGhlbHAgaWRlbnRpZnkKICAgdGhlIHVzZXIgYW5kIGNhc2UgaW4gd2hp
Y2ggdGhlIGhlbHBlcnMgYXJlIHVzZWQuIFRoYXQgc2hvdWxkIHByb3ZpZGUKICAgZW5vdWdoIGNv
bnRleHQgYW5kIHNpbXBsaWZpZXMgdGhlIG1lc3NhZ2VzIGZ1cnRoZXIuCgp2NDogZ2VuZXJhbGl6
ZSBkZWJ1Zy93YXJuIG1lc3NhZ2VzIGV2ZW4gZnVydGhlciBhcyBzdWdnZXN0ZWQgYnkKICAgIEtl
ZXMgQ29vay4KCkNjOiBSdXN0eSBSdXNzZWxsIDxydXN0eUBydXN0Y29ycC5jb20uYXU+CkNjOiBB
bmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPgpDYzogR3JlZyBLcm9haC1I
YXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KQ2M6IERhdmlkIEhvd2VsbHMgPGRo
b3dlbGxzQHJlZGhhdC5jb20+CkNjOiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVtLm9yZz4K
Q2M6IENhc2V5IFNjaGF1ZmxlciA8Y2FzZXlAc2NoYXVmbGVyLWNhLmNvbT4KQ2M6IE1pbmcgTGVp
IDxtaW5nLmxlaUBjYW5vbmljYWwuY29tPgpDYzogVGFrYXNoaSBJd2FpIDx0aXdhaUBzdXNlLmRl
PgpDYzogVm9qdMSbY2ggUGF2bMOtayA8dm9qdGVjaEBzdXNlLmN6PgpDYzogS3lsZSBNY01hcnRp
biA8a3lsZUBrZXJuZWwub3JnPgpDYzogTWF0dGhldyBHYXJyZXR0IDxtamc1OUBzcmNmLnVjYW0u
b3JnPgpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5OiBMdWlz
IFIuIFJvZHJpZ3VleiA8bWNncm9mQGtlcm5lbC5vcmc+ClNpZ25lZC1vZmYtYnk6IE1pbWkgWm9o
YXIgPHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbT4KLS0tCiBkcml2ZXJzL2Jhc2UvZmlybXdhcmVf
Y2xhc3MuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2Zpcm13YXJlX2NsYXNzLmMg
Yi9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfY2xhc3MuYwppbmRleCA4NTI0NDUwLi4zMzU4ZjVkIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfY2xhc3MuYworKysgYi9kcml2ZXJzL2Jh
c2UvZmlybXdhcmVfY2xhc3MuYwpAQCAtMzUzLDE1ICszNTMsMTUgQEAgc3RhdGljIGludCBmd19n
ZXRfZmlsZXN5c3RlbV9maXJtd2FyZShzdHJ1Y3QgZGV2aWNlICpkZXZpY2UsCiAJCXJjID0gZndf
cmVhZF9maWxlX2NvbnRlbnRzKGZpbGUsIGJ1Zik7CiAJCWZwdXQoZmlsZSk7CiAJCWlmIChyYykK
LQkJCWRldl93YXJuKGRldmljZSwgImZpcm13YXJlLCBhdHRlbXB0ZWQgdG8gbG9hZCAlcywgYnV0
IGZhaWxlZCB3aXRoIGVycm9yICVkXG4iLAotCQkJCXBhdGgsIHJjKTsKKwkJCWRldl93YXJuKGRl
dmljZSwgImxvYWRpbmcgJXMgZmFpbGVkIHdpdGggZXJyb3IgJWRcbiIsCisJCQkJIHBhdGgsIHJj
KTsKIAkJZWxzZQogCQkJYnJlYWs7CiAJfQogCV9fcHV0bmFtZShwYXRoKTsKIAogCWlmICghcmMp
IHsKLQkJZGV2X2RiZyhkZXZpY2UsICJmaXJtd2FyZTogZGlyZWN0LWxvYWRpbmcgZmlybXdhcmUg
JXNcbiIsCisJCWRldl9kYmcoZGV2aWNlLCAiZGlyZWN0LWxvYWRpbmcgJXNcbiIsCiAJCQlidWYt
PmZ3X2lkKTsKIAkJbXV0ZXhfbG9jaygmZndfbG9jayk7CiAJCXNldF9iaXQoRldfU1RBVFVTX0RP
TkUsICZidWYtPnN0YXR1cyk7CkBAIC0xMDUxLDcgKzEwNTEsNyBAQCBfcmVxdWVzdF9maXJtd2Fy
ZV9wcmVwYXJlKHN0cnVjdCBmaXJtd2FyZSAqKmZpcm13YXJlX3AsIGNvbnN0IGNoYXIgKm5hbWUs
CiAJfQogCiAJaWYgKGZ3X2dldF9idWlsdGluX2Zpcm13YXJlKGZpcm13YXJlLCBuYW1lKSkgewot
CQlkZXZfZGJnKGRldmljZSwgImZpcm13YXJlOiB1c2luZyBidWlsdC1pbiBmaXJtd2FyZSAlc1xu
IiwgbmFtZSk7CisJCWRldl9kYmcoZGV2aWNlLCAidXNpbmcgYnVpbHQtaW4gJXNcbiIsIG5hbWUp
OwogCQlyZXR1cm4gMDsgLyogYXNzaWduZWQgKi8KIAl9CiAKLS0gCjIuMS4wCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=

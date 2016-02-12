Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([125.16.236.9])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIav-00029T-QA
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:37:31 +0000
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:07:09 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIajvD23265642
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:06:58 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CITur8030066
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:21 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 01/19] firmware: simplify dev_*() print messages for
 generic helpers
Date: Fri, 12 Feb 2016 13:29:13 -0500
Message-Id: <1455301771-7703-2-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Kyle McMartin <kyle@kernel.org>, Kees Cook <keescook@chromium.org>, Takashi Iwai <tiwai@suse.de>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, =?UTF-8?q?Vojt=C4=9Bch=20Pavl=C3=ADk?= <vojtech@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Ming Lei <ming.lei@canonical.com>, linux-modules@vger.kernel.org

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
YXIgPHpvaGFyQGxpbnV4LnZuZXQuaWJtLmNvbT4KQWNrZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPgpTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdr
aEBsaW51eGZvdW5kYXRpb24ub3JnPgotLS0KIGRyaXZlcnMvYmFzZS9maXJtd2FyZV9jbGFzcy5j
IHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZmlybXdhcmVfY2xhc3MuYyBiL2RyaXZl
cnMvYmFzZS9maXJtd2FyZV9jbGFzcy5jCmluZGV4IGI5MjUwZTUuLmNlODgzNTUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvYmFzZS9maXJtd2FyZV9jbGFzcy5jCisrKyBiL2RyaXZlcnMvYmFzZS9maXJt
d2FyZV9jbGFzcy5jCkBAIC0zNTMsMTUgKzM1MywxNSBAQCBzdGF0aWMgaW50IGZ3X2dldF9maWxl
c3lzdGVtX2Zpcm13YXJlKHN0cnVjdCBkZXZpY2UgKmRldmljZSwKIAkJcmMgPSBmd19yZWFkX2Zp
bGVfY29udGVudHMoZmlsZSwgYnVmKTsKIAkJZnB1dChmaWxlKTsKIAkJaWYgKHJjKQotCQkJZGV2
X3dhcm4oZGV2aWNlLCAiZmlybXdhcmUsIGF0dGVtcHRlZCB0byBsb2FkICVzLCBidXQgZmFpbGVk
IHdpdGggZXJyb3IgJWRcbiIsCi0JCQkJcGF0aCwgcmMpOworCQkJZGV2X3dhcm4oZGV2aWNlLCAi
bG9hZGluZyAlcyBmYWlsZWQgd2l0aCBlcnJvciAlZFxuIiwKKwkJCQkgcGF0aCwgcmMpOwogCQll
bHNlCiAJCQlicmVhazsKIAl9CiAJX19wdXRuYW1lKHBhdGgpOwogCiAJaWYgKCFyYykgewotCQlk
ZXZfZGJnKGRldmljZSwgImZpcm13YXJlOiBkaXJlY3QtbG9hZGluZyBmaXJtd2FyZSAlc1xuIiwK
KwkJZGV2X2RiZyhkZXZpY2UsICJkaXJlY3QtbG9hZGluZyAlc1xuIiwKIAkJCWJ1Zi0+ZndfaWQp
OwogCQltdXRleF9sb2NrKCZmd19sb2NrKTsKIAkJc2V0X2JpdChGV19TVEFUVVNfRE9ORSwgJmJ1
Zi0+c3RhdHVzKTsKQEAgLTEwNTEsNyArMTA1MSw3IEBAIF9yZXF1ZXN0X2Zpcm13YXJlX3ByZXBh
cmUoc3RydWN0IGZpcm13YXJlICoqZmlybXdhcmVfcCwgY29uc3QgY2hhciAqbmFtZSwKIAl9CiAK
IAlpZiAoZndfZ2V0X2J1aWx0aW5fZmlybXdhcmUoZmlybXdhcmUsIG5hbWUpKSB7Ci0JCWRldl9k
YmcoZGV2aWNlLCAiZmlybXdhcmU6IHVzaW5nIGJ1aWx0LWluIGZpcm13YXJlICVzXG4iLCBuYW1l
KTsKKwkJZGV2X2RiZyhkZXZpY2UsICJ1c2luZyBidWlsdC1pbiAlc1xuIiwgbmFtZSk7CiAJCXJl
dHVybiAwOyAvKiBhc3NpZ25lZCAqLwogCX0KIAotLSAKMi4xLjAKCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2tleGVjCg==

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hPFgj-0008L7-9K
 for kexec@lists.infradead.org; Sat, 11 May 2019 00:16:31 +0000
Received: by mail-pf1-x444.google.com with SMTP id 13so4024996pfw.9
 for <kexec@lists.infradead.org>; Fri, 10 May 2019 17:16:28 -0700 (PDT)
MIME-Version: 1.0
From: prakhar srivastava <prsriva02@gmail.com>
Date: Fri, 10 May 2019 17:16:16 -0700
Message-ID: <CAEFn8q+rT2_0TFb0fKA6ixOvC3H5R5KpR0zFiTOXa_4U-9HeUw@mail.gmail.com>
Subject: Carrying over the ima log during kexec_file_load
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
To: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, kexec@lists.infradead.org
Cc: bhe@redhat.com, dyoung@redhat.com, jmorris@namei.org, Mimi Zohar <zohar@linux.ibm.com>, vgoyal@redhat.com

SGksCgpJIGFtIGN1cnJlbnRseSBsb29raW5nIGF0IGNhcnJ5aW5nIG92ZXIgdGhlIGltYSBsb2cg
ZnJvbSB0aGUgY3VycmVudAprZXJuZWwgdG8gdGhlIG5leHQga2VybmVsIGR1cmluZyBzb2Z0IHJl
Ym9vdChrZXhlY19maWxlX2xvYWQpIGZvciBhcm02NAphbmQgeDg2XzY0LgpEdXJpbmcgc29mdCBy
ZWJvb3Qoa2V4ZWNfZmlsZV9sb2FkKSBUUE0gYm9vdCBQQ1LigJlzKFBDUnMgMCB0aHJvdWdoIDcp
CmFyZSBub3QgcmVzZXQgb3IgZXh0ZW5kZWQgYW5kIHRodXMgdGhlIGJvb3QgYWdncmVnYXRlIGRv
ZXMgbm90IGNoYW5nZSwKbGVhdmluZyB0aGUgbmV3IGtlcm5lbCB3aXRoIGEgc2Vuc2Ugb2Ygc2Vj
dXJlIGJvb3QuCkR1cmluZyBrZXhlY19maWxlX2xvYWQgdGhlIGtlcm5lbCBmaWxlIHNpZ25hdHVy
ZSBpcyB2YWxpZGF0ZWQgdGhyb3VnaCBQRQpmaWxlIHNpZ25hdHVyZSB2YWxpZGF0aW9uLgpUaGUg
Ym9vdCBjbWRsaW5lIGFyZ3Mgd2lsbCBhbHNvIGJlIG1lYXN1cmVkIHdpdGgK4oCca2V4ZWMgY21k
bGluZSBidWZmZXIgbWVhc3VyZeKAnSBjaGFuZ2Ugd2hpY2ggaXMgaW4gcHJvZ3Jlc3MuCmh0dHBz
Oi8vbGttbC5vcmcvbGttbC8yMDE5LzUvMTAvNzI4CgpMb29raW5nIGF0IHRoZSBwb3dlcnBjIGlt
cGxlbWVudGF0aW9uIG9mIGtleGVjX2ZpbGVfbG9hZCwgIG1ha2luZwpjaGFuZ2UgdG8gdGhlIGtp
bWFnZV9hcmNoIGFzIGJlbG93IHNlZW1zIG1vc3QgcmVhc29uYWJsZS4KClN0cnVjdCBraW1hZ2Vf
YXJjaCB7CiAgICAgICAgICAgICAgICDigKYKICAgICAgICAgICAgICAgIGltYV9sb2dfYnVmZmVy
CiAgICAgICAgICAgICAgICBpbWFfbG9nX2J1ZmZlcl9zaXplCn07CgpBZGQgcmVzcGVjdGl2ZSBl
bnRyaWVzIGluIGR0Yi9mZHQgYW5kIHJlYWQgdGhlIHNhbWUgaW4gdGhlIG5leHQga2VybmVsLgpO
byBjaGFuZ2VzIHRvIHRoZSBwdXJnYXRvcnkgc2hvdWxkIGJlIG5lZWRlZCBzaW5jZSBubyBrZXJu
ZWwgc2VnbWVudHMKYXJlIGNoYW5nZWQuCgpJcyBhbnlvbmUgYWxyZWFkeSBsb29raW5nIGF0IHRo
aXM/CklmIG5vdCwgSSB3YW50IHRvIHVuZGVyc3RhbmQgd2hhdOKAmXMgdGhlIGJlc3QgYXBwcm9h
Y2ggZm9yIHRoaXMgaXM/CgpUaGFua3MsClByYWtoYXIgU3JpdmFzdGF2YQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=

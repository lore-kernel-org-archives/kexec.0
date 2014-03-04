Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qg0-x22b.google.com ([2607:f8b0:400d:c04::22b])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKdJx-0001gc-36
 for kexec@lists.infradead.org; Tue, 04 Mar 2014 00:34:57 +0000
Received: by mail-qg0-f43.google.com with SMTP id f51so13488602qge.2
 for <kexec@lists.infradead.org>; Mon, 03 Mar 2014 16:34:35 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 3 Mar 2014 16:34:35 -0800
Message-ID: <CAMBSHm_fvPTjdEwgVdyMGPi=3et+JEP-G5TNV986yXWYw35YYw@mail.gmail.com>
Subject: PATCH: bug in locate_hole()
From: Matthew Fleming <mdf356@gmail.com>
Content-Type: multipart/mixed; boundary=001a11c118348c699e04f3bd11a6
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
To: kexec@lists.infradead.org

--001a11c118348c699e04f3bd11a6
Content-Type: text/plain; charset=ISO-8859-1

In upgrading to kexec-tools 2.0.5 I first got the error "Overlapping
memory segments at 0xbeff000"

Adding some debugging I found locate_hole was returning incorrect
values.  The below is from the debug I added:

XXXMDF: look for hole size 100000, cur range [52b3000, bffffff] size 6d4cfff
XXXMDF: look for hole memsz=100000, found beff000

Hmm, if we wanted 0x100000 bytes ending at 0xbffffff, that should be
0xbf00000, not 0xbef000.  Continuing to the second invocation:

XXXMDF: look for hole size 1000, cur range [52b3000, befefff] size 6c4bfff
XXXMDF: look for hole size 1000, cur range [bfff000, bffffff] size fff
XXXMDF: look for hole memsz=1000, found bffe000

Now we die with overlapping ranges, since the 0x100000 bytes at
0xbeff000 overlaps 0x1000 bytes at 0xbffe000.

The attached patch fixes the off-by-one that causes the later overlap.

Thanks,
matthew

--001a11c118348c699e04f3bd11a6
Content-Type: text/plain; charset=US-ASCII; name="kexec-locate-hole.diff"
Content-Disposition: attachment; filename="kexec-locate-hole.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hscg27jj0

LS0tIGtleGVjLmMub3JpZwkyMDE0LTAzLTAzIDE2OjA4OjUzLjI4OTg0NDEwNiAtMDgwMAorKysg
a2V4ZWMuYwkyMDE0LTAzLTAzIDE2OjA5OjA0Ljk2MDg0NDEwNyAtMDgwMApAQCAtMjcyLDE3ICsy
NzIsMTcgQEAgdW5zaWduZWQgbG9uZyBsb2NhdGVfaG9sZShzdHJ1Y3Qga2V4ZWNfaQogCQl9CiAJ
CS8qIElzIHRoZXJlIGVub3VnaCBzcGFjZSBsZWZ0IHNvIHdlIGNhbiB1c2UgaXQ/ICovCiAJCXNp
emUgPSBlbmQgLSBzdGFydDsKIAkJaWYgKCFob2xlX3NpemUgfHwgc2l6ZSA+PSBob2xlX3NpemUg
LSAxKSB7CiAJCQlpZiAoaG9sZV9lbmQgPiAwKSB7CiAJCQkJaG9sZV9iYXNlID0gc3RhcnQ7CiAJ
CQkJYnJlYWs7CiAJCQl9IGVsc2UgewotCQkJCWhvbGVfYmFzZSA9IF9BTElHTl9ET1dOKGVuZCAt
IGhvbGVfc2l6ZSwKKwkJCQlob2xlX2Jhc2UgPSBfQUxJR05fRE9XTihlbmQgLSBob2xlX3NpemUg
KyAxLAogCQkJCQlob2xlX2FsaWduKTsKIAkJCX0KIAkJfQogCX0KIAlmcmVlKG1lbV9yYW5nZSk7
CiAJaWYgKGhvbGVfYmFzZSA9PSBVTE9OR19NQVgpIHsKIAkJZnByaW50ZihzdGRlcnIsICJDb3Vs
ZCBub3QgZmluZCBhIGZyZWUgYXJlYSBvZiBtZW1vcnkgb2YgIgogCQkJIjB4JWx4IGJ5dGVzLi4u
XG4iLCBob2xlX3NpemUpOwo=
--001a11c118348c699e04f3bd11a6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--001a11c118348c699e04f3bd11a6--


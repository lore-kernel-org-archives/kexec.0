Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0708.google.com ([209.85.198.247])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MJ8Rm-0003VR-Rw
	for kexec@lists.infradead.org; Tue, 23 Jun 2009 16:02:17 +0000
Received: by rv-out-0708.google.com with SMTP id k29so47373rvb.42
	for <kexec@lists.infradead.org>; Tue, 23 Jun 2009 09:02:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 24 Jun 2009 00:02:09 +0800
Message-ID: <e997b7420906230902k3084ca5fh1ff8be5c1941117a@mail.gmail.com>
Subject: kexec--virtual address or physical address?
From: "wilbur.chan" <wilbur512@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

IEhlbGxvIGV2ZXJ5b25lo6EKCkkgZ290IHNvbWUgdHJvdWJsZSBpbiBwb3J0aW5nIGtleGVjdG9v
bHMgdG8gcG93ZXJwYyA4NTQxICx3aXRoIGtlcm5lbCAyLjYuMjEuNwoKCkRldGFpbCAgOiBJbiBN
YWNoaW5lX2tleGVjXzMyLmMgLAogZnVuY3Rpb24gImRlZmF1bHRfbWFjaGluZV9rZXhlYyIsCgp0
aGUgc2Vjb25kIHBhcmFtZXRlciBvZiBmdW5jdGlvbiByZWJvb3RfY29kZSwgIHdoaWNoIGlzCnJl
Ym9vdF9jb2RlX2J1ZmZlcl9waHlzICwKCgpjYXVzaW5nIGFuIGluc3RydWN0aW9uIGVycm9yIGlu
IGFyY2gvcG93ZXJwYy9taXNjXzMyLnMgd2hlbiBleGVjdXRpbmcKaW5zdHJ1Y3Rpb24gInJmaSIK
CihMaW5lIDg5NCkKCkFmdGVyIEkgY2hhbmdlZCByZWJvb3RfY29kZV9idWZmZXJfcGh5cyBpbnRv
IHJlYm9vdF9jb2RlX2J1ZmZlcihyYXRoZXIKdGhhbiBhIHBoeXNpYWwgYWRkcmVzcykgLCB0aGUg
Y29kZSBnbyBvbiAsYnV0IGNhdXNlZAoKYW5vdGhlciAgZXJyb3Igb2YgICIga2VybmVsIHN0YWNr
IG92ZXJmbG93Ii4KCkkgZG9uJ3QgaG93IHRvIHNvbHZlIHRoaXMgcHJvYmxlbSxhbnkgc3VnZ2Vz
dGlvbiB3b3VsZCBiZSBncmF0ZWZ1bC4KCgpoZXJlIGFyZSBteSBzdGVwczoKCiMga2V4ZWMgLWwg
dUltYWdlIC0tZGV2dHJlZT15b3VyLmZkdC5kdGIgLS1kZXZ0cmVlX2FkZHI9MHg4MDAwMDAKICAg
SW1hZ2UgTmFtZTogICBMaW51eC0yLjYuMjEuNwogICBJbWFnZSBUeXBlOiAgIFBvd2VyUEMgTGlu
dXggS2VybmVsIEltYWdlIChnemlwIGNvbXByZXNzZWQpCiAgIERhdGEgU2l6ZTogICAgMTE5MDI2
NSBCeXRlcyA9ICAgIExvYWQgQWRkcmVzczogMDAwMDAwMDAKICAgRW50cnkgUG9pbnQ6ICAwMDAw
MDAwMAoKIyBrZXhlYyAtZQpTdGFydGluZyBuZXcga2VybmVsCnZpcnR1YWwgYWRkcmVzczogY2Zj
MDkwMDAKcGh5c2ljYWwgYWRkcmVzczogZmMwOTAwMAoKY2FsbGluZyBmdW5jdGlvbjogcmVib290
X2NvZGUocGFnZV9saXN0PTB4ZmMwODAwMiwKcmVib290X2NvZGVfYnVmZmVyX3BoeXM9MHhmYzA5
MDAwLCBpbWFnZS0+c3RhcnQ9MHgwLGltYWdlLT5zZWdtZW50CgpbMV0ubWVtPTB4ODAwMDAwKQoK
VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgZm9yIGluc3RydWN0aW9uIGZl
dGNoCkZhdWx0aW5nIGluc3RydWN0aW9uIGFkZHJlc3M6IDB4MGZjMDkwMjgKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdApr
ZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8va2V4ZWMK

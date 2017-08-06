Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kapsi.fi ([2001:67c:1be8::25])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1deOig-0000ep-KW
 for kexec@lists.infradead.org; Sun, 06 Aug 2017 16:48:05 +0000
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v06 21/36] uapi linux/kexec.h: use __kernel_size_t instead of
 size_t
Date: Sun,  6 Aug 2017 18:44:12 +0200
Message-Id: <20170806164428.2273-22-mikko.rapeli@iki.fi>
In-Reply-To: <20170806164428.2273-1-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
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
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Rml4ZXMgdXNlcnNwYWNlIGNvbXBpbGF0aW9uIGVycm9yOgoKZXJyb3I6IHVua25vd24gdHlwZSBu
YW1lIOKAmHNpemVfdOKAmQogIHNpemVfdCBidWZzejsKClNpZ25lZC1vZmYtYnk6IE1pa2tvIFJh
cGVsaSA8bWlra28ucmFwZWxpQGlraS5maT4KQ2M6IGtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
Q2M6IEVyaWMgQmllZGVybWFuIDxlYmllZGVybUB4bWlzc2lvbi5jb20+Ci0tLQogaW5jbHVkZS91
YXBpL2xpbnV4L2tleGVjLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L2tleGVj
LmggYi9pbmNsdWRlL3VhcGkvbGludXgva2V4ZWMuaAppbmRleCBhYWU1ZWJmMjAyMmIuLmY5NjRk
ODNiMjc1NyAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2tleGVjLmgKKysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L2tleGVjLmgKQEAgLTUxLDkgKzUxLDkgQEAKICAqLwogc3RydWN0IGtl
eGVjX3NlZ21lbnQgewogCWNvbnN0IHZvaWQgKmJ1ZjsKLQlzaXplX3QgYnVmc3o7CisJX19rZXJu
ZWxfc2l6ZV90IGJ1ZnN6OwogCWNvbnN0IHZvaWQgKm1lbTsKLQlzaXplX3QgbWVtc3o7CisJX19r
ZXJuZWxfc2l6ZV90IG1lbXN6OwogfTsKIAogI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8KLS0gCjIu
MTMuMwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK

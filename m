Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.kapsi.fi ([2001:1bc8:1004::1:25] helo=mail.kapsi.fi)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbu6k-0003rQ-38
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 18:38:03 +0000
From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 44/72] include/uapi/linux/kexec.h: use __kernel_size_t
 instead of size_t
Date: Mon, 22 Aug 2016 20:33:01 +0200
Message-Id: <1471890809-4383-45-git-send-email-mikko.rapeli@iki.fi>
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
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
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Rml4ZXMgdXNlcnNwYWNlIGNvbXBpbGF0aW9uIGVycm9yOgoKZXJyb3I6IHVua25vd24gdHlwZSBu
YW1lIOKAmHNpemVfdOKAmQogIHNpemVfdCBidWZzejsKClNpZ25lZC1vZmYtYnk6IE1pa2tvIFJh
cGVsaSA8bWlra28ucmFwZWxpQGlraS5maT4KLS0tCiBpbmNsdWRlL3VhcGkvbGludXgva2V4ZWMu
aCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgva2V4ZWMuaCBiL2luY2x1ZGUvdWFw
aS9saW51eC9rZXhlYy5oCmluZGV4IGFhZTVlYmYuLmY5NjRkODMgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvdWFwaS9saW51eC9rZXhlYy5oCisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9rZXhlYy5oCkBA
IC01MSw5ICs1MSw5IEBACiAgKi8KIHN0cnVjdCBrZXhlY19zZWdtZW50IHsKIAljb25zdCB2b2lk
ICpidWY7Ci0Jc2l6ZV90IGJ1ZnN6OworCV9fa2VybmVsX3NpemVfdCBidWZzejsKIAljb25zdCB2
b2lkICptZW07Ci0Jc2l6ZV90IG1lbXN6OworCV9fa2VybmVsX3NpemVfdCBtZW1zejsKIH07CiAK
ICNlbmRpZiAvKiBfX0tFUk5FTF9fICovCi0tIAoyLjguMQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK

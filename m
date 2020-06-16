Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlG7G-0004VJ-60
 for kexec@lists.infradead.org; Tue, 16 Jun 2020 18:15:23 +0000
Date: Tue, 16 Jun 2020 13:20:41 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] kexec_file: Use array_size() helper in memcpy()
Message-ID: <20200616182041.GA30841@embeddedor>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Use array_size() instead of the open-coded version in memcpy(). These
sorts of multiplication factors need to be wrapped in array_size().

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the pointer variable type is
changed but the corresponding sizeof that is passed as argument is not.

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/kexec_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index bb05fd52de85..2bbb001cd505 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -910,11 +910,11 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs = vzalloc(array_size(sizeof(*sechdrs), pi->ehdr->e_shnum));
 	if (!sechdrs)
 		return -ENOMEM;
 	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	       array_size(sizeof(*sechdrs), pi->ehdr->e_shnum));
 	pi->sechdrs = sechdrs;
 
 	offset = 0;
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

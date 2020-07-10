Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ju0Nl-0005hx-I9
 for kexec@lists.infradead.org; Fri, 10 Jul 2020 21:16:34 +0000
Date: Fri, 10 Jul 2020 16:22:06 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] kexec_file: Assign array_size() to a variable
Message-ID: <20200710212206.GA29369@embeddedor>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Assign array_size() to variable _size_ and use it in both vzalloc()
and memcpy(). These sorts of multiplication factors need to be wrapped
in array_size().

This issue was found with the help of Coccinelle and, audited and fixed
manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/kexec_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 09cc78df53c6..4479d864aaf2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -883,16 +883,16 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	Elf_Shdr *sechdrs;
 	int i;
+	size_t size = array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum);
 
 	/*
 	 * The section headers in kexec_purgatory are read-only. In order to
 	 * have them modifiable make a temporary copy.
 	 */
-	sechdrs = vzalloc(array_size(sizeof(Elf_Shdr), pi->ehdr->e_shnum));
+	sechdrs = vzalloc(size);
 	if (!sechdrs)
 		return -ENOMEM;
-	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff,
-	       pi->ehdr->e_shnum * sizeof(Elf_Shdr));
+	memcpy(sechdrs, (void *)pi->ehdr + pi->ehdr->e_shoff, size);
 	pi->sechdrs = sechdrs;
 
 	offset = 0;
-- 
2.27.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

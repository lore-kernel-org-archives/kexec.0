Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xuF-0001Wd-GV
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:01:42 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 03/32] kdump: actually write out the memory
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xrd-0003rh-Ti@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:58:57 +0100
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
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>, Baoquan He <bhe@redhat.com>

Actually write out the memory rather than writing the notes a second
time.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 99a1789..1f5b984 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -300,7 +300,7 @@ int main(int argc, char **argv)
 	for(i = 0; i < ehdr->e_phnum; i++) {
 		unsigned long long offset, size;
 		size_t wsize;
-		if (phdr[i].p_type != PT_NOTE) {
+		if (phdr[i].p_type == PT_NOTE) {
 			continue;
 		}
 		offset = phdr[i].p_offset;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

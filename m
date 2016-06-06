Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xu0-0001Vv-59
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:01:33 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 02/32] kdump: fix multiple program header
 entries
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xrY-0003rb-Na@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:58:52 +0100
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

generate_new_headers() forgot to increment the program header pointer
after adding each program header from the kexec template. Fix it to
increment it correctly.

Without this, the program headers contain only the last entry, which
means we will be missing most of the kernel image in the dump.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 3247a54..99a1789 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -192,6 +192,7 @@ static void *generate_new_headers(
 		}
 		memcpy(nphdr, &phdr[i], sizeof(*nphdr));
 		nphdr->p_offset = offset;
+		nphdr++;
 		offset += phdr[i].p_filesz;
 	}
 	
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b9xt0-0001ax-VU
 for kexec@lists.infradead.org; Mon, 06 Jun 2016 17:00:24 +0000
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools v2 08/32] kexec: add max_size to memory_ranges
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b9xs4-0003sB-0u@e0050434b2927.dyn.armlinux.org.uk>
Date: Mon, 06 Jun 2016 17:59:24 +0100
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

Many implementations statically allocate the memory range array, which
therefore will have a maximum allowable size.  Add this information to
the memory_ranges structure, so we don't have to carry it around.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/kexec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kexec/kexec.h b/kexec/kexec.h
index c02ac8f..9194f1c 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -142,6 +142,7 @@ struct memory_range {
 
 struct memory_ranges {
         unsigned int size;
+	unsigned int max_size;
         struct memory_range *ranges;
 };
 
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

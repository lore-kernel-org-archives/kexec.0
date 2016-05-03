Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1axXTC-0007Mz-9R
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:22:26 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 08/32] kexec: add max_size to memory_ranges
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXSa-0004hf-Iz@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:21:44 +0100
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
Cc: Pratyush Anand <panand@redhat.com>

Many implementations statically allocate the memory range array, which
therefore will have a maximum allowable size.  Add this information to
the memory_ranges structure, so we don't have to carry it around.

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

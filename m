Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from intranet.asianux.com ([58.214.24.6])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VTpAW-0003Od-54
 for kexec@lists.infradead.org; Wed, 09 Oct 2013 08:30:57 +0000
Message-ID: <525513E8.6040900@asianux.com>
Date: Wed, 09 Oct 2013 16:29:28 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
Subject: [PATCH] kernel/kexec.c: use vscnprintf() instead of vsnprintf() in
 vmcoreinfo_append_str()
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Richard Weinberger <richard@nod.at>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>

vsnprintf() may let 'r' larger than sizeof(buf), in this case, if 'r'
is also less than "vmcoreinfo_max_size - vmcoreinfo_size" (left size of
destination buffer), next memcpy() will read the unexpected addresses.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 kernel/kexec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 2a74f30..0abcd68 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1533,7 +1533,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
 	size_t r;
 
 	va_start(args, fmt);
-	r = vsnprintf(buf, sizeof(buf), fmt, args);
+	r = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	r = min(r, vmcoreinfo_max_size - vmcoreinfo_size);
-- 
1.7.7.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

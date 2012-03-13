Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from acsinet15.oracle.com ([141.146.126.227])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S7I8B-0001p3-57
 for kexec@lists.infradead.org; Tue, 13 Mar 2012 03:10:35 +0000
Message-ID: <4F5EBAA7.50709@oracle.com>
Date: Tue, 13 Mar 2012 11:10:31 +0800
From: DuanZhenzhong <zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Subject: [PATCH] kexec: add further check to crashkernel
References: <1329989047-20378-1-git-send-email-zhenzhong.duan@oracle.com>
In-Reply-To: <1329989047-20378-1-git-send-email-zhenzhong.duan@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@oracle.com>

When add crashkernel=2M-256M, kernel don't give any warning.
This is misleading sometimes.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 kernel/kexec.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 7b08867..0a6d147 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1359,6 +1359,10 @@ static int __init parse_crashkernel_simple(char 		*cmdline,
 
 	if (*cur == '@')
 		*crash_base = memparse(cur+1, &cur);
+	else if (*cur != ' ' && *cur != '\0') {
+		pr_warning("crashkernel: unrecognized char\n");
+		return -EINVAL;
+	}
 
 	return 0;
 }
-- 1.7.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

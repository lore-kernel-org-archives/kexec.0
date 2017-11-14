Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eEWAQ-00079e-AM
 for kexec@lists.infradead.org; Tue, 14 Nov 2017 08:02:05 +0000
Date: Tue, 14 Nov 2017 16:01:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH V2] kdump: print a message in case parse_crashkernel_mem
 resulted in zero bytes
Message-ID: <20171114080129.GA6115@dhcp-128-65.nay.redhat.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, bhsharma@redhat.com, vgoyal@redhat.com, bhe@redhat.com

In parse_crashkernel_mem, it silently return in case we get zero
bytes in the parsing function.  It is useful for debugging for
adding a message especially sometimes kernel can not boot
up correctly.

Add a pr_info instead of pr_warn because it is expected behavior for
size = 0, eg. crashkernel=2G-4G:128M, size will be 0 in case system
memory is less than 2G.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
[v1 -> v2]: bhsharma: pr_warn looks confusing because of return 0
 kernel/crash_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-x86.orig/kernel/crash_core.c
+++ linux-x86/kernel/crash_core.c
@@ -108,7 +108,8 @@ static int __init parse_crashkernel_mem(
 				return -EINVAL;
 			}
 		}
-	}
+	} else
+		pr_info("crashkernel size resulted in zero bytes\n");
 
 	return 0;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

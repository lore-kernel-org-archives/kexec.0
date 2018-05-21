Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fKl1Z-0003wH-B8
 for kexec@lists.infradead.org; Mon, 21 May 2018 13:38:55 +0000
From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Subject: [PATCH net-next] vmcore: move get_vmcore_size out of __init
Date: Mon, 21 May 2018 19:07:50 +0530
Message-Id: <1526909870-27630-1-git-send-email-rahul.lakkireddy@chelsio.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: netdev@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: indranil@chelsio.com, nirranjan@chelsio.com, stephen@networkplumber.org, ganeshgr@chelsio.com, Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>, ebiederm@xmission.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, davem@davemloft.net, viro@zeniv.linux.org.uk

Fix below build warning:

WARNING: vmlinux.o(.text+0x422bb8): Section mismatch in reference from
the function vmcore_add_device_dump() to the function
.init.text:get_vmcore_size.constprop.5()

The function vmcore_add_device_dump() references
the function __init get_vmcore_size.constprop.5().
This is often because vmcore_add_device_dump lacks a __init
annotation or the annotation of get_vmcore_size.constprop.5 is wrong.

Fixes: 7efe48df8a3d ("vmcore: append device dumps to vmcore as elf notes")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
---
 fs/proc/vmcore.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 247c3499e5bd..cfb6674331fd 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -649,8 +649,8 @@ static struct vmcore* __init get_new_element(void)
 	return kzalloc(sizeof(struct vmcore), GFP_KERNEL);
 }
 
-static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
-				  struct list_head *vc_list)
+static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
+			   struct list_head *vc_list)
 {
 	u64 size;
 	struct vmcore *m;
-- 
2.14.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

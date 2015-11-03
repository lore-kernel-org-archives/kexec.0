Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22b.google.com ([2607:f8b0:400e:c03::22b])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZthY8-0001ld-BP
 for kexec@lists.infradead.org; Tue, 03 Nov 2015 19:47:21 +0000
Received: by pasz6 with SMTP id z6so27440105pas.2
 for <kexec@lists.infradead.org>; Tue, 03 Nov 2015 11:46:59 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 11/13] Always define MAX_RAW_MINORS as 2**20 in userspace
Date: Tue,  3 Nov 2015 11:46:32 -0800
Message-Id: <1446579994-9937-12-git-send-email-palmer@dabbelt.com>
In-Reply-To: <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
References: <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1446579994-9937-1-git-send-email-palmer@dabbelt.com>
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
To: arnd@arndb.de, dhowells@redhat.com
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, plagnioj@jcrosoft.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, a.p.zijlstra@chello.nl, jikos@kernel.org, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

While I don't think this was ever meant to be exposed to userspace, if
anyone is using it then this will at least provide a correct (if
unlikely) definition.

MAX_RAW_MINORS used to be used in the kernel, where it's been replaced
with CONFIG_MAX_RAW_MINORS.

Note that there's a checkpatch.pl warning about a split config string
here, but I've left that alone.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 drivers/char/raw.c       | 7 ++++---
 include/uapi/linux/raw.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/raw.c b/drivers/char/raw.c
index 60316fb..362d7a6 100644
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -36,7 +36,7 @@ static struct raw_device_data *raw_devices;
 static DEFINE_MUTEX(raw_mutex);
 static const struct file_operations raw_ctl_fops; /* forward declaration */
 
-static int max_raw_minors = MAX_RAW_MINORS;
+static int max_raw_minors = CONFIG_MAX_RAW_MINORS;
 
 module_param(max_raw_minors, int, 0);
 MODULE_PARM_DESC(max_raw_minors, "Maximum number of raw devices (1-65536)");
@@ -317,8 +317,9 @@ static int __init raw_init(void)
 
 	if (max_raw_minors < 1 || max_raw_minors > 65536) {
 		printk(KERN_WARNING "raw: invalid max_raw_minors (must be"
-			" between 1 and 65536), using %d\n", MAX_RAW_MINORS);
-		max_raw_minors = MAX_RAW_MINORS;
+			" between 1 and 65536), using %d\n",
+		       CONFIG_MAX_RAW_MINORS);
+		max_raw_minors = CONFIG_MAX_RAW_MINORS;
 	}
 
 	raw_devices = vzalloc(sizeof(struct raw_device_data) * max_raw_minors);
diff --git a/include/uapi/linux/raw.h b/include/uapi/linux/raw.h
index 62d543e..f3d009b 100644
--- a/include/uapi/linux/raw.h
+++ b/include/uapi/linux/raw.h
@@ -13,6 +13,6 @@ struct raw_config_request
 	__u64	block_minor;
 };
 
-#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
+#define MAX_RAW_MINORS (1 << 20)
 
 #endif /* __LINUX_RAW_H */
-- 
2.4.10


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

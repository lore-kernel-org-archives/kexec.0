Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x236.google.com ([2607:f8b0:400e:c03::236])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZthXy-0001jQ-GZ
 for kexec@lists.infradead.org; Tue, 03 Nov 2015 19:47:11 +0000
Received: by pasz6 with SMTP id z6so27436262pas.2
 for <kexec@lists.infradead.org>; Tue, 03 Nov 2015 11:46:49 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 03/13] Move COMPAT_ATM_ADDPARTY to net/atm/svc.c
Date: Tue,  3 Nov 2015 11:46:24 -0800
Message-Id: <1446579994-9937-4-git-send-email-palmer@dabbelt.com>
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

This used to be behind an #ifdef COMPAT_COMPAT, so most of userspace
wouldn't have seen the definition before.  Unfortunately this header
file became visible to userspace, so the definition has instead been
moved to net/atm/svc.c (the only user).

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/linux/atmdev.h | 4 ----
 net/atm/svc.c               | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/atmdev.h b/include/uapi/linux/atmdev.h
index 93e0ec0..3dcec70 100644
--- a/include/uapi/linux/atmdev.h
+++ b/include/uapi/linux/atmdev.h
@@ -100,10 +100,6 @@ struct atm_dev_stats {
 					/* use backend to make new if */
 #define ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct atm_iobuf)
  					/* add party to p2mp call */
-#ifdef CONFIG_COMPAT
-/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
-#define COMPAT_ATM_ADDPARTY  	_IOW('a', ATMIOC_SPECIAL+4,struct compat_atm_iobuf)
-#endif
 #define ATM_DROPPARTY 	_IOW('a', ATMIOC_SPECIAL+5,int)
 					/* drop party from p2mp call */
 
diff --git a/net/atm/svc.c b/net/atm/svc.c
index 3fa0a9e..9e2e6ef 100644
--- a/net/atm/svc.c
+++ b/net/atm/svc.c
@@ -27,6 +27,11 @@
 #include "signaling.h"
 #include "addr.h"
 
+#ifdef CONFIG_COMPAT
+/* It actually takes struct sockaddr_atmsvc, not struct atm_iobuf */
+#define COMPAT_ATM_ADDPARTY _IOW('a', ATMIOC_SPECIAL+4, struct compat_atm_iobuf)
+#endif
+
 static int svc_create(struct net *net, struct socket *sock, int protocol,
 		      int kern);
 
-- 
2.4.10


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YtDNY-0004iz-7x
 for kexec@lists.infradead.org; Fri, 15 May 2015 11:02:08 +0000
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
 [10.134.21.209])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 59A9EAC02FA
 for <kexec@lists.infradead.org>; Fri, 15 May 2015 20:01:44 +0900 (JST)
Subject: [PATCH v3 1/2] kernel/panic: call the 2nd crash_kexec() only if
 crash_kexec_post_notifiers is enabled
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Date: Fri, 15 May 2015 20:01:44 +0900
Message-ID: <20150515110143.8431.38836.stgit@localhost6.localdomain6>
In-Reply-To: <20150515105953.8431.65220.stgit@localhost6.localdomain6>
References: <20150515105953.8431.65220.stgit@localhost6.localdomain6>
MIME-Version: 1.0
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
To: akpm@linux-foundation.org, ebiederm@xmission.com, vgoyal@redhat.com, mingo@kernel.org
Cc: masami.hiramatsu.pt@hitachi.com, hidehiro.kawai.ez@hitachi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, bhe@redhat.com

For compatibility with the behaviour before the commit
f06e5153f4ae2e2f3b0300f0e260e40cb7fefd45, the 2nd crash_kexec() should
be called only if crash_kexec_post_notifiers is enabled.

Note that crash_kexec() returns immediately if kdump crash kernel is
not loaded, so in this case, this patch makes no functionality change,
but the point is to make it explicit, from the caller panic() side,
that the 2nd crash_kexec() does nothing.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Suggested-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/panic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 8136ad7..774614f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -142,7 +142,8 @@ void panic(const char *fmt, ...)
 	 * Note: since some panic_notifiers can make crashed kernel
 	 * more unstable, it can increase risks of the kdump failure too.
 	 */
-	crash_kexec(NULL);
+	if (crash_kexec_post_notifiers)
+		crash_kexec(NULL);
 
 	bust_spinlocks(0);
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

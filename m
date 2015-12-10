Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6qMX-0007iw-2F
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 01:49:44 +0000
Subject: [V6 PATCH 6/6] Documentation: Add documentation for
 kernel.panic_on_io_nmi sysctl
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Date: Thu, 10 Dec 2015 10:46:37 +0900
Message-ID: <20151210014637.25437.71903.stgit@softrs>
In-Reply-To: <20151210014624.25437.50028.stgit@softrs>
References: <20151210014624.25437.50028.stgit@softrs>
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
To: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@kernel.org>, Borislav Petkov <bp@alien8.de>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

kernel.panic_on_io_nmi sysctl was introduced by commit 5211a242d0cb
("x86: Add sysctl to allow panic on IOCK NMI error"), but its
documentation is missing. So, add it.

V6:
- Newly added

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/sysctl/kernel.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
index af70d15..235f804 100644
--- a/Documentation/sysctl/kernel.txt
+++ b/Documentation/sysctl/kernel.txt
@@ -551,6 +551,21 @@ the recommended setting is 60.
 
 ==============================================================
 
+panic_on_io_nmi:
+
+Controls the kernel's behavior when a CPU receives an NMI caused by
+an IO error.
+
+0: try to continue operation (default)
+
+1: panic immediately. The IO error triggered NMI indicates a serious
+   system condition, which could result in IO data corruption. Rather
+   than continuing, panicking might be a better choice. Some servers
+   issue this sort of NMI when the dump button is pushed, and you
+   can use this option to take a crash dump
+
+==============================================================
+
 panic_on_oops:
 
 Controls the kernel's behaviour when an oops or BUG is encountered.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

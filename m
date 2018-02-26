Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqHSj-0007a2-AB
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 12:01:03 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 5/5] kexec: document -s and -c options.
Date: Mon, 26 Feb 2018 13:00:38 +0100
Message-Id: <afd70d98a36490bde3b1ddf21ea388c8a9ed5fb8.1519646210.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
References: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
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
To: msuchanek@suse.de, kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Petr Tesarik <ptesarik@suse.cz>

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.8 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index e0131b4ea827..f3b1556f749e 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -144,6 +144,13 @@ Load the new kernel for use on panic.
 Specify that the new kernel is of this
 .I type.
 .TP
+.BI \-s\ (\-\-kexec-file-syscall)
+Specify that the new KEXEC_FILE_LOAD syscall should be used exclusively.
+Otherwise KEXEC_FILE_LOAD is tried and when not supported KEXEC_LOAD is used.
+.TP
+.BI \-c\ (\-\-kexec-syscall)
+Specify that the old KEXEC_LOAD syscall should be used exclusively.
+.TP
 .B \-u\ (\-\-unload)
 Unload the current
 .B kexec
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

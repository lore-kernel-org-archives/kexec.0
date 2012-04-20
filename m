Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SLGsr-0002li-09
 for kexec@lists.infradead.org; Fri, 20 Apr 2012 16:40:33 +0000
Date: Fri, 20 Apr 2012 10:39:14 -0600
From: Khalid Aziz <khalid.aziz@hp.com>
Subject: [PATCH] Correct section number for shutdown and clarify what -e
 does in manpage
Message-ID: <20120420163914.GA27026@hp.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

Another patch that I have been carrying in debian kexec-tools package. 
It corrects the section number for shutdown in the man page. This
patch also adds little more descriptive note for the -e option to
clarify that this does not do an orderly shutdown.

Please apply.

Signed-off-by: Khalid Aziz <khalid.aziz@hp.com>
---
 kexec/kexec.8 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index da03c40..aff674c 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -71,7 +71,7 @@ It's also possible to invoke
 .B kexec
 without an option parameter. In that case, kexec loads the specified
 kernel and then invokes
-.BR shutdown (1).
+.BR shutdown (8).
 If the shutdown scripts of your Linux distribution support
 kexec-based rebooting, they then call
 .B kexec
@@ -105,13 +105,13 @@ command:
 .SH OPTIONS
 .TP
 .B \-e\ (\-\-exec)
-Run the currently loaded kernel.
+Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
 .TP
 .B \-f\ (\-\-force)
 Force an immediate
 .B kexec
 call, do not call
-.BR shutdown (1)
+.BR shutdown (8)
 (contrary to the default action without any option parameter). This option
 performs the same actions like executing
 .IR -l
-- 
1.7.8.3

-- 

====================================================================
Khalid Aziz                                         Unix Systems Lab
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

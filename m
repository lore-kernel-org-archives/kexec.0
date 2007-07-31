Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IFof4-0008Nl-IN
	for kexec@lists.infradead.org; Tue, 31 Jul 2007 06:09:08 -0400
Date: Tue, 31 Jul 2007 12:09:08 +0200
From: Pavel Machek <pavel@ucw.cz>
Subject: kexec/kdump: docs fix, stale urls?
Message-ID: <20070731100908.GD3462@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, hbabu@us.ibm.com, kexec@lists.infradead.org, kernel list <linux-kernel@vger.kernel.org>, ebiederm@xmission.com

Hi!

This fixes few typos in kdump.txt. (Please check, I'm not native
speaker). 

Also, the urls pointed out in kdump.txt seem a bit old, are there
better pointers these days?

								Pavel

--- 

This fixes few typos in kdump.txt.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index eb60087..faf0e27 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -69,7 +69,7 @@ http://www.kernel.org/pub/linux/kernel/p
 
 This is a symlink to the latest version, which at the time of writing is
 20061214, the only release of kexec-tools-testing so far. As other versions
-are made released, the older onese will remain available at
+are released, the older ones will remain available at
 http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/
 
 Note: Latest kexec-tools-testing git tree is available at

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

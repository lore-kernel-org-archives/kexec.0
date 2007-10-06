Return-path: <kexec-bounces@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IeEbq-0007qo-HZ
	for kexec@lists.infradead.org; Sat, 06 Oct 2007 19:42:46 +0100
Date: Sat, 6 Oct 2007 20:41:38 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Use fclose() to close the file pointer
Message-ID: <20071006184138.GA16948@suse.de>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Simon@suse.de, Horman@suse.de, horms@verge.net.au
Cc: kexec@lists.infradead.org

Just use fclose() instead of close() to close a pointer of type FILE *.
That fixes the compile warning

kexec/kexec.c: In function 'check_reuse_initrd':
kexec/kexec.c:793: warning: passing argument 1 of 'close' makes integer from pointer without a cast


Signed-off-by: Bernhard Walle <bwalle@suse.de>

---
 kexec/kexec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -790,7 +790,7 @@ void check_reuse_initrd(void)
 		    "retain the initrd for reuse.\n");
 	if (line)
 		free(line);
-	close(fp);
+	fclose(fp);
 }
 
 /* Arch hook for reuse_initrd */

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

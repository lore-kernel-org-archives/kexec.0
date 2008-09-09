Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Kcyh8-00016J-Qu
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 08:35:31 +0000
Content-Type: multipart/mixed; boundary="===============0412276394=="
MIME-Version: 1.0
Subject: [PATCH] Use gzip for manpage compression
Message-Id: <e31c137cf40f10b0a445.1220949784@kepler.site>
Date: Tue, 09 Sep 2008 10:43:04 +0200
From: Bernhard Walle <bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: oomichi@mxs.nes.nec.co.jp
Cc: kexec@lists.infradead.org

--===============0412276394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Use gzip instead of zip for manual page compression. That's the usual
method of compressing manual pages on Unix.


Signed-off-by: Bernhard Walle <bwalle@suse.de>


1 file changed, 1 insertion(+), 1 deletion(-)
Makefile |    2 +-



--===============0412276394==
Content-Type: text/x-patch; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=makedumpfile-use-gzip.diff

Use gzip instead of zip for manual page compression. That's the usual
method of compressing manual pages on Unix.


Signed-off-by: Bernhard Walle <bwalle@suse.de>

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@
 
 makedumpfile: $(SRC) $(OBJ_ARCH)
 	$(CC) $(CFLAGS) $(OBJ_ARCH) -o $@ $< -static -ldw -lelf -lz
-	zip ./makedumpfile.8.gz ./makedumpfile.8
+	gzip -c ./makedumpfile.8 > ./makedumpfile.8.gz
 
 clean:
 	rm -f $(OBJ) $(OBJ_ARCH) makedumpfile makedumpfile.8.gz

--===============0412276394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0412276394==--


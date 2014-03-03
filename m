Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ernst.netinsight.se ([194.16.221.21])
 by merlin.infradead.org with smtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WKRcm-0005Ul-Sw
 for kexec@lists.infradead.org; Mon, 03 Mar 2014 12:05:37 +0000
Date: Mon, 3 Mar 2014 13:04:59 +0100
From: Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?= <simon.kagstrom@netinsight.net>
Subject: [PATCH 3/4] build: Honor VPATH to support out-of-tree builds
Message-ID: <20140303130459.0fc230ae@marrow.netinsight.se>
In-Reply-To: <20140303130213.1d441d32@marrow.netinsight.se>
References: <20140303130213.1d441d32@marrow.netinsight.se>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
 Makefile |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index 57e7e44..b9121ad 100644
--- a/Makefile
+++ b/Makefile
@@ -63,19 +63,20 @@ endif
 all: makedumpfile
 
 $(OBJ_PART): $(SRC_PART)
-	$(CC) $(CFLAGS) -c -o ./$@ ./$(@:.o=.c) 
+	$(CC) $(CFLAGS) -c -o ./$@ $(VPATH)$(@:.o=.c)
 
 $(OBJ_ARCH): $(SRC_ARCH)
-	$(CC) $(CFLAGS_ARCH) -c -o ./$@ ./$(@:.o=.c) 
+	@mkdir -p $(@D)
+	$(CC) $(CFLAGS_ARCH) -c -o ./$@ $(VPATH)$(@:.o=.c)
 
 makedumpfile: $(SRC) $(OBJ_PART) $(OBJ_ARCH)
 	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJ_PART) $(OBJ_ARCH) -rdynamic -o $@ $< $(LIBS)
 	echo .TH MAKEDUMPFILE 8 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.8
-	grep -v "^.TH MAKEDUMPFILE 8" $(SRC)/makedumpfile.8 >> temp.8
+	grep -v "^.TH MAKEDUMPFILE 8" $(VPATH)makedumpfile.8 >> temp.8
 	mv temp.8 makedumpfile.8
 	gzip -c ./makedumpfile.8 > ./makedumpfile.8.gz
 	echo .TH MAKEDUMPFILE.CONF 5 \"$(DATE)\" \"makedumpfile v$(VERSION)\" \"Linux System Administrator\'s Manual\" > temp.5
-	grep -v "^.TH MAKEDUMPFILE.CONF 5" makedumpfile.conf.5 >> temp.5
+	grep -v "^.TH MAKEDUMPFILE.CONF 5" $(VPATH)makedumpfile.conf.5 >> temp.5
 	mv temp.5 makedumpfile.conf.5
 	gzip -c ./makedumpfile.conf.5 > ./makedumpfile.conf.5.gz
 
@@ -87,7 +88,7 @@ clean:
 
 install:
 	install -m 755 -d ${DESTDIR}/usr/sbin ${DESTDIR}/usr/share/man/man5 ${DESTDIR}/usr/share/man/man8 ${DESTDIR}/etc
-	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile makedumpfile-R.pl
+	install -m 755 -t ${DESTDIR}/usr/sbin makedumpfile $(VPATH)makedumpfile-R.pl
 	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
 	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
-	install -m 644 -D makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
+	install -m 644 -D $(VPATH)makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
-- 
1.7.9.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

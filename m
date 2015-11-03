Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZthY5-0001m7-VX
 for kexec@lists.infradead.org; Tue, 03 Nov 2015 19:47:19 +0000
Received: by pasz6 with SMTP id z6so27440911pas.2
 for <kexec@lists.infradead.org>; Tue, 03 Nov 2015 11:47:01 -0800 (PST)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 13/13] Re-enable and clean up "check_config()" in
 headers_check.pl
Date: Tue,  3 Nov 2015 11:46:34 -0800
Message-Id: <1446579994-9937-14-git-send-email-palmer@dabbelt.com>
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

I recently got bit by a CONFIG_ in userspace bug.  This has apparently
happened before, but the check got disabled for triggering too much.
In order to reduce false positives, I added some hueristics to avoid
detecting comments.

Since these tests all pass, I've now re-enabled them.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 scripts/headers_check.pl | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index 62320f9..1634b51 100755
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -27,6 +27,7 @@ my $ret = 0;
 my $line;
 my $lineno = 0;
 my $filename;
+my $check_config_in_multiline_comment = 0;
 
 foreach my $file (@files) {
 	$filename = $file;
@@ -40,7 +41,7 @@ foreach my $file (@files) {
 		&check_asm_types();
 		&check_sizetypes();
 		&check_declarations();
-		# Dropped for now. Too much noise &check_config();
+		&check_config();
 	}
 	close $fh;
 }
@@ -78,7 +79,21 @@ sub check_declarations
 
 sub check_config
 {
-	if ($line =~ m/[^a-zA-Z0-9_]+CONFIG_([a-zA-Z0-9_]+)[^a-zA-Z0-9_]/) {
+	my $nocomments = $line;
+	$nocomments =~ s/\/\*.*\*\///; # Remove ANSI-style comments (/* to */)
+	$nocomments =~ s/\/\/.*//;     # Remove C99-style comments (// to EOL)
+
+	# Check to see if we're within a multiline comment, and if so
+	# just remove the whole line.  I tried matching on '^ * ', but
+	# there's one header that doesn't prepend multi-line comments
+	# with * so that won't work.
+	if ($nocomments =~ m/\/\*/) { $check_config_in_multiline_comment = 1; }
+	if ($nocomments =~ m/\*\//) { $check_config_in_multiline_comment = 0; }
+	if ($check_config_in_multiline_comment == 1) { $nocomments = "" }
+
+	# Check to see if there is something that looks like CONFIG_
+	# inside a userspace-accessible header file and if so, print that out.
+	if ($nocomments =~ m/[^a-zA-Z0-9_]+CONFIG_([a-zA-Z0-9_]+)[^a-zA-Z0-9_]/) {
 		printf STDERR "$filename:$lineno: leaks CONFIG_$1 to userspace where it is not valid\n";
 	}
 }
-- 
2.4.10


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

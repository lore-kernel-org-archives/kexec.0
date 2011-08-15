Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qsx9o-0000dP-Dw
	for kexec@lists.infradead.org; Mon, 15 Aug 2011 13:24:45 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7FDORjH002001
	for <kexec@lists.infradead.org>; Mon, 15 Aug 2011 13:24:27 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7FDORm12396302
	for <kexec@lists.infradead.org>; Mon, 15 Aug 2011 14:24:27 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7FDORUl000349
	for <kexec@lists.infradead.org>; Mon, 15 Aug 2011 07:24:27 -0600
Subject: [PATCH] makedumpfile: Support line mode terminals
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 15:24:26 +0200
Message-ID: <1313414666.9445.3.camel@br98xy6r>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

On S390 we have line mode terminals that do not have the ability to
position the cursor. When using kdump the output of makedumpfile will be shown
on such terminals. Currently the output looks very strange because the '\r'
control character is ignored. It looks like the following:

 Checking for memory holes          : [  0 %]  Checking for memory holes        
  : [100 %]  Copying data                       : [ 33 %]  Copying data         
              : [ 65 %]  Copying data                       : [ 96 %]  Copying d
ata                       : [100 %]   

For those line mode terminals the TERM environment variable is set to "dumb".
With this patch makedumpfile checks the TERM variable and in case of "dumb"
instead of using '\r' each progress message is printed into a separate line.
The output will then look like the following:

Checking for memory holes          : [  0 %]
Checking for memory holes          : [100 %]
Copying data                       : [ 11 %]
Copying data                       : [ 44 %]
Copying data                       : [ 75 %]
Copying data                       : [100 %]

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 makedumpfile.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -29,6 +29,7 @@ struct DumpInfo		*info = NULL;
 
 char filename_stdout[] = FILENAME_STDOUT;
 int message_level;
+static int dumb_term;
 
 /*
  * Forward declarations
@@ -5661,9 +5662,14 @@ print_progress(const char *msg, unsigned
 		progress = current * 100 / end;
 	} else
 		progress = 100;
-
-	PROGRESS_MSG("\r");
-	PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ", msg, progress);
+	if (dumb_term) {
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%]\n",
+			     msg, progress);
+	} else {
+		PROGRESS_MSG("\r");
+		PROGRESS_MSG("%-" PROGRESS_MAXLEN "s: [%3d %%] ",
+			     msg, progress);
+	}
 }
 
 unsigned long long
@@ -7825,11 +7831,21 @@ static struct option longopts[] = {
 	{0, 0, 0, 0}
 };
 
+static void setup_term(void)
+{
+	char *term_str = getenv("TERM");
+
+	if (term_str && strcmp(term_str, "dumb") == 0)
+		dumb_term = 1;
+}
+
 int
 main(int argc, char *argv[])
 {
 	int i, opt, flag_debug = FALSE;
 
+	setup_term();
+
 	if ((info = calloc(1, sizeof(struct DumpInfo))) == NULL) {
 		ERRMSG("Can't allocate memory for the pagedesc cache. %s.\n",
 		    strerror(errno));



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

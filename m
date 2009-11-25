Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NDR7S-0007BV-D2
	for kexec@lists.infradead.org; Wed, 25 Nov 2009 23:17:59 +0000
Date: Thu, 26 Nov 2009 10:17:52 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec.c: workaround getline and fscanf to make it
	*libc agnostic. Tested against klibc and dietlibc.
Message-ID: <20091125231752.GL4794@verge.net.au>
References: <1258845169-4999-1-git-send-email-andrea.adami@gmail.com>
	<20091122050350.GF2728@verge.net.au> <4B09034E.40309@bwalle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B09034E.40309@bwalle.de>
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
To: Bernhard Walle <bernhard@bwalle.de>
Cc: Andrea Adami <andrea.adami@gmail.com>, Yuri Bushmelev <jay4mail@gmail.com>, kexec@lists.infradead.org

On Sun, Nov 22, 2009 at 10:24:30AM +0100, Bernhard Walle wrote:
> Simon Horman schrieb:
> >
> >> +	char *line = malloc(sizeof_line); /* according to strdup() later */
> >
> > 	Could line be char line[1024] ?
> 
> Better would be a constant. However, 1024 is too less since the maximum
> command line size can be 2048 currently on x86
> (arch/x86/include/asm/setup.h, #define COMMAND_LINE_SIZE 2048).

Hi,

I have taken a stab at revising this patch:

----------------------------------------------------------------------

kexec.c: workaround getline and fscanf to make it *libc agnostic.
	Tested against klibc and dietlibc.

Based on a patch by Andrea Adami and Yuri Bushmelev
I have:

* Cleaned up indentation
* Rearranged the logic in get_command_line()
* Increased the buffer for reading the command line
  from 1024 to 2048 bytes as this is now possible on x86

Only compile tested against glibc.

Cc: Andrea Adami <andrea.adami@gmail.com>
Cc: Yuri Bushmelev <jay4mail@gmail.com>
Cc: Bernhard Walle <bernhard@bwalle.de>
Signed-off-by: Simon Horman <horms@verge.net.au>

Index: kexec-tools/kexec/kexec.c
===================================================================
--- kexec-tools.orig/kexec/kexec.c	2009-11-26 10:10:01.000000000 +1100
+++ kexec-tools/kexec/kexec.c	2009-11-26 10:10:22.000000000 +1100
@@ -933,15 +933,32 @@ void usage(void)
 
 static int kexec_loaded(void)
 {
-	int ret;
+	long ret = -1;
 	FILE *fp;
+	char *p;
+	char line[3];
 
 	fp = fopen("/sys/kernel/kexec_loaded", "r");
 	if (fp == NULL)
 		return -1;
-	fscanf(fp, "%d", &ret);
+
+	p = fgets(line, sizeof(line), fp);
 	fclose(fp);
-	return ret;
+
+	if ( NULL == p)
+		return -1;
+
+	ret = strtol(line, &p, 10);
+
+	/* Too long */
+	if (ret > INT_MAX)
+		return -1;
+
+	/* No digits were found */
+	if (p == line)
+		return -1;
+
+	return (int)ret;
 }
 
 /*
@@ -989,24 +1006,28 @@ static void remove_parameter(char *line,
 char *get_command_line(void)
 {
 	FILE *fp;
-	size_t len;
-	char *line = NULL;
+	char *line;
+	const int sizeof_line = 2048;
+
+	line = malloc(sizeof_line);
+	if (line == NULL)
+		die("Could not allocate memory to read /proc/cmdline.");
 
 	fp = fopen("/proc/cmdline", "r");
 	if (!fp)
-		die("Could not read /proc/cmdline.");
-	getline(&line, &len, fp);
+		die("Could not open /proc/cmdline.");
+
+	if (fgets(line, sizeof_line, fp) == NULL)
+		die("Can't read /proc/cmdline.");
+
 	fclose(fp);
 
-	if (line) {
-		/* strip newline */
-		*(line + strlen(line) - 1) = 0;
-
-		remove_parameter(line, "BOOT_IMAGE");
-		if (kexec_flags & KEXEC_ON_CRASH)
-			remove_parameter(line, "crashkernel");
-	} else
-		line = strdup("");
+	/* strip newline */
+	line[strlen(line) - 1] = '\0';
+
+	remove_parameter(line, "BOOT_IMAGE");
+	if (kexec_flags & KEXEC_ON_CRASH)
+		remove_parameter(line, "crashkernel");
 
 	return line;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

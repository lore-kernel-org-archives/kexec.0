Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZH2W-0000lF-8m
 for kexec@lists.infradead.org; Fri, 26 Feb 2016 11:58:32 +0000
Date: Fri, 26 Feb 2016 19:57:55 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH update] kexec/fs2dt.c: wrong dt node fix
Message-ID: <20160226115755.GA10986@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Andrew Jones <drjones@redhat.com>, Simon Horman <horms@verge.net.au>

2nd kernel hangs early because of a regression caused by below commit:
commit 68262155d8c661586b809bc5301a7dff1c378137
Author: Andrew Jones <drjones@redhat.com>
Date:   Fri Nov 20 12:31:53 2015 -0500

    kexec/fs2dt: cleanup pathname
    
    putnode() will add the trailing '/', avoid having two. Also
    pathstart is unused, get rid of it.
    
    Signed-off-by: Andrew Jones <drjones@redhat.com>
    Signed-off-by: Simon Horman <horms@verge.net.au>

The actual purpose of the commit is to avoid double slash in pathname.
But unfortunately in function putnode() we have below magics to get the node
name:
	basename = strrchr(pathname,'/') + 1;
	...
	strcpy((void *)dt, *basename ? basename : "");
	...
	strcat(pathname, "/");

We treat none zero basename as a node name, then concat a slash to open the
directory for later property handling.
pathname originally was "/proc/device-tree/" so for the first run of putnode
it will cause double slashes. With the commit above mentioned there are no
double slashes but we will copy "device-tree" to dt. Thus kexec kernel is not
happy..

Instead let's fix it by only concating slash when the basenanme is not empty
and restore the initial value of pathname as "/proc/device-tree/"

Note: I only reproduce the issue with loading older kernel like 3.10 in RHEL. I do
not see the problem in new kernels in Fedora.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/fs2dt.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- kexec-tools.orig/kexec/fs2dt.c
+++ kexec-tools/kexec/fs2dt.c
@@ -577,7 +577,8 @@ static void putnode(void)
 	strcpy((void *)dt, *basename ? basename : "");
 	dt += ((plen + 4)/4);
 
-	strcat(pathname, "/");
+	if (*basename)
+		strcat(pathname, "/");
 	dn = pathname + strlen(pathname);
 
 	putprops(dn, namelist, numlist);
@@ -804,7 +805,7 @@ static void add_boot_block(char **bufp,
 
 void create_flatten_tree(char **bufp, off_t *sizep, const char *cmdline)
 {
-	strcpy(pathname, "/proc/device-tree");
+	strcpy(pathname, "/proc/device-tree/");
 
 	dt_cur_size = INIT_TREE_WORDS;
 	dt_base = malloc(dt_cur_size*4);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

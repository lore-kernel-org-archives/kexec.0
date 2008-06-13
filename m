Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([59.145.155.5] helo=e28esmtp05.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K7Da4-0007Nq-Aq
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 18:01:05 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m5DI0Rf5011345
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:30:27 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DHxgSf864398
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:29:42 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m5DI0Qag011424
	for <kexec@lists.infradead.org>; Fri, 13 Jun 2008 23:30:27 +0530
From: Chandru <chandru@in.ibm.com>
Subject: [RFC][PATCH 3/3] kexec-tools: add support for dynamic reconfiguration
	memory
Date: Fri, 13 Jun 2008 23:30:21 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200806132330.21758.chandru@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: bwalle@suse.de, vgoyal@redhat.com, maneesh@in.ibm.com

The add_dyn_reconf_usable_mem_property() appends the entry number from 
ibm,dynamic-memory to 'linux,usable-memory' string. 


Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com
---

--- kexec/arch/ppc64/fs2dt.c.orig	2008-06-12 06:26:57.000000000 -0400
+++ kexec/arch/ppc64/fs2dt.c	2008-06-13 12:44:47.000000000 -0400
@@ -35,7 +35,7 @@
 
 #define MAXPATH 1024		/* max path name length */
 #define NAMESPACE 16384		/* max bytes for property names */
-#define TREEWORDS 65536		/* max 32 bit words for property values */
+#define TREEWORDS 131072	/* max 32 bit words for property values */
 #define MEMRESERVE 256		/* max number of reserved memory blocks */
 #define MAX_MEMORY_RANGES 1024
 
@@ -122,18 +122,90 @@ static unsigned propnum(const char *name
 	return offset;
 }
 
+static void add_dyn_reconf_usable_mem_property(int fd)
+{
+	char fname[MAXPATH], propname[64], t[32], *bname;
+	const char tbuf[128];
+	unsigned long long buf[32];
+	unsigned long ranges[2*MAX_MEMORY_RANGES];
+	unsigned long long base, end, loc_base, loc_end;
+	int range, rlen = 0, i;
+
+	strcpy(fname, pathname);
+	bname = strrchr(fname, '/');
+	bname[0] = '\0';
+	bname = strrchr(fname, '/');
+	if (strncmp(bname, "/ibm,dynamic-reconfiguration-memory", 36))
+		return;
+
+	if (lseek(fd, 4, SEEK_SET) < 0)
+		die("unrecoverable error: error seeking in \"%s\": %s\n",
+		    pathname, strerror(errno));
+	for (i = 1; i <= num_of_lmbs; i++) {
+		rlen = 0;
+		if (read(fd, buf, 24) < 0)
+			die("unrecoverable error: error reading \"%s\": %s\n",
+			    pathname, strerror(errno));
+
+		base = buf[0];
+		end = base + lmb_size;
+		if (~0ULL - base < end)
+			die("unrecoverable error: mem property overflow\n");
+
+		for (range = 0; range < usablemem_rgns.size; range++) {
+			loc_base = usablemem_rgns.ranges[range].start;
+			loc_end = usablemem_rgns.ranges[range].end;
+			if (loc_base >= base && loc_end <= end) {
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+			} else if (base < loc_end && end > loc_base) {
+				if (loc_base < base)
+					loc_base = base;
+				if (loc_end > end)
+					loc_end = end;
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+			}
+		}
+
+		if (!rlen) {
+			/*
+			 * User did not pass any ranges for this region.
+			 * Hence, write (0,0) duple in linux,usable-memory
+			 * property such that this region will be ignored.
+			 */
+			ranges[rlen++] = 0;
+			ranges[rlen++] = 0;
+		}
+
+		rlen = rlen * sizeof(unsigned long);
+		/*
+		 * Add linux,usable-memory property.
+		 */
+		*dt++ = 3;
+		*dt++ = rlen;
+		strcpy(tbuf, "linux,usable-memory");
+		sprintf(t, "%d", i);
+		strcat(tbuf, t);
+		*dt++ = propnum((const char *)tbuf);
+		if ((rlen >= 8) && ((unsigned long)dt & 0x4))
+			dt++;
+		memcpy(dt, &ranges, rlen);
+		dt += (rlen + 3)/4;
+	}
+}
 static void add_usable_mem_property(int fd, int len)
 {
 	char fname[MAXPATH], *bname;
 	unsigned long long buf[2];
 	unsigned long ranges[2*MAX_MEMORY_RANGES];
 	unsigned long long base, end, loc_base, loc_end;
-	int range, rlen = 0;
+	int range, rlen = 0, i;
 
 	strcpy(fname, pathname);
-	bname = strrchr(fname,'/');
+	bname = strrchr(fname, '/');
 	bname[0] = '\0';
-	bname = strrchr(fname,'/');
+	bname = strrchr(fname, '/');
 	if (strncmp(bname, "/memory@", 8))
 		return;
 
@@ -171,7 +243,7 @@ static void add_usable_mem_property(int 
 
 	if (!rlen) {
 		/*
-		 * User did not pass any ranges for thsi region. Hence, write
+		 * User did not pass any ranges for this region. Hence, write
 		 * (0,0) duple in linux,usable-memory property such that
 		 * this region will be ignored.
 		 */
@@ -190,6 +262,7 @@ static void add_usable_mem_property(int 
 		dt++;
 	memcpy(dt,&ranges,rlen);
 	dt += (rlen + 3)/4;
+
 }
 
 /* put all properties (files) in the property structure */
@@ -267,6 +340,9 @@ static void putprops(char *fn, struct di
 		dt += (len + 3)/4;
 		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
 			add_usable_mem_property(fd, len);
+		if (!strcmp(dp->d_name, "ibm,dynamic-memory") &&
+						usablemem_rgns.size)
+			add_dyn_reconf_usable_mem_property(fd);
 		close(fd);
 	}
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

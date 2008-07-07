Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KFvhU-0002sE-SU
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 18:44:38 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m67IhZtm017096
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:43:35 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m67Ii7bR4374684
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:44:07 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m67IiYQS008109
	for <kexec@lists.infradead.org>; Tue, 8 Jul 2008 04:44:34 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH 2/4] kdump : add support for ibm,
	dynamic-reconfiguration-memory for kexec/kdump
Date: Tue, 8 Jul 2008 00:14:32 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200807080014.32765.chandru@in.ibm.com>
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
To: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org
Cc: maneesh@in.ibm.com

Add linux,usable-memory properties into device tree in case of 
ibm,dynamic-reconfiguration-memory node of /proc/device-tree

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

diff -Naurp kexec-tools-testing-orig/kexec/arch/ppc64/fs2dt.c 
kexec-tools-testing/kexec/arch/ppc64/fs2dt.c
--- kexec-tools-testing-orig/kexec/arch/ppc64/fs2dt.c	2008-07-07 
17:54:58.000000000 +0530
+++ kexec-tools-testing/kexec/arch/ppc64/fs2dt.c	2008-07-07 20:08:53.000000000 
+0530
@@ -122,6 +122,80 @@ static unsigned propnum(const char *name
 	return offset;
 }
 
+static void add_dyn_reconf_usable_mem_property(int fd)
+{
+	char fname[MAXPATH], propname[64], t[8], *bname;
+	const char tbuf[32];
+	uint64_t buf[32];
+	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t base, end, loc_base, loc_end;
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
+			pathname, strerror(errno));
+
+	/* kernel counts the lmb's from 1, hence use i=1 here */
+	for (i = 1; i <= num_of_lmbs; i++) {
+		rlen = 0;
+		if (read(fd, buf, 24) < 0)
+			die("unrecoverable error: error reading \"%s\": %s\n",
+				pathname, strerror(errno));
+
+		base = (uint64_t) buf[0];
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
+		rlen = rlen * sizeof(uint64_t);
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
+
 static void add_usable_mem_property(int fd, int len)
 {
 	char fname[MAXPATH], *bname;
@@ -267,6 +341,10 @@ static void putprops(char *fn, struct di
 		dt += (len + 3)/4;
 		if (!strcmp(dp->d_name, "reg") && usablemem_rgns.size)
 			add_usable_mem_property(fd, len);
+		if (!strcmp(dp->d_name, "ibm,dynamic-memory") &&
+					usablemem_rgns.size)
+			add_dyn_reconf_usable_mem_property(fd);
+
 		close(fd);
 	}

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

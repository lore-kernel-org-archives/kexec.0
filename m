Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KiSsR-00045w-1w
	for kexec@lists.infradead.org; Wed, 24 Sep 2008 11:49:51 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m8OBnm57031581
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:19:48 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m8OBnlff1564784
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 17:19:47 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id m8OBnTDk031215
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
Received: from guara.in.ibm.com ([9.124.35.51])
	by d28av05.in.ibm.com (8.13.1/8.12.11) with ESMTP id m8OBnTpI030328
	for <kexec@lists.infradead.org>; Wed, 24 Sep 2008 21:49:29 +1000
From: Chandru <chandru@in.ibm.com>
Subject: [PATCH 2/3] kexec/kdump : add a new linux,
	usable-drconf-memory node to the device tree
Date: Wed, 24 Sep 2008 17:19:18 +0530
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809241719.19003.chandru@in.ibm.com>
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

Add a new linux,usable-drconf-memory property to the device tree passed to the 
2nd kernel.  Each entry in the property is of the form: a count followed by so 
many  (base, size) pairs of usable memory regions.  The total number of such 
entries is equal to number of lmb's in ibm,dynamic-memory property.

Signed-off-by: Chandru Siddalingappa <chandru@in.ibm.com>
---

 kexec/arch/ppc64/fs2dt.c |   72 +++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

--- kexec-tools-orig/kexec/arch/ppc64/fs2dt.c	2008-09-24 14:46:55.000000000 
+0530
+++ kexec-tools/kexec/arch/ppc64/fs2dt.c	2008-09-16 19:19:02.000000000 +0530
@@ -122,6 +122,74 @@ static unsigned propnum(const char *name
 	return offset;
 }
 
+static void add_dyn_reconf_usable_mem_property(int fd)
+{
+	char fname[MAXPATH], *bname;
+	uint64_t buf[32];
+	uint64_t ranges[2*MAX_MEMORY_RANGES];
+	uint64_t base, end, loc_base, loc_end;
+	int range, rlen = 0, i;
+	int rngs_cnt, tmp_indx;
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
+	rlen = 0;
+	for (i = 0; i < num_of_lmbs; i++) {
+		if (read(fd, buf, 24) < 0)
+			die("unrecoverable error: error reading \"%s\": %s\n",
+				pathname, strerror(errno));
+
+		base = (uint64_t) buf[0];
+		end = base + lmb_size;
+		if (~0ULL - base < end)
+			die("unrecoverable error: mem property overflow\n");
+
+		tmp_indx = rlen++;
+
+		rngs_cnt = 0;
+		for (range = 0; range < usablemem_rgns.size; range++) {
+			loc_base = usablemem_rgns.ranges[range].start;
+			loc_end = usablemem_rgns.ranges[range].end;
+			if (loc_base >= base && loc_end <= end) {
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+				rngs_cnt++;
+			} else if (base < loc_end && end > loc_base) {
+				if (loc_base < base)
+					loc_base = base;
+				if (loc_end > end)
+					loc_end = end;
+				ranges[rlen++] = loc_base;
+				ranges[rlen++] = loc_end - loc_base;
+				rngs_cnt++;
+			}
+		}
+		/* Store the count of (base, size) duple */
+		ranges[tmp_indx] = rngs_cnt;
+	}
+		
+	rlen = rlen * sizeof(uint64_t);
+	/*
+	 * Add linux,drconf-usable-memory property.
+	 */
+	*dt++ = 3;
+	*dt++ = rlen;
+	*dt++ = propnum("linux,drconf-usable-memory");
+	if ((rlen >= 8) && ((unsigned long)dt & 0x4))
+		dt++;
+	memcpy(dt, &ranges, rlen);
+	dt += (rlen + 3)/4;
+}
+
 static void add_usable_mem_property(int fd, int len)
 {
 	char fname[MAXPATH], *bname;
@@ -267,6 +335,10 @@ static void putprops(char *fn, struct di
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

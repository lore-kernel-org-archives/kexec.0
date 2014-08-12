Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XH8ML-0006pK-I2
 for kexec@lists.infradead.org; Tue, 12 Aug 2014 09:27:14 +0000
Date: Tue, 12 Aug 2014 17:25:30 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [Patch v3 2/7] functions to get crashkernel memory range
Message-ID: <20140812092530.GA4887@dhcp-16-105.nay.redhat.com>
References: <1406535606-16303-1-git-send-email-bhe@redhat.com>
 <1406535606-16303-3-git-send-email-bhe@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97246701@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97246701@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 08/01/14 at 07:32am, Atsushi Kumagai wrote:
> >+ */
> >+int iomem_for_each_line(char *match,
> >+			      int (*callback)(void *data,
> >+					      int nr,
> >+					      char *str,
> >+					      unsigned long base,
> >+					      unsigned long length),
> >+			      void *data)
> >+{
> >+	const char iomem[] = "/proc/iomem";
> >+	char line[BUFSIZE_FGETS];
> >+	FILE *fp;
> >+	unsigned long long start, end, size;
> >+	char *str;
> >+	int consumed;
> >+	int count;
> >+	int nr = 0;
> >+
> >+	fp = fopen(iomem, "r");
> >+	if (!fp) {
> >+		ERRMSG("Cannot open %s\n", iomem);
> >+		exit(1);
> >+	}
> 
> Could you change this to return ERROR and handle it in the
> caller side? It's a coding style of makedumpfile.

Yes, sure. I plan to return nr since nr is initialized to 0. Then it
will cause show_mem_usage() to return FALSE and print the related
failure message.

	fp = fopen(iomem, "r");
        if (!fp) {
                ERRMSG("Cannot open %s\n", iomem);
                return nr;
        } 

> > static struct option longopts[] = {
> > 	{"split", no_argument, NULL, OPT_SPLIT},
> > 	{"reassemble", no_argument, NULL, OPT_REASSEMBLE},
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index 9402f05..7ffa1ee 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -1452,6 +1452,13 @@ extern struct array_table	array_table;
> > extern struct number_table	number_table;
> > extern struct srcfile_table	srcfile_table;
> >
> >+struct memory_range {
> >+        unsigned long long start, end;
> >+};
> >+
> >+#define CRASH_RESERVED_MEM_NR   8
> >+struct memory_range crash_reserved_mem[CRASH_RESERVED_MEM_NR];
> >+int crash_reserved_mem_nr;
> >
> > int readmem(int type_addr, unsigned long long addr, void *bufptr, size_t size);
> > int get_str_osrelease_from_vmlinux(void);
> >--
> >1.8.5.3
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 
> 
> Thanks
> Atsushi Kumagai
> 
> >+
> >+	while(fgets(line, sizeof(line), fp) != 0) {
> >+		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
> >+		if (count != 2)
> >+			continue;
> >+		str = line + consumed;
> >+		size = end - start + 1;
> >+		if (!match || memcmp(str, match, strlen(match)) == 0) {
> >+			if (callback
> >+			    && callback(data, nr, str, start, size) < 0) {
> >+				break;
> >+			}
> >+			nr++;
> >+		}
> >+	}
> >+
> >+	fclose(fp);
> >+
> >+	return nr;
> >+}
> >+
> >+static int crashkernel_mem_callback(void *data, int nr,
> >+                                          char *str,
> >+                                          unsigned long base,
> >+                                          unsigned long length)
> >+{
> >+        if (nr >= CRASH_RESERVED_MEM_NR)
> >+                return 1;
> >+
> >+        crash_reserved_mem[nr].start = base;
> >+        crash_reserved_mem[nr].end   = base + length - 1;
> >+        return 0;
> >+}
> >+
> >+int is_crashkernel_mem_reserved(void)
> >+{
> >+        int ret;
> >+
> >+        ret = iomem_for_each_line("Crash kernel\n",
> >+                                        crashkernel_mem_callback, NULL);
> >+        crash_reserved_mem_nr = ret;
> >+
> >+        return !!crash_reserved_mem_nr;
> >+}
> >+

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMsCb-0007E4-1Y
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 04:20:23 +0000
Message-ID: <523BCBFF.4050508@mxc.nes.nec.co.jp>
Date: Fri, 20 Sep 2013 13:15:59 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH v2] dump-dmesg: Understand >= v3.11-rc4 dmesg
References: <522979FA.7090409@mxc.nes.nec.co.jp>
 <1379506754-24222-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1379506754-24222-1-git-send-email-lkundrak@v3.sk>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: lkundrak@v3.sk
Cc: usui@mxm.nes.nec.co.jp, nishimura@mxp.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, louis.bouchard@canonical.com, kexec@lists.infradead.org

Hello Lubomir,

(2013/09/18 22:59), Lubomir Rintel wrote:
> Symbol name changed with the following commit:
> 62e32ac printk: rename struct log to struct printk_log
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Cc: Louis Bouchard <louis.bouchard@canonical.com>
> Cc: Masaki Tachibana <tachibana@mxm.nes.nec.co.jp>
> Cc: Minoru Usui <usui@mxm.nes.nec.co.jp>
> Cc: Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>
> Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
> So, the change did make it into 3.11.
> Does this make sense?

Thanks, I'll merge this patch with the small change below:


diff --git a/makedumpfile.c b/makedumpfile.c
index ca27987..c21d113 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -49,7 +49,6 @@ unsigned long long pfn_hwpoison;
  
  unsigned long long num_dumped;
  
-int use_printk_log;	/* did we read printk_log symbol name? */
  int retcd = FAILED;	/* return code */
  
  #define INITIALIZE_LONG_TABLE(table, value) \
@@ -1392,12 +1391,12 @@ get_structure_info(void)
  
  	SIZE_INIT(printk_log, "printk_log");
  	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
-		use_printk_log = 1;
+		info->flag_use_printk_log = TRUE;
  		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
  		OFFSET_INIT(printk_log.len, "printk_log", "len");
  		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
  	} else {
-		use_printk_log = 0;
+		info->flag_use_printk_log = FALSE;
  		SIZE_INIT(printk_log, "log");
  		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
  		OFFSET_INIT(printk_log.len, "log", "len");
@@ -1603,7 +1602,7 @@ write_vmcoreinfo_data(void)
  	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
  	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
  	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
-	if (use_printk_log)
+	if (info->flag_use_printk_log)
  		WRITE_STRUCTURE_SIZE("printk_log", printk_log);
  	else
  		WRITE_STRUCTURE_SIZE("log", printk_log);
@@ -1641,7 +1640,7 @@ write_vmcoreinfo_data(void)
  	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
  	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
  	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
-	if (use_printk_log) {
+	if (info->flag_use_printk_log) {
  		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
  		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
  		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
@@ -1962,12 +1961,12 @@ read_vmcoreinfo(void)
  
  	READ_STRUCTURE_SIZE("printk_log", printk_log);
  	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
-		use_printk_log = 1;
+		info->flag_use_printk_log = TRUE;
  		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
  		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
  		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
  	} else {
-		use_printk_log = 0;
+		info->flag_use_printk_log = FALSE;
  		READ_STRUCTURE_SIZE("log", printk_log);
  		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
  		READ_MEMBER_OFFSET("log.len", printk_log.len);

diff --git a/makedumpfile.h b/makedumpfile.h
index d244b83..3a7e61a 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -893,6 +893,7 @@ struct DumpInfo {
  	int		flag_force;	     /* overwrite existing stuff */
  	int		flag_exclude_xen_dom;/* exclude Domain-U from xen-kdump */
  	int             flag_dmesg;          /* dump the dmesg log out of the vmcore file */
+	int		flag_use_printk_log; /* did we read printk_log symbol name? */
  	int		flag_nospace;	     /* the flag of "No space on device" error */
  	unsigned long	vaddr_for_vtop;      /* virtual address for debugging */
  	long		page_size;           /* size of page */
@@ -1176,6 +1177,7 @@ struct size_table {
  	long	list_head;
  	long	node_memblk_s;
  	long	nodemask_t;
+	long	printk_log;
  
  	/*
  	 * for Xen extraction
@@ -1198,8 +1200,6 @@ struct size_table {
  	long	cpumask_t;
  	long	kexec_segment;
  	long	elf64_hdr;
-	long	printk_log;
-	long	log;
  
  	long	pageflags;
  };


Thanks
Atsushi Kumagai

> Changes for v2:
>    * Only back values for symbol names we did actually read; either "log"
>      or "printk_log"
>
>   makedumpfile.c |   66 ++++++++++++++++++++++++++++++++++++++++---------------
>   makedumpfile.h |    5 ++-
>   2 files changed, 51 insertions(+), 20 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b42565c..6f00167 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -49,6 +49,7 @@ unsigned long long pfn_hwpoison;
>
>   unsigned long long num_dumped;
>
> +int use_printk_log;	/* did we read printk_log symbol name? */
>   int retcd = FAILED;	/* return code */
>
>   #define INITIALIZE_LONG_TABLE(table, value) \
> @@ -1389,10 +1390,19 @@ get_structure_info(void)
>   	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
>   	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
>
> -	SIZE_INIT(log, "log");
> -	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
> -	OFFSET_INIT(log.len, "log", "len");
> -	OFFSET_INIT(log.text_len, "log", "text_len");
> +	SIZE_INIT(printk_log, "printk_log");
> +	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
> +		use_printk_log = 1;
> +		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
> +		OFFSET_INIT(printk_log.len, "printk_log", "len");
> +		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
> +	} else {
> +		use_printk_log = 0;
> +		SIZE_INIT(printk_log, "log");
> +		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
> +		OFFSET_INIT(printk_log.len, "log", "len");
> +		OFFSET_INIT(printk_log.text_len, "log", "text_len");
> +	}
>
>   	return TRUE;
>   }
> @@ -1593,7 +1603,10 @@ write_vmcoreinfo_data(void)
>   	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
>   	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
>   	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
> -	WRITE_STRUCTURE_SIZE("log", log);
> +	if (use_printk_log)
> +		WRITE_STRUCTURE_SIZE("printk_log", printk_log);
> +	else
> +		WRITE_STRUCTURE_SIZE("log", printk_log);
>
>   	/*
>   	 * write the member offset of 1st kernel
> @@ -1628,9 +1641,16 @@ write_vmcoreinfo_data(void)
>   	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>   	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
>   	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
> -	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
> -	WRITE_MEMBER_OFFSET("log.len", log.len);
> -	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
> +	if (use_printk_log) {
> +		WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
> +		WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
> +		WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +	} else {
> +		/* Compatibility with pre-3.11-rc4 */
> +		WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> +		WRITE_MEMBER_OFFSET("log.len", printk_log.len);
> +		WRITE_MEMBER_OFFSET("log.text_len", printk_log.text_len);
> +	}
>
>   	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>   		WRITE_ARRAY_LENGTH("node_data", node_data);
> @@ -1909,7 +1929,6 @@ read_vmcoreinfo(void)
>   	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
>   	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
>   	READ_STRUCTURE_SIZE("pageflags", pageflags);
> -	READ_STRUCTURE_SIZE("log", log);
>
>   	READ_MEMBER_OFFSET("page.flags", page.flags);
>   	READ_MEMBER_OFFSET("page._count", page._count);
> @@ -1940,9 +1959,20 @@ read_vmcoreinfo(void)
>   	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>   	READ_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
>   	READ_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
> -	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
> -	READ_MEMBER_OFFSET("log.len", log.len);
> -	READ_MEMBER_OFFSET("log.text_len", log.text_len);
> +
> +	READ_STRUCTURE_SIZE("printk_log", printk_log);
> +	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
> +		use_printk_log = 1;
> +		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
> +		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
> +		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +	} else {
> +		use_printk_log = 0;
> +		READ_STRUCTURE_SIZE("log", printk_log);
> +		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> +		READ_MEMBER_OFFSET("log.len", printk_log.len);
> +		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
> +	}
>
>   	READ_ARRAY_LENGTH("node_data", node_data);
>   	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
> @@ -3705,13 +3735,13 @@ dump_log_entry(char *logptr, int fp)
>   	ulonglong nanos;
>   	ulong rem;
>
> -	text_len = USHORT(logptr + OFFSET(log.text_len));
> -	ts_nsec = ULONGLONG(logptr + OFFSET(log.ts_nsec));
> +	text_len = USHORT(logptr + OFFSET(printk_log.text_len));
> +	ts_nsec = ULONGLONG(logptr + OFFSET(printk_log.ts_nsec));
>
>   	nanos = (ulonglong)ts_nsec / (ulonglong)1000000000;
>   	rem = (ulonglong)ts_nsec % (ulonglong)1000000000;
>
> -	msg = logptr + SIZE(log);
> +	msg = logptr + SIZE(printk_log);
>
>   	sprintf(buf, "[%5lld.%06ld] ", nanos, rem/1000);
>
> @@ -3749,7 +3779,7 @@ log_from_idx(unsigned int idx, char *logbuf)
>   	 * the buffer.
>   	 */
>
> -	msglen = USHORT(logptr + OFFSET(log.len));
> +	msglen = USHORT(logptr + OFFSET(printk_log.len));
>   	if (!msglen)
>   		logptr = logbuf;
>
> @@ -3770,9 +3800,9 @@ log_next(unsigned int idx, char *logbuf)
>   	 * return the one after that.
>   	 */
>
> -	msglen = USHORT(logptr + OFFSET(log.len));
> +	msglen = USHORT(logptr + OFFSET(printk_log.len));
>   	if (!msglen) {
> -		msglen = USHORT(logbuf + OFFSET(log.len));
> +		msglen = USHORT(logbuf + OFFSET(printk_log.len));
>   		return msglen;
>   	}
>
> diff --git a/makedumpfile.h b/makedumpfile.h
> index a5826e0..c33852a 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1198,6 +1198,7 @@ struct size_table {
>   	long	cpumask_t;
>   	long	kexec_segment;
>   	long	elf64_hdr;
> +	long	printk_log;
>   	long	log;
>
>   	long	pageflags;
> @@ -1337,11 +1338,11 @@ struct offset_table {
>   		long	p_memsz;
>   	} elf64_phdr;
>
> -	struct log_s {
> +	struct printk_log_s {
>   		long ts_nsec;
>   		long len;
>   		long text_len;
> -	} log;
> +	} printk_log;
>
>   };
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

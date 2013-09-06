Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VHpp6-0008QO-Jb
 for kexec@lists.infradead.org; Fri, 06 Sep 2013 06:47:19 +0000
Message-ID: <522979FA.7090409@mxc.nes.nec.co.jp>
Date: Fri, 06 Sep 2013 15:45:14 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] dump-dmesg: Understand >= v3.11-rc4 dmesg
References: <1378065900-20513-1-git-send-email-lkundrak@v3.sk>
In-Reply-To: <1378065900-20513-1-git-send-email-lkundrak@v3.sk>
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

HelloLubomir,

(2013/09/02 5:04), Lubomir Rintel wrote:
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
>   makedumpfile.c |   56 ++++++++++++++++++++++++++++++++++++++------------------
>   makedumpfile.h |    6 +++---
>   2 files changed, 41 insertions(+), 21 deletions(-)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index b42565c..5b04048 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1389,10 +1389,17 @@ get_structure_info(void)
>   	OFFSET_INIT(elf64_phdr.p_paddr, "elf64_phdr", "p_paddr");
>   	OFFSET_INIT(elf64_phdr.p_memsz, "elf64_phdr", "p_memsz");
>
> -	SIZE_INIT(log, "log");
> -	OFFSET_INIT(log.ts_nsec, "log", "ts_nsec");
> -	OFFSET_INIT(log.len, "log", "len");
> -	OFFSET_INIT(log.text_len, "log", "text_len");
> +	SIZE_INIT(printk_log, "printk_log");
> +	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
> +		OFFSET_INIT(printk_log.ts_nsec, "printk_log", "ts_nsec");
> +		OFFSET_INIT(printk_log.len, "printk_log", "len");
> +		OFFSET_INIT(printk_log.text_len, "printk_log", "text_len");
> +	} else {
> +		SIZE_INIT(printk_log, "log");
> +		OFFSET_INIT(printk_log.ts_nsec, "log", "ts_nsec");
> +		OFFSET_INIT(printk_log.len, "log", "len");
> +		OFFSET_INIT(printk_log.text_len, "log", "text_len");
> +	}
>
>   	return TRUE;
>   }
> @@ -1593,7 +1600,8 @@ write_vmcoreinfo_data(void)
>   	WRITE_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
>   	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
>   	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
> -	WRITE_STRUCTURE_SIZE("log", log);
> +	WRITE_STRUCTURE_SIZE("printk_log", printk_log);
> +	WRITE_STRUCTURE_SIZE("log", printk_log); /* compat */

To export the size of struct printk_log as the size of struct log
for old makedumpfile doesn't provide compatibility, because old
makedumpfile can't extract dmesg after all since the variable-length
record format isn't supported. (except makedumpfile-1.5.2, 1.5.3 and 1.5.4)
The compatibility you said is only for those versions, so that's
incomplete and not acceptable.

I think ether log or printk_log should be written based on the original
symbol name, to write both is redundant and confusing in many cases.

>   	/*
>   	 * write the member offset of 1st kernel
> @@ -1628,9 +1636,13 @@ write_vmcoreinfo_data(void)
>   	WRITE_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>   	WRITE_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
>   	WRITE_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
> -	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
> -	WRITE_MEMBER_OFFSET("log.len", log.len);
> -	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
> +	WRITE_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
> +	WRITE_MEMBER_OFFSET("printk_log.len", printk_log.len);
> +	WRITE_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +	/* Compatibility with pre-3.11-rc4 */
> +	WRITE_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> +	WRITE_MEMBER_OFFSET("log.len", printk_log.len);
> +	WRITE_MEMBER_OFFSET("log.text_len", printk_log.text_len);

The same as above can be said.


Thanks
Atsushi Kumagai

>   	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
>   		WRITE_ARRAY_LENGTH("node_data", node_data);
> @@ -1909,7 +1921,6 @@ read_vmcoreinfo(void)
>   	READ_STRUCTURE_SIZE("node_memblk_s", node_memblk_s);
>   	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
>   	READ_STRUCTURE_SIZE("pageflags", pageflags);
> -	READ_STRUCTURE_SIZE("log", log);
>
>   	READ_MEMBER_OFFSET("page.flags", page.flags);
>   	READ_MEMBER_OFFSET("page._count", page._count);
> @@ -1940,9 +1951,18 @@ read_vmcoreinfo(void)
>   	READ_MEMBER_OFFSET("vm_struct.addr", vm_struct.addr);
>   	READ_MEMBER_OFFSET("vmap_area.va_start", vmap_area.va_start);
>   	READ_MEMBER_OFFSET("vmap_area.list", vmap_area.list);
> -	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
> -	READ_MEMBER_OFFSET("log.len", log.len);
> -	READ_MEMBER_OFFSET("log.text_len", log.text_len);
> +
> +	READ_STRUCTURE_SIZE("printk_log", printk_log);
> +	if (SIZE(printk_log) != NOT_FOUND_STRUCTURE) {
> +		READ_MEMBER_OFFSET("printk_log.ts_nsec", printk_log.ts_nsec);
> +		READ_MEMBER_OFFSET("printk_log.len", printk_log.len);
> +		READ_MEMBER_OFFSET("printk_log.text_len", printk_log.text_len);
> +	} else {
> +		READ_STRUCTURE_SIZE("log", printk_log);
> +		READ_MEMBER_OFFSET("log.ts_nsec", printk_log.ts_nsec);
> +		READ_MEMBER_OFFSET("log.len", printk_log.len);
> +		READ_MEMBER_OFFSET("log.text_len", printk_log.text_len);
> +	}
>
>   	READ_ARRAY_LENGTH("node_data", node_data);
>   	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
> @@ -3705,13 +3725,13 @@ dump_log_entry(char *logptr, int fp)
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
> @@ -3749,7 +3769,7 @@ log_from_idx(unsigned int idx, char *logbuf)
>   	 * the buffer.
>   	 */
>
> -	msglen = USHORT(logptr + OFFSET(log.len));
> +	msglen = USHORT(logptr + OFFSET(printk_log.len));
>   	if (!msglen)
>   		logptr = logbuf;
>
> @@ -3770,9 +3790,9 @@ log_next(unsigned int idx, char *logbuf)
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
> index a5826e0..5b96c11 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1198,7 +1198,7 @@ struct size_table {
>   	long	cpumask_t;
>   	long	kexec_segment;
>   	long	elf64_hdr;
> -	long	log;
> +	long	printk_log;
>
>   	long	pageflags;
>   };
> @@ -1337,11 +1337,11 @@ struct offset_table {
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

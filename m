Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410057.outbound.protection.outlook.com
 ([40.107.141.57] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltnRY-009VNN-20
 for kexec@lists.infradead.org; Thu, 17 Jun 2021 08:32:11 +0000
From: =?iso-2022-jp?B?SEFHSU8gS0FaVUhJVE8oGyRCR2tIeCEhMGw/ThsoQik=?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH makedumpfile] Add -L option to limit output file size
Date: Thu, 17 Jun 2021 08:32:01 +0000
Message-ID: <TYYPR01MB677714EF5E33BBDBF4F0918BDD0E9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210610082446.131057-1-bpoirier@nvidia.com>
In-Reply-To: <20210610082446.131057-1-bpoirier@nvidia.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Benjamin Poirier <bpoirier@nvidia.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> This option can be used to ensure that a certain amount of free space is
> preserved. It is useful when the output of makedumpfile is on the root
> filesystem and some services fail to start at boot if there is no space
> left.

Thanks for the patch, the option seems nice!
Some comments inline.

> 
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
> ---
>  makedumpfile.8 | 12 +++++++++---
>  makedumpfile.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
>  makedumpfile.h |  2 ++
>  print_info.c   |  3 +++
>  4 files changed, 58 insertions(+), 9 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 313a41c..9a90f0e 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -157,9 +157,10 @@ will be effective if you specify domain-0's \fIvmlinux\fR with \-x option.
>  Then the pages are excluded only from domain-0.
>  .br
>  If specifying multiple dump_levels with the delimiter ',', makedumpfile retries
> -to create a \fIDUMPFILE\fR by other dump_level when "No space on device" error
> -happens. For example, if dump_level is "11,31" and makedumpfile fails
> -by dump_level 11, makedumpfile retries it by dump_level 31.
> +to create \fIDUMPFILE\fR using the next dump_level when the size of a dumpfile
> +exceeds the limit specified with '-L' or when when a "No space on device" error
> +happens. For example, if dump_level is "11,31" and makedumpfile fails with
> +dump_level 11, makedumpfile retries with dump_level 31.
>  .br
>  .B Example:
>  .br
> @@ -221,6 +222,11 @@ Here is the all combinations of the bits.
>      30 |      |   X   |   X   |  X   |  X
>      31 |  X   |   X   |   X   |  X   |  X
> 
> +.TP
> +\fB\-L\fR \fISIZE\fR
> +Limit the size of the output file to \fISIZE\fR bytes. An incomplete
> +\fIDUMPFILE\fR or \fILOGFILE\fR is written if the size would otherwise exceed
> +\fISIZE\fR.
> 
>  .TP
>  \fB\-E\fR
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 894c88e..8a443c6 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -22,6 +22,8 @@
>  #include "cache.h"
>  #include <stddef.h>
>  #include <ctype.h>
> +#include <signal.h>
> +#include <sys/resource.h>
>  #include <sys/time.h>
>  #include <limits.h>
>  #include <assert.h>
> @@ -1383,6 +1385,28 @@ open_dump_file(void)
>  		return FALSE;
>  	}
>  	info->fd_dumpfile = fd;
> +
> +	if (info->size_limit != -1) {
> +		struct sigaction act = {
> +			.sa_handler = SIG_IGN,
> +		};
> +		struct rlimit rlim = {
> +			.rlim_cur = info->size_limit,
> +			.rlim_max = info->size_limit,
> +		};
> +
> +		if (sigaction(SIGXFSZ, &act, NULL)) {
> +			ERRMSG("Can't ignore SIGXFSZ. %s\n", strerror(errno));
> +			return FALSE;
> +		}
> +
> +		if (setrlimit(RLIMIT_FSIZE, &rlim)) {
> +			ERRMSG("Can't set file size limit(%lld). %s\n",
> +			       (long long) info->size_limit, strerror(errno));
> +			return FALSE;
> +		}
> +	}
> +
>  	return TRUE;
>  }
> 
> @@ -4729,7 +4753,7 @@ write_and_check_space(int fd, void *buf, size_t buf_size, char *file_name)
>  			written_size += status;
>  			continue;
>  		}
> -		if (errno == ENOSPC)
> +		if (errno == ENOSPC || errno == EFBIG)
>  			info->flag_nospace = TRUE;
>  		MSG("\nCan't write the dump file(%s). %s\n",
>  		    file_name, strerror(errno));
> @@ -5308,7 +5332,7 @@ dump_log_entry(char *logptr, int fp)
>  	for (i = 0, p = msg; i < text_len; i++, p++) {
>  		if (bufp - buf >= sizeof(buf) - buf_need) {
>  			if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
> -				return FALSE;
> +				goto out_fail;
>  			bufp = buf;
>  		}
> 
> @@ -5322,10 +5346,13 @@ dump_log_entry(char *logptr, int fp)
> 
>  	*bufp++ = '\n';
> 
> -	if (write(info->fd_dumpfile, buf, bufp - buf) < 0)
> -		return FALSE;
> -	else
> +	if (write(info->fd_dumpfile, buf, bufp - buf) >= 0)
>  		return TRUE;
> +
> +out_fail:
> +	ERRMSG("\nCan't write the log file(%s). %s\n", info->name_dumpfile,
> +	       strerror(errno));
> +	return FALSE;
>  }

This change in dump_log_entry() looks ok, but the function supports only
Linux 3.5 to 5.9 kernels.  The other kernels are supported by the other
function or path:

dump_dmesg()
...
        if ((SYMBOL(prb) != NOT_FOUND_SYMBOL))
                return dump_lockless_dmesg();  <<-- 5.10 and newer
...
        if (info->kernel_version < KERNEL_VERSION(3, 5, 0)) {
...
                if (write(info->fd_dumpfile, log_buffer, length_log) < 0) <<-- 3.4 and older
                        goto out;

Could you add support for those kernels? if you need the -L option for
the --dump-dmesg option.

But it seems that write() with RLIMIT_FSIZE returns the rest size to
the limit first, and returns -1 with EFBIG next time.  So a change
might be needed for the write() above.

> 
>  /*
> @@ -11585,6 +11612,7 @@ main(int argc, char *argv[])
>  	}
>  	info->file_vmcoreinfo = NULL;
>  	info->fd_vmlinux = -1;
> +	info->size_limit = -1;
>  	info->fd_xen_syms = -1;
>  	info->fd_memory = -1;
>  	info->fd_dumpfile = -1;
> @@ -11605,9 +11633,11 @@ main(int argc, char *argv[])
> 
>  	info->block_order = DEFAULT_ORDER;
>  	message_level = DEFAULT_MSG_LEVEL;
> -	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lpRvXx:", longopts,
> +	while ((opt = getopt_long(argc, argv, "b:cDd:eEFfg:hi:lL:pRvXx:", longopts,
>  	    NULL)) != -1) {
>  		switch (opt) {
> +			long long val;
> +
>  		case OPT_BLOCK_ORDER:
>  			info->block_order = atoi(optarg);
>  			break;
> @@ -11624,6 +11654,14 @@ main(int argc, char *argv[])
>  			if (!parse_dump_level(optarg))
>  				goto out;
>  			break;
> +		case OPT_SIZE_LIMIT:
> +			val = atoll(optarg);
> +			if (val < 0) {

The atoll() returns 0 if the optarg is an invalid string and "-L 0" is
also meaningless, so I'd prefer (val <= 0) here.

Thanks,
Kazu

> +				MSG("Limit size(%lld) is invalid.\n", val);
> +				goto out;
> +			}
> +			info->size_limit = val;
> +			break;
>  		case OPT_ELF_DUMPFILE:
>  			info->flag_elf_dumpfile = 1;
>  			break;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 79046f2..7357ee7 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1344,6 +1344,7 @@ struct DumpInfo {
>  	int		max_dump_level;      /* maximum dump level */
>  	int		num_dump_level;      /* number of dump level */
>  	int		array_dump_level[NUM_ARRAY_DUMP_LEVEL];
> +	off_t		size_limit;          /* dump file size limit */
>  	int		flag_compress;       /* flag of compression */
>  	int		flag_lzo_support;    /* flag of LZO compression support */
>  	int		flag_elf_dumpfile;   /* flag of creating ELF dumpfile */
> @@ -2458,6 +2459,7 @@ struct elf_prstatus {
>  #define OPT_HELP                'h'
>  #define OPT_READ_VMCOREINFO     'i'
>  #define OPT_COMPRESS_LZO        'l'
> +#define OPT_SIZE_LIMIT          'L'
>  #define OPT_COMPRESS_SNAPPY     'p'
>  #define OPT_REARRANGE           'R'
>  #define OPT_VERSION             'v'
> diff --git a/print_info.c b/print_info.c
> index ad4184e..8b28554 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -144,6 +144,9 @@ print_usage(void)
>  	MSG("        16  |                                    X\n");
>  	MSG("        31  |   X       X        X       X       X\n");
>  	MSG("\n");
> +	MSG("  [-L SIZE]:\n");
> +	MSG("      Limit the size of the output file to SIZE bytes.\n");
> +	MSG("\n");
>  	MSG("  [-E]:\n");
>  	MSG("      Create DUMPFILE in the ELF format.\n");
>  	MSG("      This option cannot be specified with the -c, -l or -p options,\n");
> --
> 2.32.0.rc0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QORAE-0002Mi-Mq
	for kexec@lists.infradead.org; Mon, 23 May 2011 09:11:04 +0000
Subject: Re: [PATCH v2 1/8] makedumpfile: Add '--config' option to specify
	filterconfig file.
Message-Id: <20110523180900tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Mon, 23 May 2011 18:09:00 +0900
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
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hi Mahesh


On 2011/05/18 01:30:07 +0530, Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch adds '--config' option to specify config file that contains filter
> commands to filter out desired kernel data and it's members.
> 
> Updated makedumpfile man page with '--config' option info.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Prerna Saxena <prerna@linux.vnet.ibm.com>
> ---
> 
>  makedumpfile.8 |   20 +++++++++++++++++++-
>  makedumpfile.c |   17 +++++++++++++++++
>  makedumpfile.h |    7 +++++++
>  3 files changed, 43 insertions(+), 1 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 4a0271d..a1aaa3e 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -6,6 +6,8 @@ makedumpfile \- make a small dumpfile of kdump
>  .br
>  \fBmakedumpfile\fR \-F [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR
>  .br
> +\fBmakedumpfile\fR   [\fIOPTION\fR] \-x \fIVMLINUX\fR \-\-config \fIFILTERCONFIGFILE\fR \fIVMCORE\fR \fIDUMPFILE\fR
> +.br
>  \fBmakedumpfile\fR \-R \fIDUMPFILE\fR
>  .br
>  \fBmakedumpfile\fR \-\-split [\fIOPTION\fR] [\-x \fIVMLINUX\fR|\-i \fIVMCOREINFO\fR] \fIVMCORE\fR \fIDUMPFILE1\fR \fI
DUMPFILE2\fR [\fIDUMPFILE3\fR ..]
> @@ -55,6 +57,15 @@ compression support. The ELF format is readable with GDB and the crash utility.
>  If a user wants to use GDB, \fIDUMPFILE\fR format has to be explicitly
>  specified to be the ELF format.
>  .PP
> +Apart from the exclusion of unnecessary pages mentioned above, makedumpfile
> +allows user to filter out targeted kernel data. The filter config file can
> +be used to specify kernel/module symbols and its members that need to be
> +filtered out through the erase command syntax. makedumpfile reads the filter
> +config and builds the list of memory addresses and its sizes after processing
> +filter commands. The memory locations that require to be filtered out are
> +then poisoned with character 'X' (58 in Hex). Refer to \fBfilter.conf(8)\fR
> +for file format.
> +.PP
>  To analyze the first kernel's memory usage, makedumpfile can refer to
>  \fIVMCOREINFO\fR instead of \fIVMLINUX\fR. \fIVMCOREINFO\fR contains the first
>  kernel's information (structure size, field offset, etc.), and \fIVMCOREINFO\fR
> @@ -232,6 +243,13 @@ specified.
>  # makedumpfile \-g vmcoreinfo \-x vmlinux
>  
>  .TP
> +\fB\-\-config\fR \fIFILTERCONFIGFILE\fR
> +Used in conjunction with \-x \fIVMLINUX\fR option, to specify the filter
> +config file \fIFILTERCONFIGFILE\fR that contains erase commands to filter out
> +desired kernel data from vmcore while creating \fIDUMPFILE\fR. For filter
> +command syntax please refer to \fBfilter.conf(8)\fR.
> +
> +.TP
>  \fB\-F\fR
>  Output the dump data in the flattened format to the standard output for
>  transporting the dump data by SSH.
> @@ -482,5 +500,5 @@ Written by Masaki Tachibana, and Ken'ichi Ohmichi.
>  
>  .SH SEE ALSO
>  .PP
> -crash(8), gdb(1), kexec(8)
> +crash(8), gdb(1), kexec(8), filter.conf(8)
>  
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7d0c663..f136eba 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -636,6 +636,11 @@ print_usage(void)
>  	MSG("  Creating DUMPFILE:\n");
>  	MSG("  # makedumpfile    [-c|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE DUMPFILE\n");
>  	MSG("\n");
> +	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
> +	MSG("  file:\n");
> +	MSG("  # makedumpfile    [-c|-E] [-d DL] -x VMLINUX --config FILTERCONFIGFILE VMCORE\n");
> +	MSG("    DUMPFILE\n");
> +	MSG("\n");
>  	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
>  	MSG("  # makedumpfile -F [-c|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
>  	MSG("\n");
> @@ -714,6 +719,11 @@ print_usage(void)
>  	MSG("      other system that is running the same first kernel. [-x VMLINUX] must\n");
>  	MSG("      be specified.\n");
>  	MSG("\n");
> +	MSG("  [--config FILTERCONFIGFILE]:\n");
> +	MSG("      Used in conjunction with -x VMLINUX option, to specify the filter config\n");
> +	MSG("      file that contains filter commands to filter out desired kernel data\n");
> +	MSG("      from vmcore while creating DUMPFILE.\n");
> +	MSG("\n");
>  	MSG("  [-F]:\n");
>  	MSG("      Output the dump data in the flattened format to the standard output\n");
>  	MSG("      for transporting the dump data by SSH.\n");
> @@ -7729,6 +7739,9 @@ check_param_for_creating_dumpfile(int argc, char *argv[])
>  	if (info->flag_flatten && info->flag_split)
>  		return FALSE;
>  


> +	if (info->name_filterconfig && !info->name_vmlinux)
> +		return FALSE;

A new option '--config makedumpfile.conf' always needs an option 
'-x debug_info_file', doesn't it?
Once I heard that a debug_info file(i.e. vmlinux) was too large 
to be included in 2nd kernel's initrd.
So instead of a debug_info_file, small text files generated by 
'-g debug_info_file' were introduced.
Now a debug information is read from /proc/vmcore.
Do you want to use '--config' while 2nd kernel is running?
But I think it's impossible on usual distributers' environment, because
vmlinux is not included in 2nd kernel's initrd.
So I suppose you use this option as follows:
1.Panic occurs.
2.2nd kernel is activated.
3.makedumpfile makes a dump file from /proc/vmcore without '--config'.
4.1st kernel is reactivated.
5.makedumpfile makes a masked dump file from the above dump file 
  with '--config'.

Am I right?


Thanks
tachibana


> +
>  	if ((argc == optind + 2) && !info->flag_flatten
>  				 && !info->flag_split) {
>  		/*
> @@ -7821,6 +7834,7 @@ static struct option longopts[] = {
>  	{"message-level", required_argument, NULL, 'm'},
>  	{"vtop", required_argument, NULL, 'V'},
>  	{"dump-dmesg", no_argument, NULL, 'M'}, 
> +	{"config", required_argument, NULL, 'C'},
>  	{"help", no_argument, NULL, 'h'},
>  	{0, 0, 0, 0}
>  };
> @@ -7851,6 +7865,9 @@ main(int argc, char *argv[])
>  		case 'b':
>  			info->block_order = atoi(optarg);
>  			break;
> +		case 'C':
> +			info->name_filterconfig = optarg;
> +			break;
>  		case 'c':
>  			info->flag_compress = 1;
>  			break;
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 4ec77b7..e037f12 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -888,6 +888,13 @@ struct DumpInfo {
>  	unsigned long	vmemmap_end;
>  
>  	/*
> +	 * Filter config file containing filter commands to filter out kernel
> +	 * data from vmcore.
> +	 */
> +	char		*name_filterconfig;
> +	FILE		*file_filterconfig;
> +
> +	/*
>  	 * diskdimp info:
>  	 */
>  	int		block_order;
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

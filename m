Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UpEDs-0004jQ-5o
 for kexec@lists.infradead.org; Wed, 19 Jun 2013 08:58:37 +0000
Message-ID: <51C17292.50107@redhat.com>
Date: Wed, 19 Jun 2013 16:57:54 +0800
From: Baoquan He <bhe@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: add missing options to man page or help
References: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
In-Reply-To: <fc047066a6f5ba18f02838f4b3e89006917db4a5.1371632010.git.bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

This patch is based on devel branch.

Baoquan
Thanks a lot

On 06/19/2013 04:55 PM, Baoquan He wrote:
> makedumpfile has some options which has two 2 forms, long option
> and short option. E.g. --help  |  -h
> 
> In man page and help, only one of them are presented, user may complain
> of this. Here add missing options.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  makedumpfile.8 | 28 ++++++++++++++--------------
>  print_info.c   | 28 ++++++++++++++--------------
>  2 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index 61bd5f2..9c507d9 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -267,14 +267,14 @@ specified.
>  # makedumpfile \-g vmcoreinfo \-x vmlinux
>  
>  .TP
> -\fB\-\-config\fR \fIFILTERCONFIGFILE\fR
> +\fB\-C (\-\-config)\fR \fIFILTERCONFIGFILE\fR
>  Used in conjunction with \-x \fIVMLINUX\fR option, to specify the filter
>  config file \fIFILTERCONFIGFILE\fR that contains erase commands to filter out
>  desired kernel data from vmcore while creating \fIDUMPFILE\fR. For filter
>  command syntax please refer to \fBmakedumpfile.conf(5)\fR.
>  
>  .TP
> -\fB\-\-eppic\fR \fIEPPICMACRO\fR
> +\fB\-S (\-\-eppic)\fR \fIEPPICMACRO\fR
>  Used in conjunction with \-x \fIVMLINUX\fR option, to specify the eppic macro
>  file that contains filter rules or directory that contains eppic macro
>  files to filter out desired kernel data from vmcore while creating \fIDUMPFILE\fR.
> @@ -341,7 +341,7 @@ host by running this script.
>  | ssh user@host "makedumpfile\-R.pl dumpfile"
>  
>  .TP
> -\fB\-\-split\fR
> +\fB\-s (\-\-split)\fR
>  Split the dump data to multiple \fIDUMPFILE\fRs in parallel. If specifying
>  \fIDUMPFILE\fRs on different storage devices, a device can share I/O load
>  with other devices and it reduces time for saving the dump data. The file
> @@ -354,7 +354,7 @@ the kdump\-compressed format.
>  # makedumpfile \-\-split \-d 31 \-x vmlinux /proc/vmcore dumpfile1 dumpfile2
>  
>  .TP
> -\fB\-\-reassemble\fR
> +\fB\-r (\-\-reassemble)\fR
>  Reassemble multiple \fIDUMPFILE\fRs, which are created by \-\-split option,
>  into one \fIDUMPFILE\fR. dumpfile1 and dumpfile2 are reassembled into dumpfile
>  on the following example.
> @@ -369,7 +369,7 @@ Cache 2^order pages in ram when generating \fIDUMPFILE\fR before writing to outp
>  The default value is 4.
>  
>  .TP
> -\fB\-\-cyclic\-buffer\fR \fIbuffer_size\fR
> +\fB\-Z (\-\-cyclic\-buffer)\fR \fIbuffer_size\fR
>  Specify the buffer size in kilo bytes for analysis in the cyclic mode.
>  Actually, the double of \fIbuffer_size\fR kilo bytes will be allocated in memory.
>  In the cyclic mode, the number of cycles is represented as:
> @@ -386,7 +386,7 @@ size, so ordinary users don't need to specify this option.
>  # makedumpfile \-\-cyclic\-buffer 1024 \-d 31 \-x vmlinux /proc/vmcore dumpfile
>  
>  .TP
> -\fB\-\-non\-cyclic\fR
> +\fB\-Y (\-\-non\-cyclic)\fR
>  Running in the non-cyclic mode, this mode uses the old filtering logic same as v1.4.4 or before.
>  If you feel the cyclic mode is too slow, please try this mode.
>  .br
> @@ -395,7 +395,7 @@ If you feel the cyclic mode is too slow, please try this mode.
>  # makedumpfile \-\-non\-cyclic \-d 31 \-x vmlinux /proc/vmcore dumpfile
>  
>  .TP
> -\fB\-\-xen-syms\fR \fIXEN-SYMS\fR
> +\fB\-y (\-\-xen-syms)\fR \fIXEN-SYMS\fR
>  Specify the \fIXEN-SYMS\fR with debug information to analyze the xen's memory usage.
>  This option extracts the part of xen and domain-0.
>  \-E option must be specified with this option.
> @@ -405,7 +405,7 @@ This option extracts the part of xen and domain-0.
>  # makedumpfile \-E \-\-xen-syms xen-syms /proc/vmcore dumpfile
>  
>  .TP
> -\fB\-\-xen-vmcoreinfo\fR \fIVMCOREINFO\fR
> +\fB\-z (\-\-xen-vmcoreinfo)\fR \fIVMCOREINFO\fR
>  Specify \fIVMCOREINFO\fR instead of \fIXEN-SYMS\fR for analyzing the xen's memory usage.
>  .br
>  \fIVMCOREINFO\fR should be made beforehand by makedumpfile with \-g option, and
> @@ -428,7 +428,7 @@ not necessary to specify \fI\-\-xen-syms\fR and \fI\-\-xen-vmcoreinfo\fR.
>  # makedumpfile \-E \-X /proc/vmcore dumpfile
>  
>  .TP
> -\fB\-\-xen_phys_start\fR \fIxen_phys_start_address\fR
> +\fB\-P (\-\-xen_phys_start)\fR \fIxen_phys_start_address\fR
>  This option is only for x86_64.
>  Specify the \fIxen_phys_start_address\fR, if the xen code/data is relocatable
>  and \fIVMCORE\fR does not contain \fIxen_phys_start_address\fR in the CRASHINFO.
> @@ -448,7 +448,7 @@ if /proc/iomem is the following:
>  # makedumpfile \-E \-X \-\-xen_phys_start 0xcee00000 /proc/vmcore dumpfile
>  
>  .TP
> -\fB\-\-message-level\fR \fImessage_level\fR
> +\fB\-m (\-\-message-level)\fR \fImessage_level\fR
>  Specify the message types.
>  .br
>  Users can restrict outputs printed by specifying \fImessage_level\fR
> @@ -497,7 +497,7 @@ value of \fImessage_level\fR is 31.
>        31 |    X     |    X    |    X    |    X    |    X
>  
>  .TP
> -\fB\-\-vtop\fR \fIvirtual_address\fR
> +\fB\-V (\-\-vtop)\fR \fIvirtual_address\fR
>  This option is useful, when user debugs the translation problem
>  of virtual address. If specifing \fIvirtual_address\fR, its physical
>  address is printed. It makes debugging easy by comparing the
> @@ -507,7 +507,7 @@ crash utility.
>  not affect the dumpfile creation.
>  
>  .TP
> -\fB\-\-dump-dmesg\fR
> +\fB\-M (\-\-dump-dmesg)\fR
>  This option overrides the normal behavior of makedumpfile.  Instead of
>  compressing and filtering a \fIVMCORE\fR to make it smaller, it simply
>  extracts the dmesg log from a \fIVMCORE\fR and writes it to the specified
> @@ -523,7 +523,7 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
>  .br
>  
>  .TP
> -\fB\-\-diskset=VMCORE\fR
> +\fB\-k (\-\-diskset)=VMCORE\fR
>  Specify multiple \fIVMCORE\fRs created on sadump diskset configuration
>  the same number of times as the number of \fIVMCORE\fRs in increasing
>  order from left to right.  \fIVMCORE\fRs are assembled into a single
> @@ -539,7 +539,7 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
>  Print debugging message.
>  
>  .TP
> -\fB\-h\fR
> +\fB\-h (\-\-help)\fR
>  Show help message and LZO/snappy support status (enabled/disabled).
>  
>  .TP
> diff --git a/print_info.c b/print_info.c
> index 06939e0..404e1c5 100644
> --- a/print_info.c
> +++ b/print_info.c
> @@ -140,12 +140,12 @@ print_usage(void)
>  	MSG("      other system that is running the same first kernel. [-x VMLINUX] must\n");
>  	MSG("      be specified.\n");
>  	MSG("\n");
> -	MSG("  [--config FILTERCONFIGFILE]:\n");
> +	MSG("  [-C|--config FILTERCONFIGFILE]:\n");
>  	MSG("      Used in conjunction with -x VMLINUX option, to specify the filter config\n");
>  	MSG("      file that contains filter commands to filter out desired kernel data\n");
>  	MSG("      from vmcore while creating DUMPFILE.\n");
>  	MSG("\n");
> -	MSG("  [--eppic EPPICMACRO]:\n");
> +	MSG("  [-S|--eppic EPPICMACRO]:\n");
>  	MSG("      Used in conjunction with -x VMLINUX option, to specify the eppic macro\n");
>  	MSG("      file that contains filter rules or directory that contains eppic macro\n");
>  	MSG("      files to filter out desired kernel data from vmcore while creating DUMPFILE.\n");
> @@ -163,7 +163,7 @@ print_usage(void)
>  	MSG("      Rearrange the dump data in the flattened format from the standard input\n");
>  	MSG("      to a readable DUMPFILE.\n");
>  	MSG("\n");
> -	MSG("  [--split]:\n");
> +	MSG("  [-s|--split]:\n");
>  	MSG("      Split the dump data to multiple DUMPFILEs in parallel. If specifying\n");
>  	MSG("      DUMPFILEs on different storage devices, a device can share I/O load with\n");
>  	MSG("      other devices and it reduces time for saving the dump data. The file size\n");
> @@ -171,7 +171,7 @@ print_usage(void)
>  	MSG("      by the number of DUMPFILEs.\n");
>  	MSG("      This feature supports only the kdump-compressed format.\n");
>  	MSG("\n");
> -	MSG("  [--reassemble]:\n");
> +	MSG("  [-r|--reassemble]:\n");
>  	MSG("      Reassemble multiple DUMPFILEs, which are created by --split option,\n");
>  	MSG("      into one DUMPFILE. dumpfile1 and dumpfile2 are reassembled into dumpfile.\n");
>  	MSG("\n");
> @@ -179,7 +179,7 @@ print_usage(void)
>  	MSG("      Specify the cache 2^order pages in ram when generating DUMPFILE before\n");
>  	MSG("      writing to output. The default value is 4.\n");
>  	MSG("\n");
> -	MSG("  [--cyclic-buffer BUFFER_SIZE]:\n");
> +	MSG("  [-Z|--cyclic-buffer BUFFER_SIZE]:\n");
>  	MSG("      Specify the buffer size in kilo bytes for analysis in the cyclic mode.\n");
>  	MSG("      Actually, the double of BUFFER_SIZE kilo bytes will be allocated in memory.\n");
>  	MSG("      In the cyclic mode, the number of cycles is represented as:\n");
> @@ -191,18 +191,18 @@ print_usage(void)
>  	MSG("      By default, BUFFER_SIZE will be calculated automatically depending on\n");
>  	MSG("      system memory size, so ordinary users don't need to specify this option.\n");
>  	MSG("\n");
> -	MSG("  [--non-cyclic]:\n");
> +	MSG("  [-Y|--non-cyclic]:\n");
>  	MSG("      Running in the non-cyclic mode, this mode uses the old filtering logic\n");
>  	MSG("      same as v1.4.4 or before.\n");
>  	MSG("      If you feel the cyclic mode is too slow, please try this mode.\n");
>  	MSG("\n");
> -	MSG("  [--xen-syms XEN-SYMS]:\n");
> +	MSG("  [-y|--xen-syms XEN-SYMS]:\n");
>  	MSG("      Specify the XEN-SYMS to analyze Xen's memory usage.\n");
>  	MSG("\n");
> -	MSG("  [--xen-vmcoreinfo VMCOREINFO]:\n");
> +	MSG("  [-z|--xen-vmcoreinfo VMCOREINFO]:\n");
>  	MSG("      Specify the VMCOREINFO of Xen to analyze Xen's memory usage.\n");
>  	MSG("\n");
> -	MSG("  [--xen_phys_start XEN_PHYS_START_ADDRESS]:\n");
> +	MSG("  [-P|--xen_phys_start XEN_PHYS_START_ADDRESS]:\n");
>  	MSG("      This option is only for x86_64.\n");
>  	MSG("      Specify the XEN_PHYS_START_ADDRESS, if the xen code/data is relocatable\n");
>  	MSG("      and VMCORE does not contain XEN_PHYS_START_ADDRESS in the CRASHINFO.\n");
> @@ -211,12 +211,12 @@ print_usage(void)
>  	MSG("      Exclude all the user domain pages from Xen kdump's VMCORE, and extract\n");
>  	MSG("      the part of Xen and domain-0.\n");
>  	MSG("\n");
> -	MSG("  [--diskset=VMCORE]:\n");
> +	MSG("  [-k|--diskset=VMCORE]:\n");
>  	MSG("      Specify multiple VMCOREs created on sadump diskset configuration the same\n");
>  	MSG("      number of times as the number of VMCOREs in increasing order from left to\n");
>  	MSG("      right.\n");
>  	MSG("\n");
> -	MSG("  [--message-level ML]:\n");
> +	MSG("  [-m|--message-level ML]:\n");
>  	MSG("      Specify the message types.\n");
>  	MSG("      Users can restrict output printed by specifying Message_Level (ML) with\n");
>  	MSG("      this option. The message type marked with an X in the following table is\n");
> @@ -237,12 +237,12 @@ print_usage(void)
>  	MSG("           16 |                                              X\n");
>  	MSG("           31 |     X          X         X         X         X\n");
>  	MSG("\n");
> -	MSG("  [--vtop VIRTUAL_ADDRESS]:\n");
> +	MSG("  [-V|--vtop VIRTUAL_ADDRESS]:\n");
>  	MSG("      This option is useful, when user debugs the translation problem\n");
>  	MSG("      of virtual address. If specifing the VIRTUAL_ADDRESS, its physical\n");
>  	MSG("      address is printed.\n");
>  	MSG("\n");
> -	MSG("  [--dump-dmesg]:\n");
> +	MSG("  [-M|--dump-dmesg]:\n");
>  	MSG("      This option overrides the normal behavior of makedumpfile. Instead of\n");
>  	MSG("      compressing and filtering a VMCORE to make it smaller, it simply\n");
>  	MSG("      extracts the dmesg log from a VMCORE and writes it to the specified\n");
> @@ -255,7 +255,7 @@ print_usage(void)
>  	MSG("  [-f]:\n");
>  	MSG("      Overwrite DUMPFILE even if it already exists.\n");
>  	MSG("\n");
> -	MSG("  [-h]:\n");
> +	MSG("  [-h|--help]:\n");
>  	MSG("      Show help message and LZO/snappy support status (enabled/disabled).\n");
>  	MSG("\n");
>  	MSG("  [-v]:\n");
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

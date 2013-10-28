Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vaarj-00088e-36
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 00:39:31 +0000
Date: Mon, 28 Oct 2013 09:39:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 2/4] remove extra acpi_rsdp command line for efi
Message-ID: <20131028003908.GH849@verge.net.au>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027041231.024036396@dhcp-16-126.nay.redhat.com>
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
To: dyoung@redhat.com
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, James.Bottomley@HansenPartnership.com, kexec@lists.fedoraproject.org, ebiederm@xmission.com, hpa@zytor.com, bp@alien8.de, vgoyal@redhat.com

On Sun, Oct 27, 2013 at 12:04:39PM +0800, dyoung@redhat.com wrote:
> Removing code to pass acpi_rsdp because this
> patch series will support efi runtime, it's not
> necessary any more. EFI initialization code will
> take the functionality.

I wonder if it would make more sense to make this the
last patch in the series or squash it into the last patch
of the series.

> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  include/x86/x86-linux.h           |    3 ++-
>  kexec/arch/i386/crashdump-x86.c   |   35 -----------------------------------
>  kexec/arch/i386/x86-linux-setup.c |    8 ++++++++
>  3 files changed, 10 insertions(+), 36 deletions(-)
> 
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c
> @@ -848,40 +848,6 @@ static int cmdline_add_memmap_acpi(char
>  	return 0;
>  }
>  
> -/* Appends 'acpi_rsdp=' commandline for efi boot crash dump */
> -static void cmdline_add_efi(char *cmdline)
> -{
> -	FILE *fp;
> -	int cmdlen, len;
> -	char line[MAX_LINE], *s;
> -	const char *acpis = " acpi_rsdp=";
> -
> -	fp = fopen("/sys/firmware/efi/systab", "r");
> -	if (!fp)
> -		return;
> -
> -	while(fgets(line, sizeof(line), fp) != 0) {
> -		/* ACPI20= always goes before ACPI= */
> -		if ((strstr(line, "ACPI20=")) || (strstr(line, "ACPI="))) {
> -		        line[strlen(line) - 1] = '\0';
> -			s = strchr(line, '=');
> -			s += 1;
> -			len = strlen(s) + strlen(acpis);
> -			cmdlen = strlen(cmdline) + len;
> -			if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -				die("Command line overflow\n");
> -			strcat(cmdline, acpis);
> -			strcat(cmdline, s);
> -			dbgprintf("Command line after adding efi\n");
> -			dbgprintf("%s\n", cmdline);
> -
> -			break;
> -		}
> -	}
> -
> -	fclose(fp);
> -}
> -
>  static void get_backup_area(struct kexec_info *info,
>  				struct memory_range *range, int ranges)
>  {
> @@ -1046,7 +1012,6 @@ int load_crashdump_segments(struct kexec
>  	if (delete_memmap(memmap_p, elfcorehdr, memsz) < 0)
>  		return -1;
>  	cmdline_add_memmap(mod_cmdline, memmap_p);
> -	cmdline_add_efi(mod_cmdline);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
>  
>  	/* Inform second kernel about the presence of ACPI tables. */
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

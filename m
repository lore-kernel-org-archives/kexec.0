Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VaaqA-00086N-JT
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 00:37:55 +0000
Date: Mon, 28 Oct 2013 09:37:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 4/4] Passing efi related data via setup_data
Message-ID: <20131028003726.GF849@verge.net.au>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027041231.350640917@dhcp-16-126.nay.redhat.com>
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

On Sun, Oct 27, 2013 at 12:04:41PM +0800, dyoung@redhat.com wrote:
> For supporting efi runtime, several efi physical addresses
> fw_vendor, runtime, config tables, smbios and the whole runtime
> mapping info need to be used in kexec kernel. Thus introduce
> setup_data struct for passing these data.
> 
> collect the varialbes from /sys/firmware/efi/systab and
> /sys/firmware/efi/efi-runtime-map
> 
> Tested on qemu+ovmf, dell laptop, lenovo laptop and HP workstation.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  include/x86/x86-linux.h           |    2 
>  kexec/arch/i386/x86-linux-setup.c |  120 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 120 insertions(+), 2 deletions(-)
> 
> --- kexec-tools.orig/include/x86/x86-linux.h
> +++ kexec-tools/include/x86/x86-linux.h
> @@ -115,7 +115,7 @@ struct x86_linux_param_header {
>  	uint32_t ext_ramdisk_image;		/* 0xc0 */
>  	uint32_t ext_ramdisk_size;		/* 0xc4 */
>  	uint32_t ext_cmd_line_ptr;		/* 0xc8 */
> -	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xcc */
> +	uint8_t reserved4_1[0x1c0 - 0xcc];	/* 0xe4 */
>  	uint8_t efi_info[32];			/* 0x1c0 */
>  	uint32_t alt_mem_k;			/* 0x1e0 */
>  	uint8_t  reserved5[4];			/* 0x1e4 */
> --- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
> +++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
> @@ -473,6 +473,124 @@ void setup_efi_info(struct x86_linux_par
>  	get_bootparam(&real_mode->efi_info, offset, 32);
>  }
>  
> +struct efi_mem_descriptor {
> +        uint32_t type;
> +        uint32_t pad;
> +        uint64_t phys_addr;
> +        uint64_t virt_addr;
> +        uint64_t num_pages;
> +        uint64_t attribute;
> +};
> +
> +struct efi_setup_data {
> +        uint64_t fw_vendor;
> +        uint64_t runtime;
> +        uint64_t tables;
> +        uint64_t smbios;
> +        uint64_t reserved[8];
> +        struct efi_mem_descriptor map[0];
> +};
> +
> +struct setup_data {
> +        __uint64_t next;
> +        __u32 type;
> +        __u32 len;
> +        __u8 data[0];
> +}__attribute__ ((packed));
> +
> +static void _get_efi_value(char *line, const char *pattern, __uint64_t *val)
> +{
> +	char *s, *end;
> +	s = strstr(line, pattern);
> +	if (s)
> +		*val = strtoull(s + strlen(pattern), &end, 16);
> +}
> +
> +static void get_efi_value(struct efi_setup_data *esd)
> +{
> +	FILE *fp;
> +	char line[1024];
> +
> +	fp = fopen("/sys/firmware/efi/systab", "r");
> +	if (!fp)
> +		return;
> +
> +	while(fgets(line, sizeof(line), fp) != 0) {
> +		_get_efi_value(line, "fw_vendor=0x", &esd->fw_vendor);
> +		_get_efi_value(line, "runtime=0x", &esd->runtime);
> +		_get_efi_value(line, "config_tables=0x", &esd->tables);
> +		_get_efi_value(line, "SMBIOS=0x", &esd->smbios);
> +	}
> +
> +	fclose(fp);
> +}
> +
> +static int get_efi_runtime_map(struct efi_setup_data **esd)
> +{
> +	DIR * dirp;
> +	struct dirent * entry;
> +	char filename[1024];
> +	struct efi_mem_descriptor md;
> +	int nr_maps = 0;
> +
> +	dirp = opendir("/sys/firmware/efi/efi-runtime-map");
> +	while ((entry = readdir(dirp)) != NULL) {
> +		sprintf(filename, "/sys/firmware/efi/efi-runtime-map/%s", (char *)entry->d_name);
> +		if (*entry->d_name == '.' )
> +			continue;
> +		file_scanf(filename, "type", "0x%x", (unsigned int *)&md.type);
> +		file_scanf(filename, "phys_addr", "0x%llx", (unsigned long long *)&md.phys_addr);
> +		file_scanf(filename, "virt_addr", "0x%llx", (unsigned long long *)&md.virt_addr);
> +		file_scanf(filename, "num_pages", "0x%llx", (unsigned long long *)&md.num_pages);
> +		file_scanf(filename, "attribute", "0x%llx", (unsigned long long *)&md.attribute);
> +		*esd = realloc(*esd, sizeof(struct efi_setup_data) + (nr_maps + 1) * sizeof(struct efi_mem_descriptor));
> +		*((*esd)->map + nr_maps) = md;
> +		nr_maps++;
> +	}
> +
> +	closedir(dirp);
> +	return nr_maps;
> +}
> +
> +static void setup_efi_setup_data(struct kexec_info *info,
> +			struct x86_linux_param_header *real_mode)
> +{
> +	int nr_maps;
> +	int64_t setup_data_paddr;
> +	struct setup_data *sd;
> +	struct efi_setup_data *esd;
> +	int size, sdsize;
> +	int has_efi = 0;

The indentation of the line below is inconsistent with the line above.

> +
> +        has_efi = access("/sys/firmware/efi/systab", F_OK);
> +        if (has_efi < 0)
> +                return;
> +
> +	esd = malloc(sizeof(struct efi_setup_data));
> +	if (!esd)
> +		return;

This function appears to leak esd.

> +	memset(esd, 0, sizeof(struct efi_setup_data));
> +	get_efi_value(esd);
> +	nr_maps = get_efi_runtime_map(&esd);
> +	size = nr_maps * sizeof(struct efi_mem_descriptor) + sizeof(struct efi_setup_data);
> +	sd = malloc(sizeof(struct setup_data) + size);
> +	if (!sd) {
> +		free(esd);
> +		return;
> +	}

This function appears to leak sd.

> +
> +	memset(sd, 0, sizeof(struct setup_data) + size);
> +	sd->next = 0;
> +	sd->type = 4;
> +	sd->len = size;
> +	memcpy(sd->data, esd, size);
> +	sdsize = sd->len + sizeof(struct setup_data);
> +	setup_data_paddr = add_buffer(info, sd, sdsize, sdsize, getpagesize(), 0x100000, ULONG_MAX, INT_MAX);
> +
> +	real_mode->setup_data = setup_data_paddr;
> +}
> +
> +
>  void setup_linux_system_parameters(struct kexec_info *info,
>  				   struct x86_linux_param_header *real_mode)
>  {
> @@ -483,7 +601,7 @@ void setup_linux_system_parameters(struc
>  	/* get subarch from running kernel */
>  	setup_subarch(real_mode);
>  	setup_efi_info(real_mode);
> -	
> +	setup_efi_setup_data(info, real_mode);
>  	/* Default screen size */
>  	real_mode->orig_x = 0;
>  	real_mode->orig_y = 0;
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

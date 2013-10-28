Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vaaqd-000879-4E
 for kexec@lists.infradead.org; Mon, 28 Oct 2013 00:38:24 +0000
Date: Mon, 28 Oct 2013 09:38:00 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch 1/4] Add function get_bootparam
Message-ID: <20131028003800.GG849@verge.net.au>
References: <20131027040437.600278368@dhcp-16-126.nay.redhat.com>
 <20131027041230.864225266@dhcp-16-126.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20131027041230.864225266@dhcp-16-126.nay.redhat.com>
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
Cc: mjg59@srcf.ucam.org, kexec@lists.infradead.org, vgoyal@redhat.com, James.Bottomley@HansenPartnership.com, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, kexec@lists.fedoraproject.org

On Sun, Oct 27, 2013 at 12:04:38PM +0800, dyoung@redhat.com wrote:
> Not only setup_subarch will get data from debugfs file
> boot_params/data, later code for adding efi_info will
> also need do same thing. Thus add a common function here
> for later use.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kexec/arch/i386/x86-linux-setup.c |   14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> --- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
> +++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
> @@ -436,10 +436,9 @@ char *find_mnt_by_fsname(char *fsname)
>  	return mntdir;
>  }
>  
> -void setup_subarch(struct x86_linux_param_header *real_mode)
> +void get_bootparam(void *buf, off_t offset, size_t size)
>  {
>  	int data_file;
> -	const off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
>  	char *debugfs_mnt;
>  	char filename[PATH_MAX];
>  
> @@ -447,7 +446,7 @@ void setup_subarch(struct x86_linux_para
>  	if (!debugfs_mnt)
>  		return;
>  	snprintf(filename, PATH_MAX, "%s/%s", debugfs_mnt, "boot_params/data");
> -	filename[PATH_MAX-1] = 0;
> +	filename[PATH_MAX - 1] = 0;
>  	free(debugfs_mnt);

This change appears to be unrelated to the rest of the patch.

>  
>  	data_file = open(filename, O_RDONLY);
> @@ -455,11 +454,18 @@ void setup_subarch(struct x86_linux_para
>  		return;
>  	if (lseek(data_file, offset, SEEK_SET) < 0)
>  		goto close;
> -	read(data_file, &real_mode->hardware_subarch, sizeof(uint32_t));
> +	read(data_file, buf, size);
>  close:
>  	close(data_file);
>  }
>  
> +void setup_subarch(struct x86_linux_param_header *real_mode)
> +{
> +	off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
> +
> +	get_bootparam(&real_mode->hardware_subarch, offset, sizeof(uint32_t));
> +}
> +
>  void setup_linux_system_parameters(struct kexec_info *info,
>  				   struct x86_linux_param_header *real_mode)
>  {
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

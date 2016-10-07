Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bsMRS-00014B-V2
 for kexec@lists.infradead.org; Fri, 07 Oct 2016 04:07:27 +0000
Date: Fri, 7 Oct 2016 12:06:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Message-ID: <20161007040657.GB16400@dhcp-128-65.nay.redhat.com>
References: <1475545025-31977-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1475545025-31977-1-git-send-email-maddy@linux.vnet.ibm.com>
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
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 10/04/16 at 07:07am, Madhavan Srinivasan wrote:
> In dt_copy_old_root_param(), FILE * returned
> from fopen is not checked for NULL pointer
> before passinig to fclose(). This could trigger
> a segfault. Patch to fix the same.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
> Changelog v2
> -Removed redundant check fp
> 
> Changelog v1:
> - Moved the check right after fopen
>  
>  kexec/fs2dt.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 6ed2399759cf..79aa0f320a5a 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -524,19 +524,21 @@ static void dt_copy_old_root_param(void)
>  	strcpy(filename, pathname);
>  	strcat(filename, "bootargs");
>  	fp = fopen(filename, "r");
> -	if (fp) {
> -		if (getline(&last_cmdline, &len, fp) == -1)
> -			die("unable to read %s\n", filename);
> -
> -		p = strstr(last_cmdline, "root=");
> -		if (p) {
> -			old_param = strtok(p, " ");
> -			len = strlen(local_cmdline);
> -			if (len != 0)
> -				strcat(local_cmdline, " ");
> -			strcat(local_cmdline, old_param);
> -		}
> +	if (!fp)
> +		return;
> +
> +	if (getline(&last_cmdline, &len, fp) == -1)
> +		die("unable to read %s\n", filename);
> +
> +	p = strstr(last_cmdline, "root=");
> +	if (p) {
> +		old_param = strtok(p, " ");
> +		len = strlen(local_cmdline);
> +		if (len != 0)
> +			strcat(local_cmdline, " ");
> +		strcat(local_cmdline, old_param);
>  	}
> +
>  	if (last_cmdline)
>  		free(last_cmdline);
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

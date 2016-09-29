Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWdm-0007YW-98
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 08:24:28 +0000
Received: by mail-yw0-f169.google.com with SMTP id i129so43438896ywe.2
 for <kexec@lists.infradead.org>; Thu, 29 Sep 2016 01:24:05 -0700 (PDT)
Subject: Re: [PATCH v2] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
References: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <a9c0bc6c-c9df-0ed9-8774-20821a8edf26@redhat.com>
Date: Thu, 29 Sep 2016 13:54:00 +0530
MIME-Version: 1.0
In-Reply-To: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, horms@verge.net.au
Cc: kexec@lists.infradead.org



On Thursday 29 September 2016 01:29 PM, Madhavan Srinivasan wrote:
> In dt_copy_old_root_param(), FILE * returned
> from fopen is not checked for NULL pointer
> before passinig to fclose(). This could trigger
> a segfault. Patch to fix the same.
>
> Reviewed-by: Dave Young <dyoung@redhat.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
> Changelog v1:
>  - Moved the check right after fopen
>
>  kexec/fs2dt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kexec/fs2dt.c b/kexec/fs2dt.c
> index 6ed2399759cf..5ba3ec0fa65c 100644
> --- a/kexec/fs2dt.c
> +++ b/kexec/fs2dt.c
> @@ -524,6 +524,9 @@ static void dt_copy_old_root_param(void)
>  	strcpy(filename, pathname);
>  	strcat(filename, "bootargs");
>  	fp = fopen(filename, "r");
> +	if (!fp)
> +		return;
> +
>  	if (fp) {
>  		if (getline(&last_cmdline, &len, fp) == -1)
>  			die("unable to read %s\n", filename);
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bpWaE-0006jG-9c
 for kexec@lists.infradead.org; Thu, 29 Sep 2016 08:20:46 +0000
Date: Thu, 29 Sep 2016 10:20:20 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec/fs2dt: Check for NULL pointer in
 dt_copy_old_root_param()
Message-ID: <20160929082020.GH14497@verge.net.au>
References: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1475135953-21729-1-git-send-email-maddy@linux.vnet.ibm.com>
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
Cc: panand@redhat.com, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

[CC Dave Young]

On Thu, Sep 29, 2016 at 01:29:13PM +0530, Madhavan Srinivasan wrote:
> In dt_copy_old_root_param(), FILE * returned
> from fopen is not checked for NULL pointer
> before passinig to fclose(). This could trigger
> a segfault. Patch to fix the same.
> 
> Reviewed-by: Dave Young <dyoung@redhat.com>

Probably Dave's tag should be dropped as that was for a somewhat
different (though equally trivial) approach.

> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
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

With the (!fp) conditional above the (fp) conditional below can be removed.

>  	if (fp) {
>  		if (getline(&last_cmdline, &len, fp) == -1)
>  			die("unable to read %s\n", filename);
> -- 
> 2.7.4
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e39.co.us.ibm.com ([32.97.110.160])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOPmh-0002Hz-5Q
 for kexec@lists.infradead.org; Tue, 24 Sep 2013 10:23:59 +0000
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 24 Sep 2013 04:23:33 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 5D9991FF001A
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 04:23:24 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8OANTYh294974
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 04:23:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r8OANT4H015956
 for <kexec@lists.infradead.org>; Tue, 24 Sep 2013 04:23:29 -0600
Message-ID: <524167F4.6030709@in.ibm.com>
Date: Tue, 24 Sep 2013 15:52:44 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc: Add nodes for initrd in dtb
References: <20130924052240.4517.85639.stgit@localhost.localdomain>
In-Reply-To: <20130924052240.4517.85639.stgit@localhost.localdomain>
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
To: Athira Rajeev <atrajeev@in.ibm.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 09/24/2013 10:52 AM, Athira Rajeev wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> If the primary kernel doesn't use an initrd,
> we may not have linux,initrd-* entries in the
> device-tree, and hence the initial flat tree
> may not contain them.
> 
> Make sure we add the entries in the dtb if the
> second kernel needs an initrd.
Simon,

Without this patch, one cannot use an initrd with kexec on a machine
which is booted without an initrd. (e.g, network booted boards.)

Please pull this one.

Thanks
Suzuki

> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
> Signed-off-by: Athira Rajeev<atrajeev@in.ibm.com>
> ---
> 
>  kexec/arch/ppc/fs2dt.c |   18 ++++++++++++++----
>  1 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
> index a49f85e..4121c7d 100644
> --- a/kexec/arch/ppc/fs2dt.c
> +++ b/kexec/arch/ppc/fs2dt.c
> @@ -342,8 +342,17 @@ static void putnode(void)
> 
>  	putprops(dn, namelist, numlist);
> 
> -	/* Add initrd entries to the second kernel */
> -	if (initrd_base && !strcmp(basename, "chosen/")) {
> +	/* 
> +	 * Add initrd entries to the second kernel
> +	 * if
> +	 * 	a) a ramdisk is specified in cmdline
> +	 * 	 OR
> +	 * 	b) reuseinitrd is specified and a initrd is
> +	 * 	   used by the kernel.
> +	 *
> +	 */
> +	if ((ramdisk || (initrd_base && reuse_initrd))
> +		&& !strcmp(basename, "chosen/")) {
>  		int len = 8;
>  		unsigned long long initrd_end;
>  		*dt++ = 3;
> @@ -362,8 +371,9 @@ static void putnode(void)
> 
>  		memcpy(dt, &initrd_end, len);
>  		dt += (len + 3)/4;
> -
> -		reserve(initrd_base, initrd_size);
> +		/* reserve the existing initrd image in case of reuse_initrd */
> +		if (initrd_base && initrd_size && reuse_initrd)
> +			reserve(initrd_base, initrd_size);
>  	}
> 
>  	for (i = 0; i < numlist; i++) {
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

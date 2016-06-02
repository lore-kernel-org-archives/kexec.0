Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b8JPu-00013t-BT
 for kexec@lists.infradead.org; Thu, 02 Jun 2016 03:35:31 +0000
Received: by mail-qk0-f180.google.com with SMTP id n63so29449519qkf.0
 for <kexec@lists.infradead.org>; Wed, 01 Jun 2016 20:35:09 -0700 (PDT)
Date: Thu, 2 Jun 2016 09:05:04 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] kexec-tools: find sysfs smarter
Message-ID: <20160602033504.GB30865@dhcppc6>
References: <1464812798-9034-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1464812798-9034-1-git-send-email-jbacik@fb.com>
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
To: Josef Bacik <jbacik@fb.com>
Cc: kernel-team@fb.com, kexec@lists.infradead.org

On 01/06/2016:04:26:38 PM, Josef Bacik wrote:
> Some systems may not have /etc/mtab, so fall back to using /proc/mounts if we
> fail to open /etc/mtab.  Also if a user does
> 
> mount -t sysfs none /sys
> 
> we won't find the sysfs directory.  We need to check mnt->mnt_type, not
> mnt->mnt_fsname.

yes, mnt_fsname is actually "device for filesystem" and mnt_type is "type of
filesystem". Therefore, checking mnt->mnt_type is appropriate.
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/i386/x86-linux-setup.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
> index c75adaa..c24abaa 100644
> --- a/kexec/arch/i386/x86-linux-setup.c
> +++ b/kexec/arch/i386/x86-linux-setup.c
> @@ -425,10 +425,13 @@ char *find_mnt_by_fsname(char *fsname)
>  	char *mntdir;
>  
>  	mtab = setmntent("/etc/mtab", "r");
> -	if (!mtab)
> -		return NULL;
> +	if (!mtab) {
> +		mtab = setmntent("/proc/mounts", "r");
> +		if (!mtab)
> +			return NULL;
> +	}
>  	for(mnt = getmntent(mtab); mnt; mnt = getmntent(mtab)) {
> -		if (strcmp(mnt->mnt_fsname, fsname) == 0)
> +		if (strcmp(mnt->mnt_type, fsname) == 0)
>  			break;
>  	}
>  	mntdir = mnt ? strdup(mnt->mnt_dir) : NULL;
> -- 
> 2.5.0
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

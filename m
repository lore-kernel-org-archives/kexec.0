Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y71kc-0000Iz-I0
 for kexec@lists.infradead.org; Fri, 02 Jan 2015 12:54:47 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t02CsODC022673
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <kexec@lists.infradead.org>; Fri, 2 Jan 2015 07:54:24 -0500
Date: Fri, 2 Jan 2015 07:54:23 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec, remove panic_on_warn kernel parameter from kdump
 situations
Message-ID: <20150102125423.GA18785@redhat.com>
References: <1419951471-19765-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1419951471-19765-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, WANG Chao <chaowang@redhat.com>

On Tue, Dec 30, 2014 at 09:57:51AM -0500, Prarit Bhargava wrote:
> panic_on_warn kernel parameter will cause the kernel to panic when a
> WARN() is hit in the kernel.  This is not a good situation for the kdump
> kernel because then it would be possible for the kdump kernel to panic in
> a non-fatal WARN().
> 
> This patch removes panic_on_warn as a kernel parameter for the kdump
> kernel.
> 

I think modifying kexec-tools is not best place for this. It probably is better to take care of this in distribution specific scripts.

In the past we have learnt that it is best that kexec-tools does least
amount of manipulation with command line.

Thanks
Vivek

> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: WANG Chao <chaowang@redhat.com>
> ---
>  kexec/kexec.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index b088916..323cafb 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1048,8 +1048,10 @@ char *get_command_line(void)
>  	line[strlen(line) - 1] = '\0';
>  
>  	remove_parameter(line, "BOOT_IMAGE");
> -	if (kexec_flags & KEXEC_ON_CRASH)
> +	if (kexec_flags & KEXEC_ON_CRASH) {
>  		remove_parameter(line, "crashkernel");
> +		remove_parameter(line, "panic_on_warn");
> +	}
>  
>  	return line;
>  }
> -- 
> 1.7.9.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

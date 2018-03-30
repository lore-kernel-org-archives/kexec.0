Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f1nXi-0000co-Bk
 for kexec@lists.infradead.org; Fri, 30 Mar 2018 06:29:43 +0000
Date: Fri, 30 Mar 2018 08:29:29 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v6 1/5] kexec: Return -ENOSYS when kexec does not know
 how to call KEXEC_FILE_LOAD
Message-ID: <20180330062928.234zvlgiwyfvqadd@verge.net.au>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
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
To: Michal Suchanek <msuchanek@suse.de>
Cc: Petr Tesarik <ptesarik@suse.cz>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Tony Jones <tonyj@suse.com>

Hi again Dave,

would you care to review v6?

On Wed, Mar 28, 2018 at 03:15:14PM +0200, Michal Suchanek wrote:
> When the kernel does not know a syscall number it returns -ENOSYS but
> when kexec does not know a syscall number it returns -1. Return -ENOSYS
> from kexec as well.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kexec/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index cfd837c1b6bb..ab8cff7fe083 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1166,7 +1166,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>  
>  	if (!is_kexec_file_load_implemented()) {
>  		fprintf(stderr, "syscall kexec_file_load not available.\n");
> -		return -1;
> +		return -ENOSYS;
>  	}
>  
>  	if (argc - fileind <= 0) {
> -- 
> 2.13.6
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f42ig-000779-9Q
 for kexec@lists.infradead.org; Thu, 05 Apr 2018 11:06:19 +0000
Date: Thu, 5 Apr 2018 13:05:58 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH v6 3/5] kexec: Do not special-case the -s option
Message-ID: <20180405130558.30486489@ezekiel.suse.cz>
In-Reply-To: <1ce7ef9717b1e1a721a1012d1de1ed2b4eae9485.1522242915.git.msuchanek@suse.de>
References: <20180327095955.GB4681@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1522242915.git.msuchanek@suse.de>
 <1ce7ef9717b1e1a721a1012d1de1ed2b4eae9485.1522242915.git.msuchanek@suse.de>
MIME-Version: 1.0
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
Cc: Tony Jones <tonyj@suse.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, horms@verge.net.au

On Wed, 28 Mar 2018 15:15:16 +0200
Michal Suchanek <msuchanek@suse.de> wrote:

> It is parsed separately to save a few CPU cycles when setting up other
> options but it just complicates the code. So fold it back and set up all
> flags for both KEXEC_LOAD and KEXEC_FILE_LOAD
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  kexec/kexec.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index b793f31ea501..68ae0594d4a7 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
>[...]
> @@ -1354,11 +1340,8 @@ int main(int argc, char *argv[])
>  			do_exec = 0;
>  			do_shutdown = 0;
>  			do_sync = 0;
> -			if (do_kexec_file_syscall)
> -				kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> -			else
> -				kexec_flags = KEXEC_ON_CRASH;
> -			break;

Argh. This break was rather important. "kexec -p" now segfaults on
me, as it falls through to parsing non-existent optarg. :-(

Petr T

> +			kexec_file_flags |= KEXEC_FILE_ON_CRASH;
> +			kexec_flags = KEXEC_ON_CRASH;
>  		case OPT_MEM_MIN:
>  			mem_min = strtoul(optarg, &endptr, 0);
>  			if (*endptr) {
> @@ -1383,7 +1366,7 @@ int main(int argc, char *argv[])
>  			do_reuse_initrd = 1;
>  			break;
>  		case OPT_KEXEC_FILE_SYSCALL:
> -			/* We already parsed it. Nothing to do. */
> +			do_kexec_file_syscall = 1;
>  			break;
>  		case OPT_STATUS:
>  			do_status = 1;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

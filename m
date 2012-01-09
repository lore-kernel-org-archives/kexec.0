Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RkCBo-0002XL-85
 for kexec@lists.infradead.org; Mon, 09 Jan 2012 10:10:54 +0000
Message-ID: <4F0ABDB2.9010200@redhat.com>
Date: Mon, 09 Jan 2012 18:13:06 +0800
From: Dave Young <dyoung@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Correct magic varible of function name in debug code
References: <20120109100230.GA29322@hpt.localdomain>
In-Reply-To: <20120109100230.GA29322@hpt.localdomain>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Han Pingtian <hanpt@linux.vnet.ibm.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On 01/09/2012 06:02 PM, Han Pingtian wrote:

> The magic varible of function name should be uppercase.
> 
> Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> ---
>  kexec/crashdump.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/crashdump.c b/kexec/crashdump.c
> index e7ac42c..847d080 100644
> --- a/kexec/crashdump.c
> +++ b/kexec/crashdump.c
> @@ -103,7 +103,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
>  	*addr = (uint64_t) temp;
>  	*len = MAX_NOTE_BYTES; /* we should get this from the kernel instead */
>  #ifdef DEBUG
> -	printf("%s: crash_notes addr = %Lx\n", __function__, *addr);
> +	printf("%s: crash_notes addr = %Lx\n", __FUNCTION__, *addr);
>  #endif
>  
>  	fclose(fp);



Hi, Han

Glad to see you here.

I post a similar fix for this issue, please see:
http://lists.infradead.org/pipermail/kexec/2011-December/005889.html

-- 
Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WiPR7-0008Al-PE
 for kexec@lists.infradead.org; Thu, 08 May 2014 14:36:38 +0000
Date: Thu, 8 May 2014 10:36:15 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] cleanup duplicate code
Message-ID: <20140508143615.GF9224@redhat.com>
References: <1399559595-6062-1-git-send-email-chaowang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399559595-6062-1-git-send-email-chaowang@redhat.com>
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
To: WANG Chao <chaowang@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org

On Thu, May 08, 2014 at 10:33:15PM +0800, WANG Chao wrote:
> I accidentally add one duplicate line. Now remove it.
> 
> Signed-off-by: WANG Chao <chaowang@redhat.com>
> ---

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

>  kexec/arch/i386/crashdump-x86.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
> index cc33347..164ebb2 100644
> --- a/kexec/arch/i386/crashdump-x86.c
> +++ b/kexec/arch/i386/crashdump-x86.c
> @@ -303,7 +303,6 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
>  		} else if(memcmp(str,"reserved\n",9) == 0 ) {
>  			type = RANGE_RESERVED;
>  		} else if (memcmp(str, "GART\n", 5) == 0) {
> -		} else if (memcmp(str, "GART\n", 5) == 0) {
>  			gart_start = start;
>  			gart_end = end;
>  			gart = 1;
> -- 
> 1.8.5.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

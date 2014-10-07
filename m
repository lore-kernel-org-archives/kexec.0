Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XbYx9-0004st-5c
 for kexec@lists.infradead.org; Tue, 07 Oct 2014 17:53:39 +0000
Date: Tue, 7 Oct 2014 13:52:48 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH V25/5] powerpc/kexec: Use global IND_FLAGS macro
Message-ID: <20141007175248.GG27464@redhat.com>
References: <cover.1412640584.git.geoff@infradead.org>
 <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adf97d602657c72f6ee59aefe5d51149159a3e99.1412640584.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Tue, Oct 07, 2014 at 12:21:30AM +0000, Geoff Levand wrote:
> linux/kexec.h now defines an IND_FLAGS macro.  Remove the local powerpc
> definition and use the generic one.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

I think this patch should be merged in previous patch. I guess after
applying patch4, series might not be compilable as there are two
definitions of IND_FLAGS now.

Thanks
Vivek

> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 879b3aa..75652a32 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -96,8 +96,6 @@ int default_machine_kexec_prepare(struct kimage *image)
>  	return 0;
>  }
>  
> -#define IND_FLAGS (IND_DESTINATION | IND_INDIRECTION | IND_DONE | IND_SOURCE)
> -
>  static void copy_segments(unsigned long ind)
>  {
>  	unsigned long entry;
> -- 
> 1.9.1
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

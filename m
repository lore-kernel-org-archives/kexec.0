Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6NHV-0001ml-9g
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 15:32:58 +0000
Date: Fri, 15 Feb 2013 10:32:53 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 06/13] vmcore: modify vmcore clean-up function to free
 buffer on 2nd kernel
Message-ID: <20130215153253.GE27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101216.22466.52389.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101216.22466.52389.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Feb 14, 2013 at 07:12:16PM +0900, HATAYAMA Daisuke wrote:
> Vmcore object has buffer on 2nd kernel if it has VMCORE_2ND_KERNEL
> type, which needs to be freed.
> 
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
> 
>  fs/proc/vmcore.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 7e3f922..77e0a0e 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -735,6 +735,15 @@ void vmcore_cleanup(void)
>  		struct vmcore *m;
>  
>  		m = list_entry(pos, struct vmcore, list);
> +
> +		switch (m->type) {
> +		case VMCORE_OLD_MEMORY:
> +			break;
> +		case VMCORE_2ND_KERNEL:
> +			free_pages((unsigned long)m->buf, get_order(m->size));
> +			break;

I think order of patches is little wrong. None of the patches so far has
done any memory allocation for VMCORE_2ND_KERNEL, and we are already
freeing the memory which will be allocated in future patches. May be just
merge this patch with the patch which does memory allocation. No need
to separate it out.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

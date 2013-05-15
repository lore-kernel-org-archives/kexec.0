Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcjP8-0002IM-Kf
 for kexec@lists.infradead.org; Wed, 15 May 2013 21:38:35 +0000
Received: by mail-oa0-f41.google.com with SMTP id n9so2891221oag.0
 for <kexec@lists.infradead.org>; Wed, 15 May 2013 14:38:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130515090602.28109.90142.stgit@localhost6.localdomain6>
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090602.28109.90142.stgit@localhost6.localdomain6>
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Wed, 15 May 2013 17:37:52 -0400
Message-ID: <CAHGf_=q-91cYOMPFfSGLsWWst7STgp6pxX4__9UMYUGh=Ef3oA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] vmalloc: make find_vm_area check in range
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "riel@redhat.com" <riel@redhat.com>, Hugh Dickins <hughd@google.com>, jingbai.ma@hp.com, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, lisa.mitchell@hp.com, "linux-mm@kvack.org" <linux-mm@kvack.org>, kumagai-atsushi@mxc.nes.nec.co.jp, "Eric W. Biederman" <ebiederm@xmission.com>, zhangyanfei@cn.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, cpw@sgi.com, vgoyal@redhat.com

On Wed, May 15, 2013 at 5:06 AM, HATAYAMA Daisuke
<d.hatayama@jp.fujitsu.com> wrote:
> Currently, __find_vmap_area searches for the kernel VM area starting
> at a given address. This patch changes this behavior so that it
> searches for the kernel VM area to which the address belongs. This
> change is needed by remap_vmalloc_range_partial to be introduced in
> later patch that receives any position of kernel VM area as target
> address.
>
> This patch changes the condition (addr > va->va_start) to the
> equivalent (addr >= va->va_end) by taking advantage of the fact that
> each kernel VM area is non-overlapping.
>
> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
> ---
>
>  mm/vmalloc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d365724..3875fa2 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -292,7 +292,7 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
>                 va = rb_entry(n, struct vmap_area, rb_node);
>                 if (addr < va->va_start)
>                         n = n->rb_left;
> -               else if (addr > va->va_start)
> +               else if (addr >= va->va_end)
>                         n = n->rb_right;

OK. This is natural definition. Looks good.

Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

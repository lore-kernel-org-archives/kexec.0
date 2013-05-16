Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ud7sV-0003FK-Gx
 for kexec@lists.infradead.org; Thu, 16 May 2013 23:46:33 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 300D43EE0AE
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:46:03 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 20DFC45DE4E
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:46:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0B5D845DDCF
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:46:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EE81C1DB803A
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:46:02 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A60921DB802C
 for <kexec@lists.infradead.org>; Fri, 17 May 2013 08:46:02 +0900 (JST)
Message-ID: <51956FA3.6040806@jp.fujitsu.com>
Date: Fri, 17 May 2013 08:45:39 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 4/8] vmalloc: make find_vm_area check in range
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <20130515090602.28109.90142.stgit@localhost6.localdomain6>
 <CAHGf_=q-91cYOMPFfSGLsWWst7STgp6pxX4__9UMYUGh=Ef3oA@mail.gmail.com>
In-Reply-To: <CAHGf_=q-91cYOMPFfSGLsWWst7STgp6pxX4__9UMYUGh=Ef3oA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: "riel@redhat.com" <riel@redhat.com>, Hugh Dickins <hughd@google.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, lisa.mitchell@hp.com, vgoyal@redhat.com, "linux-mm@kvack.org" <linux-mm@kvack.org>, kumagai-atsushi@mxc.nes.nec.co.jp, "Eric W. Biederman" <ebiederm@xmission.com>, zhangyanfei@cn.fujitsu.com, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, cpw@sgi.com, jingbai.ma@hp.com

(2013/05/16 6:37), KOSAKI Motohiro wrote:
> On Wed, May 15, 2013 at 5:06 AM, HATAYAMA Daisuke
> <d.hatayama@jp.fujitsu.com> wrote:
>> Currently, __find_vmap_area searches for the kernel VM area starting
>> at a given address. This patch changes this behavior so that it
>> searches for the kernel VM area to which the address belongs. This
>> change is needed by remap_vmalloc_range_partial to be introduced in
>> later patch that receives any position of kernel VM area as target
>> address.
>>
>> This patch changes the condition (addr > va->va_start) to the
>> equivalent (addr >= va->va_end) by taking advantage of the fact that
>> each kernel VM area is non-overlapping.
>>
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>>
>>   mm/vmalloc.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d365724..3875fa2 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -292,7 +292,7 @@ static struct vmap_area *__find_vmap_area(unsigned long addr)
>>                  va = rb_entry(n, struct vmap_area, rb_node);
>>                  if (addr < va->va_start)
>>                          n = n->rb_left;
>> -               else if (addr > va->va_start)
>> +               else if (addr >= va->va_end)
>>                          n = n->rb_right;
>
> OK. This is natural definition. Looks good.
>
> Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>

Thanks for your reviewing. Could you or other someone review the next 
5/8 patch too? It also changes vmalloc and cc people's review is needed.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

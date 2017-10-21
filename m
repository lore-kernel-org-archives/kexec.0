Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ua0-x230.google.com ([2607:f8b0:400c:c08::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e5o5Y-0006vq-Iu
 for kexec@lists.infradead.org; Sat, 21 Oct 2017 07:20:58 +0000
Received: by mail-ua0-x230.google.com with SMTP id e46so9781921uaa.4
 for <kexec@lists.infradead.org>; Sat, 21 Oct 2017 00:20:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171020055254.GA7095@dhcp-128-65.nay.redhat.com>
References: <20171020055254.GA7095@dhcp-128-65.nay.redhat.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sat, 21 Oct 2017 00:20:33 -0700
Message-ID: <CAE9FiQU+R4Z+3xS9SjUk2i2D8Ht6uhP_pd8maguQOen1UqpgZg@mail.gmail.com>
Subject: Re: x86/kdump: crashkernel=X try to reserve below 896M first then
 below 4G and MAXMEM
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
To: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Thu, Oct 19, 2017 at 10:52 PM, Dave Young <dyoung@redhat.com> wrote:
> Now crashkernel=X will fail if there's not enough memory at low region
> (below 896M) when trying to reserve large memory size.  One can use
> crashkernel=xM,high to reserve it at high region (>4G) but it is more
> convinient to improve crashkernel=X to:
>
>  - First try to reserve X below 896M (for being compatible with old
>    kexec-tools).
>  - If fails, try to reserve X below 4G (swiotlb need to stay below 4G).
>  - If fails, try to reserve X from MAXMEM top down.
>
> It's more transparent and user-friendly.

ok with me.

But looks like last time Vivek did not like this idea.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

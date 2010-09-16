Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from hera.kernel.org ([140.211.167.34])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1Ow9Nk-0001F6-5M
	for kexec@lists.infradead.org; Thu, 16 Sep 2010 07:59:48 +0000
Message-ID: <4C91CE6E.5030500@kernel.org>
Date: Thu, 16 Sep 2010 09:59:42 +0200
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fix kvm kdump regression
References: <1301046921.1075601284613078206.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1301046921.1075601284613078206.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
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
To: caiqian@redhat.com
Cc: graff.yang@gmail.com, Marcelo Tosatti <mtosatti@redhat.com>, kexec <kexec@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Cliff Wickman <cpw@sgi.com>, dhowells@redhat.com, sonic.adi@gmail.com, Chris Lalancette <clalance@redhat.com>, Avi Kivity <avi@redhat.com>, stable@kernel.org

On 09/16/2010 06:57 AM, caiqian@redhat.com wrote:
> 020ec6537aa65c18e9084c568d7b94727f2026fd introduced a regression that an empty vmcore was generated during kdump on a kvm guest.
> ioremap: invalid physical address db74000000000000
> ------------[ cut here ]------------
> WARNING: at arch/x86/mm/ioremap.c:83 __ioremap_caller+0x307/0x380()
> Hardware name: KVM
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.36-rc2-mm1+ #2
> Call Trace:
>  [<ffffffff8105f48f>] warn_slowpath_common+0x7f/0xc0
>  [<ffffffff8103052e>] ? copy_oldmem_page+0x4e/0xc0
>  [<ffffffff8105f4ea>] warn_slowpath_null+0x1a/0x20
>  [<ffffffff8103f0a7>] __ioremap_caller+0x307/0x380
>  [<ffffffff8103f1f7>] ioremap_nocache+0x17/0x20
>  [<ffffffff8103052e>] copy_oldmem_page+0x4e/0xc0
>  [<ffffffff811af4ca>] read_from_oldmem+0x7a/0xb0
>  [<ffffffff81c4f70b>] merge_note_headers_elf64.clone.1+0x6c/0x21f
>  [<ffffffff8103056e>] ? copy_oldmem_page+0x8e/0xc0
>  [<ffffffff811af4ca>] ? read_from_oldmem+0x7a/0xb0
>  [<ffffffff81c4fa5b>] vmcore_init+0x19d/0x396
>  [<ffffffff81c4f8be>] ? vmcore_init+0x0/0x396
>  [<ffffffff81002053>] do_one_initcall+0x43/0x190
>  [<ffffffff81c278ab>] kernel_init+0x2a0/0x330
>  [<ffffffff8100be84>] kernel_thread_helper+0x4/0x10
>  [<ffffffff81c2760b>] ? kernel_init+0x0/0x330
>  [<ffffffff8100be80>] ? kernel_thread_helper+0x0/0x10
> ---[ end trace 93d72a36b9146f22 ]---
> Kdump: vmcore not initialized
> 
> This patch fixed it by reverting a chunk of the above commit and 9983b6f0cf8263e51bcf4c8a9dc0c1ef175b3c60 which is based on it.
> 
> Signed-off-by: CAI Qian <caiqian@redhat.com>

Sorry about the delay but I'm prepping a debug patch.  Let's root
cause and see if it can be fixed without reverting it as there are
further changes which depend on the commit and we'll have to hunt it
down anyway.

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

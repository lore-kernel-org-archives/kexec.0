Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bcjeo-0000Vw-QL
 for kexec@lists.infradead.org; Thu, 25 Aug 2016 01:40:39 +0000
Date: Thu, 25 Aug 2016 09:40:14 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Fix double-free when failing to relocate the
 purgatory.
Message-ID: <20160825014014.GA3574@x1.redhat.com>
References: <1472083546-23683-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1472083546-23683-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>

It's reasonable. Ack.

Acked-by: Baoquan He <bhe@redhat.com>

On 08/24/16 at 09:05pm, Thiago Jung Bauermann wrote:
> If kexec_apply_relocations fails, kexec_load_purgatory frees pi->sechdrs
> and pi->purgatory_buf. This is redundant, because in case of error
> kimage_file_prepare_segments calls kimage_file_post_load_cleanup,
> which will also free those buffers.
> 
> This causes two warnings like the following, one for pi->sechdrs and the
> other for pi->purgatory_buf:
> 
> [   18.112843] kexec-bzImage64: Loading purgatory failed
> [   18.113257] ------------[ cut here ]------------
> [   18.113263] WARNING: CPU: 1 PID: 2119 at mm/vmalloc.c:1490 __vunmap+0xc1/0xd0
> [   18.113264] Trying to vfree() nonexistent vm area (ffffc90000e91000)
> [   18.113367] Modules linked in:
> [   18.113371] CPU: 1 PID: 2119 Comm: kexec Not tainted 4.8.0-rc3+ #5
> [   18.113372] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
> [   18.113373]  0000000000000000 ffff88003bbb7dc8 ffffffff8132eca8 ffff88003bbb7e18
> [   18.113376]  0000000000000000 ffff88003bbb7e08 ffffffff8105f1bb 000005d281175bf8
> [   18.113377]  ffffc90000e91000 0000000000000000 0000000000000001 ffff88003e5f8c00
> [   18.113379] Call Trace:
> [   18.113384]  [<ffffffff8132eca8>] dump_stack+0x4d/0x65
> [   18.113386]  [<ffffffff8105f1bb>] __warn+0xcb/0xf0
> [   18.113388]  [<ffffffff8105f22f>] warn_slowpath_fmt+0x4f/0x60
> [   18.113390]  [<ffffffff81176469>] ? find_vmap_area+0x19/0x70
> [   18.113393]  [<ffffffff810dbb57>] ? kimage_file_post_load_cleanup+0x47/0xb0
> [   18.113394]  [<ffffffff81177451>] __vunmap+0xc1/0xd0
> [   18.113396]  [<ffffffff811774ce>] vfree+0x2e/0x70
> [   18.113397]  [<ffffffff810dbb6e>] kimage_file_post_load_cleanup+0x5e/0xb0
> [   18.113398]  [<ffffffff810dc718>] SyS_kexec_file_load+0x448/0x680
> [   18.113401]  [<ffffffff811a6834>] ? putname+0x54/0x60
> [   18.113403]  [<ffffffff81195d70>] ? do_sys_open+0x190/0x1f0
> [   18.113407]  [<ffffffff81824e5b>] entry_SYSCALL_64_fastpath+0x13/0x8f
> [   18.113408] ---[ end trace 158bb74f5950ca2b ]---
> 
> Fix by setting pi->sechdrs an pi->purgatory_buf to NULL, since vfree
> won't try to free a NULL pointer.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  kernel/kexec_file.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 503bc2d348e5..037c321c5618 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -887,7 +887,10 @@ int kexec_load_purgatory(struct kimage *image, unsigned long min,
>  	return 0;
>  out:
>  	vfree(pi->sechdrs);
> +	pi->sechdrs = NULL;
> +
>  	vfree(pi->purgatory_buf);
> +	pi->purgatory_buf = NULL;
>  	return ret;
>  }
>  
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

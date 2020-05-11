Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from shards.monkeyblade.net ([2620:137:e000::1:9])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYEzc-0008PX-Em
 for kexec@lists.infradead.org; Mon, 11 May 2020 20:25:41 +0000
Date: Mon, 11 May 2020 13:25:31 -0700 (PDT)
Message-Id: <20200511.132531.1067573616053698778.davem@davemloft.net>
Subject: Re: [PATCH v2 0/2] net: Optimize the qed* allocations inside kdump
 kernel
From: David Miller <davem@davemloft.net>
In-Reply-To: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
References: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
Mime-Version: 1.0
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
To: bhsharma@redhat.com
Cc: aelior@marvell.com, irusskikh@marvell.com, manishc@marvell.com, netdev@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, GR-everest-linux-l2@marvell.com, bhupesh.linux@gmail.com

From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 11 May 2020 15:41:40 +0530

 ...
> Since kdump kernel(s) run under severe memory constraint with the
> basic idea being to save the crashdump vmcore reliably when the primary
> kernel panics/hangs, large memory allocations done by a network driver
> can cause the crashkernel to panic with OOM.
> 
> The qed* drivers take up approximately 214MB memory when run in the
> kdump kernel with the default configuration settings presently used in
> the driver. With an usual crashkernel size of 512M, this allocation
> is equal to almost half of the total crashkernel size allocated.
> 
> See some logs obtained via memstrack tool (see [1]) below:
>  dracut-pre-pivot[676]: ======== Report format module_summary: ========
>  dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)
>  dracut-pre-pivot[676]: Module qede using 65.3MB (1045 pages), peak allocation 65.3MB (1045 pages)
> 
> This patchset tries to reduce the overall memory allocation profile of
> the qed* driver when they run in the kdump kernel. With these
> optimization we can see a saving of approx 85M in the kdump kernel:
>  dracut-pre-pivot[671]: ======== Report format module_summary: ========
>  dracut-pre-pivot[671]: Module qed using 124.6MB (1993 pages), peak allocation 124.7MB (1995 pages)
>  <..snip..>
>  dracut-pre-pivot[671]: Module qede using 4.6MB (73 pages), peak allocation 4.6MB (74 pages)
 ...

Series applied to net-next, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

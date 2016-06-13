Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1bCLu8-0004cC-NJ
 for kexec@lists.infradead.org; Mon, 13 Jun 2016 07:03:25 +0000
Date: Mon, 13 Jun 2016 15:02:58 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/8] kexec_file_load implementation for PowerPC
Message-ID: <20160613070258.GA4974@dhcp-128-65.nay.redhat.com>
References: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1465701022-11601-1-git-send-email-bauerman@linux.vnet.ibm.com>
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
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On 06/12/16 at 12:10am, Thiago Jung Bauermann wrote:
> Hello,
> 
> This patch series implements the kexec_file_load system call on PowerPC.
> 
> It starts by removing an x86 assumption from kexec_file: kexec_add_buffer uses
> iomem to find reserved memory ranges, but PowerPC uses the memblock subsystem.
> Hooks are added so that each arch can specify how memory ranges can be found.
> 
> Also, the memory-walking logic in kexec_add_buffer is useful in this
> implementation to find a free area for the purgatory's stack, so that same
> patch moves that logic to kexec_locate_mem_hole.
> 
> The kexec_file_load system call needs to apply relocations to the purgatory
> but adding code for that would duplicate functionality with the module loading
> mechanism, which also needs to apply relocations to the kernel modules.
> Therefore, this patch series factors out the module relocation code so that it
> can be shared.
> 
> One thing that is still missing is crashkernel support, which I intend to
> submit shortly.

But seems there's no error handling in patches about KEXEC_ON_CRASH?
It would be good to either sending out the whole set or handle the error
cases correctly.

[snip]

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cEvZf-0000l3-5P
 for kexec@lists.infradead.org; Thu, 08 Dec 2016 10:05:12 +0000
Date: Thu, 8 Dec 2016 11:04:44 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools/x86: get_kernel_vaddr_and_size off-by-one fix
Message-ID: <20161208100444.GC31057@verge.net.au>
References: <20161208025222.GA5427@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161208025222.GA5427@dhcp-128-65.nay.redhat.com>
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
Cc: kexec@lists.infradead.org

On Thu, Dec 08, 2016 at 10:52:22AM +0800, Dave Young wrote:
> I got below error while tesing kexec -p:
> "Can't find kernel text map area from kcore"
> 
> The case is the pt_load start addr was same as stext_sym. The checking
> code should really be saddr <= stext_sym so that the right pt_load area
> includes stext_sym can be matched.
> 
> This was not reported by people previously because it will fail over to
> use hardcode X86_64__START_KERNEL_map to match the pt_load areas again
> in later code and it sometimes succeeds because of kernel address
> randomization.
> 
> With this change according to my test stext_sym checking can garantee
> falling into right pt_load area if we get correct stext_sym.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1abkjs-0005Z0-Lk
 for kexec@lists.infradead.org; Fri, 04 Mar 2016 08:05:33 +0000
Date: Fri, 4 Mar 2016 16:04:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/2] Export new VMCOREINFO about compound page
Message-ID: <20160304080459.GA3056@dhcp-128-65.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FC7@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E25FC7@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 03/01/16 at 06:14am, Atsushi Kumagai wrote:
> Hello,
> 
> This patch set is to follow up modifications of struct page for 
> makedumpfile which filters dump file.
> It's necessary to filter unnecessary compound pages in newer kernel
> as usual.
> 
> Incidentally, [PATCH 1/2] was post in:
> 
>   https://lkml.org/lkml/2016/1/27/92
> 
> but it didn't get any response, I repost it here.
> 
> Atsushi Kumagai (2):
>       kexec: update VMCOREINFO for compound_order/dtor
>       kexec: export OFFSET(page.compound_head) to check anonymous page
> 
> kernel/kexec_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WwSY2-0008DG-PO
 for kexec@lists.infradead.org; Mon, 16 Jun 2014 08:45:51 +0000
Date: Mon, 16 Jun 2014 16:44:27 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/3] makedumpfile: Reduce the risk of OOM.
Message-ID: <20140616084427.GB1718@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE972196B4@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE972196B4@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 06/10/14 at 04:51am, Atsushi Kumagai wrote:
> Hello,
> 
> makedumpfile tries maximizing the bitmap buffer size to get the
> best performance, but it occasionally cause OOM because the safe
> limit is variable and it can be too aggressive depending on the
> situation.
> 
> I think reliability is more important than performance for dump
> tools, so I decided to remove the maximization. I don't worry
> about performance degradation, please see [PATCH 3/3].
> 
> If there is no objection, I'll merge this patch into v1.5.7.
> 
> BTW, an expert user still can try to maximize the bitmap buffer with
> --cyclic-buffer option.

It makes sense to decrease the bufsize_cyclic to make sure the dumping
can work successfully.

Thanks for your effort, Atsushi!

Thanks
Baoquan

> 
> Atsushi Kumagai (3):
>       Remove the 1st bitmap buffer from the ELF path in cyclic mode.
>       Move counting pfn_memhole for cyclic mode.
>       Stop maximizing the bitmap buffer to reduce the risk of OOM.
> 
>  makedumpfile.8 |   1 -
>  makedumpfile.c | 117 ++++++++++++++++++++------------------------------------------------------------------------------
>  print_info.c   |   1 -
>  3 files changed, 24 insertions(+), 95 deletions(-)
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

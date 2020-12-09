Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmyoa-0007hP-LT
 for kexec@lists.infradead.org; Wed, 09 Dec 2020 12:43:29 +0000
Date: Wed, 9 Dec 2020 13:43:19 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] dt-ops: fix memory leak when new_node malloc fails
Message-ID: <20201209124319.GB21612@vergenet.net>
References: <20201201040616.18618-1-qiuguorui1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201040616.18618-1-qiuguorui1@huawei.com>
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
To: qiuguorui1 <qiuguorui1@huawei.com>
Cc: leeyou.li@huawei.com, bhsharma@redhat.com, kexec@lists.infradead.org, zengweilin@huawei.com

On Tue, Dec 01, 2020 at 12:06:16PM +0800, qiuguorui1 wrote:
> In function dtb_set_property, when malloc new_node fails,
> we need to free new_dtb before return.
> 
> Fixes: f56cbcf4c2766 ("kexec/dt-ops.c: Fix '/chosen' v/s 'chosen' node
> being passed to fdt helper functions")
> Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
> 
> v2:
>   use goto instead of free here,based on Simon Horman's advice:
>   "Can we use the goto idiom here, as is used elsewhere in this function?"
> 
> v1: http://lists.infradead.org/pipermail/kexec/2020-November/021809.html

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

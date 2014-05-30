Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WqFLt-0006Lu-A6
 for kexec@lists.infradead.org; Fri, 30 May 2014 05:27:37 +0000
Date: Fri, 30 May 2014 14:27:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] kexec-tools: add --page-offset option for ARM
Message-ID: <20140530052715.GF6561@verge.net.au>
References: <1401355203-63794-1-git-send-email-wangnan0@huawei.com>
 <1401355203-63794-3-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401355203-63794-3-git-send-email-wangnan0@huawei.com>
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
To: Wang Nan <wangnan0@huawei.com>
Cc: Dave Anderson <anderson@redhat.com>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

On Thu, May 29, 2014 at 05:20:03PM +0800, Wang Nan wrote:
> When KALLSYMS is disabled or /proc is not mounted, this patch allows
> --page-offset cmdline option for user to setup correct page_offset.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>

Thanks, applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

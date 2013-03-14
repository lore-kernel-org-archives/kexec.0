Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UG4mS-0008A3-Ud
 for kexec@lists.infradead.org; Thu, 14 Mar 2013 09:49:05 +0000
Date: Thu, 14 Mar 2013 10:48:56 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 03/13] kexec: ppc: remove duplicated _ALIGN_* macros
Message-ID: <20130314094855.GQ11196@verge.net.au>
References: <5140B511.7020109@gmail.com>
 <5140B625.2010106@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5140B625.2010106@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Mar 14, 2013 at 01:23:49AM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> We have defined the global align macros for use, so remove the
> duplicated macros here.
> 
> And in file kexec/arch/ppc/include/page.h, we directly expand the
> align operation for marco PAGE_ALIGN since we have removed marco
> _ALIGN in this file.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

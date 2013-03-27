Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpi6-0007xE-V5
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:44:11 +0000
Date: Wed, 27 Mar 2013 21:44:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix a minor mistake in an error message
Message-ID: <20130327124405.GD17248@verge.net.au>
References: <5151A739.6070502@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5151A739.6070502@gmail.com>
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

On Tue, Mar 26, 2013 at 09:48:41PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> when specified a wrong --entry option, it outputs the error message:
>     "Bad option value in --load-jump-back-helper=%s\n"
> which is obviously wrong, it should be:
>     "Bad option value in --entry=%s\n"
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

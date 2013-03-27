Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UKpcE-0006qG-Tx
 for kexec@lists.infradead.org; Wed, 27 Mar 2013 12:38:07 +0000
Date: Wed, 27 Mar 2013 21:38:04 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 05/13] kexec: i386: multiboot: fix possible memory leak
 in multiboot_x86_load
Message-ID: <20130327123804.GR17248@verge.net.au>
References: <51506758.4070902@gmail.com>
 <515068EB.20200@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <515068EB.20200@gmail.com>
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

On Mon, Mar 25, 2013 at 11:10:35PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> In multiboot_x86_load, allocated memory may not be free'd if the code
> exits abnormally, by calling return. So the patch fixes the possible
> memory leak.
> 
> Besides, remove some extra blank lines.
> 
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

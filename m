Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UChbg-00034R-Bj
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 02:27:57 +0000
Date: Tue, 5 Mar 2013 11:27:53 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: use dbgprintf instead of #if 0 for debug printing
Message-ID: <20130305022751.GK16128@verge.net.au>
References: <50D97377.3010209@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50D97377.3010209@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Tue, Dec 25, 2012 at 05:35:51PM +0800, Zhang Yanfei wrote:
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kexec/arch/i386/kexec-x86-common.c |   28 ++++++++++------------------
>  kexec/kexec.c                      |   18 +++++++++---------
>  2 files changed, 19 insertions(+), 27 deletions(-)

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJcji-0003lJ-25
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 12:44:51 +0000
Date: Wed, 1 Apr 2020 14:44:46 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Removing condition that will never be met after calls
 xmalloc and xrealloc
Message-ID: <20200401124446.GD29376@vergenet.net>
References: <20200303035649.GA726@kexec.lxd>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200303035649.GA726@kexec.lxd>
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
To: "Leonidas S. Barbosa" <kirotawa@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Mar 03, 2020 at 03:56:49AM +0000, Leonidas S. Barbosa wrote:
> Hi,
> 
> Looking in the kexec-tools code I found these conditions that
> seems will never be met. Not sure if that was intentional for explicitity,
> if it was the case, please disconsider this patch.
> 
> 
> 
> 
> xmalloc and xrealloc when fails calls die() that calls exit(1).
> Checks for if(!memory) after they are called will never be met that
> condition, since the process will be exited after an allocation fail.
> 
> Signed-off-by: Leonidas S. Barbosa <kirotawa@gmail.com>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

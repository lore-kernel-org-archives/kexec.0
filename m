Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmyt8-0008HS-Sy
 for kexec@lists.infradead.org; Wed, 09 Dec 2020 12:48:11 +0000
Date: Wed, 9 Dec 2020 13:48:07 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: mips: Fix mem parameters
Message-ID: <20201209124807.GC21612@vergenet.net>
References: <1607041787-375-1-git-send-email-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1607041787-375-1-git-send-email-hejinyang@loongson.cn>
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
To: Jinyang He <hejinyang@loongson.cn>
Cc: kexec@lists.infradead.org, Youling Tang <tangyouling@loongson.cn>

On Fri, Dec 04, 2020 at 08:29:47AM +0800, Jinyang He wrote:
> "mem=" is useful to indicate the memory region when capture kernel boot.
> Otherwise, capture kernel will breakdown the memory of panic kernel.
> Although it can be add by user, adding "mem" by software is a better way.
> What's more, "mem" should contain elfcorehdr range. Elfcorehdr memory
> should be managed by kernel.
> 
> Fixes: 7bd251654aad ("kexec-tools: mips: Remove commandline parameter "mem"")
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

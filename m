Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSGWl-00Cfj1-V2
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 09:55:47 +0000
Date: Fri, 2 Apr 2021 11:55:40 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec-tools: mips: Fix the increased mem parameter size
Message-ID: <20210402095539.GB18086@vergenet.net>
References: <1615952714-18683-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1615952714-18683-1-git-send-email-tangyouling@loongson.cn>
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org

On Wed, Mar 17, 2021 at 11:45:14AM +0800, Youling Tang wrote:
> The added "mem=size@start" parameter actually corresponds to
> "crashkernel=YM@XM", but 1 byte is missing when calculating
> the size, so 1 byte should be added.
> 
> For example, when using crashkernel=108M@64M (110592K@65536K):
> Without this patch:
> 	the mem parameter added is: mem=110591K@65536K
> 
> With this patch:
> 	the mem parameter added is: mem=110592K@65536K
> 
> Fixes: 0eac64052636 ("kexec: mips: Fix mem parameters")
> 
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

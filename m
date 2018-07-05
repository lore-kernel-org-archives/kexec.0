Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fay2Y-0001so-6C
 for kexec@lists.infradead.org; Thu, 05 Jul 2018 06:46:56 +0000
Date: Thu, 5 Jul 2018 14:46:20 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 0/1] x86/purgatory: Fix Makefile bug
Message-ID: <20180705064620.GA24455@dhcp-128-65.nay.redhat.com>
References: <20180704110044.29279-1-prudo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180704110044.29279-1-prudo@linux.ibm.com>
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
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, kexec@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>

On 07/04/18 at 01:00pm, Philipp Rudo wrote:
> Hi everybody,
> 
> when i moved the purgatories sha256 implementation to common code, i forgot
> to add FORCE to the new Makefile target. This patch fixes it.

Hi Philipp,

Do you have the exact steps of how to reproduce your problem?

> 
> Note: There is an equivalent bug in the s390 purgatory. The fix for that
> will go upstream via Martin.
> 
> Thanks
> Philipp
> 
> Philipp Rudo (1):
>   x86/purgatory: Add missing FORCE to Makefile target
> 
>  arch/x86/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> -- 
> 2.16.4
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TjVMs-0000D6-O2
 for kexec@lists.infradead.org; Fri, 14 Dec 2012 13:31:59 +0000
Date: Fri, 14 Dec 2012 22:31:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] Fix xen_cpuid() inline asm to not clobber stack's
 red zone
Message-ID: <20121214133155.GH16382@verge.net.au>
References: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1355413730-18190-1-git-send-email-olaf@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Olaf Hering <olaf@aepfle.de>
Cc: kexec@lists.infradead.org

On Thu, Dec 13, 2012 at 04:48:46PM +0100, Olaf Hering wrote:
> Port xen-unstable changeset 24344:72f4e4cb7440 to kexec-tools:
> 
>   Pushing stuff onto the stack on x86-64 when we do not specify
>   -mno-red-zone is unsafe. Since the complicated asm is due to register
>   pressure on i386, we simply implement an all-new simpler alternative
>   for x86-64.

Thanks, all 5 patches applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

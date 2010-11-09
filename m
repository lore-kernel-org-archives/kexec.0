Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PFeQP-0000fA-E0
	for kexec@lists.infradead.org; Tue, 09 Nov 2010 02:59:10 +0000
Date: Tue, 9 Nov 2010 11:51:39 +0900
From: Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/2] makedumpfile: few ARM fixes
Message-Id: <20101109115139.2e466559.igawa@mxs.nes.nec.co.jp>
In-Reply-To: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1289202688.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
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
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: kexec@lists.infradead.org

Hi,

Thank you for your patches. I've merged and pushed.

Regards,
Masayuki Igawa


On Mon,  8 Nov 2010 09:59:26 +0200, Mika Westerberg wrote:

> Hi,
> 
> While using makedumpfile on ARM I found few issues from the current
> implementation. Basically the current implementation only works on
> 3G/1G VM split but not others.
> 
> These patches should make makedumpfile on ARM to work on other VM
> split values as well. I've tested with 1G/3G, 2G/2G, 3G/1G, and
> VMSPLIT_3G_OPT (2.7G/1.3G).
> 
> Changes to previous version:
> 	- removed any references to vmalloc_start as per review comments
> 
> This version still allows users to use '--vtop' option to perform V->P
> translations via page tables.
> 
> Regards,
> MW
> 
> Mika Westerberg (2):
>   ARM: determine PAGE_OFFSET from _stext
>   ARM: don't depend on vmalloc_start
> 
>  arm.c          |   50 +++++++++-----------------------------------------
>  makedumpfile.h |    1 -
>  2 files changed, 9 insertions(+), 42 deletions(-)
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

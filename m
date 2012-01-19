Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RniLP-0002pn-8w
 for kexec@lists.infradead.org; Thu, 19 Jan 2012 03:07:21 +0000
Date: Thu, 19 Jan 2012 11:58:52 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/3][makedumpfile]Add support for  PPC32
Message-Id: <20120119115852.588bf8bb.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
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
To: suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp

Hi Suzuki,

On Wed, 18 Jan 2012 15:37:49 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> The following series implements makedumpfile support for PPC32.
> 
> The implementation is heavily based on PPC64. This also introduces
> cross build support which is required for Embedded PPC Boards.
> 
> ---
> 
> Suzuki K. Poulose (3):
>       [makedumpfile] Add support for PPC32
>       [ppc64] Rename the __powerpc__ macro to __powerpc64__ for PPC64
>       [makedumpfile] Support building for cross build
> 
> 
>  Makefile       |   26 ++++++++++++--
>  README         |    5 +++
>  arch/ppc.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  makedumpfile.c |    4 +-
>  makedumpfile.h |   28 +++++++++++++---
>  5 files changed, 153 insertions(+), 11 deletions(-)
>  create mode 100644 arch/ppc.c
> 
> -- 
> Suzuki Poulose

Thank you for your patches.
I will review them.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

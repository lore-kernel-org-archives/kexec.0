Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RyBmg-0001aL-AC
 for kexec@lists.infradead.org; Fri, 17 Feb 2012 00:34:48 +0000
Date: Fri, 17 Feb 2012 09:32:20 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
Message-Id: <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120216033411.7972.77705.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
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
Cc: kexec@lists.infradead.org

Hi, Suzuki

On Thu, 16 Feb 2012 09:05:17 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> The series introduces an infrastructure to define platform specific
> bits for page translation for PPC and PPC44x support for vmalloc
> translation.
> 
> This is similar to what we have implemented for Crash-utility.
> 
> The patches are based makedumpfile-1.4.2 + PPC32 support patches
> which is queued in for 1.4.3.
> 
> ---
> 
> Suzuki K. Poulose (4):
>       [makedumpfile][ppc] PPC44x page translation definitions
>       [makedumpfile][ppc] Define platform descriptors for page translation
>       [makedumpfile][ppc] Generic vmalloc translation support
>       [makedumpfile] Add read_string routine
> 
> 
>  arch/ppc.c     |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  makedumpfile.c |   14 +++++++
>  makedumpfile.h |   21 +++++++++++
>  3 files changed, 139 insertions(+), 4 deletions(-)
> 
> -- 
> Suzuki Poulose

Could you tell me what kind of data is stored in vmalloc region in PPC ?
I want to estimate importance of your patches for makedumpfile.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

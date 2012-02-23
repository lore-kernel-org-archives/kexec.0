Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0V7J-0000DO-7n
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 09:37:40 +0000
Date: Thu, 23 Feb 2012 18:35:05 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] Fix segmentation fault for makedumpfile -x/--split
Message-Id: <20120223183505.2ab30cfd.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120201131518.7764c710.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120131102456.17966.37854.stgit@aruna-ThinkPad-T420>
 <20120201131518.7764c710.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: aruna@linux.vnet.ibm.com
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hi Aruna,

On Wed, 1 Feb 2012 13:15:18 +0900
Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:

> Hi Aruna,
> 
> On Tue, 31 Jan 2012 15:56:33 +0530
> Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com> wrote:
> 
> > 
> > The patch fixes the segmentation fault issue of makedumpfile when a
> > user specifies an invalid file name with -x/--split option.
> > The patch takes care of such a scenario by setting .find_debuginfo to
> > a function pointer which returns -1 and throws error messages against
> > invalid vmlinux file input. With a valid vmlinux file .find_debuginfo
> > was never invoked since the absolute path of debuginfo was known by the
> > time we call init_dwarf_info.
> > 
> > Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
> > ---
> >  dwarf_info.c |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)

I'm reviewing your patch and it looks good.

However, I can't guess that the segmentation fault caused
by --split option because --split option doesn't require an argument.

Would you tell me the case that you thought.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

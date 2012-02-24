Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0lUo-0002G9-JI
 for kexec@lists.infradead.org; Fri, 24 Feb 2012 03:07:02 +0000
Date: Fri, 24 Feb 2012 12:05:05 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] Fix segmentation fault for makedumpfile -x/--split
Message-Id: <20120224120505.a747b51d.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <4F461828.8020601@linux.vnet.ibm.com>
References: <20120131102456.17966.37854.stgit@aruna-ThinkPad-T420>
 <20120201131518.7764c710.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120223183505.2ab30cfd.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F461828.8020601@linux.vnet.ibm.com>
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
To: arunabal@linux.vnet.ibm.com
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org

Hello Aruna,

On Thu, 23 Feb 2012 16:12:48 +0530
Aruna Balakrishnaiah <arunabal@linux.vnet.ibm.com> wrote:

> > I'm reviewing your patch and it looks good.
> >
> > However, I can't guess that the segmentation fault caused
> > by --split option because --split option doesn't require an argument.
> >
> > Would you tell me the case that you thought.
> This is the case,
> 
> makedumpfile --split -x /boot/vmlinuz vmcore vm1 vm2
> 
> when used compressed vmlinux with -x.

Thank you for your reply, I understand.
I merged your patch into makedumpfile-1.4.3.

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

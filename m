Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StXnp-0006i1-VC
 for kexec@lists.infradead.org; Tue, 24 Jul 2012 05:37:07 +0000
Date: Tue, 24 Jul 2012 14:13:17 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/8] makedumpfile: Xen4 support for SLES11
Message-Id: <20120724141317.94818eff2aaa00fac3362ece@mxc.nes.nec.co.jp>
In-Reply-To: <20120723113244.751777873@suse.cz>
References: <20120723113244.751777873@suse.cz>
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
To: ptesarik@suse.cz
Cc: kexec@lists.infradead.org, fngw.zhang@huawei.com, Norbert.Trapp@ts.fujitsu.com

Hello Petr,

On Mon, 23 Jul 2012 13:32:44 +0200
ptesarik@suse.cz wrote:

> This patchset was created to allow using makedumpfile for Dom0 dumps in SLES
> SP1 and SP2. Most of the patches account for changes to the Xen hypervisor,
> except the last one, which reflects that the "max_pfn" symbol is not exporte
> by the SLES kernel.
> 
> Petr Tesarik
> SUSE Linux

Thank you for your work.

Although I haven't seen almost your patchset yet, does your patchset have 
a functional overlap with the patchset Norbert sent ?

  http://lists.infradead.org/pipermail/kexec/2012-June/006420.html
  (This thread needs some experts in Xen)

It seems that the two have the same purpose, but I can't decide which is 
better way. Do you have any opinion ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

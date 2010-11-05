Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.105.134] helo=mgw-mx09.nokia.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PEHN6-0004FW-U8
	for kexec@lists.infradead.org; Fri, 05 Nov 2010 08:10:05 +0000
Date: Fri, 5 Nov 2010 10:03:37 +0200
From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH 2/2] ARM: don't depend on vmalloc_start
Message-ID: <20101105080337.GE17801@esdhcp04058.research.nokia.com>
References: <cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<cover.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<d7f8e9b169c05bc7643b2c01929e38ac3fadf035.1288788355.git.ext-mika.1.westerberg@nokia.com>
	<20101105.111842.14992809.igawa@mxs.nes.nec.co.jp>
	<20101105060226.GC17801@esdhcp04058.research.nokia.com>
	<20101105164134.314fd489.igawa@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101105164134.314fd489.igawa@mxs.nes.nec.co.jp>
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
To: ext Masayuki Igawa <igawa@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

On Fri, Nov 05, 2010 at 04:41:34PM +0900, ext Masayuki Igawa wrote:
> On Fri, 5 Nov 2010 08:02:26 +0200, Mika Westerberg wrote:
> > 
> > Normal makedumpfile run (at least on ARM) only does V->P translation on kernel
> > directly mapped memory so I considered this to save few clock cycles since that
> > translation is trivial compared to the one using page tables.
> 
> Unfortunately, I'm not good at ARM. So I have a few questions.
> In (all) ARM, is all the kernel memory directly mapped?

Not all -- vmalloc() memory is not directly mapped.

> The result of vtop_arm()'s translation is always equals __pa()'s in ARM?

vtop_arm() also handles this vmalloc() memory as it uses page tables to perform
the translation.

> > Well my intention was to leave user a option to use '--vtop' for all the kernel
> > memory (not just for kernel directly mapped memory). IMO, it is useful to have
> > such option available for debugging etc. Is it ok for you?
> 
> IIUC, is there the kernel memory which isn't directly mapped?

Yes, see above.

> If so, the memory(which isn't directly mapped) is not supported by your patch?

As makedumpfile uses only values from VMCOREINFO which are in kernel direct
mapped memory the patch should work (I've tested this).

For example ppc64 does the same, it only allows V->P translation on kernel
direct mapped memory.

Regards,
MW

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

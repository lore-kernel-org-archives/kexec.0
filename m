Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from noname.neutralserver.com ([70.84.186.210])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IKdrv-00078p-Bz
	for kexec@lists.infradead.org; Mon, 13 Aug 2007 13:38:21 -0400
Date: Mon, 13 Aug 2007 20:38:11 +0300
From: Dan Aloni <da-x@monatomic.org>
Subject: Re: [RFC][PATCH 1/3] Embed vmcoreinfo into kernel file
Message-ID: <20070813173811.GA14191@localdomain>
References: <20070813163212oomichi@mail.jp.nec.com>
	<20070813163653oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070813163653oomichi@mail.jp.nec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Bernhard Walle <bwalle@suse.de>, Vivek Goyal <vgoyal@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Neil Horman <nhorman@redhat.com>

On Mon, Aug 13, 2007 at 04:36:53PM +0900, Ken'ichi Ohmichi wrote:
>[..]
> Patches:
> - [1/3] patch for linux-2.6.22.
>   Changelog:
>   * Rename "mkdfinfo" to "vmcoreinfo".
>   * Multi memory models (FLATMEM, DISCONTIGMEM, and SPASEMEM) are
>     supported.
>   * The elf note typedef for vmcoreinfo is added because the original
>     elf note size is limited to 1024.
>   * The generation of the elf note is moved to boot time instead of
>     crash time.

This looks very good. Just one suggestion - in order to reduce clutter 
from kernel/kexec.c (as to avoid #ifdefs) perhaps it might be better 
to have crash_save_vmcoreinfo_init() additionally call an arch-specific 
arch_crash_save_vmcoreinfo_init() function and have that append all 
the arch-specific stuff.

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

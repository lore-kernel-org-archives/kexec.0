Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I8isz-0005uq-K9
	for kexec@lists.infradead.org; Wed, 11 Jul 2007 16:34:11 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [IA64] [kdump] machveg=dig on hpzx1 platforms
Date: Wed, 11 Jul 2007 13:34:05 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A01E6CC56@scsmsx411.amr.corp.intel.com>
In-Reply-To: <467AE260.7030906@hp.com>
From: "Luck, Tony" <tony.luck@intel.com>
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
To: Terry Loftin <terry.loftin@hp.com>, Bernhard Walle <bwalle@suse.de>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-ia64@vger.kernel.org, Khalid Aziz <khalid_aziz@hp.com>, kexec@lists.infradead.org

> Here is a patch to do that.  We use this internally, but
> I had forgotten to post it.

Terry,

Just got to applying some older patches ... perhaps this one has
been sitting too long because I had some apply & build problems with it.

Building with arch/ia64/configs/zx1_defconfig and with this patch
hand applied I get:

  LD      .tmp_vmlinux1
arch/ia64/hp/common/built-in.o(.init.text+0xcc2): In function `sba_init':
: undefined reference to `swiotlb_late_init_with_default_size'
arch/ia64/hp/common/built-in.o(.init.text+0xd02): In function `sba_init':
: undefined reference to `machvec_init'
make: *** [.tmp_vmlinux1] Error 1

sba_init() uses these routines inside #ifdef CONFIG_I64_GENERIC, perhaps
you need to do the same?


Other issues:
1) No "Signed-off-by"

2) +#include <linux/crash_dump.h>

We usually group all the <linux/*> includes together before the <asm/*> ones

3) +extern int swiotlb_late_init_with_default_size (size_t size);

extern declarations in ".c" files are frowned upon.  This should be in
a header file, which should be included (though I see that this guideline
has already been ignored as you were just moving the declaration).

-Tony

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

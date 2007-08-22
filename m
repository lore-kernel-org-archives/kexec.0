Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1INysf-0001gL-SX
	for kexec@lists.infradead.org; Wed, 22 Aug 2007 18:40:56 -0400
Date: Wed, 22 Aug 2007 15:40:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] vmcoreinfo support for dump filtering
Message-Id: <20070822154036.1bd2f360.akpm@linux-foundation.org>
In-Reply-To: <20070822210838oomichi@mail.jp.nec.com>
References: <20070822210838oomichi@mail.jp.nec.com>
Mime-Version: 1.0
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
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@in.ibm.com>

On Wed, 22 Aug 2007 21:08:38 +0900
"Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:

> 
> Hi Andrew,
> 
> This patch set frees the restriction that makedumpfile users should
> install a vmlinux file (including the debugging information) into
> each system.
> 
> makedumpfile command is the dump filtering feature for kdump.
> It creates a small dumpfile by filtering unnecessary pages for the
> analysis. To distinguish unnecessary pages, it needs a vmlinux file
> including the debugging information. These days, the debugging package
> becomes a huge file, and it is hard to install it into each system.
> 
> To solve the problem, kdump developers discussed it at lkml and kexec-ml.
> As the result, we reached the conclusion that necessary information
> for dump filtering (called "vmcoreinfo") should be embedded into the
> first kernel file and it should be accessed through /proc/vmcore
> during the second kernel.
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.0/1806.html) 
> 
> Dan Aloni created the patch set for the above implementation.
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.1/1053.html)
> 
> And I updated it for multi architectures and memory models.
> (http://lists.infradead.org/pipermail/kexec/2007-August/000479.html)

so...  will this permit us to generate kdump files whcih don't have any
pagecache or anonymous memory in them?


> +void vmcoreinfo_append_str(const char *fmt, ...);

This should have suitable __attribute__s so that the compiler can check its
use.    See many examples in include/linux/kernel.h, around line 120.

> +/* vmcoreinfo stuff */
> +unsigned char vmcoreinfo_data[VMCOREINFO_BYTES];
> +u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
> +unsigned int vmcoreinfo_size = 0;

Please always run scripts/checkpatch.pl against your diffs.

> +unsigned int vmcoreinfo_max_size = sizeof(vmcoreinfo_data);

unsigned int = size_t?  Perhaps vmcoreinfo_max_size should have size_t
type?

> +void crash_save_vmcoreinfo(void)
> +{
> +	u32 *buf;
> +
> +	if (!vmcoreinfo_size)
> +		return;
> +
> +	vmcoreinfo_append_str("CRASHTIME=%d", xtime.tv_sec);

open-coded access to xtime probably isn't appropriate here.  Consider using
get_seconds().  That might be more accurate on tickless kernels, too.


> +	buf = (u32 *)vmcoreinfo_note;
> +
> +	buf = append_elf_note(buf, VMCOREINFO_NOTE_NAME, 0, vmcoreinfo_data,
> +			      vmcoreinfo_size);
> +
> +	final_note(buf);
> +}
> +
> +}
> +
> +static int __init crash_save_vmcoreinfo_init(void)
> +{
> +	vmcoreinfo_append_str("OSRELEASE=%s\n", UTS_RELEASE);
> +	vmcoreinfo_append_str("PAGESIZE=%d\n", PAGE_SIZE);

I expect the virtualisation guys would be bothered by an open-coded access
to UTS_RELEASE.  I guess it doesn't matter much here, but perhaps it'd be
setting a better example to use init_uts_ns.name.release?



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

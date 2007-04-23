Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HfriR-0000ab-RO
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 02:08:01 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3N67peH005374
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:07:51 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3N67p3t525084
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:07:51 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3N67oR6028510
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 02:07:51 -0400
Date: Mon, 23 Apr 2007 11:37:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 2/2] x86_64: Remove CONFIG_PHYSICAL_START and
	CONFIG_RELOCATABLE
Message-ID: <20070423060739.GA14664@in.ibm.com>
References: <20070331232957.e1c93f19.akpm@linux-foundation.org>
	<20070402074159.GA13704@in.ibm.com>
	<m1abxrf9o3.fsf@ebiederm.dsl.xmission.com>
	<20070402094520.GC13704@in.ibm.com>
	<m1648eg01d.fsf@ebiederm.dsl.xmission.com>
	<20070403040152.GA5108@in.ibm.com>
	<m1zm5qc9q2.fsf@ebiederm.dsl.xmission.com>
	<20070403100349.GA21759@in.ibm.com>
	<m18xcjznbm.fsf_-_@ebiederm.dsl.xmission.com>
	<m14pn7zn5n.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m14pn7zn5n.fsf_-_@ebiederm.dsl.xmission.com>
Reply-To: vgoyal@in.ibm.com
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, Kexec Mailing List <kexec@lists.infradead.org>, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org, Magnus Damm <magnus@valinux.co.jp>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>

On Sun, Apr 22, 2007 at 11:15:48PM -0600, Eric W. Biederman wrote:
> 
> Now that the vmlinux is marked as relocatable there is no reason to
> retain the CONFIG_PHYSICAL_START option, as we can put the binary we
> have at any 2MB aligned address in memory.
> 
> With CONFIG_PHYSICAL_START gone the handful of code lines that depend
> on CONFIG_RELOCATABLE no longer make sense to be conditional and can
> be removed.
> 
> The big win of this patch (besides Kconfig simplicity) is that the
> nasty BUILD_BUG_ON test for people misaligning their kernel when using
> CONFIG_PHYSICAL_START can be removed as this case can only happen with
> CONFIG_PHYSICAL_START selected.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/x86_64/Kconfig                |   55 +-----------------------------------
>  arch/x86_64/Makefile               |    2 -
>  arch/x86_64/boot/compressed/head.S |   13 +--------
>  arch/x86_64/boot/setup.S           |    4 --
>  arch/x86_64/defconfig              |    2 -
>  arch/x86_64/kernel/head64.c        |    7 ----
>  include/asm-x86_64/page.h          |    2 +-
>  7 files changed, 3 insertions(+), 82 deletions(-)
> 
> diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
> index 773b487..713c1ad 100644
> --- a/arch/x86_64/Kconfig
> +++ b/arch/x86_64/Kconfig
> @@ -565,62 +565,9 @@ config CRASH_DUMP
>            which are loaded in the main kernel with kexec-tools into
>            a specially reserved region and then later executed after
>            a crash by kdump/kexec. The crash dump kernel must be compiled
> -	  to a memory address not used by the main kernel or BIOS using
> -	  PHYSICAL_START.
> +	  to a memory address not used by the main kernel or BIOS
>            For more details see Documentation/kdump/kdump.txt

Hi Eric,

I think "must be compiled" should be replaced with "must be loaded" now.

Otherwise both the patches look fine.  I am planning to test these.

This change will also require modifications to Documentation/kdump/kdump.txt
file.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.181])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K5Lts-0001iD-On
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 14:29:41 +0000
Received: by wa-out-1112.google.com with SMTP id v33so1204966wah.2
	for <kexec@lists.infradead.org>; Sun, 08 Jun 2008 07:29:39 -0700 (PDT)
Date: Sun, 8 Jun 2008 22:26:06 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080608142606.GE2487@hacking>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080608134629.743220278@halley.suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

On Sun, Jun 08, 2008 at 03:46:30PM +0200, Bernhard Walle wrote:
>This patch adds a 'flags' parameter to reserve_bootmem_generic() like it
>already has been added in reserve_bootmem() with commit
>72a7fe3967dbf86cb34e24fbf1d957fe24d2f246.
>
>It also changes all users to use BOOTMEM_DEFAULT, which doesn't effectively
>change the behaviour. Since the change is x86-specific, I don't think it's
>necessary to add a new API for migration. There are only 4 users of that
>function.
>
>The change is necessary for the next patch, using reserve_bootmem_generic()
>for crashkernel reservation.
>
>
>Signed-off-by: Bernhard Walle <bwalle@suse.de>
>
>---
> arch/x86/kernel/e820_64.c |    3 ++-
> arch/x86/kernel/efi_64.c  |    3 ++-
> arch/x86/kernel/mpparse.c |    5 +++--
> arch/x86/mm/init_64.c     |   17 ++++++++++++-----
> include/asm-x86/proto.h   |    2 +-
> 5 files changed, 20 insertions(+), 10 deletions(-)
>
>--- a/arch/x86/kernel/e820_64.c
>+++ b/arch/x86/kernel/e820_64.c
>@@ -118,7 +118,8 @@ void __init early_res_to_bootmem(unsigne
> 			continue;
> 		printk(KERN_INFO "  early res: %d [%lx-%lx] %s\n", i,
> 			final_start, final_end - 1, r->name);
>-		reserve_bootmem_generic(final_start, final_end - final_start);
>+		reserve_bootmem_generic(final_start, final_end - final_start,
>+			BOOTMEM_DEFAULT);
> 	}
> }
> 
>--- a/arch/x86/kernel/efi_64.c
>+++ b/arch/x86/kernel/efi_64.c
>@@ -100,7 +100,8 @@ void __init efi_call_phys_epilog(void)
> void __init efi_reserve_bootmem(void)
> {
> 	reserve_bootmem_generic((unsigned long)memmap.phys_map,
>-				memmap.nr_map * memmap.desc_size);
>+				memmap.nr_map * memmap.desc_size,
>+				BOOTMEM_DEFAULT);
> }

Just one comment.

Since 'reserve_bootmem_generic' is changed from 'void' to 'int',
we should check its return value for failure when possible, right?


-- 
Hi, I'm a .signature virus, please copy/paste me to help me spread
all over the world.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

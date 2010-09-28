Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE008.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1P0cOr-0006ou-KQ
	for kexec@lists.infradead.org; Tue, 28 Sep 2010 15:47:26 +0000
Subject: Re: Can't kexec/kdump on mpc85xx
MIME-Version: 1.0 (Apple Message framework v1081)
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <4CA163C5.1060704@miraclelinux.com>
Date: Tue, 28 Sep 2010 10:47:33 -0500
Message-ID: <F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
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
To: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
Cc: kexec@lists.infradead.org


On Sep 27, 2010, at 10:40 PM, Makito SHIOKAWA wrote:

>> First off, what SHA of the kernel are you using? It looks like 2.6.35 should have the patches you need, but I want to double check. Also, how did you compile kexec-tools? Cross compile? What compiler are you using?
> 
> As kernel, I used vanilla 2.6.35. (http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.35.tar.gz. Git commit should be 9fe6206f400646a2322096b56c59891d530e8d51)

Ok, that should have all you need.... there are a few more patches but those are mostly for SMP systems. I will try to locate a 8548 board sometime if we can't get this working.

> 
> As cross compiler, I used "Sourcery G++ Lite 4.4-254 for Power GNU/Linux". (http://www.codesourcery.com/sgpp/lite/power/portal/package6842/public/powerpc-linux-gnu/freescale-4.4-254-powerpc-linux-gnu-i686-pc-linux-gnu.tar.bz2).
> 
> I cross compiled kernel, kexec-tools on x86 host with it.

Can you try this patch below when building kexec-tools? I ran in to an issue with my cross compiler...

diff --git a/purgatory/Makefile b/purgatory/Makefile
index ea0c19a..a558ed9 100644
--- a/purgatory/Makefile
+++ b/purgatory/Makefile
@@ -47,7 +47,7 @@ purgatory/sha256.o: $(srcdir)/util_lib/sha256.c
 $(PURGATORY): CC=$(TARGET_CC)
 $(PURGATORY): CFLAGS+=$(PURGATORY_EXTRA_CFLAGS) \
 		      $($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
-		      -Os -fno-builtin -ffreestanding
+		      -O0 -fno-builtin -ffreestanding
 
 $(PURGATORY): CPPFLAGS=$($(ARCH)_PURGATORY_EXTRA_CFLAGS) \
 			-I$(srcdir)/purgatory/include \


-M

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

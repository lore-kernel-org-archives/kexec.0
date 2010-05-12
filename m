Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from moutng.kundenserver.de ([212.227.126.187])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1OC6Gs-00004s-PH
	for kexec@lists.infradead.org; Wed, 12 May 2010 07:22:23 +0000
Message-ID: <4BEA5726.50806@nerdbynature.de>
Date: Wed, 12 May 2010 00:22:14 -0700
From: Christian Kujau <lists@nerdbynature.de>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
References: <20100511174749.19309.44615.stgit@muvarov>
In-Reply-To: <20100511174749.19309.44615.stgit@muvarov>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: kexec@lists.infradead.org, uvarov@dev.rtsoft.ru, linuxppc-dev@lists.ozlabs.org, horms@verge.net.au, cbouatmailru@gmail.com

On Tue, 11 May 2010 at 21:47, Maxim Uvarov wrote:
> This patch is required in case if you are using new toolchains.

After kexec-tools compiled, I actually tried it:

# kexec -l /boot/2.6/zImage --command-line="root=/dev/hda6 ro"
# echo $?
0
# kexec -e
Starting new kernel
Bye!

....but then the system just hung there, no more messages, I had to
powercycle it.

The --debug options is listed for "dol-ppc" systems (I have a PowerBook
G4, not sure if this falls into this category), when I use it the help
screen of kexec is displayed again and at the bottom:

   Cannot load /boot/2.6/zImage


This is with 2.6.34-rc7 (today's git):

# file /boot/2.6/zImage
/boot/2.6/zImage: ELF 32-bit MSB executable, PowerPC or cisco 4500,
version 1 (SYSV), statically linked, with unknown capability 0x41000000
= 0x11676e75, with unknown capability 0x10000 = 0x90402, not stripped


.config and dmesg: http://nerdbynature.de/bits/2.6.34-rc7/kexec/

Christian.
-- 
make bzImage, not war

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

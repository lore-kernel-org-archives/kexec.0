Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.gmx.net ([213.165.64.20])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MdHab-0006aO-Mn
	for kexec@lists.infradead.org; Tue, 18 Aug 2009 05:50:38 +0000
Message-ID: <4A8A4121.2060100@gmx.de>
Date: Tue, 18 Aug 2009 07:50:25 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
MIME-Version: 1.0
Subject: Re: vmcore file 0 size in x86_64
References: <OF7433B9C5.3D5E2748-ON65257611.0037CE47-65257611.0037EEDB@tcs.com>	<OF8B20E4B3.38CCED3C-ON65257611.003DC8CE-65257611.00461ED3@tcs.com>
	<4A88F864.2000006@mxs.nes.nec.co.jp>
In-Reply-To: <4A88F864.2000006@mxs.nes.nec.co.jp>
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
To: kexec@lists.infradead.org

Ken'ichi Ohmichi schrieb:
> 
> If compiling your user space program with tree options
> (-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE),
> it can access the high memory.

And it's important that you load the crashkernel with

 % kexec ... --elf64-core-headers

or at least *without* --elf32-core-headers since there is an
auto-detection in 'new' versions of kexec.


Regards,
Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-sin.frontbridge.com ([207.46.51.80]
	helo=outbound1-sin-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZG48-0004G7-Dx
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 01:47:37 +0000
Message-ID: <47D7349E.90409@am.sony.com>
Date: Tue, 11 Mar 2008 18:40:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>		<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>		<47D19114.1090700@am.sony.com>	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>	<47D6B92D.2020205@am.sony.com>
	<47D6D406.8050209@am.sony.com> <47D73003.8060208@bluelane.com>
In-Reply-To: <47D73003.8060208@bluelane.com>
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
To: piet@bluelane.com
Cc: Rajasekaran P <rajasekaran83@gmail.com>, kexec@lists.infradead.org

Pete/Piet Delaney wrote:
> Geoff Levand wrote:
> | Geoff Levand wrote:
> |> Rajasekaran P wrote:
> |>> Hi Geoff,
> |>> Thanks for your information.
> |>>
> |>> I used latest kexec tools with 2.6.23 kernel built with ps3_defconfig.
> |>> This kernel boots normally on PS3. But when I  add "crashkernel"
> |>> argument, it goes on hang.
> |>>
> |>> # kexec --command-line="video=ps3fb:mode:166 rhgb root=/dev/ps3da3
> |>> crashkernel=128M@32M" \
> |>> --initrd=/boot/initrd-2.6.23.img \
> |>> -l /boot/vmlinux-2.6.23
> |>>
> |>> # taskset 1 kexec e
> |>>
> |>> Nothing happens after this. As you said earlier in your mail, I am not
> |>> getting any PRINTK outputs from kernel on screen.
> 
> I was wondering about bringing in the printf() code from purgatory
> and using that to print info about what's going on in the kexec code.
> The standalone printf() might come in handy in other places; Ex: kgdb
> stub. If it was in a library it could also be used during kernel
> decompression to inform on problems occurring, like checksum errors.

When the first stage kernel goes down it releases all hypervisor
resources so that whatever boots next can successful open those
resources.  The frame buffer is one of those resources that are
released, and after it is, there will be no more output to the
display until the second stage image brings up its display.  It
is not a matter of adding print statements or string formatting.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

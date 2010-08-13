Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok3PP-0000EW-IL
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 23:11:32 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<4C65C630.4070008@zytor.com>
	<987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
Date: Fri, 13 Aug 2010 16:11:20 -0700
In-Reply-To: <987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
	(Tony Luck's message of "Fri, 13 Aug 2010 15:33:56 -0700")
Message-ID: <m1r5i2kt0n.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH][EFI] Run EFI in physical mode
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
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

"Luck, Tony" <tony.luck@intel.com> writes:

>> does this affect ia64 in any way?
>
> I remember Eric complaining that set_virtual_address_map() was a one
> way trap door with no way to get back to physical mode ... and thus
> this was a big problem to support kexec on ia64. And yet we still call
> it, and ia64 can do kexec. So some other work around must have been
> found. Can't immediately remember what it was though.

There is a hack in the code someplace on ia64 to pass the virtual
address efi was mapped at to the next kernel, and have the kernel make
certain to use efi there, without calling set_virtual_address_map().
For similar kernels that is fine at some point I expect kernel
divergence will make that scheme unworkable.  Essentially this is the
same as using physical addresses but starting with the virtual addresses.

For ia64 I seem to recall some weird floating point fixup routines that
benefited from the speed set_virtual_address_map() provided.  For x86_64
where the primary (sole?) reason for enabling EFI handling is to set efi
variables from linux, I don't see a case where enabling virtual mode
makes sense.  If EFI stays around on x86, always running the calls in
physical mode and in other ways slowly decreasing our dependence on
perfect efi implementations seems necessary.

As to Peter's question I did not see any of that code that affected
anything that ia64 used.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

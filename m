Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I2vNe-00006x-G6
	for kexec@lists.infradead.org; Mon, 25 Jun 2007 16:41:54 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: kexec-tools unknown rel relocation: 9
References: <467E5422.60604@impulze.org>
Date: Mon, 25 Jun 2007 14:41:29 -0600
In-Reply-To: <467E5422.60604@impulze.org> (Daniel Mierswa's message of "Sun,
	24 Jun 2007 13:23:14 +0200")
Message-ID: <m1y7i7u5qe.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
To: Daniel Mierswa <impulze@impulze.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Daniel Mierswa <impulze@impulze.org> writes:

> Hi there...
> i'm struggling with kexec-tools on that particular machine for good a year
> now... it never seemed to work on that machine so it might not be the software
> itself but i wonder if you could manage to give me a hint on where it particular
> goes kaboom
> from the source i cannot dig anything except the switch statement which boils
> out with unknown rel relocation if a specific r_type is not matched.
>
>
> barad-dur i386 # kexec --debug --type=bzImage --append="init=/linuxrc rw
> root=/dev/ram0 real_root=/dev/vg/ROOT lvm=vg
> crypt0=sda:8:0:router.sda.key:wd91ultra2" --initrd=/boot/initrd-new.gz --load
> /boot/vmlinuz-2.6.20-hardened-r5
> Unknown rel relocation: 9
>
> the version i'm using is
> kexec-tools-testing 20070330-git released 30th March 2007
>
> but it's the same error with any other version :)

That is a generic software bug.  
Either /sbin/kexec needs to handle R_386_GOT_OFF or you need to
switch to a different set of build tools.

What are you compiler, linker, and assembler versions?
Just so we have a chance of reproducing this problem.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

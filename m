Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JqtUO-0001m0-PX
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 17:19:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
	<m163u8oeli.fsf@frodo.ebiederm.org>
	<20080428102213.63eeaba1@strauss.suse.de>
	<m1bq3t50fq.fsf@frodo.ebiederm.org>
	<20080429175826.4a891110@strauss.suse.de>
Date: Tue, 29 Apr 2008 10:15:13 -0700
In-Reply-To: <20080429175826.4a891110@strauss.suse.de> (Bernhard Walle's
	message of "Tue, 29 Apr 2008 17:58:26 +0200")
Message-ID: <m1fxt44m72.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec --real-mode
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
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

Bernhard Walle <bwalle@suse.de> writes:

> * Eric W. Biederman [2008-04-28 10:55]:
>> 
>> It is a different code path.  It is designed to exercise the 16bit BIOS
>> calls that the kernel uses with a lot of serial port debugging
>> so we can see if that is the problem.
>
> Well, that gives me 
> ------------------------------------------------------------
> I'm in purgatory
> kexec_test 20080324 starting...
> eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 00000000
> esi: 00000000 edi: 00000000 esp: 00008FF8 ebp: 00000000
> idt: 00000000 00000000
> gdt: 0000006F 00005BA0
> Switching descriptors.
> Descriptors changed.
> Legacy pic setup.
> In real mode.
> Interrupts enabled.
> Base memory size: 0276
> A20 disabled.
> E820 Memory Map.
> 000000000009D800 @ 0000000000000000 type: 00000001
> 0000000000002800 @ 000
> ------------------------------------------------------------
>
> Yes, the output stops here. Don't know why ...

Ok.  I'm guessing that whatever it is immediately after
the e820 map dump causes the box to go south.

But this is a very good clue that your BIOS just can't
handle being run after the linux kernel has run at
this point.  Unfortunately this is common and why
the --real-mode switch has not been the default for several years.

What is your interest in getting the --real-mode option working at this
point?

After this point the debugging starts to get very laborious.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

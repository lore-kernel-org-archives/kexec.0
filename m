Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JqsCn-0004As-Ls
	for kexec@lists.infradead.org; Tue, 29 Apr 2008 15:57:25 +0000
Date: Tue, 29 Apr 2008 17:58:26 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: kexec --real-mode
Message-ID: <20080429175826.4a891110@strauss.suse.de>
In-Reply-To: <m1bq3t50fq.fsf@frodo.ebiederm.org>
References: <20080422151622.43c85a00@strauss.suse.de>
	<e2ed954f0804221644y436bd6cdoeb1fed2fd5d04ccb@mail.gmail.com>
	<20080423103400.6e3d9d90@strauss.suse.de>
	<m163u8oeli.fsf@frodo.ebiederm.org>
	<20080428102213.63eeaba1@strauss.suse.de>
	<m1bq3t50fq.fsf@frodo.ebiederm.org>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Jamey Sharp <jamey@thetovacompany.com>

* Eric W. Biederman [2008-04-28 10:55]:
> 
> It is a different code path.  It is designed to exercise the 16bit BIOS
> calls that the kernel uses with a lot of serial port debugging
> so we can see if that is the problem.

Well, that gives me 
------------------------------------------------------------
I'm in purgatory
kexec_test 20080324 starting...
eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00008FF8 ebp: 00000000
idt: 00000000 00000000
gdt: 0000006F 00005BA0
Switching descriptors.
Descriptors changed.
Legacy pic setup.
In real mode.
Interrupts enabled.
Base memory size: 0276
A20 disabled.
E820 Memory Map.
000000000009D800 @ 0000000000000000 type: 00000001
0000000000002800 @ 000
------------------------------------------------------------

Yes, the output stops here. Don't know why ...



        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

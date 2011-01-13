Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PdQnD-0002Py-7I
	for kexec@lists.infradead.org; Thu, 13 Jan 2011 17:17:00 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <F7CB3D97D99F33indou.takao@jp.fujitsu.com>
	<4D06E7FE.5000600@jp.fujitsu.com>
	<9CB9BB8ED64BAindou.takao@jp.fujitsu.com>
	<20110113163838.GA21289@srcf.ucam.org>
Date: Thu, 13 Jan 2011 09:16:26 -0800
In-Reply-To: <20110113163838.GA21289@srcf.ucam.org> (Matthew Garrett's message
	of "Thu, 13 Jan 2011 16:38:38 +0000")
Message-ID: <m1bp3kbu6t.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2][EFI] Run EFI in physical mode
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
To: Matthew Garrett <mjg@redhat.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, nhorman@tuxdriver.com, hpa@zytor.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com

Matthew Garrett <mjg@redhat.com> writes:

> We're seeing issues with some Dell hardware when EFI is run in physical 
> mode - it seems that Windows uses virtual mode, so the physical path is 
> never exercised. I'm not sure that changing the default to physical is 
> going to be possible without compatibility issues.

The bootloaders use physical mode, and there shouldn't be a separate
physical vs virtual mode.  It should be the same code with or without
relocations applied.  At worst we can set virtual address to the
physical address, on buggy boards.

Honestly if the problem is the EFI code is so buggy we can't use it
in physical mode the answer is almost certainly not to use the
buggy EFI code.

The only bits that I don't think have an alternative are the firmware
variable accesses.   Which are a nice to have, but not a show stopper
anywhere.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

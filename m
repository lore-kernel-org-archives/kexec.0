Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Odquf-0003oN-Of
	for kexec@lists.infradead.org; Tue, 27 Jul 2010 20:38:10 +0000
Subject: Re: [PATCH] Enable kdump with EFI boot
References: <C0CB2D0F31868Bindou.takao@jp.fujitsu.com>
	<20100727111029.GA6303@hmsreliant.think-freely.org>
	<m1eieolsy6.fsf@fess.ebiederm.org>
	<C1CB2DC4DB0586indou.takao@jp.fujitsu.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 27 Jul 2010 13:38:00 -0700
In-Reply-To: <C1CB2DC4DB0586indou.takao@jp.fujitsu.com> (Takao Indoh's message
	of "Tue\, 27 Jul 2010 15\:49\:42 -0400")
Message-ID: <m1pqy8ek47.fsf@fess.ebiederm.org>
MIME-Version: 1.0
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

Takao Indoh <indou.takao@jp.fujitsu.com> writes:

> If SetVirtualAddressMap is not called in 1st kernel, EFI system table 
> keeps its physical address, so it's ok, my patch is not needed. Did
> anyone post a patch to do that, or anyone are trying that?

Not that I know of.  What I have heard people doing is not using any
of the kernel efi support at all, in which case everything just works.
Certainly that is what my friends at sgi are doing.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

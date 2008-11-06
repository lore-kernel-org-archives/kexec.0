Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173003pub.verizon.net ([206.46.173.3])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KyDMM-0001v8-Bm
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 22:29:50 +0000
Received: from localhost.localdomain ([96.237.168.40])
	by vms173003.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K9X0089CN94HVB0@vms173003.mailsrvcs.net> for
	kexec@lists.infradead.org; Thu, 06 Nov 2008 16:17:28 -0600 (CST)
Date: Thu, 06 Nov 2008 17:17:25 -0500 (EST)
From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
In-reply-to: <20081106215011.GA6391@srcf.ucam.org>
Message-id: <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
MIME-version: 1.0
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
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
To: Matthew Garrett <mjg@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Avi Kivity <avi@redhat.com>



> > My expectation is that with the ACPI default, our problem
> > is working around a finite list of old machines that don't work;
> > while with the default KBD, our problem is working around
> > a potentially unbounded list of yet to be shipped machines
> > who may only be tested and work using the ACPI method.
> 
> Does Windows default to using the ACPI method now?

That is my guess, based on the fact that we've seen
newer machines that don't reboot w/o using the ACPI reset reg.

-Len

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

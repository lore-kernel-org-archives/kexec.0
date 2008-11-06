Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6] helo=vavatch.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KyEDO-0001Po-8d
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 23:24:38 +0000
Date: Thu, 6 Nov 2008 23:24:19 +0000
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Message-ID: <20081106232419.GA8007@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
	<alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
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
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Avi Kivity <avi@redhat.com>

On Thu, Nov 06, 2008 at 05:17:25PM -0500, Len Brown wrote:
> > Does Windows default to using the ACPI method now?
> 
> That is my guess, based on the fact that we've seen
> newer machines that don't reboot w/o using the ACPI reset reg.

We've seen machines that won't reboot for a variety of reasons in the 
past. In some cases this has seemed to be due to hardware being in a 
state that the BIOS didn't expect. Hitting the SMI trap behind the ACPI 
register might work around this, but I suspect that in many cases we 
could achieve the same effect by spending more time trying to work out 
whether there's any common themes in the failures.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KyFc2-0005Bf-7l
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 00:54:10 +0000
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
From: Zhao Yakui <yakui.zhao@intel.com>
In-Reply-To: <alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
	<alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
Date: Fri, 07 Nov 2008 09:01:19 +0800
Message-Id: <1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
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
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Matthew Garrett <mjg@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Avi Kivity <avi@redhat.com>

On Fri, 2008-11-07 at 06:17 +0800, Len Brown wrote:
> 
> > > My expectation is that with the ACPI default, our problem
> > > is working around a finite list of old machines that don't work;
> > > while with the default KBD, our problem is working around
> > > a potentially unbounded list of yet to be shipped machines
> > > who may only be tested and work using the ACPI method.
> > 
> > Does Windows default to using the ACPI method now?
> 
> That is my guess, based on the fact that we've seen
> newer machines that don't reboot w/o using the ACPI reset reg.
With the help of KVM I find that the windows will be rebooted by writing
RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
zero(It indicates whether ACPI reboot is supported).
IMO maybe the ACPI reboot is the first choice. If it can't, then it will
fall back to other mode.

Thanks.
> 
> -Len
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

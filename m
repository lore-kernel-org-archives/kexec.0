Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cavan.codon.org.uk ([93.93.128.6] helo=vavatch.codon.org.uk)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KyFhs-0007LP-3L
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 01:00:12 +0000
Date: Fri, 7 Nov 2008 00:59:46 +0000
From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Message-ID: <20081107005946.GA9254@srcf.ucam.org>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
	<alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
	<1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
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
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>, Avi Kivity <avi@redhat.com>

On Fri, Nov 07, 2008 at 09:01:19AM +0800, Zhao Yakui wrote:

> With the help of KVM I find that the windows will be rebooted by writing
> RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
> zero(It indicates whether ACPI reboot is supported).
> IMO maybe the ACPI reboot is the first choice. If it can't, then it will
> fall back to other mode.

Hmm. But we're seeing some machines that end up very confused if 
rebooted via ACPI. I guess we need to run Vista on them to find out how 
they behave. What OSI strings did your KVM setup expose? We know that 
Windows changes behaviour under various circumstances depending on which 
OS the firmware requests, so it's almost possible that this is another 
of those cases.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

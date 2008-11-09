Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kz7GZ-0003IH-Bs
	for kexec@lists.infradead.org; Sun, 09 Nov 2008 10:11:36 +0000
Message-ID: <4916B737.7050107@redhat.com>
Date: Sun, 09 Nov 2008 12:11:03 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
	<200811061853.08003.arvidjaar@mail.ru>
	<alpine.LFD.2.00.0811061442590.3106@localhost.localdomain>
	<20081106215011.GA6391@srcf.ucam.org>
	<alpine.LFD.2.00.0811061716420.3106@localhost.localdomain>
	<1226019679.3989.107.camel@yakui_zhao.sh.intel.com>
	<20081107005946.GA9254@srcf.ucam.org>
In-Reply-To: <20081107005946.GA9254@srcf.ucam.org>
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
Cc: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>

Matthew Garrett wrote:
> Hmm. But we're seeing some machines that end up very confused if 
> rebooted via ACPI. I guess we need to run Vista on them to find out how 
> they behave. What OSI strings did your KVM setup expose? We know that 
> Windows changes behaviour under various circumstances depending on which 
> OS the firmware requests, so it's almost possible that this is another 
> of those cases.
>   

Isn't it the other way around?  The firmware changes behavior depending 
on how the OS identifies itself?

Reboot is a fixed feature IIRC, so it cannot change depending on 
identification strings.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

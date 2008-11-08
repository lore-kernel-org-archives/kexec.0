Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ogre.sisk.pl ([217.79.144.158])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KywJ6-0001qr-6P
	for kexec@lists.infradead.org; Sat, 08 Nov 2008 22:29:28 +0000
From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Date: Sat, 8 Nov 2008 23:32:22 +0100
References: <fa.UVpnVba3yRAWG3rGZ0sk20JE9hs@ifi.uio.no>
	<fa.ckUqcrtVKbxAkjNggIdajBTHr9Q@ifi.uio.no>
	<49139A43.4000203@shaw.ca>
In-Reply-To: <49139A43.4000203@shaw.ca>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200811082332.24125.rjw@sisk.pl>
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
To: Robert Hancock <hancockr@shaw.ca>, Matthew Garrett <mjg@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Eduardo Habkost <ehabkost@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, Len Brown <lenb@kernel.org>

On Friday, 7 of November 2008, Robert Hancock wrote:
> Matthew Garrett wrote:
> > On Fri, Nov 07, 2008 at 09:01:19AM +0800, Zhao Yakui wrote:
> > 
> >> With the help of KVM I find that the windows will be rebooted by writing
> >> RESET_VALUE to RESET_REG I/O port if the RESET_REG_SUP bit is not
> >> zero(It indicates whether ACPI reboot is supported).
> >> IMO maybe the ACPI reboot is the first choice. If it can't, then it will
> >> fall back to other mode.
> > 
> > Hmm. But we're seeing some machines that end up very confused if 
> > rebooted via ACPI. I guess we need to run Vista on them to find out how 
> > they behave. What OSI strings did your KVM setup expose? We know that 
> > Windows changes behaviour under various circumstances depending on which 
> > OS the firmware requests, so it's almost possible that this is another 
> > of those cases.
> 
> Given that Windows behavior, this patch seems suspicious:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=8fd145917fb62368a9b80db59562c20576238f5a
> 
> This patch ignores the RESET_REG_SUP flag and just tries using the reset 
> register anyway if it thinks it's valid. So we may attempt ACPI reset on 
> machines which don't indicate it's supported.
> 
> The patch description mentioned that some machines didn't reboot after 
> S3 suspend without this patch. However, we recently had this patch merged:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a68823ee5285e65b51ceb96f8b13a5b4f99a6888
> 
> Is it possible that the problem fixed there is the true cause of this 
> reboot after S3 problem?

Generally, it is.

Should it regarded as -stable material, BTW, or is it already in -stable?

Matthew?

Thanks,
Rafael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

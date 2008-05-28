Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K1AYk-0005Qx-6J
	for kexec@lists.infradead.org; Wed, 28 May 2008 01:34:34 +0000
Subject: Re: [PATCH -mm] kexec jump -v9
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080527221514.GA20037@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080514205204.GJ30469@redhat.com>
	<1210830110.23707.141.camel@caritas-dev.intel.com>
	<20080516005121.GA6926@redhat.com>
	<1211873263.12819.103.camel@caritas-dev.intel.com>
	<20080527221514.GA20037@redhat.com>
Date: Wed, 28 May 2008 09:35:52 +0800
Message-Id: <1211938552.12819.122.camel@caritas-dev.intel.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Tue, 2008-05-27 at 18:15 -0400, Vivek Goyal wrote:
[...]
> > But, because IOAPIC may need to be in original state during
> > suspend/resume, so it is not appropriate to call disable_IO_APIC() in
> > ioapic_suspend(). So I think we can call disable_IO_APIC() in new
> > hibernation/restore callback.
> 
> My hunch is suspend/resume will still work if we put this call in
> ioapic_suspend() but I would not recommend that. suspend/resume does
> not need to put IOAPIC in legacy mode.
>   
> I am not sure what is "new hibernation/restore callback"? Are you
> referring to new patches from Rafel?

Yes. Rafel has a new patch to separate suspend and hibernation device
call backs.
http://kerneltrap.org/Linux/Separating_Suspend_and_Hibernation

> I think this issue is specifc to kexec and kjump so probably we should
> not tweaking any suspend/resume related bit.
> 
> How about calling disable_IO_APIC() in kexec_jump()? We can probably even
> optimize it by calling it only when we are transitioning into new image
> for the first time and not for subsquent transitions (by keeping some kind of
> count in kimage). This is little hackish but, should work...

Yes. This issue is kexec/kjump specific. We can call it in kexec_jump().
Maybe we also need call something other in native_machine_shutdown()?

BTW: I have a new version -v10: http://lkml.org/lkml/2008/5/22/106, do
you have time to review it?

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

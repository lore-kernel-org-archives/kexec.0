Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky5sR-0005Ui-Ju
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 14:30:28 +0000
Date: Thu, 6 Nov 2008 15:30:21 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
Message-ID: <20081106143021.GD13023@elte.hu>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<1225915018-6548-16-git-send-email-ehabkost@redhat.com>
	<20081106071445.GI15731@elte.hu> <20081106124031.GO5247@blackpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20081106124031.GO5247@blackpad>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>


* Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Thu, Nov 06, 2008 at 08:14:45AM +0100, Ingo Molnar wrote:
> > 
> > * Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > This reverts commit c7ffa6c26277b403920e2255d10df849bd613380.
> > > 
> > > Now that we have the hooks to disable virtualization on
> > > emergency_restart(), we can get back to the BOOT_KBD reboot_type default.
> > > 
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > 
> > hm, why revert this? There's nothing wrong with the ACPI reboot 
> > method, it's just that we surprise the BIOS by exiting with an unclean 
> > VMX state in certain circumstances.
> > 
> > if the ACPI reboot method does not work we do the KBD method as the 
> > next thing in the reboot chain.
> 
> I suppose there are cases where the new default broke without KVM, 
> and the suggestion was to disable VMX before rebooting instead of 
> changing the default.
> 
> Avi changed the default because on some machines reboot=kbd breaks 
> when VMX is enabled, but the regressions caused by the new default 
> doesn't necessarily involve VMX.

there's another reason as well: a growing quirk-list of machines where 
ACPI is the best (sometimes only) method to reboot.

> Andrey Borzenkov's patch, for example, adds a new DMI entry because 
> reboot=acpi breaks his keyboard (even without KVM, I guess). Andrey, 
> was that the case?

hm, IIRC the problem was KVM in his case too.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

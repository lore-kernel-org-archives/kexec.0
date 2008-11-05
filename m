Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kxqoz-0000GQ-4t
	for kexec@lists.infradead.org; Wed, 05 Nov 2008 22:26:06 +0000
Date: Wed, 5 Nov 2008 23:27:32 +0100
From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 09/15] x86: Emergency virtualization disable function
Message-ID: <20081105222731.GA14202@elf.ucw.cz>
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<1225915018-6548-10-git-send-email-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1225915018-6548-10-git-send-email-ehabkost@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>

On Wed 2008-11-05 17:56:52, Eduardo Habkost wrote:
> This patch adds an interface to set a function that can be used to
> disable virtualization extensions on the CPU on emergency cases, such
> as on kdump or emergency reboot.
> 
> The function will be set by code that enables virtualization extensions
> on the CPUs (i.e. KVM), and should do the very least to disable virt
> extensions on the CPU where it is being called.
> 
> The functions that set the function pointer uses RCU synchronization,
> just in case the crash NMI is triggered while KVM is unloading.
> 
> We can't just use the same notifiers used at reboot time (that are used
> by non-crash-dump kexec), because at crash time some CPUs may have IRQs
> disabled, so we can't use IPIs. The crash shutdown code use NMIs to tell
> the other CPUs to be halted, so the notifier call will be hooked into
> the CPU halting code that is on the crash shutdown NMI handler.
> 
> [v2: drop 'unsigned int cpu' arg from function]
> [v3: make emergency_virt_disable() non-static]
> [v4: add a config option for it: CPU_VIRT_EXTENSIONS]
> [v5: add has_virt_extensions() function]
> [v6: don't define the registering functions if CPU_VIRT_EXTENSIONS is
>  not enabled]
> [v7: use EXPORT_SYMBOL_GPL]
> 

> --- /dev/null
> +++ b/arch/x86/kernel/virtext.c
> @@ -0,0 +1,89 @@
> +/* Core CPU virtualization extensions handling
> + *
> + * This should carry the code for handling CPU virtualization extensions
> + * that needs to live in the kernel core.
> + *
> + * Author: Eduardo Habkost <ehabkost@redhat.com>
> + *
> + * Copyright (C) 2008, Red Hat Inc.
> + */

GPL?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

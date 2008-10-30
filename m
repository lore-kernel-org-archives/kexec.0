Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXur-0002ig-3v
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:50:25 +0000
Message-ID: <4909BBA7.1020307@redhat.com>
Date: Thu, 30 Oct 2008 15:50:31 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] kdump: crash-time virt disable function
References: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
	<1225373687-6960-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1225373687-6960-2-git-send-email-ehabkost@redhat.com>
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
Cc: Andrew Morton <akpm@osdl.org>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Eduardo Habkost wrote:
> This patch adds an interface to set a function to be called on crash time,
> on each CPU. The function will be set by code that enables virtualization
> extensions on the CPUs (i.e. KVM).  It will be called once on each CPU
> by machine_crash_shutdown(), and should do the very least to disable
> virt extensions on the CPU where it is being called.
>
> The function will be used by KVM to disable virtualization before halting
> the CPUs, otherwise the booting of the kdump kernel may hang. It does
> hang, when vmx is enabled, and I wouldn't be surprised if having svm
> enabled also causes problems.
>
> The functions that set the function pointer uses RCU synchronization,
> just in case the crash NMI is triggered while KVM is unloading.
>
> We can't just use the same notifiers used at reboot time (that are used
> by non-crash-dump kexec), because at crash time some CPUs may have IRQs
> disabled, so we can't use IPIs. The crash shutdown code use NMIs to
> tell the other CPUs to be halted, so the notifier call is hooked into
> the CPU halting code that is on the crash shutdown NMI handler.
>
> +static void (*virt_disable_fn)(unsigned int cpu);
>   

Since you never use the cpu argument, I suggest dropping it.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

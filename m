Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KvXgC-0000LX-VZ
	for kexec@lists.infradead.org; Thu, 30 Oct 2008 13:35:17 +0000
From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 0/6] kdump: disable virtualization extensions on crash (v2)
Date: Thu, 30 Oct 2008 11:34:40 -0200
Message-Id: <1225373687-6960-1-git-send-email-ehabkost@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>


Hi,

After some discussion, this is my second try to fix properly the kdump
hang when the kvm-intel module is loaded. I've kept the virtualization
code inside the KVM, and just used a function pointer that can be
registered by KVM to be called at crash time.


This series is for one of the alternatives for solving the problem. Other
alternatives that were discussed were:

a) Using a raw notifier chain (kernel/notifier.c) (the first version
   of this series)
   - This was dropped because the less code we have to rely on, the better,
     and it would make it too easy to break kdump
b) Always calling vmxoff, after hacking the #UD vector to ignore
   unknown opcode exceptions.
  - Too hackish in my opinion. And we don't need to hack #UD, anyway,
    if we can simply test CR4.VMXE (all our code that run vmxon/vmxoff
    toggle CR4.VMXE accordingly)
c) Moving the equivalent to the hardware_disable()/hardware_enable() API
   (and the vmx and svm implementations) from the KVM module to the kernel
   core, so the kernel core knows which CPUs have virtualization enabled,
   and disables virtualization without calling into the KVM module.
   - This wasn't completely discarded, but would move to the core a bunch
     of code that always lived in the KVM module.

-- 
Eduardo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

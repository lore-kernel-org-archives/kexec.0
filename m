Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx30.brocade.com ([144.49.194.4])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1LURX6-0007og-DH
	for kexec@lists.infradead.org; Tue, 03 Feb 2009 20:06:11 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: should kernel image destination address be picked up by kernel
	itself?
Date: Tue, 3 Feb 2009 12:06:02 -0800
Message-ID: <4C94DE2070B172459E4F1EE14BD2364E027DFC66@HQ-EXCH-5.corp.brocade.com>
In-Reply-To: <m14ozb1eom.fsf@fess.ebiederm.org>
References: <4C94DE2070B172459E4F1EE14BD2364E027534BA@HQ-EXCH-5.corp.brocade.com>
	<m14ozb1eom.fsf@fess.ebiederm.org>
From: "Ming Lei" <mlei@Brocade.COM>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org

Hi Eric,

I tried run latest kexec-tools v2.0 on ppc freescale 85xx platforms.

>- All of the policy decisions are made in user space (such as where to
>  execute from)
Is where to execute from the physical address or the virtual address?
How do we know it is available to kexec, it may be taken.

>- standalone executables are loaded into an address space where
>  physical address and virtual address are the same.
There may be case that physical address and virtual address not the same
on linux, such as vmalloc.

>What problem do you see in that model?
>Why is it a problem for you?

Can we put something like -1 to indicate to kernel that user space wants
kernel to choose the virtual address to load the standalone executable,
then linux kernel can kmalloc this area and then load the standalone
executable.

Thanks
Ming

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

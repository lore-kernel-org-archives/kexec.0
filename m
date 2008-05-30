Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.ctxuk.citrix.com ([62.200.22.115] helo=SMTP.EU.CITRIX.COM)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K25RJ-0003fr-17
	for kexec@lists.infradead.org; Fri, 30 May 2008 14:18:41 +0000
Date: Fri, 30 May 2008 15:18:10 +0100
Subject: Re: [Xen-devel] [PATCH] Add xen_phys_start value in the crash
	info note
From: Keir Fraser <keir.fraser@eu.citrix.com>
Message-ID: <C465CB32.2176B%keir.fraser@eu.citrix.com>
In-Reply-To: <20080530134554.1647.ODA@valinux.co.jp>
Mime-version: 1.0
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
To: Itsuro ODA <oda@valinux.co.jp>, xen-devel@lists.xensource.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

On 30/5/08 06:13, "Itsuro ODA" <oda@valinux.co.jp> wrote:

> This patch makes the vmcore utilities (ex. crash, makedumpfile) be
> able to get the relocation address of the xen hypervisor from a vmcore.
> It is necessary for the utilities to find the data of the hypervisor
> structures.
> 
> Note that this patch does not raise any comptibility issue for the
> utilities (which I know) nor the other components of xen.

Since it both changes the size of the crash_info elf note, and adds the new
field in the middle of the crash_info structure, how can it not affect
compatibility?

 -- Keir



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

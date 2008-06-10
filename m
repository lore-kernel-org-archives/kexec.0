Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vms173003pub.verizon.net ([206.46.173.3])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K69An-0006XW-DK
	for kexec@lists.infradead.org; Tue, 10 Jun 2008 19:06:25 +0000
Received: from localhost.localdomain ([72.93.254.151])
	by vms173003.mailsrvcs.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTPA id <0K2900A15E22M726@vms173003.mailsrvcs.net> for
	kexec@lists.infradead.org; Tue, 10 Jun 2008 13:01:16 -0500 (CDT)
Date: Tue, 10 Jun 2008 14:01:10 -0400 (EDT)
From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [PATCH -mm 2/2] kexec jump -v11: save/restore device
	state
In-reply-to: <1213082106.22608.30.camel@caritas-dev.intel.com>
Message-id: <alpine.LFD.1.10.0806101400090.14381@localhost.localdomain>
MIME-version: 1.0
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>



On Tue, 10 Jun 2008, Huang, Ying wrote:

> This patch implements devices state save/restore before after kexec.
> 
> 
> This patch together with features in kexec_jump patch can be used for
> following:
> 
> - A simple hibernation implementation without ACPI support. You can
>   kexec a hibernating kernel, save the memory image of original system
>   and shutdown the system. When resuming, you restore the memory image
>   of original system via ordinary kexec load then jump back.

What part of ACPI's role in hibernation are you trying to avoid
1. enabling wake devices
2. removing power from the system
3. something else?

thanks,
-Len

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

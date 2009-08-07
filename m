Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.gmx.net ([213.165.64.20])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MZX2s-0007cr-AO
	for kexec@lists.infradead.org; Fri, 07 Aug 2009 21:32:18 +0000
Message-ID: <4A7C9D48.3030405@gmx.de>
Date: Fri, 07 Aug 2009 23:31:52 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
MIME-Version: 1.0
Subject: Re: [Patch 0/7] Implement crashkernel=auto
References: <20090805112123.6552.73574.sendpatchset@localhost.localdomain>	<m1eirqtmey.fsf@fess.ebiederm.org>	<20090805140408.GJ7259@hmsreliant.think-freely.org>	<m1skg5vpgg.fsf@fess.ebiederm.org>
	<4A7A3A78.7080200@redhat.com>	<m1y6pxr737.fsf@fess.ebiederm.org>
	<4A7A506B.2060008@redhat.com>	<m1ljlxsiox.fsf@fess.ebiederm.org>
	<4A7A70E5.2010204@redhat.com>	<m1bpmtqxjh.fsf@fess.ebiederm.org>
	<4A7A7A0F.6070906@redhat.com>	<m1iqh1nxv3.fsf@fess.ebiederm.org>
	<4A7A9E54.60705@redhat.com> <m1iqgze740.fsf@fess.ebiederm.org>
In-Reply-To: <m1iqgze740.fsf@fess.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
Cc: Neil Horman <nhorman@redhat.com>, tony.luck@intel.com, linux-ia64@vger.kernel.org, Amerigo Wang <amwang@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, akpm@linux-foundation.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>

Eric W. Biederman schrieb:
> 
> With the current set of crashkernel= options we are asking the
> distribution installer to perform magic.  Moving as much of this logic
> into a normal init script for better maintenance is desirable.

Not (necessarily) the installer but the program that configures kdump.
system-config-kdump on Red Hat, YaST on SUSE.

> Bernhard does that sound useful to you?

I don't see any problems. I don't know how much effort is it to free
already reserved crashkernel memory, but I guess it's not really
complicated. Maybe that "1/32" should be specified on the command line like


	crashkernel=>>5

(for 1/32*system_memory == system_memory>>5), OTOH I have no real strong
opinion.


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

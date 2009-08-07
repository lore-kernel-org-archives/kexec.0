Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.gmx.net ([213.165.64.20])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MZWxM-0006bs-8n
	for kexec@lists.infradead.org; Fri, 07 Aug 2009 21:26:36 +0000
Message-ID: <4A7C9BF1.8070700@gmx.de>
Date: Fri, 07 Aug 2009 23:26:09 +0200
From: Bernhard Walle <bernhard.walle@gmx.de>
MIME-Version: 1.0
Subject: Re: [Patch 0/7] Implement crashkernel=auto
References: <4A7A3A78.7080200@redhat.com> <m1y6pxr737.fsf@fess.ebiederm.org>
	<4A7A506B.2060008@redhat.com> <m1ljlxsiox.fsf@fess.ebiederm.org>
	<4A7A70E5.2010204@redhat.com> <m1bpmtqxjh.fsf@fess.ebiederm.org>
	<4A7A7A0F.6070906@redhat.com>
	<m1iqh1nxv3.fsf@fess.ebiederm.org> <4A7A9E54.60705@redhat.com>
	<m1iqgze740.fsf@fess.ebiederm.org>
	<20090807210306.GA25609@basil.fritz.box>
In-Reply-To: <20090807210306.GA25609@basil.fritz.box>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: Neil Horman <nhorman@redhat.com>, tony.luck@intel.com, linux-ia64@vger.kernel.org, Amerigo Wang <amwang@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@linux-foundation.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>

Andi Kleen schrieb:
>> As an initial approximation I would use a 32nd of low memory.
> 
> That means a 1TB machine will have a 32GB crash kernel.
> 
> Surely that's excessive?!?
> 
> It would be repeating all the same mistakes people made with hash tables
> several years ago.

The idea of Eric was to shrink the reserved memory in an init script. I
doubt that the 1 TB machine will have any problems or performance issue
when booting with (1 TB - 32 GB) memory.

> It doesn't sound reasonable to Andi.
> 
> Why do you even want to grow the crash kernel that much? Is there
> any real problem with a 64-128MB crash kernel?

Try it out. No chance for 64-128MB crashkernel on "medium" IA64 machines.


Regards,
Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

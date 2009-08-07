Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from one.firstfloor.org ([213.235.205.2])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1MZWan-0002jB-7G
	for kexec@lists.infradead.org; Fri, 07 Aug 2009 21:03:17 +0000
Date: Fri, 7 Aug 2009 23:03:06 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [Patch 0/7] Implement crashkernel=auto
Message-ID: <20090807210306.GA25609@basil.fritz.box>
References: <4A7A3A78.7080200@redhat.com> <m1y6pxr737.fsf@fess.ebiederm.org>
	<4A7A506B.2060008@redhat.com> <m1ljlxsiox.fsf@fess.ebiederm.org>
	<4A7A70E5.2010204@redhat.com> <m1bpmtqxjh.fsf@fess.ebiederm.org>
	<4A7A7A0F.6070906@redhat.com>
	<m1iqh1nxv3.fsf@fess.ebiederm.org> <4A7A9E54.60705@redhat.com>
	<m1iqgze740.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Neil Horman <nhorman@redhat.com>, tony.luck@intel.com, linux-ia64@vger.kernel.org, Amerigo Wang <amwang@redhat.com>, Bernhard Walle <bernhard.walle@gmx.de>, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, akpm@linux-foundation.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>

> As an initial approximation I would use a 32nd of low memory.

That means a 1TB machine will have a 32GB crash kernel.

Surely that's excessive?!?

It would be repeating all the same mistakes people made with hash tables
several years ago.

> 
> That can be written to (with enough privileges when no crash kernel is
> loaded) reduce the amount of memory reserved by the crash kernel.
> 
> Bernhard does that sound useful to you?
> 
> Amerigo does that seem reasonable?

It doesn't sound reasonable to Andi.

Why do you even want to grow the crash kernel that much? Is there
any real problem with a 64-128MB crash kernel?

-Andi
> 

-- 
ak@linux.intel.com -- Speaking for myself only.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

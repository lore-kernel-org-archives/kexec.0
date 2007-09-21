Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYaRz-0005Gh-W4
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 00:49:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
	<200709211259.00195.nigel@nigel.suspend2.net>
Date: Thu, 20 Sep 2007 22:46:08 -0600
In-Reply-To: <200709211259.00195.nigel@nigel.suspend2.net> (Nigel Cunningham's
	message of "Fri, 21 Sep 2007 12:58:59 +1000")
Message-ID: <m1r6ksiq27.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

Nigel Cunningham <nigel@nigel.suspend2.net> writes:
>
> Sounds doable, as long as you can cope with long command lines (which 
> shouldn't be a biggie). (If you've got a swapfile or parts of a swap 
> partition already in use, it can be quite fragmented).

Hmm.  This is an interesting problem.  Sharing a swap file or a swap
partition with the actual swap of user space pages does seem to be
a limitation of this approach.

Although the fact that it is simple to write to a separate file may
be a reasonable compensation.

> Andrew, you're seeing that it really doesn't mean the removal of all 
> hibernation code from the kernel being suspended, aren't you? (And if the 
> kexec'd kernel is the same binary, then there's more code again).

More binary size yes not more code to maintain.

As for the rest the current implementation is small enough and allows
for enough beyond hibernation I think it makes sense to eventually
merge assuming a good clean implementation can be achieved.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

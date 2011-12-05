Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcaE-0005kT-8D
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:44:08 +0000
Received: by iaby26 with SMTP id y26so2008976iab.36
 for <kexec@lists.infradead.org>; Mon, 05 Dec 2011 09:44:05 -0800 (PST)
Date: Mon, 5 Dec 2011 09:43:49 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
Message-ID: <20111205174349.GG627@google.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
 <20111205171508.GC627@google.com>
 <4EDD019E.9010009@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EDD019E.9010009@linux.vnet.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: len.brown@intel.com, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, rdunlap@xenotime.net, ebiederm@xmission.com, pavel@ucw.cz

Hello,

On Mon, Dec 05, 2011 at 11:08:38PM +0530, Srivatsa S. Bhat wrote:
> Sorry, I didn't get what you meant here. Are you talking about what
> needs to be added/changed in the documentation or, are you referring
> to the code itself and are saying that we must make these APIs
> internal to the PM alone?

Ooh, sorry about not being clear.  I meant pm_mutex itself.  There's
no reason to expose that outside of pm, right?  And in the
documentation, we can just require use of the APIs instead of pm_mutex
itself.

Thank you.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

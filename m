Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXc8H-0006L7-UQ
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 17:15:14 +0000
Received: by mail-gx0-f177.google.com with SMTP id i1so6417180ggk.36
 for <kexec@lists.infradead.org>; Mon, 05 Dec 2011 09:15:13 -0800 (PST)
Date: Mon, 5 Dec 2011 09:15:08 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
Message-ID: <20111205171508.GC627@google.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
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

On Mon, Dec 05, 2011 at 01:33:42AM +0530, Srivatsa S. Bhat wrote:
> Update the documentation to explain the perils of directly using
> mutex_[un]lock(&pm_mutex) and recommend the usage of the safe
> APIs [un]lock_system_sleep() instead.

Maybe just make it pm internal?

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

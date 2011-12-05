Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RXcpg-0000kM-GY
 for kexec@lists.infradead.org; Mon, 05 Dec 2011 18:00:05 +0000
Received: by iaby26 with SMTP id y26so2029200iab.36
 for <kexec@lists.infradead.org>; Mon, 05 Dec 2011 10:00:01 -0800 (PST)
Date: Mon, 5 Dec 2011 09:59:54 -0800
From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] PM / Docs: Recommend the use of
 [un]lock_system_sleep() over mutex_[un]lock(&pm_mutex)
Message-ID: <20111205175954.GH627@google.com>
References: <20111204200208.25620.515.stgit@srivatsabhat.in.ibm.com>
 <20111204200332.25620.53610.stgit@srivatsabhat.in.ibm.com>
 <20111205171508.GC627@google.com>
 <4EDD019E.9010009@linux.vnet.ibm.com>
 <20111205174349.GG627@google.com>
 <4EDD05C6.8080809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4EDD05C6.8080809@linux.vnet.ibm.com>
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

On Mon, Dec 05, 2011 at 11:26:22PM +0530, Srivatsa S. Bhat wrote:
> Yes, that sounds good. No need for giving unnecessary choices :-)
> But I had worded the documentation that way with the intention of
> explaining why calling mutex_lock() over pm_mutex can be disastrous (which
> I mentioned in the commit message as one of the goals of the patch).
> I didn't mean it to give the user 2 choices and say please use
> [un]lock_system_sleep() preferably.
> 
> Although, we have to notice that unless somebody is acquainted with
> these APIs, the first instinct would probably be to directly use
> mutex_lock(), until they look up the documentation (hopefully).
> So, IMHO, it would do good to keep the explanation in the docs as
> it is, in this patch. What do you think?

Yeah, sounds good to me.

Thanks.

-- 
tejun

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K83qe-0006j5-Gm
	for kexec@lists.infradead.org; Mon, 16 Jun 2008 01:49:32 +0000
Subject: Re: [PATCH -mm 1/2] kexec jump -v11: kexec jump
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080613180059.GA4906@redhat.com>
References: <1213082104.22608.29.camel@caritas-dev.intel.com>
	<20080612192015.GH9654@redhat.com>
	<1213319040.20431.8.camel@caritas-dev.intel.com>
	<20080613180059.GA4906@redhat.com>
Date: Mon, 16 Jun 2008 09:52:21 +0800
Message-Id: <1213581141.7179.6.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Fri, 2008-06-13 at 14:00 -0400, Vivek Goyal wrote:
[...]
> Ok, I found that in my config CONFIG_HIBERNATION was not enabled. After
> enabling CONFIG_HIBERNATION, both suspend to disk and kjump started
> working.
> 
> Does that mean there is some dependency on code under CONFIG_HIBERNATION.
> If yes, I think this dependency should be resolved during compile time.
> May be addtional config option (CONFIG_KEXEC_JUMP), which also selects
> the CONFIG_HIBERNATION automatically etc...

Yes. kexec jump need to put devices into quiescent state and save
devices state into memory, which is implemented by calling hibernation
function: device_suspend(PMSG_FREEZE), whose implementation depends on 
CONFIG_HIBERNATION.

So, I will add CONFIG_KEXEC_JUMP and select CONFIG_HIBERNATION
automatically.

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

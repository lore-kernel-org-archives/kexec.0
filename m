Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IBKRj-0004gd-3E
	for kexec@lists.infradead.org; Wed, 18 Jul 2007 21:04:48 -0400
Date: Wed, 18 Jul 2007 18:04:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec based
	hibernation
Message-Id: <20070718180420.02352d4f.akpm@linux-foundation.org>
In-Reply-To: <1184483593.1898.98.camel@caritas-dev.intel.com>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Sun, 15 Jul 2007 15:13:13 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> 
> The changelog between v1 and v2
> 
> 1. The kexec jump implementation is put into the kexec/kdump
>    framework instead of software suspend framework. The device
>    and CPU state save/restore code of software suspend is called
>    when needed.
> 
> 2. The same code path is used for both kexec a new kernel and jump
>    back to original kernel.

I like the idea but I think I'll let people chat about it a bit more
before looking at merging the patches, OK?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

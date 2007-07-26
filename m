Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IE3zh-0005FZ-D7
	for kexec@lists.infradead.org; Thu, 26 Jul 2007 10:07:10 -0400
Date: Thu, 26 Jul 2007 16:07:02 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch] add kdump_after_notifier
Message-ID: <20070726140702.GA8949@suse.de>
References: <469F55D0.4050203@ah.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <469F55D0.4050203@ah.jp.nec.com>
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
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, k-miyoshi@cb.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Takenori Nagano <t-nagano@ah.jp.nec.com> [2007-07-19 14:15]:
> 
> In latest kernel, we can't use panic_notifier_list if kdump is enabled.
> panic_notifier_list is very useful function for debug, failover, etc...
> 
> So this patch adds a control file /proc/sys/kernel/dump_after_notifier
> and resolves a problem users can not use both kdump and panic_notifier_list
> at the same time.
> 
> kdump_after_notifier = 0
>  -> panic()
>     -> crash_kexec(NULL)
> 
> kdump_after_notifier = 1
>  -> panic()
>     -> atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>     -> crash_kexec(NULL)

What's problematic about this patch? I also would like to see that
feature.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces@lists.infradead.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Idfzr-00029g-Sj
	for kexec@lists.infradead.org; Fri, 05 Oct 2007 06:45:16 +0100
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l955hQLY027206
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 01:43:26 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l955fu3m664464
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 01:41:56 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l955fpts012137
	for <kexec@lists.infradead.org>; Fri, 5 Oct 2007 01:41:51 -0400
Date: Fri, 5 Oct 2007 11:12:05 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 1/2] add tunable_notifier function
Message-ID: <20071005054205.GB4893@in.ibm.com>
References: <4704D0BA.4090507@ah.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4704D0BA.4090507@ah.jp.nec.com>
Reply-To: vgoyal@in.ibm.com
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
Errors-To: kexec-bounces@lists.infradead.org
To: Takenori Nagano <t-nagano@ah.jp.nec.com>
Cc: k-miyoshi@cb.jp.nec.com, Bernhard Walle <bwalle@suse.de>, kdb@oss.sgi.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Oct 04, 2007 at 08:38:34PM +0900, Takenori Nagano wrote:
> This patch adds new notifier function tunable_notifier_chain. Its base is
> atomic_notifier_chain.
> 
> Thanks,
> 
> ---
> 
> Signed-off-by: Takenori Nagano <t-nagano@ah.jp.nec.com>
> 
> ---
> diff -uprN linux-2.6.23-rc9.orig/include/linux/notifier.h
> linux-2.6.23-rc9/include/linux/notifier.h
> --- linux-2.6.23-rc9.orig/include/linux/notifier.h	2007-10-02 12:24:52.000000000
> +0900
> +++ linux-2.6.23-rc9/include/linux/notifier.h	2007-10-03 14:48:04.288000000 +0900
> @@ -13,6 +13,7 @@
>  #include <linux/mutex.h>
>  #include <linux/rwsem.h>
>  #include <linux/srcu.h>
> +#include <linux/kobject.h>
> 
>  /*
>   * Notifier chains are of four types:
> @@ -53,6 +54,14 @@ struct notifier_block {
>  	int priority;
>  };
> 
> +struct tunable_notifier_block {
> +	struct notifier_block *nb;
> +	struct tunable_notifier_head *head;
> +	struct dentry *dir;
> +	struct dentry *pri_dentry;
> +	struct dentry *desc_dentry;
> +};
> +

Should this be tunable_atomic_notifier_block? I think there are two kind
of lists. One where handlers have to be atomic and other one where handlers
can be blocking one. I think you are making atomic one tunable. If that's
the case it should be reflected in the naming everywhere.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

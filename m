Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZfLjQ-00083B-7P
 for kexec@lists.infradead.org; Fri, 25 Sep 2015 05:39:40 +0000
Date: Fri, 25 Sep 2015 14:39:15 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] fix kexec load hang in case crash notes addr read failure
Message-ID: <20150925053912.GA21799@verge.net.au>
References: <20150925023728.GA11505@dhcp-129-149.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150925023728.GA11505@dhcp-129-149.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Fri, Sep 25, 2015 at 10:37:51AM +0800, Dave Young wrote:
> While readng crash note, count_cpu variable will be never decreased in case
> any failure to read the sysfs file.
> 
> The issue was found during I test CONFIG_KEXEC_FILE only kernel option.
> crash_notes are exported to sysfs only for CONFIG_KEXEC. In latest kernel
> we can configure kernel with CONFIG_KEXEC_FILE only in Kconfig. In this
> case, if you run a kernel with kexec_file only but do not specify "-s"
> in kexec-tools arguments, then kexec-tools will hang there.
> 
> Though "-s" is mandatory for kexec_file_load, kexec should still fail out
> instead of hanging.
> 
> Fixing the problem by always decreasing count_cpu in the for loop.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks Dave, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

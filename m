Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1ITAEe-0007KS-Vw
	for kexec@lists.infradead.org; Thu, 06 Sep 2007 06:49:05 +0100
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l865mgoD017079
	for <kexec@lists.infradead.org>; Thu, 6 Sep 2007 01:48:42 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l865mfVL463912
	for <kexec@lists.infradead.org>; Thu, 6 Sep 2007 01:48:41 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l865mfRh021363
	for <kexec@lists.infradead.org>; Thu, 6 Sep 2007 01:48:41 -0400
Received: from vivek.in.ibm.com ([9.124.218.235])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l865meZU021343
	for <kexec@lists.infradead.org>; Thu, 6 Sep 2007 01:48:41 -0400
Date: Thu, 6 Sep 2007 11:18:58 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: DEBUG_INFO -> DEBUG_KERNEL dependency
Message-ID: <20070906054858.GD17336@in.ibm.com>
References: <20070905122311.GA11013@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070905122311.GA11013@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Wed, Sep 05, 2007 at 02:23:11PM +0200, Bernhard Walle wrote:
> Hi,
> 
> Subject says all. Why does DEBUG_INFO depend on DEBUG_KERNEL? IMO it's
> also desirable to use Kdump when DEBUG_KERNEL is not enabled.
> 

That's true. But is DEBUG_KERNEL hurting you. You can disable all other
debug options under DEBUG_KERNEL and only enable DEBUG_INFO.

Logically it makes sense to put all kernel debug features under KERNEL_DEBUG.
Though DEBUG_INFO probably can be brought out. But is there huge piece
of code under DEBUG_KERNEL which is a problem for you?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

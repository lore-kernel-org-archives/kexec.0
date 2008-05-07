Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga12.intel.com ([143.182.124.36] helo=azsmga102.ch.intel.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JtnEx-0000O4-8I
	for kexec@lists.infradead.org; Wed, 07 May 2008 17:15:39 +0000
Received: from nlxdcldnl2.cl.intel.com (localhost.localdomain [127.0.0.1])
	by nlxdcldnl2.cl.intel.com (8.14.1/8.14.1) with ESMTP id m47HBUXV029507
	for <kexec@lists.infradead.org>; Wed, 7 May 2008 10:11:30 -0700
Received: (from dnlombar@localhost)
	by nlxdcldnl2.cl.intel.com (8.14.1/8.14.1/Submit) id m47HBUIu029506
	for kexec@lists.infradead.org; Wed, 7 May 2008 10:11:30 -0700
Date: Wed, 7 May 2008 10:11:30 -0700
From: "Lombard, David N" <dnlombar@ichips.intel.com>
Subject: Reducing the size of kexec util
Message-ID: <20080507171130.GB21888@nlxdcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: kexec@lists.infradead.org

The current (20080324) kexec binary on x86 is 135KiB.  While not a
problem on a normal distro or runtime environment, it's a chubster
in an embedded role.

Has any thought been given to reducing its 'on-disk' footprint?
The rather obvious, non-default build-time options to only support
specific kernel types and capabilities, jumps to mind.

Beyond build-time options, a Busybox applet would further minimize
size, but maintenance would be painful...

-- 
David N. Lombard, Intel, Irvine, CA
I do not speak for Intel Corporation; all comments are strictly my own.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

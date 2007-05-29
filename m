Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Ht7PT-0003fr-Nm
	for kexec@lists.infradead.org; Tue, 29 May 2007 15:31:13 -0400
Date: Tue, 29 May 2007 21:30:58 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: [makedumpfile] config file -- OSRELEASE
Message-ID: <20070529193058.GA4229@suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, jlan@sgi.com

Hi,

is there any reason why the kernel version saved in the configuration
file is the version of the running kernel and not the version for
which the config file is for?

It's a big problem because my plan was to ship the configuration files
with the kernel RPMs in SLES. However, we don't build the kernels on
systems which run the kernel that is just built -- so that's not
possible.

I think from implementation point of view it's not a problem, that's
why I ask and didn't create a patch.


Thanks,
   Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

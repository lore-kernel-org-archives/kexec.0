Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KcyJe-0006YF-Jp
	for kexec@lists.infradead.org; Tue, 09 Sep 2008 08:11:14 +0000
Date: Tue, 9 Sep 2008 10:19:00 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: IA64: copying /proc/vmcore caused kernel MCA'ed
Message-ID: <20080909101900.76f843ec@kepler.site>
In-Reply-To: <48C56F55.5000503@sgi.com>
References: <48C56F55.5000503@sgi.com>
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
To: kexec@lists.infradead.org
Cc: jlan@sgi.com

* Jay Lan <jlan@sgi.com> [2008-09-08]: 

> Any input helping me speed up debugging is appreciated.

I would start with comparing the ELF program headers of /proc/vmcore
which you get with "readelf -l /proc/vmcore" in kdump environment and
the /proc/iomem which kexec uses to set up the ELF core headers.

If both does contain the memory regions which should not be accessed,
then it's a bug in the ressource assignment of the kernel, and
if /proc/iomem does not, the kexec tool has a bug.

Hope that helps a bit, I don't have time to look deeper into that now.


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

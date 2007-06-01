Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu3oO-0001FQ-81
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 05:55:22 -0400
Date: Fri, 1 Jun 2007 11:52:28 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [makedumpfile] config file -- OSRELEASE
Message-ID: <20070601095228.GB27205@suse.de>
References: <m1d50g3iwj.fsf@ebiederm.dsl.xmission.com>
	<20070601180704oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070601180704oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: jlan@sgi.com, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-06-01 11:07]:
> 
> Now, the items makedumpfile cannot get from vmlinux statically are
> only version and page size. Do you have any idea for getting them
> from vmlinux ?

I already tried to address a similar issue (version + command line
length for kexec-tools) by adding a ELF note. But it seems that kernel
hackers didn't like it.

http://article.gmane.org/gmane.comp.boot-loaders.fastboot.general/3996/.



Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

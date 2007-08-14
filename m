Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IL4Q8-0000Yu-4W
	for kexec@lists.infradead.org; Tue, 14 Aug 2007 17:59:27 -0400
Date: Tue, 14 Aug 2007 23:59:22 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [RFC][PATCH 3/3] Embed vmcoreinfo into kernel file
Message-ID: <20070814215922.GA16408@suse.de>
References: <20070813163212oomichi@mail.jp.nec.com>
	<20070813163934oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070813163934oomichi@mail.jp.nec.com>
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
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Vivek Goyal <vgoyal@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Dan Aloni <da-x@monatomic.org>

Hello,

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-08-13 09:39]:
> +#define FILENAME_VMCOREINFO		"/tmp/vmcoreinfo.tmp"

Wouldn't it be better to use mkstemp() here? It also makes sense to
copy the whole vmcore first and run makedumpfile after this in a full
featured system, e.g. before sending the dump file via FTP.

Then, you have the well-known security problems when using a temporary
file with a static name -- as well as two makedumpfile processes
running in parallel. While this all is not very likely, it's also not
guaranteed that this doesn't happen.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JBcr7-0002jq-Ng
	for kexec@lists.infradead.org; Sun, 06 Jan 2008 21:16:36 +0000
Date: Sun, 6 Jan 2008 16:16:28 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kexec buffer error
Message-ID: <20080106211628.GB19601@redhat.com>
References: <20080104135418.9ae53103.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080104135418.9ae53103.rdunlap@xenotime.net>
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>

On Fri, Jan 04, 2008 at 01:54:18PM -0800, Randy Dunlap wrote:
> Hi,
> 
> kexec of 2.6.24-rc6-git11 fails for me with:
> 
> Close of /boot/kernel-2.6.24-rc6-git11 failed: : buffer  error
> kexec load failed, error = 1
> 

So close() system call seems to be failing here. If kexec-tools version
is same then we should not have erred on fd number etc. Could be a kernel
issue. I have no idea though.....


Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ki2gq-0004gy-LV
	for kexec@lists.infradead.org; Tue, 23 Sep 2008 07:52:09 +0000
Date: Tue, 23 Sep 2008 17:52:04 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: /sbin/kexec became zero size... Anyone else?
Message-ID: <20080923075202.GA20108@verge.net.au>
References: <48D17183.7030002@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48D17183.7030002@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 17, 2008 at 02:07:15PM -0700, Jay Lan wrote:
> Hi,
> 
> My root disk was populated with sles10sp2, but the kernel was
> 2.6.27-rc5 and /sbin/kexec was built from 2.0.0 version.
> 
> Many times when kdump kernel failed early i found  after reboot that
> /sbin/kexec became zero size. There was no warning on executing
> '/etc/init.d/kdump start' when /sbin/kexec is zero size. I have
> no idea when and how that happened.
> 
> Has anyone else seen this problem?

Is it possible that this is caused by filesystem corruption?

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

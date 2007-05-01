Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hii3B-0004dY-U9
	for kexec@lists.infradead.org; Mon, 30 Apr 2007 22:25:12 -0400
Date: Tue, 1 May 2007 11:25:07 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] kexec: Added generic --reuseinitrd option
Message-ID: <20070501022505.GA22818@verge.net.au>
References: <13112.1177317015@neuling.org>
	<1177649598.976491.841801585564.qpush@coopers>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1177649598.976491.841801585564.qpush@coopers>
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
To: Michael Neuling <mikey@neuling.org>
Cc: kexec@lists.infradead.org, Milton Miller <miltonm@bga.com>

On Fri, Apr 27, 2007 at 02:53:18PM +1000, Michael Neuling wrote:
> Adds a generic --reuseinitrd option and performs some sanity checks on
> it.  Can be used with the retain_initrd kernel option.

Thanks, I've applied both this and the following patch.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

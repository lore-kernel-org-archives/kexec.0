Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MIu0Q-0003lY-33
	for kexec@lists.infradead.org; Tue, 23 Jun 2009 00:37:04 +0000
Date: Tue, 23 Jun 2009 10:36:55 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [patch] kexec: Fix printed symbol value
Message-ID: <20090623003651.GA24772@verge.net.au>
References: <4A4000F1.8040908@am.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A4000F1.8040908@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: kexec@lists.infradead.org

On Mon, Jun 22, 2009 at 03:08:49PM -0700, Geoff Levand wrote:
> Move the print statement so that the variable
> value has been assigned before its value is
> printed.

Thanks Geoff,

applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

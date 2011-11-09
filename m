Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RNwV5-0008H0-PZ
 for kexec@lists.infradead.org; Wed, 09 Nov 2011 00:58:48 +0000
Date: Wed, 9 Nov 2011 09:58:41 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] remove unnecessary check code for hole_align
Message-ID: <20111109005841.GA380@verge.net.au>
References: <20111108052623.GA22922@darkstar.nay.redhat.com>
 <20111108072205.GA26841@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111108072205.GA26841@verge.net.au>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, Nov 08, 2011 at 04:22:08PM +0900, Simon Horman wrote:
> On Tue, Nov 08, 2011 at 01:26:23PM +0800, Dave Young wrote:
> > hole_align == 0 check is not neccesary, because it will be set to
> > pagesize if it's zero. Just remove it here.
> > 
> 
> Hi Dave,
> 
> it looks like the if condition can never be true due
> to hole_base being set to a non-zero value on the
> previous line.
> 
> Which is a long way of saying, I like your patch.

Hi Dave,

I have applied your patch to my kexec-tools tree on github.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

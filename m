Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TiwT7-0005ce-5K
 for kexec@lists.infradead.org; Thu, 13 Dec 2012 00:16:05 +0000
Date: Thu, 13 Dec 2012 09:15:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: kexec: ppc exec stack fix
Message-ID: <20121213001552.GA13343@verge.net.au>
References: <20121210030732.GA6290@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20121210030732.GA6290@darkstar.nay.redhat.com>
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

On Mon, Dec 10, 2012 at 11:07:32AM +0800, Dave Young wrote:
> 
> execstack shows ppc kexec has an executable stack,
> this leaves it vulnerable to buffer overflows.
> 
> Fix it by adding ASFLAGS --noexecstack
> 
> Tested on PowerMac G4 Macmini:
> Without the patch:
> dave@darkstar:~/kexec-tools$ execstack build/sbin/kexec 
> X build/sbin/kexec
> 
> With the patch:
> dave@darkstar:~/kexec-tools$ execstack build/sbin/kexec 
> - build/sbin/kexec
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Thanks Dave, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

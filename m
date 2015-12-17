Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a9VDr-0006B8-Kg
 for kexec@lists.infradead.org; Thu, 17 Dec 2015 09:51:44 +0000
Date: Thu, 17 Dec 2015 15:21:17 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] arm: ramdisk uimage support for arm
Message-ID: <20151217095117.GB8965@dhcp-0-82.del.redhat.com>
References: <56711B8C.9090407@powersoft.it>
 <20151217042353.GC1525@dhcppc13.redhat.com>
 <56726ADA.1050403@powersoft.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56726ADA.1050403@powersoft.it>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michele Dionisio <michele.dionisio@powersoft.it>
Cc: kexec@lists.infradead.org

On 17/12/2015:08:57:14 AM, Michele Dionisio wrote:
> yes it is true.
> 
> I'm not in the position to test ppc. So my only way to be sure to avoid to
> introduce regration is to avoid to refactor the code.
> 
> But it is true. If you are able to test ppc I can try to post the
> refactoring.

I also do not be able to test it on ppc, but I believe refactoring would be
trivial and would not have any functionality difference. So, better to go with
that rather than duplicating the code. You may keep ppc developer in CC and ask
for ACK from  them.

~Pratyush


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

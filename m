Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HgyDw-0002h4-PC
	for kexec@lists.infradead.org; Thu, 26 Apr 2007 03:17:15 -0400
Date: Thu, 26 Apr 2007 16:17:00 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] fix valid_memory_range region merging
Message-ID: <20070426071658.GF17808@verge.net.au>
References: <1165.1177570234@neuling.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1165.1177570234@neuling.org>
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
Cc: Magnus Damm <magnus.damm@gmail.com>, kexec@lists.infradead.org

On Thu, Apr 26, 2007 at 04:50:34PM +1000, Michael Neuling wrote:
> Check the next region we are including is type RANGE_RAM as well.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> I've not actually seen this cause a problem, but it looks wrong.  We
> should probably merge regions properly and solve this problem for real. 

I think that Magnus was working on some code do do just that...

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

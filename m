Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjm8i-0003G8-6n
 for kexec@lists.infradead.org; Mon, 30 Nov 2020 16:35:01 +0000
Date: Mon, 30 Nov 2020 17:34:48 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] printk: add support for lockless ringbuffer
Message-ID: <20201130163448.GA20208@vergenet.net>
References: <20201125222059.6792-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201125222059.6792-1-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: kexec@lists.infradead.org

On Wed, Nov 25, 2020 at 11:26:59PM +0106, John Ogness wrote:
> Linux 5.10 moved to a new lockless ringbuffer. The new ringbuffer
> is structured completely different to the previous iterations.
> Add support for retrieving the ringbuffer using vmcoreinfo. The
> new ringbuffer is detected based on the availability of the
> "prb" symbol.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

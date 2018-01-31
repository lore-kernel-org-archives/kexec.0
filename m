Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.89 #1 (Red Hat Linux))
 id 1egrg1-0000ga-FI
 for kexec@lists.infradead.org; Wed, 31 Jan 2018 12:39:48 +0000
Date: Wed, 31 Jan 2018 13:39:27 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180131123925.gr6hgxuoxflqipl5@verge.net.au>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Andi Kleen <ak@linux.intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On Sat, Jan 27, 2018 at 12:11:29PM +0800, Dave Young wrote:
> It is useful to print kdump kernel loaded status in dump_stack() 
> especially when panic happens so that we can differenciate 
> kdump kernel early hang and a normal panic in a bug report.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

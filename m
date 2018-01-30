Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1egSLW-0003Rl-6z
 for kexec@lists.infradead.org; Tue, 30 Jan 2018 09:36:57 +0000
Date: Tue, 30 Jan 2018 10:36:40 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180130093640.r4a45m6eicmyeljc@pathway.suse.cz>
References: <20180127041129.GA29016@dhcp-128-65.nay.redhat.com>
 <20180130085055.GA569@jagdpanzerIV>
 <20180130090729.GA2558@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180130090729.GA2558@dhcp-128-65.nay.redhat.com>
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
Cc: Andi Kleen <ak@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On Tue 2018-01-30 17:07:29, Dave Young wrote:
> On 01/30/18 at 05:50pm, Sergey Senozhatsky wrote:
> > On (01/27/18 12:11), Dave Young wrote:
> > > It is useful to print kdump kernel loaded status in dump_stack() 
> > > especially when panic happens so that we can differenciate 
> > > kdump kernel early hang and a normal panic in a bug report.
> > > 
> > > Signed-off-by: Dave Young <dyoung@redhat.com>
> > 
> > Looks OK to me.
> > 
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Same here:

Reviewed-by: Petr Mladek <pmladek@suse.com>

> > I agree with Steven, would be better to move the whole thing
> > to lib/dump_stack.c
> 
> If nobody has plan I can put it in my todo list, probably do it next
> week.

Sounds good.

JFYI, I would target these changes for 4.17. There was some discussion
about where and how to show the new information. IMHO, it would deserve
some gurgling in linux-next.

Best Regards,
Petr

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

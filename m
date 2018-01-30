Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1egRdG-0001n4-He
 for kexec@lists.infradead.org; Tue, 30 Jan 2018 08:51:15 +0000
Received: by mail-pg0-x243.google.com with SMTP id m20so6708431pgc.11
 for <kexec@lists.infradead.org>; Tue, 30 Jan 2018 00:50:59 -0800 (PST)
Date: Tue, 30 Jan 2018 17:50:55 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH V2] print kdump kernel loaded status in stack dump
Message-ID: <20180130085055.GA569@jagdpanzerIV>
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

On (01/27/18 12:11), Dave Young wrote:
> It is useful to print kdump kernel loaded status in dump_stack() 
> especially when panic happens so that we can differenciate 
> kdump kernel early hang and a normal panic in a bug report.
> 
> Signed-off-by: Dave Young <dyoung@redhat.com>

Looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>


I agree with Steven, would be better to move the whole thing
to lib/dump_stack.c

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

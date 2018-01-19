Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecS6H-0001IN-AN
 for kexec@lists.infradead.org; Fri, 19 Jan 2018 08:32:38 +0000
Received: by mail-pf0-x22e.google.com with SMTP id t5so874870pfi.0
 for <kexec@lists.infradead.org>; Fri, 19 Jan 2018 00:32:26 -0800 (PST)
Date: Fri, 19 Jan 2018 17:32:22 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
Message-ID: <20180119083222.GB477@jagdpanzerIV>
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
 <878tcvt592.fsf@linux.intel.com>
 <20180119054538.GA484@jagdpanzerIV>
 <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180119081628.GB3985@dhcp-128-65.nay.redhat.com>
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
Cc: pmladek@suse.com, Andi Kleen <ak@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

On (01/19/18 16:16), Dave Young wrote:
> I thought about adding an option to improve printk_delay so it can
> delay every n lines, eg. 25 rows. Maybe that idea works for this
> issue?

/* sent the message too soon */

printk_delay() has no effect there. it limits only printk()->vprintk_emit()
and we don't have any new printk()-s once the system has panic-ed. it's
console_unlock() that prints out the oops.

	-ss

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

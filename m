Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ecEWM-0002xI-Ej
 for kexec@lists.infradead.org; Thu, 18 Jan 2018 18:02:39 +0000
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] print kdump kernel loaded status in stack dump
References: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com>
Date: Thu, 18 Jan 2018 10:02:17 -0800
In-Reply-To: <20180117045057.GA4994@dhcp-128-65.nay.redhat.com> (Dave Young's
 message of "Wed, 17 Jan 2018 12:50:57 +0800")
Message-ID: <878tcvt592.fsf@linux.intel.com>
MIME-Version: 1.0
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
Cc: pmladek@suse.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, sergey.senozhatsky@gmail.com, akpm@linux-foundation.org

Dave Young <dyoung@redhat.com> writes:
>  		printk("%sHardware name: %s\n",
>  		       log_lvl, dump_stack_arch_desc_str);
> +	if (kexec_crash_loaded())
> +		printk("%skdump kernel loaded\n", log_lvl);

Oops/warnings are getting longer and longer, often scrolling away
from the screen, and if the kernel crashes backscroll does not work
anymore, so precious information is lost.

Can you merge it with some other line?

Just a [KDUMP] or so somewhere should be good enough.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

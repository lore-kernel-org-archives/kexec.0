Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b2HZ9-0007Qu-0V
 for kexec@lists.infradead.org; Mon, 16 May 2016 12:24:07 +0000
Date: Mon, 16 May 2016 20:23:42 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kdump: Fix gdb macros work work with newer and 64-bit
 kernels
Message-ID: <20160516122342.GG7214@x1.redhat.com>
References: <1462926655-9390-1-git-send-email-minyard@acm.org>
 <20160516093249.GE7214@x1.redhat.com> <5739B478.5010205@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5739B478.5010205@acm.org>
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
To: Corey Minyard <minyard@acm.org>
Cc: Corey Minyard <cminyard@mvista.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Haren Myneni <hbabu@us.ibm.com>, dyoung@redhat.com, Vivek Goyal <vgoyal@redhat.com>

On 05/16/16 at 06:52am, Corey Minyard wrote:
> On 05/16/2016 04:32 AM, Baoquan He wrote:
> >On 05/10/16 at 07:30pm, minyard@acm.org wrote:
> >>From: Corey Minyard <cminyard@mvista.com>
> >>
> >>Lots of little changes needed to be made to clean these up, remove the
> >>four byte pointer assumption and traverse the pid queue properly.
> >>Also consolidate the traceback code into a single function instead
> >>of having three copies of it.
> >>
> >>Signed-off-by: Corey Minyard <cminyard@mvista.com>
> >Hi Corey,
> >
> >Today I tried gdbmacro.txt and found dmesg doesn't work. I tested it
> >on the latest 4.6.0 kernel. And I directly copy /proc/vmcore out
> >and use gdb to open it by below command"
> >
> >gdb vmlinux /var/crash/vmcore --"gdbmacros.txt"
> >
> >All macro functions work well except of dmesg since code inside refer to
> >the deprecated variable like "log_end" and "logged_chars". But these
> >have been changed since this commit:
> >
> >commit 7ff9554bb578ba02166071d2d487b7fc7d860d62
> >Author: Kay Sievers <kay@vrfy.org>
> >Date:   Thu May 3 02:29:13 2012 +0200
> >
> >     printk: convert byte-buffer to variable-length record buffer
> >
> >So invoking dmesg will cause an error message printing out:
> >
> >(gdb) dmesg
> >No symbol "log_end" in current context.
> 
> Yes, I was actually aware of that, but that's a different issue and I
> hadn't thought about it much.

Got it. Then fixes covered by this patch looks good. Ack it, thanks
for this effort.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

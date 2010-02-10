Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NfFh4-0007i6-Ex
	for kexec@lists.infradead.org; Wed, 10 Feb 2010 16:45:42 +0000
Date: Wed, 10 Feb 2010 11:45:30 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: kdump not writing any vmcore
Message-ID: <20100210164530.GE27658@hmsreliant.think-freely.org>
References: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
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
To: Gallus <gall.cwpl@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Feb 10, 2010 at 05:31:47PM +0100, Gallus wrote:
> Hello
> 
> What can be any reasons why kdump isn't writing vmcore file in
> /var/crash/[date] directory? I have a box on which Kexec is property
> configured: /etc/init.d/kdump status shows: "Kdump is operational".
> There is no message like: "disabling kdump" in dmesg. Instead, there
> are messages: "kdump: kexec: loaded kdump kernel" and "kdump: started
> up".
> 
> After the random system-wide error occurs, kdump reacts correctly. New
> kernel is started, and there are messages like: "Memory for crash
> kernel (0x0 to 0x0) notwithin permissible range" (this is correct,
> secondary kernel starts with different kernel command line, without
> the crashkernel option, because it doesn't load any third kernel, as
> we know) and "disabling kdump". But, there is no message: "kdump:
> saved a vmcore to /var/crash/*" and no vmcore is saved.
> 
> When I tested exactly the same box with manually triggered system
> crash (echo c >/proc/sysrq....), everything was the same except that
> the "kdump: saved a vmcore to /var/crash/*" was emitted and the vmcore
> was saved.
> 
> Regards,
> Gallus
> 
To answer that fully, we'd really need the output of the console during the
kdump kernel boot/capture process.  This will most likely be an initramfs
problem (or possibly a kernel issue).  We'll be better able to tell with the
console log
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

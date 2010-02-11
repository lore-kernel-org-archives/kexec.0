Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ey-out-1920.google.com ([74.125.78.144])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nfbsr-0007Xm-0O
	for kexec@lists.infradead.org; Thu, 11 Feb 2010 16:27:21 +0000
Received: by ey-out-1920.google.com with SMTP id 4so318305eyg.26
	for <kexec@lists.infradead.org>; Thu, 11 Feb 2010 08:27:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100210164530.GE27658@hmsreliant.think-freely.org>
References: <b08bcbf51002100831k3c1e35d7t8b0d80a1bf89fa07@mail.gmail.com>
	<20100210164530.GE27658@hmsreliant.think-freely.org>
Date: Thu, 11 Feb 2010 17:27:15 +0100
Message-ID: <b08bcbf51002110827r29d17280mab2876356410f567@mail.gmail.com>
Subject: Re: kdump not writing any vmcore
From: Gallus <gall.cwpl@gmail.com>
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
To: kexec@lists.infradead.org

On 10 February 2010 17:45, Neil Horman <nhorman@redhat.com> wrote:
> To answer that fully, we'd really need the output of the console during the
> kdump kernel boot/capture process.  This will most likely be an initramfs
> problem (or possibly a kernel issue).  We'll be better able to tell with the
> console log
> Neil

It shouldn't be the initramfs problem, because when I test it with
sysrq-trigger, it works fine. Right?

I'm thinking that it can be some driver problem, which is causing
repeated kernel-panic. I'm planning to use NFS and/or FTP. How do you
think? Is this the right way to try to avoid possibly corrupted system
parts?

Does someone have any experience with such problems? Is there
something left to try out?

Regards,
Gallus

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

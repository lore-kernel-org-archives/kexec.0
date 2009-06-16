Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MGS1I-0000ga-LR
	for kexec@lists.infradead.org; Tue, 16 Jun 2009 06:19:51 +0000
References: <9c8decfb07c.00000038dseetharam@inbox.com>
	<913da90c6c8.0000039bdseetharam@inbox.com>
	<C11029D0F00.00000039dseetharam@inbox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <C11029D0F00.00000039dseetharam@inbox.com> (Dharmosoth
	Seetharam's message of "Mon\, 15 Jun 2009 20\:43\:02 -0800")
Date: Mon, 15 Jun 2009 23:19:37 -0700
Message-ID: <m1fxe0zona.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: /var/log/messages doesn't have crash info when kernel gets
	panic/oops/crash
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dharmosoth Seetharam <dseetharam@inbox.com>
Cc: Neil Horman <nhorman@redhat.com>, vgoyal@in.ibm.com, kexec@lists.infradead.org, fastboot@lists.linux-foundation.org

Dharmosoth Seetharam <dseetharam@inbox.com> writes:

> Hi,
>
> I have experimented few things and results are below.
>
> Case 1) echo 0 > /proc/sys/kernel/panic_on_oops
>         When BUG/oops occurred it is able to log the diagnostics to /var/log/messages
>         and then continue(not switching to dump-saving kernel).
>
>         What I am looking is - I want both the things to be happen.
>         that is - it should log the appropriate messages in /var/log/messsages and
>         should be able to take kernel dump.

You can't have it.  Sorry.
Keeping user space alive is something that simply can not be done reliably.

> Please advice me, What we can do to achieve those things.

The only scenario I see possible is to take the dump.  Use
makedumpfile or the crash log command to extract the kernel messages
and put them in the /var/log/messages.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

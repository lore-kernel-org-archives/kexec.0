Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MrIzg-0004qR-M0
	for kexec@lists.infradead.org; Fri, 25 Sep 2009 22:10:28 +0000
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
References: <473364.90108.qm@web65711.mail.ac4.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 25 Sep 2009 15:10:13 -0700
In-Reply-To: <473364.90108.qm@web65711.mail.ac4.yahoo.com> (Prabhakar K.'s
	message of "Fri\, 25 Sep 2009 11\:27\:15 -0700 \(PDT\)")
Message-ID: <m1iqf6oeuy.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Prabhakar K." <krishkar99@yahoo.com>
Cc: fastboot@lists.linux-foundation.org, Kexec Mailing List <kexec@lists.infradead.org>

"Prabhakar K." <krishkar99@yahoo.com> writes:

> Hi - After my previous posting I was able to make some progress.
>
> When I do
>
> kexec -l vmlinux --append="init 1 root=/dev/hda2" --console-serial
>
> and 
> kexec -e,
>
> I get message:
>
> Starting new kernel
> I'm in purgatory
>
> And after that it still boots from BIOS (to the same first kernel).
>
> Whats the problem here?

I would recommend instrumenting up purgatory and then your target kernel.

It is quite possible the problem is in your backport.

> Also do I need kdump again in addition to the latest kexec tools?
> When I do:
> #chkconfig kdump on
> error reading information on service kdump
> #service kdump start
> Bad core dump start addres: start

The user space kdump stuff is just a user space wrapper, that creates
a useful initrd etc.


> What am I missing here?

The appropriate list.  Discussion of all things kexec has moved to the kexec
list at infradead which I have cc'd.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

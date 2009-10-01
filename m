Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtA1U-00069g-UQ
	for kexec@lists.infradead.org; Thu, 01 Oct 2009 01:00:01 +0000
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
References: <564351.23709.qm@web65704.mail.ac4.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 30 Sep 2009 17:59:49 -0700
In-Reply-To: <564351.23709.qm@web65704.mail.ac4.yahoo.com> (Prabhakar K.'s
	message of "Wed\, 30 Sep 2009 17\:07\:51 -0700 \(PDT\)")
Message-ID: <m1pr98ylmi.fsf@fess.ebiederm.org>
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

> Sending again as it is not posted yet !!
>
> I have back ported to multiple versions of different kexec-tools. Also I
> disabled watchdogs so that the first kernel reboot is not kicked in.
> Now, with all those kexec-tools I see that it hangs
> after post_verification_setup_arch( ).
> And I had to hard reboot the router box.
>
> Is there a specific kexec tools that is known to work with 2.6.14 ? Or any
> additional changes needed ?

Almost certainly if you are getting as far as kexec-tools you are dying
someplace early in your target kernel.


> Any inputs welcome , thanks in advance !!
>
> Please CC me in reply.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

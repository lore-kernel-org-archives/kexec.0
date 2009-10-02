Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MtXUK-0005pe-Vb
	for kexec@lists.infradead.org; Fri, 02 Oct 2009 02:03:22 +0000
References: <187068.43679.qm@web65716.mail.ac4.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Oct 2009 19:03:08 -0700
In-Reply-To: <187068.43679.qm@web65716.mail.ac4.yahoo.com> (Prabhakar K.'s
	message of "Thu\, 1 Oct 2009 14\:09\:33 -0700 \(PDT\)")
Message-ID: <m11vlma6xv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
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

> From: Eric W. Biederman <ebiederm@xmission.com>
> Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
> To: "Prabhakar K." <krishkar99@yahoo.com>
> Cc: "Kexec Mailing List" <kexec@lists.infradead.org>,
> fastboot@lists.linux-foundation.org
> Date: Thursday, October 1, 2009, 6:29 AM
>
> "Prabhakar K." <krishkar99@yahoo.com> writes:
>
>> Sending again as it is not posted yet !!
>>
>> I have back ported to multiple versions of different kexec-tools. Also I
>> disabled watchdogs so that the first kernel reboot is not kicked in.
>> Now, with all those kexec-tools I see that it hangs
>> after post_verification_setup_arch( ).
>> And I had to hard reboot the router box.
>>
>> Is there a specific kexec tools that is known to work with 2.6.14 ? Or any
>> additional changes needed ?
>
> Almost certainly if you are getting as far as kexec-tools you are dying
> someplace early in your target kernel.
>
>>>> OK. What piece of code can cause in the target kernel to die ?
> Can I take any working bzImage or vmlinux of a linux kernel(for that matter any
> linux kernel) and load that as my target kernel ? or does this has any
> restriction ?

Short of bugs in /sbin/kexec it is unrestricted.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

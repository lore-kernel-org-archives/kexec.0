Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MsQmW-0007g4-AT
	for kexec@lists.infradead.org; Tue, 29 Sep 2009 00:41:32 +0000
Subject: Re: [Fastboot] kexec - 2.6.14 - loads BIOS again
References: <808738.1314.qm@web65701.mail.ac4.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 28 Sep 2009 17:41:17 -0700
In-Reply-To: <808738.1314.qm@web65701.mail.ac4.yahoo.com> (Prabhakar K.'s
	message of "Mon\, 28 Sep 2009 11\:43\:27 -0700 \(PDT\)")
Message-ID: <m1tyympope.fsf@fess.ebiederm.org>
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

>> Hi - After my previous posting I was able to make some progress.
>>
>> When I do
>>
>> kexec -l vmlinux --append="init 1 root=/dev/hda2" --console-serial
>>
>> and 
>> kexec -e,
>>
>> I get message:
>>
>> Starting new kernel
>> I'm in purgatory
>>
>> And after that it still boots from BIOS (to the same first kernel).
>>
>> Whats the problem here?
>
> I would recommend instrumenting up purgatory and then your target kernel.
>
> It is quite possible the problem is in your backport.
>
>>>>>
>  I have instrumented the purgatory code. when I run kexec -e, It hangs for a
> while at 
> sha256_starts(&ctx); in the function verify_sha256_digest(), and then reboots
> to the first kernel (from BIOS). I have put debug prints in sha256_starts, but
> none of those are executed.
>
> Interestingly, the same function sha256_starts is executed during kexec -l,
> which is called as part of update_purgatory( )( when my_load( ) is called from
> kexec.c).
> so its surprise why the same function is giving problems when kexec -e is run.

Do you by any chance have a watchdog you are not petting?

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

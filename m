Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MFShp-0003Ok-K3
	for kexec@lists.infradead.org; Sat, 13 Jun 2009 12:51:40 +0000
References: <9c8decfb07c.00000038dseetharam@inbox.com>
	<913da90c6c8.0000039bdseetharam@inbox.com>
	<9E4E2F1EF78.00000173dseetharam@inbox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 13 Jun 2009 05:51:25 -0700
In-Reply-To: <9E4E2F1EF78.00000173dseetharam@inbox.com> (Dharmosoth
	Seetharam's message of "Sat\, 13 Jun 2009 02\:22\:08 -0800")
Message-ID: <m1prd8uwj6.fsf@fess.ebiederm.org>
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

>> -----Original Message-----
>> From: ebiederm@xmission.com
>> Sent: Sat, 13 Jun 2009 00:11:25 -0700
>> To: dseetharam@inbox.com
>> Subject: Re: /var/log/messages doesn't have crash info when kernel gets
>> panic/oops/crash
>> 
>> Dharmosoth Seetharam <dseetharam@inbox.com> writes:
>> 
>>> Hi Neil,
>>> 
>>> Thanks for your quick reply.
>>> 
>>> What you have suggested is nice when we got/save crash dump (i.e vmcore)
>>> What if we failed to save/capture vmcore info or vmcore is corrupted
>>> etc. then we dont get any information
>>> regarding the panic/crash/oops at anywhere?
>> 
> Hi Eric,
>
>> Basic questions.
>> 1) Do you have panic on oops set?
>>    I think that setting more than anything else will be the
>>    difference in what shows up in /var/log/messages.
>
> Yes, in my case panic_on_oops was set with 1

That is the reason thing don't show up in /var/log/messages
because you panic before syslog has a chance to write the messages.

>> 2) Have you tried a dry run and confirmed you can get a crash dump?
>
> No, I haven't tried this.

It sounds like you have not been getting the coredumps when problems
happen.  Running a simple test run to  Alt-sysrq-c to confirm
that things are basically setup ok is a good idea.

>> 3) Are you using kvm
> kvm? kernel virtual memory?

Kernel virtual machine.  In particular.
Hardware acceleration for virtual machines.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

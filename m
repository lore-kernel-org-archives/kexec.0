Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wm58.inbox.com ([64.135.83.58])
	by bombadil.infradead.org with smtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MFTBx-0008KO-Ng
	for kexec@lists.infradead.org; Sat, 13 Jun 2009 13:22:58 +0000
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <906130002449.WM58> for <kexec@lists.infradead.org> from
	<dseetharam@inbox.com>; Sat, 13 Jun 2009 5:24:09 AM -0800
Mime-Version: 1.0
Date: Sat, 13 Jun 2009 05:24:09 -0800
Message-ID: <9FE503A86B2.000002E5dseetharam@inbox.com>
From: Dharmosoth Seetharam <dseetharam@inbox.com>
Subject: Re: /var/log/messages doesn't have crash info when kernel gets
	panic/oops/crash
In-Reply-To: <m1prd8uwj6.fsf@fess.ebiederm.org>
References: <9e4e2f1ef78.00000173dseetharam@inbox.com>
	<9c8decfb07c.00000038dseetharam@inbox.com>
	<913da90c6c8.0000039bdseetharam@inbox.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Neil Horman <nhorman@redhat.com>, vgoyal@in.ibm.com, kexec@lists.infradead.org, fastboot@lists.linux-foundation.org



> -----Original Message-----
> From: ebiederm@xmission.com
> Sent: Sat, 13 Jun 2009 05:51:25 -0700
> To: dseetharam@inbox.com
> Subject: Re: /var/log/messages doesn't have crash info when kernel gets
> panic/oops/crash
> 
> Dharmosoth Seetharam <dseetharam@inbox.com> writes:
> 
>>> -----Original Message-----
>>> From: ebiederm@xmission.com
>>> Sent: Sat, 13 Jun 2009 00:11:25 -0700
>>> To: dseetharam@inbox.com
>>> Subject: Re: /var/log/messages doesn't have crash info when kernel gets
>>> panic/oops/crash
>>> 
>>> Dharmosoth Seetharam <dseetharam@inbox.com> writes:
>>> 
>>>> Hi Neil,
>>>> 
>>>> Thanks for your quick reply.
>>>> 
>>>> What you have suggested is nice when we got/save crash dump (i.e
>>>> vmcore)
>>>> What if we failed to save/capture vmcore info or vmcore is corrupted
>>>> etc. then we dont get any information
>>>> regarding the panic/crash/oops at anywhere?
>>> 
>> Hi Eric,
>> 
>>> Basic questions.
>>> 1) Do you have panic on oops set?
>>>    I think that setting more than anything else will be the
>>>    difference in what shows up in /var/log/messages.
>> 
>> Yes, in my case panic_on_oops was set with 1
> 
> That is the reason thing don't show up in /var/log/messages
> because you panic before syslog has a chance to write the messages.

Thanks.
So, if panic_on_oops set with 0(default), we will get all the 
needed info like stack traces, bug info etc. in /var/log/messages then reboots.

Or do we need to apply any specific patches to get info in /var/log/messages?

> 
>>> 2) Have you tried a dry run and confirmed you can get a crash dump?
>> 
>> No, I haven't tried this.
> 
> It sounds like you have not been getting the coredumps when problems
> happen.  Running a simple test run to  Alt-sysrq-c to confirm
> that things are basically setup ok is a good idea.
> 
Sorry, I misunderstood your question.
I have gave dry run and confirmed that the dumps are getting saved in particular dir and able to analyze.

I did in both the ways like
1 - echo c > /proc/sysrq-trigger
2 -Alt -sysrq -c



thanks,
Seetharam

>>> 3) Are you using kvm
>> kvm? kernel virtual memory?
> 
> Kernel virtual machine.  In particular.
> Hardware acceleration for virtual machines.
> 
> Eric

____________________________________________________________
FREE ONLINE PHOTOSHARING - Share your photos online with your friends and family!
Visit http://www.inbox.com/photosharing to find out more!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

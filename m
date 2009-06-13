Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MFTul-0003LE-GJ
	for kexec@lists.infradead.org; Sat, 13 Jun 2009 14:09:06 +0000
References: <9e4e2f1ef78.00000173dseetharam@inbox.com>
	<9c8decfb07c.00000038dseetharam@inbox.com>
	<913da90c6c8.0000039bdseetharam@inbox.com>
	<9FE503A86B2.000002E5dseetharam@inbox.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 13 Jun 2009 07:08:50 -0700
In-Reply-To: <9FE503A86B2.000002E5dseetharam@inbox.com> (Dharmosoth
	Seetharam's message of "Sat\, 13 Jun 2009 05\:24\:09 -0800")
Message-ID: <m1bpostedp.fsf@fess.ebiederm.org>
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

>>>> Basic questions.
>>>> 1) Do you have panic on oops set?
>>>>    I think that setting more than anything else will be the
>>>>    difference in what shows up in /var/log/messages.
>>> 
>>> Yes, in my case panic_on_oops was set with 1
>> 
>> That is the reason thing don't show up in /var/log/messages
>> because you panic before syslog has a chance to write the messages.
>
> Thanks.
> So, if panic_on_oops set with 0(default), we will get all the 
> needed info like stack traces, bug info etc. in /var/log/messages then reboots.
>
> Or do we need to apply any specific patches to get info in /var/log/messages?
>
>> 
>>>> 2) Have you tried a dry run and confirmed you can get a crash dump?
>>> 
>>> No, I haven't tried this.
>> 
>> It sounds like you have not been getting the coredumps when problems
>> happen.  Running a simple test run to  Alt-sysrq-c to confirm
>> that things are basically setup ok is a good idea.
>> 
> Sorry, I misunderstood your question.
> I have gave dry run and confirmed that the dumps are getting saved in particular dir and able to analyze.
>
> I did in both the ways like
> 1 - echo c > /proc/sysrq-trigger
> 2 -Alt -sysrq -c

Then unless you are having problems capturing core dumps in real
failure situations it sounds like all is well with the world.

A kernel oops is normally not fatal and the kernel tries to limp along
allowing for better diagnostics etc.  This allows klogd to read the
kernels message buffer and pass the kernel messages to syslog which
writes the messages to /var/log/messages.

After a kernel panic nothing is allowed to happen which prevents
user space from writing to /var/log/messages in the usual way.

If you want data in /var/log/messages it appears you have two choices.
1) Post process a core dump as Neil suggested and feed the kernel log
   buffer to syslog.
2) disable panic on oops.  The system will continue to limp along allowing
   user space to write to /var/log/messages.

Eric






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dIeDc-0004Lc-FM
 for kexec@lists.infradead.org; Wed, 07 Jun 2017 16:54:06 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <72f60925-c2a6-8811-a75a-5f443486e781@cisco.com>
Date: Wed, 07 Jun 2017 11:46:27 -0500
In-Reply-To: <72f60925-c2a6-8811-a75a-5f443486e781@cisco.com> (Daniel Walker's
 message of "Wed, 7 Jun 2017 09:20:51 -0700")
Message-ID: <87bmpzoie4.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: crash_kexec in oops_end() and panic()
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Daniel Walker <danielwa@cisco.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, xe-linux-external@cisco.com

Daniel Walker <danielwa@cisco.com> writes:

> Hi,
>
> These two paths seem to be duplicating each other. We have an issue
> where we're using mtdoops to collect kernel logs on oops and panic, we
> also have a crash kernel (which also collects these logs). mtdoops
> saves logs differently for oops and panic, since oops isn't always
> fatal it schedules a write to the flash. Since panic() is always fatal
> is writes the logs immediately. In oops_end() the crash kernel runs
> immediately while still signaling an OOPS condition to mtdoops. Since
> mtdoops schedules a write to flash later, there is no later since the
> crash kernel runs immediately, we end up without getting the logs
>
> I'm wondering what the significance is to have these two paths ?
> oops_end() could just call into panic() or a modified
> panic_with_regs() then we would collapse multiple paths. There is what
> I would call a hack in kexec_should_crash() which checks if there are
> crash_kexec_post_notifiers and it runs panic() if they exist. This
> wouldn't be needed if we always called panic() . I also wonder if
> there are other things in panic() which we should be running , but
> don't get run because of these two paths.

crash_kexec_post_notifiers is a horrible hack it is broken by design and
no one should use it.

Looking at the history and it still seems valid is the point of
kexec_should_crash is so that crash_kexec could be called with the
registers at the time of the crash.

The code that is run in kexec on panic path the less well it works.
This has been a known fact for years.

Please figure out how to depend on less code running in a broken
kernel.  Trying to figure out how to run more code is not the solution
to making the kernel reliable at the time of a crash.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

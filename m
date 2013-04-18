Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USpGt-0007J6-2O
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 13:53:07 +0000
Date: Thu, 18 Apr 2013 09:52:57 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Message-ID: <20130418135257.GL79013@redhat.com>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
 <87li8gaku0.fsf@xmission.com> <20130418130009.GH79013@redhat.com>
 <20130418134904.GC2767@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130418134904.GC2767@roeck-us.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, "Eric W. Biederman" <ebiederm@xmission.com>, dyoung@redhat.com, vgoyal@redhat.com

On Thu, Apr 18, 2013 at 06:49:04AM -0700, Guenter Roeck wrote:
> On Thu, Apr 18, 2013 at 09:00:09AM -0400, Don Zickus wrote:
> > On Wed, Apr 17, 2013 at 02:49:59PM -0700, Eric W. Biederman wrote:
> > > Don Zickus <dzickus@redhat.com> writes:
> > > 
> > > > A common problem with kdump is that during the boot up of the
> > > > second kernel, the hardware watchdog times out and reboots the
> > > > machine before a vmcore can be captured.
> > > >
> > > > Instead of tellling customers to disable their hardware watchdog
> > > > timers, I hacked up a hook to put in the kdump path that provides
> > > > one last kick before jumping into the second kernel.
> > > >
> > > > The assumption is the watchdog timeout is at least 10-30 seconds
> > > > long, enough to get the second kernel to userspace to kick the watchdog
> > > > again, if needed.
> > > 
> > > Why not double the watchdog timeout? and/or pet the watchdog a little
> > > more frequently.
> > 
> > I am not sure if the watchdog timeouts can be doubled.  I think Guenter
> > was saying some have a max of a couple seconds?? Petting a little more
> > frequently might be an option.  Guenter can that be done with a softdog
> > option?
> > 
> Most watchdog driver permit at least a minute. Some are more limited.
> Worst I have seen is the BookE watchdog timer (non-Freescale version)
> which has a maximum of three seconds. But that is broken anyway.
> 
> Most hardware watchdogs implement a softdog on top of the hardware watchdog
> if the hardware needs to be pinged faster than every 60 seconds.
> 
> So, yes, for the most common case you should actually be able to live with a,
> say, 30-60 second timeout which is pinged at least every 5-10 seconds. I thought
> that somehow did not work in your case. Maybe a misunderstanding ?

No, that will probably work.  It is my misunderstanding.  Is there a
common way to check the timeout length and the ping frequency?

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

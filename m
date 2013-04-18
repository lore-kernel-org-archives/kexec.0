Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.active-venture.com ([67.228.131.205])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USf7U-0002x2-9G
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 03:02:44 +0000
Date: Wed, 17 Apr 2013 20:03:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Message-ID: <20130418030303.GA7294@roeck-us.net>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
 <87li8gaku0.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87li8gaku0.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Don Zickus <dzickus@redhat.com>, linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, dyoung@redhat.com, vgoyal@redhat.com

On Wed, Apr 17, 2013 at 02:49:59PM -0700, Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > A common problem with kdump is that during the boot up of the
> > second kernel, the hardware watchdog times out and reboots the
> > machine before a vmcore can be captured.
> >
> > Instead of tellling customers to disable their hardware watchdog
> > timers, I hacked up a hook to put in the kdump path that provides
> > one last kick before jumping into the second kernel.
> >
> > The assumption is the watchdog timeout is at least 10-30 seconds
> > long, enough to get the second kernel to userspace to kick the watchdog
> > again, if needed.
> 
> Why not double the watchdog timeout? and/or pet the watchdog a little
> more frequently.
> 
> This is the least icky hook I have seen proposed to be put on the kexec
> on panic path, but I still suspect this may reduce the ability to take a
> crash dump.  What happens if it was the watchdog timer that panic'd for
> example.
> 
That should be addressed by the use of mutex_trylock(), which should fail in
that case.

Guenter

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

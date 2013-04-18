Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USssx-000524-5h
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 17:44:39 +0000
Date: Thu, 18 Apr 2013 13:44:32 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Message-ID: <20130418174432.GN79013@redhat.com>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
 <87ip3j94qu.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ip3j94qu.fsf@xmission.com>
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
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, Guenter Roeck <linux@roeck-us.net>, dyoung@redhat.com, vgoyal@redhat.com

On Thu, Apr 18, 2013 at 09:35:05AM -0700, Eric W. Biederman wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > A common problem with kdump is that during the boot up of the
> > second kernel, the hardware watchdog times out and reboots the
> > machine before a vmcore can be captured.
> >
> > Instead of tellling customers to disable their hardware watchdog
> > timers, I hacked up a hook to put in the kdump path that provides
> > one last kick before jumping into the second kernel.
> 
> Having thought about this a little more this patch is actively wrong.
> 
> The problem is you can easily be petting the watchdog in violation of
> whatever policy is normally in place.  Which means that this extra
> petting can result in a system that is unavailable for an unacceptably
> long period of time.

Not really, just an extra period which isn't that much.  This would only
be noticable if kdump is setup and enabled and then _hung_, otherwise it
just quickly reboots and noone notices. :-)

> 
> I expect most watchdog policies are not that strict, but this patch
> would preclude using those that are.

I would assume most of those users would not enable kdump and would not be
affected.

> 
> And like is being discussed in another subthread it does look like
> changing the timeout and the interval should be enough all on it's own.

Probably and I will pursue that.  Thanks for the suggestion.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

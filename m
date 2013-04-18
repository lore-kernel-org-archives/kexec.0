Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USrnt-0003Kc-7z
 for kexec@lists.infradead.org; Thu, 18 Apr 2013 16:35:22 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
Date: Thu, 18 Apr 2013 09:35:05 -0700
In-Reply-To: <1366233596-34681-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Wed, 17 Apr 2013 17:19:56 -0400")
Message-ID: <87ip3j94qu.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
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
To: Don Zickus <dzickus@redhat.com>
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, Guenter Roeck <linux@roeck-us.net>, dyoung@redhat.com, vgoyal@redhat.com

Don Zickus <dzickus@redhat.com> writes:

> A common problem with kdump is that during the boot up of the
> second kernel, the hardware watchdog times out and reboots the
> machine before a vmcore can be captured.
>
> Instead of tellling customers to disable their hardware watchdog
> timers, I hacked up a hook to put in the kdump path that provides
> one last kick before jumping into the second kernel.

Having thought about this a little more this patch is actively wrong.

The problem is you can easily be petting the watchdog in violation of
whatever policy is normally in place.  Which means that this extra
petting can result in a system that is unavailable for an unacceptably
long period of time.

I expect most watchdog policies are not that strict, but this patch
would preclude using those that are.

And like is being discussed in another subthread it does look like
changing the timeout and the interval should be enough all on it's own.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

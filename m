Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USaFI-0007aC-0p
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 21:50:28 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
Date: Wed, 17 Apr 2013 14:49:59 -0700
In-Reply-To: <1366233596-34681-1-git-send-email-dzickus@redhat.com> (Don
 Zickus's message of "Wed, 17 Apr 2013 17:19:56 -0400")
Message-ID: <87li8gaku0.fsf@xmission.com>
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
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, linux@roeck-us.net, dyoung@redhat.com, vgoyal@redhat.com

Don Zickus <dzickus@redhat.com> writes:

> A common problem with kdump is that during the boot up of the
> second kernel, the hardware watchdog times out and reboots the
> machine before a vmcore can be captured.
>
> Instead of tellling customers to disable their hardware watchdog
> timers, I hacked up a hook to put in the kdump path that provides
> one last kick before jumping into the second kernel.
>
> The assumption is the watchdog timeout is at least 10-30 seconds
> long, enough to get the second kernel to userspace to kick the watchdog
> again, if needed.

Why not double the watchdog timeout? and/or pet the watchdog a little
more frequently.

This is the least icky hook I have seen proposed to be put on the kexec
on panic path, but I still suspect this may reduce the ability to take a
crash dump.  What happens if it was the watchdog timer that panic'd for
example.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

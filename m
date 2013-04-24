Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.active-venture.com ([67.228.131.205])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UV1VS-0003nR-Kq
 for kexec@lists.infradead.org; Wed, 24 Apr 2013 15:21:15 +0000
Date: Wed, 24 Apr 2013 08:21:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] watchdog: Add hook for kicking in kdump path
Message-ID: <20130424152142.GA26864@roeck-us.net>
References: <1366233596-34681-1-git-send-email-dzickus@redhat.com>
 <87li8gaku0.fsf@xmission.com> <20130418130009.GH79013@redhat.com>
 <20130418134904.GC2767@roeck-us.net>
 <20130418135257.GL79013@redhat.com>
 <20130418145413.GA1980@roeck-us.net>
 <20130424144226.GI79013@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130424144226.GI79013@redhat.com>
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
Cc: linux-watchdog@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, wim@iguana.be, "Eric W. Biederman" <ebiederm@xmission.com>, dyoung@redhat.com, vgoyal@redhat.com

On Wed, Apr 24, 2013 at 10:42:26AM -0400, Don Zickus wrote:
> On Thu, Apr 18, 2013 at 07:54:13AM -0700, Guenter Roeck wrote:
> > > No, that will probably work.  It is my misunderstanding.  Is there a
> > > common way to check the timeout length and the ping frequency?
> > > 
> > Usually it is configured in /etc/watchdog.conf if the watchdog package
> > is installed. The standard ping interval is "interval", the timeout is
> > "watchdog-timeout". See "man watchdog.conf" for details.
> > 
> > Minimum and maximum values for a given watchdog driver are not exported
> > to user space, so you would have to look into the driver sources to find
> > out what they are.
> 
> Hi Guenter,
> 
> Is there an easy way to determine which driver is loaded for each
> /dev/watchdogN device (from a script perspective).
> 
> Basically, I wanted to determine the module that needs to be included in
> the kdump initrd image.
> 
Sometimes. For example, the iTCO_wdt driver has an entry in /sys/devices, and
/sys/class/watchdog/watchdogX/device points to it. That is not always the case,
howewver. In my system, for example, the MEI watchdog is active, but there is
nothing I can find that would give me an indication that /dev/watchdog0 actually
points to the MEI watchdog driver.

Of course I might be missing something, and there might be some other means
to identify the driver from userspace. Would be great, actually, as I am having
the same problem.

Guenter

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5F5a-0001yQ-7y
 for kexec@lists.infradead.org; Thu, 28 Jan 2021 21:44:31 +0000
Received: by mail-ed1-x531.google.com with SMTP id dj23so8310426edb.13
 for <kexec@lists.infradead.org>; Thu, 28 Jan 2021 13:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20210126204125.313820-1-pasha.tatashin@soleen.com>
 <20210126204125.313820-2-pasha.tatashin@soleen.com>
 <87lfcczvab.fsf@x220.int.ebiederm.org>
In-Reply-To: <87lfcczvab.fsf@x220.int.ebiederm.org>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 28 Jan 2021 16:43:51 -0500
Message-ID: <CA+CK2bBMO+USv3SE25GNQDqpY-+4cEXrKbAmaSmsko=_CS6ZPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] kexec: dump kmessage before machine_kexec
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sasha Levin <sashal@kernel.org>, Petr Mladek <pmladek@suse.com>, Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>, Anton Vorontsov <anton@enomsg.org>, kexec mailing list <kexec@lists.infradead.org>, James Morris <jmorris@namei.org>, LKML <linux-kernel@vger.kernel.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, Colin Cross <ccross@android.com>

On Thu, Jan 28, 2021 at 3:01 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Pavel Tatashin <pasha.tatashin@soleen.com> writes:
>
> > kmsg_dump(KMSG_DUMP_SHUTDOWN) is called before
> > machine_restart(), machine_halt(), machine_power_off(), the only one that
> > is missing is  machine_kexec().
> >
> > The dmesg output that it contains can be used to study the shutdown
> > performance of both kernel and systemd during kexec reboot.
> >
> > Here is example of dmesg data collected after kexec:
>
> As long was we keep kmsg_dump out of the crash_kexec path where
> it completely breaks kexec on panic this seems a reasonable thing to do.
> On the ordinary kernel_kexec path everything is expected to be working.

This is an ordinary kexec reboot path, not kdump.

>
> Is kmsg_dump expected to work after all of the device drivers
> are shut down?  Otherwise this placement of kmsg_dump is too late.

Yes it is. It is called after device_shutdown(); in all other places.


Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-iy0-f177.google.com ([209.85.210.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJKeo-0007z3-HU
	for kexec@lists.infradead.org; Thu, 27 Oct 2011 07:45:47 +0000
Received: by iagz35 with SMTP id z35so3296816iag.36
	for <kexec@lists.infradead.org>; Thu, 27 Oct 2011 00:45:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1319645292.3321.24.camel@br98xy6r>
References: <1319645292.3321.24.camel@br98xy6r>
Date: Thu, 27 Oct 2011 15:45:44 +0800
Message-ID: <CAM_iQpXHieUhvTHOno_qQmE+6=PPhqrkuA4Xa7HP8JB9buOm=A@mail.gmail.com>
Subject: Re: kdump: No udev events for memory hotplug?
From: =?UTF-8?Q?Am=C3=A9rico_Wang?= <xiyou.wangcong@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On Thu, Oct 27, 2011 at 12:08 AM, Michael Holzheu
<holzheu@linux.vnet.ibm.com> wrote:
> Hello Vivek and Eric,
>

Hello,

> I noticed that on my system kernel 3.1 *no* udev events for memory
> hotplug are generated. Same on my RHEL6.1.
>
> # udevadm monitor
> # echo offline > /sys/devices/system/memory/memory4/state
>
> -> No event
>
> But we need the udev events in order to do a kdump reload for setting up
> the ELF loads correctly.
>
> In my /etc/udev/rules.d/98-kexec.rules there are rules for memory
> hotplug:
>
> SUBSYSTEM=="memory", ACTION=="add", PROGRAM="/etc/init.d/kdump restart"
> SUBSYSTEM=="memory", ACTION=="remove", PROGRAM="/etc/init.d/kdump
> restart"
>
> Perhaps/probably I am missing something?

As Heiko pointed out, probably the memory-hotplug subsystem doesn't implement
uevent, this is why you can't get uevent when you hot-remove the memory.

For kdump, the memory is reserved by "crashkernel=", it is determined during
boot (but you can shrink it after boot), so it is not aware of memory hotplug.
IOW, if you hot-remove the memory where the crash kernel stays, the
'kdump restart'
will fail. But yes, restarting kdump can rebuild the memmap and ELF headers.

Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

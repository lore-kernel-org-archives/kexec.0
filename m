Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QuOnS-0006X4-IU
	for kexec@lists.infradead.org; Fri, 19 Aug 2011 13:07:39 +0000
Received: by gyh20 with SMTP id 20so2434697gyh.36
	for <kexec@lists.infradead.org>; Fri, 19 Aug 2011 06:07:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF087F73E2.5ECF6BE5-ON862578F0.0079BA5A-862578F0.007AD1A0@us.ibm.com>
References: <OF087F73E2.5ECF6BE5-ON862578F0.0079BA5A-862578F0.007AD1A0@us.ibm.com>
Date: Fri, 19 Aug 2011 21:07:36 +0800
Message-ID: <CALZhoSSnHcfuTaKv6FCrONhh5DXtfO+JV6hOQzWfKhYG5WYeDg@mail.gmail.com>
Subject: Re: Bootloaders with early kdump support?
From: Lei Wen <adrian.wenl@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Nathan D Miller <nathanm2@us.ibm.com>
Cc: kexec@lists.infradead.org

Hi Nathan,

On Fri, Aug 19, 2011 at 6:21 AM, Nathan D Miller <nathanm2@us.ibm.com> wrot=
e:
> Greetings-
>
> Vivek made the following statement a few months ago:
>
>> On a side note, few months back there were folks who were trying
>> to enhance bootloaders to be able to prepare basic environment so
>> that a kdump kernel can boot even in the event of early first
>> kernel boot.
>
> Any idea which bootloaders? =A0Which folks?
>
> I'm curious how one would go about implementing such a thing. =A0What
> parameters would the bootloader need to supply to the kernel?

Actually I ask a similar question for it, but sightly different at
that I try to trigger
the dump kernel at the moment the first kernel unable to trigger. Core hang=
, or
very bad dead lock all could lead to this...

I recently make some patches to both the kernel and kexec tools side, and b=
asic
idea is:
1) Move copy kernel relocation code to the stage of
machine_kexec_prepare() from original
in machine_kexec()
2) Provide a new supported flags for kexec_load api to support
crash_update method. In this
method,  I would call crash_setup_regs(), crash_save_vmcoreinfo() and
machine_crash_update().
3) Add patch to kexec to support the new supported flags. This new
made method could be called
as a daemon in the kernel, and the info pass to the crash kernel could
be gotten updated to
the point of dead lock.
4) After kernel meet core hang, we reset the board and while enter the
uboot, we let the uboot to
directly transfer the control to the crash kernel. Since crash kernel
is already loaded, and reloaction
code and parameter all has been set up. There is no more effort for
the bootloader, just transferring
control would do the all good.

Best regards,
Lei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

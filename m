Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpxAr-0000BE-CL
 for kexec@lists.infradead.org; Thu, 17 Dec 2020 17:34:46 +0000
Received: from mail-ej1-f70.google.com ([209.85.218.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kpxAp-0001SY-L1
 for kexec@lists.infradead.org; Thu, 17 Dec 2020 17:34:43 +0000
Received: by mail-ej1-f70.google.com with SMTP id t17so8956397ejd.12
 for <kexec@lists.infradead.org>; Thu, 17 Dec 2020 09:34:43 -0800 (PST)
MIME-Version: 1.0
References: <87h7oudcbx.fsf@vps.thesusis.net>
 <CAHD1Q_zcruQ6KVHApvhb=0+mG0m80T+tmg1UzjQBki8j+aR51A@mail.gmail.com>
 <87czzcdtir.fsf@vps.thesusis.net>
In-Reply-To: <87czzcdtir.fsf@vps.thesusis.net>
From: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Date: Thu, 17 Dec 2020 14:34:07 -0300
Message-ID: <CAHD1Q_z+WW36rfr1RAFYKjU5bocA90OonBmSKECRnpacvWyPmQ@mail.gmail.com>
Subject: Re: kexec not working in xen domU?
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
To: Phillip Susi <phill@thesusis.net>
Cc: xen-devel@lists.xenproject.org, kexec mailing list <kexec@lists.infradead.org>

On Mon, Dec 14, 2020 at 5:25 PM Phillip Susi <phill@thesusis.net> wrote:
> The regular xen cosole should work for this shouldn't it?  So
> earlyprintk=hvc0 I guess?  I also threw in console=hvc0 and loglevel=7:
>
> [  184.734810] systemd-shutdown[1]: Syncing filesystems and block
> devices.
> [  185.772511] systemd-shutdown[1]: Sending SIGTERM to remaining
> processes...
> [  185.896957] systemd-shutdown[1]: Sending SIGKILL to remaining
> processes...
> [  185.901111] systemd-shutdown[1]: Unmounting file systems.
> [  185.902180] [1035]: Remounting '/' read-only in with options
> 'errors=remount-ro'.
> [  185.990634] EXT4-fs (xvda1): re-mounted. Opts: errors=remount-ro
> [  186.002373] systemd-shutdown[1]: All filesystems unmounted.
> [  186.002411] systemd-shutdown[1]: Deactivating swaps.
> [  186.002502] systemd-shutdown[1]: All swaps deactivated.
> [  186.002529] systemd-shutdown[1]: Detaching loop devices.
> [  186.002699] systemd-shutdown[1]: All loop devices detached.
> [  186.002727] systemd-shutdown[1]: Stopping MD devices.
> [  186.002814] systemd-shutdown[1]: All MD devices stopped.
> [  186.002840] systemd-shutdown[1]: Detaching DM devices.
> [  186.002974] systemd-shutdown[1]: All DM devices detached.
> [  186.003017] systemd-shutdown[1]: All filesystems, swaps, loop
> devices, MD devices and DM devices detached.
> [  186.168475] systemd-shutdown[1]: Syncing filesystems and block
> devices.
> [  186.169150] systemd-shutdown[1]: Rebooting with kexec.
> [  186.418653] xenbus_probe_frontend: xenbus_frontend_dev_shutdown:
> device/vbd/5632: Initialising != Connected, skipping
> [  186.427377] kexec_core: Starting new kernel
>

Hm..not many prints, either earlyprintk didn't work, or it's a really
early boot issue. Might worth to investigate if it's not a purgatory
issue too - did you try to use the ""new"" kexec syscall, by running
"kexec -s -l" instead of just "kexec -l" ?
Also, worth to try that with upstream kernel and kexec-tools - I
assume you're doing that already?

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

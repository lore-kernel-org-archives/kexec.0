Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from vps.thesusis.net ([34.202.238.73])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kouPm-0003Wc-QS
 for kexec@lists.infradead.org; Mon, 14 Dec 2020 20:25:53 +0000
References: <87h7oudcbx.fsf@vps.thesusis.net>
 <CAHD1Q_zcruQ6KVHApvhb=0+mG0m80T+tmg1UzjQBki8j+aR51A@mail.gmail.com>
From: Phillip Susi <phill@thesusis.net>
Subject: Re: kexec not working in xen domU?
Date: Mon, 14 Dec 2020 15:08:57 -0500
In-reply-to: <CAHD1Q_zcruQ6KVHApvhb=0+mG0m80T+tmg1UzjQBki8j+aR51A@mail.gmail.com>
Message-ID: <87czzcdtir.fsf@vps.thesusis.net>
MIME-Version: 1.0
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
To: "Guilherme G. Piccoli" <guilherme.piccoli@canonical.com>
Cc: xen-devel@lists.xenproject.org, kexec mailing list <kexec@lists.infradead.org>


Guilherme G. Piccoli writes:

> Can you capture the serial console in a pastebin? Maybe add something
> like "earlyprintk=ttySX", where ttySX is your known-to-work serial
> console output. This helps to determine if it's a shutdown issue or an
> early boot problem.

The regular xen cosole should work for this shouldn't it?  So
earlyprintk=hvc0 I guess?  I also threw in console=hvc0 and loglevel=7:

[  184.734810] systemd-shutdown[1]: Syncing filesystems and block
devices.
[  185.772511] systemd-shutdown[1]: Sending SIGTERM to remaining
processes...
[  185.896957] systemd-shutdown[1]: Sending SIGKILL to remaining
processes...
[  185.901111] systemd-shutdown[1]: Unmounting file systems.
[  185.902180] [1035]: Remounting '/' read-only in with options
'errors=remount-ro'.
[  185.990634] EXT4-fs (xvda1): re-mounted. Opts: errors=remount-ro
[  186.002373] systemd-shutdown[1]: All filesystems unmounted.
[  186.002411] systemd-shutdown[1]: Deactivating swaps.
[  186.002502] systemd-shutdown[1]: All swaps deactivated.
[  186.002529] systemd-shutdown[1]: Detaching loop devices.
[  186.002699] systemd-shutdown[1]: All loop devices detached.
[  186.002727] systemd-shutdown[1]: Stopping MD devices.
[  186.002814] systemd-shutdown[1]: All MD devices stopped.
[  186.002840] systemd-shutdown[1]: Detaching DM devices.
[  186.002974] systemd-shutdown[1]: All DM devices detached.
[  186.003017] systemd-shutdown[1]: All filesystems, swaps, loop
devices, MD devices and DM devices detached.
[  186.168475] systemd-shutdown[1]: Syncing filesystems and block
devices.
[  186.169150] systemd-shutdown[1]: Rebooting with kexec.
[  186.418653] xenbus_probe_frontend: xenbus_frontend_dev_shutdown:
device/vbd/5632: Initialising != Connected, skipping
[  186.427377] kexec_core: Starting new kernel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

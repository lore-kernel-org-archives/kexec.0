Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PbJSH-0000DR-4P
	for kexec@lists.infradead.org; Fri, 07 Jan 2011 21:02:37 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>
	<m1bp3uifln.fsf@fess.ebiederm.org>
	<AANLkTinLhAuSny735kofonAkaqwJvjjDHMUed_r03rVc@mail.gmail.com>
	<m1k4igjwzf.fsf@fess.ebiederm.org>
	<1294432333.3237.107.camel@localhost.localdomain>
Date: Fri, 07 Jan 2011 13:02:32 -0800
In-Reply-To: <1294432333.3237.107.camel@localhost.localdomain> (Eric Paris's
	message of "Fri, 07 Jan 2011 15:32:13 -0500")
Message-ID: <m18vywh1g7.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [Patch] kexec_load: check CAP_SYS_MODULE
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric Paris <eparis@redhat.com>
Cc: kexec@lists.infradead.org, Amerigo Wang <amwang@redhat.com>, linux-kernel@vger.kernel.org

Eric Paris <eparis@redhat.com> writes:

>> If I was building a configuration where I didn't want anyone to be able
>> to direct the kernel into a different state by locking down the
>> bootloaders I expect I would compile out the syscall as well.
>
> As sad as it may sound the vast majority of people don't build their own
> kernels.  And even those people who have the intelligence to do it are
> often constrained by some non-technical policy to run 'approved'
> kernels. 

Yes I am aware of the crazy game that is called approved kernels.  Where
there are too many regressions for people to trust new kernel releases
but people want to change the kernel and the setup from what was tested
and still have the stamp of approval anyway.  Financially it seems to
make people money, but as best I can tell that game is ultimately what
killed unix.

In this instance you seem to be redefining CAP_SYS_MODULE and
CAP_SYS_REBOOT so you can play that game. 

> Maybe I didn't make it clear how this is going to be used.  I plan to
> drop CAP_SYS_MODULE to stop root from loading their own modules and
> running their own code in the kernel.  I can control reboot() since I
> control the platform and the bootloader.  I cannot control kexec().  I'm
> also required to use a generic distro kernel (bet you can't guess which
> one)

If you are truly locked down I recommend dropping CAP_SYS_REBOOT and
setting up a watchdog that keeps the system from rebooting (standard
practice in embedded kinds of setups like you describe).  That should
meet everyone requirements without needing to game the system.

> The only solution I see to solve the problem is to gate kexec on
> CAP_SYS_MODULE.  Which makes sense since kexec() is in many respects
> close to module_init() than it is to reboot().

kexec_load is nothing like module_init().  All it does it puts data in
memory for use by a subsequent reboot.  /sbin/kexec is a bootloader that
runs inside of linux.  All you are noticing is that if you don't control
/sbin/kexec you aren't controlling the bootloader.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

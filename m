Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Pbkiy-0001Jr-Sd
	for kexec@lists.infradead.org; Sun, 09 Jan 2011 02:09:42 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1294302325-22593-1-git-send-email-amwang@redhat.com>
	<m1bp3uifln.fsf@fess.ebiederm.org>
	<AANLkTinLhAuSny735kofonAkaqwJvjjDHMUed_r03rVc@mail.gmail.com>
	<m1k4igjwzf.fsf@fess.ebiederm.org>
	<1294432333.3237.107.camel@localhost.localdomain>
	<m18vywh1g7.fsf@fess.ebiederm.org>
	<1294447189.3237.132.camel@localhost.localdomain>
Date: Sat, 08 Jan 2011 18:09:17 -0800
In-Reply-To: <1294447189.3237.132.camel@localhost.localdomain> (Eric Paris's
	message of "Fri, 07 Jan 2011 19:39:49 -0500")
Message-ID: <m1k4ieesky.fsf@fess.ebiederm.org>
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

> On Fri, 2011-01-07 at 13:02 -0800, Eric W. Biederman wrote:
>> Eric Paris <eparis@redhat.com> writes:
>
>> Yes I am aware of the crazy game that is called approved kernels.  Where
>> there are too many regressions for people to trust new kernel releases
>> but people want to change the kernel and the setup from what was tested
>> and still have the stamp of approval anyway.  Financially it seems to
>> make people money, but as best I can tell that game is ultimately what
>> killed unix.
>
> I don't believe this is a particularly relevant line of conversion and
> should probably drop it, but I can't completely leave it alone.  We
> obviously have a very different understanding of what concerning the
> unix wars brought about its death.  I'd think it obvious that the very
> fact that this conversation is taking place shows that the exact
> opposite of the unix wars problems are being seen here.  You clearly
> have personal opinions about the benefits of custom built kernels, but
> they are not the opinions of the vast majority of linux users.  I rarely
> run disto kernels and I'm sure few on lkml do, but it doesn't change the
> fact that most users, especially large IT environments, require system
> standardization.  I hope to address the needs of this portion of the
> linux community even if you might wish they functioned differently.

Sure and if you have a good clear architecture not an adhoc set of goals
getting it into the standard kernel makes sense.

Trying to shoe horn everyone crazy ideas into the standard kernel before
they are well thought out is a bad idea.

What I am most sensitive to about distro kernels is the massive
stagnation that happens (it gets extremely silly to run a kernel that is
several years old on bleeding edge hardware) as well as the crazy hacks
that I see people asking for because they must use a distro kernel for
random reasons.

>> In this instance you seem to be redefining CAP_SYS_MODULE and
>> CAP_SYS_REBOOT so you can play that game.
>
> Clearly I am refining the meaning of both in some way.  Personally I
> think the current differentiation is wrong.

To some extent I agree.  The old check for being uid == 0 is the only
real check that makes much sense.

>> > Maybe I didn't make it clear how this is going to be used.  I plan to
>> > drop CAP_SYS_MODULE to stop root from loading their own modules and
>> > running their own code in the kernel.  I can control reboot() since I
>> > control the platform and the bootloader.  I cannot control kexec().  I'm
>> > also required to use a generic distro kernel (bet you can't guess which
>> > one)
>> 
>> If you are truly locked down I recommend dropping CAP_SYS_REBOOT and
>> setting up a watchdog that keeps the system from rebooting (standard
>> practice in embedded kinds of setups like you describe).  That should
>> meet everyone requirements without needing to game the system.
>
> This does not meet the set of requirements.  I recognize that you don't
> have the full architecture in mind (and apologize that I can't describe
> it much better than I am already), but root should still be allowed to
> reboot the machine.  This is not an embedded platform.  Nor one in which
> a watchdog task makes any sense at all.

What you are asking for if I understand this correctly is a way to
disable sys_kexec_load?

What strange things are you trying to accomplish on top of a
distribution kernel?

>> > The only solution I see to solve the problem is to gate kexec on
>> > CAP_SYS_MODULE.  Which makes sense since kexec() is in many respects
>> > close to module_init() than it is to reboot().
>> 
>> kexec_load is nothing like module_init().  All it does it puts data in
>> memory for use by a subsequent reboot.  /sbin/kexec is a bootloader that
>> runs inside of linux.  All you are noticing is that if you don't control
>> /sbin/kexec you aren't controlling the bootloader.
>
> Does that mean you would instead prefer that we check CAP_SYS_MODULE in
> sys_reboot() when LINUX_REBOOT_CMD_KEXEC is set (or really
> kernel_kexec())?  It seems to me you indicate that is the more analogous
> location since it is the actual place where we load new kernel code on
> the running system (aka what sys_module was intended to protect)?

We aren't dealing with modules I think CAP_SYS_MODULE is totally
irrelevant in the context of kexec.

I think to accomplish what you want we either need a way to disable
sys_kexec_load or possibly a new very targeted capability bit.

You are making it so that giving someone CAP_SYS_MODULE is giving more
than the ability to load kernel modules.  Which seems non-intuitive from
a system management point of view.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

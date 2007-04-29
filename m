Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HiAgW-0000Us-7E
	for kexec@lists.infradead.org; Sun, 29 Apr 2007 10:47:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Fastboot] restoring x86 BIOS state before reboot
References: <20070406154628.GG12005@jukie.net>
	<m1zm4rd676.fsf@ebiederm.dsl.xmission.com>
	<20070429094135.GA10948@suse.de>
Date: Sun, 29 Apr 2007 08:46:59 -0600
In-Reply-To: <20070429094135.GA10948@suse.de> (Bernhard Walle's message of
	"Sun, 29 Apr 2007 11:41:35 +0200")
Message-ID: <m1ejm38cgs.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>

Bernhard Walle <bwalle@suse.de> writes:

> * Eric W. Biederman <ebiederm@xmission.com> [2007-04-29 08:51]:
>> 
>> It may also be worth investigating if it is possible to bypass
>> the part of windows that uses BIOS calls.  I really don't have
>> a clue how a modern windows systems boots.
>
> I think ReactOS has a bootlader that can also boot Windows, or at
> least they are close to booting the Windows kernel. That bootloader
> could be then used for booting Windows without BIOS calls.
>
> I also heard that the 100-$-Laptop should now be able to use Windows.
> As it's using LinuxBIOS, this could also be interesting. However,
> maybe Microsoft simply modifies a special Windows for this, or they
> integrate a ClosedSource part in that LinuxBIOS, I don't know ... :-(

I know it isn't a ClosedSource part in LinuxBIOS.

In any particular case you can work through the details, and
make it work.

The hard part is making the general case work.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

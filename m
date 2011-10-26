Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RJ95s-0004G0-4K
	for kexec@lists.infradead.org; Wed, 26 Oct 2011 19:24:56 +0000
Date: Wed, 26 Oct 2011 15:24:49 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump: No udev events for memory hotplug?
Message-ID: <20111026192449.GE355@redhat.com>
References: <1319645292.3321.24.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1319645292.3321.24.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: heiko.carstens@de.ibm.com, Kay Sievers <kay.sievers@vrfy.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com

On Wed, Oct 26, 2011 at 06:08:12PM +0200, Michael Holzheu wrote:
> Hello Vivek and Eric,
> 
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

I don't know. Sounds like a bug. I have never looked into it. CCing Kay,
if he has any thoughts.

Are any events generated for memory add?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

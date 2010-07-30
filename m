Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OeuRt-0004O8-Ei
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 18:36:51 +0000
Subject: Re: In place kexec
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>
	<4C51BFA5.60507@zytor.com> <m1k4oe88n9.fsf@fess.ebiederm.org>
	<4C51C878.2090102@zytor.com> <20100729191654.GB28704@redhat.com>
	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<4C525D6A.4000007@zytor.com> <m1aap93pak.fsf@fess.ebiederm.org>
	<4C5300B9.2080507@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 30 Jul 2010 11:36:43 -0700
In-Reply-To: <4C5300B9.2080507@zytor.com> (H. Peter Anvin's message of "Fri\,
	30 Jul 2010 09\:41\:29 -0700")
Message-ID: <m1sk30zuis.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-driver@qlogic.com, Vivek Goyal <vgoyal@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 07/30/2010 09:30 AM, Eric W. Biederman wrote:
>> 
>>>> That said it looks like the code to do the shutdown is in
>>>> qla2x00_remove_one so it should be too hard if someone cared to
>>>> extract just the hardware bits.
>>>
>>> Charming.  Code is there, just not hooked up.
>> 
>> Using the .remove method in reboot is a fight a lost long ago.
>> 
>
> Could you elucidate, please?

My original proposal was for device_shutdown to call the .remove
methods as those are well exercised and tested in development. aka
rmmod.

It was argued (with some merit) that for a system reboot we don't want
to perform all of the subsystem registration work, to make it more
likely that reboot -f will reboot even if there is a kernel oops.

What I proposed and unfortunately failed to write the patch for at the
time is was to have the device remove path call shutdown before calling
remove, so drivers wouldn't have to code it all up twice.

A lot of the disk drivers implement .shutdown these days and there aren't
may bug reports about kexec failing.  So I would be reluctant to change
things other than on a driver by driver basis unless I had a lot of time
for testing etc.

It might be worth playing with adding a pci_clear_master in
pci_device_shutdown.  It has the potential to break things like usb
keyboards, so I would be careful.  If it doesn't break fundamental
things like usb a pci_clear_master when shutting down devices should
improve reliability somewhat.

And of course there is the old staple of work arounds: "rmmod <driver>"
before calling kexec --exec.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

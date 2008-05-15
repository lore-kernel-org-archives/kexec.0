Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JwkP4-0006cJ-KK
	for kexec@lists.infradead.org; Thu, 15 May 2008 20:50:19 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <Pine.LNX.4.44L0.0805151012150.2107-100000@iolanthe.rowland.org>
Date: Thu, 15 May 2008 13:48:14 -0700
In-Reply-To: <Pine.LNX.4.44L0.0805151012150.2107-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 15 May 2008 10:14:00 -0400 (EDT)")
Message-ID: <m18wybqooh.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [linux-pm] [PATCH -mm] kexec jump -v9
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 14 May 2008, Eric W. Biederman wrote:
>
>> My take on the situation is this.  For proper handling we
>> need driver device_detach and device_reattach methods.
>> 
>> With the following semantics.  The device_detach methods
>> will disable DMA and place the hardware in a sane state
>> from which the device driver can reclaim and reinitialize it,
>> but the hardware will not be touched.
>> 
>> device_reattach reattaches the driver to the hardware.
>
> How would these differ from the already-existing remove and probe 
> methods?

Honestly I would like for them not to, and they should be
proper factors of the remove and probe methods.

However we have a fundamental gotcha that we need to handle.
Logical abstractions on physical devices.

i.e.  How do we handle the case of a filesystem on a block
      device, when we remove the block device and then read it.

We have two choices.
1) We go through the pain of teaching the upper layers in the
   kernel of how to deal with hotplug and then we are sane
   when someone removes a usb stick accidentally before
   unmounting it and then reinserts the usb stick.

2) Teach the drivers how to do just the lower have of hotplug/remove.
   In which case with the driver still present and presenting it's
   upper layer queues we have the driver relinquish it's hardware
   and then later check to see if it's hardware is still present
   and reinitialize it.

I don't know if anyone has looked at moving this to an upper layer.
Definitely a question worth asking.  The simpler we can make this
for driver authors the better.  Especially as that will make
the drivers more maintainable long term.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

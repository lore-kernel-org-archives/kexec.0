Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com
 ([213.199.154.250] helo=db9outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UyVQ0-0008Ee-3o
 for kexec@lists.infradead.org; Sun, 14 Jul 2013 23:09:29 +0000
Message-ID: <51E32F76.5070502@mail.usask.ca>
Date: Sun, 14 Jul 2013 17:08:38 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca>	 <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia>	 <51E07056.8040007@mail.usask.ca>
 <51E08A40.80900@mail.usask.ca>	 <51E0F41A.20904@mail.usask.ca>
 <20130714043600.GA30717@concordia> <1373779584.19894.270.camel@pasglop>
In-Reply-To: <1373779584.19894.270.camel@pasglop>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kexec@lists.infradead.org, Michael Ellerman <michael@ellerman.id.au>, Haren Myneni <hbabu@us.ibm.com>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

On 07/13/2013 11:26 PM, Benjamin Herrenschmidt wrote:
> On Sun, 2013-07-14 at 14:36 +1000, Michael Ellerman wrote:
>>>> Is this expected behaviour? It seems to be the same in current git
>>>> versions of kexec-tools.
>>>>
>>>> On my system I see "/proc/device-tree/memory".
>>>>
>>>> If I modify add_usable_mem_property() to also accept "/memory" then
>> my
>
> This is a bug in your device-tree. The memory node should have a unit
> address which corresponds to it's reg property. I know people tend to
> skip it for "0" but it's bad practice.
>
> So for memory starting at 0 it should be memory@0

There are a fair number of dts files in the kernel tree that don't 
specify an address for the memory node.

If the kernel accepts it without an address, it seems logical that kexec 
should as well.

Or maybe the kernel should just implicitly assume an address of zero and 
export it as such in /proc/device-tree?

Chris


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

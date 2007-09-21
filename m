Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.andrew.cmu.edu ([128.2.10.212])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IYps8-00073T-PP
	for kexec@lists.infradead.org; Fri, 21 Sep 2007 17:17:16 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: [linux-pm] Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
References: <Pine.LNX.4.44L0.0709211540100.5816-100000@iolanthe.rowland.org>
	<200709212253.02158.rjw@sisk.pl> <87d4wb680u.fsf@jbms.ath.cx>
	<200709212325.39599.rjw@sisk.pl>
Date: Fri, 21 Sep 2007 17:16:59 -0400
In-Reply-To: <200709212325.39599.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Fri\, 21 Sep 2007 23\:25\:37 +0200")
Message-ID: <878x6z67n8.fsf@jbms.ath.cx>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, linux-pm@lists.linux-foundation.org, huang ying <huang.ying.caritas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Friday, 21 September 2007 23:08, Jeremy Maitin-Shepard wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>> > On Friday, 21 September 2007 22:26, Jeremy Maitin-Shepard wrote:
>> >> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> >> 
>> >> [snip]
>> >> 
>> >> > The ACPI NVS area is explicitly marked as reserved and we don't save it.
>> >> > On x86_64 we don't save any memory areas marked as reserved and yet the
>> > above
>> >> > happens.
>> >> 
>> >> I think you have mentioned before, though, that ACPI is first
>> >> initialized by the boot kernel, before it is later initialized by
>> >> resuming kernel.  This could well be the source of the problem.
>> 
>> > No, it's not.  I have tested that too with an ACPI-less boot kernel.
>> 
>> Well, it seems that there just must be some other bug.  I would define
>> anything that differs between the post-resume initialization of ACPI

> I'm not sure what you mean.

>> from the normal boot initialization of ACPI as a bug.  If the interaction
>> with the hardware is the same, then the behavior will be the same.

> The ACPI platform firmware is allowed to preserve information accross the
> hibernation-resume cycle, so this need not be the same.

All of my comments related to the case where S4 is not being used
(instead the system is just powered off normally), and a boot kernel
that does not initialize ACPI is used.  In that case, the ACPI platform
firmware should not be able to distinguish a normal boot from a resume
from hibernation.

-- 
Jeremy Maitin-Shepard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

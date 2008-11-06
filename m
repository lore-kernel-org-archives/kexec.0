Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky731-0004dV-UC
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 15:45:40 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>
	<1225915018-6548-16-git-send-email-ehabkost@redhat.com>
	<20081106071445.GI15731@elte.hu> <20081106124031.GO5247@blackpad>
	<20081106143021.GD13023@elte.hu> <20081106150610.GA1644@elte.hu>
Date: Thu, 06 Nov 2008 07:41:01 -0800
In-Reply-To: <20081106150610.GA1644@elte.hu> (Ingo Molnar's message of "Thu, 6
	Nov 2008 16:06:10 +0100")
Message-ID: <m1mygczwtu.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Avi Kivity <avi@redhat.com>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Ingo Molnar <mingo@elte.hu> writes:

> * Ingo Molnar <mingo@elte.hu> wrote:
>
>> > Andrey Borzenkov's patch, for example, adds a new DMI entry 
>> > because reboot=acpi breaks his keyboard (even without KVM, I 
>> > guess). Andrey, was that the case?
>> 
>> hm, IIRC the problem was KVM in his case too.
>
> actually, Andrey's problem seems to be unrelated. So i've queued up 
> the revert below in tip/x86/urgent for v2.6.28. Thanks guys!

If there are a number of problems with reboot and reset
I'm wondering if we should investigate using an
outb to port 0x92.  With the right bit set you can trigger
a toggle of the reset line on many motherboards.

Eric



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

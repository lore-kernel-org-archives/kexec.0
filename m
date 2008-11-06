Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.redhat.com ([66.187.237.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ky79o-0004BB-5m
	for kexec@lists.infradead.org; Thu, 06 Nov 2008 15:52:28 +0000
Message-ID: <491312AA.6000006@redhat.com>
Date: Thu, 06 Nov 2008 17:52:10 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 15/15] Revert "x86: default to reboot via ACPI"
References: <1225915018-6548-1-git-send-email-ehabkost@redhat.com>	<1225915018-6548-16-git-send-email-ehabkost@redhat.com>	<20081106071445.GI15731@elte.hu>
	<20081106124031.GO5247@blackpad>	<20081106143021.GD13023@elte.hu>
	<20081106150610.GA1644@elte.hu> <m1mygczwtu.fsf@frodo.ebiederm.org>
In-Reply-To: <m1mygczwtu.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Haren Myneni <hbabu@us.ibm.com>, Simon Horman <horms@verge.net.au>, Ingo Molnar <mingo@elte.hu>, Andrey Borzenkov <arvidjaar@mail.ru>, mingo@redhat.com, Vivek Goyal <vgoyal@redhat.com>

Eric W. Biederman wrote:
> If there are a number of problems with reboot and reset
> I'm wondering if we should investigate using an
> outb to port 0x92.  With the right bit set you can trigger
> a toggle of the reset line on many motherboards.
>   

Most likely that's what the ACPI reset describes.

-- 
error compiling committee.c: too many arguments to function


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

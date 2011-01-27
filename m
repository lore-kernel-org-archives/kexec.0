Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiUVU-0003cJ-No
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 16:15:37 +0000
Message-ID: <4D41997D.5070206@zytor.com>
Date: Thu, 27 Jan 2011 08:12:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
	panic
References: <20110125134748.GA10051@laptop>	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>	<20110126124954.GC24527@laptop>
	<20110126125813.GA26952@elte.hu>	<20110126133400.GA3399@laptop>
	<20110126140030.GB30064@elte.hu>	<4D40F5FD.6090507@zytor.com>
	<20110127114113.GB20279@elte.hu> <m1aaimxs9h.fsf@fess.ebiederm.org>
In-Reply-To: <m1aaimxs9h.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?ISO-8859-1?Q?Fr=E9d=E9ric_W?= =?ISO-8859-1?Q?eisbecker?= <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, X86-ML <x86@kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

On 01/27/2011 07:47 AM, Eric W. Biederman wrote:
>>
>> Yes - but at least a long time ago there used to be modi of reboot when the BIOS did
>> not do this. Whether that's possible at all with modern BIOSen is a
>> big question ...
>
> As I recall that was how you went from 32bit mode to 16bit real mode.
> The issue is that mode never reset the hardware it simply changed the
> cpu mode.
>

Quite correct.  It doesn't just bypass the memory wipe, it bypasses the 
entire POST.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

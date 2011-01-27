Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiJcm-0006ge-GE
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 04:38:25 +0000
Message-ID: <4D40F5FD.6090507@zytor.com>
Date: Wed, 26 Jan 2011 20:35:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
	panic
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop>
	<20110126125813.GA26952@elte.hu> <20110126133400.GA3399@laptop>
	<20110126140030.GB30064@elte.hu>
In-Reply-To: <20110126140030.GB30064@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?ISO-8859-1?Q?Fr=E9d=E9ric_W?= =?ISO-8859-1?Q?eisbecker?= <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, X86-ML <x86@kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Mark Lord <kernel@teksavvy.com>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

On 01/26/2011 06:00 AM, Ingo Molnar wrote:
>
> I mean, use the warm reset vector to truly reset the box.
>
> Then, once a stable known-good kernel boots, *that* kernel can then recover all the
> log data which is sitting in a well-known place in RAM, automatically and
> transparently.
>
> Basically a bit like kexec, just more convenient and it also goes through the BIOS
> warm reset, so it might work better than kexec ...
>

The problem is that the BIOS will often wipe memory.

	-hpa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

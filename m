Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PiMeO-0007M6-5a
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 07:52:17 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110127021338.GA20334@redhat.com>
	<4D40F81E.1030009@zytor.com> <20110127052639.GA16289@laptop>
Date: Wed, 26 Jan 2011 23:51:50 -0800
In-Reply-To: <20110127052639.GA16289@laptop> (Ahmed S. Darwish's message of
	"Thu, 27 Jan 2011 07:26:39 +0200")
Message-ID: <m1sjweyeax.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk upon
	panic
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
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

"Ahmed S. Darwish" <darwish.07@gmail.com> writes:

> On Wed, Jan 26, 2011 at 08:44:14PM -0800, H. Peter Anvin wrote:
>> On 01/26/2011 06:13 PM, Vivek Goyal wrote:
>>>>
>>>> - Use kexec/kdump. I wonder though, can kexec work on early panics? The
>>>>    kind where the disk itself might not yet be initialized?
>>>
>>> As of today kexec/kdump does not work with early panics as kdump kernel
>>> needs to be loaded in reserved memory and that action happens once the
>>> first kernel has booted.
>>>
>>> There is so much to it that I really don't think that modifying bootloaders to
>>> do all that might not trivial and more importantly I think it probably is not
>>> worth the effort.
>>>
>>
>> It's really not all that hard, actually.
>>
>
> Nice, I'll try prototyping this using syslinux and kexec: this seems the
> safest path so far. Further details are in my first reply to Vivek.

Given the inertia of boot loaders it might make sense to compile in the
crash recovery code.

Regardless the way I would organize this is simply to have a chunk of
memory that you place the crash reporting kernel and initrd in, and
simply tell the linux about it, at boot time.  Then kexec on panic can
be pointed at it and that is the end of the matter.  That is very simple.

It might be a bit tricky to get all of the context information the crash
kernel needs, but it should not be too bad.  I am with Vivek in being a
bit dubious if this will do better in practice than having a crash
kernel that we load from the initramfs, simply because the maintenance
difficulty of a specialized component.  But I see no reason to not add
the basic mechanism, to the kernel and bootloaders.  The basic mechanism
is simple and easy to maintain, and ultimately should work across platforms.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

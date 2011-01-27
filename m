Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiKNd-0006qC-9b
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 05:26:49 +0000
Received: by wwb17 with SMTP id 17so1792009wwb.18
	for <kexec@lists.infradead.org>; Wed, 26 Jan 2011 21:26:47 -0800 (PST)
Date: Thu, 27 Jan 2011 07:26:39 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Message-ID: <20110127052639.GA16289@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110127021338.GA20334@redhat.com>
	<4D40F81E.1030009@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D40F81E.1030009@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, X86-ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Vivek Goyal <vgoyal@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>

On Wed, Jan 26, 2011 at 08:44:14PM -0800, H. Peter Anvin wrote:
> On 01/26/2011 06:13 PM, Vivek Goyal wrote:
>>>
>>> - Use kexec/kdump. I wonder though, can kexec work on early panics? The
>>>    kind where the disk itself might not yet be initialized?
>>
>> As of today kexec/kdump does not work with early panics as kdump kernel
>> needs to be loaded in reserved memory and that action happens once the
>> first kernel has booted.
>>
>> There is so much to it that I really don't think that modifying bootloaders to
>> do all that might not trivial and more importantly I think it probably is not
>> worth the effort.
>>
>
> It's really not all that hard, actually.
>

Nice, I'll try prototyping this using syslinux and kexec: this seems the
safest path so far. Further details are in my first reply to Vivek.

> 	-hpa

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

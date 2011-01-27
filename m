Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ww0-f49.google.com ([74.125.82.49])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PiIcR-0006VH-Mu
	for kexec@lists.infradead.org; Thu, 27 Jan 2011 03:34:00 +0000
Received: by wwb17 with SMTP id 17so1727325wwb.18
	for <kexec@lists.infradead.org>; Wed, 26 Jan 2011 19:33:57 -0800 (PST)
Date: Thu, 27 Jan 2011 05:33:47 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk
	upon panic
Message-ID: <20110127033347.GA12477@laptop>
References: <20110125134748.GA10051@laptop>
	<AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
	<20110126124954.GC24527@laptop> <20110127021338.GA20334@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110127021338.GA20334@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Willy Tarreau <wtarreau@hera.kernel.org>, Dirk Hohndel <hohndel@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, FBDEV-ML <linux-fbdev@vger.kernel.org>, IDE-ML <linux-ide@vger.kernel.org>, Randy Dunlap <rdunlap@xenotime.net>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, X86-ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jgarzik@pobox.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dirk.Hohndel@intel.com, Borislav Petkov <bp@alien8.de>, Dave Jones <davej@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Lord <kernel@teksavvy.com>, Arjan van de Ven <arjan@infradead.org>, Tony Luck <tony.luck@intel.com>, KEXEC-ML <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>


(Very timely! was just exploring kexec-tools and friends)

On Wed, Jan 26, 2011 at 09:13:38PM -0500, Vivek Goyal wrote:
> On Wed, Jan 26, 2011 at 02:49:54PM +0200, Ahmed S. Darwish wrote:
> > 
> >   If not, can kexec be modified to do so? That possibly needs the help
> >   of a a bootloader extension.
> 
> - Generally kdump uses same kernel as first one. So if first kernel panics
>   then kdump kernel will also panic. Though one can keep a known good kdump
>   kernel.
> 

I was thinking of a 'special' kdump kernel: the older kernel will just pass
the physical RAM address of its ring buffer to the newer kernel. The newer
kernel will be __so specialized__ that it will just:

 - display the log in a friendly manner
 - write it to the swap partition
 - .. and halt

This way, I completely toss the BIOS while accomplishing similar goals.

>
> - Currently kexec-tools take care of loading the kdump kernel, and then
>   preparing memory map for second kernel and pass to it and also pass
>   along some information about vmcore in ELF headers to second kernel. 
>
> There is so much to it that I really don't think that modifying bootloaders to
> do all that might not trivial and more importantly I think it probably is not
> worth the effort.
> 

IMHO if done in a user-friendly and stable manner, it can really be worth
the effort. But quite honestly, since I did not read all the setup work
done by kexec-tools yet, I might be too optimistic.

> Thanks
> Vivek

thanks,

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

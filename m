Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Ok3nA-0004vT-MR
	for kexec@lists.infradead.org; Fri, 13 Aug 2010 23:36:07 +0000
Received: by gyf2 with SMTP id 2so1392464gyf.36
	for <kexec@lists.infradead.org>; Fri, 13 Aug 2010 16:36:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C65D263.6050904@zytor.com>
References: <F0CB3B1C601247indou.takao@jp.fujitsu.com>
	<4C65C630.4070008@zytor.com>
	<987664A83D2D224EAE907B061CE93D53015B2DAD87@orsmsx505.amr.corp.intel.com>
	<m1r5i2kt0n.fsf@fess.ebiederm.org> <4C65D263.6050904@zytor.com>
Date: Fri, 13 Aug 2010 16:36:03 -0700
Message-ID: <AANLkTim8U87uZ73BcFc42O6EFWuNkA5UjhhiNeVLtAWT@mail.gmail.com>
Subject: Re: [PATCH][EFI] Run EFI in physical mode
From: Tony Luck <tony.luck@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On Fri, Aug 13, 2010 at 4:16 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> I guess my real question was "is this something IA64 could benefit from
> and/or could we make the IA64 code more similar to the x86 bits"?

If Eric's recollection about the "weird floating point fixup routines"[1]
performance issues are correct - then ia64 won't want to do this.

-Tony

[1] more usually called FPSWA - floating point software assist - which
handle a bunch or corner cases in denormalized floating point values
that the h/w doesn't cover.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

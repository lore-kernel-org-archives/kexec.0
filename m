Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A014E7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uroNpEhEts/6M5DBrlEuNaeWTD8hLrh6FtXzy3QcsF0=; b=JBiWnwgcbtr1WcgVvCKTNYPyfx
	UKNtSM1IKt9JMb0cNpL8PBN/grUjv4wRKNa9DvD1CIFaggGmTpoFnRRxy3gMR/+vzgsmmbOGvNqRP
	6XxdUsTynuNBB5oYoyPPr41PikjmyeM5G8uct7lc9y/se/gzc+GmyAiM6VIRPQ5hXvcL94myBdjoG
	Fp5UHyRUFhRx75UhppjT+n9pSGGy+qoG1DynqgccuMjvRmU+yNmyvZgLFmH4INfz8VXw3Ov5xcrLK
	Nki5qcMgcIfJTCSx7I5UKyhRWoFBygATsEHMjg5zapnEcePdYJmfIvoRPTuyDxzHJvPGvgZr6wzZU
	N3EJ/YOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tMC6q-00000004xXi-2HuI;
	Fri, 13 Dec 2024 20:18:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tMC6p-00000004xXW-0Ufw
	for kexec@bombadil.infradead.org;
	Fri, 13 Dec 2024 20:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uroNpEhEts/6M5DBrlEuNaeWTD8hLrh6FtXzy3QcsF0=; b=G2bEc0wtXBCjs0jgA2xi0sRRUI
	u9mJYD4H/LB70lK2oGgJ6+0c5e8YUuXaBI6rfQHnnuoWBSTx0nhUC1qPJtIm8KJZtxUuu9rnGussa
	eHAPvL8XbK4e9vVN2rnFX1WvRNUNnVfk28nyLGFxFNOIpkCxwPM2JmTvp473KeyJ+Y5bS827v5WL1
	2OV/jTsT620V4jJkc00BZ0Moakrrjt8TroTGHJLjuGr9+Z11yl57WIV9Dftyh/SVzaurwPrLtiQ7d
	puufkUIdHJMlrm/XGbtzhsb98gRX4Wfy7PGkege3TI+3uxCTVkNG2Oz1hw/RR4aSm9+Pd5XxqCOcU
	lN5Qj0pA==;
Received: from [172.31.31.140] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tMC6m-00000004KsB-3G15;
	Fri, 13 Dec 2024 20:17:57 +0000
Date: Fri, 13 Dec 2024 20:16:51 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Ming Lei <ming.lei@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
 hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>,
 kexec <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>,
 Paolo Bonzini <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Jens Axboe <axboe@kernel.dk>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
References: <87ldwl9g93.ffs@tglx> <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org> <87a5d0aibc.ffs@tglx> <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org> <874j38a16p.ffs@tglx> <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org> <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org> <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx> <Z1wfF6NJRZh1jROz@fedora> <87pllv90ow.ffs@tglx> <1a7c126f3ab8ae75e755d01a6bf9bc06730dd239.camel@infradead.org> <87msgz8qes.ffs@tglx> <CAJZ5v0i3zg1ee9p7vc0xEN4cEyCoO-d9OOyV_m65=f251tnxXQ@mail.gmail.com> <CAJZ5v0hBUgOB4QhhwjusRcP+jksWFL-upR5En58g9RD5+n70JA@mail.gmail.com>
Message-ID: <73E84E2B-001B-48D6-9BB4-B104D43F8FBF@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 13 December 2024 19:06:52 GMT, "Rafael J=2E Wysocki" <rafael@kernel=2Eor=
g> wrote:
>On Fri, Dec 13, 2024 at 6:32=E2=80=AFPM Rafael J=2E Wysocki <rafael@kerne=
l=2Eorg> wrote:
>>
>> On Fri, Dec 13, 2024 at 6:05=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x=2Ede> wrote:
>> >
>> > On Fri, Dec 13 2024 at 14:07, David Woodhouse wrote:
>> > > On Fri, 2024-12-13 at 14:23 +0100, Thomas Gleixner wrote:
>> > >> That's only true for the case where the new kernel takes over=2E
>> > >>
>> > >> In the case KEXEC_JUMP=3Dn and kexec_image->preserve_context =3D=
=3D true, then
>> > >> it is supposed to align with suspend/resume and if you look at the=
 code
>> > >> then it actually mimics suspend/resume in the most dilettanteish w=
ay=2E
>> > >
>> > > Did you mean KEXEC_JUMP=3Dy there?
>> >
>> > Yes, of course=2E
>> >
>> > > I spent a while the other week trying to understand the case where
>> > > CONFIG_KEXEC_JUMP=3Dn and kexec_image->preserve_context=3Dtrue, and=
 came to
>> > > the conclusion that it was a mirage=2E Userspace can't *actually* s=
et the
>> > > KEXEC_PRESERVE_CONTEXT bit when setting up the image, if KEXEC_JUMP=
=3Dn=2E
>> > >
>> > > The whole of the code path for that case is dead code=2E It's confu=
sing
>> > > because as discussed elsewhere, we don't just #ifdef out the whole =
of
>> > > that dead code path, but only the bits which don't actually *compil=
e*
>> > > (like references to restore_processor_state() etc=2E)=2E
>> >
>> > Yes, I had to stare at it quite a while=2E :)
>> >
>> > >> It's a patently bad idea to clobber the kernel with kexec jump "fi=
xes"
>> > >> instead of using the well tested and established suspend/resume
>> > >> machinery=2E
>> > >>
>> > >> All it takes is to:
>> > >>
>> > >>     1) disable the wakeup logic
>> > >>
>> > >>     2) provide a mechanism to invoke machine_kexec() instead of th=
e
>> > >>        actual suspend mechanism=2E
>> > >>
>> > >> No?
>> > >
>> > > Agreed=2E The hacky proof of concept I posted earlier invoking
>> > > machine_kexec() instead of suspend_ops->enter() works fine=2E I'll =
look
>> > > at cleaning it up and making it not invoke all the ACPI hooks for
>> > > *actual* suspend to RAM, etc=2E
>> >
>> > Something like the below? It survived an hour of loop testing=2E
>>
>> I think that this KEXEC_JUMP thing can be dropped entirely and forgotte=
n=2E
>>
>> I'm not aware of anyone actually using it=2E
>
>And now I've been made aware that it's used=2E  Oh well=2E
>
>As discussed with Dave over IRC, the current implementation isn't
>actually that bad=2E  It might use PMSG_THAW instead of PMSG_RESTORE in
>kernel_kexec(), but other than this it reflects the code flow around
>the jump from the restore kernel to the image one during resume from
>hibernation=2E
>
>This means that hibernation and kexec jump could be unified somewhat=2E

Fair enough=2E I'm happy to do whatever cleanups or consolidation make sen=
se, if we have a consensus=2E

There remains the question of why the blk-mq thing explodes on the way dow=
n for both kjump and, apparently, even the plain kexec case=2E


Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54367E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n2BAPcHxdGhy0vmxEJ/sjgGoKxVfP+fnZ9WQuC3FZvA=; b=K1hhjpHVy4XEG18G/j5XYcBO6b
	rIj1yLWGlUH5neualH6UGPBGlt7/eieZbXA21fkbc5jvH9ncpHMLYnFJ2hWW6xR/LGAGZOobhqEul
	hiRAumk5rJ0dCp9p3oQ7/I5IrqtguzkE/Ae/VmFhQR3yGtWEXQ6N3Po9sox9mSTO+J+qinWxqQW8G
	eRMWBNDGbnkxFe+5T62tHcW3IPjBJqCv88SZzl+bo+Lw+GKykEJkuLycgW/Fh3XC9CEcdTdaRnD54
	ZsYKuy+MvjBgAjKpoRSw/X5scr/epiBVjemAs9Z7hI838s9miXjdWGmNHBHg+qCQPPvzbukvXR02i
	44pusdWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM5dT-00000003p3h-3Cxy;
	Fri, 13 Dec 2024 13:23:15 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM5dR-00000003p2s-0Seq
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 13:23:14 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734096191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2BAPcHxdGhy0vmxEJ/sjgGoKxVfP+fnZ9WQuC3FZvA=;
	b=NvOjPfivC9xDA2DrB+2+7pnnSEcW0iw0pEsGQT1eWdf6kQvuxfkMRJ9Fofcbn5PXOxI57w
	KvVJf2mrpXTiDdehztwu3OplGW45CAHY0RfJTjRhM486A5j6RacfsDKnJ+p2IPQthpsQl+
	SIzx3zd2uUSaDPVlKRghJs25fbJq6n/059vAAljuWLOvCqkc+MCqe3hP0W8ds7lU04Q8IP
	NbixBKD/jzfyG8pOF0Fez9PXM0BfySnPXS82AhkNcahGauP5Zzp4pBKnwIcNDU4PH/BOEY
	lai0UbkyGIEv7nKREm8mK7RYcoNB/KVhgmqxVJDCv04xFQONZ6YibfUzJOqHiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734096191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2BAPcHxdGhy0vmxEJ/sjgGoKxVfP+fnZ9WQuC3FZvA=;
	b=cN1c9G+mWP0NNaOK1timD9IoG/manIkMNgEANGMAAaRoXJpsA05H5nfeWpq4Q2p2oVxZix
	Y6fbWzcukais7LBg==
To: Ming Lei <ming.lei@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, Petr Mladek <pmladek@suse.com>, John Ogness
 <jogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <Z1wfF6NJRZh1jROz@fedora>
References: <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <9c4b189656a0a773227a11568171903989130bb7.camel@infradead.org>
 <adf6981fcfd3b23d0a293404879598e8fcf072f6.camel@infradead.org>
 <871pybamoc.ffs@tglx> <Z1wV9SsaVe3torbO@fedora> <87y10j95v7.ffs@tglx>
 <Z1wfF6NJRZh1jROz@fedora>
Date: Fri, 13 Dec 2024 14:23:11 +0100
Message-ID: <87pllv90ow.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_052313_280254_6DFB72B4 
X-CRM114-Status: GOOD (  16.32  )
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

On Fri, Dec 13 2024 at 19:48, Ming Lei wrote:
> On Fri, Dec 13, 2024 at 12:31:24PM +0100, Thomas Gleixner wrote:
>> I'd rather say, that's a kexec problem. On the same instance a loop test
>> of suspend to ram with pm_test=core just works fine. That's equivalent
>> to the kexec scenario. It goes down to syscore_suspend() and skips the
>> actual suspend low level magic. It then resumes with syscore_resume()
>> and brings the machine back up.
>> 
>> That runs for 2 hours now, while the kexec muck dies within 2
>> minutes....
>> 
>> And if you look at the difference of these implementations, you might
>> notice that kexec just implemented some rudimentary version of the
>> actual suspend logic. Based on let's hope it works that way.
>> 
>> This is just insane and should be rewritten to actually reuse the suspend
>> mechanism, which is way better tested than this kexec jump muck.
>
> But kexec is supposed to align with reboot/shutdown, instead of suspend,
> and it is calling ->shutdown() for notifying driver & device.

That's only true for the case where the new kernel takes over.

In the case KEXEC_JUMP=n and kexec_image->preserve_context == true, then
it is supposed to align with suspend/resume and if you look at the code
then it actually mimics suspend/resume in the most dilettanteish way.

It's a patently bad idea to clobber the kernel with kexec jump "fixes"
instead of using the well tested and established suspend/resume
machinery.

All it takes is to:

    1) disable the wakeup logic

    2) provide a mechanism to invoke machine_kexec() instead of the
       actual suspend mechanism.

No?

Thanks

        tglx





Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771C1C433FE
	for <kexec@archiver.kernel.org>; Wed,  9 Nov 2022 21:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fmIKUfo/SVSQ+/KMoHuiOIhLGVsE1nril60p35FaDt0=; b=dmJ0rZrVLkhCMw
	NMUWURKYkGmIY/2bxkqAQStvwhlhg+CJT7skpmiBVXa8HiGfoGy7nY5AS9xZ8wQYaMIwoOjVpBHje
	9A2nYVoIR2IgZcNmb92RKQPLexXEaHVXQutTMbvIp1/ySGBtphK/FxnAl8HtxqfPNlBgEpD9BDdQ6
	Jt1V9Ba7ApRJ1KcmGMLIrcU7exGheBn4WnvgyTo0uLRxThatvYHealaqg7g2g7IkgnK533mQgE4Bu
	w+vaflh5Eyi3JrBQPbFGr2wjOV/vX1/h5FbVa7TqFIuH7Xg7I0xjDlqWHXax5nIL4rhfT3gXzPn+s
	/qOgg8uOZMLj8g1QPFFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ossfa-00HQzx-Av; Wed, 09 Nov 2022 21:31:38 +0000
Received: from mail.skyhub.de ([5.9.137.197])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ossfW-00HQu3-ED
	for kexec@lists.infradead.org; Wed, 09 Nov 2022 21:31:37 +0000
Received: from zn.tnic (p200300ea9733e7bc329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7bc:329c:23ff:fea6:a903])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 094B61EC063F;
	Wed,  9 Nov 2022 22:31:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1668029481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=ZVuAEP7EZJD1bSmxJ8gb2o1Y328HRP3H25tj29o45V8=;
	b=VhK+4kugpuZrqOzjcVJFEOya0RABF34TBESQEqw49x4MCk5qbzJJ6ucw6BjfZRhyR4tORv
	+FL/nQEEWAKdEmR/dKv48qF9AYwFzl4FDSlTjNKg0l210qAK07k8SvfsgiJUD9b5cJxGTR
	9Tgq13YrK2qJ2FjhI+ikBtQOxn+IB8c=
Date: Wed, 9 Nov 2022 22:31:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric DeVolder <eric.devolder@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org,
	ebiederm@xmission.com, dyoung@redhat.com, bhe@redhat.com,
	vgoyal@redhat.com, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	nramas@linux.microsoft.com, thomas.lendacky@amd.com,
	robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
	sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
	boris.ostrovsky@oracle.com
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Message-ID: <Y2wcJOehWcG7w5c4@zn.tnic>
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com>
 <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com>
 <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd820d8a-7ce9-c32f-fc84-bbf20dd7d6e5@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_133135_770868_BE7D70E2 
X-CRM114-Status: GOOD (  15.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, Nov 09, 2022 at 09:48:33AM -0600, Eric DeVolder wrote:
> ...
> which then defaults HOTPLUG_CPU to on and thus this code/ifdef in question.

defconfig can sometimes lag reality. In this case, the majority of
machines have SMP=y because the majority of machines out there are,
well, multicore.

> So at this point, I'm still not sure if you want the ifdef line:
>  - removed altogether
>  - transitioned to CRASH_HOTPLUG
>  - leave as is

So let's think out loud:

* the majority of machines will have CONFIG_HOTPLUG_CPU=y because
they're SMP machines and we want the elfcorehdr updates to happen when
CPUs get offlined or onlined.

CONFIG_MEMORY_HOTPLUG is most likely going to be =n on the majority of
machines out there.

(Note how the deciding factor for all this is what would make sense on
the prevailing majority of machines out there.)

And memory hotplug will be off for the simple reason that not so many
machines have memory hotplug hardware capability.

Which then means, IMHO, this functionality should be separate: have a
CPU hotplug callback and a memory hotplug callback.

And you kinda do that in

Subject: [PATCH v13 3/7] crash: add generic infrastructure for crash hotplug support

but then this all calls into a single handle_hotplug_event() and that
hp_action doesn't really matter.

It is used in the call to

  arch_crash_handle_hotplug_event(image, hp_action);

but that hp_action argument is unused in the x86 version.

IOW, you can do this callback regardless whether it is a CPU or memory
hotplug event.

So thinking about it, a single CONFIG_CRASH_HOTPLUG which unifies those
CPU and memory hotplug callback functionality makes most sense to me.
Because you don't really differentiate between the two in the callback
actions.

Anyway, this is how I see it from here. I could very well be missing an
aspect, of course.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0A7E7717F
	for <kexec@archiver.kernel.org>; Mon, 16 Dec 2024 18:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SjfNhuvGiolOyrjKsZTgRFX8OJYdur2afUKbQ/gvW4o=; b=hjYvu5Ab2x5b2uv4MDN5MGmPeC
	P79C4LV0aGieH2fTBA3Sx3qi1XospTgi6863ah/BzVl8e5t9bPE8GSiXuITsPXwcuRT1Nf/cxT6v7
	H3wuxedYWRez5ZWECCP4+AgdHQE8KnSADbaV+u7EfIoSZp4tmYyXcUkz+chu/MixZZoVW7Y/ilKWH
	c04gvCOzGGQUQwavoTlwzpV0B/L+vgAfmuySxOPVWoaH8MEOnZzizagYtM6pPI2mgRIU77Pk8guzS
	b5gC5leXfjJWDC7UZ1mb2xoNgbnMt61eNyL/iB+S9TJ4BQDLKSdpuWKgA5ya8nS2ZK5weA3hytysj
	9XqjHWFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFmM-0000000AxfM-22ih;
	Mon, 16 Dec 2024 18:25:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFbl-0000000AvUr-3kKP
	for kexec@bombadil.infradead.org;
	Mon, 16 Dec 2024 18:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=SjfNhuvGiolOyrjKsZTgRFX8OJYdur2afUKbQ/gvW4o=; b=drxG7okGe1i9XAqvE98rdkL0gK
	6VQceyOgk6MPOf4drANwU2q98fmfn1dEvTiTFWC4Q/Ou1nSK47fOv9uBDYQEMVq0lxa5khv8mq0kY
	S5Ba6HXcZMuv1w3OiUK1W+FWmj1dQ2bOSuUUkjCOe65fzrmAFQXNuutOD9kpE+RjLtudyDAyNmYeD
	iS0aLblPISiXb48W40Ht6LSGH0i9anIIPfEXsSbtvh7eFNN/7zQVIAm2OodCyuHC0cF5t7qeH+hhD
	b0TyLv5fCRtyslQ7DcOmQ5u+Hr6OlyWEvsZfEcUOfpWzMm/jIyTg04+DiyWEi+ud5zbSfV4HS6Wn4
	C+OeZxnw==;
Received: from [2a00:23ee:2908:bad:cd3a:995:e233:9fc1] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNFbk-00000004vCP-0VOE;
	Mon, 16 Dec 2024 18:14:16 +0000
Date: Mon, 16 Dec 2024 18:14:17 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>,
 Ming Lei <ming.lei@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: Does anyone actually use KEXEC_JUMP?
User-Agent: K-9 Mail for Android
In-Reply-To: <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
References: <4968818.GXAFRqVoOG@rjwysocki.net> <d29738023f117bbd4031579443e0c2f8f1f78592.camel@infradead.org> <87h673zkhr.fsf_-_@email.froward.int.ebiederm.org>
Message-ID: <E64227FF-E6A2-4E2C-85F3-EF1D9EFEC91F@infradead.org>
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

On 16 December 2024 16:00:00 GMT, "Eric W=2E Biederman" <ebiederm@xmission=
=2Ecom> wrote:
>David Woodhouse <dwmw2@infradead=2Eorg> writes:
>
>> On Mon, 2024-12-16 at 14:39 +0100, Rafael J=2E Wysocki wrote:
>>> From: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>>>=20
>>> The KEXEC_JUMP flow is analogous to hibernation flows occurring
>>> before
>>> and after creating an image and before and after jumping from the
>>> restore kernel to the image one, which is why it uses the same device
>>> callbacks as those hibernation flows=2E
>>>=20
>>> Add comments explaining that to the code in question and update an
>>> existing comment in it which appears a bit out of context=2E
>>>=20
>>> No functional changes=2E
>>>=20
>>> Signed-off-by: Rafael J=2E Wysocki <rafael=2Ej=2Ewysocki@intel=2Ecom>
>>
>> Thanks=2E I'll round that up into my kexec-debug tree, which Ingo has
>> been taking into tip/x86/boot=2E Once I'm done fighting with
>> objtool(qv)=2E
>
>I have no objection to getting kexec jump more in sync with the
>rest of the power management code=2E
>
>I do have a question though=2E  Does anyone actually use kexec jump?
>
>It is fine if folks do, but I haven't actually heard of anyone using
>it=2E  If folks aren't using it, it might make sense to just use the fact
>that it is broken as a nudge to remove that option=2E
>
>Eric
>
>
>

It isn't broken=2E I know of it being used a few million times a week=2E

There are corner cases which have never worked right, like the callee putt=
ing a different return address for its next invocation, on the stack *above=
* the address it 'ret's to=2E Which since the first kjump patch has been th=
e first word of the page *after* the swap page (and is now fixed in my tree=
)=2E But fundamentally it *does* work=2E

I only started messing with it because I was working on relocate_kernel() =
and needed to write a test case for it; the fact that I know of it being us=
ed in production is actually just a coincidence=2E


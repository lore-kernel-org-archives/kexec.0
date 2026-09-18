Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85DBC982DA
	for <kexec@archiver.kernel.org>; Fri, 18 Sep 2026 14:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYtYAfDJI8svYgT1CrIOHRyiBJYKlCKWW3kx3NqqXaA=; b=S7i5kygy80zL7ojd6UVSZsElS3
	2kK16MUX8/fWx3XUVeTMLvEU0RAthVjegRkHD+4OYKwVkri637EMUe23oeX5gQbLPL+Jt76ATdWWC
	y/i7vdStIT9UlUagx30gyNALtSYflc8ViRBKQhxXkVDEdVQ91hlurv5a3fdtjhAdt5yPwHS9/PfYZ
	cXllENPs32GcWlYULV9t9y+QXz2UpFbDAiTB9XN8h0XVeG3BRyZh+uObk+7ZTMKpjXP+d5SEaMr7d
	yKzHjkpnNZjWRPVuRjdpip4xo8Cw8TDdY1EUV4JS7EuxmjDJl4kkvlRrR4NmydsBb7D2hJPgRhp5A
	2MoR0YCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ZVL-0000000Ei1G-25hT;
	Fri, 18 Sep 2026 14:23:57 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ZUd-0000000EhwX-3WtT
	for kexec@lists.infradead.org;
	Fri, 18 Sep 2026 14:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=pYtYAfDJI8svYgT1CrIOHRyiBJYKlCKWW3kx3NqqXaA=; b=EaeCuaRdcRqVmNl2UEMC6QisP0
	kg5w3HbqifVeXKkmWkqX/s3URonieftbiyE2PXXeRhhfc7HXBuk3ieziDcosLAl1GrXN3pT6ugQQq
	7Yd8nkvCaLko1T29eHPgIpQ0LBjrbe168rUfvyfmaNFS3b6QmCCyPi/4ili4OPD+j1n2Up6AkH9Pg
	+r98FiPmT98FQqtjOkmlYk626vUg+wOJmym5DE6qYjYmRFS7C9K2Iwfzo5JuE7qJQqZoWr5xZRTiC
	O/cDJYTRL4ZnoBCzihKo6i6OeOl2UssF1T8i6v5xx2DiVvS2vTEzVHpCNR3RhrQhUf8EIuy6MX4u7
	9nJTRW5A==;
Received: from [191.32.244.140] (helo=[192.168.1.56])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7ZTG-003yti-Ta; Fri, 18 Sep 2026 16:21:46 +0200
Message-ID: <bc0bdd14-5e6a-0676-cd04-14fb0bb93cd5@igalia.com>
Date: Fri, 18 Sep 2026 11:21:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] x86/vmware: Run panic diagnostics before kdump by
 default
Content-Language: en-US
To: Zack Rusin <zack.rusin@broadcom.com>, Petr Mladek <pmladek@suse.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org,
 Joel Granados <joel.granados@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, virtualization@lists.linux.dev,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>, Dave Young <ruirui.yang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>, Bo Gan <bo.gan@broadcom.com>,
 Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 Stephen Brennan <stephen.s.brennan@oracle.com>
References: <cover.1788414671.git.zack.rusin@broadcom.com>
 <7487011dfb95aadda9515b22a5852680df1982c5.1788414671.git.zack.rusin@broadcom.com>
 <aquttpMVKX8e6zGB@pathway.suse.cz>
 <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CABQX2QPJVg-dZB9f4ydRU_5W7nyWwVCQtDoRGoe1+9cA7wyUDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_072331_303384_A7858173 
X-CRM114-Status: GOOD (  21.20  )
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

Hi Petr, Zack - thanks for CCing me!
Some comments below:


On 18/09/2026 00:23, Zack Rusin wrote:
>> [...]
>> Maybe, we should start with something simple, and introduce
>> one more panic notifier as a start. It might be called either:
>>
>>   + "panic_hypervisor_list" because "crash_kexec_post_notifiers = true"
>>     seems to be primary set on hypervisors.
>>
>> But I would rather make it more generic and call it
>>
>>   + panic_pre_crash_kexec or panic_pre_kdump because there might be
>>     more notifiers which are either 100% safe and useful or are worth
>>     the risk before calling crash dump.
>>
>> We could put there x86/vmware notifiers as a start. And we could later
>> move there other important notifiers.
>>
>> How does that sound, please?
> 

It's a good idea, IMO. We could start with this, Zach commented some
implementation details below...and after it gets merged, we could move
other hypervisors that currently set "crash_kexec_post_notifiers" to
this list and eventually, unexport this symbol. We should avoid having
code forcing this parameter, as Petr said, many notifiers are executed
if that is set.

(I'm CCing Stephen Brennan here, I recall he had problems with this
being auto-set, we talked about that in the panic notifiers big
discussions in the past heh)

The only thing I'd like to suggest: I think we should have a parameter
that disables running this list, which would be the opposite of
"crash_kexec_post_notifiers".

I would implement it as something like: "postpone_pre_kexec_notifiers"
or something like that. The parameter would basically "move" this list
execution to the same time as the current notifiers, gating them to
"crash_kexec_post_notifiers". This way, we'd allow users to debug kexec
failures maybe related to the "early" notifiers. WDYT?


> [...]
> I think that without that default though, x86 oops_end() can enter
> crash_kexec(regs) before reaching panic(), for example with
> panic_on_oops=1. To cover that path too, I'd call the chain from
> __crash_kexec() after the image check and register capture, under the
> existing kexec lock. A second call in vpanic(), immediately before
> kmsg_dump_desc(), would cover the fallback path. And I think a
> set-once guard would prevent duplicate or recursive dispatch.
> 

Regarding this, 2 things:

a) I think you could change kexec_should_crash() to "return 0" also in
case the new list is set to run, the same is done currently for
"crash_kexec_post_notifiers". Makes sense?

b) Well, does this whole panic diag thing you're implementing here aims
only at x86 guests ? Or would it be possible to run, for example, arm64
guests? Asking this because in x86 and some other architectures (but not
arm64[0]), it's possible to override machine_crash_shutdown() handler,
and run things prior to a kexec. Take a look on how Hyper-V does that on
arch/x86 - this could be just what you need, except if you plan to have
it for all architectures heh

Finally, if possible please keep me looped in the following patches, I'm
very interested on that =)
Cheers,


Guilherme


[0]
https://lore.kernel.org/r/427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com/


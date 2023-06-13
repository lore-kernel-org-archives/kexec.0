Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD965EB64D8
	for <kexec@archiver.kernel.org>; Tue, 13 Jun 2023 20:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eNWGueNli4GnT3v/vOIunJZsTkyICFfkklyqkbyZa5Y=; b=SV3e5CdgO67b65
	JatNZFB23fdMov6V9X9ocQAJ/YkjlJak+s7i1gM01cAinQq+gMYFv37XBROC4YWUDW8uTctZ3sq7a
	lVIxcx33QgwFtz4fyp91TR/5WiGsD71ou8bEOIDQKG0JSkm5u80rqZ4nBrII+He424WX3NvhE1/u2
	AgoIGbxmC3E4dYcHOBBaACTXt0Kf902lA76r3eo4SXfSz7WqQ32/JuI1h0RyWiG33nMh5uWyrMy2X
	dNmXPutD0NKGPcX+b4qdcOMnCjBh3/URZggRNly3oxl/4m9MuNN8mqub8VR7ULGuCmrzTEarOutvm
	9DSNO14sS5TkSb2vw0pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9AUY-0094sM-33;
	Tue, 13 Jun 2023 20:19:50 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9AUU-0094p7-14
	for kexec@lists.infradead.org;
	Tue, 13 Jun 2023 20:19:49 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1686687579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HE1N4P0d/WhniObXa5GtYC4fEZuwmn5LLuL6Wr0ZtK4=;
	b=Tf3UoS9LopV2MoDkt6mREw6JQ1H92mYf8JJR87y9KFj/g9Y6BCa1QsYyoSYpqQU8Kv513J
	pN4kb9E9e4kjmxzWqS2LDHP3scrieeSc067Bh5mzIcuZNGGRyI6Y3UbzyynDyXRmWCDwC/
	UTYLoIx7oveMp/6/NRRZXvvmsZPcCraBbhAPPeZy7w7QMifJcu7iOfGhCbl81K5+EANJqT
	B3IteW2VL5AvNnkNiS9WdZxIaX7WJQgq/vOtVU9GM3RuqBZKiYvYUssYiwiHsZHBZH5JOJ
	o32Xzk/Q71EPi97vaNCjxCLPhuCVLdS9Xhe8Y95dAsEYHGaFSiuPSqBA+HhiSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1686687579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HE1N4P0d/WhniObXa5GtYC4fEZuwmn5LLuL6Wr0ZtK4=;
	b=Xp05f34xzTJaqdiVBn9l6bLgZ93PE8JGwnfn3n5pwFY//ykipWNnG09cAq9lqdTQfkJHHL
	3z+xTe5HLaRIWgCA==
To: Eric DeVolder <eric.devolder@oracle.com>, Greg KH
 <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
 corbet@lwn.net, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
 ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
 rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
 lf32.dev@gmail.com, akpm@linux-foundation.org,
 naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com, bhelgaas@google.com,
 vbabka@suse.cz, tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
 vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
In-Reply-To: <40cacc6b-c3d1-c63b-e307-d95b2c53e399@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
 <2023061320-vindicate-usual-6643@gregkh>
 <13118eaa-6fae-7b45-9f3e-ab95e7d34729@oracle.com>
 <40cacc6b-c3d1-c63b-e307-d95b2c53e399@oracle.com>
Date: Tue, 13 Jun 2023 22:19:39 +0200
Message-ID: <87h6rb6rok.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_131946_536213_69F27DBD 
X-CRM114-Status: GOOD (  12.82  )
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

On Tue, Jun 13 2023 at 14:58, Eric DeVolder wrote:
> On 6/13/23 10:24, Eric DeVolder wrote:
>> On 6/13/23 03:03, Greg KH wrote:
>>> All of these #ifdefs should all be removed and instead use the
>>> is_visible() callback to determine if the attribute is shown or not,
>>> using the IS_ENABLED() test in the function.
>> 
>> ok, I'll correct this.
>
> I've been examining drivers/base/cacheinfo.c as a template for how to remove the
> #ifdefs and use the is_visible() callback for the drivers/base/cpu|memory.c files.
>
> I'm attempting to apply this technique to drivers/base/cpu.c. In this file, there
> are features that are compiled in/out based on the CONFIG settings, for example 
> CONFIG_ARCH_CPU_PROBE_RELEASE. My attempts at applying the technique thus far have
> resulted in link-time errors for missing symbols, ie. arch_cpu_probe() and
> arch_cpu_release().
>
> As I understand it, to use IS_ENABLED(XYZ) to guard-band conditional code, the contents
> of that code still needs to be compile-able (eg. no references to struct members with
> surrounding #ifdef CONFIG_XYZ) and link-able (eg. any called functions must also be
> compiled).

You can't obviously reference anything which is #ifdeffed out in a data
structure. But functions is a different story. All you needs is a
declaration.

void foo(void);

     if (IS_ENABLED(FOO))
     	foo();

Builds correctly if FOO=n and foo() is not built in. The wonders of dead
code elimination.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

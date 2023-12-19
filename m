Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B51EC41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 04:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HZig4o6FKcEj+Ywv/IMRE1vkaxThbcaw8OFh1NJ+zpE=; b=sVW5IqI1ij0Sbu
	r57ymRz2XEu0XzuVLNYXIaZH2WBDqn+bAwgFWhVPtHitELQ6H9XN9fVEHZJmXZkPi0aEcavsHW4KQ
	e7LJR9neNNbKjVfXLrBvS6fdhXXNKIBLXZvuWLIsDCvyp24P/m3hxWQ/rPtDSMRoZqG/TAJXVzLC4
	k3wuDfX1cMQdFyRKF6EYgQUBkMJUG7BlvsFPicry1FhUAvFuAbN35MD9vqzWx1xnKawRlo7mIUXt3
	kbG9IqospxC5j+UBgwBv/A6bOddwqZrMbGdc3PY+qb8bzQk/ESanN+HiPwjAm+wq0THIqgrRWJ4mO
	uLSyTwOgmaO1zh4aQ5jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRlg-00CngH-1b;
	Tue, 19 Dec 2023 04:31:44 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFRlc-00Cnf4-29
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 04:31:42 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-35d77fb7d94so21412785ab.0
        for <kexec@lists.infradead.org>; Mon, 18 Dec 2023 20:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702960298; x=1703565098; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KASV8ZY3q4Gm++WZlk7mbPwpsWDMSJh7Y1zsTXQhMQ4=;
        b=R8CwcaDcxh/OMegf8HPg/DTUpqy6ZNlfl+NKg+EviHkkp7M+D8XSH4h/FdAPibA9Qf
         aRL0Up8gpu2uOwe+fkNk58qEmc+2oVcJUEbJVhLiZyx0sDKUvzhpEcbV56ZW55fpsdRI
         EB73v9O/TXp8VxQFA8ur6SXAqGuxObEZIYSbB/W4Psz+8fMjJbUGG5R/PdW2ZtXAYcX5
         o7hrC5QtZ/7lGUJ32l6zXB+b9Eb4aM8sKclLaSIKh6gDolw3f73ru4oDUjVMhChwKNrQ
         KZ1k3SG8nZapmFceFtsePgabCG5iQF1M8L1N0Gh844p/fkW7W09oi2Y3vvAiqClg76Mj
         AZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960298; x=1703565098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KASV8ZY3q4Gm++WZlk7mbPwpsWDMSJh7Y1zsTXQhMQ4=;
        b=p+GijKa1itT4R1gWk844C60Tb8Ah3qHFE15Ef12XD1o27P7UWt835gsNUEgFHaL/d4
         KzY6RqZGQw6hKl0s4edWpnkb2ZYy3QrGqbsOLmT4X6UzkE2iyTY1Q6jhtqUw8Nwe3ml8
         7YErEzdhoKHymOGZbuEZodlDrB0I1fS50PNfFw83TBiIhPPUVpcR+1vzYs++/xcSrM7z
         m9zDEC8PB0AT/29qkXusQyKTiY0STdWXnCI2WKN26Hf/KB1TA8tYt1WpQ/AbVUgPzxit
         Yr81cF7d0Uzu7m2UJpO8XqjPkA9Z0eF8OysYklV5FlxsQGaRVw/sO2FYsMCR7djhtExa
         Rvrg==
X-Gm-Message-State: AOJu0Yym9wy8wl9YkP+16q9znImZ/IUUWzwLd6L/fZusfSGv6DY9nrNT
	h6bRECAhoc0/iWWhcI7jJx0=
X-Google-Smtp-Source: AGHT+IHBQGuQpaCjfbmEqKhvpwV4Dyb8OSyRzQXCS8TyuU0AA7gKbA3htBg3b+dop44dZKEl6aBpJA==
X-Received: by 2002:a05:6e02:1e09:b0:35f:a313:5555 with SMTP id g9-20020a056e021e0900b0035fa3135555mr8026312ila.64.1702960298277;
        Mon, 18 Dec 2023 20:31:38 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001d0c37a9ccdsm19949051plg.10.2023.12.18.20.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 20:31:38 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	dyoung@redhat.com,
	hbathini@linux.ibm.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	seanjc@google.com,
	tglx@linutronix.de,
	tiwai@suse.de,
	vgoyal@redhat.com,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: Re: [PATCH 2/2] crash_core: fix out-of-bounds access check in crash_exclude_mem_range()
Date: Tue, 19 Dec 2023 12:31:29 +0800
Message-ID: <20231219043129.38841-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZYEOshALGbDKwSdc@MiWiFi-R3L-srv>
References: <ZYEOshALGbDKwSdc@MiWiFi-R3L-srv>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_203140_700973_85AA1CC4 
X-CRM114-Status: GOOD (  46.80  )
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

On Tue, 19 Dec 2023 11:32:02 +0800, Baoquan He <bhe@redhat.com> wrote:
> Hi Yuntao,
> 
> On 12/19/23 at 10:02am, Yuntao Wang wrote:
> > On Mon, 18 Dec 2023 09:29:02 -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Mon, 18 Dec 2023 16:19:15 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:
> > > 
> > > > mem->nr_ranges represents the current number of elements stored in
> > > > the mem->ranges array, and mem->max_nr_ranges represents the maximum number
> > > > of elements that the mem->ranges array can hold. Therefore, the correct
> > > > array out-of-bounds check should be mem->nr_ranges >= mem->max_nr_ranges.
> > > > 
> > > 
> > > This does not apply after your own "crash_core: fix and simplify the
> > > logic of crash_exclude_mem_range()".  What should be done?
> > 
> > Hi Andrew,
> > 
> > I actually prefer the "crash_core: fix and simplify the logic of
> > crash_exclude_mem_range()" patch as it makes the final code more concise and
> > clear, and less prone to errors.
> > 
> > The current code is too strange, I guess no one can understand why there is
> > a break in the for loop when they read this code for the first time.
> > 
> > Moreover, I think the current code is too fragile, it relies on callers using
> > this function correctly to ensure its correctness, rather than being able to
> > guarantee the correctness on its own. I even feel that this function is very
> > likely to have bugs again as the code evolves.
> > 
> > However, Baoquan also has his own considerations, he suggests keeping the code
> > as it is.
> > 
> > The link below is our detailed discussion on this issue:
> 
> There's misunderstanding here.
> 
> Firstly I said I have concern about the patch, I didn't NACK or reject the patch.
> 
> [PATCH 3/3] crash_core: fix and simplify the logic of crash_exclude_mem_range()
> 
> Usually, when people said he/she had concern, you may need to
> investigate and resolve it or explain why it's not need be cared about.
> 
> E.g on above [PATCH 3/3], we can add below code change to stop scanning
> when the left ranges are all above the excluded range, assume the passed
> in cmem has a ascending order of ranges. Say so because I checked code
> and found that crash_exclude_mem_range() is called in arch arm64, ppc,
> riscv and x86. Among them, arm64 and ppc create the cmem from memblock,
> riscv and x86 create cmem from iomem. All of them should be in ascending
> ordr. The below code change based on your patch 3/3 looks safe to me.
> What do you think?
> 
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index aab342c2a5ee..39b6c149dc80 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -574,9 +574,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (p_start > end || p_end < start)
> +		if (p_start > end)
>  			continue;
>  
> +		if (p_end < start)
> +			break;
> +
>  		/* Truncate any area outside of range */
>  		if (p_start < start)
>  			p_start = start;
> 
> Secondly, I welcome people who are interested kexec/kdump code, and raise
> issues or post patches to fix bug, clean up code. I like these patches.
> They can help improve kexec/kdump code and solve problem in advance.
> I would like to review and make the patches acceptable and merged
> inally. And I also hope people can follow the later issue reported by
> other people or LKP if their merged patch caused that.
> 
> Lastly, people are encouraged to help review other people's patch
> and give suggestes to improve the code change. If patch author don't
> respond for a long while or the work has been suspended for long time, we
> can add comment to tell and take over the work to continue.
> 
> These are my personal understanding and thought about kexec/kdump patch
> reviewing and maintance. So cheer up.
> 
> > 
> > https://lore.kernel.org/lkml/20231214163842.129139-3-ytcoode@gmail.com/t/#mfd78a97e16251bcb190b0957a0b6cb4b0a096b54
> > 
> > The final decision on whether to apply that patch is up to you and Baoquan, if
> > you choose to apply that patch, this patch can be ignored. But if you decide not
> > to apply that patch, then this patch must be applied, as it fixes a bug in the
> > crash_exclude_mem_range() function.
> > 
> > Sincerely,
> > Yuntao

Hi Baoquan,

I must clarify that I was not complaining about you. On the contrary, I am
grateful to everyone who takes time to review code for others, because I know
it is a lot of work.

I'm relatively new to the Linux community and still learning the various rules
of the community. I'm very sorry that I didn't fully grasp your previous intention.

Regarding the method you suggested to add a 'break', I did consider it initially
but later decided against it because the memory ranges obtained from iomem may
overlap, so I chose a safer way instead.

Finally, I would like to apologize again if my previous response offended you.
That was not my intention.

Sincerely,
Yuntao

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

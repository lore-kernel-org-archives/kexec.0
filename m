Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC83E7717F
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oIvx1QOmnoMjv+UcZ5OW36K4SsjomKKCLj0cIrmikGw=; b=quepOQeIhWsDHVAuKs4oruLjD3
	DtY8bh5VRZi2rodMyNfxaXOEKGm5yMtiuVG9dGYqr6HH/h6+WkiYhgpnNt0oR2EO2qiCEYXB03ttT
	AW0gbX0nSqAu5JyUqSqEPmvmLOiqL24F/Hss8fVxnDnBM+Frns5GLESaOoaMg+gSfnzgWW0u0XQ5e
	5dPzBJ7Ewva7zva+bS7qcHPasdhpfZ6mi7berj6k5+8Ulcf/IhyiUxMdtBal/q6d2LQFU/8Jj8f6e
	P7m2f6BlHOprwO7b4eDq5i7qRw+xy1zjuPLSgIKgXliGYhXJd/E6pqJCwdH3Bmb4hjbjAZ12sPL9n
	l1acvmWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM5UD-00000003noV-1785;
	Fri, 13 Dec 2024 13:13:41 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM5UA-00000003nmh-0KHF
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 13:13:39 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734095616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIvx1QOmnoMjv+UcZ5OW36K4SsjomKKCLj0cIrmikGw=;
	b=1PT8OqZP4YlYwzKN/9RwGZtgfH8YkO/Yfeu8wJPzgbOQMOf5P59wFBbtNVmF0J7XJbkr+5
	QnBolz+g+WURuyPH3hgDypXOYVKMY2e0PxLTiKz2EL0MBeNWqn/gP9jtFhwQJpWoUrS/F5
	6GMDJClGh+mwLBDzHQ6PBQnyfKnjnkVYTiKgZnJIIjGc3GmBOHdfYQjVnhXaA2AblHqPbK
	9zZbiFNW6LHQee7WRfdUbWTpxv/DWSHbyv9EX8S+q7c0/rY5WA1y30tGFFBaLNg5qEAvXu
	YbEAvGNJf5KgHq+8InbMWfFnqoH9D/67YyKNgZqMlCRHTssk4nsAub3lbC8sug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734095616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oIvx1QOmnoMjv+UcZ5OW36K4SsjomKKCLj0cIrmikGw=;
	b=Fz9B86tyD74Nta+QP4pC570ZJoZV5oa40phqYQC0eog9H2qWxA9VTZrbfFUenXoYb86oiV
	ED/q3tX5yJt6vRCw==
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Stefan Hajnoczi
 <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, "x86@kernel.org"
 <x86@kernel.org>, hpa <hpa@zytor.com>, dyoung <dyoung@redhat.com>, kexec
 <kexec@lists.infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, eperezma <eperezma@redhat.com>, Paolo Bonzini
 <bonzini@redhat.com>, ming.lei@redhat.com, Petr Mladek <pmladek@suse.com>,
 John Ogness <jogness@linutronix.de>
Subject: Re: Lockdep warnings on kexec (virtio_blk, hrtimers)
In-Reply-To: <20241213112028.GE21636@noisy.programming.kicks-ass.net>
References: <1f631458c180c975c238d4d33d333f9fa9a4d2a3.camel@infradead.org>
 <CACGkMEtOdYorGPdSjxC1Lb1LJtZ+ZqHam3agHJ6JdpS-tE1qAQ@mail.gmail.com>
 <20241211124240.GA310916@fedora>
 <7717fe2ac0ce5f0a2c43fdab8b11f4483d54a2a4.camel@infradead.org>
 <87ldwl9g93.ffs@tglx>
 <10f5d22150b548ec271e0a847ba2eb91139e6f61.camel@infradead.org>
 <87a5d0aibc.ffs@tglx>
 <dd06cd643ee7fa0be08ac3082cff443b8bfbfb58.camel@infradead.org>
 <874j38a16p.ffs@tglx>
 <20241213112028.GE21636@noisy.programming.kicks-ass.net>
Date: Fri, 13 Dec 2024 14:13:36 +0100
Message-ID: <87seqr914v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_051338_251606_554E9845 
X-CRM114-Status: GOOD (  11.34  )
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

On Fri, Dec 13 2024 at 12:20, Peter Zijlstra wrote:
> On Fri, Dec 13, 2024 at 01:14:54AM +0100, Thomas Gleixner wrote:
>
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -7276,7 +7276,7 @@ void rt_mutex_setprio(struct task_struct
>>  #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
>>  int __sched __cond_resched(void)
>>  {
>> -	if (should_resched(0)) {
>> +	if (should_resched(0) && system_state != SYSTEM_SUSPEND) {
>>  		preempt_schedule_common();
>>  		return 1;
>>  	}
>
> Perhaps we should just do:
>
> 	if (should_resched(0) && !irqs_disabled())
>
> That's more or less what preemptible() does too. Yes, mucking about with
> IF is expensive, but it's only done if preempt_count is agreeing we
> should schedule, which it shouldn't be most of the time.

Makes sense. Let me write a real patch.

Thanks,

        tglx



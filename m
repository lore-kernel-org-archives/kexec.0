Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99172C48BF6
	for <kexec@archiver.kernel.org>; Fri, 16 Feb 2024 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RtBm9ohueMh/us+Q2XjJDvg/2nqpRttEB85s/S9xljA=; b=IcuZlEwBdM7SNY
	gqbQMcfgKTgH0SMUTIK5BaDR4HfnctiE2jB7nuuYYykAbsmwEdE5JclqHHWLk+VvrRJgaWn7WMMCW
	QnPi5v4La2twKOI9jgWXhU8vJJX3MqvGNh/UbFfqKPVRp3T8SgcBrNpGjkjU27lLTkXsIYTHcY20V
	dzG7LUb+IlpTJchllTZC6lKkFqNoIyoggpMN/soQyRx1Xyr1cmQba8HMbiqoUeqddA4RHkjFFxFEe
	lxYkpxflinbbpcVqBiqJ0iUqcSLWKWlXWWtqYJxGsR4lxZUZwVB4BYREK6GjtjAbbllwh6/7MVEJi
	AYQKzNQJJmiT+m9dx8bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0GS-00000002qR5-0AeO;
	Fri, 16 Feb 2024 15:36:36 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb0GO-00000002qOg-0b0I;
	Fri, 16 Feb 2024 15:36:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1708097792; x=1739633792;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zYEPhdOGwxfalucYYKXEQXA0b+MOVSC9pumogm3wVhQ=;
  b=qAGkAVYzcioAI652QF525eeSXOxMsfKFYGYJnV79lOCImsH6hTj6Quz5
   NtRSwCfMqEZGL5MB1xXERb0WalULBzQkVq25w+NBoEXEcyWUPN3jYR7iD
   PwkJUUfNhjXvjOM98fINc3XFod2OT804YFfvJTT2cjJFrHLpenshz3JF1
   E=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="66561533"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 15:36:27 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:36608]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.0.197:2525] with esmtp (Farcaster)
 id 14bd3545-92ef-44f2-844a-9c8f63002956; Fri, 16 Feb 2024 15:36:26 +0000 (UTC)
X-Farcaster-Flow-ID: 14bd3545-92ef-44f2-844a-9c8f63002956
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:36:06 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 15:36:06 +0000
Received: from dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (10.15.11.255)
 by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 15:36:06 +0000
Received: by dev-dsk-ptyadav-1c-37607b33.eu-west-1.amazon.com (Postfix, from userid 23027615)
	id 0583720CE8; Fri, 16 Feb 2024 16:36:06 +0100 (CET)
From: Pratyush Yadav <ptyadav@amazon.de>
To: Alexander Graf <graf@amazon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Rob Herring <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>
Subject: Re: [PATCH v3 11/17] tracing: Introduce kho serialization
In-Reply-To: <20240117144704.602-12-graf@amazon.com> (Alexander Graf's message
	of "Wed, 17 Jan 2024 14:46:58 +0000")
References: <20240117144704.602-1-graf@amazon.com>
	<20240117144704.602-12-graf@amazon.com>
Date: Fri, 16 Feb 2024 16:36:05 +0100
Message-ID: <mafs0sf1s8lqy.fsf@amazon.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_073632_634803_86397981 
X-CRM114-Status: GOOD (  26.86  )
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

Hi,

On Wed, Jan 17 2024, Alexander Graf wrote:

> We want to be able to transfer ftrace state from one kernel to the next.
> To start off with, let's establish all the boiler plate to get a write
> hook when KHO wants to serialize and fill out basic data.
>
> Follow-up patches will fill in serialization of ring buffers and events.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
> v1 -> v2:
>
>   - Remove ifdefs
> ---
>  kernel/trace/trace.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a0defe156b57..9a0d96975c9c 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -32,6 +32,7 @@
>  #include <linux/percpu.h>
>  #include <linux/splice.h>
>  #include <linux/kdebug.h>
> +#include <linux/kexec.h>
>  #include <linux/string.h>
>  #include <linux/mount.h>
>  #include <linux/rwsem.h>
> @@ -866,6 +867,8 @@ static struct tracer		*trace_types __read_mostly;
>   */
>  DEFINE_MUTEX(trace_types_lock);
>
> +static bool trace_in_kho;
> +
>  /*
>   * serialize the access of the ring buffer
>   *
> @@ -10574,12 +10577,56 @@ void __init early_trace_init(void)
>  	init_events();
>  }
>
> +static int trace_kho_notifier(struct notifier_block *self,
> +			      unsigned long cmd,
> +			      void *v)
> +{
> +	const char compatible[] = "ftrace-v1";
> +	void *fdt = v;
> +	int err = 0;
> +
> +	switch (cmd) {
> +	case KEXEC_KHO_ABORT:
> +		if (trace_in_kho)
> +			mutex_unlock(&trace_types_lock);
> +		trace_in_kho = false;
> +		return NOTIFY_DONE;
> +	case KEXEC_KHO_DUMP:
> +		/* Handled below */
> +		break;
> +	default:
> +		return NOTIFY_BAD;
> +	}
> +
> +	if (unlikely(tracing_disabled))
> +		return NOTIFY_DONE;
> +
> +	err |= fdt_begin_node(fdt, "ftrace");
> +	err |= fdt_property(fdt, "compatible", compatible, sizeof(compatible));
> +	err |= fdt_end_node(fdt);
> +
> +	if (!err) {
> +		/* Hold all future allocations */
> +		mutex_lock(&trace_types_lock);

Say I do "echo 1 | tee /sys/kernel/kho/active". Then the lock is held by
tee, which exits. Then I later I do "echo 0 | tee
/sys/kernel/kho/active". This time another tee task unlocks the lock. So
it is not being unlocked by the same task that locked it. The comment
above mutex_lock() definition says:

    The mutex must later on be released by the same task that acquired
    it. Recursive locking is not allowed. The task may not exit without
    first unlocking the mutex.

I tested your code and it happens to work because the unlock always
happened to take the fast path which does not sanity-check the owner.
Still, this is not the correct thing to do.

> +		trace_in_kho = true;
> +	}
> +
> +	return err ? NOTIFY_BAD : NOTIFY_DONE;
> +}
> +
> +static struct notifier_block trace_kho_nb = {
> +	.notifier_call = trace_kho_notifier,
> +};
> +
>  void __init trace_init(void)
>  {
>  	trace_event_init();
>
>  	if (boot_instance_index)
>  		enable_instances();
> +
> +	if (IS_ENABLED(CONFIG_FTRACE_KHO))
> +		register_kho_notifier(&trace_kho_nb);
>  }
>
>  __init static void clear_boot_tracer(void)

--
Regards,
Pratyush Yadav



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033CCEE49BC
	for <kexec@archiver.kernel.org>; Wed, 11 Sep 2024 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T5L55J52FYhx3rjcL+Km43SiMbu4+R8Qf9+CT0ww+ps=; b=LtO0UP7Tnk2eqU
	roHce7kQXz7WgthLzOPNZTJsNT76zUGh++SUPE92IgSbJbdZznrU519XP00Yrd4GFHZqOtzymt2ta
	c3mpWEeix0r/v6Ov/dZQZ4jZ4RlYRmsitQ2VjuDw7FMCChvWpMGyGoeE/ertZ7XwFt7GaFcQJ2XnL
	2n3elZ0xFuQoaVw7RtL3YHPU/kul772GxBjrNuADN/VMxhFU/OwuWc7SqrGVIaK/y5ZLndihy2vmT
	rHX1tBnu1x4K+6ot1HrApExLiv336NP7jbkclUViJe0+j630NEmwZEpwdL7OVOu2ogTZoUgN/z5fs
	p8Gm7sNDpRYUb8MWDY7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soPAd-0000000A7sK-1aeE;
	Wed, 11 Sep 2024 15:22:15 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soOyJ-0000000A5CV-0nKH
	for kexec@lists.infradead.org;
	Wed, 11 Sep 2024 15:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=StjhS8B78DcDy6BGi67+Cz5YOv6C9jIwH3H6WigF/WM=; b=r+UhIyBWzMNTcNYxUJSUllsIDu
	bu2ZKt5cxVuYjqUkhKZKxQ3tFhHQQ8UFlpvwKu31tci73Zl6s8gQYkX+Bt9kqCGfsG8Bou9iJKm3J
	iT8mrpkRdPgL0hXNAI11wDl+Q2Y+WDt9wfTTB+70Wf3WfhOTX5TZjxMc3NFqqFSQCkWRzWlEgo4WL
	NKo6QFhEvNJJzk/KAmqtNJE94OqnR9N5dN4ui+dZ8O0rMEf6lmNxMbhJsZrIzpGcYHtaJQWYW6wOK
	zNUdsbzl6vJ/n+Qx48V0sQMPsyLlg0brzgAiSi1+RKrLlOBjd/s7VELVgnsKekMzJni/4Sn1Zq4Zo
	9tS8nxvg==;
Received: from [195.69.0.8] (helo=[172.21.208.109])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1soOy6-00CUTT-Gv; Wed, 11 Sep 2024 17:09:18 +0200
Message-ID: <d954da78-87cf-d7d9-a620-0c2fae5dd242@igalia.com>
Date: Wed, 11 Sep 2024 17:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-debuggers@vger.kernel.org, stephen.s.brennan@oracle.com,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240830182219.485065-1-gpiccoli@igalia.com>
 <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <ZtUrX4n+HPYhyQ9z@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_080931_266346_AFE4B02E 
X-CRM114-Status: GOOD (  17.06  )
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

On 02/09/2024 05:05, Baoquan He wrote:
> On 08/30/24 at 03:21pm, Guilherme G. Piccoli wrote:
>> Be more clear about the downsides, the upsides (yes, there are some!)
>> and about code that unconditionally sets that.
>>
>> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> ---
>>
>> V2: Some wording improvements from Stephen, thanks!
>> Also added his review tag.
>>
>> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
>>
>>
>>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index efc52ddc6864..351730108c58 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -913,12 +913,16 @@
>>  			the parameter has no effect.
>>  
>>  	crash_kexec_post_notifiers
>> -			Run kdump after running panic-notifiers and dumping
>> -			kmsg. This only for the users who doubt kdump always
>> -			succeeds in any situation.
>> -			Note that this also increases risks of kdump failure,
>> -			because some panic notifiers can make the crashed
>> -			kernel more unstable.
>> +			Only jump to kdump kernel after running the panic
>> +			notifiers and dumping kmsg. This option increases the
>> +			risks of a kdump failure, since some panic notifiers
>> +			can make the crashed kernel more unstable. In the
>> +			configurations where kdump may not be reliable,
>> +			running the panic notifiers can allow collecting more
>> +			data on dmesg, like stack traces from other CPUS or
>> +			extra data dumped by panic_print. Notice that some
>> +			code enables this option unconditionally, like
>> +			Hyper-V, PowerPC (fadump) and AMD SEV.
>                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> I know Hyper-V enable panic-notifiers by default, but don't remember how
> PowerPC and AMD SEC behave in this aspect. While at it, can you add a
> little more words to state them in log so that people can learn it?
> Thanks.
> 
Hi Baoquan, tnx for the suggestion! You mean mention that in the commit
message? If so, I can certainly do - will sent a new version soon(tm)
and include it =)

Cheers,


Guilherme


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C7CAC5A7
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zudI2xzc/K+ymH1yslZ7PgitSRlwY3erZSroIuIlDFs=; b=mguIzYGyuCtIR+rceG71QplbU4
	xH5aJpC4NPP1ICpB8j1fYovA4oVsgSQHiVEGe8gA38DdoAyRDIR3nQ1kIV+iSTtvTcM3BgtRzQTxY
	EEAmVj9CrdBtkpHkXVPuNTqGBDyzyFZS2TR8JI53k9xtZth9knCmqGSc+fPrfkb3zoSr7nLswRTmE
	MsaWZpW5Xc7vS37qUZYoNhxx8XIhx3CNNesMgT5o4hW22RSLLDV8z4CvpAvnkfgAURMkJVr9MJztc
	vtBFWY3xdAA/j8nZoV45hyCsrxwgDh5neDUvPu/U8AmroPv2Q0XTHJXQhOl/QLASHtU8ZWRjFtLMy
	TnxcDXgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iEf-00000007aVv-2VcX;
	Thu, 25 Sep 2025 09:25:57 +0000
Received: from out-186.mta1.migadu.com ([2001:41d0:203:375::ba])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iEc-00000007aSC-3ONB
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 09:25:56 +0000
Message-ID: <1a04d38f-b231-483b-8a10-0d66a82b6e3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758792351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zudI2xzc/K+ymH1yslZ7PgitSRlwY3erZSroIuIlDFs=;
	b=dY8HP7ysVcNeCVXxQyJ6gY28sGTuyXg2jPxpGM/d4kdYMKuy3Z4zP6EaaPEw5dLkQ/k+Md
	MZARyGSeBNE+g23pr6tkNsLexouPIK6QGFAeVbFnho/RjjzDDE4ryUW0reweKLuy/IIljW
	hsgXj+FeUyTdsDEnXqkAxcHQ0o9a/Rg=
Date: Thu, 25 Sep 2025 17:25:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Remove the "mem=" parameter when using the
 --reuse-cmdline option in kdump operation
To: Dave Young <dyoung@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>,
 kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>,
 Youling Tang <tangyouling@kylinos.cn>
References: <20250925063241.337897-1-youling.tang@linux.dev>
 <CALu+AoTauqunUunsnpSX6_pn08PAcr=tpkzWiNJ1cOTR9-8vVA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <CALu+AoTauqunUunsnpSX6_pn08PAcr=tpkzWiNJ1cOTR9-8vVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_022555_270895_4BD2A82E 
X-CRM114-Status: GOOD (  17.27  )
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

Hi, Dave

On 9/25/25 17:11, Dave Young wrote:
> Hi Youling,
>
> On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> During kdump operations, the capture kernel cannot reuse the "mem="
>> parameter from the production kernel. The "mem=" parameter is used
>> to specify the available memory range for the kernel. Reusing the
>> "mem=" memory range may destroy the production environment.
>>
>> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
>> ---
>>   kexec/kexec.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kexec/kexec.c b/kexec/kexec.c
>> index c9e4bcb..fadf986 100644
>> --- a/kexec/kexec.c
>> +++ b/kexec/kexec.c
>> @@ -1256,8 +1256,10 @@ char *get_command_line(void)
>>                  *p = '\0';
>>
>>          remove_parameter(line, "BOOT_IMAGE");
>> -       if (kexec_flags & KEXEC_ON_CRASH)
>> +       if (kexec_flags & KEXEC_ON_CRASH) {
>>                  remove_parameter(line, "crashkernel");
>> +               remove_parameter(line, "mem=");
>> +       }
> People can remove it from the kdump load scripts instead if it is not
> useful. I do not suggest removing other cmdline in c code.  The
> crashkernel is a special one which is fine.
Removing it in scripts is also acceptable. However, reusing the 
production kernel's
"mem=" parameter will inevitably damage the production environment. In 
my view,
modifying it in C code can achieve a permanent solution (avoiding the 
need to
modify kdump services for each distribution, and also applicable to 
non-kdump
services scenarios where commands are executed directly).

Thanks,
Youling.
>>          return line;
>>   }
>> --
>> 2.48.1
>>
>>
> Thanks
> Dave
>


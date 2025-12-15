Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB711D41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 07:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFAONnQ5m69r6NkpaANqpuLgGiHSbRBwF3vJTNGcH2Y=; b=enE4a4M9h3ljjp2tMut1iiVqJx
	GaM701uTS/nYzeBrHcGiTaexFrv4PeHDJSJIpB3tgbTas4hdepTZs40vkmTo/NmGf068rAadBNtYx
	zKeVTVr3qHLFO7gfa920MiMRKEGJJzvYVAYztTTN+XnXFV+Q4Ubkoi8+R7U686aWEhdqCYSFP8ZKX
	qJm+l9zYmebiT9TyWo2izeOg/+SfJSmJ1d4Joid/QVFhY/EC3LJAZfsWyhmy6+yrC8Gt/juHJXnsB
	tC/99KW26suIkHtCgjMCfsfgMBQUQlEBUBBHdC9iHl3DKFTVwK+PWEpdG1ntQ9t7v5i9jx40lXbSx
	cMX2MLkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV2rx-00000003Bt9-1WyH;
	Mon, 15 Dec 2025 07:19:45 +0000
Received: from smtp-78.smtpout.orange.fr ([80.12.242.78] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV2rs-00000003BsZ-3pVr
	for kexec@lists.infradead.org;
	Mon, 15 Dec 2025 07:19:44 +0000
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id V2rnvp18I8HTFV2rov1Yqo; Mon, 15 Dec 2025 08:19:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1765783177;
	bh=dFAONnQ5m69r6NkpaANqpuLgGiHSbRBwF3vJTNGcH2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NLdMi3Id7CvtEhX2k9KpnPyqRTuhQs5MwDg5+h4TejkOt9EKonmcRoeENZwhQd5mk
	 gB0ft64LlIhRK8+hcl+0o0oMzmd3CWrmq78V8xd7NSwXqBytxRyJPVlPoOOXf6YWBo
	 TCSBwWUzMKUAh2EU/ZdJ1j45umzm7iLJV1QokufDKGECRuvsxsxpz6WI/oUaKOO0Yr
	 MrCG8Ps3Xqkkfeon0PDgF1sGPZPAU4JF+kUofRCmNAZUBRK6THe0jxxtxApyd/pa5y
	 U2uWJdXowiBu2xpxtPnAdXT9s2UfRf60DzGTlrgrfkGyB+EgRsk0i5xh+5SSFpzTKd
	 mIaqQzmnJmUNg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Dec 2025 08:19:37 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <b1c7b612-5c5e-4234-9aa5-a83105d01c52@wanadoo.fr>
Date: Mon, 15 Dec 2025 08:19:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_dump: Constify struct configfs_item_operations and
 configfs_group_operations
To: Baoquan He <bhe@redhat.com>, coxu@redhat.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal
 <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 kexec@lists.infradead.org
References: <d046ee5666d2f6b1a48ca1a222dfbd2f7c44462f.1765735035.git.christophe.jaillet@wanadoo.fr>
 <aT9uwXK8XFdXei/L@MiWiFi-R3L-srv>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aT9uwXK8XFdXei/L@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_231941_885275_6F2544D3 
X-CRM114-Status: GOOD (  15.96  )
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

Le 15/12/2025 à 03:13, Baoquan He a écrit :
> On 12/14/25 at 06:57pm, Christophe JAILLET wrote:
>> 'struct configfs_item_operations' and 'configfs_group_operations' are not
>> modified in this driver.
>>
>> Constifying these structures moves some data to a read-only section, so
>> increases overall security, especially when the structure holds some
>> function pointers.
>>
>> On a x86_64, with allmodconfig, as an example:
>> Before:
>> ======
>>     text	   data	    bss	    dec	    hex	filename
>>    16339	  11001	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
>>
>> After:
>> =====
>>     text	   data	    bss	    dec	    hex	filename
>>    16499	  10841	    384	  27724	   6c4c	kernel/crash_dump_dm_crypt.o
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Sounds not bad, leave this to Coiby to test.
> 
>> ---
>> Compile tested only.
>>
>> This change is possible since commits f2f36500a63b and f7f78098690d.
> 
> I don't follow here, why do these two commits have anything with this
> patch?

Without these patches, it won't compile because "struct 
config_item_type" needs to be tweaked to accept some const field. It is 
what is done by these patches that have landed 2 weeks ago or so.


Without these 2 commits, you would get (with French messages, sorry):

   CC      kernel/crash_dump_dm_crypt.o
kernel/crash_dump_dm_crypt.c:231:24: erreur: l'initialisation abandonne 
le qualificatif « const » du type pointé [-Werror=discarded-qualifiers]
   231 |         .ct_item_ops = &config_key_item_ops,
       |                        ^
kernel/crash_dump_dm_crypt.c:306:25: erreur: l'initialisation abandonne 
le qualificatif « const » du type pointé [-Werror=discarded-qualifiers]
   306 |         .ct_group_ops = &config_keys_group_ops,
       |                         ^

CJ

> 
>> ---
>>   kernel/crash_dump_dm_crypt.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/crash_dump_dm_crypt.c b/kernel/crash_dump_dm_crypt.c
>> index 401423ba477d..0d23dc1de67c 100644
>> --- a/kernel/crash_dump_dm_crypt.c
>> +++ b/kernel/crash_dump_dm_crypt.c
>> @@ -223,7 +223,7 @@ static void config_key_release(struct config_item *item)
>>   	key_count--;
>>   }
>>   
>> -static struct configfs_item_operations config_key_item_ops = {
>> +static const struct configfs_item_operations config_key_item_ops = {
>>   	.release = config_key_release,
>>   };
>>   
>> @@ -298,7 +298,7 @@ static struct configfs_attribute *config_keys_attrs[] = {
>>    * Note that, since no extra work is required on ->drop_item(),
>>    * no ->drop_item() is provided.
>>    */
>> -static struct configfs_group_operations config_keys_group_ops = {
>> +static const struct configfs_group_operations config_keys_group_ops = {
>>   	.make_item = config_keys_make_item,
>>   };
>>   
>> -- 
>> 2.52.0
>>
>>
> 
> 
> 



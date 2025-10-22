Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FB3CCD1BB
	for <kexec@archiver.kernel.org>; Wed, 22 Oct 2025 15:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aaDlp+RI/87Oq/P/iLc6Ydi0LWEpE3MZQqoOk2S4jJw=; b=tO59CHvHLVRPRu
	gzTMVqmEy+qay6YBj5bYBJ7hlNwsSEeoZZ821mh8DWneYa79Es4rRZ6UMq01ALoQajjZ9KilgLvdN
	BsJh86xFSp+JYNAEQDRqUKKNPqzkBGfqUXt0Z3iUYUsPdFitX7YIeVDciJR3F+e4qZTVZaeEqeCGe
	rRe3dkLwPUYB5lzv35B7b5+pql4WGpFUdZh/9FtT5fHyRzcT0+kCqIoPg/85UmWFcQY5J9XWsn5l1
	s2UqM1VHLry5fHZwPJEhCUKucnb8UcuCTpXk7DZB2j08E8COAB3GeybxYYg0rmZZ4xzOUlPVjHV1Y
	0QB5KRg4a6HFTVaH7Psg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBapC-00000003Pi5-3pms;
	Wed, 22 Oct 2025 15:32:30 +0000
Received: from mailout.easymail.ca ([64.68.200.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBap8-00000003Pfv-3N2a
	for kexec@lists.infradead.org;
	Wed, 22 Oct 2025 15:32:29 +0000
Received: from localhost (localhost [127.0.0.1])
	by mailout.easymail.ca (Postfix) with ESMTP id 99FAE63A41;
	Wed, 22 Oct 2025 15:32:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo07-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
	by localhost (emo07-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RCmx42ZlcONu; Wed, 22 Oct 2025 15:32:24 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.175.187.108])
	by mailout.easymail.ca (Postfix) with ESMTPA id F386363740;
	Wed, 22 Oct 2025 15:32:23 +0000 (UTC)
Received: from [192.168.1.4] (rhapsody.internal [192.168.1.4])
	by mail.gonehiking.org (Postfix) with ESMTP id A3C7A7EB48;
	Wed, 22 Oct 2025 09:32:23 -0600 (MDT)
Message-ID: <f2235ac2-41fa-4cad-bf1d-24692397af86@gonehiking.org>
Date: Wed, 22 Oct 2025 09:32:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Spam] [PATCH 1/2] kexec-tools: powerpc: Fix function signature
 of comparefunc()
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: kexec@lists.infradead.org
References: <20251022114413.4440-1-glaubitz@physik.fu-berlin.de>
 <14f8d5e9-716b-413f-a6a9-da6b4f024a09@gonehiking.org>
 <145b0eb54dd6548e19e22f230ebfca8cedee7e17.camel@physik.fu-berlin.de>
From: Khalid Aziz <khalid@gonehiking.org>
Content-Language: en-US
Autocrypt: addr=khalid@gonehiking.org; keydata=
 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
In-Reply-To: <145b0eb54dd6548e19e22f230ebfca8cedee7e17.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_083227_189656_7DE36DE0 
X-CRM114-Status: GOOD (  21.69  )
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
Reply-To: khalid@gonehiking.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 10/22/25 9:20 AM, John Paul Adrian Glaubitz wrote:
> Hi Khalid,
> 
> On Wed, 2025-10-22 at 09:15 -0600, Khalid Aziz wrote:
>> On 10/22/25 5:44 AM, John Paul Adrian Glaubitz wrote:
>>> Fixes the following build error on 32-bit PowerPC:
>>>
>>> kexec/arch/ppc/fs2dt.c: In function 'putnode':
>>> kexec/arch/ppc/fs2dt.c:338:51: error: passing argument 4 of 'scandir' from incompatible pointer type [-Wincompatible-pointer-types]
>>>     338 |         numlist = scandir(pathname, &namelist, 0, comparefunc);
>>>         |                                                   ^~~~~~~~~~~
>>>         |                                                   |
>>>         |                                                   int (*)(const void *, const void *)
>>>
>>> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>>
>> I sent out a suggested patch yesterday making these same changes. They make sense to me.
> 
> Yes, I actually saw your patch after submitting my patches. ;-)
> 
>>> ---
>>>    kexec/arch/ppc/fs2dt.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kexec/arch/ppc/fs2dt.c b/kexec/arch/ppc/fs2dt.c
>>> index fed499b..d03b995 100644
>>> --- a/kexec/arch/ppc/fs2dt.c
>>> +++ b/kexec/arch/ppc/fs2dt.c
>>> @@ -292,7 +292,8 @@ static void putprops(char *fn, struct dirent **nlist, int numlist)
>>>     * Compare function used to sort the device-tree directories
>>>     * This function will be passed to scandir.
>>>     */
>>> -static int comparefunc(const void *dentry1, const void *dentry2)
>>> +static int comparefunc(const struct dirent **dentry1,
>>> +		       const struct dirent **dentry2)
>>>    {
>>>    	char *str1 = (*(struct dirent **)dentry1)->d_name;
>>>    	char *str2 = (*(struct dirent **)dentry2)->d_name;
>>
>> You can drop typecasting in above two lines as well:
>>
>> -    char *str1 = (*(struct dirent **)dentry1)->d_name;
>> -    char *str2 = (*(struct dirent **)dentry2)->d_name;
>> +    char *str1 = (*dentry1)->d_name;
>> +    char *str2 = (*dentry2)->d_name;
> 
> That's right. However, that should be done in a separate patch which would
> also do the same for comparefunc() in kexec/fs2dt.c so that changes that
> logically belong together are submitted as one patch.

Okay, I can see that. It also makes sense to drop typecast in kexec/arch/ppc/kexec-ppc.c
in the same patch that changes comparefunc declaration. I don't feel strongly about
either approach and can go either way. You can add my reviewed by tag:

Reviewed-by: Khalid Aziz <khalid@gonehiking.org>

> 
> My changes above are the minimal changes required to fix the build on 32-bit
> PowerPC which I tested on the Debian powerpc/ppc64 porterbox.
> 
> Once the two patches are merged, I'm happy to submit one to drop the two
> type-casting changes in both instances of comparefunc().
> 
> There are also some warnings that I will look into and address them.

Yes, there are lots of build warnings :) I chose to ignore those for now and get
this building first. I am glad you are looking at those.

> 
> Adrian
> 
--Khalid


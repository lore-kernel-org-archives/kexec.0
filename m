Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5EDCFD2F6
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 07:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B31Dd6fp3ZhCdYkGjWA31vrvuiVnWUxGMoqhJbVcJQY=; b=n/TgRzscylMPKbM24jWnvjoVyQ
	AH2syOWNCT6RirvYsY7cwD9QzcH8ZbXrnrbC8im3u94QLNJtjA8sHNr1bPgN3eud2lvzRFj9luQnh
	4KM4tj3yPNkEGDI0YdJ/H7lU6i5mvN/2i+3TNEMUwgTpTUKIZeXro+Qkm228wDdPiqOLZzhdFNfS7
	nhY52eMYZtMR1iI6LvzMQKItFv1mUkOboCaRogAZg5b4551sBs/RU8yECUvEe7hiV14BaiuWe6dBM
	SX2fLyO3JYUP2gjHRJSZ3YTQRYDQm8ENDvq4/H7zgBWo24ejot0uZY3RnIFJ0azyorxk01AyvZwh4
	Uo+slMkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOVyw-0000000G4dK-089x;
	Thu, 27 Nov 2025 06:59:58 +0000
Received: from smtpbgeu2.qq.com ([18.194.254.142])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOVyn-0000000G4aQ-2x3q
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 06:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764226759;
	bh=B31Dd6fp3ZhCdYkGjWA31vrvuiVnWUxGMoqhJbVcJQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ltiskctsMLJb6KQrbXPpnql3uVFZeiDmF8HqthhTy0qKYEJyfywLSPsuKv4jwoscv
	 6tBkohATHedEYeKK6vRR0l3lPId+YCxGlLj+aMqBrEnx3qhHumrrQZNIVvSc8nNx+5
	 AKWnPPxG0anXsETTYgRjjMpw5V5nsGt/i/obCfOQ=
X-QQ-mid: zesmtpgz7t1764226756t49b47f41
X-QQ-Originating-IP: C1UECmbtptOMOb9RX7s3eYe3smzA8xtR9cugsFgLClk=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Nov 2025 14:59:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5758405747890425677
Message-ID: <4D709A5E16BE5DEC+04521049-61de-411f-85c1-cfc049ff04c5@uniontech.com>
Date: Thu, 27 Nov 2025 14:59:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251126084427.3222212-1-maqianga@uniontech.com>
 <aSetpjhZi3T1Mjhb@MiWiFi-R3L-srv>
 <63BA9935197ADF34+2a3faf95-36da-46f1-b9b5-4e438e75d1be@uniontech.com>
 <aSe5HXpBtzLnHvNG@MiWiFi-R3L-srv>
 <D40CB4FFD668159A+09161aea-9a97-4e58-8fb4-0a13387da858@uniontech.com>
 <aSfLvmG6dap/Fcuf@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aSfLvmG6dap/Fcuf@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MmIUUz9KGMMd1zzUdEDBeaCA/UQgfN3csQXpVRq80dp7VdV1QCFchbiU
	lE88EdDZ6rALKyscvsTVDiwcc51YyNwLFEctDcGsYvgmXh4WTfft9xzHL5JaSqKEuYBFSxv
	34DN8lF7LcOXGhKMTsx0JmcZUvQ1W/OomhmPQuw2fWbsIPRhoZJb8WM8uYQ2W4yuY3BF/T2
	NtM3tCA+H7Zfn6c3/I3BhANMGqI3EOCEP4u+fxAOuW4ofUt4cJGHPgNkSt6F64iOig8MeGh
	okaD9+1lIXCLrZsclmnrzeT8iEBRMRoz4EQHkMEekfRTzNkqF0VmlWvQ+Op0VMEwOPj1EHt
	o6B6cR/EyaUiLeVzssWGS1AHzqS03NLwqDm0wnqOga3jMSmC1xF0C9udfQVpsA0nxbio5Xd
	oBpzhihiHE7XfCmVIPO3/SOMjzyv0sonCLHliwqZObs5PguPWNtIp6lgBNXzrQb4V1YdBrk
	gVdeEXagyHxewnELM7ahMLGCY8qJIfZJJPolnW4ihIljVJhzl/2Tz6emvR15pn+zyQJXNad
	Dyb8pRGrprwik7K1zRQEwjwDUpGEjQLN6x/A5GVBviF4fEX8mZVzwB90AIK5kz3cY1uV8Gz
	mKJxcwFB3gb/I8zf0mxNYOMH/E7wZCKdjbD0PL6wZa6AOoD7jcBMEt2sZqtqEQdmpxVtpzy
	2Q8zuZWXPcVtfbG18+ls7BAsqvDBr6zOApnjdajZJ/zzU/3KXhrV7WD7eFPSf49OWuxwT7x
	giQN98qHaKQ3jXn+WRfSPE8OMYMv2E/TRYoK+47xNpnAC29WUhSyxSTukMrI2w6N8hdLJgr
	u53SyeN57qqKDEbO54lgkV4YY7jZ4ANsiwxSiQVRvshzl2BzAI6XkGpDESZF7xYYGl8FbuT
	h1hWU+Y2iJx0dL9XbhKCFgJaHmuaIgYyY082SG0wV7azsTgWO2iFwY+c9hE/aCdd9Z4hpxY
	M3b6lQYa60a3/3PC3RaxokuvV/DcY/GFFX8MD9pFZmr7LLjS8W2S4Ey9TMQtXrEvh/6zds9
	Ha8wOU8LcncHDq+aZf
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_225950_259852_15AE33E3 
X-CRM114-Status: GOOD (  19.24  )
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


在 2025/11/27 11:55, Baoquan He 写道:
> On 11/27/25 at 11:00am, Qiang Ma wrote:
>> 在 2025/11/27 10:36, Baoquan He 写道:
>>> On 11/27/25 at 10:04am, Qiang Ma wrote:
>>>> 在 2025/11/27 09:47, Baoquan He 写道:
>>>>> Hi,
>>>>>
>>>>> On 11/26/25 at 04:44pm, Qiang Ma wrote:
>>>>>> Overview:
>>>>>> =========
>>>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>>>> if required") has added general code printing in kexec_file_load(),
>>>>>> but not in kexec_load().
>>>>>> Since kexec_load and kexec_file_load are not triggered simultaneously,
>>>>>> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
>>>>> As I said in your last post, this is not needed at all, you just add a
>>>>> not needed thing to kernel.
>>>>>
>>>>> So NACK this patchset, unless you have reason to justify it. Sorry about
>>>>> it.
>>>> The segment prints discussed in the last post,
>>>>
>>>> this patchset has been removed, leaving only type/start/head of kimage and
>>>> flags.
>>>>
>>>>
>>>> I think the current patchset is still necessary.
>>>> For example, renaming kexec_file_dbg_print is still necessary, but not for
>>>> kexec_file.
>>> How come renaming kexec_file_dbg_print is a justification in this case.
>>>
>>> No, kexec_file_dbg_print is named because it's only for kexec_file
>>> debugging printing. Because we have had enough debugging printing for
>>> kexec_load interface. Do you have difficulty on debugging printing of
>>> kexec_load?
>> It's sufficient now, but there might be a need in the future.
>> Also, there's kexec_dprintk. Judging from its name, it seems like a
> Hmm, as I ever said in earlier discussion, kexec sometime means generic
> handling including kexec_load and kexec_file_load interfaces. Both possible
> future need and kexec_dprintk which seems a little ambiguous to you are
> not justified. We do not suggest adding these meaningless code to
> kernel. Please do't continue spending effort on this, that is not good.
>
> I welcome cleanup/refactoring/fix for kexec/kdump to improve code, but
> adding non-reasonable code is not included.
I agree that meaningless code should not be added to the kernel,
but it is meaningful for this patchset and has reasonable reasons.

Let me summarize again the purpose of submitting this patchset:

First, unify the print flag of kexec_file and kexec as kexec_dbg_print,
so that both kexec and kexec_file can be used both now and in the future.

Secondly, in the current code, for instance, I saw in the arm64 code
that under the kexec_load interface, the kexec_image_info() already uses 
kexec_dprintk.
When unset CONFIG_KEXEC_FILE, specifying '-d' for kexec_load interface, 
print nothing in the kernel space.
static void _kexec_image_info(const char *func, int line,
         const struct kimage *kimage)
{
         kexec_dprintk("%s:%d:\n", func, line);
         kexec_dprintk("  kexec kimage info:\n");
         kexec_dprintk("    type:        %d\n", kimage->type);

         kexec_dprintk("    head:        %lx\n", kimage->head);


Thirdly, for instance, in the arm64 code, the kexec_image_info() prints 
type/head of kimage,
while in the RISC-V code, the type/head of kimage under kexec_load and 
kexec_file_load is removed.
We can remove the print(type/head of kimage) in arm64, and then add it 
to the general code.

For points 1 and 2, Patch 2 can implement: "kexec: add kexec flag to 
control debug printing"
For point 3, Patch 3 can be implemented: "kexec: print out debugging 
message if required for kexec_load"

Additionally, if it is necessary to remove the type/head of kimage 
printed in the kexec_image_info()
in the arm64 code, another patch can be provided.
>> universal kexec print.
>> Looking at the code, it feels like not only the kexec_file interface path
>> uses it for printing.
>>
>> So, would it be better to rename kexec_file_dbg_print to kexec_dbg_print.
>>
>>
>>>
>



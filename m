Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBEFC4706C
	for <kexec@archiver.kernel.org>; Fri, 12 Jan 2024 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Be2J0sMXzcxSzzsRqB8gQk73h41SkQayc1GFHEm2fws=; b=Cf0ZkgPjGvfwu6
	odzIuavfo7r/EG8XKeg5ROy9pwspwubyOpsmVEvaEBb22b+C57sjP55TyP8/P+aTARZbJ4eO6A5wF
	kXfR/HX0sKm2pmfT2ZyvlCJykivAY+lcWpF3egOeuQn8BYi7zU/tO93dXR20wOcHdETVSZiS02LI4
	nAkVTEGyNY2d3V13DWJwmfZtpJRnMz/G3+iIITugGhBdaAdQfCj/K2OTZkNcjz3zuDORZX1xNN3Uo
	P1OkAAw8wg61woIJmlpQF6mOk+FMHPkyJIitdaW02fZzuybvHc++Y5EnNoFCiNk3QE2lt1XYDvOxN
	YeJ5RwRFMzh9PEvrYY/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOMC9-003b3n-1o;
	Fri, 12 Jan 2024 18:23:53 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOMC6-003b3L-0q
	for kexec@lists.infradead.org;
	Fri, 12 Jan 2024 18:23:51 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C41020B3CDE;
	Fri, 12 Jan 2024 10:23:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C41020B3CDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705083828;
	bh=gpxTcvKnkoBsHVJNPTQQphS77esyYUMo75E4RxbL2x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z94CzjSnbTd/Zr7L4YugLYetotrKcRgm4vMmsgdyzJS+6gyjvHChRAdvNWv12x68H
	 E10T9asTjMJtM8CiQv12PDU4V150aFF9ygovIuXsc8Tuj0exOkQd/7U2jWw1jt9cOQ
	 H+1l9j6GtA9taAh8vy4bpYbcTwm2p6RdbxyEIXK8=
Message-ID: <a09613f2-0d9f-41a3-b78d-b1b1fd35614c@linux.microsoft.com>
Date: Fri, 12 Jan 2024 10:23:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, Stefan Berger <stefanb@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
 <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
 <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
 <6acf82dcefd349941b05ff2a3b7e4bf651dc4429.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <6acf82dcefd349941b05ff2a3b7e4bf651dc4429.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_102350_325262_3BFE6C7B 
X-CRM114-Status: GOOD (  11.28  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 1/12/24 09:44, Mimi Zohar wrote:
> On Thu, 2024-01-11 at 12:52 -0800, Tushar Sugandhi wrote:
> [...]
>> If we go with the KBs approach -
>>
>> half-a-page translates to different KBs on different architectures.
>> And setting the right default value in KBs which would translate to
>> the desired half-a-page, on a given arch, inside the Kconfig seems
>> fragile (as I mentioned in the context of Option A in my previous
>> response.
> 
> How about setting the default value to 0, indicating not to change the current
> half page default.  Any other value would be KBs, as Stefan suggested.
> 
Thanks.
That's way more elegant than the other alternatives.
It's definitely doable in KConfig and handle the default in code 
appropriately.

It may cause some confusion in the documentation of the config param.
But it would be a wording issue, and we can work on it.

Thanks for the suggestion.  I like it honestly.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB3DEB64DC
	for <kexec@archiver.kernel.org>; Tue, 11 Jul 2023 19:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U7SX7Zf2l5SrEbjTfjoyEUmoMwz+mwbE4GVGOJSyx3I=; b=yJRYQCDt00Ut2W
	Qs90W2klGzTMgV8VLnrsl/gLNmg0NIm8Rt1dx428kg+Q/QE+un7gedQbdyAu8OLLV57yvIyT1f03F
	vM82MM8XGE5HfydJ4GZBL1I5zJVGlE62q0d3lWZiHnWAC6LAC6GeJgVLUt/NzeWXD8OYw91USZsjz
	avqa8evPiRXcF+BH/781CB2aHqn5ldRprD2bPLBd4l0gOBgIobLwRX19hHS/T8hSzyv4t6ZIInpfw
	IfqWoAMvxZZ5SQoPs8hubPl4z0Yi373umrzT6snyKxurGYAYaJaXrbThNq6Ph9bKY0DimRKBkRrA6
	/2SJLnMfc1U2WLG9Blgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIm4-00Fiq9-1C;
	Tue, 11 Jul 2023 19:11:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJIm1-00Fipe-1b
	for kexec@lists.infradead.org;
	Tue, 11 Jul 2023 19:11:46 +0000
Received: from [192.168.87.36] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC79821C3A89;
	Tue, 11 Jul 2023 12:11:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC79821C3A89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1689102704;
	bh=GKxqe8os36wp7SYz7yVh3qvFrnisvzs2Xal1CiLRFEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bjc9zA9OXJ702Uod3JO53hYvRvEMpOq0vUS3W/UpYRr65esp35gNOyAp6KUgimsEg
	 mMQLmOCzeuQAbyJKaf6MQtUXaPK6yEV6+0PkQmHQmSFJ6Q746/aY1tkmMJ7EAfUODI
	 yNIbcXlHcxzVomn47p170Kg8kX3e+LbtEPAPVBfM=
Message-ID: <ed466669-994c-4e19-1582-4ebf48492e68@linux.microsoft.com>
Date: Tue, 11 Jul 2023 12:11:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/10] ima: remove function ima_dump_measurement_list
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, noodles@fb.com, bauermann@kolabnow.com,
 kexec@lists.infradead.org, linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com,
 Eric Biederman <ebiederm@xmission.com>
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com>
 <20230703215709.1195644-8-tusharsu@linux.microsoft.com>
 <3a67093401f6d14224e9cef748a9e2c191d21fa1.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <3a67093401f6d14224e9cef748a9e2c191d21fa1.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_121145_580473_ADC5281B 
X-CRM114-Status: GOOD (  14.36  )
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

Adding Eric to cc.


On 7/7/23 06:55, Mimi Zohar wrote:
> Hi Tushar,
>
> On Mon, 2023-07-03 at 14:57 -0700, Tushar Sugandhi wrote:
>> The ima_dump_measurement_list function was designed to iterate over the
>> IMA measurement list and store each entry into a buffer.  The buffer,
>> along with its size, would be returned to the caller.  However, the
>> function is no longer required in the IMA subsystem.  It previously served
>> to dump the measurement list during the kexec 'load' operation, but this
>> functionality has been replaced by an alternative approach in this patch
>> series.
>>
>> Remove the unused ima_dump_measurement_list function from the IMA
>> subsystem, to ensure a cleaner and more maintainable code.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Have you compiled the code and tested after applying each patch?
> Removing the caller before removing the code should have resulted in a
> warning.
>
Yes, I compiled each patch separately, and I did see this warning.
But removing ima_dump_measurement_list after implementing and
calling the alternate ima_allocate_buf_at_kexec_load() and
ima_populate_buf_at_kexec_execute() felt cleaner in terms of organizing
the patches.

I can remove the definition when I deprecate the usage, if we end up
using the alternate two functions.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

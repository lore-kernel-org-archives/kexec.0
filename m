Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CB6D116F0
	for <kexec@archiver.kernel.org>; Thu, 27 Nov 2025 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plG7wvACNnIy8VafbayGfc1xXuTxESOFkAWKjk+oJG4=; b=mt0PeMiUI/UU1PXmuEmY9kL+Ug
	mEdhIxyzjQjOYwWOp8HvHL8PtM8KoLAQN5rlhZtnWL5oIzZFfg1mPaCCVwXF2IA4cnRrW3ZnVpxtv
	T0UF3EOSH1I1p89T8FpNftkubu0OxDPcJ/IVomHVecImy+QDvHvLgiA8q4tssXnxmRbdw/PkUyQfp
	JJHnZ2MkhPhxZO4yaSIkcf/FsS/GSe0YBACCb2FM7JxB+0FP/imsoITWYIejKz9as3MSz45OfXAfd
	Y8pX4ugVnU+OZodJ2A874TImhIMCBSzgldMLsFjSre8txzKWiHXqgfA3UDmsZaFJfEm1B9RQNThx9
	V4iZnMdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOSFR-0000000Fuj1-24Mz;
	Thu, 27 Nov 2025 03:00:45 +0000
Received: from smtpbguseast2.qq.com ([54.204.34.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOSFN-0000000Fuf0-3l6S
	for kexec@lists.infradead.org;
	Thu, 27 Nov 2025 03:00:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764212411;
	bh=plG7wvACNnIy8VafbayGfc1xXuTxESOFkAWKjk+oJG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SOJrjg3Yk0soptqOFEaGhOuGEJENFjYEepjXhZgjcJa4SuTZhypyIC/npp0+hkI38
	 9sJLn0eg4sIcDefU74EOWDVtzYCy2aiA0JCA3/+5/7E//rlkVWcgHnfkg1xvXnvd2q
	 P7oPZH5XHX9cTNtUQr1yliK/GmJjuOEyfMMUUprs=
X-QQ-mid: esmtpsz20t1764212408t688b49a1
X-QQ-Originating-IP: 5yd+wnZbgB0NtvXL0Goy7cPkLgizM0dqnyLxhf5U8PM=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Nov 2025 11:00:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4367172464145463368
Message-ID: <D40CB4FFD668159A+09161aea-9a97-4e58-8fb4-0a13387da858@uniontech.com>
Date: Thu, 27 Nov 2025 11:00:06 +0800
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
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aSe5HXpBtzLnHvNG@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NcV11xv8JFuL0PDoxw3hR1O/Vh/vP7OBuxDxoYezT2DPInW/o68yh2qX
	g6bXn5+z/sNi2tqJ7DOdCuQ1NGf0NpfJFasDZPPe+kIRY54OZqWLIC37MhU6D5Zr9rAUpA9
	8ocy/6hgR7NIVwuUFiRTbKCAa6vltpY+uq2N61Fuk4Xy4WWX6YDOjIcTgI7wr618FDjQIvR
	Z8Nelnd2oveBg72z/aYH/uhLh+Y7UjCUf6Ahx0eybJN63IonFlvGUf/noqx+wdCOvxoa25/
	cHVlDi+oU+9q8t6KfaStIe1EWmoXleBqU11HJSSuO/gHdjKDd0r4W73nWQUDau71UmftUbo
	vsl+KBFNox6ZQTUk1RIQ40MevNEsDMBSaXJjkmdLIv4MR08xagKtZrIMDMD8MJaNgFenmmo
	rSMs+EWJ5S8XMlzy5hycf3wRlpQbyVaA7aLnos5xsLCk9u5cnidA5PLr/gvd6qhVcXOYLbr
	r+DM8LLBhpn8NnGFCuXt6ihcjigAWgfOjk0XVZsHqw2eUaegnTb6pWDdRQH78jezWcsZRXv
	VAxUgIIk0l2k3hE+dZiadLThCYQeskWqQ05PQA+291X//wfW01pLNhi53eu925XjI+ZlmXZ
	0aEgN8AXqwEn2wSzQ9QpSUc+6w2WFTqEKwfuaFEoThvSpx61+QWFBKy4VNwb4RWI9s/6+jc
	vw9zpUzLDPy2keXNQzDJHic91P+ucP/5nbyP+gOaey266Zag2x+cujm2hSml0/6OmcNS41O
	nA8mfAC6DUZbj9EVsceO7gcG9EWzo9iT+/IYx2OILQ5sjsN/+fUUJbDys80ApaI0E2If9uN
	u95IZGp6bgPxj3iC28zDbrddugDI3jouimU+bbFiscdEwwREbLrKDmExXkdWqiGLE8eIC5Q
	qMkmXvTHH6FbJSXu32nYlgpjKTjczx4UXNc3vncwNvFi7v2EAp24kKli+eLUOF/wZvKbJFb
	xyeMrhmiyC2alLNVMwtu0Lz54WcofJLJaeIUZSIp5+0GdbAKVtsxqrdzP+8rubUYJUmS+cK
	zwKa6SavCwrOl/6d/r/VZfBqFvR9RBgx4gDaQ/u42riMUv/4dFsRRCgvbWXSXyEV4ltED7Y
	A==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_190042_892143_E40749BB 
X-CRM114-Status: GOOD (  12.71  )
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


在 2025/11/27 10:36, Baoquan He 写道:
> On 11/27/25 at 10:04am, Qiang Ma wrote:
>> 在 2025/11/27 09:47, Baoquan He 写道:
>>> Hi,
>>>
>>> On 11/26/25 at 04:44pm, Qiang Ma wrote:
>>>> Overview:
>>>> =========
>>>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>>>> if required") has added general code printing in kexec_file_load(),
>>>> but not in kexec_load().
>>>> Since kexec_load and kexec_file_load are not triggered simultaneously,
>>>> we can unify the debug flag of kexec and kexec_file as kexec_dbg_print.
>>> As I said in your last post, this is not needed at all, you just add a
>>> not needed thing to kernel.
>>>
>>> So NACK this patchset, unless you have reason to justify it. Sorry about
>>> it.
>> The segment prints discussed in the last post,
>>
>> this patchset has been removed, leaving only type/start/head of kimage and
>> flags.
>>
>>
>> I think the current patchset is still necessary.
>> For example, renaming kexec_file_dbg_print is still necessary, but not for
>> kexec_file.
> How come renaming kexec_file_dbg_print is a justification in this case.
>
> No, kexec_file_dbg_print is named because it's only for kexec_file
> debugging printing. Because we have had enough debugging printing for
> kexec_load interface. Do you have difficulty on debugging printing of
> kexec_load?
It's sufficient now, but there might be a need in the future.
Also, there's kexec_dprintk. Judging from its name, it seems like a 
universal kexec print.
Looking at the code, it feels like not only the kexec_file interface 
path uses it for printing.

So, would it be better to rename kexec_file_dbg_print to kexec_dbg_print.


>
>



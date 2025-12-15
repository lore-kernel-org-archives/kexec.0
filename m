Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D86D41D74
	for <kexec@archiver.kernel.org>; Mon, 15 Dec 2025 04:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3lOSDOM4oQzUiD2Hxei8TKH49gYyrijPqR+c7lN4i6k=; b=ev33FOK6Ew9ywAn00wpS6JE0v/
	QT2AY77SZ1txHhkgTKaOsB19Vn1WEwpvy5+lBdwkRhhsEeXDlPNn09NRRD8aULFOXcPkRztxASNZp
	Zho81BEMcl5rvZBv+qPrCCO1F0aO7hNEYuDJOb2z/JGDws93ahKUa5Fd3wx236qOKDuNEMUbvWvF9
	hRIxo+Xvx5lYI58sFEOmqqhDKAZqfNRxkiwlRKd8oh3HQGQquePr3LcLw71VwCzbZmLu48qDK069u
	h7G+A/vK6c8bbS4VrEemYw98AwQjILSkhmlbYlcs74VjKeSUKcACxJ5mYdyJmWgcXtoMYs+I1FeeD
	o2yjTDOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV0QA-000000033vX-3vFG;
	Mon, 15 Dec 2025 04:42:54 +0000
Received: from smtpbguseast3.qq.com ([54.243.244.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV0Q7-000000033se-2pda;
	Mon, 15 Dec 2025 04:42:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765773706;
	bh=3lOSDOM4oQzUiD2Hxei8TKH49gYyrijPqR+c7lN4i6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=FsFB3PJN6tU6lMyRa5z7WS4PwHO6OXhu68Rm8HAV5vmLZ7xOjWX835saFRhlCtnBN
	 pRiwSFAtwC78pbPZuRWf8o9l9YARlmGwivVAL8lPlambWgFXBa/RXpRIClTbHqamD/
	 TChT0N6A2zxwo16MSUsD185+nHgZakRgyDrGLUGg=
X-QQ-mid: esmtpgz15t1765773698t10035d30
X-QQ-Originating-IP: 0WfD5yvhvW13kvUdeyJmv1hnISC08Dc8ngn/qRYwPgU=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Dec 2025 12:41:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10387698090418089952
Message-ID: <B86C6BDD7F4F1AC4+1b245d22-60ed-48d4-829e-aadfa145098f@uniontech.com>
Date: Mon, 15 Dec 2025 12:41:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] kexec: print out debugging message if required for
 kexec_load
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, catalin.marinas@arm.com, will@kernel.org,
 kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251212095649.857796-1-maqianga@uniontech.com>
 <20251212095649.857796-3-maqianga@uniontech.com>
 <20251214163214.5018b9c083f11c7ecc081a5d@linux-foundation.org>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <20251214163214.5018b9c083f11c7ecc081a5d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OGRTx1KypL8C/viUD4JUiKSm32Nj7azkR04soI1I0Sxd2qA6HJGzz6lJ
	HhwHGrNH1tI8XQXMkksBHUWHl7sOK2XMK0zGjEzKl0M1TSV4kOBeMbWxAwhwbGh0lhj5q8L
	E5yfFySbRs80kEgd9eeH2s6y0abPBCAILFY2UYNOjRIXyD3Xw7I6mnTxB5t8G/H3SJZXWtw
	/CElFnKKd3GMbnlC/6RHLfjlvE03NxUgblnf7pkxu8EZxmmznGdHG9+wT9XorpR30Tg/wG7
	nMUi33Pz4oEaps6K94FpRdG4wY/8mFFamEc14ifBNkOJm31x+SHkupNd1v7GghpnpaDtusQ
	c52BPBmh5rMOlGh5nZaruiF7fjuPiXdjZiQt52xT5YryOcQG34U9SxmudOE7ykw9+9ruFhX
	dybGhVdzPrO5IvTM6yQyu+D8m1ftA/+pC7wynId7feBk8bXrLfUnEtF21jblGJr/7FO5Uyr
	M4oJCZY1jnKJ3Rj9Rlz9cEH97KxbvdJeZPjjzwnR29dQlKxE5H8HCpUKGL1WpnzknZc1x19
	pH5QiyvWPTs6O4djJSIZWcux5fHMhFltFdGXYwwWu4nRkzy6w7ICBTHIG8oXIE/EsbaD8um
	8Ly2wRUnzDHLVUc+KoK7enCKCenNBZCsO+0Kzv1N6BiQ0zs3EqP9Wt2iAZ5fupREFn31RJJ
	zAyUFSFZ79CmyyMOOzxcvb4JrwJllictfmsUt43IrdKLLz3G1wHzSlHLpO2mELC3i81xgmO
	B+h5rbm2cPX9IPkgDMspVo6AKUar+iTUO3x9NmaZNSC3zDYjPdERNilQZ01NRGxiPcr4op+
	LVjRhCLokuJ4RRKCRwEwjEQWZ/puR6cxwgZxal2zLphOXgLjk4g3a8Id04sCj+3YSbp1tB1
	JE/FnHWBzsrY3aZpAZSpNKVGgS06MkqVVfLsnKvsswq9wRmD5liKeHJceAIvAZ8DKX18CAE
	2Ci5gKTqjoK5KfF1b79NVexo3tWvyxRzYk0mdfyeiMfiJfxQg1+/AGFuJDq4C3WhH4eXAyg
	iC+Gl8Kmm7EzXqr6oQXapxwOGJcqw8dlkAIbnDCjvoEp6u5QQy
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_204252_241906_5C540354 
X-CRM114-Status: GOOD (  14.50  )
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


在 2025/12/15 08:32, Andrew Morton 写道:
> On Fri, 12 Dec 2025 17:56:48 +0800 Qiang Ma <maqianga@uniontech.com> wrote:
>
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> As a result, when using '-d' for the kexec_load interface,
>> print nothing in the kernel space.
> That doesn't sound like a thing which "kernel test robot" would detect
> and report.
>
>> Since the segments debugging message has already been printed by the
>> user-space tool kexec-tools, it will not be printed here in the
>> kernel space.
>>
>> And print out type/start/head of kimage and flags to help debug.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
> Oh I see, that's a warning against an earlier version of this patch.
> But this is labelled "v1"!
yes.
>
> I suggest we remove this Reported-by record.
ok, I'll collect some other suggestions and fix it together in the next 
version.
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -166,6 +166,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>> +		      image->type, image->start, image->head, flags);
>> +
>>   	/* Install the new kernel and uninstall the old */
>>   	image = xchg(dest_image, image);
> Thanks, I'll await reviewer input before proceeding with this series.
>


